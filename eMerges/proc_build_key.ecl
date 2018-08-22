import ut,roxiekeybuild, doxie_files,dops,DOPSGrowthCheck;


export proc_build_key(string filedate) := function
	SuperKeyName 					:= cluster.cluster_out+'key::hunting_fishing::';
	SuperKeyName_fcra			:= cluster.cluster_out+'key::hunting_fishing::fcra::';
	SuperKeyName_CCW 			:= cluster.cluster_out+'key::ccw::';
	SuperKeyName_CCW_fcra := cluster.cluster_out+'key::ccw::fcra::';
	BaseKeyName  					:= SuperKeyName+filedate;
	BaseKeyName_fcra			:= SuperKeyName_fcra+filedate;	
	BaseKeyName_CCW 			:= SuperKeyName_CCW+filedate;
	BaseKeyName_CCW_fcra	:= SuperKeyName_CCW_fcra+filedate;
	
	pre := sequential(
			fileservices.startsuperfiletransaction(),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::emerges_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::emerges_BUILDING','~thor_data400::base::emerges_hunt_vote_ccw',0,true)),
			fileservices.finishsuperfiletransaction()
			);

	a := emerges.make_hvc_output(filedate);

	pre2 := sequential(
			fileservices.startsuperfiletransaction(),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::emerges_hunt_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::emerges_hunt_BUILDING','~thor_data400::base::emerges_hunt',0,true)),
			if (fileservices.getsuperfilesubcount('~thor_Data400::base::emerges_ccw_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				fileservices.addsuperfile('~thor_Data400::base::emerges_ccw_BUILDING','~thor_data400::base::emerges_ccw',0,true)),
			fileservices.finishsuperfiletransaction()
			);
			
	Roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_hunters_did(),'~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did','~thor_Data400::key::hunters_doxie_did',key1);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_did(),SuperKeyName+'did',BaseKeyName+'::did',key2);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_rid(),SuperKeyName+'rid',BaseKeyName+'::rid',key3);
	roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_ccw_did(),'~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did','~thor_Data400::key::ccw_doxie_did',key4);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_did(),SuperKeyName_CCW+'did',BaseKeyName_CCW+'::did',key5);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_rid(),SuperKeyName_CCW+'rid',BaseKeyName_CCW+'::rid',key6);
	
	Roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did','~thor_Data400::key::hunters_doxie_did',mv1);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',BaseKeyName+'::did',mv2,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::rid',BaseKeyName+'::rid',mv3,2);
	roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did','~thor_Data400::key::ccw_doxie_did',mv4);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW+'@version@::did',BaseKeyName_CCW+'::did',mv5,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW+'@version@::rid',BaseKeyName_CCW+'::rid',mv6,2);
	
	// Build FCRA keys
	Roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_hunters_did(true),'~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did_fcra','~thor_Data400::key::hunters_doxie_did_fcra',key1_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_did(true),SuperKeyName_fcra+'did',BaseKeyName_fcra+'::did',key2_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.Key_huntfish_rid(true),SuperKeyName_fcra+'rid',BaseKeyName_fcra+'::rid',key3_fcra);
	roxiekeybuild.MAC_SK_BuildProcess_Local(doxie_files.key_ccw_did(true),'~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did_fcra','~thor_Data400::key::ccw_doxie_did_fcra',key4_fcra);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_did(true),SuperKeyName_CCW_fcra+'did',BaseKeyName_CCW_fcra+'::did',key5_fcra);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(emerges.key_ccw_rid(true),SuperKeyName_CCW_fcra+'rid',BaseKeyName_CCW_fcra+'::rid',key6_fcra);
	
	// Move FCRA keys
	Roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::hunters_doxie_did_fcra','~thor_Data400::key::hunters_doxie_did_fcra',mv1_fcra);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_fcra+'@version@::did',BaseKeyName_fcra+'::did',mv2_fcra,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_fcra+'@version@::rid',BaseKeyName_fcra+'::rid',mv3_fcra,2);	
	Roxiekeybuild.MAC_SK_Move_To_Built('~thor_Data400::key::emerges::'+filedate+'::ccw_doxie_did_fcra','~thor_Data400::key::ccw_doxie_did_fcra',mv4_fcra);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW_fcra+'@version@::did',BaseKeyName_CCW_fcra+'::did',mv5_fcra,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName_CCW_fcra+'@version@::rid',BaseKeyName_CCW_fcra+'::rid',mv6_fcra,2);
	

	RoxieKeyBuild.Mac_Daily_Email_Local('EMERGES','SUCC',filedate,send_succ_msg,emerges.Spray_Notification_Email_Address);
	RoxieKeyBuild.Mac_Daily_Email_Local('EMERGES','FAIL',filedate,send_fail_msg,'kgummadi@seisint.com;fhumayun@seisint.com');

	move_qa := eMerges.proc_accept_sk_to_QA;
	
	build_huntfish_autokeys 			:= emerges.Proc_HuntFish_AutokeyBuild(filedate);
	build_huntfish_autokeys_fcra	:= emerges.Proc_HuntFish_AutokeyBuild_fcra(filedate);	
  build_CCW_autokeys						:= emerges.Proc_CCW_AutokeyBuild(filedate);
	build_CCW_autokeys_fcra				:= emerges.Proc_CCW_AutokeyBuild_fcra(filedate);
	
	update_dops := roxiekeybuild.updateversion('EmergesKeys',filedate,'kgummadi@seisint.com;fhumayun@seisint.com',,'N');
  update_dops_fcra := roxiekeybuild.updateversion('FCRA_EmergesKeys',filedate,'kgummadi@seisint.com;fhumayun@seisint.com',,'F');
	
	build_roxie_keys := 
	  if (fileservices.getsuperfilesubname('~thor_data400::base::emerges_hunt_vote_ccw',1) = fileservices.getsuperfilesubname('~thor_data400::base::emerges_BUILT',1),
				output('BASE = BUILT, Nothing done.'),
				sequential(pre,a,pre2,
									 parallel(key1,key2,key3,key4,key5,key6),
									 parallel(mv1,mv2,mv3,mv4,mv5,mv6),				
									 parallel(key1_fcra,key2_fcra,key3_fcra,key4_fcra,key5_fcra,key6_fcra),
									 // parallel(key4_fcra,key5_fcra,key6_fcra),
									 parallel(mv1_fcra,mv2_fcra,mv3_fcra,mv4_fcra,mv5_fcra,mv6_fcra),
									 // parallel(mv4_fcra,mv5_fcra,mv6_fcra),
									 move_qa,
									 build_huntfish_autokeys,
									 build_huntfish_autokeys_fcra,
									 build_ccw_autokeys,
									 build_ccw_autokeys_fcra,
									 update_dops,
                   update_dops_fcra                   
									 )) : success(send_succ_msg), failure(send_fail_msg);

	// build_moxie_keys := emerges.proc_build_all_moxie_keys : success(output('moxie keys build completed')), failure(output('moxie key build failed'));

	post_build := sequential(
													fileservices.startsuperfiletransaction(),
													fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_BUILT'),
													fileservices.addsuperfile('~thor_data400::base::emerges_hunt_BUILT','~thor_data400::base::emerges_hunt_BUILDING',0,true),
													fileservices.clearsuperfile('~thor_Data400::base::emerges_hunt_BUILDING'),
													fileservices.clearsuperfile('~thor_data400::base::emerges_ccw_BUILT'),
													fileservices.addsuperfile('~thor_data400::base::emerges_ccw_BUILT','~thor_data400::base::emerges_ccw_BUILDING',0,true),
													fileservices.clearsuperfile('~thor_Data400::base::emerges_ccw_BUILDING'),
													fileservices.clearsuperfile('~thor_data400::base::emerges_BUILT'),
													fileservices.addsuperfile('~thor_data400::base::emerges_BUILT','~thor_data400::base::emerges_BUILDING',0,true),
													fileservices.clearsuperfile('~thor_Data400::base::emerges_BUILDING'),
													fileservices.finishsuperfiletransaction()
													);	
GetDops := dops.GetDeployedDatasets('P', 'B', 'F');
OnlyEmerges:=GetDops(datasetname='FCRA_EmergesKeys');
father_filedate := OnlyEmerges[1].buildversion;																
set of string InputSet_CCW := ['date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','ccwpermnum','ccwweapontype','ccwregdate','ccwexpdate','ccwpermtype','ccwfill1','ccwfill2','ccwfill3','ccwfill4','miscfill1','miscfill2','miscfill3','miscfill4','miscfill5','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat'];
set of string InputSet_Hunt := ['date_first_seen','date_last_seen','score','best_ssn','did_out','source','file_id','vendor_id','source_state','source_code','file_acquired_date','_use','title_in','lname_in','fname_in','mname_in','maiden_prior','name_suffix_in','votefiller','source_voterid','dob','agecat','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','gender','poliparty','phone','work_phone','other_phone','active_status','votefiller2','active_other','voterstatus','resaddr1','resaddr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','historyfiller','huntfishperm','license_type_mapped','datelicense','homestate','resident','nonresident','hunt','fish','combosuper','sportsman','trap','archery','muzzle','drawing','day1','day3','day7','day14to15','dayfiller','seasonannual','lifetimepermit','landowner','family','junior','seniorcit','crewmemeber','retarded','indian','serviceman','disabled','lowincome','regioncounty','blind','huntfiller','salmon','freshwater','saltwater','lakesandresevoirs','setlinefish','trout','fallfishing','steelhead','whitejubherring','sturgeon','shellfishcrab','shellfishlobster','deer','bear','elk','moose','buffalo','antelope','sikebull','bighorn','javelina','cougar','anterless','pheasant','goose','duck','turkey','snowmobile','biggame','skipass','migbird','smallgame','sturgeon2','gun','bonus','lottery','otherbirds','huntfill1','title','fname','mname','lname','name_suffix','score_on_input','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','record_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_record_type','mail_ace_fips_st','mail_fipscounty','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat'];
set of string Persistent_ID_Hun_CCW := ['vendor_id','source_state','source_code','file_acquired_date','_use','title','lname','fname','mname','maiden_prior','name_suffix','dob_str','AgeCat','HeadHousehold','place_of_birth','occupation','regSource','RegDate','race','gender','Phone','Work_Phone','active_status','ResAddr1','ResAddr2','Res_city','Res_state','Res_zip','Res_county','Mail_Addr1','Mail_Addr2','mail_city','mail_state','mail_zip','mail_county','cass_fipscounty','ContributorParty','recptparty','dateofcontr','DollarAmt','officecontto','cumuldollaramt','ContFiller1','ContFiller2','ContType','ContFiller3','HuntFishPerm','DateLicense','HomeState','Resident','NonResident','Hunt','Fish','ComboSuper','Sportsman','Trap','Archery','Muzzle','Drawing','Day1','Day3','Day7','Day14to15','DayFiller','SeasonAnnual','LifeTimePermit','LandOwner','Family','Junior','SeniorCit','CrewMemeber','Retarded','Indian','Serviceman','Disabled','LowIncome','RegionCounty','Blind','HuntFiller','Salmon','Freshwater','Saltwater','LakesandResevoirs','Trout','FallFishing','SteelHead','WhiteJubHerring','Sturgeon','ShellfishCrab','ShellfishLobster','Deer','Bear','Elk','Moose','Buffalo','Antelope','SikeBull','bighorn','Javelina','Cougar','Anterless','Pheasant','Goose','Duck','Turkey','Snowmobile','BigGame','MigBird','SmallGame','Sturgeon2','Gun','Bonus','Lottery','OtherBirds','huntfill1','BoatIndexNum','BoatCoOwner','lengt','hullconstruct','RegExpDate','BoatFill3','CCWPermNum','CCWWeaponType','CCWRegDate','ccwexpdate','CCWPermType','MiscFill5','FillerOther1','FillerOther2','FillerOther4'];	
DeltaCommands:=sequential(
DOPSGrowthCheck.CalculateStats('FCRA_EmergesKeys','emerges.key_ccw_rid(true)', 'key_EmergesCCW_FCRA','~thor_data400::key::ccw::fcra::'+filedate+'::rid','rid,persistent_record_id','persistent_record_id','','phone','best_ssn','',filedate,father_filedate),DOPSGrowthCheck.CalculateStats('FCRA_EmergesKeys','emerges.Key_HuntFish_Rid(true)','key_HuntFish_FCRA','~thor_data400::key::hunting_fishing::fcra::'+filedate+'::rid','rid,persistent_record_id','persistent_record_id','','phone','best_ssn','',filedate,father_filedate),
DOPSGrowthCheck.DeltaCommand('~thor_data400::key::ccw::fcra::'+filedate+'::rid', '~thor_data400::key::ccw::fcra::'+father_filedate+'::rid', 'FCRA_EmergesKeys', 'key_EmergesCCW_FCRA', 'emerges.key_ccw_rid(true)', 'persistent_record_id', filedate, father_filedate, InputSet_CCW),DOPSGrowthCheck.DeltaCommand('~thor_data400::key::hunting_fishing::fcra::'+filedate+'::rid', '~thor_data400::key::hunting_fishing::fcra::'+father_filedate+'::rid', 'FCRA_EmergesKeys', 'key_HuntFish_FCRA', 'emerges.Key_HuntFish_Rid(true)', 'persistent_record_id', filedate, father_filedate, InputSet_Hunt),
DOPSGrowthCheck.ChangesByField('~thor_data400::key::ccw::fcra::'+filedate+'::rid','~thor_data400::key::ccw::fcra::'+father_filedate+'::rid','FCRA_EmergesKeys','key_EmergesCCW_FCRA','emerges.key_ccw_rid(true)','persistent_record_id','',filedate,father_filedate),DOPSGrowthCheck.ChangesByField('~thor_data400::key::hunting_fishing::fcra::'+filedate+'::rid', '~thor_data400::key::hunting_fishing::fcra::'+father_filedate+'::rid', 'FCRA_EmergesKeys','key_HuntFish_FCRA','emerges.Key_HuntFish_Rid(true)', 'persistent_record_id','',filedate,father_filedate),
DOPSGrowthCheck.PersistenceCheck('~thor_data400::base::emerges_hunt_vote_ccw',  '~thor_data400::base::emerges_hunt_vote_ccw_father',  'FCRA_EmergesKeys',  'key_EmergesCCW_FCRA',  'emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout',  'persistent_record_id',  Persistent_ID_Hun_CCW,  Persistent_ID_Hun_CCW,  filedate,  father_filedate,  ,  false),DOPSGrowthCheck.PersistenceCheck('~thor_data400::base::emerges_hunt_vote_ccw',  '~thor_data400::base::emerges_hunt_vote_ccw_father',  'FCRA_EmergesKeys',  'key_HuntFish_FCRA',  'emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout',  'persistent_record_id',  Persistent_ID_Hun_CCW,  Persistent_ID_Hun_CCW,  filedate,  father_filedate,  ,  false)
);
												
	return sequential(build_roxie_keys,
										// build_moxie_keys,
										post_build,
										DeltaCommands);
	
end;