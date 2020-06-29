
//import QtQuick 2.0

//ListModel{

//       id:model

//       ListElement{portrait:"../../assets/d1.jpg"}

//       ListElement{portrait:"../../assets/d2.jpg"}

//       ListElement{portrait:"../../assets/d3.jpg"}

//       ListElement{portrait:"../../assets/d4.jpg"}

//       ListElement{portrait:"../../assets/d1.jpg"}

//   }
import QtQuick 2.0

ListModel {

    property real firstValue: 2
    id: leftGrid

    // 1. Initialize the list model:
    property bool completed: false
    Component.onCompleted: {
        append({"portrait":"../../assets/dy1.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy2.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy3.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy4.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy5.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy6.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy1.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy2.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy3.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy4.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy5.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/dy6.jpg","name": mvintroduceSql.getIntroduce(),value:leftGrid.firstValue});
        completed = true;
    }

    // 2. Update the list model:
    onFirstValueChanged: {
        if(completed) setProperty(0, "value", leftGrid.firstValue);
    }
}
