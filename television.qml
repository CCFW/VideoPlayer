import QtQuick 2.0

Rectangle{
    //头像
    Image {
        id: touxiang
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 32
        height: 32
        source: "qrc:/touxiang.png"
    }
    //返回按钮
    Image{
        id:backbutton
        width: 30
        height: 30
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        source: "qrc:/back.png"
    }
}
