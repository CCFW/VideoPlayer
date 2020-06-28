
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.5
import "./Personal"
import "./Player"
import "./Search"
import "./Home"

App {
    property alias widths: mainwindow.width
    property alias heights: mainwindow.height
    width: 1080
    height: 960

    id:mainwindow
    Home{
        id:homepage
    }

    Personal{
        id:personalpage
    }
    Login{
        id:loginpage
    }
    Register{
        id:registerpage
    }
    Informationchange{
        id:informationchangpage
    }

    SearchHome{
        id:searchhomepage

    }

    Playerinterface{
        id:playerinterfacepage
    }

    Scene{
        anchors.fill: parent;
        StackView{
            id:stackView
            anchors.fill: parent

            initialItem: homepage
        }
    }
}
