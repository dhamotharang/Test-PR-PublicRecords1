import std,ut,Scoring_Project_Macros,scoring_project_pip,  ProfileBooster;
#workunit('name','Data Collection Error code Response Counts');

dt := ut.getdate+ '_1';

filenames_details1 :=  OUTPUT(nothor(STD.File.LogicalFileList('scoringqa::out::*' + dt)),,'~scoringqa::out::files_' + dt, thor, overwrite );

//*************input and output file names*************

RV_Attributes_V3_XML_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;
RV_Attributes_V3_BATCH_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_Experian_infile;
RV_Attributes_V3_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_CapOne_infile;
// RV_Attributes_V2_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
// RV_Attributes_V2_BATCH_CreditAcceptance_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_infile;
// RV_Scores_XML_Tmobile_rvt1212_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_infile;
// RV_Scores_XML_Tmobile_rvt1210_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_infile;
// RV_Scores_XML_Santander_1304_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_1_infile;
// RV_Scores_XML_Santander_1304_2_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_2_infile;
// RV_Scores_V4_XML_ENOVA_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_V4_XML_ENOVA_infile;
RV_V4_Generic_infile := scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_V3_Generic_infile:= scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile; 
// RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile;
BC10_Scores_Chase_BNK4_infile := scoring_project_pip.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;
CBBL_Scores_XML_Chase_infile:= scoring_project_pip.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;
// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile :=  scoring_project_pip.Input_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile;
LI_Generic_msn1210_1_infile := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;
PRIO_Scores_Chase_PIO2_infile := scoring_project_pip.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;
BIID_Scores_Batch_Chase_infile := scoring_project_pip.Input_Sample_Names.BIID_Scores_Batch_Chase_infile;
BIID_Scores_XML_Generic_infile := scoring_project_pip.Input_Sample_Names.BIID_Scores_XML_Generic_infile;
BIID_Scores_BATCH_Generic_infile :=scoring_project_pip.Input_Sample_Names.BIID_Scores_BATCH_Generic_infile;
IID_Scores_V0_XML_Generic_infile := scoring_project_pip.Input_Sample_Names.IID_Scores_V0_XML_Generic_infile;
IID_Scores_V0_BATCH_Generic_infile :=scoring_project_pip.Input_Sample_Names.IID_Scores_V0_BATCH_Generic_infile;
// FP_V2_Generic_FP1109_0_infile := scoring_project_pip.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;
ITA_Attributes_V3_BATCH_CapOne_infile :=   scoring_project_pip.Input_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_infile;

Profile_booster_Capone_infile := scoring_project_pip.Input_Sample_Names.Profile_booster_Capone_infile;
FP_V2_American_Express_FP1109_0_infile := scoring_project_pip.Input_Sample_Names.FP_V2_American_Express_FP1109_0_infile;
FP_V3_Generic_FP31505_0_infile := scoring_project_pip.Input_Sample_Names.FP_V3_Generic_FP31505_0_infile;
AddressShell_Attributes_V1_BATCH_Generic_infile := scoring_project_pip.Input_Sample_Names.AddressShell_Attributes_V1_BATCH_Generic_infile;
BusinessShell_Attributes_V2_XML_Generic_infile :=  scoring_project_pip.Input_Sample_Names.BusinessShell_Attributes_V2_XML_Generic_infile;

RV_Attributes_V3_XML_Experian_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile  ;
RV_Attributes_V3_BATCH_Experian_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile  ;
// RV_Attributes_V3_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_CapOne_outfile  ;
// RV_Attributes_V2_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_CapOne_outfile  ;
// RV_Attributes_V2_BATCH_CreditAcceptance_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_outfile  ;
// RV_Scores_XML_Tmobile_rvt1212_1_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_outfile  ;
// RV_Scores_XML_Tmobile_rvt1210_1_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_outfile  ;
// RV_Scores_XML_Santander_1304_1_outfile :=scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Santander_1304_1_outfile  ;
// RV_Scores_XML_Santander_1304_2_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Santander_1304_2_outfile  ;
// RV_Scores_V4_XML_ENOVA_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_ENOVA_outfile  ;
RV_Attributes_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile  ;
RV_Attributes_V4_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_BATCH_Generic_outfile  ;
RV_Scores_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_Generic_outfile  ;
RV_Scores_V4_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_BATCH_Generic_outfile  ;   
RV_Attributes_V3_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Generic_outfile  ;
RV_Attributes_V3_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Generic_outfile  ;
RV_Scores_V3_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V3_XML_Generic_outfile  ;
RV_Scores_V3_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V3_BATCH_Generic_outfile  ;
// RV_Attributes_V2_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_Generic_outfile  ;
// RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile :=scoring_project_pip.Output_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile  ;
BC10_Scores_XML_Chase_BNK4_outfile := scoring_project_pip.Output_Sample_Names.BC10_Scores_XML_Chase_BNK4_outfile  ;
BC10_Scores_BATCH_Chase_BNK4_outfile := scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile  ;
CBBL_Scores_XML_Chase_outfile := scoring_project_pip.Output_Sample_Names.CBBL_Scores_XML_Chase_outfile  ;
ITA_Attributes_V3_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile  ;
// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile := scoring_project_pip.Output_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile  ;
PRIO_Scores_XML_Chase_PIO2_outfile := scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile  ;
PRIO_Scores_BATCH_Chase_PIO2_outfile := scoring_project_pip.Output_Sample_Names.PRIO_Scores_BATCH_Chase_PIO2_outfile  ;
BIID_Scores_Batch_Chase_outfile := scoring_project_pip.Output_Sample_Names.BIID_Scores_Batch_Chase_outfile  ;
BIID_Scores_XML_Generic_outfile :=scoring_project_pip.Output_Sample_Names.BIID_Scores_XML_Generic_outfile  ;
BIID_Scores_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.BIID_Scores_BATCH_Generic_outfile  ;
IID_Scores_V0_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.IID_Scores_V0_XML_Generic_outfile  ;
IID_Scores_V0_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.IID_Scores_V0_BATCH_Generic_outfile  ;
// FP_V2_XML_Generic_FP1109_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V2_XML_Generic_FP1109_0_outfile  ;
// FP_V2_BATCH_Generic_FP1109_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile  ;
LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile := scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile  ;
// LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile := scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile  ;
LI_Attributes_V4_XML_Generic_msn1106_0_outfile := scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile  ;
LI_Scores_V4_XML_Generic_msn1106_0_outfile := scoring_project_pip.Output_Sample_Names.LI_Scores_V4_XML_Generic_msn1106_0_outfile  ;
LI_Scores_V4_BATCH_Generic_msn1106_0_outfile := scoring_project_pip.Output_Sample_Names.LI_Scores_V4_BATCH_Generic_msn1106_0_outfile  ;

RV_Attributes_V5_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile  ;
RV_Scores_Attributes_V5_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile  ;
Profile_Booster_Capone_outfile := scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile  ;
FP_V2_XML_American_Express_FP1109_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile  ;
FP_V3_XML_Generic_FP31505_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile  ;
AddressShell_Attributes_V1_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.AddressShell_Attributes_V1_BATCH_Generic_outfile;
BusinessShell_Attributes_V2_XML_Generic_outfile :=  scoring_project_pip.Output_Sample_Names.BusinessShell_Attributes_V2_XML_Generic_outfile;

//***************************************

biid_layout_input:=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.bus_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
                End;
								
	
	BIID_Scores_Batch_Chase_infile_cnt:=count(dataset(BIID_Scores_Batch_Chase_infile,biid_layout_input,thor));
	BIID_Scores_BATCH_Generic_infile_cnt:=count(dataset(BIID_Scores_BATCH_Generic_infile,biid_layout_input,thor));
	BIID_Scores_XML_Generic_infile_cnt:=count(dataset(BIID_Scores_XML_Generic_infile,biid_layout_input,thor));	
	BC10_Scores_Chase_BNK4_infile_cnt:=count(dataset(BC10_Scores_Chase_BNK4_infile,biid_layout_input,thor));		
	CBBL_Scores_XML_Chase_infile_cnt:=count(dataset(CBBL_Scores_XML_Chase_infile,biid_layout_input,thor));								

layout_Business_Shell := Scoring_Project_Macros.Regression.Business_shell_PII;								
			Business_Shell_infile_cnt:=count(dataset(BusinessShell_Attributes_V2_XML_Generic_infile,layout_Business_Shell,thor));
						
// bestbuy_layout_input :=RECORD
  // Scoring_Project_Macros.Regression.global_layout;
  // Scoring_Project_Macros.Regression.pii_layout pii1;
  // Scoring_Project_Macros.Regression.pii_layout pii2;
  // Scoring_Project_Macros.Regression.runtime_layout;
  // END;
	
	// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile_cnt:=count(dataset(ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile,bestbuy_layout_input,thor));	
	
file_count_function(string infile_name) := function

layout_input :=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
                End;
							 
return count(dataset( infile_name,layout_input, thor));
                            
end;

input_file_count_ds_rec:=record
  string file_name; 
	decimal19_2 input_file_count;
end;

		tag1 := 'flapsd_';
		tag2 := 'fls_';
		tag3 := 'fla_';
		tag4 := 'flaps_';
		tag5 := 'flapd_';
		tag6 := 'flasd_';
		tag7 := 'flpsd_';
		tag8 := 'flap_';
		tag9 := 'flps_';
		tag10 := 'flsd_';
		tag11 := 'flad_';
		tag12 := 'flas_';


input_file_count_ds:= distribute(DATASET([ 
													     {RV_Attributes_V3_XML_Experian_outfile+ dt,file_count_function(RV_Attributes_V3_XML_Experian_infile)},
													     {RV_Attributes_V3_BATCH_Experian_outfile+ dt,file_count_function(RV_Attributes_V3_BATCH_Experian_infile)}, 
												       // {RV_Attributes_V3_BATCH_CapOne_outfile+ dt,file_count_function(RV_Attributes_V3_BATCH_CapOne_infile)},
												    	 // {RV_Attributes_V2_BATCH_CapOne_outfile+ dt,file_count_function(RV_Attributes_V2_BATCH_CapOne_infile)}, 
												    	 // {RV_Attributes_V2_BATCH_CreditAcceptance_outfile+ dt,file_count_function(RV_Attributes_V2_BATCH_CreditAcceptance_infile)},  
										           // {RV_Scores_XML_Tmobile_rvt1212_1_outfile+ dt,file_count_function(RV_Scores_XML_Tmobile_rvt1212_1_infile)}, 
															 // {RV_Scores_XML_Tmobile_rvt1210_1_outfile+ dt,file_count_function(RV_Scores_XML_Tmobile_rvt1210_1_infile)},
													     // {RV_Scores_XML_Santander_1304_1_outfile+ dt,file_count_function(RV_Scores_XML_Santander_1304_1_infile)}, 
												       // {RV_Scores_XML_Santander_1304_2_outfile+ dt,file_count_function(RV_Scores_XML_Santander_1304_2_infile)},
												    	 // {RV_Scores_V4_XML_ENOVA_outfile+ dt,file_count_function(RV_Scores_V4_XML_ENOVA_infile)}, 
												    	 {RV_Attributes_V4_XML_Generic_outfile+ dt,file_count_function(RV_V4_Generic_infile)},  
										           {RV_Attributes_V4_BATCH_Generic_outfile+ dt,file_count_function(RV_V4_Generic_infile)}, 
															 {RV_Scores_V4_XML_Generic_outfile+ dt,file_count_function(RV_V4_Generic_infile)},
													     {RV_Scores_V4_BATCH_Generic_outfile+ dt,file_count_function(RV_V4_Generic_infile)}, 
												       {RV_Attributes_V3_XML_Generic_outfile+ dt,file_count_function(RV_V3_Generic_infile)},
												    	 {RV_Attributes_V3_BATCH_Generic_outfile+ dt,file_count_function(RV_V3_Generic_infile)}, 
												    	 {RV_Scores_V3_XML_Generic_outfile+ dt,file_count_function(RV_V3_Generic_infile)},  
										           {RV_Scores_V3_BATCH_Generic_outfile+ dt,file_count_function(RV_V3_Generic_infile)}, 
															 // {RV_Attributes_V2_BATCH_Generic_outfile+ dt,file_count_function(RV_V4_Generic_infile)},
													     // {RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile+ dt,file_count_function(RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile)}, 
												       {BC10_Scores_XML_Chase_BNK4_outfile+ dt,BC10_Scores_Chase_BNK4_infile_cnt},
												    	 {BC10_Scores_BATCH_Chase_BNK4_outfile+ dt,BC10_Scores_Chase_BNK4_infile_cnt}, 
												    	 {CBBL_Scores_XML_Chase_outfile+ dt,CBBL_Scores_XML_Chase_infile_cnt},  
										           {ITA_Attributes_V3_BATCH_CapOne_outfile+ dt,file_count_function(ITA_Attributes_V3_BATCH_CapOne_infile)}, 
															 // {ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile+ dt,ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile_cnt}, 
															 {PRIO_Scores_XML_Chase_PIO2_outfile+ dt,file_count_function(PRIO_Scores_Chase_PIO2_infile)}, 
															 {PRIO_Scores_BATCH_Chase_PIO2_outfile+ dt,file_count_function(PRIO_Scores_Chase_PIO2_infile)}, 
															 {BIID_Scores_Batch_Chase_outfile+ dt,BIID_Scores_Batch_Chase_infile_cnt}, 
															 {BIID_Scores_XML_Generic_outfile+ dt,BIID_Scores_XML_Generic_infile_cnt}, 
															 {BIID_Scores_BATCH_Generic_outfile+dt,BIID_Scores_BATCH_Generic_infile_cnt}, 
															 {IID_Scores_V0_XML_Generic_outfile+ dt,file_count_function(IID_Scores_V0_XML_Generic_infile)},
															 {IID_Scores_V0_BATCH_Generic_outfile+ dt,file_count_function(IID_Scores_V0_BATCH_Generic_infile)}, 
															 // {FP_V2_XML_Generic_FP1109_0_outfile+ dt,file_count_function(FP_V2_Generic_FP1109_0_infile)}, 
															 // {FP_V2_BATCH_Generic_FP1109_0_outfile+ dt,file_count_function(FP_V2_Generic_FP1109_0_infile)},															 
															 {LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + dt,file_count_function(LI_Generic_msn1210_1_infile)},
															 // {LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ dt,file_count_function(LI_Generic_msn1210_1_infile)},
															 {LI_Attributes_V4_XML_Generic_msn1106_0_outfile+ dt,file_count_function(LI_Generic_msn1210_1_infile)},
															 {LI_Scores_V4_XML_Generic_msn1106_0_outfile+ dt,file_count_function(LI_Generic_msn1210_1_infile)},
															 {LI_Scores_V4_BATCH_Generic_msn1106_0_outfile+ dt,file_count_function(LI_Generic_msn1210_1_infile)},
															 
															 // {RV_Attributes_V5_BATCH_CapOne_outfile + dt, file_count_function(RV_Attributes_V3_BATCH_CapOne_infile)},
																{RV_Scores_Attributes_V5_XML_Generic_outfile + dt, file_count_function(RV_V4_Generic_infile)},
																{Profile_Booster_Capone_outfile + dt, file_count_function(Profile_booster_Capone_infile)},
																{FP_V2_XML_American_Express_FP1109_0_outfile + dt, file_count_function(FP_V2_American_Express_FP1109_0_infile)},
																{AddressShell_Attributes_V1_BATCH_Generic_outfile	+ dt, file_count_function(AddressShell_Attributes_V1_BATCH_Generic_infile)},									 
																{BusinessShell_Attributes_V2_XML_Generic_outfile	+ dt, Business_Shell_infile_cnt},
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag1 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag2 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag3 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag4 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag5 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag6 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag7 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag8 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag9 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag10 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag11 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)},						 
																{FP_V3_XML_Generic_FP31505_0_outfile+ tag12 + dt, file_count_function(FP_V3_Generic_FP31505_0_infile)					 
															 															 }
															 
                             ],input_file_count_ds_rec),hash(file_name));
														 
														 // input_file_count_ds;
												

 
    string lib_fileservices__fslogicalfilename := string{maxlength(255)};
   
   layname := RECORD
      lib_fileservices__fslogicalfilename name;
     END;
		 
   lay1 := RECORD(layname)
     boolean superfile;
     integer8 size;
     integer8 rowcount;
     string19 modified;
     string owner{maxlength(255)};
     string cluster{maxlength(255)};
    END;
    
     
   ds1 := dataset('~scoringqa::out::files_'+ dt , lay1, thor);
   
   // ds1;
   
    result_lay:= record
   			string file_name;  
   			decimal19_2 Input_File_Count;
   			decimal19_2 curr_response_count;
   			decimal19_2 curr_response_count_pct;
   			end;
   
   join1 := join(ds1,input_file_count_ds,left.name=right.file_name,transform(recordof(result_lay),self.file_name:= right.file_name,
                                                                                                                 self.Input_File_Count:= right.Input_File_Count,   
   																																																							self.curr_response_count:= left.rowcount, 
   																																									self.curr_response_count_pct:= (left.rowcount/right.Input_File_Count)*100 
                ) );
   
   		
   				file1:=DATASET(RV_Attributes_V4_XML_Generic_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout,thor);
   				// file2:=DATASET(RV_Scores_V4_XML_ENOVA_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_ENOVA_rvg1103_0_V4_Global_Layout ,thor);
   				file3:=DATASET(RV_Scores_V4_XML_Generic_outfile + dt,  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout  ,thor);
   				// file4:=DATASET(RV_Scores_XML_Tmobile_rvt1212_1_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1212_1_v4_Global_Layout ,thor);
   				file5:=DATASET(RV_Scores_V3_XML_Generic_outfile+ dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout  ,thor);
   				// file6:=DATASET(RV_Scores_XML_Tmobile_rvt1210_1_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1210_1_v4_Global_Layout  ,thor);
   				file7:=DATASET(CBBL_Scores_XML_Chase_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_CBBL_Global_Layout ,thor);
   				// file8:=DATASET(RV_Attributes_V2_BATCH_CreditAcceptance_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_CreditAcceptancecorp_Attributes_V2_Global_Layout  ,thor);
   				// file9:=DATASET('~scoringqa::out::nonfcra::it60_xml_paro_msn605_'+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT60_Paro_Global_Layout  ,thor);
   			  // file10:=DATASET('~scoringqa::out::nonfcra::it60_batch_paro_msn605_'+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT60_Paro_Global_Layout  ,thor);
   				// file11:=DATASET('~scoringqa::out::nonfcra::it61_xml_paro_msn605_rsn804_'+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT61_Paro_Global_Layout  ,thor);
   				// file12:=DATASET('~scoringqa::out::nonfcra::it61_batch_paro_msn605_rsn804_'+ dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT61_Paro_Global_Layout ,thor);
   				// file13:=DATASET(RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile + dt,  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_RegionalAcceptance_RVA1008_1_V4_Global_Layout	 ,thor);
   			  // file14:=DATASET(RV_Scores_XML_Santander_1304_1_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Santander_RVA1304_1_V3_Global_Layout  ,thor);
   				file15:=DATASET(RV_Scores_V4_BATCH_Generic_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout  ,thor);
   				file16:=DATASET(RV_Scores_V3_BATCH_Generic_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V3_Global_Layout ,thor);
   				// file17:=DATASET(RV_Scores_XML_Santander_1304_2_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Santander_RVA1304_2_V3_Global_Layout  ,thor);
   			  file18:=DATASET(RV_Attributes_V3_BATCH_Generic_outfile + dt,  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout ,thor);
   				// file19:=DATASET(RV_Attributes_V2_BATCH_CapOne_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V2_Global_Layout ,thor);
   				file20:=DATASET(RV_Attributes_V4_BATCH_Generic_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Generic_Attributes_V4_Global_Layout  ,thor);
   				// file21:=DATASET(RV_Attributes_V3_BATCH_CapOne_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout ,thor);
   			  file22:=DATASET(RV_Attributes_V3_XML_Generic_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout ,thor);
   				// file23:=DATASET('~scoringqa::out::fcra::riskview_batch_generic_attributes_v2_'+ dt,  ,thor);
   				file24:=DATASET(RV_Attributes_V3_XML_Experian_outfile + dt,  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout ,thor);		
   				file25:=DATASET(RV_Attributes_V3_BATCH_Experian_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Experian_Attributes_V3_Global_Layout ,thor);		
   				// file26:=DATASET(FP_V2_XML_Generic_FP1109_0_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout ,thor);		
   				file27:=DATASET(LI_Scores_V4_BATCH_Generic_msn1106_0_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout ,thor);	
   				// file28:=DATASET(FP_V2_BATCH_Generic_FP1109_0_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout		  ,thor);		
   				file29:=DATASET(IID_Scores_V0_XML_Generic_outfile + dt,  Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout		,thor);		
   				file30:=DATASET(IID_Scores_V0_BATCH_Generic_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout		 ,thor);	
   				file31:=DATASET(BC10_Scores_XML_Chase_BNK4_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout	  ,thor);		
   				file32:=DATASET(BC10_Scores_BATCH_Chase_BNK4_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout  ,thor);		
   				file33:=DATASET(BIID_Scores_Batch_Chase_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_CHASE_BusinessInstantId_Global_Layout		 ,thor);	
   				file34:=DATASET(LI_Scores_V4_XML_Generic_msn1106_0_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout	  ,thor);		
   				file35:=DATASET(PRIO_Scores_XML_Chase_PIO2_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout	 ,thor);		
   				// file36:=DATASET('~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v3_'+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V3_Global_Layout			  ,thor);	
   				file37:=DATASET(PRIO_Scores_BATCH_Chase_PIO2_outfile+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout	  ,thor);		
   				// file38:=DATASET('~scoringqa::out::nonfcra::leadintegrity_batch_generic_attributes_v3_'+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V3_Global_Layout	  ,thor);		
   				file39:=DATASET(BIID_Scores_XML_Generic_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout	  ,thor);	
   				// file40:=DATASET(ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BestBuy_CDS_CDN1109_1_Global_Layout	 ,thor);	
   				file41:=DATASET(LI_Attributes_V4_XML_Generic_msn1106_0_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout	  ,thor);	
   				file42:=DATASET(BIID_Scores_BATCH_Generic_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout		  ,thor);	
   				file43:=DATASET(ITA_Attributes_V3_BATCH_CapOne_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout	 ,thor);	
   				file44:=DATASET(LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout	  ,thor);	
   				// file45:=DATASET(LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout	  ,thor);	
   								
							 // file46:=DATASET(RV_Attributes_V5_BATCH_CapOne_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout ,thor);	
																file47:=DATASET(RV_Scores_Attributes_V5_XML_Generic_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout ,thor);	
																file48:=DATASET(Profile_Booster_Capone_outfile + dt, Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout  ,thor);	
																file49:=DATASET(FP_V2_XML_American_Express_FP1109_0_outfile + dt, scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout,thor);	
																file50:=DATASET(AddressShell_Attributes_V1_BATCH_Generic_outfile	+ dt, Scoring_Project_Macros.Global_Output_Layouts.AddressShell_Attributes_V1_BATCH_Generic_Global_Layout	, thor);							 
																file51:=DATASET(BusinessShell_Attributes_V2_XML_Generic_outfile	+ dt,Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor);							 
																file52:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag1 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);					 
																file53:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag2 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);			 
																file54:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag3 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);						 
																file55:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag4 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);							 
																file56:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag5 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);						 
																file57:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag6 + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);								 
																file58:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag7 + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);								 
																file59:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag8 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);							 
																file60:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag9 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);						 
																file61:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag10 + dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);						 
																file62:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag11 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);						 
																file63:=DATASET(FP_V3_XML_Generic_FP31505_0_outfile + tag12 + dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout, thor);		
   							// count(length((string)file1.errorcode)>0)		       	  
   						// file1(errorcode='');
   						
   						
   								  file1_cnt_with_no_roxie_issues:=	count(file1( length(trim(errorcode,left,right))= 0 ));	
   								  // file2_cnt_with_no_roxie_issues:=	count(file2( length(trim(errorcode,left,right))= 0 ));	
    							  	file3_cnt_with_no_roxie_issues:=	count(file3( length(trim(errorcode,left,right))= 0 ));	
      								// file4_cnt_with_no_roxie_issues:=	count(file4( length(trim(errorcode,left,right))= 0 ));	
      								file5_cnt_with_no_roxie_issues:=	count(file5( length(trim(errorcode,left,right))= 0 ));	
      								// file6_cnt_with_no_roxie_issues:=	count(file6( length(trim(errorcode,left,right))= 0 ));
      								file7_cnt_with_no_roxie_issues:=	count(file7( length(trim(errorcode,left,right))= 0 ));	
      								// file8_cnt_with_no_roxie_issues:=	count(file8( length(trim(errorcode,left,right))= 0 ));	
      								// file9_cnt_with_no_roxie_issues:=	count(file9( length(trim(errorcode,left,right))= 0 ));
      								// file10_cnt_with_no_roxie_issues:=	count(file10( length(trim(errorcode,left,right))= 0 ));	
      								// file11_cnt_with_no_roxie_issues:=	count(file11( length(trim(errorcode,left,right))= 0 ));	
      								// file12_cnt_with_no_roxie_issues:=	count(file12( length(trim(errorcode,left,right))= 0 ));
      								// file13_cnt_with_no_roxie_issues:=	count(file13( length(trim(errorcode,left,right))= 0 ));	
      								// file14_cnt_with_no_roxie_issues:=	count(file14( length(trim(errorcode,left,right))= 0 ));	
      								file15_cnt_with_no_roxie_issues:=	count(file15( length(trim(errorcode,left,right))= 0 ));
      								file16_cnt_with_no_roxie_issues:=	count(file16( length(trim(errorcode,left,right))= 0 ));	
      								// file17_cnt_with_no_roxie_issues:=	count(file17( length(trim(errorcode,left,right))= 0 ));	
      								file18_cnt_with_no_roxie_issues:=	count(file18( length(trim(errorcode,left,right))= 0 ));
      								// file19_cnt_with_no_roxie_issues:=	count(file19( length(trim(errorcode,left,right))= 0 ));	
      								file20_cnt_with_no_roxie_issues:=	count(file20( length(trim(errorcode,left,right))= 0 ));	
      								// file21_cnt_with_no_roxie_issues:=	count(file21( length(trim(errorcode,left,right))= 0 ));	
      								file22_cnt_with_no_roxie_issues:=	count(file22( length(trim(errorcode,left,right))= 0 ));	
      								// file23_cnt_with_no_roxie_issues:=	count(file23( length(trim(errorcode,left,right))= 0 ));	
      								file24_cnt_with_no_roxie_issues:=	count(file24( length(trim(errorcode,left,right))= 0 ));	
      								file25_cnt_with_no_roxie_issues:=	count(file25( length(trim(errorcode,left,right))= 0 ));	
      								// file26_cnt_with_no_roxie_issues:=	count(file26( length(trim(errorcode,left,right))= 0 ));
      								file27_cnt_with_no_roxie_issues:=	count(file27( length(trim(errorcode,left,right))= 0 ));	
      								// file28_cnt_with_no_roxie_issues:=	count(file28( length(trim(errorcode,left,right))= 0 ));	
      								file29_cnt_with_no_roxie_issues:=	count(file29( length(trim(errorcode,left,right))= 0 ));
      								file30_cnt_with_no_roxie_issues:=	count(file30( length(trim(errorcode,left,right))= 0 ));	
      								file31_cnt_with_no_roxie_issues:=	count(file31( length(trim(errorcode,left,right))= 0 ));	
      								file32_cnt_with_no_roxie_issues:=	count(file32( length(trim(errorcode,left,right))= 0 ));
      								file33_cnt_with_no_roxie_issues:=	count(file33( length(trim(errorcode,left,right))= 0 ));	
      								file34_cnt_with_no_roxie_issues:=	count(file34( length(trim(errorcode,left,right))= 0 ));	
      								file35_cnt_with_no_roxie_issues:=	count(file35( length(trim(errorcode,left,right))= 0 ));
      								// file36_cnt_with_no_roxie_issues:=	count(file36( length(trim(errorcode,left,right))= 0 ));	
      								file37_cnt_with_no_roxie_issues:=	count(file37( length(trim(errorcode,left,right))= 0 ));	
      								// file38_cnt_with_no_roxie_issues:=	count(file38( length(trim(errorcode,left,right))= 0 ));
      								file39_cnt_with_no_roxie_issues:=	count(file39( length(trim(errorcode,left,right))= 0 ));	
      								// file40_cnt_with_no_roxie_issues:=	count(file40( length(trim(errorcode,left,right))= 0 ));	
      								file41_cnt_with_no_roxie_issues:=	count(file41( length(trim(errorcode,left,right))= 0 ));	
      								file42_cnt_with_no_roxie_issues:=	count(file42( length(trim(errorcode,left,right))= 0 ));	
      								file43_cnt_with_no_roxie_issues:=	count(file43( length(trim(errorcode,left,right))= 0 ));	
      								file44_cnt_with_no_roxie_issues:=	count(file44( length(trim(errorcode,left,right))= 0 ));	
      								
											// file46_cnt_with_no_roxie_issues:=	count(file46( length(trim(errorcode,left,right))= 0 ));	
      								file47_cnt_with_no_roxie_issues:=	count(file47( length(trim(errorcode,left,right))= 0 ));	
      								file48_cnt_with_no_roxie_issues:=	count(file48( length(trim(errorcode,left,right))= 0 ));	
      								file49_cnt_with_no_roxie_issues:=	count(file49( length(trim(errorcode,left,right))= 0 ));	
      								file50_cnt_with_no_roxie_issues:=	count(file50( length(trim(errorcode,left,right))= 0 ));	
      								file51_cnt_with_no_roxie_issues:=	count(file51( length(trim(errorcode,left,right))= 0 ));	
      								file52_cnt_with_no_roxie_issues:=	count(file52( length(trim(errorcode,left,right))= 0 ));	
      								file53_cnt_with_no_roxie_issues:=	count(file53( length(trim(errorcode,left,right))= 0 ));	
      								file54_cnt_with_no_roxie_issues:=	count(file54( length(trim(errorcode,left,right))= 0 ));	
      								file55_cnt_with_no_roxie_issues:=	count(file55( length(trim(errorcode,left,right))= 0 ));	
      								file56_cnt_with_no_roxie_issues:=	count(file56( length(trim(errorcode,left,right))= 0 ));	
      								file57_cnt_with_no_roxie_issues:=	count(file57( length(trim(errorcode,left,right))= 0 ));	
      								file58_cnt_with_no_roxie_issues:=	count(file58( length(trim(errorcode,left,right))= 0 ));	
      								file59_cnt_with_no_roxie_issues:=	count(file59( length(trim(errorcode,left,right))= 0 ));	
      								file60_cnt_with_no_roxie_issues:=	count(file60( length(trim(errorcode,left,right))= 0 ));	
      								file61_cnt_with_no_roxie_issues:=	count(file61( length(trim(errorcode,left,right))= 0 ));	
      								file62_cnt_with_no_roxie_issues:=	count(file62( length(trim(errorcode,left,right))= 0 ));	
      								file63_cnt_with_no_roxie_issues:=	count(file63( length(trim(errorcode,left,right))= 0 ));	
      						
      								
      												    
      			no_error_input_file_count_ds:=DATASET([ {RV_Attributes_V4_XML_Generic_outfile + dt,file1_cnt_with_no_roxie_issues},
                                     // {RV_Scores_V4_XML_ENOVA_outfile+ dt,file2_cnt_with_no_roxie_issues},
      															 {RV_Scores_V4_XML_Generic_outfile+ dt,file3_cnt_with_no_roxie_issues}, 																	
      															 // {RV_Scores_XML_Tmobile_rvt1212_1_outfile+ dt,file4_cnt_with_no_roxie_issues}, 
      															 {RV_Scores_V3_XML_Generic_outfile+ dt,file5_cnt_with_no_roxie_issues},    
      														   // {RV_Scores_XML_Tmobile_rvt1210_1_outfile+ dt,file6_cnt_with_no_roxie_issues}, 
                                     {CBBL_Scores_XML_Chase_outfile+ dt,file7_cnt_with_no_roxie_issues},    
      															 // {RV_Attributes_V2_BATCH_CreditAcceptance_outfile+ dt,file8_cnt_with_no_roxie_issues}, 
      															 // {'scoringqa::out::nonfcra::it60_xml_paro_msn605_'+ dt,file9_cnt_with_no_roxie_issues},   
      															 // {'scoringqa::out::nonfcra::it60_batch_paro_msn605_'+ dt,file10_cnt_with_no_roxie_issues}, 
      														   // {'scoringqa::out::nonfcra::it61_xml_paro_msn605_rsn804_'+ dt,file11_cnt_with_no_roxie_issues},   
      													     // {'scoringqa::out::nonfcra::it61_batch_paro_msn605_rsn804_'+ dt,file12_cnt_with_no_roxie_issues},
      												       // {RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile+ dt,file13_cnt_with_no_roxie_issues},  
      													     // {RV_Scores_XML_Santander_1304_1_outfile+ dt,file14_cnt_with_no_roxie_issues}, 
      													     {RV_Scores_V4_BATCH_Generic_outfile+ dt,file15_cnt_with_no_roxie_issues},
      													     {RV_Scores_V3_BATCH_Generic_outfile+ dt,file16_cnt_with_no_roxie_issues}, 
      												       // {RV_Scores_XML_Santander_1304_2_outfile+ dt,file17_cnt_with_no_roxie_issues},
      												    	 {RV_Attributes_V3_BATCH_Generic_outfile+ dt,file18_cnt_with_no_roxie_issues}, 
      												    	 // {RV_Attributes_V2_BATCH_CapOne_outfile+ dt,file19_cnt_with_no_roxie_issues},  
      										           {RV_Attributes_V4_BATCH_Generic_outfile+ dt,file20_cnt_with_no_roxie_issues}, 
      										         	 // {RV_Attributes_V3_BATCH_CapOne_outfile+ dt,file21_cnt_with_no_roxie_issues}, 
      										       	   {RV_Attributes_V3_XML_Generic_outfile+ dt,file22_cnt_with_no_roxie_issues}, 
      										        	 // {'scoringqa::out::fcra::riskview_batch_generic_attributes_v2_'+ dt,file23_cnt_with_no_roxie_issues}, 
      												       {RV_Attributes_V3_XML_Experian_outfile+ dt,file24_cnt_with_no_roxie_issues},
      											         {RV_Attributes_V3_BATCH_Experian_outfile+ dt,file25_cnt_with_no_roxie_issues} , 
      															 // {FP_V2_XML_Generic_FP1109_0_outfile+ dt,file26_cnt_with_no_roxie_issues},   
      													     {LI_Scores_V4_BATCH_Generic_msn1106_0_outfile+ dt,file27_cnt_with_no_roxie_issues},
      												       // {FP_V2_BATCH_Generic_FP1109_0_outfile+ dt,file28_cnt_with_no_roxie_issues},  
      													     {IID_Scores_V0_XML_Generic_outfile+ dt,file29_cnt_with_no_roxie_issues}, 
      													     {IID_Scores_V0_BATCH_Generic_outfile+ dt,file30_cnt_with_no_roxie_issues},																			 
      													     {BC10_Scores_XML_Chase_BNK4_outfile+ dt,file31_cnt_with_no_roxie_issues}, 
      												       {BC10_Scores_BATCH_Chase_BNK4_outfile+ dt,file32_cnt_with_no_roxie_issues},																			 
      												    	 {BIID_Scores_Batch_Chase_outfile+ dt,file33_cnt_with_no_roxie_issues}, 
      												    	 {LI_Scores_V4_XML_Generic_msn1106_0_outfile+ dt,file34_cnt_with_no_roxie_issues},  																			 
      										           {PRIO_Scores_XML_Chase_PIO2_outfile+ dt,file35_cnt_with_no_roxie_issues}, 
      										         	 // {'scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v3_'+ dt,file36_cnt_with_no_roxie_issues}, 																			 
      										       	   {PRIO_Scores_BATCH_Chase_PIO2_outfile+ dt,file37_cnt_with_no_roxie_issues}, 
      										        	 // {'scoringqa::out::nonfcra::leadintegrity_batch_generic_attributes_v3_'+ dt,file38_cnt_with_no_roxie_issues}, 																			 
      												       {BIID_Scores_XML_Generic_outfile+ dt,file39_cnt_with_no_roxie_issues}, 																				 
      											         // {ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile+ dt,file40_cnt_with_no_roxie_issues}  ,	
      												       {LI_Attributes_V4_XML_Generic_msn1106_0_outfile+ dt,file41_cnt_with_no_roxie_issues},   																			 
      													     {BIID_Scores_BATCH_Generic_outfile+ dt,file42_cnt_with_no_roxie_issues}, 
      													     {ITA_Attributes_V3_BATCH_CapOne_outfile+ dt,file43_cnt_with_no_roxie_issues},																			 
      													     {LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile+ dt,file44_cnt_with_no_roxie_issues}, 
      												       // {LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ dt,file45_cnt_with_no_roxie_issues}
      												       
																		 // {RV_Attributes_V5_BATCH_CapOne_outfile + dt,file46_cnt_with_no_roxie_issues},
      												       {RV_Scores_Attributes_V5_XML_Generic_outfile + dt,file47_cnt_with_no_roxie_issues},
      												       // {Profile_Booster_Capone_outfile + dt,file48_cnt_with_no_roxie_issues},
      												       {FP_V2_XML_American_Express_FP1109_0_outfile + dt,file49_cnt_with_no_roxie_issues},
      												       {AddressShell_Attributes_V1_BATCH_Generic_outfile	+ dt,file50_cnt_with_no_roxie_issues},
      												       {BusinessShell_Attributes_V2_XML_Generic_outfile	+ dt,file51_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag1 + dt,file52_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag2 + dt,file53_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag3 + dt,file54_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag4 + dt,file55_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag5 + dt,file56_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag6 + dt,file57_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag7 + dt,file58_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag8 + dt,file59_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag9 + dt,file60_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag10 + dt,file61_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag11 + dt,file62_cnt_with_no_roxie_issues},
      												       {FP_V3_XML_Generic_FP31505_0_outfile+ tag12 + dt,file63_cnt_with_no_roxie_issues}
                                   ],input_file_count_ds_rec);											
      														
      														// no_error_input_file_count_ds;
   
   												       																	 
   				
   join2 := join(no_error_input_file_count_ds,input_file_count_ds,left.file_name=right.file_name,transform(recordof(result_lay),self.file_name:= right.file_name,
                                                                                                                 self.Input_File_Count:= right.Input_File_Count,   
   																																																							self.curr_response_count:= left.input_file_count, 
   																																									self.curr_response_count_pct:= (left.input_file_count/right.Input_File_Count)*100 
                ) );
   
   
   
    filter:=70;
      							
      							flag:=join1(curr_response_count_pct<filter);
   								flag2:=join2(curr_response_count_pct<filter);
      				
      	MyRec := RECORD
         			INTEGER order;
         			STRING line;
         		END;
         
      
         		ds_no_diff := DATASET([{2, 'No differences under the ' + filter + '% threshold'+'\n\n'}], MyRec);
         		
      			
         		STRING filler := '                                                                                                                    ';
         
         		outfile_ds := IF(COUNT(flag) > 0,
         																			PROJECT(flag, TRANSFORM(MyRec, SELF.order := 2;
         																			SELF.line := (TRIM(LEFT.file_name) + filler)[1..75] + '\t' + LEFT.Input_File_Count + filler[1..20] + '\t' + LEFT.curr_response_count[1..20] + '\t' + 
      																				LEFT.curr_response_count_pct[1..20] ))
         																			);
         		outfile_ds2 := IF(COUNT(flag2) > 0,
         																			PROJECT(flag2, TRANSFORM(MyRec, SELF.order := 2;
         																			SELF.line := (TRIM(LEFT.file_name) + filler)[1..75] + '\t' + LEFT.Input_File_Count + filler[1..20] + '\t' + LEFT.curr_response_count[1..20] + '\t' + 
      																				LEFT.curr_response_count_pct[1..20] ))
         																			);			
       
         																			
         line_heading := ('file_name' ) + '\t\t\t\t\t\t\t\t\t\t\t\t\t\t' + 'Input_File_Count' + '\t' + 'curr_response_count'+ '\t' + 'curr_response_count_pct';
         
         		
      	 head_cert_realtime := DATASET([{1,    
      														''	+ '\n'
      												
      													+ line_heading + '\n'
      													+ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------'
      													}], MyRec); 			
      	 main_head_ds := DATASET([{3,   ' Data collection files response counts under '+ filter + '% threshold' + '\n'
         												 + '\n\n'
         													}], MyRec); 		
         main_head_ds2 := DATASET([{3,   ' Data collection files valid error codes response counts under '+ filter + '% threshold' + '\n'
         												 + '\n\n'
         													}], MyRec); 				
       
         
         output_ds_pjt := PROJECT(outfile_ds, TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
   
   	     output_ds_pjt2 := PROJECT(outfile_ds2, TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
      			
      	
   				
         output_ds:= IF(COUNT(flag) > 0,main_head_ds,ds_no_diff) + head_cert_realtime + output_ds_pjt ;
         		
         output_ds2:= IF(COUNT(flag2) > 0,main_head_ds2,ds_no_diff) + head_cert_realtime + output_ds_pjt2 ;
         		
     			
         		MyRec Xform_nonfcra(myrec L,myrec R) := TRANSFORM
         				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
         				self := l;
         		END;
         
         XtabOut_ds := ITERATE(output_ds, Xform_nonfcra(LEFT, RIGHT));
   					
   			 XtabOut_ds2 := ITERATE(output_ds2, Xform_nonfcra(LEFT, RIGHT));
           	
          			
	distr:= FileServices.SendEmail('Isabel.Ma@lexisnexisrisk.com; Matthew.Ludewig@lexisnexisrisk.com; Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com; Karen.Acuna@lexisnexisrisk.com; Lucky.Mores@lexisnexisrisk.com', 'Data Collection Response Counts Tracking Report ' , XtabOut_ds[COUNT(XtabOut_ds)].line);

	distr2:= FileServices.SendEmail('Isabel.Ma@lexisnexisrisk.com; Matthew.Ludewig@lexisnexisrisk.com; Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com; Karen.Acuna@lexisnexisrisk.com; Lucky.Mores@lexisnexisrisk.com', 'Data Collection Error code Response Counts Tracking Report ' , XtabOut_ds2[COUNT(XtabOut_ds2)].line);    		
   
  sequential( filenames_details1,IF(COUNT(flag) > 0,distr),IF(COUNT(flag2) > 0,distr2));
 

EXPORT Response_Counts_Tracking_Report := 'todo';