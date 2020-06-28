import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4 as Controls14
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4


Rectangle {

    property alias mediaPlayer: mediaPlayer

    Rectangle{
        id: play
        anchors.fill: parent
        color: "DimGrey"

        Rectangle{
            id: playWindow
            width: parent.width/1.3
            height: parent.height/1.1
            color: "black"

            MouseArea{
                anchors.fill: parent
                //onDoubleClicked此信号在双击(按下、释放、按下)时发出
                //当视频全屏播放时，双击视频恢复原来的样子
                onDoubleClicked: {
                    if(playWindow.width == screenWidth && playWindow.height == screenHeight){
                        playWindow.width = parent.width/1.3
                        playWindow.height = parent.height/1.1
                        controlComment.visible = true
                    }
                }

            }

            VideoOutput{
                id:videoOutPut
                //            anchors.right: parent.right
                //            anchors.rightMargin: parent.width/2
                //            anchors.bottom: parent.bottom
                //            anchors.bottomMargin: parent.height/10
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                source: mediaPlayer
                //PreserveAspectFit -视频被均匀缩放以适应不裁剪
                fillMode: VideoOutput.PreserveAspectFit
            }

            MediaPlayer{
                id: mediaPlayer
                source: "../../assets/audio.mp4"
//                autoPlay: true
                volume: volumeControl.value
//                loops: MediaPlayer.Infinite

                //此信号在回放停止时发出。相应的处理程序是onstop。当视频播放完过后，暂停键显示
                onStopped: {
                    pauseKey.visible=true
                    playKey.visible=false
                }

            }

            //视频播放进度条的控制
            Rectangle{
                id:progressBar
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 0
                height: 5
                color: "lightGray"
                Rectangle {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: mediaPlayer.duration>0?parent.width*mediaPlayer.position/mediaPlayer.duration:0
                    color: "darkGreen"
                }

                MouseArea {
                    //声明一个变量
                    property int pos
                    anchors.fill: parent

                    onClicked: {
                        //此属性保存音频的位置是否可以更改。
                        //如果为真，调用seek()方法将导致回放查找到新位置。
                        if (mediaPlayer.seekable)
                            pos = mediaPlayer.duration * mouse.x/width
                        //seek(offset)如果“查找”属性为真，则查找要偏移的当前播放位置。

                        //查找可能是异步的，因此位置属性可能不会立即更新。
                        mediaPlayer.seek(pos)
                    }
                }
            }

        }

        //操作右边的节目信息和评论
        Rectangle{
            id: operation
            color: "#333333"
            anchors.left: playWindow.right
            height: parent.height/1.1
            width: parent.width-parent.width/1.3

            Rectangle {
                id: jieMuInfo
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 20
                Text {
                    id: jieMuInfoText
                    text: qsTr("节目信息")
                    font.pixelSize: 30
                    color: "Green"
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            commentsText.color = "white"
                            jieMuInfoText.color = "Green"
                        }
                    }
                }
            }
            Rectangle{
                id: comments
                anchors.left: jieMuInfo.right
                anchors.leftMargin: 160
                anchors.top: parent.top
                anchors.topMargin: 20
                Text {
                    id: commentsText
                    text: qsTr("评论")
                    font.pixelSize: 30
                    color: "white"

                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            commentsText.color = "Green"
                            jieMuInfoText.color = "white"
                        }
                    }
                }

            }


        }

        //右下角的输入以及下载
        Rectangle{
            id: controlComment
            width: parent.width-parent.width/1.3
            height: parent.height-parent.height/1.1
            anchors.left: controlKey.right
            anchors.top: operation.bottom
            color: "DimGrey"
            visible: true

            Rectangle{
                id: comment
                width: (parent.width-parent.width/1.3)/0.5
                height: (parent.height-parent.height/1.1)/0.17
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 30
                color: "black"
                TextField{
                    id:inputComment
                    anchors.fill: parent
                    placeholderText: qsTr("写评论")
                    selectByMouse: true

                    MouseArea{
                        id: mouseArea
                        anchors.fill: parent
                        onClicked: {
                            controlComment.visible=false
                            controlComment1.visible=true
                        }
                    }

                }

            }

            Text {
                id: textDownload
                text: qsTr("下载")
                font.pixelSize: 20
                anchors.left: comment.right
                anchors.leftMargin: 60
                anchors.top: parent.top
                anchors.topMargin: 65
            }
            Image {
                id: download
                source: "../../assets/playerdownload.png"
                anchors.right: parent.right
                anchors.rightMargin: 90
                anchors.top: parent.top
                anchors.topMargin: 25
            }

        }

        //弹出的输入评论的输入框
        Rectangle{
            id: controlComment1
            width: parent.width-parent.width/1.3
            height: parent.height-parent.height/1.2
            anchors.bottom: play.bottom
            anchors.left: controlKey.right
            color: "DimGrey"
            visible: false
            TextField{
                id:inputComment1
                width: (parent.width-parent.width/1.3)/0.3
                height: (parent.height-parent.height/1.2)/0.3
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 50
                placeholderText: qsTr("我来说一说")
                selectByMouse: true
            }
            Button{
                id: cancel
                text: "取消"
                anchors.left: parent.left
                anchors.leftMargin: 170
                anchors.top: inputComment1.bottom
                anchors.topMargin: 20
                font.pixelSize: 20
                onClicked: {
                    controlComment1.visible=false
                    controlComment.visible=true
                }

            }
            Button{
                id: send
                anchors.left: cancel.right
                anchors.leftMargin: 20
                anchors.top: inputComment1.bottom
                anchors.topMargin: 20
                font.pixelSize: 20
                text: "发送"
            }

        }

        //最下面一排的控制键
        Rectangle{
            id: controlKey
            color: "#333333"
            width: parent.width/1.3
            height: parent.height-parent.height/1.1
            anchors.top: playWindow.bottom

            Image {
                id: playKey
                visible: true
                source: "../../assets/play.png"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        playKey.visible=false
                        pauseKey.visible=true
                        mediaPlayer.pause()
                    }
                }
            }

            Image {
                id: pauseKey
                visible: false
                source: "../../assets/pause.png"
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        playKey.visible=true
                        pauseKey.visible=false
                        mediaPlayer.play()
                    }
                }
            }

            Image {
                id: nextSet
                source: "../../assets/nextSet.png"
                anchors.left: parent.left
                anchors.leftMargin: 80
                anchors.top: parent.top
                anchors.topMargin: 20
            }
            Row{
                anchors.left: parent.left
                anchors.leftMargin: 160
                anchors.top: parent.top
                anchors.topMargin: 15
                width: 100
                height: 50
                spacing: 10
                Text{
                    id:movieTimeText
                    anchors.verticalCenter: parent.verticalCenter
                    //显示视频当前播放进度的时间/视频总时长
                    //duration 此属性保存媒体的持续时间(以毫秒为单位)。
                    //如果媒体没有固定的持续时间(例如实时流)，那么这个值将为0。
                    text:parent.currentTime(mediaPlayer.position)+"/"+parent.currentTime(mediaPlayer.duration)
                    color: "white"
                    font.pixelSize: 20
                }

                //                //时间格式化
                function currentTime(time)
                {
                    var sec= Math.floor(time/1000);
                    var hours=Math.floor(sec/3600);
                    var minutes=Math.floor((sec-hours*3600)/60);
                    var seconds=sec-hours*3600-minutes*60;
                    var hh,mm,ss;
                    if(hours.toString().length<2)
                        hh="0"+hours.toString();
                    else
                        hh=hours.toString();
                    if(minutes.toString().length<2)
                        mm="0"+minutes.toString();
                    else
                        mm=minutes.toString();
                    if(seconds.toString().length<2)
                        ss="0"+seconds.toString();
                    else
                        ss=seconds.toString();
                    return hh+":"+mm+":"+ss
                }
            }

            Image {
                id: danMuOpen
                visible: true
                source: "../../assets/danMuClose.png"
                anchors.left: parent.left
                anchors.leftMargin: 350
                anchors.top: parent.top
                anchors.topMargin: 20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        danMuOpen.visible=false
                        danMuClose.visible=true
                        danMuComment.visible=true
                    }
                }
            }

            Image {
                id: danMuClose
                visible: false
                source: "../../assets/danMuOpen.png"
                anchors.left: parent.left
                anchors.leftMargin: 350
                anchors.top: parent.top
                anchors.topMargin: 20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        danMuOpen.visible=true
                        danMuClose.visible=false
                        danMuComment.visible=false
                    }
                }
            }
            TextField{
                id:danMuComment
                visible: false
                width: 400

                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 450
                placeholderText: qsTr("弹幕来一波...")
                selectByMouse: true

                Button{
                    anchors.right: parent.right
                    text: "发送"
                    font.pixelSize: 20
                    //                    flat: true
                }
            }
            Image {
                //控制视频音量的键
                id: volumeKey
                visible: true
                source: "../../assets/volume.png"
                anchors.left: parent.left
                anchors.leftMargin: parent.width/1.6
                anchors.top: parent.top
                anchors.topMargin: 20
            }

            //调节音量
            Row{
                anchors.left: volumeKey.right
                anchors.leftMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 40
                Controls14.Slider{
                    id:volumeControl
                    width: play.width*0.2
                    height: 10
                    //此属性保存滑块的当前值
                    value: 1
                    onPressedChanged: {
                        if(value < 0.5){
                            volumeKey.source = "../../assets/volume1.png"
                        }else if(value >= 0.5){
                            volumeKey.source = "../../assets/volume.png"
                        }else if(value == 0.0){
                            volumeKey.source = "../../assets/volume0.png"
                        }
                    }
                    stepSize: 0.01
                    //此属性保存滑块的最大值,默认值是1.0
                    maximumValue: 1
                    //此属性保存滑块的最小值。默认值是0.0
                    minimumValue: 0
                    anchors.verticalCenter: parent.verticalCenter
                    style: SliderStyle {
                        //groove此属性保存滑块的背景槽
                        groove: Rectangle {
                            implicitWidth: play.width*0.2
                            implicitHeight: 5
                            color: "white"
                            radius: 2
                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                //此属性保存媒体播放器的音频音量。
                                //音量从0.0(静音)线性缩放到1.0(全音量),默认卷是1.0
                                width: mediaPlayer.volume>0?parent.width*mediaPlayer.volume:0
                                color: "darkGreen"
                            }
                        }
                        //handle此属性保存滑块句柄的项。
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: volumeControl.pressed ?  "white" : "darkGreen"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 15
                            implicitHeight: 15
                            radius:7.5
                            Rectangle{
                                width: parent.width-8
                                height: width
                                radius: width/2
                                color: "darkGreen"
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }

            Image {
                //控制全屏
                id: fullScreen
                visible: true
                source: "../../assets/fullScreen.png"
                anchors.left: parent.left
                anchors.leftMargin: parent.width/1.05
                anchors.top: parent.top
                anchors.topMargin: 20
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        playWindow.width = screenWidth
                        playWindow.height = screenHeight
                        controlComment.visible = false
                    }
                }
            }
        }

    }
}

 
