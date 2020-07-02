import QtQuick 2.0
import Felgo 3.0

Item {

    property alias withlogindialog: withlogindialog
    property alias dialogInfo: dialogInfo

    //如果未登录点击右下角的写评论弹出的提示对话框
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
//                controlComment.visible=false
//                controlComment1.visible=true
//                controlComment2.visible = false
//                //            danMuComment.visible = true
//                //            danMuOpen.visible = true
//                //            flag = 1
//                danMuComment.visible = false
//                controlComment2.visible = false



        }
    }

    //当输入的弹幕和评论内容为空时弹出的提示对话框
    Dialog{
        id: dialogInfo
        title: "输入的内容不能为空,请重新输入!"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled:{
            dialogInfo.close()
        }

        onAccepted: {
            dialogInfo.close()
        }
    }
}
