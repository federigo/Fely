#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../misc/commander.as"


namespace Factory {

enum Attr {
	T1 = 0x0001, T2 = 0x0002, T3 = 0x0004, T4 = 0x0008
}

class SUserData {
	SUserData(int a) {
		attr = a;
	}
	SUserData() {}
	int attr = 0;
}

// Example of userData per UnitDef
array<SUserData> userData(ai.GetDefCount() + 1);

//=======================================================
//Armada Land Factories
//=======================================================
string armlab  		("armlab");
string armalab 		("armalab");
string armvp   		("armvp");
string armavp  		("armavp");
//string armhp   		("armhp");
//Armada Sea Factories
//string armfhp  		("armfhp");
string armsy   		("armsy");
string armasy  		("armasy");
string armamsub 	("armamsub");
//Armada Air Factories
string armap   		("armap");
string armaap  		("armaap");
string armplat  	("armplat");
string armapt3  	("armapt3");
//Armada T3 Factories
string armshltx 	("armshltx");
string armshltxuw 	("armshltxuw");
//=======================================================
//Cortex Land Factories
//=======================================================
string corlab  		("corlab");
string coralab 		("coralab");
string corvp   		("corvp");
string coravp  		("coravp");
//string corhp  		("corhp");
//Cortex Land Factories
//string corfhp  		("corfhp");
string corsy   		("corsy");
string corasy  		("corasy");
string coramsub 	("coramsub");
//Cortex Land Factories
string corap   		("corap");
string coraap  		("coraap");
string corplat  	("corplat");
string corapt3  	("corapt3");
//Cortex Land Factories
string corgant 		("corgant");
string corgantuw 	("corgantuw");
//=======================================================
//Legion Land Factories
//=======================================================
string leglab  		("leglab");
string legalab 		("legalab");
string legvp   		("legvp");
string legavp  		("legavp");
//string leghp  		("leghp");
//Legion Land Factories
//string legfhp  		("legfhp");
//string legsy   	("legsy"); //Add Later
//string legasy  	("legasy"); //Add Later
string legamsub 	("legamsub");
//Legion Land Factories
string legap   		("legap");
string legaap  		("legaap");
//Legion Land Factories
string leggant 		("leggant");
//string leggantuw 	("leggantuw"); //Add Later
//=======================================================
//=======================================================

float switchLimit = MakeSwitchLimit();

IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
{
	return aiFactoryMgr.DefaultMakeTask(unit);
}

void AiTaskAdded(IUnitTask@ task)
{
}

void AiTaskRemoved(IUnitTask@ task, bool done)
{
}

void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
{
	if (usage != Unit::UseAs::FACTORY)
		return;

	const CCircuitDef@ facDef = unit.circuitDef;
	if (userData[facDef.id].attr & Attr::T3 != 0) {
		// if (ai.teamId != ai.GetLeadTeamId()) then this change affects only target selection,
		// while threatmap still counts "ignored" here units.
		array<string> spam = {"armpw", "corak", "armflea", "armfav", "corfav", "corvamp", "corveng"};
		for (uint i = 0; i < spam.length(); ++i)
			ai.GetCircuitDef(spam[i]).SetIgnore(true);
	}

	const array<Opener::SO>@ opener = Opener::GetOpener(facDef);
	if (opener is null)
		return;

	const AIFloat3 pos = unit.GetPos(ai.frame);
	for (uint i = 0, icount = opener.length(); i < icount; ++i) {
		CCircuitDef@ buildDef = aiFactoryMgr.GetRoleDef(facDef, opener[i].role);
		if ((buildDef is null) || !buildDef.IsAvailable(ai.frame))
			continue;

		Task::Priority priority;
		Task::RecruitType recruit;
		if (opener[i].role == Unit::Role::BUILDER.type) {
			priority = Task::Priority::NORMAL;
			recruit  = Task::RecruitType::BUILDPOWER;
		} else {
			priority = Task::Priority::HIGH;
			recruit  = Task::RecruitType::FIREPOWER;
		}
		for (uint j = 0, jcount = opener[i].count; j < jcount; ++j)
			aiFactoryMgr.Enqueue(TaskS::Recruit(recruit, priority, buildDef, pos, 64.f));
	}
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

/*
 * New factory switch condition; switch event is also based on eco + caretakers.
 */
bool AiIsSwitchTime(int lastSwitchFrame)
{
	const float value = pow((ai.frame - lastSwitchFrame), 0.9) * aiEconomyMgr.metal.income + (aiEconomyMgr.metal.current * 5);
	if (value > switchLimit) {
		switchLimit = MakeSwitchLimit();
		return true;
	}
	return false;
}

bool AiIsSwitchAllowed(CCircuitDef@ facDef)
{
	return true;
}

/* --- Utils --- */

float MakeSwitchLimit()
{
	return AiRandom(4000, 6000) * SECOND;
}

}  // namespace Factory
