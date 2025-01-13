#include "../helpers.as"
//Types
#include "../types/profile.as"
#include "../types/profile_controller.as"
//managers
#include "manager/military.as"
#include "manager/builder.as"
#include "manager/factory.as"
#include "manager/economy.as"
//Maps
#include "maps/default_map_config.as"
#include "maps/swirly_rock.as"
#include "maps/all_that_glitters.as"
//Role Handlers
#include "role_handlers/front.as"
#include "role_handlers/eco.as"
#include "role_handlers/air.as"

namespace Main {

	Profile profile;
	ProfileController profileController;

	void AiMain()
	{	
		LogUtil("Running AiMain()", 1);

		LogUtil("registerMaps", 1);
		MapConfigManager@ mapManager = MapConfigManager(DEFAULT_MAP_CONFIG);
		registerMaps(mapManager);

		const string mapName = ai.GetMapName();
		LogUtil("MAP_NAME: " + mapName, 1);
        MapConfig selectedMapConfig = mapManager.getMapConfig(mapName);

		AiRole selectedAiRole = GetRandomAiRole();

		LogUtil("Profile(" + selectedMapConfig._mapNameMatch + ", " + selectedAiRole +")", 1);
		profile = Profile(selectedMapConfig, selectedAiRole);

		profileController = createProfileController(profile);




		for (Id defId = 1, count = ai.GetDefCount(); defId <= count; ++defId) {
			CCircuitDef@ cdef = ai.GetCircuitDef(defId);
			if (cdef.costM >= 200.f && !cdef.IsMobile() && aiEconomyMgr.GetEnergyMake(cdef) > 1.f)
				cdef.AddAttribute(Unit::Attr::BASE.type);  // Build heavy energy at base
		}

		// Example of user-assigned custom attributes
		array<string> names = {Factory::armalab, Factory::coralab, Factory::armavp, Factory::coravp,
			Factory::armaap, Factory::coraap, Factory::armasy, Factory::corasy};
		for (uint i = 0; i < names.length(); ++i)
			Factory::userData[ai.GetCircuitDef(names[i]).id].attr |= Factory::Attr::T2;
		names = {Factory::armshltx, Factory::corgant};
		for (uint i = 0; i < names.length(); ++i)
			Factory::userData[ai.GetCircuitDef(names[i]).id].attr |= Factory::Attr::T3;
	}

	void AiUpdate()  // SlowUpdate, every 30 frames with initial offset of skirmishAIId
	{
		if (profileController !is null) {
			profileController.MainUpdate();
		}
	}

	void OpenStrategy(const CCircuitDef@ facDef, const AIFloat3& in pos)
	{
		LogUtil("OpenStrategy called for factory: " + facDef.GetName() + " at position: " + pos.x + ", " + pos.z, 1);
	}

	ProfileController createProfileController(Profile profile) {

		ProfileController _profileController = ProfileController(profile);
		// Assign the appropriate MainUpdateHandler based on the AiRole
		switch (profile.GetAiRole()) {
			case AiRole::FRONT:
				@_profileController.MainUpdateHandler = cast<MainUpdateDelegate@>(@Front_MainUpdate);
				break;
			case AiRole::AIR:
				@_profileController.MainUpdateHandler = cast<MainUpdateDelegate@>(@Air_MainUpdate);
				break;
			case AiRole::ECO:
				@_profileController.MainUpdateHandler = cast<MainUpdateDelegate@>(@Eco_MainUpdate);
				break;
			default:
				LogUtil("Error: Unknown AiRole provided", 3);
				break;
		}

		return _profileController;
	}

	void registerMaps(MapConfigManager@ mapManager) {
        mapManager.RegisterMapConfig(SWIRLY_ROCK);
        mapManager.RegisterMapConfig(ALL_THAT_GLITTERS);
    }

}  // namespace Main