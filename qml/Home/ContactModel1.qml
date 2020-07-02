

//import QtQuick 2.0

//ListModel {



//    ListElement {

//        name: "Jim Williams"

//        portrait: "../../assets/d1.jpg"

//    }

//    ListElement {

//        name: "John Brown"

//        portrait: "../../assets/d2.jpg"

//    }

//    ListElement {

//        name: "Bill Smyth"

//        portrait: "../../assets/d3.jpg"

//    }

//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d4.jpg"

//    }
//    ListElement {

//        name: "Bill Smyth"

//        portrait: "../../assets/d3.jpg"

//    }

//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d4.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d2.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d1.jpg"

//    }
//    ListElement {

//        name: "Sam Wise"

//        portrait: "../../assets/d1.jpg"

//    }

//}
import QtQuick 2.0

ListModel {

    property real firstValue: 2
    id: leftGrid

    // 1. Initialize the list model:
    property bool completed: false
    Component.onCompleted: {
        append({"portrait":"../../assets/dy1.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy2.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy3.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy4.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy5.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy6.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy1.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy2.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy3.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy4.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy5.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy6.jpg","name": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        completed = true;
    }

    // 2. Update the list model:
    onFirstValueChanged: {
        if(completed) setProperty(0, "value", leftGrid.firstValue);

    }

}
