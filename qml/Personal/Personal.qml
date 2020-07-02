
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2 as QQD
import ".."
import Felgo 3.0
Page {
    property alias historylistview: model1
    property alias personalpageview: bar3.visible
    HistoryModel{
        id:model1

    }

    id:mainwindow
    width: parent.width
    height: parent.height


    property alias personaltext:personalname.text
    property alias iamgefile: pesonaliamge.source

    ColumnLayout{
        anchors.fill: parent

        id:content
        spacing: 20

        RowLayout{
            //            Layout.alignment: Qt.AlignCenter
            //            anchors.left: parent.left
            //            anchors.leftMargin: 10
            id:bar1
            spacing: 10
            Image {
                width: 30
                height: 30
                source: "../../assets/back.png"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.pop()
                    }
                }
            }
            Image {
                id: personalimage
                source: "../../assets/personal.png"

            }
        }


        RowLayout{

            Layout.alignment: Qt.AlignLeft
            //            anchors.leftMargin: 30
            id:bar2
            spacing: 10
            Text {
                id: personalkongbaitext
                text: qsTr("   ")

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

                    source: "../../assets/touxiang.png"

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

                            var id = sql.getid()
                            if(id ==0){
                                stackView.push(loginpage)
                            }else{
                                persondialog.open()
                            }

                        }

                    }
                }
            }

            Text{
                id:personalname

                text:sql.getname()

            }

            Button{
                id:personalbutton
                text: qsTr("设置")
                width: 10
                //flat: true
                onClicked: {

                    var id = sql.getid()
                    if(id == 0){
                        withlogindialog.open()
                    }else{
                        informationchangpage.informationimage = sql.getavatar()
                        stackView.push(informationchangpage)
                    }

                }
            }
            Button{
                id:personalexit
                text: qsTr("退出")
                width: 10
                // flat: true
                onClicked: {

                    var id = sql.getid();
                    if(id == 0){
                        exitdialogagin.open()
                    }else{

                        exitdialog.open()
                    }



                }
            }
        }



        RowLayout{
            Button{
                //                text: qsTr("历史记录")
                Image {
                    id: historybuttonimage
                    anchors.fill: parent
                    source: view.currentIndex == 0?"../../assets/historyclick.png":"../../assets/history.png"
                    //                    source: "../../assets/history.png"
                }
                onClicked: {
//                    stackView.push(historypage)
                    //                    historybuttonimage.source = "../../assets/historyclick.png"
                    view.currentIndex = 0
                }
            }
            Button{
                //                text: qsTr("我的下载")
                Image {
                    id: downloadbuttonimag
                    anchors.fill: parent
                    source: view.currentIndex == 1 ? "../../assets/downloadclick.png":"../../assets/download.png"
                    //                    source: "../../assets/download.png"
                }
                onClicked: {
                    //                    downloadbuttonimag.source = "../../assets/downloadclick.png"
                    view.currentIndex = 1
                }

            }

            //            TabBar{
            ////                height: 40
            //                id:tabBar
            ////                width: 250
            ////                    currentIndex: personalswipeview.currentIndex
            //                TabButton {
            //                    id:historybar
            //                    width: tabBar.width/2
            //                    //text: qsTr("历史记录")
            //                    Image {
            //                        focus: true
            //                        id: historyiamge
            //                        anchors.fill: parent
            //                        source: tabBar.currentIndex !== 0?"../../assets/historyclick.png":"../../assets/history.png"
            //                    }

            //                }
            //                TabButton {
            //                    id:downloadbar
            //                    width: tabBar.width/2
            //                    //text: qsTr("我的下载")
            //                    Image {
            //                        focus: true
            //                        id: downloadimage
            //                        anchors.fill: parent
            //                        source: tabBar.currentIndex !== 0?"../../assets/downloadclick.png":"../../assets/download.png"
            //                    }
            //                }
            //            }

        }
        RowLayout{
            //            anchors.top: content.bottom
            //            anchors.topMargin: 0
            id:toorbarlayot
            width: parent.width
            height: parent.height/1.5
            Item{
                width: parent.width
                height: parent.height
                visible: true
                id:bar3
                SwipeView {

                    id: view
                    currentIndex: 0
                    anchors.fill: parent
                    Item {
                        id: secondPage
                        //                        History{
                        //                        }
                        Rectangle{
                            id:bglistview
                            anchors.fill: parent
//                            color: "#F9F9F9"
                            //        color: "red"
                            ScrollView{
                                id:control
                                anchors.fill: parent
                                width: parent.width
                                focus: true
                                ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
                                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                                ListView{
                                    spacing: 50
                                    id:views
                                    anchors.fill: parent
                                    width: parent.width
                                    model:model1



                                    delegate:Rectangle{
                                        id:delegate
                                        width: views.width/4*3
//                                        anchors.right: parent.right
//                                        anchors.rightMargin: views.width/8
                                        height: 100
                                        color: bglistview.color

                                        opacity: 0.9
                                        //                    border.width: 1

                                        Image {
                                            id: moveimage
                                            source: portrait
                                            width: 80
                                            height: 100
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
                                                onClicked: {
                                                    stackView.push(playInterface)
                                                    playInterface.mediaPlayer.play()

                                                }
                                            }

                                        }
                                        Column{
                                            spacing:10
                                            anchors.left: moveimage.right
                                            anchors.leftMargin: 30
                                            anchors.top: parent.top
                                            anchors.topMargin: 0
                                            height: parent.height

                                            Text {
                                                id: titletext
                                                text: '<pre>电视剧  '+'<font size="4" color="orange">'+title+'</font>'+'</pre>'
                                            }
                                            Row{
                                                spacing: 100
                                                Text {
                                                    id: directortext
                                                    text: "导演："+director
                                                }
                                                Text {
                                                    id: actortext
                                                    text: "主演："+role
                                                }
                                            }
                                            Text {
                                                id: introduceText
                                                width: delegate.width-moveimage.width-100
                                                text: "简介:"+'<font color="gray">'+introduce+'</font>'
                                                wrapMode: Text.WordWrap //换行
                                            }

                                        }
                                    }
                                }
                            }
                        }

                    }
                    Item {
                        id: thirdPage
                        Download{
                        }
                    }
                }

                PageIndicator {
                    id: indicator
                    count: view.count
                    currentIndex: view.currentIndex
                    anchors.bottom: view.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

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
        }
    }
    Dialog{
        id: exitdialogagin
        title: "您已经退出登录!"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            exitdialogagin.close()
        }

        onAccepted: {
            exitdialogagin.close()
        }
    }
    Dialog{
        id: exitdialog
        title: "是否要退出当前登录？"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            exitdialog.close()
        }

        onAccepted: {
            sql.exitlogin()
            sql.clearVector()
            personalpage.historylistview.clear()
            //            danMuSql.playExit()
            personalpage.iamgefile = sql.getavatar()
            personalname.text = sql.getname()
            exitdialog.close()
            playInterface.controlComment2Visible=true
            homepage.homepageimage = sql.getavatar()
        }
    }
    Dialog{
        id: persondialog
        title: "您已经登录，无需重复登录"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            persondialog.close()
        }

        onAccepted: {
            persondialog.close()
        }
    }


}


