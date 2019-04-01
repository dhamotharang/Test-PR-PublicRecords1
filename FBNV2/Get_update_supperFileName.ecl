import FBNV2 ;

export Get_Update_SupperFilename(string source)  := 


	map(source='SAN_DIEGO'=>cluster.Cluster_In + 'in::FBNV2::CA::San_diego::Cleaned',
	source='VENTURA'=>cluster.Cluster_In + 'in::FBNV2::CA::Ventura::Cleaned',
	source='ORANGE'=>cluster.Cluster_In + 'in::FBNV2::CA::orange::Cleaned',
	source='SAN_BERNARDINO'=>cluster.Cluster_In + 'in::FBNV2::CA::San_Bernardino',
	source='SANTA_CLARA'=>cluster.Cluster_In + 'in::FBNV2::CA::Santa_Clara::Cleaned',
	source='DALLAS'=>cluster.Cluster_In + 'in::FBNV2::TX::Dallas',
	source='HARRIS'=>cluster.Cluster_In + 'in::FBNV2::TX::Harris::Cleaned',
	source='FILING'=>cluster.Cluster_In + 'in::FBNV2::FL::Filing::Cleaned',
	source='EVENT'=>cluster.Cluster_In + 'in::FBNV2::FL::Event::Cleaned',
	source='NYC'=>cluster.Cluster_In + 'in::FBNV2::NYC',
	source='INFOSA'=>cluster.Cluster_In + 'in::FBNV2::InfoUSA',						
	'');
	
	