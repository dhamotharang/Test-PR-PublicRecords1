import FBNV2 ;

export Get_Update_SupperFilename(string updatetype)  := 


	map(updatetype='San_Diego'=>cluster.Cluster_In + 'in::FBNV2::CA::San_diego::Cleaned',
	updatetype='Ventura'=>cluster.Cluster_In + 'in::FBNV2::CA::Ventura::Cleaned',
	updatetype='Orange'=>cluster.Cluster_In + 'in::FBNV2::CA::orange::Cleaned',
	updatetype='San_Bernardino'=>cluster.Cluster_In + 'in::FBNV2::CA::San_Bernardino',
	updatetype='Santa_Clara'=>cluster.Cluster_In + 'in::FBNV2::CA::Santa_Clara::Cleaned',
	updatetype='Dallas'=>cluster.Cluster_In + 'in::FBNV2::TX::Dallas',
	updatetype='Harris'=>cluster.Cluster_In + 'in::FBNV2::TX::Harris::Cleaned',
	updatetype='Filing'=>cluster.Cluster_In + 'in::FBNV2::FL::Filing::Cleaned',
	updatetype='Event'=>cluster.Cluster_In + 'in::FBNV2::FL::Event::Cleaned',
	updatetype='NYC'=>cluster.Cluster_In + 'in::FBNV2::NYC',
	updatetype='InfoUSA'=>cluster.Cluster_In + 'in::FBNV2::InfoUSA',						
	'');
	
	