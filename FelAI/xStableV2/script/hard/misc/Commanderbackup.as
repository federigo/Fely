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
		
//=======================================================
//Armada Land Factories
//=======================================================

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
		{Factory::armhp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		
//=======================================================
//Armada Sea Factories
//=======================================================

		{Factory::armfhp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armsy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armasy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::armamsub, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		
		
//=======================================================
//Armada Air Factories
//=======================================================

		{Factory::armap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armaap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::armplat, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::armapt3 array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},

//=======================================================
//Armada T3 Factories
//=======================================================

		{Factory::armshltx, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},
		{Factory::armshltxuw, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},
		
//=======================================================
//Cortex Land Factories
//=======================================================

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
		{Factory::corhp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		
//=======================================================
//Cortex Sea Factories
//=======================================================

		{Factory::corfhp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::corsy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::corasy, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::coramsub, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		
		
//=======================================================
//Cortex Air Factories
//=======================================================

		{Factory::corap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::coraap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::corplat, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::corapt3 array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},

//=======================================================
//Cortex T3 Factories
//=======================================================

		{Factory::corgant, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},
		{Factory::corgantuw, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},
		
//=======================================================
//Legion Land Factories
//=======================================================

		{Factory::leglab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::legalab, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::legvp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::legavp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::leghp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		
//=======================================================
//Legion Sea Factories
//=======================================================

		{Factory::legfhp, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		//{Factory::legsy, array<SQueue> = {
		//	SQueue(1.0f, {SO(RT::BUILDER)})
		//}},
		//{Factory::legasy, array<SQueue> = {
		//	SQueue(1.0f, {SO(RT::BUILDER2)})
		//}},
		{Factory::legamsub, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		
		
//=======================================================
//Legion Air Factories
//=======================================================

		{Factory::legap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::legaap, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER2)})
		}},
		{Factory::legplat, array<SQueue> = {
			SQueue(1.0f, {SO(RT::BUILDER)})
		}},
		{Factory::legapt3 array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}},

//=======================================================
//Legion T3 Factories
//=======================================================

		{Factory::leggant, array<SQueue> = {
			SQueue(1.0f, {SO(RT::RAIDER)})
		}}
		//{Factory::leggantuw, array<SQueue> = {
		//	SQueue(1.0f, {SO(RT::BUILDER)})
		//}}

//=======================================================
//Default if given no Orders
//=======================================================

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
