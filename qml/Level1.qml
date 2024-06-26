import Felgo 4.0
import QtQuick 2.0

import "entities"

Item {
    id: level1

    // number of total zombies
    property int maxZombies : 6
    // path to background image for this level
    property string background: "../assets/img/atl.png"
    // name of the city will be displayed in the HUD
    property string city: "Atlanta"

    // add some zombies
    Zombie {x:zombieWidth*1; y:zombieHeight*1;}
    Zombie {x:zombieWidth*2; y:zombieHeight*1;}
    Zombie {x:zombieWidth*4; y:zombieHeight*2;}
    Zombie {x:zombieWidth*5; y:zombieHeight*2;}
    Zombie {x:zombieWidth*7; y:zombieHeight*1;}
    Zombie {x:zombieWidth*8; y:zombieHeight*1;}
}
