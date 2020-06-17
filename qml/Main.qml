import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.5

App {
    id:main
    visible: true
    width: 1080
    height: 960
//    visible: true

        SwipeView{
            id:swipeView
            anchors.fill: parent
            currentIndex: indicator.currentIndex
            width: 1000
            height: 300   
            Item{
                Image {
                    id:img1
                    width: parent.width
                    height: 300
                    source: "qrc:/../img/5.jpg"
                    anchors.fill: img1
                }
            }
            Item{
                Image {
                    id:img2
                    width: parent.width
                    height: 300
                    source: "qrc:/../img/5.jpg"
                    anchors.fill: img2
                }
            }
            Item{
                Image {
                    id:img3
                    width: parent.width
                    height: 300
                    source: "qrc:/../img/5.jpg"
                    anchors.fill: img3
                }
            }
            Item{
                Image {
                    id:img4
                    width: parent.width
                    height: 300
                    source: "qrc:/../img/5.jpg"
                    anchors.fill: img4
                }
            }
        }

        //tubiao
        PageIndicator{
            id:indicator
            count:swipeView.count
            currentIndex: swipeView.currentIndex
            interactive: true
            anchors.top: swipeView.top
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle{
            id:titlebar
            width: parent.width
            height: 60
            color: "whitesmoke"
            ToolBar{
                id:toolbar
                width: parent.width
//                anchors.bottom: main.Center
    //            anchors.bottomMargin: 10
                ToolButton{
                    id:button1
                    text: qsTr("shouye")
        //                onClicked:

                }
                ToolButton{
                    id:button2
                    anchors.left: button1.left
                    anchors.leftMargin: button1.width
                    text: qsTr("dianshiju")
//                        onClicked: stack.push(tv)

                }
            }

            Rectangle{

                Image {
                    id:touxiang
                    source: "qrc:/touxiang.png"
                }
                anchors.left: parent.left
                anchors.leftMargin: parent.width-touxiang.width
            }

            Rectangle {
                id: searchBkgnd;
                anchors.left: parent.left
                anchors.leftMargin: parent.width/2-300
//                anchors.horizontalCenter: parent.horizontalCenter;
//                anchors.verticalCenter: parent.verticalCenter
                width: 300
                height: parent.height-20
                radius: 14;
                //        color: Qt.rgba(213/255, 217/255, 227/255, 1.0);
                color: "white"
                border.color: "green"
                Rectangle{
                    id:searchInput
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width/4*3
                    height: parent.height-2
                    TextInput{
                        clip: true
                        width: parent.width
                        autoScroll:true
                        color: "gray"
                        anchors.verticalCenter: parent.verticalCenter
                        text: "传闻中的陈千千"; renderType: TextInput.NativeRendering; font.hintingPreference: Font.PreferVerticalHinting
                    }
                }
                Rectangle{
                    anchors.right: parent.right
                    width: parent.width/4
                    height: parent.height
                    color: "green"
                    radius:14;
                    Image {
                        id: searchImg
                        source: "qrc:/search.png"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left;
                        width: 25;
                        height: 25;
                    }
                    Text {
                        id: searchtext
                        anchors.left: searchImg.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("搜索")
                        font.pointSize: 15;
                    }
                }
            }

        }
        Text {
            id: dianshiju
            text: qsTr("dianshiju")
            anchors.top: titlebar.top
            anchors.topMargin: titlebar.height+250
        }

        Rectangle{
            id:i1
            width: 180; height: 200
            anchors.top: parent.top
            anchors.topMargin: parent.height/3+20
                  ListView {
                      anchors.fill: parent
                      flickableDirection: Flickable.AutoFlickDirection
                      model: ContactModel {}
                      delegate: Column {
                          Rectangle {
                              Image {
                                  id: name
                                  source: "qrc:/4.jpg"
                              }
                          }
                            }
                  }
        }
        Text {
            text: qsTr("111111111111")
            anchors.left: i1.left
            anchors.top: i1.top
            anchors.topMargin: i1.height
        }

        Rectangle{
            id:i2
            width: 180; height: 200
            anchors.top: parent.top
            anchors.topMargin: parent.height/3+20
            anchors.left: parent.left
            anchors.leftMargin:parent.width-parent.width/4*3
                  ListView {
                      anchors.fill: parent
                      flickableDirection: Flickable.AutoFlickDirection
                      model: ContactModel {}
                      delegate: Column {
                          Rectangle {
                              Image {
                                  id: name1
                                  source: "qrc:/4.jpg"
                              }
                          }
                            }
                  }
        }
        Text {
            text: qsTr("111111111111")
            anchors.top: i2.top
            anchors.left: i2.left
            anchors.topMargin: i2.height
        }

        Text {
            id: dianying
            text: qsTr("dianying")
            anchors.top: titlebar.top
            anchors.topMargin: titlebar.height+490
        }

        Rectangle{
            id:i11
            width: 180; height: 200
            anchors.top: parent.top
            anchors.topMargin: parent.height/3+260
                  ListView {
                      anchors.fill: parent
                      flickableDirection: Flickable.AutoFlickDirection
                      model: ContactModel {}
                      delegate: Column {
                          Rectangle {
                              Image {
                                  id: name11
                                  source: "qrc:/4.jpg"
                              }
                          }
                            }
                  }
        }
        Text {
            text: qsTr("111111111111")
            anchors.left: i11.left
            anchors.top: i11.top
            anchors.topMargin: i11.height
        }

        Rectangle{
            id:i21
            width: 180; height: 200
            anchors.top: parent.top
            anchors.topMargin: parent.height/3+260
            anchors.left: parent.left
            anchors.leftMargin:parent.width-parent.width/4*3
                  ListView {
                      anchors.fill: parent
                      flickableDirection: Flickable.AutoFlickDirection
                      model: ContactModel {}
                      delegate: Column {
                          Rectangle {
                              Image {
                                  id: name21
                                  source: "qrc:/4.jpg"
                              }
                          }
                            }
                  }
        }
        Text {
            text: qsTr("111111111111")
            anchors.top: i21.top
            anchors.left: i21.left
            anchors.topMargin: i21.height
        }

//        ToolBar{
//            id:toolbar
//            width: parent.width
//            anchors.left: parent.left
////            anchors.leftMargin: 10
//            anchors.verticalCenter: parent.verticalCenter
//            ToolButton{
//                text: qsTr("dianshiju")
////                onClicked:

//            }
//        }

//    Rectangle {
//        id:coverflow
//        color:"black"

//        property ListModel model
//        property int itemCount: 5

//        PathView{
//            id:pathView
//            model:coverflow.model
//            delegate: Item {
//                id:delegateItem
//                width: 200
//                height: 200
//                z:PathView.iconZ
//                scale:PathView.iconScale

//                Image{
//                    id:image
//                    source: "qrc:/../img/5.jpg"
//                    width: delegateItem.width
//                    height: delegateItem.height
//                }
//                ShaderEffect {
//                    anchors.top: image.bottom
//                    width: image.width
//                    height: image.height;
//                    anchors.left: image.left
//                    property variant source: image;
//                    property size sourceSize: Qt.size(0.5 / image.width, 0.5 / image.height);
//                    fragmentShader:
//                            "varying highp vec2 qt_TexCoord0;
//                            uniform lowp sampler2D source;
//                            uniform lowp vec2 sourceSize;
//                            uniform lowp float qt_Opacity;
//                            void main() {

//                                lowp vec2 tc = qt_TexCoord0 * vec2(1, -1) + vec2(0, 1);
//                                lowp vec4 col = 0.25 * (texture2D(source, tc + sourceSize) + texture2D(source, tc- sourceSize)
//                                + texture2D(source, tc + sourceSize * vec2(1, -1))
//                                + texture2D(source, tc + sourceSize * vec2(-1, 1)));
//                                gl_FragColor = col * qt_Opacity * (1.0 - qt_TexCoord0.y) * 0.2;
//                            }"
//                }



//                transform: Rotation{
//                    origin.x:image.width/2.0
//                    origin.y:image.height/2.0
//                    axis{x:0;y:1;z:0}
//                    angle: delegateItem.PathView.iconAngle
//                }
//            }
//            path:coverFlowPath
//            pathItemCount: coverflow.itemCount
//            anchors.fill: parent

//            preferredHighlightBegin: 0.5
//            preferredHighlightEnd: 0.5

//        }

//        Path{
//            id:coverFlowPath
//            startX: 0
//            startY: coverflow.height/3

//            PathAttribute{name:"iconZ";value: 0}
//            PathAttribute{name:"iconAngle";value: 70}
//            PathAttribute{name:"iconScale";value: 0.6}
//            PathLine{x:coverflow.width/2;y:coverflow.height/3}

//            PathAttribute{name:"iconZ";value: 100}
//            PathAttribute{name:"iconAngle";value: 0}
//            PathAttribute{name:"iconScale";value: 1.0}

//            PathLine{x:coverflow.width;y:coverflow.height/3}
//            PathAttribute{name:"iconZ";value: 0}
//            PathAttribute{name:"iconAngle";value: -70}
//            PathAttribute{name:"iconScale";value: 0.6}
//            PathPercent{value:1.0}

//        }

//    }
////    Rectangle{
////        width:660;height: 630
////            //second img
////            Image {
////                id: front
////                width: 660
////                height: 630
////                source: "qrc:/../img/5.jpg"
////                MouseArea{
////                    anchors.fill: parent
////                    onClicked: img1.running=true
////                }

////                //first image
////                Image {
////                    id: back1
////                    width: 660
////                    height: 630
////                    source: "qrc:/1.jpg"
////                    SequentialAnimation on x{
////                        id:img1
////                        running: false
////                        NumberAnimation{
////                            to:3600
////                            duration: 1000
////                        }
////                    }
////                }
////            }
////    }
////    Rectangle {
////         id: myRect
////         width: 360; height: 630
////         color: "black"

////         MouseArea {
////             id: mouseArea
////             anchors.fill: parent
////             onClicked: myRect.state == 'clicked' ? myRect.state = "" : myRect.state = 'clicked';
////         }

////         states: [
////             State {
////                 name: "clicked"
////                 PropertyChanges { target: myRect; color: "red" }
////             }
////         ]
////     }
}

