import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls
import "entities"

Scene {
    id: gameScene

    // Background image for the game scene
    Image {source:"../assets/img/background.png"; anchors.fill:parent}

    // Example plant cards in the shop
    Shop {
        id: shop
        anchors.top: parent.top
        anchors.left: parent.left
        items: [
            { name: "Sunflower", image: "../assets/img/sunflower.png" },
            { name: "Peashooter", image: "../assets/img/peashooter.png" },
        ]
    }


    function increaseSunCount() {
            player.sunCount += 25;
        console.log("Player's sun count increased to: " + player.sunCount);
    }

    Rectangle {
        width: 100
            height: 100
            color: "yellow"
            radius: width / 2  // 圆形的形状


            Image {
                   source: "sun.png"
                   anchors.centerIn: parent
                   top: parent.top
                   left: parent.left
               }

               // 定义阳光数量属性
               property int sunlightCount: 0
           // 显示阳光数量
            Text {
                   text: "Sunlight: " + sunlightCount
                   anchors.centerIn: parent
                   color: "black"
                   font.bold: true
               }
    }

    Grid {
                 id: roadGrid
                 // 这里可以定义道路格子的属性和逻辑，例如格子大小、位置等

                 // 植物放置逻辑
                 // 假设有一个植物放置函数，例如 plantPlant(x, y)
                 MouseArea {
                     anchors.fill: parent
                     onClicked: {
                         // 根据点击位置计算格子坐标1
                         var cellX = Math.floor(mouse.x / gridSize)
                         var cellY = Math.floor(mouse.y / gridSize)

                         // 示例：放置植物在点击的格子上
                         plantPlant(cellX, cellY)
                     }
                 }

                 // 可以在这里动态生成道路格子，具体实现取决于游戏的需求
                 // 例如，使用Repeater来生成多个格子
                 Repeater {
                     model: 10 // 例如，10个格子
                     Rectangle {
                         width: gridSize
                         height: gridSize
                         color: "transparent"
                         border.color: "gray"
                         border.width: 1
                         // 根据需要设置位置等属性
                     }
                 }
             }
         }





