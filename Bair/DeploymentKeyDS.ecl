import pkgfile;

EXPORT DeploymentKeyDS(string clustername = '', string	version = '', boolean isFullreplace = true, boolean isdeltareplace = false) := module

	//FULL 			PS 	Keys Count - 22
	//DELTA 		PS 	Keys Count - 22
	//FULL 	NON PS 	Keys Count - 28
	//DELTA NON PS 	Keys Count - 32

	EXPORT BairPublicSafetyKeys := DATASET([	//14
			 {'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::name'    ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::name',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::meow'     			,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::meow',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::lfz'     ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::lfz',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::vin'     ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::vin',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::dln'     ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::dln',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::zip_pr'  ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::zip_pr',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::plate'   ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::plate',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::dob'     ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::dob',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::lexid'   ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::lexid',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::ssn'     ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::ssn',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::ph'      ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::ph',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::latlong' ,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::latlong',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::address'	,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::address',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys::qa::eid_hash::refs::company'	,'thor400_data::key::bair_externallinkkeys::' + version + if(isFullreplace,'','_delta') +	'::eid_hash::refs::company',isFullreplace, isdeltareplace}
			], pkgfile.layouts.flat_layouts.FileRecord);
	
	EXPORT BairPublicSafetyKeys_V2 := DATASET([	//15
			 {'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::name'    	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::name',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::meow'     			,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::meow',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::lfz'     	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::lfz',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::vin'     	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::vin',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::dln'     	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::dln',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::zip_pr'  	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::zip_pr',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::plate'   	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::plate',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::dob'     	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::dob',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::lexid'   	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::lexid',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::ssn'     	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::ssn',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::ph'      	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::ph',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::latlong' 	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::latlong',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::address'	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::address',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::refs::company'	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::refs::company',isFullreplace, isdeltareplace}
			,{'BairPublicSafetyKeys', 'thor400_data::key::bair_externallinkkeys_v2::qa::eid_hash::wordbag::lname'	,'thor400_data::key::bair_externallinkkeys_v2::' + if(isFullreplace,'20170823_163001_490105954w', version + '_delta') +	'::eid_hash::wordbag::lname',isFullreplace, isdeltareplace}
			], pkgfile.layouts.flat_layouts.FileRecord);
			
	EXPORT BairCompositeDeltaKeys := DATASET([	//8
			 {'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::mo::delta::qa::eid' 	,'thor_data400::key::bair_composite::mo::delta::' + version + '::eid',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::mo::delta::qa::phone' ,'thor_data400::key::bair_composite::mo::delta::' + version + '::phone',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::vehicle::delta::qa::wild' ,'thor_data400::key::bair_composite::vehicle::delta::' + version + '::wild',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::vehicle::delta::qa::model' ,'thor_data400::key::bair_composite::vehicle::delta::' + version + '::model',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::vehicle::delta::qa::make' ,'thor_data400::key::bair_composite::vehicle::delta::' + version + '::make',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::vehicle::delta::qa::body' ,'thor_data400::key::bair_composite::vehicle::delta::' + version + '::body',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::mo::v2::delta::qa::eid' 	,'thor_data400::key::bair_composite::mo::v2::delta::'  + version + '::eid',true}
			,{'BairCompositeDeltaKeys', 'thor_data400::key::bair_composite::mo::v2::delta::qa::phone' ,'thor_data400::key::bair_composite::mo::v2::delta::'  + version + '::phone',true}
			], pkgfile.layouts.flat_layouts.FileRecord);
	
	EXPORT BairCompositeFullKeys := DATASET([		//8
			 {'BairCompositeFullKeys', 'thor_data400::key::bair_composite::mo::qa::eid' 				 	,'thor_data400::key::bair_composite::mo::' + version + '::eid',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::mo::qa::phone' 				,'thor_data400::key::bair_composite::mo::' + version + '::phone',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::vehicle::qa::wild' 		,'thor_data400::key::bair_composite::vehicle::' + version + '::wild',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::vehicle::qa::model' 		,'thor_data400::key::bair_composite::vehicle::' + version + '::model',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::vehicle::qa::make' 		,'thor_data400::key::bair_composite::vehicle::' + version + '::make',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::vehicle::qa::body' 		,'thor_data400::key::bair_composite::vehicle::' + version + '::body',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::mo::v2::qa::eid' 			,'thor_data400::key::bair_composite::mo::v2::'  + version + '::eid',true}
			,{'BairCompositeFullKeys', 'thor_data400::key::bair_composite::mo::v2::qa::phone' 		,'thor_data400::key::bair_composite::mo::v2::'  + version + '::phone',true}
			], pkgfile.layouts.flat_layouts.FileRecord);
			
	EXPORT BairBooleanKeys := DATASET([				//12
			 {'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::ansrecx'   ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::ansrecx'   ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::dictindx3' ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::dictindx3' ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::dstatv2'   ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::dstatv2'   ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::exkeyi'    ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::exkeyi'    ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::exkeyi2'   ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::exkeyi2'   ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::exkeyo'    ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::exkeyo'    ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::exkeyo2'   ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::exkeyo2'   ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::nidx3'     ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::nidx3'     ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::xdstat2'   ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::xdstat2'   ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::xseglist'  ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::xseglist'  ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::dtldictx2' ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::dtldictx2' ,isFullreplace, isdeltareplace}
			,{'BairBooleanKeys', 'thor_data400::bair::key::frags::qa::fieldndx'  ,'thor_data400::bair::key::frags::' + version + if(isFullreplace,'','_delta') + '::fieldndx'  ,isFullreplace, isdeltareplace}
			], pkgfile.layouts.flat_layouts.FileRecord);
			
	PayloadDeltaKeys := DATASET([					//23
			 {'BairDeltaKeys', 'thor_data400::key::bair::mo::DELTA::qa::eid'               		,'thor_data400::key::bair::mo::DELTA::'           			+ version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::persons::DELTA::qa::eid'          		,'thor_data400::key::bair::persons::DELTA::'      			+ version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::vehicle::DELTA::qa::eid'          		,'thor_data400::key::bair::vehicle::DELTA::'      			+ version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::offenders::DELTA::qa::eid'        		,'thor_data400::key::bair::offenders::DELTA::'          + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::shotspotter::DELTA::qa::eid'      		,'thor_data400::key::bair::shotspotter::DELTA::'        + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::intel::DELTA::qa::eid'            		,'thor_data400::key::bair::intel::DELTA::'              + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::base::bair::images::DELTA::qa'               		,'thor_data400::base::bair::images::DELTA::'            + version          	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::images::DELTA::qa::eid'           		,'thor_data400::key::bair::images::DELTA::'             + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::base::bair::notes::DELTA::qa'                		,'thor_data400::base::bair::notes::DELTA::'             + version          	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::notes::DELTA::qa::eid'            		,'thor_data400::key::bair::notes::DELTA::'              + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::licenseplateevent::DELTA::qa::eid'		,'thor_data400::key::bair::licenseplateevent::DELTA::'  + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::geohash::DELTA::qa'               		,'thor_data400::key::bair::geohash::DELTA::'            + version          	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::group_access::qa::ori'            	 	,'thor_data400::key::bair::group_access::'   				    + version + '::ori'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::classification::qa::ori'            	,'thor_data400::key::bair::classification::' 				    + version + '::ori'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::dataprovider::qa::data_provider_id' 	,'thor_data400::key::bair::dataprovider::'   				    + version + '::data_provider_id',true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::mo_udfv2::DELTA::qa' 								,'thor_data400::key::bair::mo_udfv2::DELTA::'   			  + version 					,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::persons_udfv2::DELTA::qa' 						,'thor_data400::key::bair::persons_udfv2::DELTA::'   		+ version 					,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::crash::v2::DELTA::qa::eid'           ,'thor_data400::key::bair::crash::v2::DELTA::'          + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::crash::person::v2::DELTA::qa::eid'   ,'thor_data400::key::bair::crash::person::v2::DELTA::'  + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::crash::vehicle::v2::DELTA::qa::eid'  ,'thor_data400::key::bair::crash::vehicle::v2::DELTA::' + version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::cfs::v2::DELTA::qa::eid'  						,'thor_data400::key::bair::cfs::v2::DELTA::' 						+ version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::cfs::officer::v2::DELTA::qa::eid'  	,'thor_data400::key::bair::cfs::officer::v2::DELTA::' 	+ version + '::eid'	,true}
			,{'BairDeltaKeys', 'thor_data400::key::bair::intel::v2::DELTA::qa::eid'           ,'thor_data400::key::bair::intel::v2::DELTA::'      	  + version + '::eid'	,true}
			], pkgfile.layouts.flat_layouts.FileRecord);			

	AL := DATASET([
			 {'BairALWeeklyKeys', 'thor_data400::key::bair::agency_layers::qa::layerid'	,'thor_data400::key::bair::agency_layers::20171106::layerid' , true}
			,{'BairALWeeklyKeys', 'thor_data400::key::bair::agency_layers::qa::search'	,'thor_data400::key::bair::agency_layers::20171106::search'	, true}
			,{'BairALWeeklyKeys', 'thor_data400::base::bair::agency_layers::qa'					,'thor_data400::base::bair::agency_layers::20171106'				  , true}
			], pkgfile.layouts.flat_layouts.FileRecord);			
	
	PayloadDeltaKeysCertOnly := DATASET([], pkgfile.layouts.flat_layouts.FileRecord);	
	
	EXPORT BairPayloadDeltaKeys := if(clustername = 'bair-qa', PayloadDeltaKeys + PayloadDeltaKeysCertOnly + AL, PayloadDeltaKeys + AL);
	// EXPORT BairPayloadDeltaKeys := PayloadDeltaKeys;
	
	EXPORT BairPayloadCommonKeys := DATASET([	//1
			 {'BairNightlyWeeklyKeys', 'thor_data400::key::bair::geohash::qa'                 ,'thor_data400::key::bair::geohash::'      							+ version          	 ,true}
			// ,{'BairNightlyWeeklyKeys', 'thor_data400::key::bair::intel::v2::qa::eid'          ,'thor_data400::key::bair::intel::v2::'      					  + version + '::eid'	 ,true}
			], pkgfile.layouts.flat_layouts.FileRecord);	
	
	PayloadFullKeys := DATASET([				//20
			 {'BairWeeklyKeys', 'thor_data400::key::bair::mo::qa::eid'               	,'thor_data400::key::bair::mo::'           				+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::base::bair::images::qa'               	,'thor_data400::base::bair::images::'      				+ version          ,true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::images::qa::eid'           	,'thor_data400::key::bair::images::'       				+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::base::bair::notes::qa'                	,'thor_data400::base::bair::notes::'       				+ version          ,true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::notes::qa::eid'            	,'thor_data400::key::bair::notes::'        				+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::persons::qa::eid'          	,'thor_data400::key::bair::persons::'      				+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::vehicle::qa::eid'          	,'thor_data400::key::bair::vehicle::'      				+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::licenseplateevent::qa::eid' ,'thor_data400::key::bair::licenseplateevent::' 	+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::offenders::qa::eid'  				,'thor_data400::key::bair::offenders::'  		    	+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::shotspotter::qa::eid'       ,'thor_data400::key::bair::shotspotter::'      	 	+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::intel::qa::eid'             ,'thor_data400::key::bair::intel::'             	+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::mo_udfv2::qa' 							,'thor_data400::key::bair::mo_udfv2::'   			    + version 				 ,true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::persons_udfv2::qa' 					,'thor_data400::key::bair::persons_udfv2::'   		+ version 				 ,true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::crash::v2::qa::eid'         ,'thor_data400::key::bair::crash::v2::'           + version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::crash::person::v2::qa::eid' ,'thor_data400::key::bair::crash::person::v2::'   + version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::crash::vehicle::v2::qa::eid','thor_data400::key::bair::crash::vehicle::v2::'  + version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::cfs::v2::qa::eid'						,'thor_data400::key::bair::cfs::v2::'  						+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::cfs::officer::v2::qa::eid'	,'thor_data400::key::bair::cfs::officer::v2::'  	+ version + '::eid',true}
			,{'BairWeeklyKeys', 'thor_data400::key::bair::intel::v2::qa::eid'         ,'thor_data400::key::bair::intel::v2::'      		  + version + '::eid',true}
			], pkgfile.layouts.flat_layouts.FileRecord);	
	
	EXPORT BairPayloadFullKeys := if(clustername = 'bair-qa', PayloadFullKeys, PayloadFullKeys);
	
END;