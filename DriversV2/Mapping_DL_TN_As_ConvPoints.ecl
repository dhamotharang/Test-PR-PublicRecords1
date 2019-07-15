IMPORT _Validate, ut, VersionControl;

EXPORT Mapping_DL_TN_As_ConvPoints( string  pversion) := MODULE

  //********* Conviction Mapping *****************************************************************************
  in_Conv_file   := DriversV2.File_DL_TN_Convictions(pversion);

  Layout_Conv_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

  Layout_Conv_Common trfToConviction(in_Conv_file l) :=  TRANSFORM
     SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date) AND
	                                   _Validate.Date.fIsValid(l.process_date,_Validate.Date.Rules.DateInPast),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(l.post_date) AND
	                                   _Validate.Date.fIsValid(l.post_date,_Validate.Date.Rules.DateInPast),l.post_date,'');
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.post_date) AND
	                                   _Validate.Date.fIsValid(l.post_date,_Validate.Date.Rules.DateInPast),l.post_date,'');
     SELF.src_state            := 'TN';   
     SELF.DLCP_KEY             := ut.CleanSpacesAndUpper(l.dl_number); 
     SELF.VIOLATION_DATE       := IF(_Validate.Date.fIsValid(l.event_date) AND
	                                   _Validate.Date.fIsValid(l.event_date,_Validate.Date.Rules.DateInPast),l.event_date,'');
     SELF.CONVICTION_DATE      := IF(_Validate.Date.fIsValid(l.post_date) AND
	                                   _Validate.Date.fIsValid(l.post_date,_Validate.Date.Rules.DateInPast),l.post_date,'');
     SELF.ACD_OFFENSE_CD       := ut.CleanSpacesAndUpper(l.action_code);
     SELF.ACD_OFFENSE_DESC     := ut.CleanSpacesAndUpper(DriversV2.Tables_CP_TN.Conviction_Code(SELF.ACD_OFFENSE_CD));
     SELF.STATE_OF_ORIGIN      := 'TN';    
		 SELF.COUNTY               := ut.CleanSpacesAndUpper(DriversV2.Tables_CP_TN.County_Code(l.County_Code));
     SELF                      := l;
     SELF                      := [];   
  END;

  EXPORT TN_As_Convictions := PROJECT(in_Conv_file, trfToConviction(LEFT));
  
  //********* Suspension Mapping *****************************************************************************
  
  in_Susp_file   := DriversV2.File_DL_TN_Withdrawals(pversion);

  Layout_Susp_Common := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;

  Layout_Susp_Common trfToSuspensions(in_Susp_file l) :=  TRANSFORM
     SELF.process_date         := IF(_Validate.Date.fIsValid(l.process_date) AND
	                                   _Validate.Date.fIsValid(l.process_date,_Validate.Date.Rules.DateInPast),l.process_date,'');
     SELF.dt_first_seen        := IF(_Validate.Date.fIsValid(l.event_date) AND
	                                   _Validate.Date.fIsValid(l.event_date,_Validate.Date.Rules.DateInPast),l.event_date,'');
     SELF.dt_last_seen         := IF(_Validate.Date.fIsValid(l.event_date) AND
	                                   _Validate.Date.fIsValid(l.event_date,_Validate.Date.Rules.DateInPast),l.event_date,'');
     SELF.src_state            := 'TN';   
     SELF.DLCP_KEY             := ut.CleanSpacesAndUpper(l.DL_NUMBER);
     SELF.ACTION_DATE          := IF(_Validate.Date.fIsValid(l.event_date) AND
	                                   _Validate.Date.fIsValid(l.event_date,_Validate.Date.Rules.DateInPast),l.event_date,'');
		 SELF.ACD_OFFENSE_CD       := ut.CleanSpacesAndUpper(l.action_code);
     SELF.ACD_OFFENSE_DESC     := ut.CleanSpacesAndUpper(DriversV2.Tables_CP_TN.Withdrawal_Code(SELF.ACD_OFFENSE_CD));
		 SELF                      := l;
     SELF                      := [];
  END;

  EXPORT TN_As_Suspension := PROJECT(in_Susp_file, trfToSuspensions(LEFT));
	
	shared logical_name := DriversV2.Constants.Cluster+'in::dl2::'+pversion+'::TN::';	 

	VersionControl.macBuildNewLogicalFile( logical_name+'As_Convictions'	,TN_As_Convictions		,Bld_TN_As_Convictions	);
	VersionControl.macBuildNewLogicalFile( logical_name+'As_Suspension'		,TN_As_Suspension			,Bld_TN_As_Suspension		);	
	
	export Build_DL_TN_Conviction :=
	sequential( Bld_TN_As_Convictions							
						 ,sequential(  FileServices.StartSuperFileTransaction()
													,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions',logical_name+'As_Convictions')													
													,FileServices.FinishSuperFileTransaction()
												)
						);
						
	export Build_DL_TN_Suspension :=
	sequential( Bld_TN_As_Suspension							
						 ,sequential(  FileServices.StartSuperFileTransaction()
													,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Suspension',logical_name+'As_Suspension')													
													,FileServices.FinishSuperFileTransaction()
												)
						);
	/* 
	export Build_DL_TN_Convpoints :=
		sequential(
							 parallel(
									 Bld_TN_As_Convictions
									,Bld_TN_As_Suspension		
							 )
							 ,sequential(  FileServices.StartSuperFileTransaction()
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions',logical_name+'As_Convictions')
														,fileservices.addsuperfile(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Suspension',logical_name+'As_Suspension')
														,FileServices.FinishSuperFileTransaction()
													)
							);
	*/
  
END;