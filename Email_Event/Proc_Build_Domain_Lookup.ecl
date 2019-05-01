﻿IMPORT Email_DataV2,Email_Data, dx_Email, STD, PromoteSupers, RoxieKeyBuild, MDR, zz_xsheng;

EXPORT Proc_Build_Domain_Lookup(STRING version) := FUNCTION
	
	ds_bv_in       := Email_Event.Files.BV_Domain_in;
	ds_bv_delta_in := Email_Event.Files.BV_Delta_Domain_in;
	ds_email_in    := Email_Event.Files.Email_Domain_in;
	
	//Append to base file
	ds_base := Email_Event.Files.Domain_lkp;
	
	CombineAll   := ds_base /*+ ds_email_in + ds_bv_in */+ ds_bv_delta_in;
	ds_sort := SORT(CombineAll,domain_name, -date_last_seen);

  // Rollup 
  dx_email.Layouts.i_Domain_lkp Xform(ds_sort L,ds_sort R) := TRANSFORM
		SELF.Domain_status := MAP(TRIM(L.domain_status) IN ['INVALID','VALID'] => L.domain_status,
		                          TRIM(L.domain_status) = 'UNKNOWN' AND TRIM(R.domain_status) IN ['INVALID','VALID'] => R.domain_status,
															TRIM(L.domain_status));
		SELF := L;
	END;
	
  dBase_rollup := ROLLUP(ds_sort,
								  	trim(LEFT.domain_name) = trim(RIGHT.domain_name),
									  Xform(LEFT,RIGHT));

	//Build base file	
	PromoteSupers.Mac_SF_BuildProcess(dBase_rollup,'~thor_data400::base::email_dataV2::Domain_lkp', build_table,3,,true);
	
	
	//Build Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_domain_lkp,																
																						Email_Event.Files.Domain_lkp(domain_name != ''),												
																						'~thor_data400::key::email_dataV2::@version@::Domain_lkp', 					 
																						'~thor_data400::key::email_dataV2::'+(string) version+'::Domain_lkp',      
																						domain_key);
																						
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::email_dataV2::@version@::Domain_lkp'
																			,'~thor_data400::key::email_dataV2::'+(string) version+'::Domain_lkp'
																			,mv_domain_key);
																			
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::email_dataV2::@version@::Domain_lkp', 'Q', mv_domain_key_qa);
	
	build_key := sequential(domain_key, mv_domain_key, mv_domain_key_qa);
	
	// zDoPopulationStats	:=	Strata_Stat_domain(version,Files.Domain_lkp);

	// dops_update :=  DOPS.updateversion('EmailDataV2DomainKeys',(string)version,emailList,,'N');

	// orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem ('Email Data V2 Domain',(string)version,'N');

	RETURN SEQUENTIAL(
	                  // Email_Event.SprayBVdeltaFile(version),
	                  Email_Event.Map_BV_Delta_Domain_Lookup(version),
	                  // Email_Event.Map_BV_Domain_Lookup,
										// Email_Event.Map_Email_Domain_Lookup,
										build_table,
										build_key
										// zDoPopulationStats,
										// dops_update,
										// orbit_update
										);	
	
END;