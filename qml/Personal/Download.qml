import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.5
import "../Personal"
Page {

    Text {
        id: name
        text: qsTr("下载界面")
    }

//    Rectangle{
//        id:bglistview
//        anchors.fill: parent
//        color: "#F9F9F9"
//        ScrollView{
//            id:control
//            anchors.fill: parent
//            width: parent.width
//            focus: true
//            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
//            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
//            ListView{
//                id:view
//                anchors.fill: parent
//                width: parent.width
//                model:HistoryModel{}



//                onContentYChanged: {
//                    if(view.contentY<-titlebar.height){
//                        titlebar.opacity = 1-(-view.contentY-titlebar.height)/100
//                        titlebar.y = -view.contentY - titlebar.height
//                    }else{
//                        item.opacity = 1
//                        titlebar.y = 0
//                    }
//                }
//                delegate:Rectangle{
//                    id:delegate
//                    width: view.width/4*3
//                    anchors.right: parent.right
//                    anchors.rightMargin: view.width/8
//                    height: 100
//                    color: bglistview.color

//                    opacity: 0.9
//                    //                    border.width: 1

//                    Image {
//                        id: moveimage
//                        source: portrait
//                        width: 80
//                        height: 100
//                        anchors.verticalCenter: parent.verticalCenter
//                        anchors.left: parent.left
//                        anchors.leftMargin: 20

//                        MouseArea{
//                            id: mouseArea
//                            anchors.fill: parent
//                            //此属性保存是否处理悬停事件。默认情况下，鼠标事件仅在响应按钮事件或按下按钮时处理。悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。
//                            hoverEnabled: true
//                            enabled: true
//                            onPressed: moveimage.opacity=0.5
//                            onReleased: moveimage.opacity=1
//                            onEntered: moveimage.scale=1.05
//                            onExited: moveimage.scale=1
//                            onClicked: {
//                                stackView.push(playInterface)
//                                playInterface.mediaPlayer.play()

//                            }
//                        }

//                    }
//                    Column{
//                        spacing:10
//                        anchors.left: moveimage.right
//                        anchors.leftMargin: 30
//                        anchors.top: parent.top
//                        anchors.topMargin: 0
//                        height: parent.height

//                        Text {
//                            id: titletext
//                            text: '<pre>电视剧  '+'<font size="4" color="orange">'+title+'</font>'+'</pre>'
//                        }
//                        Row{
//                            spacing: 100
//                            Text {
//                                id: directortext
//                                text: "导演："+director
//                            }
//                            Text {
//                                id: actortext
//                                text: "主演："+role
//                            }
//                        }
//                        Text {
//                            id: introduceText
//                            width: delegate.width-moveimage.width-100
//                            text: "简介:"+'<font color="gray">'+introduce+'</font>'
//                            wrapMode: Text.WordWrap //换行
//                        }
//                        Component{
//                            id:authologyDelegate

//                            Rectangle{
//                                width: 50;height: 50
//                                //                                color: "linen"
//                                color: bglistview.color
//                                Rectangle{
//                                    id:inauthology
//                                    width: 40
//                                    height: 40
//                                    color: "white"
//                                    MouseArea{
//                                        id: mouseArea
//                                        anchors.fill: parent
//                                        //此属性保存是否处理悬停事件。默认情况下，鼠标事件仅在响应按钮事件或按下按钮时处理。悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。
//                                        hoverEnabled: true
//                                        onEntered:{inauthology.color="#e8fcea" ;authologyNum.color="#00be06"}
//                                        onExited: {inauthology.color="white"; authologyNum.color="black"}

//                                    }

//                                    Text{
//                                        id:authologyNum
//                                        text:index+1
//                                        anchors.horizontalCenter: parent.horizontalCenter
//                                        anchors.verticalCenter: parent.verticalCenter
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}
