import ut;
export Filenames(integer cnt = 0) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Declaration of Value Types
	//////////////////////////////////////////////////////////////////

	export San_diego_raw 			:= cluster.Cluster_In + 'in::FBNV2::CA::San_diego::Sprayed';
	export Ventura_raw 				:= cluster.Cluster_In + 'in::FBNV2::CA::Ventura::Sprayed';
	export Orange_raw 				:= cluster.Cluster_In + 'in::FBNV2::CA::Orange::Sprayed';
	//export San_Bernardino_raw := cluster.Cluster_In + 'in::FBNV2::CA::San_Bernardino::Sprayed';
	export Santa_Clara_raw 		:= cluster.Cluster_In + 'in::FBNV2::CA::Santa_Clara::Sprayed';
	//export Dallas_raw 				:= cluster.Cluster_In + 'in::FBNV2::TX::Dallas::Sprayed';
	export Harris_raw 				:= cluster.Cluster_In + 'in::FBNV2::TX::Harris::Sprayed';
	export Filing_raw 				:= cluster.Cluster_In + 'in::FBNV2::FL::Filing::Sprayed';
	export Event_raw 					:= cluster.Cluster_In + 'in::FBNV2::FL::Event::Sprayed';
	//export NYC_raw 						:= cluster.Cluster_In + 'in::FBNV2::NYC::Sprayed';
	//export infoUSA_raw        := cluster.Cluster_In + 'in::FBNV2::InfoUSA::Sprayed';
	
	
	export San_diegoupdate 			:= cluster.Cluster_In + 'in::FBNV2::CA::San_diego';
	export Venturaupdate 				:= cluster.Cluster_In + 'in::FBNV2::CA::Ventura';
	export orangeupdate 				:= cluster.Cluster_In + 'in::FBNV2::CA::orange';
	export San_Bernardinoupdate := cluster.Cluster_In + 'in::FBNV2::CA::San_Bernardino';
	export Santa_Claraupdate 		:= cluster.Cluster_In + 'in::FBNV2::CA::Santa_Clara';
	export Dallasupdate 				:= cluster.Cluster_In + 'in::FBNV2::TX::Dallas';
	export Harrisupdate 				:= cluster.Cluster_In + 'in::FBNV2::TX::Harris';
	export Filingupdate 				:= cluster.Cluster_In + 'in::FBNV2::FL::Filing';
	export Eventupdate 					:= cluster.Cluster_In + 'in::FBNV2::FL::Event';
	export NYCupdate 						:= cluster.Cluster_In + 'in::FBNV2::NYC';
	export infoUSAupdate    	  := cluster.Cluster_In + 'in::FBNV2::InfoUSA';
	
	export San_diego_newupdate 			:= cluster.Cluster_In + 'in::FBNV2::CA::San_diego::Cleaned';
	export Ventura_newupdate 				:= cluster.Cluster_In + 'in::FBNV2::CA::Ventura::Cleaned';
	export orange_newupdate 				:= cluster.Cluster_In + 'in::FBNV2::CA::orange::Cleaned';
	export Santa_Clara_newupdate 		:= cluster.Cluster_In + 'in::FBNV2::CA::Santa_Clara::Cleaned';
	export Harris_newupdate 				:= cluster.Cluster_In + 'in::FBNV2::TX::Harris::Cleaned';
	export Filing_newupdate 				:= cluster.Cluster_In + 'in::FBNV2::FL::Filing::Cleaned';
	export Event_newupdate 					:= cluster.Cluster_In + 'in::FBNV2::FL::Event::Cleaned';
	

end;	