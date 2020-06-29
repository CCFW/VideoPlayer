import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2 as QQD

Page{

    width: 1080
    height: 960

    Rectangle{
        color: "white"
        //                visible: false
        //                color: "red"
        id:infomaltion
        width: parent.width
        height: parent.height
        AppText {
            x:parent.width/2-150
            height: parent.height/8
            id: infomaltiontext
            text: qsTr("修改个人信息")
            Layout.topMargin: dp(8)
            Layout.bottomMargin: dp(12)
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            //                    font.pointSize: 30
        }
        RowLayout{

            x:parent.width/2-300
            y:parent.height-infomaltiontext.height-700
            ColumnLayout{
                //                        y:parent.height-(parent.height-infomaltiontext.height)
                //                        x:parent.width/2-250
                y:parent.height-infomaltiontext.height-700
                spacing: 30

                AppText {
                    id: touxiangtext
                    text: qsTr("头像 ：")
                    font.pixelSize: sp(12)
                    //                            font.pointSize: 18
                }

                AppText {
                    id: nichengtext
                    text: qsTr("昵称 ：")
                    //                            font.pointSize: 18
                    font.pixelSize: sp(12)
                }

                AppText {
                    id: passwordtext1
                    text: qsTr("旧密码 ：")
                    //                            font.pointSize: 18
                    font.pixelSize: sp(12)
                }

                AppText {
                    id: passwordtext2
                    text: qsTr("新密码 ：")
                    //                            font.pointSize: 18
                    font.pixelSize: sp(12)
                }

                AppText {
                    id: passwordtext3
                    text: qsTr("再次输入新密码 ：")
                    //                            font.pointSize: 18
                    font.pixelSize: sp(12)
                }

            }
            ColumnLayout{
                spacing: 5
                y:parent.height-infomaltiontext.height-700
                //                     x:parent.width/2-300
                Item {
                    visible: true
                    width: 50
                    height: 50

                    Image {
                        id: pesonaliamgechange
                        anchors.centerIn: parent
                        smooth: true
                        visible: false
                        source: "../../assets/1.jpg"
                    }
                    Rectangle {
                        id: maskchange
                        width: parent.width
                        height: parent.height
                        radius: width/2
                        visible: false
                    }
                    OpacityMask {
                        visible: true
                        anchors.fill: parent
                        source: pesonaliamgechange
                        maskSource: maskchange
                    }
                }
                AppTextField{

                    id:nichenginput
                    text: qsTr("请输入新昵称")
                    //                            font.pointSize: 15
                    Layout.preferredWidth: dp(200)
                    showClearButton: true
                    font.pixelSize: sp(14)
                    borderColor: Theme.tintColor
                    borderWidth: !Theme.isAndroid ? dp(2) : 0
                }
                AppTextField{
                    x:400
                    id:passwordinput1
                    text: qsTr("请输入旧密码")
                    //                            font.pointSize: 15
                    Layout.preferredWidth: dp(200)
                    showClearButton: true
                    font.pixelSize: sp(14)
                    borderColor: Theme.tintColor
                    borderWidth: !Theme.isAndroid ? dp(2) : 0
                }
                AppTextField{
                    x:400
                    id:passwordinput2
                    text: qsTr("请输入新密码")
                    //                            font.pointSize: 15
                    Layout.preferredWidth: dp(200)
                    showClearButton: true
                    font.pixelSize: sp(14)
                    borderColor: Theme.tintColor
                    borderWidth: !Theme.isAndroid ? dp(2) : 0
                }
                AppTextField{
                    x:400
                    id:passwordinput3
                    text: qsTr("请再次输入新密码")
                    //                            font.pointSize: 15
                    Layout.preferredWidth: dp(200)
                    showClearButton: true
                    font.pixelSize: sp(14)
                    borderColor: Theme.tintColor
                    borderWidth: !Theme.isAndroid ? dp(2) : 0
                }
            }

        }
        RowLayout{
            spacing: 100
            x:parent.width/2-300
            y:parent.height/2
            AppButton{
                id:quedingbutton
                text: qsTr("确定")
                flat: false
                //                            font.pointSize: 18
                onClicked: {
                    //                                infomaltion.visible=false
                    //                                mainwindow.visible = true
                    stackView.pop()
                }
            }

            AppButton{
                id:quxiaobutton
                text: qsTr("取消")
                flat: false
                //                            font.pointSize: 18

            }

        }


    }
}

