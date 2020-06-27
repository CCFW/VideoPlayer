//import QtQuick 2.0

//ListModel {

//    property real firstValue: 2
//    id: leftGrid

//    // 1. Initialize the list model:
//    property bool completed: false
//    Component.onCompleted: {
//        append({"number": introduceSql.getIntroduce(), value: leftGrid.firstValue});
//        completed = true;
//    }

//    // 2. Update the list model:
//    onFirstValueChanged: {
//        if(completed) setProperty(0, "value", leftGrid.firstValue);
//    }
//}
import QtQuick 2.0

ListModel {



    ListElement {

        name: "Jim Williams"

        portrait: "../../assets/d1.jpg"

    }

    ListElement {

        name: "John Brown"

        portrait: "../../assets/d1.jpg"

    }

    ListElement {

        name: "Bill Smyth"

        portrait: "../../assets/d1.jpg"

    }

    ListElement {

        name: "Sam Wise"

        portrait: "../../assets/d1.jpg"

    }
    ListElement {

        name: "Sam Wise"

        portrait: "../../assets/d1.jpg"

    }
    ListElement {

        name: "Sam Wise"

        portrait: "../../assets/d1.jpg"

    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../assets/7.jpg"

//    }
//    ListElement {

//        name: "Bill Smyth"

//        portrait: "../assets/8.jpg"

//    }

//    ListElement {

//        name: "Sam Wise"

//        portrait: "../assets/4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../assets/4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../assets/4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../assets/4.jpg"

//    }

}
