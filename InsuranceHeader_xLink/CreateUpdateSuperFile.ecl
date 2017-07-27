IMPORT STD;
EXPORT createUpdateSuperFile(string buildType='') := MODULE
	// build type here should be full, inc or '''
  EXPORT createSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
			// xIDL super files for header
			IF( NOT fileservices.superfileexists(KeyNames().header_super), 
						fileservices.createsuperfile(KeyNames().header_super)),		
			IF( NOT fileservices.superfileexists(KeyNames().header0_super), 
						fileservices.createsuperfile(KeyNames().header0_super)),		
			// xIDL super files for linked path
			IF( NOT fileservices.superfileexists(KeyNames().name_super), 
							fileservices.createsuperfile(KeyNames().name_super)),
			IF( NOT fileservices.superfileexists(KeyNames().address_super), 
							fileservices.createsuperfile(KeyNames().address_super)),
			IF( NOT fileservices.superfileexists(KeyNames().ssn_super), 
							fileservices.createsuperfile(KeyNames().ssn_super)),
			IF( NOT fileservices.superfileexists(KeyNames().ssn4_super), 
							fileservices.createsuperfile(KeyNames().ssn4_super)),
			IF( NOT fileservices.superfileexists(KeyNames().dob_super), 
							fileservices.createsuperfile(KeyNames().dob_super)),
			IF( NOT fileservices.superfileexists(KeyNames().zip_pr_super), 
							fileservices.createsuperfile(KeyNames().zip_pr_super)),
			IF( NOT fileservices.superfileexists(KeyNames().src_rid_super), 
							fileservices.createsuperfile(KeyNames().src_rid_super)),
			IF( NOT fileservices.superfileexists(KeyNames().dln_super), 
							fileservices.createsuperfile(KeyNames().dln_super)),
			IF( NOT fileservices.superfileexists(KeyNames().id_history_super),
							fileservices.createsuperfile(KeyNames().id_history_super)),
			// IF( NOT fileservices.superfileexists(KeyNames().rid_super), 
							// fileservices.createsuperfile(KeyNames().rid_super)),
			IF( NOT fileservices.superfileexists(KeyNames().ph_super), 
							fileservices.createsuperfile(KeyNames().ph_super)),
			IF( NOT fileservices.superfileexists(KeyNames().lfz_super), 
							fileservices.createsuperfile(KeyNames().lfz_super)),												
			IF( NOT fileservices.superfileexists(KeyNames().relative_super), 
							fileservices.createsuperfile(KeyNames().relative_super)),								
											);	
		RETURN superFiles;
	END;
	
	EXPORT createSpcSuperFiles() := FUNCTION
		RETURN PARALLEL(
										IF(~STD.File.SuperfileExists(KeyNames().sname_spc_super),STD.File.CreateSuperfile(KeyNames().sname_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().sname_spc_father),STD.File.CreateSuperfile(KeyNames().sname_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().fname_spc_super),STD.File.CreateSuperfile(KeyNames().fname_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().fname_spc_father),STD.File.CreateSuperfile(KeyNames().fname_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().mname_spc_super),STD.File.CreateSuperfile(KeyNames().mname_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().mname_spc_father),STD.File.CreateSuperfile(KeyNames().mname_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().lname_spc_super),STD.File.CreateSuperfile(KeyNames().lname_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().lname_spc_father),STD.File.CreateSuperfile(KeyNames().lname_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().derived_gender_spc_super),STD.File.CreateSuperfile(KeyNames().derived_gender_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().derived_gender_spc_father),STD.File.CreateSuperfile(KeyNames().derived_gender_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().prim_range_spc_super),STD.File.CreateSuperfile(KeyNames().prim_range_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().prim_range_spc_father),STD.File.CreateSuperfile(KeyNames().prim_range_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().prim_name_spc_super),STD.File.CreateSuperfile(KeyNames().prim_name_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().prim_name_spc_father),STD.File.CreateSuperfile(KeyNames().prim_name_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().sec_range_spc_super),STD.File.CreateSuperfile(KeyNames().sec_range_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().sec_range_spc_father),STD.File.CreateSuperfile(KeyNames().sec_range_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().city_spc_super),STD.File.CreateSuperfile(KeyNames().city_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().city_spc_father),STD.File.CreateSuperfile(KeyNames().city_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().st_spc_super),STD.File.CreateSuperfile(KeyNames().st_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().st_spc_father),STD.File.CreateSuperfile(KeyNames().st_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().zip_spc_super),STD.File.CreateSuperfile(KeyNames().zip_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().zip_spc_father),STD.File.CreateSuperfile(KeyNames().zip_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().ssn5_spc_super),STD.File.CreateSuperfile(KeyNames().ssn5_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().ssn5_spc_father),STD.File.CreateSuperfile(KeyNames().ssn5_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().ssn4_spc_super),STD.File.CreateSuperfile(KeyNames().ssn4_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().ssn4_spc_father),STD.File.CreateSuperfile(KeyNames().ssn4_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().dob_year_spc_super),STD.File.CreateSuperfile(KeyNames().dob_year_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().dob_year_spc_father),STD.File.CreateSuperfile(KeyNames().dob_year_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().dob_month_spc_super),STD.File.CreateSuperfile(KeyNames().dob_month_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().dob_month_spc_father),STD.File.CreateSuperfile(KeyNames().dob_month_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().dob_day_spc_super),STD.File.CreateSuperfile(KeyNames().dob_day_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().dob_day_spc_father),STD.File.CreateSuperfile(KeyNames().dob_day_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().phone_spc_super),STD.File.CreateSuperfile(KeyNames().phone_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().phone_spc_father),STD.File.CreateSuperfile(KeyNames().phone_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().dl_state_spc_super),STD.File.CreateSuperfile(KeyNames().dl_state_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().dl_state_spc_father),STD.File.CreateSuperfile(KeyNames().dl_state_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().dl_nbr_spc_super),STD.File.CreateSuperfile(KeyNames().dl_nbr_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().dl_nbr_spc_father),STD.File.CreateSuperfile(KeyNames().dl_nbr_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().src_spc_super),STD.File.CreateSuperfile(KeyNames().src_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().src_spc_father),STD.File.CreateSuperfile(KeyNames().src_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().source_rid_spc_super),STD.File.CreateSuperfile(KeyNames().source_rid_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().source_rid_spc_father),STD.File.CreateSuperfile(KeyNames().source_rid_spc_father)),
										// IF(~STD.File.SuperfileExists(KeyNames().rid_spc_super),STD.File.CreateSuperfile(KeyNames().rid_spc_super)),
										// IF(~STD.File.SuperfileExists(KeyNames().rid_spc_father),STD.File.CreateSuperfile(KeyNames().rid_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().mainname_spc_super),STD.File.CreateSuperfile(KeyNames().mainname_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().mainname_spc_father),STD.File.CreateSuperfile(KeyNames().mainname_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().fullname_spc_super),STD.File.CreateSuperfile(KeyNames().fullname_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().fullname_spc_father),STD.File.CreateSuperfile(KeyNames().fullname_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().addr1_spc_super),STD.File.CreateSuperfile(KeyNames().addr1_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().addr1_spc_father),STD.File.CreateSuperfile(KeyNames().addr1_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().locale_spc_super),STD.File.CreateSuperfile(KeyNames().locale_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().locale_spc_father),STD.File.CreateSuperfile(KeyNames().locale_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().address_spc_super),STD.File.CreateSuperfile(KeyNames().address_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().address_spc_father),STD.File.CreateSuperfile(KeyNames().address_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().main_spc_super),STD.File.CreateSuperfile(KeyNames().main_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().main_spc_father),STD.File.CreateSuperfile(KeyNames().main_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().res_spc_super),STD.File.CreateSuperfile(KeyNames().res_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().res_spc_father),STD.File.CreateSuperfile(KeyNames().res_spc_father)),
										IF(~STD.File.SuperfileExists(KeyNames().res_spc_super),STD.File.CreateSuperfile(KeyNames().dt_first_seen_spc_super)),
										IF(~STD.File.SuperfileExists(KeyNames().res_spc_father),STD.File.CreateSuperfile(KeyNames().dt_last_seen_spc_father))
										);
	END;
	
	/*-------------------- updatexIDLSuperFiles ----------------------------------------------------*/
	EXPORT updatexIDLSuperFile(string baseSuperFile, string fatherSuperFile, string inFile) := FUNCTION
		action := Sequential(
								STD.File.PromoteSuperFileList([baseSuperFile, fatherSuperFile], inFile, true)
							);
		return action;
	END;
	
	// fullFile := Constants.FULL_BUILD;
	fullFile := '';
	/*-------------------- updateAllxIDLSuperFiles ----------------------------------------------------*/
	t1 := updatexIDLSuperFile(KeyNames(fullFile).header_super,			KeyNames(fullFile).header_father,			KeyNames(fullFile).header_logical);	
	t2 := updatexIDLSuperFile(KeyNames(fullFile).name_super,				KeyNames(fullFile).name_father,				KeyNames(fullFile).name_logical);
	t3 := updatexIDLSuperFile(KeyNames(fullFile).address_super,			KeyNames(fullFile).address_father,		KeyNames(fullFile).address_logical);
	t4 := updatexIDLSuperFile(KeyNames(fullFile).ssn_super,					KeyNames(fullFile).ssn_father,				KeyNames(fullFile).ssn_logical);
	t5 := updatexIDLSuperFile(KeyNames(fullFile).ssn4_super,				KeyNames(fullFile).ssn4_father,				KeyNames(fullFile).ssn4_logical);
	t6 := updatexIDLSuperFile(KeyNames(fullFile).dob_super,					KeyNames(fullFile).dob_father,				KeyNames(fullFile).dob_logical);
	t7 := updatexIDLSuperFile(KeyNames(fullFile).zip_pr_super,			KeyNames(fullFile).zip_pr_father,			KeyNames(fullFile).zip_pr_logical);
	t8 := updatexIDLSuperFile(KeyNames(fullFile).src_rid_super,			KeyNames(fullFile).src_rid_father,		KeyNames(fullFile).src_rid_logical);
	t9 := updatexIDLSuperFile(KeyNames(fullFile).dln_super,					KeyNames(fullFile).dln_father,				KeyNames(fullFile).dln_logical);
	// t10:= updatexIDLSuperFile(KeyNames(fullFile).rid_super,			KeyNames(fullFile).rid_father,				KeyNames(fullFile).rid_logical);
	t11 := updatexIDLSuperFile(KeyNames(fullFile).ph_super,					KeyNames(fullFile).ph_father,					KeyNames(fullFile).ph_logical);
	t12:= updatexIDLSuperFile(KeyNames(fullFile).lfz_super,					KeyNames(fullFile).lfz_father,				KeyNames(fullFile).lfz_logical);
	t13:= updatexIDLSuperFile(KeyNames(fullFile).relative_super,		KeyNames(fullFile).relative_father,		KeyNames(fullFile).relative_logical);
	t14 := updatexIDLSuperFile(KeyNames(fullFile).header0_super,		KeyNames(fullFile).header0_father,		KeyNames(fullFile).header0_logical);	
	t15 := updatexIDLSuperFile(KeyNames(fullFile).id_history_super,	KeyNames(fullFile).id_history_father,	KeyNames(fullFile).id_history_logical);	
	
	export updateFullFileSP := sequential( 
	 // t1, 
	 t2, t3, t4, t5, t6, t7, //t8, 
	 t9, 
	 t11, t12, t13 //, 
	// t14, t15
	);
	
	incFile := '';
	/*---------------------------- add Incremental files to superfiles ----------------------------*/
	a1 := STD.File.AddSuperFile(KeyNames(incFile).header_super,			KeyNames().header_logical);	
	a2 := STD.File.AddSuperFile(KeyNames(incFile).name_super,				KeyNames().name_logical);
	a3 := STD.File.AddSuperFile(KeyNames(incFile).address_super,		KeyNames().address_logical);
	a4 := STD.File.AddSuperFile(KeyNames(incFile).ssn_super,				KeyNames().ssn_logical);
	a5 := STD.File.AddSuperFile(KeyNames(incFile).ssn4_super,				KeyNames().ssn4_logical);
	a6 := STD.File.AddSuperFile(KeyNames(incFile).dob_super,				KeyNames().dob_logical);
	a7 := STD.File.AddSuperFile(KeyNames(incFile).zip_pr_super,			KeyNames().zip_pr_logical);
	a8 := STD.File.AddSuperFile(KeyNames(incFile).src_rid_super,		KeyNames().src_rid_logical);
	a9 := STD.File.AddSuperFile(KeyNames(incFile).dln_super,				KeyNames().dln_logical);
	// a10:= STD.File.AddSuperFile(KeyNames().rid_super,						KeyNames().rid_logical);
	a11 := STD.File.AddSuperFile(KeyNames(incFile).ph_super,				KeyNames().ph_logical);
	a12:= STD.File.AddSuperFile(KeyNames(incFile).lfz_super,				KeyNames().lfz_logical);
	a13:= STD.File.AddSuperFile(KeyNames(incFile).relative_super,		KeyNames().relative_logical);
	a14 := STD.File.AddSuperFile(KeyNames(incFile).header0_super,		KeyNames().header0_logical);	
	a15 := STD.File.AddSuperFile(KeyNames(incFile).id_history_super,KeyNames().id_history_logical);	
	
	export addAllSF := sequential(a1, 
	a2, a3, a4, a5, a6, a7, a8, a9, a11, a12, a13, a14, a15);
	
	/*-------------------- updateAllCustTestxIDLSuperFiles ----------------------------------------------------*/
	export updateAllCustTestSF(STRING fileVersion) := FUNCTION
		CustKeyNames := custTest_Files(fileVersion);
		c1 := updatexIDLSuperFile(CustKeyNames.header_super,	CustKeyNames.header_father,		CustKeyNames.header_logical);
		c2 := updatexIDLSuperFile(CustKeyNames.name_super,		CustKeyNames.name_father,			CustKeyNames.name_logical);
		c3 := updatexIDLSuperFile(CustKeyNames.address_super,	CustKeyNames.address_father,	CustKeyNames.address_logical);
		c4 := updatexIDLSuperFile(CustKeyNames.ssn_super,			CustKeyNames.ssn_father,			CustKeyNames.ssn_logical);
		c5 := updatexIDLSuperFile(CustKeyNames.ssn4_super,		CustKeyNames.ssn4_father,			CustKeyNames.ssn4_logical);
		c6 := updatexIDLSuperFile(CustKeyNames.dob_super,			CustKeyNames.dob_father,			CustKeyNames.dob_logical);
		c7 := updatexIDLSuperFile(CustKeyNames.zip_pr_super,	CustKeyNames.zip_pr_father,		CustKeyNames.zip_pr_logical);		
		c8 := updatexIDLSuperFile(CustKeyNames.dln_super,			CustKeyNames.dln_father,			CustKeyNames.dln_logical);
		c9:= updatexIDLSuperFile(CustKeyNames.rid_super,			CustKeyNames.rid_father,			CustKeyNames.rid_logical);
		c10:= updatexIDLSuperFile(CustKeyNames.ph_super,			CustKeyNames.ph_father,				CustKeyNames.ph_logical);
		c11:= updatexIDLSuperFile(CustKeyNames.lfz_super,			CustKeyNames.lfz_father,			CustKeyNames.lfz_logical);
		c12:= updatexIDLSuperFile(CustKeyNames.relative_super,CustKeyNames.relative_father,	CustKeyNames.relative_logical);
		c13:= updatexIDLSuperFile(CustKeyNames.seg_super,			CustKeyNames.seg_father,			CustKeyNames.seg_logical);		
		
		RETURN sequential(c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13);	
	END;
	
	/*-------------------- updateSpecificitiesSuperFiles ----------------------------------------------------*/
	SHARED spc1 := updatexIDLSuperFile(KeyNames().sname_spc_super, KeyNames().sname_spc_father, KeyNames().sname_spc_logical);
	SHARED spc2 := updatexIDLSuperFile(KeyNames().fname_spc_super, KeyNames().fname_spc_father, KeyNames().fname_spc_logical);
	SHARED spc3 := updatexIDLSuperFile(KeyNames().mname_spc_super, KeyNames().mname_spc_father, KeyNames().mname_spc_logical);
	SHARED spc4 := updatexIDLSuperFile(KeyNames().lname_spc_super, KeyNames().lname_spc_father, KeyNames().lname_spc_logical);
	SHARED spc5 := updatexIDLSuperFile(KeyNames().derived_gender_spc_super, KeyNames().derived_gender_spc_father, KeyNames().derived_gender_spc_logical);
	SHARED spc6 := updatexIDLSuperFile(KeyNames().prim_range_spc_super, KeyNames().prim_range_spc_father, KeyNames().prim_range_spc_logical);
	SHARED spc7 := updatexIDLSuperFile(KeyNames().prim_name_spc_super, KeyNames().prim_name_spc_father, KeyNames().prim_name_spc_logical);
	SHARED spc8 := updatexIDLSuperFile(KeyNames().sec_range_spc_super, KeyNames().sec_range_spc_father, KeyNames().sec_range_spc_logical);
	SHARED spc9 := updatexIDLSuperFile(KeyNames().city_spc_super, KeyNames().city_spc_father, KeyNames().city_spc_logical);
	SHARED spc10 := updatexIDLSuperFile(KeyNames().st_spc_super, KeyNames().st_spc_father, KeyNames().st_spc_logical);
	SHARED spc11 := updatexIDLSuperFile(KeyNames().zip_spc_super, KeyNames().zip_spc_father, KeyNames().zip_spc_logical);
	SHARED spc12 := updatexIDLSuperFile(KeyNames().ssn5_spc_super, KeyNames().ssn5_spc_father, KeyNames().ssn5_spc_logical);
	SHARED spc13 := updatexIDLSuperFile(KeyNames().ssn4_spc_super, KeyNames().ssn4_spc_father, KeyNames().ssn4_spc_logical);
	SHARED spc14 := updatexIDLSuperFile(KeyNames().dob_year_spc_super, KeyNames().dob_year_spc_father, KeyNames().dob_year_spc_logical);
	SHARED spc15 := updatexIDLSuperFile(KeyNames().dob_month_spc_super, KeyNames().dob_month_spc_father, KeyNames().dob_month_spc_logical);
	SHARED spc16 := updatexIDLSuperFile(KeyNames().dob_day_spc_super, KeyNames().dob_day_spc_father, KeyNames().dob_day_spc_logical);
	SHARED spc17 := updatexIDLSuperFile(KeyNames().phone_spc_super, KeyNames().phone_spc_father, KeyNames().phone_spc_logical);
	SHARED spc18 := updatexIDLSuperFile(KeyNames().dl_state_spc_super, KeyNames().dl_state_spc_father, KeyNames().dl_state_spc_logical);
	SHARED spc19 := updatexIDLSuperFile(KeyNames().dl_nbr_spc_super, KeyNames().dl_nbr_spc_father, KeyNames().dl_nbr_spc_logical);
	SHARED spc20 := updatexIDLSuperFile(KeyNames().src_spc_super, KeyNames().src_spc_father, KeyNames().src_spc_logical);
	SHARED spc21 := updatexIDLSuperFile(KeyNames().source_rid_spc_super, KeyNames().source_rid_spc_father, KeyNames().source_rid_spc_logical);
	//SHARED spc22 := updatexIDLSuperFile(KeyNames().rid_spc_super, KeyNames().rid_spc_father, KeyNames().rid_spc_logical);
	SHARED spc23 := updatexIDLSuperFile(KeyNames().mainname_spc_super, KeyNames().mainname_spc_father, KeyNames().mainname_spc_logical);
	SHARED spc24 := updatexIDLSuperFile(KeyNames().fullname_spc_super, KeyNames().fullname_spc_father, KeyNames().fullname_spc_logical);
	SHARED spc25 := updatexIDLSuperFile(KeyNames().addr1_spc_super, KeyNames().addr1_spc_father, KeyNames().addr1_spc_logical);
	SHARED spc26 := updatexIDLSuperFile(KeyNames().locale_spc_super, KeyNames().locale_spc_father, KeyNames().locale_spc_logical);
	SHARED spc27 := updatexIDLSuperFile(KeyNames().address_spc_super, KeyNames().address_spc_father, KeyNames().address_spc_logical);
	SHARED spc28 := updatexIDLSuperFile(KeyNames().main_spc_super, KeyNames().main_spc_father, KeyNames().main_spc_logical);
	SHARED spc29 := updatexIDLSuperFile(KeyNames().res_spc_super, KeyNames().res_spc_father, KeyNames().res_spc_logical);
	SHARED spc30 := updatexIDLSuperFile(KeyNames().dt_first_seen_spc_super, KeyNames().dt_first_seen_spc_father, KeyNames().dt_first_seen_spc_logical);
	SHARED spc31 := updatexIDLSuperFile(KeyNames().dt_last_seen_spc_super, KeyNames().dt_last_seen_spc_father, KeyNames().dt_last_seen_spc_logical);
	// SHARED spc32 := updatexIDLSuperFile(KeyNames().reporteddate_spc_super, KeyNames().reporteddate_spc_father, KeyNames().reporteddate_spc_logical);
	SHARED spc33 := updatexIDLSuperFile(KeyNames().dt_effective_first_spc_super, KeyNames().dt_effective_first_spc_father, KeyNames().dt_effective_first_spc_logical);
	SHARED spc34 := updatexIDLSuperFile(KeyNames().dt_effective_last_spc_super, KeyNames().dt_effective_last_spc_father, KeyNames().dt_effective_last_spc_logical);
		
	EXPORT updateFieldSpecificitiesSuperFiles := SEQUENTIAL(createSpcSuperFiles(),
																												  STD.File.StartSuperfileTransaction(),
																												  PARALLEL(
																													spc1, spc2, spc3, spc4, spc5, spc6, spc7, spc8, spc9, spc10,
																																	 spc11, spc12, spc13, spc14, spc15, spc16, spc17, spc18, spc19, spc20,
																																	 spc21, /*spc22,*/ 
																												spc23, spc24, spc25, spc26, spc27, 
																												spc30, spc31, //spc32, 
																																	  spc33, spc34
																																	 ),
																												  STD.File.FinishSuperfileTransaction());
																													
	EXPORT updateAttrSpecificitiesSuperFiles  := SEQUENTIAL(createSpcSuperFiles(),
																												  STD.File.StartSuperfileTransaction(),
																												  PARALLEL(spc29),
																												  STD.File.FinishSuperfileTransaction());
																													
	EXPORT updateMainSpecificitiesSuperFiles  := SEQUENTIAL(createSpcSuperFiles(),
																												  STD.File.StartSuperfileTransaction(),
																												  PARALLEL(spc28),
																												  STD.File.FinishSuperfileTransaction());
																													
	EXPORT updateAllSpecificitiesSuperFiles   := SEQUENTIAL(createSpcSuperFiles(),
																												  STD.File.StartSuperfileTransaction(),
																												  PARALLEL(spc1, spc2, spc3, spc4, spc5, spc6, spc7, spc8, spc9, spc10,
																																	 spc11, spc12, spc13, spc14, spc15, spc16, spc17, spc18, spc19, spc20,
																																	 spc21, /*spc22,*/ spc23, spc24, spc25, spc26, spc27, spc28, spc29,
																																	 spc30, spc31, /*spc32,*/ spc33, spc34),
																												  STD.File.FinishSuperfileTransaction());
																															
end;
