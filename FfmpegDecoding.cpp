#include "FfmpegDecoding.h"


//解码器
//SDL视频显示
//ffmpeg视频解码器
//SDL库的作用是封装了复杂的视音频底层交互工作，简化了视音频处理的难度
//SDL初始化可能会用到ffmpeg的参数
#include <stdio.h>

#define __STDC_CONSTANT_MACROS

#ifdef _WIN32
//Windows
extern "C"
{
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
#include "libavutil/imgutils.h"
#include "SDL2/SDL.h"
};
#else
//Linux...
#ifdef __cplusplus
extern "C"
{
#endif
//avformat封装格式处理
//avcodec编解码（最重要的库）
//swscale视频像素数据格式转换
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswscale/swscale.h>
#include <SDL2/SDL.h>
#include <libavutil/imgutils.h>
#ifdef __cplusplus
};
#endif
#endif

//Output YUV420P data as a file
#define OUTPUT_YUV420P 0

//FfmpegDecoding::FfmpegDecoding(QGuiApplication &app, QQmlApplicationEngine &engine)
//{
//    m_app = &app;
//    m_engine = &engine;
//}
FfmpegDecoding::FfmpegDecoding(){

}

int FfmpegDecoding::ffmpeg1()
{
    AVFormatContext	*pFormatCtx;  //封装格式上下文结构体，也是统领全局的结构体，保存了视频文件封装格式相关信息
    int				i, videoindex;
    AVCodecContext	*pCodecCtx;  //编码器上下文结构体，保存了视频（音频）编解码相关信息
    AVCodec			*pCodec;  //每种视频（音频）编解码器（例如H.264解码器）对应的一个该结构体
    AVFrame	*pFrame,*pFrameYUV;  //存储一帧解码后像素（采样）数据
    unsigned char *out_buffer;
    AVPacket *packet;  //存储一帧压缩编码数据
    int y_size;
    int ret, got_picture;
    struct SwsContext *img_convert_ctx;

    char filepath[]="/root/untitled12/vedio1.mp4";
    //SDL---------------------------
    int screen_w=0,screen_h=0;   //可以改变窗口大小
    SDL_Window *screen;   //代表了一个“窗口”
    SDL_Renderer* sdlRenderer;  //代表了一个”渲染器“
    SDL_Texture* sdlTexture;  //代表了一个纹理
    SDL_Rect sdlRect;  //一个简单的矩形结构

    FILE *fp_yuv;

    //注册所有组件
    av_register_all();
    //初始化网络连接
    avformat_network_init();
    pFormatCtx = avformat_alloc_context();

    //avformat_open_input打开输入视频文件
    if(avformat_open_input(&pFormatCtx,filepath,NULL,NULL)!=0){
        printf("Couldn't open input stream.\n");
        return -1;
    }
    //avformat_find_stream_info获取视频文件信息
    if(avformat_find_stream_info(pFormatCtx,NULL)<0){
        printf("Couldn't find stream information.\n");
        return -1;
    }
    videoindex=-1;
    //pFormatCtx->nb_streams输入视频的AVStream个数
    //这个循环获取视频流所在的序号值
    for(i=0; i<pFormatCtx->nb_streams; i++)
        //pFormatCtx->streams输入视频的AVStream[]数组
        //AVMEDIA_TYPE_VIDEO判断为视频
        if(pFormatCtx->streams[i]->codec->codec_type==AVMEDIA_TYPE_VIDEO){
            videoindex=i;
            break;
        }
    if(videoindex==-1){
        printf("Didn't find a video stream.\n");
        return -1;
    }

    pCodecCtx=pFormatCtx->streams[videoindex]->codec;
    //avcodec_find_decoder查找解码器
    pCodec=avcodec_find_decoder(pCodecCtx->codec_id);
    if(pCodec==NULL){
        printf("Codec not found.\n");
        return -1;
    }
    //avcodec_open2打开解码器
    if(avcodec_open2(pCodecCtx, pCodec,NULL)<0){
        printf("Could not open codec.\n");
        return -1;
    }

    pFrame=av_frame_alloc();
    pFrameYUV=av_frame_alloc();
    out_buffer=(unsigned char *)av_malloc(av_image_get_buffer_size(AV_PIX_FMT_YUV420P,  pCodecCtx->width, pCodecCtx->height,1));
    av_image_fill_arrays(pFrameYUV->data, pFrameYUV->linesize,out_buffer,
                         AV_PIX_FMT_YUV420P,pCodecCtx->width, pCodecCtx->height,1);

    packet=(AVPacket *)av_malloc(sizeof(AVPacket));
    //Output Info-----------------------------
    printf("--------------- File Information ----------------\n");
    av_dump_format(pFormatCtx,0,filepath,0);
    printf("-------------------------------------------------\n");
    //pCodecCtx->pix_fmt像素格式（只针对视频）
    img_convert_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height, pCodecCtx->pix_fmt,
                                     pCodecCtx->width, pCodecCtx->height, AV_PIX_FMT_YUV420P, SWS_BICUBIC, NULL, NULL, NULL);

#if OUTPUT_YUV420P
    fp_yuv=fopen("output.yuv","wb+");
#endif

    //SDL_Init初始化SDL系统
    if(SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER)) {
        printf( "Could not initialize SDL - %s\n", SDL_GetError());
        return -1;
    }

    //pCodecCtx->width，pCodecCtx->height图像的宽高（只针对视频）
    screen_w = pCodecCtx->width;
    screen_h = pCodecCtx->height;
    //SDL 2.0 Support for multiple windows
    //创建窗口SDL_Window
    //可以更改视频窗口的宽高，二倍宽高
    screen = SDL_CreateWindow("Simplest ffmpeg player's Window", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                              screen_w, screen_h,
                              SDL_WINDOW_OPENGL);

//    screen =

    if(!screen) {
        printf("SDL: could not create window - exiting:%s\n",SDL_GetError());
        return -1;
    }

    //SDL_CreateRenderer创建渲染器
    sdlRenderer = SDL_CreateRenderer(screen, -1, 0);
    //IYUV: Y + U + V  (3 planes)
    //YV12: Y + V + U  (3 planes)
    //创建纹理
    sdlTexture = SDL_CreateTexture(sdlRenderer, SDL_PIXELFORMAT_IYUV, SDL_TEXTUREACCESS_STREAMING,pCodecCtx->width,pCodecCtx->height);

    //sdlRect.x，sdlRect.y 矩形左上角的坐标
    sdlRect.x=0;
    sdlRect.y=0;
    //宽和高
    sdlRect.w=screen_w;
    sdlRect.h=screen_h;

    //SDL End----------------------
    //av_read_frame从输入文件读取一帧压缩数据,把视频帧写成H.264数据
    while(av_read_frame(pFormatCtx, packet)>=0){
        //packet->stream_index所属的AVStream
        if(packet->stream_index==videoindex){
            //avcodec_decode_video2解码一帧压缩数据
            ret = avcodec_decode_video2(pCodecCtx, pFrame, &got_picture, packet);
            if(ret < 0){
                printf("Decode Error.\n");
                return -1;
            }
            if(got_picture){
                //视频帧本来是480*272解出来却是512*272,所以这个函数是去掉右边的黑边，是一块空白区域，
                //所以该函数是裁掉右边这一块

                //把pFrame输出放在pFrameYUV里
                sws_scale(img_convert_ctx, (const unsigned char* const*)pFrame->data, pFrame->linesize, 0, pCodecCtx->height,
                          pFrameYUV->data, pFrameYUV->linesize);

#if OUTPUT_YUV420P
                y_size=pCodecCtx->width*pCodecCtx->height;
                fwrite(pFrameYUV->data[0],1,y_size,fp_yuv);    //Y
                fwrite(pFrameYUV->data[1],1,y_size/4,fp_yuv);  //U
                fwrite(pFrameYUV->data[2],1,y_size/4,fp_yuv);  //V
#endif
                //SDL---------------------------
#if 0
                SDL_UpdateTexture( sdlTexture, NULL, pFrameYUV->data[0], pFrameYUV->linesize[0] );
#else
                //pFrameYUV->data解码后的图像像素数据（音频采样数据）
                //pFrameYUV->linesize对视频来说是图像中一行像素的大小;对音频来说是整个音频帧的大小
                //设置纹理数据
                SDL_UpdateYUVTexture(sdlTexture, &sdlRect,
                                     pFrameYUV->data[0], pFrameYUV->linesize[0],
                        pFrameYUV->data[1], pFrameYUV->linesize[1],
                        pFrameYUV->data[2], pFrameYUV->linesize[2]);
#endif

                SDL_RenderClear( sdlRenderer );
                //将纹理的数据拷贝给渲染器
                SDL_RenderCopy( sdlRenderer, sdlTexture,  NULL, &sdlRect);
                SDL_RenderPresent( sdlRenderer );
                //SDL End-----------------------
                //Delay 40ms
                //工具函数，用于延时，改变视频播放速度
                SDL_Delay(40);
            }
        }
        av_free_packet(packet);
    }
    //flush decoder
    //FIX: Flush Frames remained in Codec
    while (1) {
        ret = avcodec_decode_video2(pCodecCtx, pFrame, &got_picture, packet);
        if (ret < 0)
            break;
        if (!got_picture)
            break;
        sws_scale(img_convert_ctx, (const unsigned char* const*)pFrame->data, pFrame->linesize, 0, pCodecCtx->height,
                  pFrameYUV->data, pFrameYUV->linesize);
#if OUTPUT_YUV420P
        int y_size=pCodecCtx->width*pCodecCtx->height;
        fwrite(pFrameYUV->data[0],1,y_size,fp_yuv);    //Y
        fwrite(pFrameYUV->data[1],1,y_size/4,fp_yuv);  //U
        fwrite(pFrameYUV->data[2],1,y_size/4,fp_yuv);  //V
#endif
        //SDL---------------------------
        SDL_UpdateTexture( sdlTexture, &sdlRect, pFrameYUV->data[0], pFrameYUV->linesize[0] );
        SDL_RenderClear( sdlRenderer );
        SDL_RenderCopy( sdlRenderer, sdlTexture,  NULL, &sdlRect);
        //显示
        SDL_RenderPresent( sdlRenderer );
        //SDL End-----------------------
        //Delay 40ms
        //测试时，此处改变大小无变化
        SDL_Delay(40);
    }

    sws_freeContext(img_convert_ctx);

#if OUTPUT_YUV420P
    fclose(fp_yuv);
#endif

    //退出SDL系统
    SDL_Quit();

    av_frame_free(&pFrameYUV);
    av_frame_free(&pFrame);
    //avcodec_close关闭解码器
    avcodec_close(pCodecCtx);
    //avformat_close_input关闭输入视频文件
    avformat_close_input(&pFormatCtx);

    return 0;
}

FfmpegDecoding::~FfmpegDecoding()
{

}

