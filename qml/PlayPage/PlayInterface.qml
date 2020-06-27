import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4 as Controls14
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

//import QtQuick.Dialogs 1.2 as QQD

//Rectangle {

//    id: playwindow
//    anchors.fill: parent

Rectangle{
    id: playInterface
    width: 1080
    height: 960
    anchors.fill: parent

    color: "DimGrey"

    //flag此属性用来判断弹幕可见不
    property int flag: 0
    property alias mediaPlayer: mediaPlayer

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
                if(playWindow.width == playInterface.width && playWindow.height == playInterface.height){
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
//            source: "../../assets/video/vedio1.mp4"
            source: "http://localhost/2.mp4";
            //            autoPlay: true
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

                cursorShape: Qt.PointingHandCursor
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

    //    Rectangle{
    //        anchors.fill: mediaPlayer;
    //        id : window
    //        color: "black"
    //    }

    //liststr装弹慕内容的容器、数组
    //var类型是一个可以引用任何数据类型的通用属性类型
    property var liststr: []
    property int index: 0

    //从c++端获取弹幕已有的数量并遍历push放入到liststr数组中
    function danMu(){
        var a = danMuSql.getDanMuCount();
        var i = 0;
        while(i < a){
            liststr.push(danMuSql.getDanMu());
            i++;
        }
    }

    //动态加载
    function addItem()
    {
        //Math.random()*500会产生一个[0,500)的数，注意其中包含了小数,除200后的余数
        //        console.log(liststr)
        //        console.log("liststr   "+typeof(liststr[index]));
        var oldy = Math.random()*500%200;
        for (var i = 0 ; i < 1; ++i)
        {
            //用Qt.createComponent加载一个qml文件并创建Component
            var component = Qt.createComponent("TextItem.qml");
            if (component.status == Component.Ready)
            {
                //使用Component的createObject()方法创建对象
                var textitem = component.createObject(playWindow);

                oldy += 30;
                //随机生成弹幕的y坐标也就是输出的位置
                textitem.y = oldy;
                index = Number(oldy%5);
                if(typeof(liststr[index]) == 'string'){
                    //                    console.log("textstr   "+typeof(textitem.textstr));
                    //                    console.log("liststr   "+typeof(liststr[index]));
                    //弹幕内容输出到屏幕上
                    if(flag == 1){
                        textitem.visible = true
                    }
                    //当flag为0时，弹幕内容不可见
                    if(flag == 0){
                        textitem.visible = false
                    }
                    textitem.textstr = liststr[index];
                }

            }
        }
    }


    Component.onCompleted: {
        //在实例化对象之后发出。一旦建立了完整的QML环境，就可以使用它在启动时执行脚本代码。
        //对应的处理程序是onCompleted。它可以在任何对象上声明。运行onCompleted处理程序的顺序未定义
        addItem()
        danMu()
    }
    Timer {
        id: timer
        //ontrigger这个信号在计时器超时时发出。
        interval: 1000
        running: true
        repeat: true
        onTriggered: addItem()
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
            source: "../../assets/playInterface/play.png"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
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
            source: "../../assets/playInterface/pause.png"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 20
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    playKey.visible=true
                    pauseKey.visible=false
                    mediaPlayer.play()
                }
            }
        }

        Image {
            id: nextSet
            source: "../../assets/playInterface/nextSet.png"
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
            width: parent.width / 3
            height: parent.height / 2
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
            id: danMuClose
            visible: true
            source: "../../assets/playInterface/danMuClose.png"
            anchors.left: parent.left
            anchors.leftMargin: 350
            anchors.top: parent.top
            anchors.topMargin: 20
            MouseArea{
                id: danMuCloseMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    danMuClose.visible=false
                    danMuOpen.visible=true
                    danMuComment.visible=true
                    flag = 1
                    //                    console.log("danMuCLose  "+flag)
                }
            }
        }

        Image {
            id: danMuOpen
            visible: false
            source: "../../assets/playInterface/danMuOpen.png"
            anchors.left: parent.left
            anchors.leftMargin: 350
            anchors.top: parent.top
            anchors.topMargin: 20
            MouseArea{
                id: danMuOpenMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    danMuClose.visible=true
                    danMuOpen.visible=false
                    danMuComment.visible=false
                    controlComment2.visible = false
                    flag = 0
                    //                    console.log("danMuOPen  "+flag)
                }
            }
        }

        Rectangle{
            id: controlComment2
            width: controlKey.width / 4
            height: controlKey.height/2.3
            //            anchors.bottom: parent.bottom
            //            anchors.bottomMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: danMuClose.right
            anchors.leftMargin: 20
            Text {
                id: danMuPrompt
                font.pixelSize: 20
                anchors.verticalCenter: parent.verticalCenter
                //                text: '<font color="Green" cursor="pointhand">'+"登录"+'</font>'+"或"+'<font color="Green">'+"注册"+'</font>'+"后来一发吧！"
                text: "登录或注册"
                color: "Lime"
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        danMuPrompt.color = "Green"
                    }
                    onExited: {
                        danMuPrompt.color = "Lime"
                    }
                    onClicked: {
                        var id = sql.getid()
                        if(id == 0){
                            stackView.push(loginpage)
                            danMuComment.visible = true
                            danMuOpen.visible = true
                        }
                    }
                }
            }
            Text {
                id: danMuPrompt3
                font.pixelSize: 20
                anchors.left: danMuPrompt.right
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("后来一发吧！")
            }
        }

        TextField{
            id:danMuComment
            visible: false
            width: controlKey.width / 4
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: danMuClose.right
            anchors.leftMargin: 20
            placeholderText: qsTr("弹幕来一波...")
            selectByMouse: true
            font.pixelSize: 20
            Button{
                anchors.right: parent.right
                text: "发送"
                font.pixelSize: 20

                onClicked: { 
                    //往容器（liststr）中push添加输入的弹幕内容
                    if(danMuComment.text){
                        liststr.push((danMuComment.text).toString())
                        danMuSql.danMu((danMuComment.text).toString())
                    }else{

                    }

                }
            }
        }

        Image {
            //控制视频音量的键
            id: volumeKey
            visible: true
            source: "../../assets/playInterface/volume.png"
            anchors.left: danMuComment.right
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
        }

        //调节音量
        Row{
            id: volume
            anchors.left: volumeKey.right
            anchors.leftMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 40
            Controls14.Slider{
                id:volumeControl
                width: playInterface.width*0.15
                height: 10
                //此属性保存滑块的当前值
                value: 1
                onPressedChanged: {
                    if(value < 0.5){
                        volumeKey.source = "../../assets/playInterface/volume1.png"
                    }else if(value >= 0.5){
                        volumeKey.source = "../../assets/playInterface/volume.png"
                    }else if(value == 0.0){
                        volumeKey.source = "../../assets/playInterface/volume0.png"
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
                        implicitWidth: playInterface.width*0.15
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
            source: "../../assets/playInterface/fullScreen.png"
            anchors.left: volume.right
            anchors.leftMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 20
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    playWindow.width = playInterface.width
                    playWindow.height = playInterface.height
                    controlComment.visible = false
                }
            }
        }
    }

    //操作右边的视频信息和评论
    Rectangle{
        id: operation
        color: "#333333"
        anchors.left: playWindow.right
        height: parent.height/1.1
        width: parent.width-parent.width/1.3

        Rectangle {
            id: jieMuInfo
            width: parent.width/1.15
            height: parent.height / 16
            color: "#333333"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            Text {
                id: jieMuInfoText
                anchors.fill: parent
                text: qsTr("视频")
                font.pixelSize: 30
                color: "Green"
                MouseArea{
                    id: mouseArea1
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        commentsText.color = "white"
                        jieMuInfoText.color = "Green"
                        description.visible = true
                        commentDescription.visible = false
                    }
                }
            }

            Text {
                id: commentsText
                anchors.fill: parent
                anchors.left: jieMuInfo.right
                anchors.leftMargin: 100
                text: qsTr("评论")
                font.pixelSize: 30
                color: "white"

                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        commentsText.color = "Green"
                        jieMuInfoText.color = "white"
                        description.visible = false
                        commentDescription.visible = true
                    }
                }
            }

        }

        Rectangle{
            id: description
            width: parent.width
            height: parent.height / 1.5
            color: "#333333"
            anchors.top: jieMuInfo.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 30

            visible: true

            Text {
                id: vedioName
                text: qsTr("冰糖炖雪梨")
                font.pixelSize: 25
                color: "white"
            }

            Text {
                id: introduction
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 5
                text: qsTr("简介 >")
                font.pixelSize: 20
                color: mouseArea2.containsMouse ? "Green" : "white"
                MouseArea{
                    id: mouseArea2
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                }
            }
            Text {
                id: select
                text: qsTr("选集")
                font.pixelSize: 25
                anchors.top: introduction.bottom
                anchors.topMargin: 30
                color: "white"
            }

            Text {
                id: fenJiJuQing
                anchors.right: parent.right
                anchors.top: introduction.bottom
                anchors.topMargin: 35
                text: qsTr("分集剧情 >")
                font.pixelSize: 20
                color: fenJiJuQingMouseArea.containsMouse ? "Green" : "white"
                MouseArea{
                    id: fenJiJuQingMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        introduction.color = "Green"
                        hoverEnabled: true
                    }

                }
            }

            //选择集数
            Rectangle{
                width: parent.width
                height: parent.height
                anchors.top: select.bottom
                anchors.topMargin: 20
                color: "#333333"
                ListModel{
                    id: model
                    ListElement{ number: 1;}
                    ListElement{ number: 2;}
                    ListElement{ number: 3;}
                    ListElement{ number: 4;}
                    ListElement{ number: 5;}
                    ListElement{ number: 6;}
                    ListElement{ number: 7;}
                    ListElement{ number: 8;}
                    ListElement{ number: 9;}
                    ListElement{ number: 10;}
                    ListElement{ number: 11;}
                    ListElement{ number: 12;}
                }
                GridView{
                    id: grid
                    anchors.fill: parent
                    width: parent.width
                    height: parent.height
                    cellWidth: 60
                    cellHeight: 60
                    model: model
                    delegate: contactDelegate
                    focus: true
                }
                Component{
                    id: contactDelegate
                    Rectangle {
                        width: 55
                        height: 55
                        color: "#333333"

                        Rectangle{
                            id: rect
                            width: 55
                            height: 55
                            color: "DimGray"
                            MouseArea{
                                id: mouseArea
                                anchors.fill: parent
                                //此属性保存是否处理悬停事件。默认情况下，鼠标事件仅在响应按钮事件或按下按钮时处理。
                                //悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。
                                hoverEnabled: true
                                //当鼠标进入鼠标区域时发出此信号。
                                //默认情况下，该信号只在当前按下按钮时发出。设置hoverEnabled为true，即使没有按下鼠标按钮，
                                //也会发出此信号。
                                onEntered:{jiShu.color="SeaGreen"}
                                //当鼠标离开鼠标区域时发出此信号。
                                //默认情况下，该信号只在当前按下按钮时发出。设置hoverEnabled为true，即使没有按下鼠标按钮，
                                //也会发出此信号。
                                onExited: {jiShu.color="white"}
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                        //                        //首先是一个渐变的矩形框
                        //                        gradient: Gradient {
                        //                            GradientStop { position: 0.0; color: "#f8306a"; }
                        //                            GradientStop { position: 1.0; color: "#fb5b40"; }
                        //                        }

                        Text {
                            id: jiShu
                            text: number
                            font.pixelSize: 25
                            anchors.centerIn: parent
                            color: "white"
                        }
                    }
                }
            }

        }

        Rectangle{
            id: commentDescription
            visible: false
            width: parent.width / 1.1
            height: parent.height / 1.5
            //            height: operation.height
            color: "transparent"
            anchors.top: jieMuInfo.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            Text {
                id: allComment
                text: qsTr("全部评论")
                font.pixelSize: 25
                color: "white"
            }
            Rectangle{
                id: rectangle
                width: parent.width
                height: parent.height
                anchors.top: allComment.bottom
                anchors.topMargin: 20
                color: "transparent"

                Component{
                    id: contactDelegate1

                    Item {
                        width: rectangle.width
                        height: user.height + commentInfo.text.length*5

                        Item {
                            id: user
                            width: 100
                            height: 100

                            Image {
                                id: avatar
                                anchors.fill: parent
                                smooth: true
                                visible: false
                                //                                source: "qrc:/images/avatar.jpg"
                                source: portrait
                            }
                            Rectangle{
                                id: mask
                                width: parent.width
                                height: parent.height
                                radius: width / 2
                                visible: false
                            }

                            //用另一个项掩码源项
                            OpacityMask{
                                anchors.fill: parent
                                //此属性定义将被屏蔽的源项
                                source: avatar
                                //此属性定义将用作掩码的项。掩码项被渲染到一个中间像素缓冲区，结果的alpha值用于确定源项在显示中的像素可见性
                                maskSource: mask
                            }

                            Text {
                                id: username
                                //                                text: qsTr("lalala")
                                text: name
                                anchors.left: avatar.right
                                anchors.leftMargin: 20
                                font.pixelSize: 30
                                color: "white"
                            }
                        }
                        Text {
                            id: commentInfo
                            width: parent.width
                            anchors.top: user.bottom
                            //                    anchors.topMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 120
                            //                            text: qsTr("如果可能，在单词边界处进行换行;否则，它将出现在该行上的适当位置，甚至在单词的中间。")
                            text: commenttext
                            font.pixelSize: 25
                            color: "white"
                            //wrapMode设置此属性以将文本包装为文本项的宽度。文本只会在明确设置宽度时自动换行
                            //如果可能，在单词边界处进行换行;否则，它将出现在该行上的适当位置，甚至在单词的中间。
                            wrapMode: Text.Wrap
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                        }
                    }

                }

                ContactModel {
                    id:model1
                }

                ListView {
                    id:view
                    width: commentDescription.width
                    height: rectangle.height
                    model:model1
                    delegate: contactDelegate1
                    //                    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                    focus: true
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
                //                selectByMouse: true
                font.pixelSize: 20
                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        var id = sql.getid()
                        if(id == 0){
                            withlogindialog.open()
                        }else{
                            controlComment.visible=false
                            controlComment1.visible=true
                        }

                    }
                }

            }

        }

        Text {
            id: textDownload
            text: qsTr("下载")
            font.pixelSize: 20
            anchors.left: comment.right
            anchors.leftMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 65
        }

        Image {
            id: download
            source: "../../assets/playInterface/download.png"
            anchors.left: comment.right
            anchors.leftMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 23
        }

    }

    //弹出的输入评论的输入框
    Rectangle{
        id: controlComment1
        width: parent.width-parent.width/1.3
        height: parent.height-parent.height/1.2
        anchors.bottom: playInterface.bottom
        anchors.left: controlKey.right
        color: "DimGrey"
        visible: false
        Rectangle{
            id: textArea
            width: (parent.width-parent.width/1.3)/0.3
            height: (parent.height-parent.height/1.2)/0.3
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 50
            color: "white"
            TextArea{
                id:inputComment1
                anchors.fill: parent
                placeholderText: qsTr("我来说一说")
                selectByMouse: true
                selectionColor: "white"
                wrapMode: TextEdit.Wrap
                font.pixelSize: 20
            }
        }

        Button{
            id: cancel
            text: "取消"
            anchors.left: parent.left
            anchors.leftMargin: 170
            anchors.top: textArea.bottom
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
            anchors.top: textArea.bottom
            anchors.topMargin: 20
            font.pixelSize: 20
            text: "发送"
            onClicked: {
                var data = {"portrait": "../../assets/playInterface/avatar1.jpg","name": "hahaha", "commenttext": inputComment1.text}
                model1.append(data)
            }
        }

    }

    Dialog{
        id: withlogindialog
        title: "请先登录！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            withlogindialog.close()
        }

        onAccepted: {
            stackView.push(loginpage)
            withlogindialog.close()
            controlComment.visible=false
            controlComment1.visible=true
            controlComment2.visible = false
            danMuComment.visible = true
            danMuOpen.visible = true
        }
    }
}

