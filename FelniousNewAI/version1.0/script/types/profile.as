#include "../helpers.as"
#include "map_config.as"
#include "ai_role.as"

#include "../unit.as"

class Profile {
    //These should be private, but Angelscript does not support static classes and cannot be private in namespace
    //Lets pretend they are :P
    MapConfig _mapConfig;
    AiRole _aiRole;

    Profile(MapConfig mapConfig, AiRole aiRole) {
       _mapConfig = mapConfig;
       _aiRole = aiRole;
    }

    Profile() {
       _mapConfig = MapConfig();
       _aiRole = AiRole::FRONT;
    }

    /************************ 
    Pretend Public Methods
    TODO: Refactor 
    **************************/

    //Returns pre-selected role determined on init
    AiRole GetAiRole() {
        return _aiRole;
    }

    //Returns pre-selected map config determined on init
    MapConfig GetMapConfig() {
        return _mapConfig;
    }
}  