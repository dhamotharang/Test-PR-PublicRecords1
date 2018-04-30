IMPORT Drivers, DriversV2, lib_stringlib, _Validate, codes, VersionControl;

EXPORT Mapping_DL_MO_New_As_ConvPoints( string  pversion) := MODULE

  //********* Conviction Mapping *****************************************************************************
  in_Conv_file   := DriversV2.File_DL_MO_Points_MedCert(pversion);

  Layout_Conv_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

  Layout_Conv_Common trfToConviction(in_Conv_file l) :=  TRANSFORM
     SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date) AND
	                                   _Validate.Date.fIsValid(l.process_date,_Validate.Date.Rules.DateInPast),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(l.conv_date) AND
	                                   _Validate.Date.fIsValid(l.conv_date,_Validate.Date.Rules.DateInPast),l.conv_date,'');
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.conv_date) AND
	                                   _Validate.Date.fIsValid(l.conv_date,_Validate.Date.Rules.DateInPast),l.conv_date,'');
     SELF.src_state            := 'MO';   
     SELF.DLCP_KEY             := l.unique_key;   
     SELF.TYPE_CD              := TRIM(l.conv_viol_code,LEFT,RIGHT);
     SELF.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Conviction_Type(SELF.TYPE_CD));
     SELF.VIOLATION_DATE       := IF(_Validate.Date.fIsValid(l.conv_viol_date) AND
	                                   _Validate.Date.fIsValid(l.conv_viol_date,_Validate.Date.Rules.DateInPast),l.conv_viol_date,'');
     SELF.CONVICTION_DATE      := IF(_Validate.Date.fIsValid(l.conv_date) AND
	                                   _Validate.Date.fIsValid(l.conv_date,_Validate.Date.Rules.DateInPast),l.conv_date,'');
     SELF.COURT_NAME_CD        := TRIM(l.conv_crt_loc,LEFT,RIGHT);
     SELF.COURT_NAME_DESC      := IF(LENGTH(TRIM(SELF.COURT_NAME_CD,LEFT,RIGHT)) = 2,codes.St2Name(SELF.COURT_NAME_CD),stringlib.StringToUpperCase(Tables_CP_MO_New.Court(SELF.COURT_NAME_CD)));
     SELF.COURT_TYPE_CD        := TRIM(l.conv_crt_type,LEFT,RIGHT);
     SELF.COURT_TYPE_DESC      := stringlib.StringToUpperCase(Tables_CP_MO_New.Court_Type(SELF.COURT_TYPE_CD));
     SELF.ST_OFFENSE_CONV_CD   := IF(TRIM(l.conv_viol_code,LEFT,RIGHT)<>'',TRIM(l.conv_viol_code,LEFT,RIGHT),TRIM(l.conv_acd_code,LEFT,RIGHT));
     SELF.ST_OFFENSE_CONV_DESC := IF(TRIM(l.conv_viol_code,LEFT,RIGHT)<>'',stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Convictions(SELF.ST_OFFENSE_CONV_CD)),
		                                 stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.ACD_Code(SELF.ST_OFFENSE_CONV_CD)));
     SELF.POINTS               := TRIM(l.conv_pts_assessed,LEFT,RIGHT);
		 SELF.HAZARDOUS_CD         := TRIM(l.conv_haz_mat_ind,LEFT,RIGHT);
		 SELF.HAZARDOUS_DESC       := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Conv_Haz_Mat_Code(SELF.HAZARDOUS_CD));
     SELF.ACD_OFFENSE_CD       := TRIM(l.conv_acd_code,LEFT,RIGHT);
     SELF.ACD_OFFENSE_DESC     := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.ACD_Code(SELF.ACD_OFFENSE_CD));
     SELF.STATE_OF_ORIGIN      := 'MO';    
     SELF                      := l;
     SELF                      := [];   
  END;

  EXPORT MO_As_Convictions := PROJECT(in_Conv_file, trfToConviction(LEFT));
  
  //********* Suspension Mapping *****************************************************************************
  
  in_Susp_file   := DriversV2.File_DL_MO_Actions_MedCert(pversion);

  Layout_Susp_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;

  Layout_Susp_Common trfToSuspensions(in_Susp_file l) :=  TRANSFORM
     SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date) AND
	                                   _Validate.Date.fIsValid(l.process_date,_Validate.Date.Rules.DateInPast),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(l.action_offense_date) AND
	                                   _Validate.Date.fIsValid(l.action_offense_date,_Validate.Date.Rules.DateInPast),l.action_offense_date,
																	   IF(_Validate.Date.fIsValid(l.action_eff_date) AND
	                                   _Validate.Date.fIsValid(l.action_eff_date,_Validate.Date.Rules.DateInPast),l.action_eff_date,''));
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.action_offense_date) AND
	                                   _Validate.Date.fIsValid(l.action_offense_date,_Validate.Date.Rules.DateInPast),l.action_offense_date,
																	   IF(_Validate.Date.fIsValid(l.action_eff_date) AND
	                                   _Validate.Date.fIsValid(l.action_eff_date,_Validate.Date.Rules.DateInPast),l.action_eff_date,''));
     SELF.src_state            := 'MO';   
     SELF.DLCP_KEY             := l.unique_key;
     SELF.TYPE_CD              := TRIM(l.action_type,LEFT,RIGHT);
     SELF.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Suspensions(SELF.TYPE_CD));
		 SELF.ACTION_DATE          := IF(_Validate.Date.fIsValid(l.action_offense_date) AND
	                                   _Validate.Date.fIsValid(l.action_offense_date,_Validate.Date.Rules.DateInPast),l.action_offense_date,'');
     SELF.START_DATE           := IF(_Validate.Date.fIsValid(l.action_eff_date) AND
		                                 _Validate.Date.fIsValid(l.action_eff_date,_Validate.Date.Rules.DateInPast),l.action_eff_date,'');
     SELF.END_DATE             := IF(_Validate.Date.fIsValid(l.action_reinst_date),l.action_reinst_date,'');
     SELF.COURT_CASE_NBR       := TRIM(l.action_case_num,LEFT,RIGHT);
		 SELF.HAZARDOUS_CD         := TRIM(IF(l.action_haz_mat_ind <> '',l.action_haz_mat_ind,
		                                   IF(l.action_haz_mat_ind = '' AND l.action_state = 'MO','N','')),LEFT,RIGHT);
		 SELF.HAZARDOUS_DESC       := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Action_Haz_Mat_Code(SELF.HAZARDOUS_CD));
     SELF.JURISDICTION         := TRIM(l.action_state,LEFT,RIGHT);     
		 SELF.WD_REASON_CD         := TRIM(l.action_wdraw_basis,LEFT,RIGHT);
     SELF.WD_REASON_DESC       := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.WD_Basis(SELF.WD_REASON_CD));
		 SELF.ACD_OFFENSE_CD       := TRIM(l.action_acd_code,LEFT,RIGHT);
		 SELF.ACD_OFFENSE_DESC     := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.ACD_Code(SELF.ACD_OFFENSE_CD)); 
     SELF.WD_STATUS_CD         := TRIM(l.action_wdraw_code,LEFT,RIGHT);
     SELF.WD_STATUS_DESC       := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.WD_Type(SELF.WD_STATUS_CD));
		 SELF                      := l;
     SELF                      := [];
  END;

  EXPORT MO_As_Suspension := PROJECT(in_Susp_file, trfToSuspensions(LEFT));
  
  //********* Drivers Record Information Mapping *****************************************************************
  
  in_DR_Info_file   := DriversV2.File_DL_MO_DPRDPS_MedCert(pversion);

  Layout_DR_Info_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;

  Layout_DR_Info_Common trfToDRInfo(in_DR_Info_file l) :=  TRANSFORM
     SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date) AND
	                                   _Validate.Date.fIsValid(l.process_date,_Validate.Date.Rules.DateInPast),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(l.driv_priv_eff_date) AND
	                                   _Validate.Date.fIsValid(l.driv_priv_eff_date,_Validate.Date.Rules.DateInPast),l.driv_priv_eff_date,'');
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.driv_priv_eff_date) AND
	                                   _Validate.Date.fIsValid(l.driv_priv_eff_date,_Validate.Date.Rules.DateInPast),l.driv_priv_eff_date,'');
     SELF.src_state            := 'MO';      
     SELF.DLCP_KEY             := l.unique_key;
     SELF.TYPE_CD              := TRIM(l.driv_priv_type,LEFT,RIGHT);
     SELF.TYPE_DESC            := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Driv_Priv_Type(SELF.TYPE_CD));
     SELF.ACTION_DATE          := IF(_Validate.Date.fIsValid(l.driv_priv_eff_date) AND
	                                   _Validate.Date.fIsValid(l.driv_priv_eff_date,_Validate.Date.Rules.DateInPast),l.driv_priv_eff_date,'');
     SELF.EXPUNGED_DATE        := IF(_Validate.Date.fIsValid(l.driv_priv_exp_date),l.driv_priv_exp_date,'');
     SELF                      := l;
     SELF                      := [];   
  END;

  EXPORT MO_As_DR_Info := PROJECT(in_DR_Info_file, trfToDRInfo(LEFT));

  //********* Accident Record Information Mapping *****************************************************************

  in_Accident_file   := DriversV2.File_DL_MO_Accidents(pversion);

  Layout_Accident_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident;
	
	Layout_Accident_Common trfToAccident(in_Accident_file l) :=  TRANSFORM
		 SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date) AND
	                                   _Validate.Date.fIsValid(l.process_date,_Validate.Date.Rules.DateInPast),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(l.acci_date) AND
	                                _Validate.Date.fIsValid(l.acci_date,_Validate.Date.Rules.DateInPast),l.acci_date,'');
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.acci_date) AND
	                                _Validate.Date.fIsValid(l.acci_date,_Validate.Date.Rules.DateInPast),l.acci_date,'');
     SELF.src_state            := 'MO';      
		 SELF.DLCP_KEY             := l.unique_key;
		 SELF.JURISDICTION         := TRIM(l.acci_state,LEFT,RIGHT);
		 SELF.SEVERITY_CD          := TRIM(l.acci_sev_code,LEFT,RIGHT);
		 SELF.SEVERITY_DESC        := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Accident_Sev_Code(SELF.SEVERITY_CD));
		 SELF.ACCIDENT_DATE        := IF(_Validate.Date.fIsValid(l.acci_date) AND
	                                   _Validate.Date.fIsValid(l.acci_date,_Validate.Date.Rules.DateInPast),l.acci_date,'');
		 SELF.HAZARDOUS_CD         := TRIM(l.acci_haz_mat_ind,LEFT,RIGHT);
		 SELF.HAZARDOUS_DESC       := stringlib.StringToUpperCase(DriversV2.Tables_CP_MO_New.Conv_Haz_Mat_Code(SELF.HAZARDOUS_CD));
	   SELF                      := l;
     SELF                      := [];   
  END;

  EXPORT MO_As_Accident := PROJECT(in_Accident_file, trfToAccident(LEFT));
	
	shared logical_name := DriversV2.Constants.Cluster+'in::dl2::'+pversion+'::MO::';	 

	VersionControl.macBuildNewLogicalFile( logical_name+'As_Convictions'	,MO_As_Convictions		,Bld_MO_As_Convictions	);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Suspension'		,MO_As_Suspension			,Bld_MO_As_Suspension		);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_DR_Info'			,MO_As_DR_Info				,Bld_MO_As_DR_Info			);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Accident'			,MO_As_Accident				,Bld_MO_As_Accident			);
	
	 
	export Build_DL_MO_Convpoints :=
	sequential(parallel( Bld_MO_As_Convictions
											,Bld_MO_As_Suspension
											,Bld_MO_As_DR_Info
											,Bld_MO_As_Accident			
										 )
							//** Create superfiles if not already exist, before moving the logical sub files created. 
						 ,sequential( if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Convictions')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Convictions')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Convictions')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Convictions'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Convictions')),
													
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Suspension'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Suspension')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Suspension'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Suspension')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Suspension'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Suspension')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Suspension'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Suspension')),
													
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_DR_Info'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_DR_Info')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_DR_Info'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_DR_Info')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_DR_Info'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_DR_Info')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_DR_Info'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_DR_Info')),
													
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Accident'),FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::As_Accident')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Accident'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::father::As_Accident')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Accident'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::grandfather::As_Accident')),
													if (~FileServices.SuperFileExists(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Accident'), FileServices.CreateSuperFile(DriversV2.Constants.cluster + 'in::dl2::ConvPoints::delete::As_Accident'))						
												)
						 ,sequential(  FileServices.StartSuperFileTransaction()
													,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions',logical_name+'As_Convictions')
													,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Suspension',logical_name+'As_Suspension')
													,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_DR_Info',logical_name+'As_DR_Info')
													,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Accident',logical_name+'As_Accident')													
													,FileServices.FinishSuperFileTransaction()
												)
						);

	
END;