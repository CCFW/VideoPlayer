import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2 as QQD
Page {
    id: loginPage
    title: qsTr("登录")


    //  backgroundColor: Qt.rgba(0,0,0, 0.75)
    useSafeArea: false
    property alias personalaccount: txtUsername.text
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
            text: "登录"
            font.pixelSize: sp(20)
        }


        AppText {
            text: qsTr("帐号")
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

        Column {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: dp(12)

            AppButton {
                text: qsTr("登录")
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    if(sql.loginvefied(txtUsername.text,txtPassword.text) == 1){
                        personalpage.personaltext = sql.getname()
                        personalpage.iamgefile = sql.getavatar()
                        danMuSql.setId(sql.getid())
                        danMuSql.setName(sql.getname())
                        homepage.homepageimage = sql.getavatar()
                        loginsucess.open()
                        txtUsername.text = ""
                        txtPassword.text = ""
                        playInterface.controlComment2Visible = false

                        //历史记录
                        sql.gethistroys()
//                        console.log(sql.gettileName().length)
                        if(sql.gettileName().length == 0){
                            personalpage.personalpageview = false
                        }else{
                            personalpage.personalpageview = true
//                             console.log(sql.gettileName().length)
                            for(var i=0; i<sql.gettileName().length;i++){

                                personalpage.historylistview.append({"title":sql.gettileName()[i],"director":sql.getDirector()[i],"introduce":sql.getIntroduce()[i],"role":sql.getRole()[i],"portrait":sql.getEpisodes()[i]})
                                if(personalpage.historylistview.get(0).title == ""){
                                    personalpage.historylistview.remove(0)
                                }
                            }
                        }

                    }
                    else if(sql.loginvefied(txtUsername.text,txtPassword.text) == 0){
                        loginfalut.open()
                    }
                    else if(sql.loginvefied(txtUsername.text,txtPassword.text) == 2){
                        registerfalut.open()
                    }
                    else if(sql.loginvefied(txtUsername.text,txtPassword.text) == 3){
                        nullfalut.open()
                    }

                }
            }



            AppButton {
                text: qsTr("还没有帐号？马上注册")
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    txtUsername.text = ""
                    txtPassword.text = ""
                    stackView.push(registerpage)
                }
            }
        }
    }

    Dialog{
        id: loginsucess
        title: "登录成功！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled:{
            loginsucess.close()
        }

        onAccepted: {
            loginsucess.close()
            stackView.pop()
        }
    }
    Dialog{
        id: loginfalut
        title: "密码错误！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled: {
            loginfalut.close()
        }

        onAccepted: {
            loginfalut.close()
        }
    }
    Dialog{
        id: nullfalut
        title: "帐号和密码不能为空！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled: {
            nullfalut.close()
        }

        onAccepted: {
            nullfalut.close()
        }
    }
    Dialog{
        id: registerfalut
        title: "未有该帐号，请先注册！"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled: {
            registerfalut.close()
        }
        onAccepted: {
            registerfalut.close()
            stackView.push(registerpage)
        }
    }

}
