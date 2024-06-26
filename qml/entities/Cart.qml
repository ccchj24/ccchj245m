import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls 2.0
 // 小推车实体
EntityBase {
      id: cart
      entityType: "Cart"
      width: 80
      height: 80
      x: 0
      y: 300
      speed: 200 // 小推车的速度，每秒移动的像素数

      Image {
        id: cartImage
        source: "cart.png" // 小推车的图片
        width: parent.width
        height: parent.height
      }

      // 小推车的移动动画
      PropertyAnimation {
        target: cart
        property: "x"
        from: 0
        to: gameScene.width
        duration: (gameScene.width / cart.speed) * 1000
        running: true
        onStopped: {
          cart.destroy() // 到达边界时销毁小推车
        }
      }

      // 与僵尸的碰撞处理
      onXChanged: {
        var zombies = gameScene.children.filter(child => child.entityType === "Zombie")
        for (var i = 0; i < zombies.length; i++) {
          var zombie = zombies[i]
          if (cart.collidesWith(zombie)) {
            zombie.destroy() // 碰撞后秒杀僵尸
          }
        }
      }
    }

