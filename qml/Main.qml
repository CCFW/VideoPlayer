<<<<<<< HEAD
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Window 2.12
import Qt.labs.platform 1.1
import "./Search/" as Home1



App{
    width: 1247
    height: 733
//    color: "transparent";
    id: root;

//    Home1.Home {
//        id: homePage

//        anchors.verticalCenter:  parent.verticalCenter;
//        anchors.horizontalCenter: parent.horizontalCenter;

//    }


   Home1.SearchHome{

   }
//   ScrollBar {
//                 id: vbar
//                 hoverEnabled: true
//                 active: hovered || pressed
//                 orientation: Qt.Vertical
//                 size: frame.height
//                 width: 10
//                 anchors.top: parent.top
//                 anchors.right: parent.right
//                 anchors.bottom: parent.bottom
//             }




}

=======
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.5

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"
    width: 1080
    height: 960
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
    PlayInterface{
            id:playerinterfacepage
        }


    Scene{
        anchors.fill: parent;
        StackView{
            id:stackView
            anchors.fill: parent
            initialItem: personalpage
        }
    }
}
>>>>>>> 32956a2018994ef01a477319ba9ff69b76e50f50
