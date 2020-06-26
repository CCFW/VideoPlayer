import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle {
    id:main
    visible: true
    width: 1080
    height: 960
    anchors.fill: parent

    property alias homepageimage: touxiang.source
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
                source: "../../assets/5.jpg"
                anchors.fill: img1
            }
        }
        Item{
            Image {
                id:img2
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
                anchors.fill: img2
            }
        }
        Item{
            Image {
                id:img3
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
                anchors.fill: img3
            }
        }
        Item{
            Image {
                id:img4
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
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
                text: qsTr("首页")
                //                onClicked:

            }
            ToolButton{
                id:button2
                anchors.left: button1.left
                anchors.leftMargin: button1.width
                text: qsTr("电视剧")
                //                        onClicked: stack.push(tv)

            }
            //                ToolButton{
            //                    id:button3
            //                    anchors.left: button2.left
            //                    anchors.leftMargin: button2.width
            //                    text: qsTr("denglu")
            //                    onClicked:{
            //                        stackView.push(loginpage)
            //                    }

            //                }
        }

        Rectangle{
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: parent.width-touxiang.width
            Image {
                id:touxiang
                width: 40
                height: 40
                source: "../../assets/touxiang.png"

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(personalpage)
                    }
                }
            }

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
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(searchhomepage)
                    }
                }
                Image {
                    id: searchImg
                    source: "../../assets/search.png"
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
                        source: "../../assets/4.jpg"
                    }
                }
                Text { text: '<b>Number:</b> ' + number }
            }
        }
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
                        source: "../../assets/4.jpg"
                    }
                }
                Text { text: '<b>Number:</b> ' + number }
            }
        }
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
                        source: "../../assets/4.jpg"
                    }
                }
                Text { text: '<b>Number:</b> ' + number }
            }
        }
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
                        source: "../../assets/4.jpg"
                    }
                }
                Text {
                    text: '<b>Number:</b> ' + number
                    //                                                  anchors.top: i21.top
                    //                                                  anchors.left: i21.left
                    //                                                  anchors.topMargin: i21.height
                }

            }
        }
    }

}

