GetDops:=dops.GetDeployedDatasets('P','B','F');
OnlyThrive:=GetDops(datasetname='FCRA_ThriveKeys');

OnlyThrive;

filedate := '20180214';
father_filedate := '20180214z'; //OnlyThrive[1].buildversion;

set of string Key_Thrive_InputSet:=['did','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','bdid','bdid_score','did_score','orig_fname','orig_mname','orig_lname','orig_addr','orig_city','orig_state','orig_zip5','orig_zip4','email','employer','income','pay_frequency','phone_work','phone_home','phone_cell','dob','monthsemployed','own_home','is_military','drvlic_state','monthsatbank','ip','yrsthere','besttime','credit','loanamt','loantype','ratetype','mortrate','ltv','propertytype','datecollected','title','fname','mname','lname','name_suffix','nid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone_work','clean_phone_home','clean_phone_cell','clean_dob'];


CalculateStatsResults   :=  DOPSGrowthCheck.CalculateStats('FCRA_ThriveKeys','Thrive.Keys(father_filedate).Did_fcra.New','Key_Thrive','~thor_data400::key::thrive::fcra::' + filedate + '::did','did','persistent_record_id','','','','',filedate,father_filedate);	

DeltaCommandResults     :=  DOPSGrowthCheck.DeltaCommand('~thor_data400::key::thrive::fcra::' + filedate + '::did','~thor_data400::key::thrive::fcra::' + father_filedate + '::did','FCRA_ThriveKeys','Key_Thrive','Thrive.Keys(father_filedate).Did_fcra.New','persistent_record_id',filedate,father_filedate,['persistent_record_id']);

ChangesByFieldResults   :=  DOPSGrowthCheck.ChangesByField('~thor_data400::key::thrive::fcra::' + filedate + '::did','~thor_data400::key::thrive::fcra::' + father_filedate + '::did','FCRA_ThriveKeys','Key_Thrive','Thrive.Keys(father_filedate).Did_fcra.New','persistent_record_id','',filedate,father_filedate);

PersistenceCheckResults :=  DopsGrowthCheck.PersistenceCheck('~thor_data400::key::thrive::fcra::' + filedate + '::did','~thor_data400::key::thrive::fcra::' + father_filedate + '::did','FCRA_ThriveKeys','Key_Thrive','Thrive.Keys(father_filedate).Did_fcra.New','persistent_record_id',Key_Thrive_InputSet,Key_Thrive_InputSet,filedate,father_filedate);


DeltaCommands:=sequential(CalculateStatsResults,DeltaCommandResults,ChangesByFieldResults,PersistenceCheckResults);

DeltaCommands;	

