#include "../../define.as"
#include "../../unit.as"
#include "../../helpers.as"

namespace Military {

	IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
	{
		LogUtil("Military::AiMakeTask", 4);
		return aiMilitaryMgr.DefaultMakeTask(unit);
	}

	void AiTaskAdded(IUnitTask@ task)
	{

	}

	void AiTaskRemoved(IUnitTask@ task, bool done)
	{
		// if (done == false) {
		// 	SmrtLog("SMRT: AiTaskRemoved " + task);
		// }

	}

	void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
	{
	}

	void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
	{
	}

	void AiLoad(IStream& istream)
	{
	}

	void AiSave(OStream& ostream)
	{
	}

	void AiMakeDefence(int cluster, const AIFloat3& in pos)
	{
		//AiLog("SMRT: Frame - " + ai.frame);
		if ((ai.frame > 10 * MINUTE)
			|| (aiEconomyMgr.metal.income > 10.f)
			|| (aiEnemyMgr.mobileThreat > 0.f))
		{
			LogUtil("Military::AiMakeDefence", 4);
			aiMilitaryMgr.DefaultMakeDefence(cluster, pos);
		}
	}

	/*
	* anti-air threat threshold;
	* air factories will stop production when AA threat exceeds
	*/
	// FIXME: Remove/replace, deprecated.
	bool AiIsAirValid()
	{
		bool isAirValid = aiEnemyMgr.GetEnemyThreat(Unit::Role::AA.type) <= 90000.f;
		LogUtil("AiIsAirValid: " + isAirValid, 2);
		return isAirValid;
	}

}  // namespace Military