import DriversV2;

export Update_DL_ConvPoints := module

    // ************* UPDATE CONVICTIONS *********************************************************
	DL_Convictions :=  	DriversV2.Mapping_DL_OH_As_ConvPoints.OH_As_Convictions +
	                   /* Removed MO, per Jill Luber to be compliant with the new state law(bug#37550; 20090309) - reinstated MO on 20090716 */
											DriversV2.Mapping_DL_MO_As_ConvPoints.MO_As_Convictions +
											DriversV2.Mapping_DL_MO_New_As_ConvPoints.MO_As_Convictions +
											DriversV2.Mapping_DL_MN_As_ConvPoints.MN_As_Convictions + 
											DriversV2.Mapping_DL_MN_New_As_ConvPoints +
	                    DriversV2.Mapping_DL_TN_As_ConvPoints.TN_As_Convictions;
											
	shared DL_Convictions_srt := distribute(DL_Convictions, hash64(src_state, DLCP_Key));
					   
  shared Layout_Conviction := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;

	shared Full_Convictions := distribute(Driversv2.Files_DL_Conv_Points_Base.Base_Conviction, hash64(src_state, DLCP_Key));

	shared Layout_Conviction  rollupXformConv(Layout_Conviction l, Layout_Conviction r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;

	export Update_DL_Convictions := rollup(sort(DL_Convictions_srt + Full_Convictions, DLCP_KEY,
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
	DL_Convictions_Restricted := DriversV2.Mapping_DL_MN_RESTRICTED_As_ConvPoints.MN_RESTRICTED_As_Convictions;

	DL_Convictions_Restricted_dist := distribute(DL_Convictions_Restricted, hash64(src_state, DLCP_Key));

  Full_Convictions_Restricted := if(count(nothor(FileServices.SuperFileContents(DriversV2.Constants.Cluster + 'base::DL2::CP_Convictions_Restricted'))) = 0,
	                                  dataset([], DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions),
	                                  distribute(Driversv2.Files_DL_Conv_Points_Base.Base_Conviction_Restricted, hash64(src_state, DLCP_Key)));
	
	export Update_DL_Convictions_Restricted :=
	  rollup(sort(DL_Convictions_Restricted_dist + Full_Convictions_Restricted,
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
	DL_Suspensions :=  DriversV2.Mapping_DL_OH_As_ConvPoints.OH_As_Suspension +
	                   /* Removed MO, per Jill Luber to be compliant with the new state law(bug#37550; 20090309) - reinstated MO on 20090716 */
	                   DriversV2.Mapping_DL_MO_As_ConvPoints.MO_As_Suspension +
										 DriversV2.Mapping_DL_MO_New_As_ConvPoints.MO_As_Suspension +
										 DriversV2.Mapping_DL_TN_As_ConvPoints.TN_As_Suspension;  
					   
    DL_Suspensions_srt := distribute(DL_Suspensions, hash64(src_state, DLCP_Key));
					   
    Layout_Suspension := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions;
	
	Full_Suspension := distribute(Driversv2.Files_DL_Conv_Points_Base.Base_Suspension, hash64(src_state, DLCP_Key));

	Layout_Suspension  rollupXformSusp(Layout_Suspension l, Layout_Suspension r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;
						 
	export Update_DL_Suspensions := rollup(sort(DL_Suspensions_srt + Full_Suspension, record, except process_date, dt_first_seen, dt_last_seen, local),rollupXformSusp(LEFT,RIGHT), RECORD,
																					EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 
        
  	// ************* UPDATE DRIVER RECORD INFORMATION *******************************************
	DL_DR_Info :=  DriversV2.Mapping_DL_OH_As_ConvPoints.OH_As_DR_Info +
	               /* Removed MO, per Jill Luber to be compliant with the new state law(bug#37550; 20090309) - reinstated 20090716 */
	               DriversV2.Mapping_DL_MO_As_ConvPoints.MO_As_DR_Info +
								 DriversV2.Mapping_DL_MO_New_As_ConvPoints.MO_As_DR_Info;
	
	DL_DR_Info_srt := distribute(DL_DR_Info, hash64(src_state, DLCP_Key));
					   
  Layout_DR_Info := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info;
	
	Full_DR_Info := distribute(Driversv2.Files_DL_Conv_Points_Base.Base_DR_Info, hash64(src_state, DLCP_Key));
	
	Layout_DR_Info  rollupXformDLI(Layout_DR_Info l, Layout_DR_Info r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;
											 
	export Update_DL_DR_Info := rollup(sort(DL_DR_Info_srt + Full_DR_Info, record, except process_date, dt_first_seen, dt_last_seen, local),rollupXformDLI(LEFT,RIGHT), RECORD,
																			EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 	
     
    
	// ************* UPDATE ACCIDENTS  **********************************************************
  DL_Accidents :=  DriversV2.Mapping_DL_OH_As_ConvPoints.OH_As_Accident +
	                 DriversV2.Mapping_DL_MO_New_As_ConvPoints.MO_As_Accident;
				
    DL_Accidents_srt := distribute(DL_Accidents, hash64(src_state, DLCP_Key));
					   
    Layout_Accident := DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident;
	
		Full_Accidents := distribute(Driversv2.Files_DL_Conv_Points_Base.Base_Accident, hash64(src_state, DLCP_Key)) ;
	
	Layout_Accident  rollupXformAcc(Layout_Accident l, Layout_Accident r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;
										 
	export Update_DL_Accidents :=	rollup(sort(DL_Accidents_srt + Full_Accidents, record, except process_date, dt_first_seen, dt_last_seen, local), rollupXformAcc(LEFT,RIGHT), RECORD,
																				EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local);    
		
	
	// ************* UPDATE FRA INSURENCE *******************************************************
	DL_Insurance :=  DriversV2.Mapping_DL_OH_As_ConvPoints.OH_As_FRA_Insurance;
    
	DL_Insurance_srt := distribute(DL_Insurance, hash64(src_state, DLCP_Key));
					   
    Layout_Insurance := DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance;
		
	Full_DL_Insurance := distribute(Driversv2.Files_DL_Conv_Points_Base.Base_FRA_Insurance, hash64(src_state, DLCP_Key));
	
	Layout_Insurance  rollupXformIns(Layout_Insurance l, Layout_Insurance r) := transform
	   self.Process_Date   := if(l.Process_Date >= r.Process_Date, l.Process_Date, r.Process_Date);
	   self.Dt_First_Seen  := if(l.Dt_First_Seen >= r.Dt_First_Seen, r.Dt_First_Seen, l.Dt_First_Seen);
	   self.Dt_Last_Seen   := if(l.Dt_Last_Seen  <= r.Dt_Last_Seen,  r.Dt_Last_Seen,  l.Dt_Last_Seen);
	   self := l;
    end;
												 
	export Update_DL_Insurance :=	rollup(sort(DL_Insurance_srt + Full_DL_Insurance, record, except process_date, dt_first_seen, dt_last_seen,local),rollupXformIns(LEFT,RIGHT), RECORD,
																				EXCEPT Process_Date, Dt_First_Seen, Dt_Last_Seen, local); 
    
	
end;