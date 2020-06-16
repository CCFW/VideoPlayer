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

    Scene{
        anchors.fill: parent;
        StackView{
            id:stackView
            anchors.fill: parent
            initialItem: personalpage
        }
    }
}