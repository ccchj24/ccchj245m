import Felgo 3.0
import QtQuick 2.12
import QtQuick.Controls 2.12

EntityBase {
    id: conezombie

    // 僵尸的属性
    property var head: null
    property int hp: 1000
    property int atk: 10
    property int state: 0
    property real speed: 80.0 * 33 / 1000 / 4.7
    property bool attack: false
    property bool beAttacked: false
    property bool dead: false
    property int line: 1
    property var yLine: [100, 200, 300, 400, 500]
    property int z_x: Math.floor(x / 10)
    property int zombiesSpawned: 0

    // 路障僵尸的属性
    property int barricadeHp: 1000

    // 僵尸类型
    property string zombieType: "normal"

    // 边界矩形
    function boundingRect() {
        return Qt.rect(-80, -100, 200, 140);
    }

    // 绘制僵尸
    function paint(painter) {
        // 绘制逻辑
    }
    // 僵尸与植物子弹的碰撞检测
    function bulletCollision(bullet) {
        return bullet.type === "Bullet" && Math.abs(bullet.y - y) < 30 && Math.abs(bullet.x - x) < 30;
    }

    // 检测僵尸与植物子弹的碰撞并开始攻击
    function checkBulletCollision(bullets) {
        for (var i = 0; i < bullets.length; i++) {
            if (bulletCollision(bullets[i])) {
                beAttacked = true;
                hp -= bullets[i].damage;
                if (hp <= 0) {
                    dead = true;
                    // 在这里添加僵尸死亡的逻辑
                }
                bullets[i].destroy();
                break;
            }
        }
    }

    // 僵尸攻击植物的碰撞检测
    function plantCollision(plant) {
        return plant.type === "Plant" && Math.abs(plant.y - y) < 30 && Math.abs(plant.x - x) < 30;
    }

    // 检测僵尸与植物的碰撞并开始攻击
    function checkPlantCollision(plants) {
        for (var i = 0; i < plants.length; i++) {
            if (plantCollision(plants[i])) {
                attack = true;
                attackDetect();
                plants[i].hp -= atk;
                if (plants[i].hp <= 0) {
                    plants[i].destroy();
                }
                break;
            } else {
                attack = false;
                attackDetect();
            }
        }
    }

    // 僵尸实体
    AnimatedImage {
        id: conezombieAnimation
        source: dead ? "" : "res/images/zombie/Zombie/Zombie.gif"
        playing: !dead

        // 移动动画
        NumberAnimation on x {
            id: move
            to: 0
            running: !dead
            duration: speed
        }

        // 死亡动画
        SequentialAnimation {
            id: deadAnimation
            NumberAnimation {
                target: conezombieAnimation
                property: "opacity"
                to: 0
                duration: 1000
            }
            NumberAnimation {
                target: deadBody
                property: "opacity"
                to: 1
                duration: 1000
            }
            NumberAnimation {
                target: deadHead
                property: "opacity"
                to: 1
                duration: 1000
            }
            onStopped: {
                deadBody.source = ""
                deadHead.source = ""
            }
        }


    // 随机生成僵尸
    Timer {
        id: spawnTimer
        interval: Math.random() * 10000 + 5000 // 随机时间生成僵尸
        repeat: true
        running: true
        onTriggered: {
            if (gameTime < 300000) { // 前五分钟
                if (zombiesSpawned < 5 || gameTime < 60000) {
                    // 生成普通僵尸
                    console.log("生成普通僵尸");
                    createZombie("normal");
                    zombiesSpawned++;
                }
            } else {
                // 五分钟后开始生成路障僵尸
                var zombieType = Math.random() < 0.5 ? "normal" : "cone";
                console.log("生成" + (zombieType === "normal" ? "普通僵尸" : "路障僵尸"));
                createConeZombie(zombieType);
            }
        }
    }

    // 创建僵尸
    function createConeZombie(type) {
        var newZombie = Qt.createQmlObject('import QtQuick 2.0; Zombie {}', parent);
        newZombie.zombieType = type;
        if (type === "cone") {
            newZombie.hp += 500; // 增加500生命值
        }
    }

}
}
