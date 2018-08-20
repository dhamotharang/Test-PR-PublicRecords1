IMPORT  tools;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE


	export San_diego_raw 			:= cluster.Cluster_In + 'in::FBNV2::CA::San_diego::Sprayed';
	export Ventura_raw 				:= cluster.Cluster_In + 'in::FBNV2::CA::Ventura::Sprayed';
	export Orange_raw 				:= cluster.Cluster_In + 'in::FBNV2::CA::Orange::Sprayed';
	export San_Bernardino_raw := cluster.Cluster_In + 'in::FBNV2::CA::San_Bernardino::Sprayed';
	export Santa_Clara_raw 		:= cluster.Cluster_In + 'in::FBNV2::CA::Santa_Clara::Sprayed';
	export Dallas_raw 				:= cluster.Cluster_In + 'in::FBNV2::TX::Dallas::Sprayed';
	export Harris_raw 				:= cluster.Cluster_In + 'in::FBNV2::TX::Harris::Sprayed';
	export Filing_raw 				:= cluster.Cluster_In + 'in::FBNV2::FL::Filing::Sprayed';
	export Event_raw 					:= cluster.Cluster_In + 'in::FBNV2::FL::Event::Sprayed';
	export NYC_raw 						:= cluster.Cluster_In + 'in::FBNV2::NYC::Sprayed';
	export infoUSA_raw        := cluster.Cluster_In + 'in::FBNV2::InfoUSA::Sprayed';


	SHARED lversiondate	:= pversion;
	SHARED lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'data'	;
	SHARED lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;

	EXPORT Input	      := tools.mod_FilenamesInput(lInputRoot ,lversiondate);
	EXPORT Base		      := tools.mod_FilenamesBuild(lfileRoot  ,lversiondate);
		     
	EXPORT dAll_filenames := Base.dAll_filenames; 

END;