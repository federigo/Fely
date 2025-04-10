#include "../manager/factory.as"


namespace Commander {

string armcom("armcom");
string corcom("corcom");
string legcom("legcom");

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
			SQueue(1.0f, {SO(RT::BUILDER), SO(RT::SCOUT, 5), SO(RT::RAIDER, 12), SO(RT::BUILDER)})
		}},
		{Factory::armvp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::SCOUT, 5), SO(RT::BUILDER), SO(RT::RAIDER, 5), SO(RT::BUILDER)}),
		}},
		{Factory::armalab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::HEAVY, 5), SO(RT::ASSAULT, 8), SO(RT::SKIRM), SO(RT::BUILDER2), SO(RT::AHA, 2), SO(RT::HEAVY), SO(RT::BUILDER2)})
		}},
		{Factory::armavp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::SKIRM, 2), SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::BUILDER2), SO(RT::AHA), SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::AHA), SO(RT::BUILDER2)}),
		}},
		{Factory::armshltx, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RIOT, 3), SO(RT::ARTY, 5), SO(RT::SUPER), SO(RT::SUPER)})
		}},
		{Factory::armsy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::SCOUT), SO(RT::BUILDER), SO(RT::SCOUT), SO(RT::BUILDER), SO(RT::RAIDER), SO(RT::SCOUT), SO(RT::BUILDER), SO(RT::SUB), SO(RT::SKIRM)})
		}},
		{Factory::armasy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::BUILDER2, 2)})
		}},
		{Factory::corlab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER), SO(RT::RAIDER, 12), SO(RT::BUILDER)})
		}},
		{Factory::corvp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::SCOUT, 10), SO(RT::BUILDER), SO(RT::RAIDER, 10), SO(RT::BUILDER), SO(RT::RAIDER, 10), SO(RT::BUILDER)})
		}},
		{Factory::coralab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::RAIDER, 3), SO(RT::BUILDER2), SO(RT::RAIDER, 3), SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::HEAVY), SO(RT::BUILDER2), SO(RT::ASSAULT, 2), SO(RT::BUILDER2)})
		}},
		{Factory::coravp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::SKIRM, 2), SO(RT::BUILDER2), SO(RT::ASSAULT), SO(RT::BUILDER2),SO(RT::HEAVY), SO(RT::BUILDER2, 2)})
		}},
		{Factory::corgant, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER), SO(RT::ASSAULT), SO(RT::ARTY, 2)})
		}},
		{Factory::corsy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::SCOUT), SO(RT::BUILDER), SO(RT::SCOUT), SO(RT::BUILDER), SO(RT::RAIDER), SO(RT::SCOUT), SO(RT::BUILDER), SO(RT::SUB), SO(RT::SKIRM)})
		}},
		{Factory::corasy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::BUILDER2), SO(RT::SKIRM), SO(RT::BUILDER2, 2)})
		}},
		{Factory::leglab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER, 3), SO(RT::RAIDER, 5), SO(RT::SKIRM, 6), SO(RT::BUILDER)})
		}},
		{Factory::legvp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER, 3), SO(RT::SCOUT, 3), SO(RT::RAIDER, 12), SO(RT::BUILDER)})
		}},
		{Factory::legalab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::RAIDER, 3), SO(RT::BUILDER2), SO(RT::RAIDER, 3), SO(RT::SKIRM), SO(RT::HEAVY), SO(RT::ASSAULT, 2), SO(RT::BUILDER2)})
		}},
		{Factory::legavp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2), SO(RT::SKIRM, 2), SO(RT::BUILDER2), SO(RT::ASSAULT), SO(RT::BUILDER2),SO(RT::HEAVY)})
		}},
		{Factory::leggant, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}}
		}, {SO(RT::BUILDER), SO(RT::RAIDER, 3), SO(RT::BUILDER), SO(RT::RAIDER)}
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
