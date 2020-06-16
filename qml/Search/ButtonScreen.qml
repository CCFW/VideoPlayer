import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle{
    Button {
        id: fileButton
        onClicked: menu.open()
        opacity: 0

        Menu {
            id: menu
            y: fileButton.height
            Action { text: "全部" }
            Action { text: "0-10分钟" }
            Action { text: "10-30分钟" }
            Action { text: "30-60分钟" }
            Action { text: "60分钟以上" }
        }
    }
}
