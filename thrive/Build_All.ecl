
import versioncontrol, _control, ut, tools, RoxieKeyBuild,dops,DOPSGrowthCheck;
export Build_all(string pversion, boolean pUseProd = false) := function

spray_lt  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd).lt);
spray_pd  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd).pd);

GetDops:=dops.GetDeployedDatasets('P','B','F');
OnlyThrive:=GetDops(datasetname='FCRA_ThriveKeys');

father_filedate := OnlyThrive[1].buildversion;

set of string Key_Thrive_InputSet:=['did','src','dt_vendor_first_reported','dt_vendor_last_reported','bdid','bdid_score','did_score','orig_fname','orig_mname','orig_lname','orig_addr','orig_city','orig_state','phone_work','phone_home','phone_cell','dob','is_military','drvlic_state','ip','yrsthere','fname','mname','lname','name_suffix','prim_name','addr_suffix','postdir','unit_desig','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','geo_blk','geo_match'];


CalculateStatsResults   :=  DOPSGrowthCheck.CalculateStats('FCRA_ThriveKeys','Thrive.Keys(pversion).Did_fcra.New','Key_Thrive','~thor_data400::key::thrive::fcra::' + pversion + '::did','did','persistent_record_id','','','','',pversion,father_filedate);	

DeltaCommandResults     :=  DOPSGrowthCheck.DeltaCommand('~thor_data400::key::thrive::fcra::' + pversion + '::did','~thor_data400::key::thrive::fcra::' + father_filedate + '::did','FCRA_ThriveKeys','Key_Thrive','Thrive.Keys(pversion).Did_fcra.New','persistent_record_id',pversion,father_filedate,['persistent_record_id']);

ChangesByFieldResults   :=  DOPSGrowthCheck.ChangesByField('~thor_data400::key::thrive::fcra::' + pversion + '::did','~thor_data400::key::thrive::fcra::' + father_filedate + '::did','FCRA_ThriveKeys','Key_Thrive','Thrive.Keys(pversion).Did_fcra.New','persistent_record_id','',pversion,father_filedate);

PersistenceCheckResults :=  DopsGrowthCheck.PersistenceCheck('~thor_data400::key::thrive::fcra::' + pversion + '::did','~thor_data400::key::thrive::fcra::' + father_filedate + '::did','FCRA_ThriveKeys','Key_Thrive','Thrive.Keys(pversion).Did_fcra.New','persistent_record_id',Key_Thrive_InputSet,Key_Thrive_InputSet,pversion,father_filedate);


DeltaCommands:=sequential(CalculateStatsResults,DeltaCommandResults,ChangesByFieldResults,PersistenceCheckResults);

dops_update  := sequential(RoxieKeybuild.updateversion('ThriveKeys',pversion,'angela.herzberg@lexisneis.com; Melanie.Jackson@lexisnexis.com',,'N'));

built := sequential(
					spray_lt
					,spray_pd
					,Build_Base(pversion,pUseProd).all
					,Build_Keys(pversion,pUseProd).all
					,Promote(pversion,pUseProd).buildfiles.Built2QA
			    ,Build_Strata(pversion,pUseProd).all
					//Archive processed files in history					
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputLtHistTemplate,  Filenames(pversion,pUseProd).lInputLtTemplate,,true)
					,FileServices.AddSuperFile(Filenames(pversion,pUseProd).lInputPdHistTemplate,  Filenames(pversion,pUseProd).lInputPdTemplate,,true)					
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputLtTemplate)
					,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).lInputPdTemplate)
					,FileServices.FinishSuperFileTransaction()
					,dops_update
					,DeltaCommands
				): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);


return built;
end;