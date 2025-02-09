#include "../manager/factory.as"


namespace Commander {

string armcom("armcom");
string corcom("corcom");

}


namespace Opener {

class SO {  // SOrder
	SO(Type r, uint c = 1) {
		role = r;
		count = c;
	}
	SO() {}
	Type role;
	uint count;
}

class SQueue {
	SQueue(float w, array<SO>& in o) {
		weight = w;
		orders = o;
	}
	SQueue() {}
	float weight;
	array<SO> orders;
}

class SOpener {
	SOpener(dictionary f, array<SO>& in d) {
		factory = f;
		def = d;
	}
	dictionary factory;
	array<SO> def;
}

SOpener@ GetOpenInfo()
{
	return SOpener({
		{Factory::armlab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armalab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::armvp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armavp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::armsy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armasy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::armap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armaap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::armshltx, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},
		{Factory::corlab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::coralab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::corvp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::coravp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::corsy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::corasy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::corap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::coraap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::corgant, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}}
		}, {SO(RT::BUILDER), SO(RT::SCOUT), SO(RT::RAIDER, 3), SO(RT::BUILDER), SO(RT::RAIDER), SO(RT::BUILDER), SO(RT::RAIDER)}
	);
}

const array<SO>@ GetOpener(const CCircuitDef@ facDef)
{
	SOpener@ open = GetOpenInfo();

	const string facName = facDef.GetName();
	array<SQueue>@ queues;
	if (!open.factory.get(facName, @queues))
		return open.def;

	array<float> weights;
	for (uint i = 0, l = queues.length(); i < l; ++i)
		weights.insertLast(queues[i].weight);

	int choice = AiDice(weights);
	if (choice < 0)
		return open.def;

	return queues[choice].orders;
}

}  // namespace Opener


/*
namespace Hide {

// Commander hides if ("frame" elapsed) and ("threat" exceeds value or enemy has "air")
shared class SHide {
	SHide(int f, float t, bool a) {
		frame = f;
		threat = t;
		isAir = a;
	}
	int frame;
	float threat;
	bool isAir;
}

dictionary hideInfo = {
	{Commander::armcom, SHide(480 * 30, 30.f, true)},
	{Commander::corcom, SHide(470 * 30, 20.f, true)}
};

map<Id, SHide@> hideUnitDef;  // cache map<UnitDef_Id, SHide>

const SHide@ CacheHide(const CCircuitDef@ cdef)
{
	Id cid = cdef.GetId();
	const string name = cdef.GetName();
	array<string>@ keys = hideInfo.getKeys();
	for (uint i = 0, l = keys.length(); i < l; ++i) {
		if (name.findFirst(keys[i]) >= 0) {
			SHide@ hide = cast<SHide>(hideInfo[keys[i]]);
			hideUnitDef.insert(cid, hide);
			return hide;
		}
	}
	hideUnitDef.insert(cid, null);
	return null;
}


const SHide@ GetForUnitDef(const CCircuitDef@ cdef)
{
	bool success;
	SHide@ hide = hideUnitDef.find(cdef.GetId(), success);
	return success ? hide : CacheHide(cdef);
}

}  // namespace Hide
*/
