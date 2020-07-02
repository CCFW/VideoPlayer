import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1

Page {

    id: registerPages

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


    Image {
        anchors.left: parent.left
        anchors.leftMargin: 20
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

                    var flag = sql.registersave(txtUsername.text,txtPassword.text,txtPasswordagin.text)
                    if(flag == 0){
                        nullfalut.open()
                    }
                    else if (flag== 1){
                        passwordfalut.open()
                    }
                    else if (flag == 2){
                        registerfalut.open()
                    }
                    else if (flag== 3){
                        loginpage.personalaccount = sql.getaccount()
                        registersuccess.open()
                    }

                    //                    stackView.pop()
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
    Dialog{
        id: nullfalut
        title: "用户名和密码不能为空！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            nullfalut.close()
        }

        onAccepted: {
            nullfalut.close()
        }
    }
    Dialog{
        id: passwordfalut
        title: "两次输入的密码不同"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            passwordfalut.close()
        }

        onAccepted: {
            passwordfalut.close()
        }
    }
    Dialog{
        id: registerfalut
        title: "该帐号已注册，请直接登录！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            registerfalut.close()
        }

        onAccepted: {
            txtUsername.text = ""
            txtPassword.text = ""
            txtPasswordagin.text = ""
            registerfalut.close()
            stackView.pop()
        }
    }
    Dialog{
        id: registersuccess
        title: "注册成功!"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        //                anchors.centerIn: loginPage
        onCanceled:{
            registersuccess.close()
        }

        onAccepted: {
            txtUsername.text = ""
            txtPassword.text = ""
            txtPasswordagin.text = ""
            registersuccess.close()
            stackView.pop()

        }
    }

}
