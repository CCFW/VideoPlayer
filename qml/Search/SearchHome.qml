import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle{
    id:home
    width: parent.width
    height: parent.height
    TitleBar{
        id:titlebar
        z:3
        color: "#F1F1F1"
        opacity: 0
        Item{
            id:item
            anchors.fill: parent
            opacity: 1
        }
    }

    Rectangle{
        id:bglistview
        anchors.fill: parent
//        color: "linen"//内容部分的背景颜色
        color: "#F9F9F9"


        ScrollView{
            id:control
            anchors.fill: parent
            width: parent.width
            focus: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ListView{
                id:view
                anchors.fill: parent
                width: parent.width
                model:SearchModel{}


                header:headerdeleget

                onContentYChanged: {
                    if(view.contentY<-titlebar.height){
                        titlebar.opacity = 1-(-view.contentY-titlebar.height)/100
                        titlebar.y = -view.contentY - titlebar.height
                    }else{
                        item.opacity = 1
                        titlebar.y = 0
                    }
                }
                delegate:Rectangle{
                    id:delegate
                    width: view.width/4*3
                    anchors.right: parent.right
                    anchors.rightMargin: view.width/8
                    height: 300
                    color: bglistview.color

                    opacity: 0.9
//                    border.width: 1

                    Image {
                        id: moveimage
                        source: portrait
                        width: 200
                        height: 270
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                        MouseArea{
                            id: mouseArea
                            anchors.fill: parent
                            //此属性保存是否处理悬停事件。默认情况下，鼠标事件仅在响应按钮事件或按下按钮时处理。悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。
                            hoverEnabled: true
                            enabled: true
                            onPressed: moveimage.opacity=0.5
                            onReleased: moveimage.opacity=1
                            onEntered: moveimage.scale=1.05
                            onExited: moveimage.scale=1
                        }

                    }
                    Column{
                        spacing:20
                        anchors.left: moveimage.right
                        anchors.leftMargin: 50
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        height: parent.height

                        Text {
                            id: titletext
                            text: '<pre>电视剧  '+'<font size="5" color="orange">'+title+'</font>'+'</pre>'
                        }
                        Row{
                            spacing: 200
                            Text {
                                id: directortext
                                text: "导演："+director
                            }
                            Text {
                                id: actortext
                                text: "主演："+actor
                            }
                        }
                        Text {
                            id: introduceText
                            width: delegate.width-moveimage.width-100
                            text: "简介:"+'<font color="gray">'+introduce+'</font>'
                            wrapMode: Text.WordWrap //换行
                        }
                        GridView{
                            id:authologyGridView
                            width: introduceText.width
                            height: 150
                            cellWidth: 50
                            cellHeight: 50
                            model: 24

                            delegate: authologyDelegate
                        }
                        Component{
                            id:authologyDelegate

                            Rectangle{
                                width: 50;height: 50
    //                                color: "linen"
                                color: bglistview.color
                                Rectangle{
                                    id:inauthology
                                    width: 40
                                    height: 40
                                    color: "white"
                                    MouseArea{
                                        id: mouseArea
                                        anchors.fill: parent
                                        //此属性保存是否处理悬停事件。默认情况下，鼠标事件仅在响应按钮事件或按下按钮时处理。悬停允许处理所有鼠标事件，即使没有按下鼠标按钮。
                                        hoverEnabled: true
                                        onEntered:{inauthology.color="#e8fcea" ;authologyNum.color="#00be06"}
                                        onExited: {inauthology.color="white"; authologyNum.color="black"}

                                    }

                                Text{
                                    id:authologyNum
                                    text:index+1
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                }
                            }
                        }


                    }
                }
            }
        }
    }
    Component{
        id:headerdeleget
        Rectangle{
            id:headerItem
            width: home.width
            height: 170
            //            color: search_re.color
            //            color: "red"

            //头部
            HeadTop{
                id:head_top
                color: "black"
                width: parent.width
                height: 50
                anchors.top: parent.top
            }

            TitleBar{
                id:search_re
                anchors.top:head_top.bottom
                color: "#F1F1F1"


                //                anchors.topMargin: 10
            }

            //筛选
            Rectangle{
                id:nav_colunm
                color:"gainsboro"
                opacity:0.99
                width: parent.width
                height: 50
                anchors.top: search_re.bottom
                //                anchors.topMargin: 10

                //相关
                Navigation{
                    id:xiangguan
                    width: 50
                    color:parent.color
                    height: parent.height
                    anchors.left: parent.left;
                    anchors.leftMargin: 35
                    Text {
                        id: xiangguantext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("相关")
                    }
                }
                //筛选
                Navigation{
                    id:shaixuan
                    width: 50
                    height: parent.height
                    color: parent.color
                    anchors.left: xiangguan.right;
                    anchors.leftMargin: 50
                    Text {
                        id: shaixuantext
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("筛选")
                    }
                }
                ButtonScreen{
                    id:downmenu
                    width: 20
                    height: 20
                    anchors.left: shaixuan.right
                    anchors.verticalCenter: parent.verticalCenter
                    color: parent.color

                    Image {
                        id: anchordown
                        anchors.fill: parent
                        opacity: 1
                        source: "../../assets/anchor-down.png"
                    }
                }
            }
        }
    }

}
