IMPORT ut,strata, obituaries, Death_Master;

EXPORT out_base_dev_stats_deaths(STRING filedate) := FUNCTION

ds						:=	Header.File_Did_Death_Master;
ds_v2					:=	Header.File_DID_Death_MasterV2;
ds_v3					:=	Header.File_DID_Death_MasterV3;
ds_plus				:=	DATASET('~thor_data400::Base::Death_Master_Plus',Header.layout_death_master_plus,FLAT);
ds_tributes		:=	Obituaries.files_raw_base.Tributes;
ds_obituaries	:=	Obituaries.files_raw_base.Obituary;

ds_SSA        :=	Death_Master.Files.SSA_File_Restricted;
ds_State   	  :=	Death_Master.Files.States_File;

tStats									:=	strata.macf_pops(ds,							'state',,,,,
														TRUE,['state_death_flag','death_rec_src']);	// remove these fields from population stats																		
tStats_v2								:=	strata.macf_pops(ds_v2,						'state',,,,,
														TRUE,['state_death_flag','death_rec_src']);	// remove these fields from population stats														
tStats_v3								:=	strata.macf_pops(ds_v3,						'death_rec_src');
tStats_plus							:=	strata.macf_pops(ds_plus,					'state');
tStats_tributes					:=	strata.macf_pops(ds_tributes,			'location_state');
tStats_obituaries				:=	strata.macf_pops(ds_obituaries,		'State_in',,,,,,,,,,,TRUE);
tStats_SSA					    :=	strata.macf_pops(ds_SSA,			    'state');
tStats_State				    :=	strata.macf_pops(ds_State,		    'State');

zOrig_Stats							:=	OUTPUT(CHOOSEN(tStats,						ALL));
zOrig_Stats_v2					:=	OUTPUT(CHOOSEN(tStats_v2,					ALL));
zOrig_Stats_v3					:=	OUTPUT(CHOOSEN(tStats_v3,					ALL));
zOrig_Stats_plus				:=	OUTPUT(CHOOSEN(tStats_plus,				ALL));
zOrig_Stats_tributes		:=	OUTPUT(CHOOSEN(tStats_tributes,		ALL));
zOrig_Stats_obituaries	:=	OUTPUT(CHOOSEN(tStats_obituaries,	ALL));
zOrig_Stats_SSA  		    :=	OUTPUT(CHOOSEN(tStats_SSA,	      ALL));
zOrig_Stats_State       :=	OUTPUT(CHOOSEN(tStats_State,      ALL));


STRATA.createXMLStats(tStats,						'Header','Death_DID',   		filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats,						'View','Population')
STRATA.createXMLStats(tStats_v2,				'Header','Death_DID_v2',		filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_v2,					'View','Population')
STRATA.createXMLStats(tStats_v3,				'Header','Death_DID_v3',		filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_v3,					'View','Population')
STRATA.createXMLStats(tStats_plus,			'Header','Death_Plus',			filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_plus,				'View','Population')
STRATA.createXMLStats(tStats_tributes,	'Header','TributesDeath',		filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_tributes,		'View','Population')
STRATA.createXMLStats(tStats_obituaries,'Header','ObituariesDeath',	filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_obituaries,	'View','Population')
STRATA.createXMLStats(tStats_SSA,	      'DeathMaster','SSA',		    filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_SSA,		    'View','Population')
STRATA.createXMLStats(tStats_State,     'DeathMaster','State',	    filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_State,	    'View','Population')

STRATA.createAsHeaderStats(Header.Death_as_header(ds_v2),	'Header',	'Death',	filedate,	'Kevin.Garrity@lexisnexis.com',	zAs_Header_Stats)

//Original state_death DID file doesn't get built anymore
RETURN PARALLEL(zOrig_Stats
                ,zOrig_Stats_v2
                ,zOrig_Stats_v3
								,zOrig_Stats_plus
								,zOrig_Stats_tributes 
								,zOrig_Stats_obituaries 
								,zOrig_Stats_SSA
								,zOrig_Stats_State							
								,zPopulation_Stats
								,zPopulation_Stats_v2
								,zPopulation_Stats_v3
								,zPopulation_Stats_plus
								,zPopulation_Stats_tributes
								,zPopulation_Stats_obituaries					
								,zPopulation_Stats_SSA
								,zPopulation_Stats_State								
								,zAs_Header_Stats
							 );

END;								