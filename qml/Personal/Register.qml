import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1

Page {
    id: loginPage
    title: qsTr("注册")

    //  backgroundColor: Qt.rgba(0,0,0, 0.75)
    useSafeArea: false

    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        color: "white"
        width: content.width + dp(1080)
        height: content.height + dp(960)
        radius: dp(4)
    }


    GridLayout {
        id: content
        anchors.centerIn: loginForm
        columnSpacing: dp(20)
        rowSpacing: dp(10)
        columns: 2

        AppText {
            Layout.topMargin: dp(8)
            Layout.bottomMargin: dp(12)
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: "注册"
            font.pixelSize: sp(20)
        }


        AppText {
            text: qsTr("昵称")
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtUsername
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
        }

        // password text and field
        AppText {
            text: qsTr("密码")
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtPassword
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            echoMode: TextInput.Password
        }
        AppText {
            text: qsTr("确认密码")
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtPasswordagin
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            echoMode: TextInput.Password
        }

        Column {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: dp(12)


            AppButton {
                text: qsTr("注册")
                flat: false
//                anchors.centerIn:parent
                Layout.fillWidth: true
                Layout.columnSpan: 2
                Layout.topMargin: dp(12)
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    stackView.pop()
                }
            }
//            AppButton {
//                text: qsTr("登录")
//                flat: false
////                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: {
//                }
//            }



        }
    }

}
