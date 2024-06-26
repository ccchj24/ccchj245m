import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls

GameWindow {
  Scene {
    id: gameScene

    // 示例植物类
    EntityBase {
      id: sunflower
      entityType: "Sunflower"
      width: 100
      height: 100
      x: 200
      y: 200

      // 简单的动画演示
      NumberAnimation on scale {
        from: 1.0
        to: 1.2
        duration: 1000
        running: true
        loops: Animation.Infinite
        easing.type: Easing.InOutQuad
        direction: NumberAnimation.Alternate
      }
    }

    // 其他植物类（Peashooter, IcePeashooter, NutWall等）
    EntityBase {
      id: peashooter
      entityType: "Peashooter"
      width: 100
      height: 100
      x: 400
      y: 200

      NumberAnimation on scale {
        from: 1.0
        to: 1.2
        duration: 1000
        running: true
        loops: Animation.Infinite
        easing.type: Easing.InOutQuad
        direction: NumberAnimation.Alternate
      }
    }

    // 铲子置放处
    Rectangle {
      id: shovelHolder
      width: 60
      height: 60
      color: "grey"
      x: 10
      y: 10
      z: -1 // 确保它在铲子下面

      // 铲子位置
      Image {
        id: shovelImage
        source: "shovel.png" // 铲子的图片
        width: 50
        height: 50
        x: 5
        y: 5
        z: 1 // 确保它在铲子置放处上面

        // 鼠标拖动逻辑
        MouseArea {
          id: shovelMouseArea
          anchors.fill: parent

          drag.target: shovelImage
          drag.axis: Drag.XAndYAxis

          onReleased: {
            // 铲子释放时检查是否铲除植物
            if (shovelImage.contains(mapToItem(sunflower, 0, 0))) {
              sunflower.destroy(); // 或者可以执行一个消失动画
            } else if (shovelImage.contains(mapToItem(peashooter, 0, 0))) {
              peashooter.destroy(); // 或者可以执行一个消失动画
            }
            // 继续添加其他植物的碰撞检测
          }
        }
      }
    }
  }
}
