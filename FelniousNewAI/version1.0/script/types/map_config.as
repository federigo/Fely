#include "../helpers.as"

class MapConfig {  
	string _disabledUnits;
	string _mapNameMatch;

	MapConfig(string mapNameMatch, string disabledUnits) {
		_mapNameMatch = mapNameMatch;
		_disabledUnits = disabledUnits;

	}

	MapConfig() {
		_mapNameMatch = "";
		_disabledUnits = "";
	}

	string GetDisabledUnits() {
        return _disabledUnits;
    }

	// Check if the provided map name contains the _mapNameMatch as a prefix
    bool CheckMatch(string mapName) {
		LogUtil("CheckMatch:MapName:" + mapName, 5);
		LogUtil("CheckMatch:_mapNameMatch:" + _mapNameMatch, 5);
		return mapName.findFirst(_mapNameMatch) == 0;
	}


}

class MapConfigManager {  
    // Array to store MapConfig objects
    array<MapConfig> mapConfigs;

    // Default MapConfig
    MapConfig defaultMapConfig;

    // Constructor with default MapConfig
    MapConfigManager(MapConfig defaultConfig) {
        defaultMapConfig = defaultConfig;
    }

    // Default constructor
    MapConfigManager() {
        defaultMapConfig = MapConfig();
    }

    // Register a MapConfig by adding it to the array
    void RegisterMapConfig(MapConfig mapConfig) {
        mapConfigs.insertLast(mapConfig);
    }

    // Retrieve a MapConfig by map name (partial match)
	// Input parameter has full name, while map config uses a partial
    MapConfig getMapConfig(string mapName) {
        LogUtil("getMapConfig() Input Map Name: " + mapName, 1);

        for (uint i = 0; i < mapConfigs.length(); i++) {
			if (mapConfigs[i] is null) {
				LogUtil("getMapConfig() mapConfigs[" + i + "] is null!", 4);
				continue;
			}
			MapConfig mapConfig = mapConfigs[i];

			LogUtil("getMapConfig() mapConfigs[i]: " + mapConfig._mapNameMatch, 1);

            if (mapConfigs[i].CheckMatch(mapName)) {
				LogUtil("getMapConfig() return mapConfigs[i]; " + mapName, 4);
                return mapConfig;
            }
        }

        LogUtil("No match found, returning default configuration", 1);
        return defaultMapConfig;
    }
}