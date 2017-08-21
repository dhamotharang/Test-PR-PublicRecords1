import ut,strata;

export out_base_dev_stats_deaths_ssa(string filedate) := function

ds_ssa			:=	header.File_Did_Death_Master_SSA;
ds_v2_ssa		:=	header.File_DID_Death_MasterV2_SSA;
ds_v3_ssa		:=	header.File_DID_Death_MasterV3_SSA;
ds_plus_ssa	:=	dataset('~thor_data400::Base::Death_Master_Plus_SSA',header.layout_death_master_plus,flat);

tStats_ssa						:=	strata.macf_pops(ds_ssa,							'state',,,,,
													TRUE,['state_death_flag','death_rec_src']);	// remove these fields from population stats											
tStats_v2_ssa					:=	strata.macf_pops(ds_v2_ssa,						'state',,,,,
													TRUE,['state_death_flag','death_rec_src']);	// remove these fields from population stats
tStats_v3_ssa					:=	strata.macf_pops(ds_v3_ssa,						'death_rec_src');
tStats_plus_ssa				:=	strata.macf_pops(ds_plus_ssa,					'state');

zOrig_Stats_ssa				:=	output(choosen(tStats_ssa,			all));
zOrig_Stats_v2_ssa		:=	output(choosen(tStats_v2_ssa,		all));
zOrig_Stats_v3_ssa		:=	output(choosen(tStats_v3_ssa,		all));
zOrig_Stats_plus_ssa	:=	output(choosen(tStats_plus_ssa,	all));

strata.createXMLStats(tStats_ssa,      'Header','Death_DID_ssa',   filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_ssa,      'View','Population')
strata.createXMLStats(tStats_v2_ssa,   'Header','Death_DID_v2_ssa',filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_v2_ssa,   'View','Population')
strata.createXMLStats(tStats_v3_ssa,   'Header','Death_DID_v3_ssa',filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_v3_ssa,   'View','Population')
strata.createXMLStats(tStats_plus_ssa, 'Header','Death_Plus_ssa',  filedate,'Kevin.Garrity@lexisnexis.com',zPopulation_Stats_plus_ssa, 'View','Population')

strata.createAsHeaderStats(header.Death_as_header(ds_v2_ssa,buildSSARestricted:=TRUE),	'Header',	'Death_ssa',	filedate,	'Kevin.Garrity@lexisnexis.com',	zAs_Header_Stats_ssa)

//Original state_death DID file doesn't get built anymore
return parallel(zOrig_Stats_ssa
                ,zOrig_Stats_v2_ssa
                ,zOrig_Stats_v3_ssa
								,zOrig_Stats_plus_ssa
								,zPopulation_Stats_ssa
								,zPopulation_Stats_v2_ssa
								,zPopulation_Stats_v3_ssa
								,zPopulation_Stats_plus_ssa
								,zAs_Header_Stats_ssa
							 );

end;					