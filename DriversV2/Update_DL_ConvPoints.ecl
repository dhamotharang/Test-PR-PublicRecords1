import DriversV2;

export Update_DL_ConvPoints := module

  // ************* UPDATE CONVICTIONS *********************************************************
	/* Removed MO, per Jill Luber to be compliant with the new state law(bug#37550; 20090309) - reinstated MO on 20090716 */
	DL_Convictions := if( nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions')) > 0, 
												DriversV2.File_DL_CP_As_Conviction +	                // As mapper updates
												DriversV2.Files_DL_Conv_Points_Base.Base_Conviction,  // base file
												DriversV2.Files_DL_Conv_Points_Base.Base_Conviction		// base file
											); 
											
	shared DL_Convictions_srt := distribute(DL_Convictions, hash64(src_state, DLCP_Key));
					   
  shared Layout_Conviction := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

	shared Layout_Conviction  rollupXformConv(Layout_Conviction l, Layout_Conviction r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
  end;

	export Update_DL_Convictions := rollup(sort(DL_Convictions_srt, DLCP_KEY,
																					TYPE_CD,
																					TYPE_DESC,
																					VIOLATION_DATE,
																					PLATE_NBR,
																					CONVICTION_DATE,
																					COURT_NAME_CD,
																					COURT_NAME_DESC,
																					COURT_COUNTY,
																					COURT_TYPE_CD,
																					COURT_TYPE_DESC,
																					ST_OFFENSE_CONV_CD,
																					ST_OFFENSE_CONV_DESC,
																					SENTENCE,
																					SENTENCE_DESC,
																					POINTS,
																					HAZARDOUS_CD,
																					HAZARDOUS_DESC,
																					PLEA_CD,
																					PLEA_DESC,
																					COURT_CASE_NBR,
																					ACD_OFFENSE_CD,
																					ACD_OFFENSE_DESC,
																					VEHICLE_NO,
																					REDUCED_CD,
																					REDUCED_DESC,
																					CREATE_DATE,
																					BMV_CASE_NBR_1,
																					BMV_CASE_NBR_2,
																					BMV_CASE_NBR_3,
																					HABITUAL_CASE_NBR,
																					FILED_DATE,
																					EXPUNGED_DATE,
																					JURISDICTION,
																					SOA_CONVICTION,
																					BMV_SP_CASE_NBR,
																					OUT_OF_STATE_DL_NBR,
																					STATE_OF_ORIGIN,
																					COUNTY,
																					 -process_date, local), rollupXformConv(LEFT,RIGHT), RECORD,
																																										EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 
		
	// Restricted convictions must be separate from normal convictions.
	Full_Convictions_Restricted := if(count(nothor(FileServices.SuperFileContents(DriversV2.Constants.Cluster + 'base::DL2::CP_Convictions_Restricted'))) = 0,
	                                  dataset([], DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions),
	                                  Driversv2.Files_DL_Conv_Points_Base.Base_Conviction_Restricted);
																		
	DL_Convictions_Restricted := if( nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Convictions_Restricted')) > 0,
																	 DriversV2.File_DL_CP_As_Conviction_Restricted +	// As mapper updates
																	 Full_Convictions_Restricted,											// base file
																	 Full_Convictions_Restricted											// base file
																 );

	DL_Convictions_Restricted_dist := distribute(DL_Convictions_Restricted, hash64(src_state, DLCP_Key));

	
	export Update_DL_Convictions_Restricted :=
	  rollup(sort(DL_Convictions_Restricted_dist,
		            DLCP_KEY,
								TYPE_CD,
								TYPE_DESC,
								VIOLATION_DATE,
								PLATE_NBR,
								CONVICTION_DATE,
								COURT_NAME_CD,
								COURT_NAME_DESC,
								COURT_COUNTY,
								COURT_TYPE_CD,
								COURT_TYPE_DESC,
								ST_OFFENSE_CONV_CD,
								ST_OFFENSE_CONV_DESC,
								SENTENCE,
								SENTENCE_DESC,
								POINTS,
								HAZARDOUS_CD,
								HAZARDOUS_DESC,
								PLEA_CD,
								PLEA_DESC,
								COURT_CASE_NBR,
								ACD_OFFENSE_CD,
								ACD_OFFENSE_DESC,
								VEHICLE_NO,
								REDUCED_CD,
								REDUCED_DESC,
								CREATE_DATE,
								BMV_CASE_NBR_1,
								BMV_CASE_NBR_2,
								BMV_CASE_NBR_3,
								HABITUAL_CASE_NBR,
								FILED_DATE,
								EXPUNGED_DATE,
								JURISDICTION,
								SOA_CONVICTION,
								BMV_SP_CASE_NBR,
								OUT_OF_STATE_DL_NBR,
								STATE_OF_ORIGIN,
								COUNTY,
								-process_date,
								local),
					 rollupXformConv(LEFT,RIGHT),
					 RECORD,
						  EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen,
					 local); 
		
	// ************* UPDATE SUSPENSIONS *********************************************************
	/* Removed MO, per Jill Luber to be compliant with the new state law(bug#37550; 20090309) - reinstated MO on 20090716 */
	DL_Suspensions :=  if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_suspension')) > 0,
												DriversV2.File_DL_CP_As_Suspension +									// As mapper updates
												Driversv2.Files_DL_Conv_Points_Base.Base_Suspension,	// base file
												Driversv2.Files_DL_Conv_Points_Base.Base_Suspension		// base file
											 );  
					   
  DL_Suspensions_srt := distribute(DL_Suspensions, hash64(src_state, DLCP_Key));
					   
  Layout_Suspension := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;

	Layout_Suspension  rollupXformSusp(Layout_Suspension l, Layout_Suspension r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
  end;
						 
	export Update_DL_Suspensions := rollup(sort(DL_Suspensions_srt, record, except process_date, dt_first_seen, dt_last_seen, local),rollupXformSusp(LEFT,RIGHT), RECORD,
																					EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 
        
  // ************* UPDATE DRIVER RECORD INFORMATION *******************************************
	/* Removed MO, per Jill Luber to be compliant with the new state law(bug#37550; 20090309) - reinstated 20090716 */
	DL_DR_Info := if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_DR_Info')) > 0, 
									 DriversV2.File_DL_CP_As_DR_Info +									// As mapper updates
									 Driversv2.Files_DL_Conv_Points_Base.Base_DR_Info,	// base file
									 Driversv2.Files_DL_Conv_Points_Base.Base_DR_Info		// base file
									);
	
	DL_DR_Info_srt := distribute(DL_DR_Info, hash64(src_state, DLCP_Key));
					   
  Layout_DR_Info := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;
		
	Layout_DR_Info  rollupXformDLI(Layout_DR_Info l, Layout_DR_Info r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;
											 
	export Update_DL_DR_Info := rollup(sort(DL_DR_Info_srt, record, except process_date, dt_first_seen, dt_last_seen, local),rollupXformDLI(LEFT,RIGHT), RECORD,
																			EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 	
     
    
	// ************* UPDATE ACCIDENTS  **********************************************************
  DL_Accidents := if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Accident')) > 0, 
										 DriversV2.File_DL_CP_As_Accident +										// As mapper updates
										 Driversv2.Files_DL_Conv_Points_Base.Base_Accident,		// base file
										 Driversv2.Files_DL_Conv_Points_Base.Base_Accident		// base file
										);
				
  DL_Accidents_srt := distribute(DL_Accidents, hash64(src_state, DLCP_Key));
					   
  Layout_Accident := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident;
	
	Layout_Accident  rollupXformAcc(Layout_Accident l, Layout_Accident r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
  end;
										 
	export Update_DL_Accidents :=	rollup(sort(DL_Accidents_srt, record, except process_date, dt_first_seen, dt_last_seen, local), rollupXformAcc(LEFT,RIGHT), RECORD,
																				EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local);    
		
	
	// ************* UPDATE FRA INSURENCE *******************************************************
	DL_Insurance :=  if(nothor(fileservices.GetSuperFileSubCount(DriversV2.Constants.Cluster+'in::dl2::ConvPoints::As_Insurance')) > 0, 
											DriversV2.File_DL_CP_As_Insurance +												// As mapper updates
											Driversv2.Files_DL_Conv_Points_Base.Base_FRA_Insurance,		// base file
											Driversv2.Files_DL_Conv_Points_Base.Base_FRA_Insurance		// base file
										 );
    
	DL_Insurance_srt := distribute(DL_Insurance, hash64(src_state, DLCP_Key));
					   
  Layout_Insurance := DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance;
	
	Layout_Insurance  rollupXformIns(Layout_Insurance l, Layout_Insurance r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;
												 
	export Update_DL_Insurance :=	rollup(sort(DL_Insurance_srt, record, except process_date, dt_first_seen, dt_last_seen,local),rollupXformIns(LEFT,RIGHT), RECORD,
																				EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 
    
	
end;