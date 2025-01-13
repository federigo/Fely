#include "../common.as"
#include "../unit.as"
#include "../helpers.as"

namespace Init {

	SInitInfo AiInit()
	{
		LogUtil("hard_aggressive AngelScript Rules!", 1);

		SInitInfo data;
		data.armor = InitArmordef();
		data.category = InitCategories();
		@data.profile = @(array<string> = {"behaviour", "block_map", "build_chain", "commander", "economy", "factory", "response"});
		return data;
	}

}