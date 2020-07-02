import QtQuick 2.0

Rectangle {

    Text {
        id: btnText;

        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        //        color: ma.pressed ? "blue" : (parent.bHovered ? "#0000a0" : "white");
        font.pointSize: 20;
    }
    //        MouseArea {
    //            id: ma;
    //            anchors.fill: parent;
    //            hoverEnabled: true;
    //            onEnabledChanged: {
    //                bkgrd.bHovered = true;
    //            }
    //            onExited: {
    //                bkgrd.bHovered = false;
    //            }
    //            onClicked: {
    //                bkgrd.bHovered = false;
    //                bkgrd.clicked();
    //            }
    //        }

}
