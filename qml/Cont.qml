import QtQuick 2.0

  Item {
      visible: false
      Image {
          source: "qrc:/4.jpg"
      }
      Image {
          x: 80
          width: 100
          height: 100
          source: "qrc:/4.jpg"
      }
      Image {
          x: 190
          width: 100
          height: 100
          fillMode: Image.Tile
          source: "qrc:/4.jpg"
      }
  }
