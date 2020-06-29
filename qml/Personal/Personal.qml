import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2 as QQD
import ".."
Page {


    id:mainwindow
    width: 1080
    height: 960
    visible: true


    ColumnLayout{

        width: parent.width
        height: parent.height

        id:content
        spacing: 30

        RowLayout{
            height: parent.height/6
            id:bar1

            Button{
                text: qsTr("返回")
                flat: true
                onClicked: {
                    stackView.pop()
                }
            }

            Text {
                width: parent.width
                height: 50
                id: text
                text: qsTr("个人中心")
                font.pointSize: 10
                //  color: "#00BFFF"

            }
        }


        RowLayout{
            height: parent.height/6
            id:bar2
            spacing: 10
            Text {
                id: leftmagint
                text: qsTr("       ")
            }
            Item {
                visible: true
                width: 50
                height: 50

                Image {
                    id: pesonaliamge
                    anchors.centerIn: parent
                    smooth: true
                    visible: false
                    source: "../../assets/1.jpg"
                }
                Rectangle {
                    id: mask
                    width: parent.width
                    height: parent.height
                    radius: width/2
                    visible: false
                }
                OpacityMask {
                    visible: true
                    anchors.fill: parent
                    source: pesonaliamge
                    maskSource: mask
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            stackView.push(loginpage)
                        }

                    }
                }
            }

            Text{
                id:personalname
                text:qsTr("个人名称")
            }

            Button{
                id:personalbutton
                text: qsTr("设置")
                width: 10
                //flat: true
                onClicked: {
                    //                        stackview.push(infomaltioncomponent)
                    //                        infomaltion.visible=true
                    //mainwindow.visible=false
                    stackView.push(informationchangpage)
                }
            }
            Button{
                id:personalexit
                text: qsTr("退出")
                width: 10
                // flat: true
                onClicked: {
                    exitdialog.open()
                }
            }
        }



        RowLayout{
            Item{
                visible: true
                id:bar3
                height: parent.height/6
                //            width: parent





                TabBar{
                    height: 40
                    id:tabBar
                    width: 250
                    currentIndex: personalswipeview.currentIndex
                    TabButton {
                        id:historybar
                        width: tabBar.width/2
                        //text: qsTr("历史记录")
                        Image {
                            focus: true
                            id: historyiamge
                            anchors.fill: parent
                            source: tabBar.currentIndex !== 0?"../../assets/historyclick.png":"../../assets/history.png"
                        }

                    }
                    TabButton {
                        id:downloadbar
                        width: tabBar.width/2
                        //text: qsTr("我的下载")
                        Image {
                            focus: true
                            id: downloadimage
                            anchors.fill: parent
                            source: tabBar.currentIndex !== 0?"../../assets/downloadclick.png":"../../assets/download.png"
                        }
                    }
                }
            }

        }
        Rectangle {
            anchors.topMargin: 0
            color: "red"
            visible: true
            height: 800
            //            height:parent.height-bar1.height-bar2.height-bar3.height
            width: parent.width
            SwipeView{
                //                anchors.rightMargin: 0
                //                anchors.bottomMargin: 0
                //                anchors.leftMargin: 0
                //                anchors.topMargin: 0
                id:personalswipeview
                enabled: opacity
                anchors.fill: parent
                currentIndex: tabBar.currentIndex
                opacity: 0
                width: parent.width
                height: parent.height
                History{
                    id:historypage

                }
                Download{
                    id:dowloadpage
                }

            }
        }
    }

    QQD.Dialog{
        id:exitdialog
        width: 150
        height: 100
        Text {
            color: "red"
            id: dialogtext
            text: qsTr("是否要退出当前登录?")
        }
    }


}


