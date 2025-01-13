#include "../../define.as"
#include "../../helpers.as"

void OpenStrategy(const CCircuitDef@ facDef, const AIFloat3& in pos)
{
	LogUtil("EC2OpenStrategy called for factory: " + facDef.GetName() + " at position: " + pos.x + ", " + pos.z, 1);
}

namespace Economy {

	// To not reset army requirement on factory switch, @see Factory::AiIsSwitchAllowed
	bool isSwitchAssist = false;

	void AiLoad(IStream& istream)
	{
	}

	void AiSave(OStream& ostream)
	{
	}

	/*
	* struct SResourceInfo {
	*   const float current;
	*   const float storage;
	*   const float pull;
	*   const float income;
	* }
	*/
	void AiUpdateEconomy()
	{
		const SResourceInfo@ metal = aiEconomyMgr.metal;
		const SResourceInfo@ energy = aiEconomyMgr.energy;
		aiEconomyMgr.isMetalEmpty = metal.current < metal.storage * 0.2f;
		aiEconomyMgr.isMetalFull = metal.current > metal.storage * 0.8f;
		aiEconomyMgr.isEnergyEmpty = energy.current < energy.storage * 0.1f;
		if (aiEconomyMgr.isMetalEmpty) {
			LogUtil("Metal Empty", 2);
			aiEconomyMgr.isEnergyStalling = aiEconomyMgr.isEnergyEmpty
				|| ((energy.income < energy.pull) && (energy.current < energy.storage * 0.3f));
		} else {
			aiEconomyMgr.isEnergyStalling = aiEconomyMgr.isEnergyEmpty
				|| ((energy.income < energy.pull) && (energy.current < energy.storage * 0.4f));
		}
		// NOTE: Default energy-to-metal conversion TeamRulesParam "mmLevel" = 0.75
		aiEconomyMgr.isEnergyFull = energy.current > energy.storage * 0.88f;

		isSwitchAssist = isSwitchAssist && aiFactoryMgr.isAssistRequired;
		aiFactoryMgr.isAssistRequired = isSwitchAssist
			|| ((metal.current > metal.storage * 0.2f) && !aiEconomyMgr.isEnergyStalling);
	}

}  // namespace Economy