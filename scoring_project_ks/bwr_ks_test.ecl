import ut,std,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking;

rule_based_test := (real) 2.0;
//
// curr_date := ut.GetDate + '_1' ; //'20130908_1' ;
// prev_date := (string) ((integer4)ut.GetDate -1)  + '_1' ;

req_date := (STRING8)Std.Date.Today();


curr_date := req_date + '_1';
// prev_date := scoring_project_ks.get_past_date(req_date, 1) + '_1';


ds := 'scoringqa::bins::ks::';

Filenames_data := nothor(STD.File.LogicalFileList(ds + '*' + '_1_data', , TRUE));
Filenames_results := nothor(STD.File.LogicalFileList(ds + '*' + '_1_results', , TRUE));

Data_filelist := sort(Filenames_data, -modified);
Results_filelist := sort(Filenames_results, -modified);

Data_prev_filename := Data_filelist[2].name;
Results_prev_filename := Results_filelist[2].name;

prev_run := Data_prev_filename[length(Data_prev_filename)-14.. Length(Data_prev_filename)-7];

prev_date := prev_run + '_1';

results_rec :=RECORD
  string9 get_score_bin;
  string80 flagship;
  string80 model;
  integer8 file_count;
  string8 date_in;
  integer8 cnt_grp;
  real8 mean;
  real8 std_dev;
  integer8 max_value;
  integer8 min_value;
 END;



 data_rec := record

  string30 acctno; 
  string80 flagship; 
	string80 model;
	string80 score ;
end;
	



oneline := record string1000 line; string2 eor := '\r\n'; end;



// result1 := dataset('~ScoringQA::bins::ks::' + prev_date + '_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));

result1 := dataset('~' + ds + prev_run + '_1_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));
// result1 := dataset('~' + ds + '20210126_1_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));

result2 := dataset('~' + ds + req_date + '_1_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));
// result2 := dataset('~' + ds + '20210127_1_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));




score_data1 := distribute(dataset('~' + ds + prev_run + '_1_data', data_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'))),(integer)acctno);

score_data2 := distribute(dataset('~' + ds + req_date + '_1_data', data_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'))),(integer)acctno);


scores_project(ds,rec):=functionmacro
res:=project (ds, transform({  string80 product,string80 version, string80 process1,string80 customer, string80 model1,
			                                                                       recordof(rec) 
			                                     },

			                      self.product := 
														map( 
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_10k_v4' => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_v4 ' => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1212_1_v4 ' => 'RiskView' ,
														
														// left.flagship  = 'RiskView_xml_Santander_RVA1304_2_v3' => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_Santander_RVA1304_1_v3' => 'RiskView' ,		
														
														// left.flagship  = 'RiskView_xml_RegionalAcceptance_RVA1008_1_v4' => 'RiskView' ,			
														
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_auto'  	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_bank' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_money' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_retail' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_telecom' 	 => 'RiskView' , 
													  // left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_prescreen' 	 => 'RiskView' , 
														
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_auto'  	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_bank' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_money'	 => 'RiskView' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_retail' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_telecom'     => 'RiskView' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_prescreen'     => 'RiskView' ,

								
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_auto'  	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_bank' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_money'	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_retail' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_telecom'  => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_prescreen'  => 'RiskView' ,
														
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_auto'  	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_bank' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_money'	 => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_retail' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_telecom'  => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_prescreen'  => 'RiskView' ,

														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'auto_score'  	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'bankcard_score' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'short_term_lending_score'	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'telecommunications_score' 	 => 'RiskView' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'Crossindustry_score' 	 => 'RiskView' ,
														
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'auto_score'  	 => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'bankcard_score' 	 => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'short_term_lending_score'	 => 'RiskView' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'telecommunications_score' 	 => 'RiskView' ,
														
														// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1' => 'RiskView'  ,
														// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1_10k' => 'RiskView'  ,
															
														left.flagship  = 'BNK4_batch_chase_BD3605_0' => 'BNK4' ,
														left.flagship  = 'BNK4_xml_chase_BD3605_0' => 'BNK4'  ,
														left.flagship  = 'PI02_batch_chase_FP3710_0' => 'PIO2' ,
														left.flagship  = 'PI02_xml_chase_FP3710_0' => 'PIO2'  ,		
														left.flagship  = 'cbbl_xml_chase' => 'CBBL'  ,	
														
														left.flagship  = 'Chase_businessinstantid_batch_genericCust_Rec_' => 'NonFcra'  ,	

														left.flagship  = 'instantid_xml_generic' and left.model ='cvi' => 'InstantId'  ,
														left.flagship  = 'instantid_xml_generic' and left.model ='nap_summary' => 'InstantId'  ,
														left.flagship  = 'instantid_xml_generic' and left.model ='nas_summary' => 'InstantId'  , 
														
														left.flagship  = 'instantid_batch_generic' and left.model ='cvi' => 'InstantId'  ,
														left.flagship  = 'instantid_batch_generic' and left.model ='nap_summary' => 'InstantId'  ,
														left.flagship  = 'instantid_batch_generic' and left.model ='nas_summary' => 'InstantId'  , 



														left.flagship  = 'fraudpoint_xml_American_Express_fp1109_0_v201' => 'FraudPoint' ,
														// left.flagship  = 'fraudpoint_xml_generic_fp1109_0_v2' => 'FraudPoint' ,


/* FP v3 */
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapsd' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fls' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fla' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flaps' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapd' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flasd' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flpsd' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flap' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flps' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flsd' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flad' => 'FraudPoint' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flas' => 'FraudPoint' ,
/* FP v3  */

														
														// left.flagship  = 'fraudpoint_batch_generic_fp1109_0_v2' => 'FraudPoint' ,
														
														
														left.flagship  = 'IT61_xml_paro_MSN605_RSN804'  and left.model = 'score3'  => 'IT61' ,
														left.flagship  = 'IT61_xml_paro_MSN605_RSN804'  and left.model = 'score'  => 'IT61' ,
														
														left.flagship  = 'IT61_batch_paro_MSN605_RSN804'  and left.model = 'score3'  => 'IT61' ,
														left.flagship  = 'IT61_batch_paro_MSN605_RSN804'  and left.model = 'score'  => 'IT61' ,
														
														left.flagship  = 'IT60_xml_paro_Msn605'  and left.model = 'score3'  => 'IT60' ,
														left.flagship  = 'IT60_xml_paro_Msn605'  and left.model = 'score'  => 'IT60' ,
														
														left.flagship  = 'IT60_batch_paro_Msn605'  and left.model = 'score3'  => 'IT60' ,
														left.flagship  = 'IT60_batch_paro_Msn605'  and left.model = 'score'  => 'IT60' ,
														
														left.flagship  = 'leadintegrity_batch_generic_msn1106_0_v4'   => 'LeadIntegrity' ,
														
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bvi'  	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnap' 	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnas'	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnat'	 => 'BusinessInstantId' ,
														
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bvi'  	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnap' 	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnas'	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnat'	 => 'BusinessInstantId' ,
														
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bvi'  	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnap' 	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnas'	 => 'BusinessInstantId' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnat'	 => 'BusinessInstantId' ,
														
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bvi'  	 => 'BusinessInstantId' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnap' 	 => 'BusinessInstantId' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnas'	 => 'BusinessInstantId' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnat'	 => 'BusinessInstantId' ,
														
															// left.flagship  = 'RiskView_xml_enova_rvg1103_0_v4'  => 'RiskView' ,
															
															
															left.flagship = 'Small_Business_Analytics_SBOM1601_Attributes' => 'Small_Business_Analytics_SBFE',
															left.flagship = 'Small_Business_Analytics_SBBM1601_Attributes' => 'Small_Business_Analytics_SBFE',

															left.flagship = 'Small_Business_Analytics_SLBO1702_Attributes' => 'Small_Business_Analytics_NonSBFE',
															left.flagship = 'Small_Business_Analytics_SLBB1702_Attributes' => 'Small_Business_Analytics_NonSBFE',
															left.flagship = 'Small_Business_Analytics_SLBO1809_Attributes' => 'Small_Business_Analytics_NonSBFE',
															left.flagship = 'Small_Business_Analytics_SLBB1809_Attributes' => 'Small_Business_Analytics_NonSBFE',
															
   													left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bvi'  	 => 'BusinessInstantIdv2' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'rep1_cvi' 	 => 'BusinessInstantIdv2' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bus2exec_index_rep1'	 => 'BusinessInstantIdv2' ,

														left.flagship  = 'leadintegrity_xml_generic_msn1106_0_v4' => 'LeadIntegrity'  , left.flagship );
														
														  self.version := 
														map( 
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_10k_v4' => '' ,
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_v4' =>    '',
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1212_1_v4' =>    '',

														// left.flagship  = 'RiskView_xml_Santander_RVA1304_2_v3' => '' ,
														// left.flagship  = 'RiskView_xml_Santander_RVA1304_1_v3 ' => '' ,											
													
														
														// left.flagship  = 'RiskView_xml_RegionalAcceptance_RVA1008_1_v4 ' => '' ,

														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  => '3',
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  => '4',
														left.flagship  = 'RiskView_xml_generic_allflagships_v3' => '3',
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  => '4',
														
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  => '5',
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  => '5',

														// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1' => '',
															// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1_10k' => '',
															
														left.flagship  = 'BNK4_batch_chase_BD3605_0' => '',
														left.flagship  = 'BNK4_xml_chase_BD3605_0' => '',
														left.flagship  = 'PI02_batch_chase_FP3710_0' => '' ,
														left.flagship  = 'PI02_xml_chase_FP3710_0' => 	'',		
														left.flagship  = 'cbbl_xml_chase' => 	'',
														
																left.flagship  = 'Chase_businessinstantid_batch_genericCust_Rec_' => '0'  ,	
														left.flagship  = 'instantid_xml_generic' => '',
														
															left.flagship  = 'instantid_batch_generic'  => ''  ,
													
														// left.flagship  = 'fraudpoint_xml_generic_fp1109_0_v2' => '2',		
														left.flagship  = 'fraudpoint_xml_American_Express_fp1109_0_v201' => '201',		
														



	/* FP v3  */													
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapsd' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fls' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fla' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flaps' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapd' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flasd' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flpsd' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flap' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flps' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flsd' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flad' => '3' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flas' => '3' ,
	/* FP v3  */													
													
														left.flagship = 'Small_Business_Analytics_SBOM1601_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SBBM1601_Attributes' => '',

														left.flagship = 'Small_Business_Analytics_SLBO1702_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SLBB1702_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SLBO1809_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SLBB1809_Attributes' => '',
													
													
													// left.flagship  = 'fraudpoint_batch_generic_fp1109_0_v2' => '2' ,
																left.flagship  = 'IT61_xml_paro_MSN605_RSN804'    => '' ,	
																left.flagship  = 'IT61_batch_paro_MSN605_RSN804'    => '' ,	
																left.flagship  = 'IT60_xml_paro_Msn605'   => '' ,														
														left.flagship  = 'IT60_batch_paro_Msn605'  => '' ,													
														left.flagship  = 'leadintegrity_batch_generic_msn1106_0_v4'   => '4' ,														
														left.flagship  = 'businessinstantid_batch_generic'   	 => '0' ,									
														left.flagship  = 'businessinstantid_xml_generic'   	 => '0' ,													
														left.flagship  = 'businessinstantid_batch_Chase'  	 => '0' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'   	 => '0' ,																										
														left.flagship  = 'RiskView_xml_enova_rvg1103_0_v4'  =>'2',	
														
														left.flagship  = 'businessinstantidv2_xml_generic'   	 => '0' ,

														left.flagship  = 'leadintegrity_xml_generic_msn1106_0_v4' => '4','');

			                      

                            self.process1 := 
														map( 
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_10k_v4' => 'XML' ,
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_v4' =>    'XML',
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1212_1_v4' =>    'XML',

														// left.flagship  = 'RiskView_xml_Santander_RVA1304_2_v3' => 'XML' ,
														// left.flagship  = 'RiskView_xml_Santander_RVA1304_1_v3 ' => 'XML' ,											
													
														
														// left.flagship  = 'RiskView_xml_RegionalAcceptance_RVA1008_1_v4 ' => 'XML' ,

														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  => 'Batch',
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  => 'Batch',
														left.flagship  = 'RiskView_xml_generic_allflagships_v3' => 'XML',
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  => 'XML',
														
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  => 'XML',
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  => 'XML',

														// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1' => 'XML',
															// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1_10k' => 'XML',
															
														left.flagship  = 'BNK4_batch_chase_BD3605_0' => 'Batch',
														left.flagship  = 'BNK4_xml_chase_BD3605_0' => 'XML',
														left.flagship  = 'PI02_batch_chase_FP3710_0' => 'Batch' ,
														left.flagship  = 'PI02_xml_chase_FP3710_0' => 	'XML',		
														left.flagship  = 'cbbl_xml_chase' => 	'XML',
														
																left.flagship  = 'Chase_businessinstantid_batch_genericCust_Rec_' => 'Batch'  ,	
														left.flagship  = 'instantid_xml_generic' => 'XML',
															left.flagship  = 'instantid_batch_generic'  => 'Batch'  ,
													
														// left.flagship  = 'fraudpoint_xml_generic_fp1109_0_v2' => 'XML',	
														left.flagship  = 'fraudpoint_xml_American_Express_fp1109_0_v201' => 'XML',	
														
		/* FP v3  */													
														
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapsd' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fls' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fla' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flaps' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapd' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flasd' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flpsd' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flap' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flps' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flsd' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flad' => 'XML' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flas' => 'XML' ,
		/* FP v3  */						
		
		
		
		
														left.flagship = 'Small_Business_Analytics_SBOM1601_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SBBM1601_Attributes' => '',

														left.flagship = 'Small_Business_Analytics_SLBO1702_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SLBB1702_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SLBO1809_Attributes' => '',
														left.flagship = 'Small_Business_Analytics_SLBB1809_Attributes' => '',
		
															// left.flagship  = 'fraudpoint_batch_generic_fp1109_0_v2' => 'Batch' ,
																left.flagship  = 'IT61_xml_paro_MSN605_RSN804'    => 'XML' ,		
																left.flagship  = 'IT61_batch_paro_MSN605_RSN804'    => 'Batch' ,	
																left.flagship  = 'IT60_xml_paro_Msn605'   => 'XML' ,														
														left.flagship  = 'IT60_batch_paro_Msn605'  => 'Batch' ,													
														left.flagship  = 'leadintegrity_batch_generic_msn1106_0_v4'   => 'Batch' ,														
														left.flagship  = 'businessinstantid_batch_generic'   	 => 'Batch' ,									
														left.flagship  = 'businessinstantid_xml_generic'   	 => 'XML' ,													
														left.flagship  = 'businessinstantid_batch_Chase'  	 => 'Batch' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'   	 => 'XML' ,																										
														// left.flagship  = 'RiskView_xml_enova_rvg1103_0_v4'  =>'XML',			
														left.flagship  = 'businessinstantidv2_xml_generic'   	 => 'XML' ,														
													
														left.flagship  = 'leadintegrity_xml_generic_msn1106_0_v4' => 'XML','');
														
														 self.customer := 
														map( 
														left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_10k_v4' => 'T-Mobile_10k' ,
														left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_v4' => 'T-Mobile' ,
														left.flagship  = 'RiskView_xml_T_mobile_RVT1212_1_v4' => 'T-Mobile' ,

														left.flagship  = 'RiskView_xml_Santander_RVA1304_2_v3' => 'santander' ,
														left.flagship  = 'RiskView_xml_Santander_RVA1304_1_v3 ' => 'santander' ,
													
														left.flagship  = 'RiskView_xml_RegionalAcceptance_RVA1008_1_v4 ' => 'RegionalAcceptance' ,
														
															left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_auto'  	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_bank' 	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_money' 	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_retail' 	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_telecom' 	 => 'Generic' ,
													  // left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_prescreen'  => 'Generic' ,

														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_auto'  	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_bank' 	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_money'	 => 'Generic' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_retail' 	 => 'Generic' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_telecom'     => 'Generic' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_prescreen'  => 'Generic' ,
																									
														
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_auto'  	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_bank' 	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_money'	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_retail' 	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_telecom'  => 'Generic' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_prescreen'  => 'Generic' ,
														
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'auto_score'  	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'bankcard_score' 	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'short_term_lending_score'	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'telecommunications_score' 	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'Crossindustry_score' 	 => 'Generic' ,
																								
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'auto_score'  	 => 'Generic_Prescreen' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'bankcard_score' 	 => 'Generic_Prescreen' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'short_term_lending_score'	 => 'Generic_Prescreen' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'telecommunications_score' 	 => 'Generic_Prescreen' ,
														
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_auto'  	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_bank' 	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_money'	 => 'Generic' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_retail' 	 => 'Generic' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_telecom'  => 'Generic' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_prescreen'  => 'Generic' ,



														left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1' => 'BestBuy'  ,
														left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1_10k' => 'BestBuy_10k'  ,
															
														left.flagship  = 'BNK4_batch_chase_BD3605_0' => 'Chase' ,
														left.flagship  = 'BNK4_xml_chase_BD3605_0' => 'Chase'  ,
														left.flagship  = 'PI02_batch_chase_FP3710_0' => 'Chase' ,
														left.flagship  = 'PI02_xml_chase_FP3710_0' => 'Chase'  ,		
														left.flagship  = 'cbbl_xml_chase' => 'Chase'  ,	
														
														left.flagship  = 'Chase_businessinstantid_batch_genericCust_Rec_' => 'Chase'  ,	

														left.flagship  = 'instantid_xml_generic' and left.model ='cvi' => 'Generic'  ,
														left.flagship  = 'instantid_xml_generic' and left.model ='nap_summary' => 'Generic'  ,
														left.flagship  = 'instantid_xml_generic' and left.model ='nas_summary' => 'Generic'  , 
														
															left.flagship  = 'instantid_batch_generic' and left.model ='cvi' => 'Generic'  ,
														left.flagship  = 'instantid_batch_generic' and left.model ='nap_summary' => 'Generic'  ,
														left.flagship  = 'instantid_batch_generic' and left.model ='nas_summary' => 'Generic'  , 



														// left.flagship  = 'fraudpoint_xml_generic_fp1109_0_v2' => 'Generic'  ,
														left.flagship  = 'fraudpoint_xml_American_Express_fp1109_0_v201' => 'American_Express'  ,
														
														
														
				/* FP v3 */													
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapsd' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fls' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fla' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flaps' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapd' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flasd' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flpsd' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flap' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flps' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flsd' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flad' => 'Generic' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flas' => 'Generic' ,
					/* FP v3 */	
					
															// left.flagship  = 'fraudpoint_batch_generic_fp1109_0_v2' => 'Generic' ,
														
														
														left.flagship  = 'IT61_xml_paro_MSN605_RSN804'  and left.model = 'score3'  => 'Paro' ,
														left.flagship  = 'IT61_xml_paro_MSN605_RSN804'  and left.model = 'score'  => 'Paro' ,
														
														left.flagship  = 'IT61_batch_paro_MSN605_RSN804'  and left.model = 'score3'  => 'Paro' ,
														left.flagship  = 'IT61_batch_paro_MSN605_RSN804'  and left.model = 'score'  => 'Paro' ,
														
														left.flagship  = 'IT60_xml_paro_Msn605'  and left.model = 'score3'  => 'Paro' ,
														left.flagship  = 'IT60_xml_paro_Msn605'  and left.model = 'score'  => 'Paro' ,
														
														left.flagship  = 'IT60_batch_paro_Msn605'  and left.model = 'score3'  => 'Paro' ,
														left.flagship  = 'IT60_batch_paro_Msn605'  and left.model = 'score'  => 'Paro' ,
														
														left.flagship  = 'leadintegrity_batch_generic_msn1106_0_v4'   => 'Generic' ,
														
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bvi'  	 => 'Generic' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnap' 	 => 'Generic' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnas'	 => 'Generic' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnat'	 => 'Generic' ,
														
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bvi'  	 => 'Generic' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnap' 	 => 'Generic' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnas'	 => 'Generic' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnat'	 => 'Generic' ,
														
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bvi'  	 => 'Chase' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnap' 	 => 'Chase' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnas'	 => 'Chase' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnat'	 => 'Chase' ,
														
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bvi'  	 => 'Generic1' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnap' 	 => 'Generic1' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnas'	 => 'Generic1' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnat'	 => 'Generic1' ,
														
															// left.flagship  = 'RiskView_xml_enova_rvg1103_0_v4'  => 'Enova' ,
															
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bvi'	 => 'Generic' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'rep1_cvi'	 => 'Generic' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bus2exec_index_rep1'	 => 'Generic' ,
		
														left.flagship = 'Small_Business_Analytics_SBOM1601_Attributes' => 'Generic',
														left.flagship = 'Small_Business_Analytics_SBBM1601_Attributes' => 'Generic',

														left.flagship = 'Small_Business_Analytics_SLBO1702_Attributes' => 'Generic',
														left.flagship = 'Small_Business_Analytics_SLBB1702_Attributes' => 'Generic',
														left.flagship = 'Small_Business_Analytics_SLBO1809_Attributes' => 'Generic',
														left.flagship = 'Small_Business_Analytics_SLBB1809_Attributes' => 'Generic',
		
												
														left.flagship  = 'leadintegrity_xml_generic_msn1106_0_v4' => 'Generic'  , '' );
														
														
                            self.model1 := 
														map( 
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_10k_v4' => 'rvt1210_1' ,
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1210_1_v4' =>    'rvt1210_1',
														// left.flagship  = 'RiskView_xml_T_mobile_RVT1212_1_v4' =>    'rvt1212_1',

														// left.flagship  = 'RiskView_xml_Santander_RVA1304_2_v3' => 'rva1304_2' ,
														// left.flagship  = 'RiskView_xml_Santander_RVA1304_1_v3' => 'rva1304_1' ,
														
													
														
														// left.flagship  = 'RiskView_xml_RegionalAcceptance_RVA1008_1_v4' => 'rva1008_1' ,

														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_auto'  	 => 'rva1104_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_bank' 	 => 'rvb1104_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_money' 	 => 'rvg1103_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_retail' 	 => 'rvr1103_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_telecom' 	 => 'rvt1104_0' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v4'  and left.model = 'rv_score_prescreen'  => 'rvp1104_0' ,

														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_auto'  	 => 'rva1003_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_bank' 	 => 'rvb1003_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_money'	 => 'rvg1003_0' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_retail' 	 => 'rvr1003_0' ,
														left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_telecom'     => 'rvt1003_0' ,
														// left.flagship  = 'RiskView_batch_generic_allflagships_v3'  and left.model = 'rv_score_prescreen'  => 'rvp1003_0' ,
																									
														
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_auto'  	 => 'rva1104_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_bank' 	 => 'rvb1104_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_money'	 => 'rvg1103_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_retail' 	 => 'rvr1103_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_telecom'  => 'rvt1104_0' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v4'  and left.model = 'rv_score_prescreen'  => 'rvp1104_0' ,

														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_auto'  	 => 'rva1003_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_bank' 	 => 'rvb1003_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_money'	 => 'rvg1003_0' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_retail' 	 => 'rvr1003_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_telecom'  => 'rvt1003_0' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_v3'  and left.model = 'rv_score_prescreen'  => 'rvp1003_0' ,

														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'auto_score'  	 => 'RVA1503_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'bankcard_score' 	 => 'RVB1503_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'short_term_lending_score'	 => 'RVG1502_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'telecommunications_score' 	 => 'RVT1503_0' ,
														left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5'  and left.model = 'Crossindustry_score' 	 => 'RVS1706_0' ,
														
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'auto_score'  	 => 'RVA1503_0' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'bankcard_score' 	 => 'RVB1503_0' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'short_term_lending_score'	 => 'RVG1502_0' ,
														// left.flagship  = 'RiskView_xml_generic_allflagships_attributes_v5_prescreen'  and left.model = 'telecommunications_score' 	 => 'RVT1503_0' ,
													
														// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1' => 'CDN1109_1'  ,
														// left.flagship  = 'ChargebackDefender_xml_BestBuy_CDN1109_1_10k' => 'CDN1109_1'  ,
															
														left.flagship  = 'BNK4_batch_chase_BD3605_0' => 'fd_score' ,
														left.flagship  = 'BNK4_xml_chase_BD3605_0' => 'fd_score'  ,
														left.flagship  = 'PI02_batch_chase_FP3710_0' => 'fp_score' ,
														left.flagship  = 'PI02_xml_chase_FP3710_0' => 'fp_score'  ,		
														left.flagship  = 'cbbl_xml_chase' and left.model ='cmpyaddrscore' => 'fp_score'  ,	
														left.flagship  = 'cbbl_xml_chase' and left.model ='ecovariables' => 'fd_score'  ,	
														
														left.flagship  = 'Chase_businessinstantid_batch_genericCust_Rec_' => 'biid'  ,	

														left.flagship  = 'instantid_xml_generic' and left.model ='cvi' => 'cvi'  ,
														left.flagship  = 'instantid_xml_generic' and left.model ='nap_summary' => 'nap'  ,
														left.flagship  = 'instantid_xml_generic' and left.model ='nas_summary' => 'nas'  , 

	                         left.flagship  = 'instantid_batch_generic' and left.model ='cvi' => 'cvi'  ,
														left.flagship  = 'instantid_batch_generic' and left.model ='nap_summary' => 'nap'  ,
														left.flagship  = 'instantid_batch_generic' and left.model ='nas_summary' => 'nas'  , 

														// left.flagship  = 'fraudpoint_xml_generic_fp1109_0_v2' => 'fp1109_0'  ,
														left.flagship  = 'fraudpoint_xml_American_Express_fp1109_0_v201' => 'fp1109_0'  ,
														
			/* FP v3 */												
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapsd'  => 'fp31505_0_flapsd' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fls' => 'fp31505_0_fls' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_fla'  => 'fp31505_0_fla' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flaps'  => 'fp31505_0_flaps' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flapd'  => 'fp31505_0_flapd' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flasd'  => 'fp31505_0_flasd' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flpsd'  => 'fp31505_0_flpsd' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flap'  => 'fp31505_0_flap' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flps'  => 'fp31505_0_flps' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flsd'  => 'fp31505_0_flsd' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flad'  => 'fp31505_0_flad' ,
														left.flagship  = 'fraudpoint_xml_generic_fp31505_0_v3_flas'  => 'fp31505_0_flas' ,


			/* FP v3 */												
															// left.flagship  = 'fraudpoint_batch_generic_fp1109_0_v2' => 'fp1109_0' ,
														
														
														left.flagship  = 'IT61_xml_paro_MSN605_RSN804'  and left.model = 'score3'  => 'score3' ,
														left.flagship  = 'IT61_xml_paro_MSN605_RSN804'  and left.model = 'score'  => 'score1' ,
														
														left.flagship  = 'IT61_batch_paro_MSN605_RSN804'  and left.model = 'score3'  => 'score3' ,
														left.flagship  = 'IT61_batch_paro_MSN605_RSN804'  and left.model = 'score'  => 'score1' ,
														
														left.flagship  = 'IT60_xml_paro_Msn605'  and left.model = 'score3'  => 'score3' ,
														left.flagship  = 'IT60_xml_paro_Msn605'  and left.model = 'score'  => 'score1' ,
														
														left.flagship  = 'IT60_batch_paro_Msn605'  and left.model = 'score3'  => 'score3' ,
														left.flagship  = 'IT60_batch_paro_Msn605'  and left.model = 'score'  => 'score1' ,
														
														left.flagship  = 'leadintegrity_batch_generic_msn1106_0_v4'   => 'msn1106_0' ,
														
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bvi'  	 => 'bvi' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnap' 	 => 'bnap' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnas'	 => 'bnas' ,
														left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnat'	 => 'bnat' ,
														
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bvi'  	 => 'bvi' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnap' 	 => 'bnap' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnas'	 => 'bnas' ,
														left.flagship  = 'businessinstantid_xml_generic'  and left.model = 'bnat'	 => 'bnat' ,
														
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bvi'  	 => 'bvi' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnap' 	 => 'bnap' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnas'	 => 'bnas' ,
														left.flagship  = 'businessinstantid_batch_Chase'  and left.model = 'bnat'	 => 'bnat' ,
														
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bvi'  	 => 'bvi' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnap' 	 => 'bnap' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnas'	 => 'bnas' ,
														// left.flagship  = 'businessinstantid_xml_genericGeneric_'  and left.model = 'bnat'	 => 'bnat' ,
														
															// left.flagship  = 'RiskView_xml_enova_rvg1103_0_v4'  => 'rvg1103_0' ,
															
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bvi'  	 => 'bvi' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'rep1_cvi' 	 => 'rep1_cvi' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bus2exec_index_rep1'	 => 'bus2exec_index_rep1' ,


														left.flagship = 'Small_Business_Analytics_SBOM1601_Attributes' => 'SBOM1601',
														left.flagship = 'Small_Business_Analytics_SBBM1601_Attributes' => 'SBBM1601',

														left.flagship = 'Small_Business_Analytics_SLBO1702_Attributes' => 'SLBO1702',
														left.flagship = 'Small_Business_Analytics_SLBB1702_Attributes' => 'SLBB1702',
														left.flagship = 'Small_Business_Analytics_SLBO1809_Attributes' => 'SLBO1809',
														left.flagship = 'Small_Business_Analytics_SLBB1809_Attributes' => 'SLBB1809',

														
														left.flagship  = 'leadintegrity_xml_generic_msn1106_0_v4' => 'msn1106_0'  , '' );
														
														self := left ));
														
														return res;
														endmacro;
														

														
score_data1_project_1:=scores_project(score_data1,data_rec);

score_data1_project:=score_data1_project_1(score<>'');
// score_data1_project;

// score_data1_project(score='-2');


 		test_rec := record
   
     score_data1_project.product; 
   	score_data1_project.version;
   	score_data1_project.process1 ;
   	score_data1_project.customer ;
   	score_data1_project.model1 ;
   	decimal19_2 max_scr:=min(group,score_data1_project.score );
   		decimal19_2 min_scr:=max(group,score_data1_project.score )
   	
   end;
   											 
    	test:=  table(score_data1_project,test_rec,product,version,process1,customer,model1);
   	output(test);
   	// test;

					


score_data2_project_1:=scores_project(score_data2,data_rec);

score_data2_project:=score_data2_project_1( score<>'' );
// score_data2_project(score<='0');
   	// count(score_data2_project);
score_name_1_layout:= record
					
  string30 acctno; 
  string80 product; 
	string80 version;
	string80 process1 ;
	string80 customer ;
	string80 model1 ;
	string80 prev_score;
	string80 curr_score;
	string80 score_name_1;
		
			end;
			
score_name_1_layout_ds:=join(score_data1_project,score_data2_project,	left.acctno=right.acctno and 
											                           left.product=right.product and 
											                           left.version=right.version and
																								  left.process1=right.process1 and 
											                           left.customer=right.customer and
																								   left.model1=right.model1,
																								 
																								 			transform(recordof(score_name_1_layout),
																											self.prev_score 	:= left.score ;
			                                                self.curr_score := right.score;
																                  // self.curr_score_valid_and_prev_score_default:=   if((right.product='RiskView' and right.score not in ['100','101','102','103','104','200','210','222'] )and
																											                                                 // (left.product='RiskView' and left.score  in ['100','101','102','103','104','200','210','222']),'true','false');
																										// self.curr_score_default_and_prev_score_valid:=   if((right.product='RiskView' and right.score  in ['100','101','102','103','104','200','210','222'])and
																											                                                 // (left.product='RiskView' and left.score not in ['100','101','102','103','104','200','210','222']),'true','false');	
																										self.score_name_1:=		   if(left.score=right.score,'true','false');																							 
																											
																											self:=left;
																								 ),inner);
																								 
																								 // Perc_To_Default_layout_ds;
																								 
																								 // Perc_To_Default_layout_ds(curr_score_default_and_prev_score_valid='true' or curr_score_valid_and_prev_score_default ='true');
																								 
																								 
 	score_name_layout :=record
   	  // Perc_To_Default_layout_ds. acctno; 
     score_name_1_layout_ds. product; 
   	score_name_1_layout_ds. version;
   	score_name_1_layout_ds. process1 ;
   	score_name_1_layout_ds. customer ;
   	score_name_1_layout_ds. model1 ;
   	// decimal19_2 To_Default:=COUNT(group,Perc_To_Default_layout_ds.curr_score_valid_and_prev_score_default='true' );
   	
   	 
   	// decimal19_2 From_Default:=COUNT(group,Perc_To_Default_layout_ds.curr_score_default_and_prev_score_valid='true');
		
			decimal19_2 score_name:=COUNT(group,score_name_1_layout_ds.score_name_1='true');
		
   	
   	
   	
   	end;
   	
   	score_name_layout_ds:= table(score_name_1_layout_ds,score_name_layout,product,version,process1,customer,model1);
		
		
		// score_name_layout_ds;
   	
  // score_name_1_layout_ds;

// score_data1_project;

score_result1_project:=scores_project(result1,results_rec);

defalut_ds_1_rv:=score_result1_project(product='RiskView'  and get_score_bin in ['100','101','102','103','104','200','210','222']);

defalut_ds_1_li:=score_result1_project(product='LeadIntegrity' and get_score_bin in ['200','210']);

defalut_ds_1:=defalut_ds_1_rv + defalut_ds_1_li;

// score_result1_project;
score_result2_project:=scores_project(result2,results_rec);

defalut_ds_2_rv:=score_result2_project(product='RiskView'  and get_score_bin in ['100','101','102','103','104','200','210','222']);

defalut_ds_2_li:=score_result2_project(product='LeadIntegrity' and get_score_bin in ['200','210']);

defalut_ds_2:=defalut_ds_2_rv + defalut_ds_2_li;

default_rec_1 := record

  defalut_ds_1.product; 
	defalut_ds_1.version;
	defalut_ds_1.process1 ;
	defalut_ds_1.customer ;
	defalut_ds_1.model1 ;
	decimal19_2 prev_default:=sum(group,defalut_ds_1.cnt_grp);

end;
											 
 	default_rec_ds_1:=  table(defalut_ds_1,default_rec_1,product,version,process1,customer,model1);

default_rec_2 := record

  defalut_ds_2.product; 
	defalut_ds_2.version;
	defalut_ds_2.process1 ;
	defalut_ds_2.customer ;
	defalut_ds_2.model1 ;
	decimal19_2 curr_default:=sum(group,defalut_ds_2.cnt_grp);

end;
											 
 	default_rec_ds_2:=  table(defalut_ds_2,default_rec_2,product,version,process1,customer,model1);
	
	// default_rec_ds_2;

// count(score_data1_project);

// score_data1_project;
score_data1_project_rv:=score_data1_project(product='RiskView' and (decimal19_2)score not in [100,101,102,103,104,200,210,222] and (decimal19_2)score >0  
                                                               and (decimal19_2)score  >=500 and  (decimal19_2)score  <=900    
																															 
                                            );
score_data1_project_fp:=score_data1_project(product='FraudPoint'  and (decimal19_2)score >=300  
                                                                  and (decimal19_2)score  <=999   
																															 
                                            );	
																						
							// score_data1_project_fp;															
score_data1_project_bnk4:=score_data1_project(product='BNK4' and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999    
                                                                
																															 
                                            );
score_data1_project_pio2:=score_data1_project(product='PIO2' and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999    
                                                                  
																															 
                                            );
score_data1_project_cbbl:=score_data1_project(product='CBBL'   and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999    
																															 
                                            );																						
																						
score_data1_project_li:=score_data1_project(product='LeadIntegrity' and (decimal19_2)score  not in [200,210] and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999    
                                                              
																															 
                                            );	
score_data1_project_biid:=score_data1_project(product='BusinessInstantId' and  model1='bvi'   
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50 
																															 
                                            );	
score_data1_project_biid1:=score_data1_project(product='BusinessInstantId' and  (model1='bnap'  or  model1='bnas' or model1='bnat')
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=12 
																															 
                                            );			
																						
score_data1_project_iid:=score_data1_project(product='InstantId' and  model1='cvi'   
                                                             and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50
																															 
                                            );	
score_data1_project_iid1:=score_data1_project(product='InstantId' and  (model1='nap'  or  model1='nas')
                                                               and (decimal19_2)score  >=0 and  (decimal19_2)score  <=12 
																															 
                                            );	
																						
score_data1_project_biidv2:=score_data1_project(product='BusinessInstantIdv2' and  (model1='bvi'  or  model1='rep1_cvi' or model1='bus2exec_index_rep1')   
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50 
																															 
                                            );	
																						
																						
score_data1_project_sba := score_data1_project((product='Small_Business_Analytics_SBFE' or product='Small_Business_Analytics_NonSBFE') and (decimal19_2)score not in [222] and (decimal19_2)score >0 and  (decimal19_2)score  <=900 

											);
																						
score_data1_project_non_rv:=score_data1_project(product='IT60' or product='IT61' and (decimal19_2)score >=-1 and (decimal19_2)score  <=999);				
																	

score_data2_project_rv:=score_data2_project(product='RiskView' and (decimal19_2)score  not in [100,101,102,103,104,200,210,222] and (decimal19_2)score >0  
                                                               and (decimal19_2)score  >=500 and  (decimal19_2)score  <=900    
																															 
                                            );
score_data2_project_fp:=score_data2_project(product='FraudPoint'  and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999   
                                                                 
																															 
                                            );	
score_data2_project_bnk4:=score_data2_project(product='BNK4' and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999  
                                                               
																															 
                                            );
score_data2_project_pio2:=score_data2_project(product='PIO2' and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999    
                                                               
																															 
                                            );
score_data2_project_cbbl:=score_data2_project(product='CBBL' and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999  
                                                                
																															 
                                            );
																						
score_data2_project_li:=score_data2_project(product='LeadIntegrity' and (decimal19_2)score  not in [200,210] and (decimal19_2)score  >=300 and  (decimal19_2)score  <=999    
                                                             
																															 
                                            );	
score_data2_project_biid:=score_data2_project(product='BusinessInstantId' and  model1='bvi'   
                                                                and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50
																															 
                                            );	
score_data2_project_biid1:=score_data2_project(product='BusinessInstantId' and  (model1='bnap'  or  model1='bnas' or model1='bnat')
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=12 
																															 
                                            );			
																						
score_data2_project_iid:=score_data2_project(product='InstantId' and  model1='cvi'   
                                                                and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50
																															 
                                            );	
score_data2_project_iid1:=score_data2_project(product='InstantId' and  (model1='nap'  or  model1='nas')
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=12 
																															 
                                            );	
																						
score_data2_project_biidv2:=score_data2_project(product='BusinessInstantIdv2' and  (model1='bvi'  or  model1='rep1_cvi' or model1='bus2exec_index_rep1')   
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50 
																															 
                                            );	

score_data2_project_non_rv:=score_data2_project(product='IT60' or product='IT61' and (decimal19_2)score >=-1 and (decimal19_2)score  <=999);


score_data2_project_sba := score_data2_project((product='Small_Business_Analytics_SBFE' or product='Small_Business_Analytics_NonSBFE') and (decimal19_2)score not in [222] and (decimal19_2)score >0 and  (decimal19_2)score  <=900 

											);



score_data1_project_rv_default:=score_data1_project(product='RiskView' and (decimal19_2)score  in [-2] );

score_data1_project_li_default:=score_data1_project(product='LeadIntegrity' and (decimal19_2)score  in [-2] );

score_data2_project_rv_default:=score_data2_project(product='RiskView' and (decimal19_2)score   in [-2] );

score_data2_project_li_default:=score_data2_project(product='LeadIntegrity' and (decimal19_2)score  in [-2] );


				// score_data1_project_rv_default;
				
				
	// qq:=			score_data1_project( score in ['100','101','102','103','104','200','210','222'] );
	
	// qq;
		
// count(score_data1_project_rv);
// count(score_data1_project_non_rv);

		
		dataset_prev:=score_data1_project_rv + score_data1_project_fp + score_data1_project_bnk4 + score_data1_project_pio2 + score_data1_project_cbbl + 
		score_data1_project_li + score_data1_project_biid +score_data1_project_biid1 +  score_data1_project_iid +  score_data1_project_iid1 +  score_data1_project_non_rv + score_data1_project_biidv2 + score_data1_project_sba;

		dataset_curr:=score_data2_project_rv + score_data2_project_fp + score_data2_project_bnk4 + score_data2_project_pio2 + score_data2_project_cbbl +  score_data2_project_li + score_data2_project_biid + 			               
		              score_data2_project_biid1 +  score_data2_project_iid +  score_data2_project_iid1 +  score_data2_project_non_rv + score_data2_project_biidv2 + score_data2_project_sba;


					// test_rec := record

  // dataset_prev.product; 
	// dataset_prev.version;
	// dataset_prev.process1 ;
	// dataset_prev.customer ;
	// dataset_prev.model1 ;
	// decimal19_2 max_scr:=min(group,dataset_prev.score );
		// decimal19_2 min_scr:=max(group,dataset_prev.score )
	
// end;
											 
 	// test:=  table(dataset_prev,test_rec,product,version,process1,customer,model1);
	
	// test;
								
		
		
		
// score_data1_project_non_rv_default:=score_data1_project(product<>'RiskView'and score > '0');
// score_data2_project_non_rv_default:=score_data2_project(product<>'RiskView'and score > '0');
		
dataset_prev_default :=score_data1_project_rv_default + score_data1_project_li_default ;
dataset_curr_default :=score_data2_project_rv_default + score_data2_project_li_default;

// count( dataset_prev_default);



To_Default_layout:= record
					
  string30 acctno; 
  string80 product; 
	string80 version;
	string80 process1 ;
	string80 customer ;
	string80 model1 ;
	string80 curr_score_valid;
	string80 prev_score_default;
				
			end;
			
To_Default_layout_ds:=join(dataset_curr_default,dataset_prev,	left.acctno=right.acctno and 
											                           left.product=right.product and 
											                           left.version=right.version and
																								  left.process1=right.process1 and 
											                           left.customer=right.customer and
																								   left.model1=right.model1,
																								 
																								 			transform(recordof(To_Default_layout),
																											self.curr_score_valid 	:= left.score ;
			                                                self.prev_score_default := right.score;
																                 																				 
																											
																											self:=left;
																								 ),inner);
																								 
	
				count_to_default_rec := record

  To_Default_layout_ds.product; 
	To_Default_layout_ds.version;
	To_Default_layout_ds.process1 ;
	To_Default_layout_ds.customer ;
	To_Default_layout_ds.model1 ;
	decimal19_2 count_to_default:=count(group,To_Default_layout_ds.curr_score_valid <> '-1');

end;
											 
 	count_to_default_rec_ds:=  table(To_Default_layout_ds,count_to_default_rec,product,version,process1,customer,model1);
	
	// count_to_default_rec_ds;
	
		From_Default_layout:= record					
  string30 acctno; 
  string80 product; 
	string80 version;
	string80 process1 ;
	string80 customer ;
	string80 model1 ;
	string80 curr_score_default;
	string80 prev_score_valid;	
			end;
			
From_Default_layout_ds:=join(dataset_curr,dataset_prev_default,	left.acctno=right.acctno and 
											                           left.product=right.product and 
											                           left.version=right.version and
																								  left.process1=right.process1 and 
											                           left.customer=right.customer and
																								   left.model1=right.model1,
																								 
																								 			transform(recordof(From_Default_layout),
																											self.curr_score_default 	:= left.score ;
			                                                self.prev_score_valid := right.score;
																                 																				 
																											
																											self:=left;
																								 ),inner);	
																								 
count_from_default_rec := record

  from_Default_layout_ds.product; 
	from_Default_layout_ds.version;
	from_Default_layout_ds.process1 ;
	from_Default_layout_ds.customer ;
	from_Default_layout_ds.model1 ;
	decimal19_2 count_from_default:=count(group,from_Default_layout_ds.curr_score_default <> '-1');

end;
											 
 	count_from_default_rec_ds:=  table(from_Default_layout_ds,count_from_default_rec,product,version,process1,customer,model1);																					 
																								 
// To_Default_layout_ds;

// From_Default_layout_ds;
		
avg_layout_prev:= record
	  dataset_prev.product;
	  dataset_prev.version;
	  dataset_prev.process1;
	  dataset_prev.customer;
  // dataset_prev.flagship;
	  dataset_prev.model1;
	// dataset_prev.score;
	// decimal19_2 prev_response_count := count(group,dataset_prev.score >'0');
	decimal10_5 prev_mean:= ave(group,(real)dataset_prev.score );
	decimal19_2	prev_std_dev   := sqrt(variance(group, (real) dataset_prev.score ));
	decimal19_2 prev_max_value := max(group,dataset_prev.score );
	decimal19_2 prev_min_value := min(group,dataset_prev.score );
	
		end;
		
			avg_layout_curr:= record
  dataset_curr.product;
  dataset_curr.version;
	dataset_curr.process1;
	dataset_curr.customer;
  // dataset_curr.flagship;
	dataset_curr.model1;
	// dataset_curr.score;
	// decimal19_2 curr_response_count := count(group,dataset_curr.score >'0');
	decimal19_2 curr_mean:= ave(group,(real)dataset_curr.score );
	decimal19_2	curr_std_dev   := sqrt(variance(group, (real) dataset_curr.score ));
	decimal19_2 curr_max_value := max(group,dataset_curr.score );
	decimal19_2 curr_min_value := min(group,dataset_curr.score );
	
		end;
		
		avg_dataset_prev:=  table(dataset_prev,avg_layout_prev,product,version,process1,customer,model1);
		avg_dataset_curr:=  table(dataset_curr,avg_layout_curr,product,version,process1,customer,model1);
		
		// avg_dataset_prev;
		// avg_dataset_curr;
		
dual_rec := record
			string30 acctno; 
			string80 product; 
			string80 version;
			string80 process1 ;
			string80 customer ;
			string80 model1 ;
			string80 prev_dual_valid;
			string80 curr_dual_valid ;
			decimal19_2 curr_dual_valid_prev_dual_valid;
			decimal19_2 _count;	
end;
		 
											 
							dual_rec_ds:=				 join(dataset_prev,dataset_curr,left.acctno=right.acctno and 
																															left.product=right.product and 
																															left.version=right.version and
																															left.process1=right.process1 and 
																															left.customer=right.customer and
																															left.model1=right.model1,
																									transform(recordof(dual_rec),
																																			self.prev_dual_valid 	:= left.score ;
																																			self.curr_dual_valid := right.score;
																																			self.curr_dual_valid_prev_dual_valid:= (decimal19_2)right.score- (decimal19_2)left.score;
																																			self._count := 0;
																																			self:=left;
																																 ),inner);
																								 

											 
ds_sort := sort(		dual_rec_ds,version,process1,customer,model1,  acctno		);				
roll := rollup(		ds_sort, left.acctno=right.acctno and 
																															left.product=right.product and 
																															left.version=right.version and
																															left.process1=right.process1 and 
																															left.customer=right.customer and
																															left.model1=right.model1	, transform(recordof(dual_rec), self._count := left._count+right._count; self := left;));
												
	dual_rec_mean := RECORD
			roll.product; 
			roll.version;
			roll.process1 ;
			roll.customer ;
			roll.model1 ;
			decimal19_2 Dual_Mean_Chg:=ave(group,(real)roll.curr_dual_valid )- ave(group,(real)roll.prev_dual_valid );
			decimal19_2 Dual_count := count(group);
			decimal19_2 Dual_Max_Chg :=max(group,abs(roll.curr_dual_valid_prev_dual_valid));
		END;
													 
	 dual_rec_ds_mean:=  table(roll,dual_rec_mean,product,version,process1,customer,model1);
	
	
	
	// dual_rec_ds_mean;
	
	
/* dual_perc_pos_layout:= record
   
     // string30 acctno; 
     string80 product; 
   	string80 version;
   	string80 process1 ;
   	string80 customer ;
   	string80 model1 ;
   	string80 prev_dual_valid;
   	string80 curr_dual_valid ;
   
   end;
*/
		
		final_rec_stats:= record		  
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;	
	decimal19_2 prev_mean;
	decimal19_2	prev_std_dev;	
	decimal19_2 prev_max_value;
	decimal19_2 prev_min_value;
	decimal19_2 curr_mean;
	decimal19_2	curr_std_dev;
	// decimal19_2	z_score;
	// string30 ND_Stat_Flag_10;
	// string30 ND_Stat_Flag_05;
	// decimal19_2 prev_response_count;
	// decimal19_2 curr_response_count;
	decimal19_2 curr_max_value;
	decimal19_2 curr_min_value;	
	// decimal19_2 diff_response_count;
	decimal19_2 diff_mean;
	decimal19_2 diff_std_dev;
	

end;
		
	final_rec_ds:=	join(avg_dataset_prev,avg_dataset_curr,left.product = right.product and
	                                                        left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(final_rec_stats),
			self.prev_mean 	:= left.prev_mean ;
			self.curr_mean := right.curr_mean;
			self.prev_std_dev := left.prev_std_dev;
			self.prev_max_value 	:= left.prev_max_value ;
			self.prev_min_value 	:= left.prev_min_value ;
			self.curr_std_dev := right.curr_std_dev;
			self.curr_max_value := right.curr_max_value;
			self.curr_min_value := right.curr_min_value;
			// self.z_score :=  ((right.curr_mean - left.prev_mean) / (sqrt((left.prev_std_dev*left.prev_std_dev)/ left.prev_response_count + 
			                                                             // (right.curr_std_dev*right.curr_std_dev) / right.curr_response_count)));
			// self.ND_Stat_Flag_10:=if(((right.curr_mean - left.prev_mean) / (sqrt((left.prev_std_dev*left.prev_std_dev)/ left.prev_response_count + 
			                                                             // (right.curr_std_dev*right.curr_std_dev) / right.curr_response_count))) > 1.645, 'Different', 'Same');		
			// self.ND_Stat_Flag_05:=if(((right.curr_mean - left.prev_mean) / (sqrt((left.prev_std_dev*left.prev_std_dev)/ left.prev_response_count + 
			                                                             // (right.curr_std_dev*right.curr_std_dev) / right.curr_response_count))) > 1.96, 'Different', 'Same');
		  // self.prev_response_count := left.prev_response_count;
			// self.curr_response_count := right.curr_response_count;	
			// self.diff_response_count:=right.curr_response_count - left.prev_response_count;
			self.diff_mean:=right.curr_mean - left.prev_mean;
			self.diff_std_dev:=right.curr_std_dev - left.prev_std_dev;
			self:=left;
	));
	
	// final_rec_ds;
	
 	dafault_layout_prev:= record
   	 dataset_prev_default.product;
   	  dataset_prev_default.version;
   	dataset_prev_default.process1;
   	dataset_prev_default.customer;
     // dataset_prev.flagship;
   	dataset_prev_default.model1;
   	// dataset_prev.score;
   	decimal19_2 prev_default := count(group,dataset_prev_default.score >'0');
   	
   	
   		end;
   		
   		dafault_layout_curr:= record
   	 dataset_curr_default.product;
   	 	 dataset_curr_default.version;
   	dataset_curr_default.process1;
   	dataset_curr_default.customer;
     // dataset_prev.flagship;
   	dataset_curr_default.model1;
   	// dataset_prev.score;
   	decimal19_2 curr_default := count(group,dataset_curr_default.score >'0');
   
   	
   		end;
   		
   		default_dataset_prev:=  table(dataset_prev_default,dafault_layout_prev,product,version,process1,customer,model1);
   		default_dataset_curr:=  table(dataset_curr_default,dafault_layout_curr,product,version,process1,customer,model1);
   		
   		
   		
   		// default_dataset_prev;
   		// default_dataset_curr;


final_rec_default:= record	
  string30 acctno; 	  
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;	
	decimal19_2 prev_default;
	decimal19_2 curr_default;	
	// string30 Default_Score_Flag ;
	decimal19_2 Default_Score_Chng; 
	// decimal19_2 diff_default; 



end;
		
	final_rec_ds_default:=	join(dataset_prev_default,dataset_curr_default,left.acctno = right.acctno and
	                                                       left.product = right.product and
                                                       	 left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(final_rec_default),
			self.prev_default 	:= (real)left.score ;
			self.curr_default := (real)right.score;
			// self.Default_Score_Flag :=IF((real)right.score-(real)left.score > 5, 'Score_Alert', '');
			self.Default_Score_Chng:=(real)right.score-(real)left.score;
				// self.diff_default:=right.curr_default-left.prev_default;
			
			self:=left;
	));
// final_rec_ds_default;


Default_Score_Chng_layout := record

  final_rec_ds_default.product; 
	final_rec_ds_default.version;
	final_rec_ds_default.process1 ;
	final_rec_ds_default.customer ;
	final_rec_ds_default.model1 ;
	decimal19_2 Default_Score_Chng:=count(group,final_rec_ds_default.Default_Score_Chng>0 );

end;
											 
 	Default_Score_Chng_layout_ds:=  table(final_rec_ds_default,Default_Score_Chng_layout,product,version,process1,customer,model1);
	
	// Default_Score_Chng_layout_ds;

/* no_of_bins_layout_prev:= record
   score_result1_project.product;
   	score_result1_project.process1;
   	score_result1_project.customer;
   	score_result1_project.model1;
   	// score_result1_project.get_score_bin;
   	decimal19_2 no_of_bins:= count(group,score_result1_project.get_score_bin>'0');
   
   end;
   
   no_of_bins_layout_curr:= record
   score_result2_project.product;
   	score_result2_project.process1;
   	score_result2_project.customer;
   	score_result2_project.model1;
   	// score_result2_project.get_score_bin;
   	decimal19_2 no_of_bins:= count(group,score_result2_project.get_score_bin>'0');
   
   end;
   
   no_of_bins_ds_prev:=  table(score_result1_project,no_of_bins_layout_prev,product,process1,customer,model1);
   
   no_of_bins_ds_curr:=  table(score_result2_project,no_of_bins_layout_prev,product,process1,customer,model1);
   
   // no_of_bins_ds_prev;
*/



final_rec := record

			string80 flagship;
			string80 model;
			string9 bin;
			integer8 prev_frequency;
			decimal19_5 prev_proportion;
			decimal19_5 prev_cum_proportion;
			integer8 curr_frequency;
			decimal19_5 curr_proportion;
			decimal19_5 curr_cum_proportion;
			integer8 prev_response_count;
			integer8 prev_invalid ;
			// integer8 prev_exceptions ;
			integer8 curr_response_count;
			integer8 curr_invalid ;
			// integer8 curr_exceptions ;
			decimal19_5 Prev_Mean;
			decimal19_5 prev_std_dev;
			integer8 prev_max_value;
			integer8 prev_min_value;
			integer8 prev_default;
			decimal19_5 curr_mean;
			decimal19_5 curr_std_dev;
			integer8 curr_max_value;
			integer8 curr_min_value;
			integer8 curr_default;


end;

final_result  :=
   join( result1, result2,
      left.get_score_bin = right.get_score_bin and
			left.flagship = right.flagship and
			left.model = right.model ,
			transform(recordof(final_rec),
			self.flagship 	:= left.flagship ;
			self.model := left.model;
			self.bin := left.get_score_bin;
			self.prev_frequency := left.cnt_grp;
			self.prev_proportion := left.cnt_grp/left.file_count;
      self.Prev_Mean := left.mean;
			self.prev_std_dev := left.std_dev;
			self.prev_max_value := left.max_value;
			self.prev_min_value := left.min_value;
      self.prev_invalid := if( left.get_score_bin = 'UNDEFINED', left.cnt_grp, 0);
			// self.prev_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], left.cnt_grp, 0);
			self.prev_cum_proportion := 0;
			self.prev_default := if( left.get_score_bin in ['222'], left.cnt_grp, 0);
			// self.curr_bin := right.get_score_bin;
			self.curr_frequency := right.cnt_grp;
			self.curr_proportion := right.cnt_grp/right.file_count ;
			self.curr_cum_proportion := 0;			
			self.prev_response_count := left.file_count;
			self.curr_response_count := right.file_count;			

      self.curr_mean := right.mean;
			self.curr_std_dev := right.std_dev;
			self.curr_max_value := right.max_value;
			self.curr_min_value := right.min_value;
			
			self.curr_invalid := if( left.get_score_bin = 'UNDEFINED', right.cnt_grp, 0);
			// self.curr_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], right.cnt_grp, 0);
      self.curr_default := if( left.get_score_bin in ['222'], right.cnt_grp, 0);
			));
			
			
	 dedup_final_0 := table(		final_result, { flagship, model, 
	                                          Prev_Mean, prev_std_dev, prev_max_value, prev_min_value, prev_response_count,
	                                          curr_mean, curr_std_dev, curr_max_value, curr_min_value, curr_response_count } );
																						
	 dedup_final_1 := dedup(		sort( dedup_final_0,
																						flagship, model, 
	                                          Prev_Mean, prev_std_dev, prev_max_value, prev_min_value, prev_response_count,
	                                          curr_mean, curr_std_dev, curr_max_value, curr_min_value, curr_response_count ),
															 flagship, model,
															Prev_Mean, prev_std_dev, prev_max_value, prev_min_value, prev_response_count,
															curr_mean, curr_std_dev, curr_max_value, curr_min_value, curr_response_count );
		// dedup_final_1;													
															
   final_result_left  :=
   join( result1, result2,
      left.get_score_bin = right.get_score_bin and
			left.flagship = right.flagship and
			left.model = right.model ,
			transform(recordof(final_rec),
			self.flagship 	:= left.flagship ;
			self.model := left.model;
			self.bin := left.get_score_bin;
			self.prev_frequency := left.cnt_grp;
			self.prev_proportion := left.cnt_grp/left.file_count;
      self.Prev_Mean := 0; // left.mean;
			self.prev_std_dev := 0; // left.std_dev;
			self.prev_max_value := 0; // left.max_value;
			self.prev_min_value := 0; // left.min_value;
      self.prev_invalid := if( left.get_score_bin  in[ 'UNDEFINED' , 'NULL'], left.cnt_grp, 0);
			// self.prev_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], left.cnt_grp, 0);
			self.prev_cum_proportion := 0;
			self.prev_default := 0;
			// self.curr_bin := right.get_score_bin;
			self.curr_frequency := right.cnt_grp;
			self.curr_proportion := right.cnt_grp/right.file_count ;
			self.curr_cum_proportion := 0;			
			self.prev_response_count := left.file_count;
			self.curr_response_count :=  right.file_count;			

      self.curr_mean := right.mean;
			self.curr_std_dev := right.std_dev;
			self.curr_max_value := right.max_value;
			self.curr_min_value := right.min_value;
			
			self.curr_invalid := if( left.get_score_bin  in[ 'UNDEFINED' , 'NULL'], right.cnt_grp, 0);
			// self.curr_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], right.cnt_grp, 0);
			self.curr_default := if( left.get_score_bin in ['222'], right.cnt_grp, 0);

			), left only);
			
			
			// final_result_left;
			
			final_res_left_join := join (dedup_final_1, final_result_left,
			                             		left.flagship = right.flagship and
			                                left.model = right.model,
																			transform(recordof(final_result_left),
																			self := left,
																			self := right ));
			// final_res_left_join;																
	
	// i changed as right only has issues with thor
	//right will not have any values -- prev all 0's
	
   final_result_right  :=
   join( result2, result1,
      left.get_score_bin = right.get_score_bin and
			left.flagship = right.flagship and
			left.model = right.model ,
			transform(recordof(final_rec),
			self.flagship 	:= left.flagship ;
			self.model := left.model;
			self.bin := left.get_score_bin;
			self.prev_frequency := right.cnt_grp;
			self.prev_proportion := right.cnt_grp/left.file_count;
      self.Prev_Mean := right.mean;
			self.prev_std_dev := right.std_dev;
			self.prev_max_value := right.max_value;
			self.prev_min_value := right.min_value;
      self.prev_invalid := if( right.get_score_bin in[ 'UNDEFINED' , 'NULL'], right.cnt_grp, 0);
			// self.prev_exceptions := if( right.get_score_bin in ['100','101','102','103','104','200','210','222'], right.cnt_grp, 0);
			self.prev_cum_proportion := 0;
			self.prev_default := 0;
			// self.curr_bin := right.get_score_bin;
			self.curr_frequency := left.cnt_grp;
			self.curr_proportion := left.cnt_grp/left.file_count ;
			self.curr_cum_proportion := 0;			
			self.prev_response_count := right.file_count;
			self.curr_response_count := left.file_count;			

      self.curr_mean := 0; // left.mean;
			self.curr_std_dev := 0; // left.std_dev;
			self.curr_max_value := 0; // left.max_value;
			self.curr_min_value := 0; // left.min_value;
			
			self.curr_invalid := if( left.get_score_bin in[ 'UNDEFINED' , 'NULL'], left.cnt_grp, 0);
			// self.curr_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], left.cnt_grp, 0);
			self.curr_default := if( left.get_score_bin in ['222'], left.cnt_grp, 0);

			), left only);

			// output(sort(final_result,flagship,model,  prev_bin)) ;			

      // final_result_right;

	    final_res_right_join := join (dedup_final_1, final_result_right,
			                             		left.flagship = right.flagship and
			                                left.model = right.model,
																			transform(recordof(final_result_left),
																			self := left,
																			self := right ));
			// final_res_right_join;
			
			
			final_rec fix_cumulative(final_rec L, final_rec R) := TRANSFORM
			SELF.prev_cum_proportion := r.prev_proportion + l.prev_cum_proportion;
			SELF.curr_cum_proportion := r.curr_proportion + l.curr_cum_proportion;
	
			SELF := R;
			END;

     

									 
      final_result_all := 		final_result + 	final_res_left_join + final_res_right_join ;						 
									 
			fix_cumulative_recs := SORT( GROUP(SORT(final_result_all,flagship,model,bin),flagship,model ),
			flagship,model,bin);			


     // fix_cumulative_recs;


			i3_fix := ITERATE(fix_cumulative_recs,fix_cumulative(LEFT,RIGHT));
			
			// output(i3_fix);
			
	
	
      // sum prev_exceptions as we can have more exceptions
	
	
	
			final_rec_final  := record

			string80 flagship;
			string80 model;
			string9 bin;
			integer8 prev_frequency;
			decimal19_5 prev_proportion;
			decimal19_5 prev_cum_proportion;
			integer8 curr_frequency;
			decimal19_5 curr_proportion;
			decimal19_5 curr_cum_proportion;
			integer8 prev_response_count;
			integer8 prev_invalid ;
			// integer8 prev_exceptions ;
			integer8 curr_response_count;
			integer8 curr_invalid ;
			// integer8 curr_exceptions ;
			integer8 diff_frequency;
			decimal19_5 diff_proportion;
			decimal19_5 diff_cum_proportion;

			decimal19_2 Prev_Mean;
			decimal19_2 prev_std_dev;
			integer8 prev_max_value;
			integer8 prev_min_value;
			integer8 prev_default;
			decimal19_2 curr_mean;
			decimal19_2 curr_std_dev;
			integer8 curr_max_value;
			integer8 curr_min_value;
			integer8 curr_default;

      integer8 diff_response_count ;
			decimal19_2 diff_mean;
			decimal19_2 diff_std_dev;
			// integer8 diff_max_value;
			// integer8 diff_min_value;
			integer8 diff_default;

      integer8 diff_invalid ;
			// integer8 diff_exceptions ;
	
	    decimal19_4 diverg_stat;

      decimal19_5 new_check_ks;
			end;

      // diverg_stat    ((curr_mean - Prev_Mean )^2) / ( (curr_std_dev^2 + prev_std_dev^2 ) / 2 ) 
      // power((left.curr_mean - left.Prev_Mean) , 2.0 ) /
			// ( ( power(left.curr_std_dev, 2.0) + power(left.prev_std_dev, 2.0) ) / 2.0 )

      final_tally := project (i3_fix , transform(recordof(final_rec_final),
			                   self.diff_response_count := left.curr_response_count - left.prev_response_count  ;
			                   self.diff_frequency := left.curr_frequency - left.prev_frequency ;
												 self.diff_proportion := left.curr_proportion - left.prev_proportion;
												 self.diff_cum_proportion := if ( left.curr_cum_proportion > 0.9999,(real) 1.0, left.curr_cum_proportion ) - if ( left.prev_cum_proportion > 0.9999, (real)1.0, left.prev_cum_proportion ) ;
												 
			                   self.diff_mean := left.curr_mean - left.Prev_Mean ;
												 self.diff_std_dev := left.curr_std_dev - left.prev_std_dev;
			                   // self.diff_max_value := left.curr_max_value - left.prev_max_value ;
			                   // self.diff_min_value := left.curr_min_value - left.prev_min_value ;												 
												 self.diff_default := left.curr_default - left.prev_default ;
			                   self.diff_invalid := left.curr_invalid - left.prev_invalid ;
			                   // self.diff_exceptions := left.curr_exceptions - left.prev_exceptions ;
												 
												 self.diverg_stat :=power((left.curr_mean - left.prev_mean) , 2.0 ) /
												                         ( ( power(left.curr_std_dev, 2.0) + power(left.prev_std_dev, 2.0) ) / 2.0 ) ;
																								 
                         self.new_check_ks := 1.22 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)))  ; 																								 
												 self := left));
												 
      // output(choosen(final_tally, 10000), named('final_tally')) ;					
			

      ks_rec := record

      final_tally.flagship;
			final_tally.model;
			//final_tally.prev_bin;

      string80 ks_flag := '';	
			// string80 rule_based_str :='';
			
			final_tally.diverg_stat;
			
			final_tally.prev_response_count;
			final_tally.Prev_Mean;
			final_tally.prev_std_dev;			
			final_tally.prev_max_value;
			final_tally.prev_min_value;		
			
			integer8 prev_invalid := sum(group, final_tally.prev_invalid);
			// integer8 prev_exceptions := sum(group, final_tally.prev_exceptions);			

	    integer8 prev_default := sum(group, final_tally.prev_default);
			
      final_tally.curr_response_count;
			final_tally.curr_mean;
			final_tally.curr_std_dev;			
			final_tally.curr_max_value;
			final_tally.curr_min_value;			

			integer8 curr_invalid := sum(group, final_tally.curr_invalid);
			// integer8 curr_exceptions := sum(group, final_tally.curr_exceptions);			
			integer8 curr_default := sum(group, final_tally.curr_default);

       final_tally.diff_response_count;
			 final_tally.diff_mean;
			 final_tally.diff_std_dev;	
			
		
			// final_tally.diff_max_value;
			// final_tally.diff_min_value;		
			

			integer8 diff_invalid := sum(group, final_tally.diff_invalid);
			// integer8 diff_exceptions := sum(group, final_tally.diff_exceptions);				
			
			integer8 diff_default := sum(group, final_tally.diff_default);
			
			// check_ks := 1.36 / sqrt(final_tally.prev_response_count) ; 
			
			check_ks := max(group, final_tally.new_check_ks);
			
			// check_ks := 1.22 / sqrt(( ( final_tally.prev_response_count + final_tally.prev_response_count) / ( final_tally.prev_response_count * final_tally.prev_response_count)))  ; 
			
			max_diff_proportion := max(group, abs(final_tally.diff_cum_proportion) );
			max_ks 							:= max(group, abs(final_tally.diff_proportion) );
			
      bin_shift_05 := sum(group, if(abs(final_tally.diff_proportion) > .005  , 	1 , 0));		
			// sum_of_bins_gt_1 := sum(group, if(abs(final_tally.diff_proportion) > .01 , 1, 0));		
			// sum_of_bins_gt_15 := sum(group, if(abs(final_tally.diff_proportion) > .015 ,1, 0));		
			
			integer no_of_bins := count(group);
			end;
			
			table_max_ks := table(final_tally, ks_rec, flagship, model);
			
			
			
			// table_max_ks;
			
				table_max_ks_out := project (table_max_ks, transform({recordof(table_max_ks) - check_ks - max_diff_proportion - max_ks   },
																	
																
				
																	self.ks_flag := if( left.max_diff_proportion > left.check_ks ,
																	                         'Different',
																													 'Same');
																													 
																	self.diverg_stat:=left.diverg_stat * 1000;												 
															
																	
																	self := left ;));
			
			// table_max_ks_out;
					
		  // output(table_max_ks,,'~kreddy::test::table_max_ks');     
			table_max_ks_out_layout:=RECORD
  string80 flagship;
  string80 model;
  string80 ks_flag;
  decimal19_4 diverg_stat;
  integer8 prev_response_count;
  decimal19_2 prev_mean;
  decimal19_2 prev_std_dev;
  integer8 prev_max_value;
  integer8 prev_min_value;
  integer8 prev_invalid;
  integer8 prev_default;
  integer8 curr_response_count;
  decimal19_2 curr_mean;
  decimal19_2 curr_std_dev;
  integer8 curr_max_value;
  integer8 curr_min_value;
  integer8 curr_invalid;
  integer8 curr_default;
  integer8 diff_response_count;
  decimal19_2 diff_mean;
  decimal19_2 diff_std_dev;
  integer8 diff_invalid;
  integer8 diff_default;
  // decimal19_5 check_ks;
  // decimal19_5 max_diff_proportion;
  // decimal19_5 max_ks;
  integer8 bin_shift_05;
  integer8 no_of_bins;
 END;


			
 table_max_ks_out_project:=scores_project(table_max_ks_out,table_max_ks_out_layout);
 
 
 // table_max_ks_out_project;
  
    		final_rec_stats_join:= record		  
       string30 acctno; 
     string80 product; 
   	string80 version;
   	string80 process1 ;
   	string80 customer ;
   	string80 model1 ;
   	string80 prev_dual_valid;
   	string80 curr_dual_valid ;
   	decimal19_2 curr_dual_valid_prev_dual_valid;
   	
   	decimal19_2 prev_response_count;
   	decimal19_2 curr_response_count;
   	
   
   
   	
   
   end;
    final_rec_stats_join_ds:= join(table_max_ks_out_project,dual_rec_ds,left.product = right.product and
                                                          	left.version = right.version and
   			                                                   left.process1 = right.process1 and
   			                                                   left.customer = right.customer and
   																												 left.model1 = right.model1 ,
   			transform(recordof(final_rec_stats_join),
   			self.prev_response_count 	:= left.prev_response_count ;
   			self.curr_response_count := left.curr_response_count;	
   	
   			self:=right;
   	));
		
		// final_rec_stats_join_ds;
		
		
		
						
		

/*    	final_rec_default_join:= record		  
        string80 product;
      	string80 version;
      	string80 process1;
      	string80 customer;
      	string80 model1;	
      	decimal19_2 prev_default;
      	decimal19_2 curr_default;	
      	// string30 Default_Score_Flag ;
      	// decimal19_2 Default_Score_Chng; 
      	// decimal19_2 diff_default; 
      	
      	decimal19_2 prev_response_count;
      	decimal19_2 curr_response_count;
      end;
      
       final_rec_default_join_ds:= join(table_max_ks_out_project,final_rec_ds_default,left.product = right.product and
                                                             	left.version = right.version and
      			                                                   left.process1 = right.process1 and
      			                                                   left.customer = right.customer and
      																												 left.model1 = right.model1 ,
      			transform(recordof(final_rec_default_join),
      			self.prev_response_count 	:= left.prev_response_count ;
      			self.curr_response_count := left.curr_response_count;				
      			self:=right;
      	));
      	
      	// final_rec_default_join_ds;
      	
*/



  final_rec_stats_join_ds_stats_layout := record
       final_rec_stats_join_ds.product; 
      	final_rec_stats_join_ds.version;
      	final_rec_stats_join_ds.process1 ;
      	final_rec_stats_join_ds.customer ;
      	final_rec_stats_join_ds.model1 ;
      	final_rec_stats_join_ds.prev_dual_valid;
      	final_rec_stats_join_ds.curr_dual_valid ;
      	// decimal19_2 curr_dual_valid_prev_dual_valid;
         	decimal19_2 Dual_Perc_Pos:=COUNT(group,(decimal19_2 )final_rec_stats_join_ds.curr_dual_valid - (decimal19_2 )	final_rec_stats_join_ds.prev_dual_valid > 0) ;
         	decimal19_2 Dual_Perc_Neg :=COUNT(group,(decimal19_2 )final_rec_stats_join_ds.curr_dual_valid - (decimal19_2 )	final_rec_stats_join_ds.prev_dual_valid < 0) ;
   				
         	// decimal19_2 Dual_Neg_Scr_Chg :=ave(group,((decimal19_2 )final_rec_stats_join_ds.curr_dual_valid - (decimal19_2 )	final_rec_stats_join_ds.prev_dual_valid) < 0) ;
         	// decimal19_2	avg_curr_dual_valid:=ave(group,(real)dual_rec_ds.curr_dual_valid );	
         end;
         											 
   
   
    	 final_rec_stats_join_ds_stats:=  table(final_rec_stats_join_ds,final_rec_stats_join_ds_stats_layout,product,version,process1,customer,model1);
   	
   	// final_rec_stats_join_ds_stats;

 Dual_Pos_Scr_ds:=final_rec_stats_join_ds(curr_dual_valid_prev_dual_valid> 0);
 Dual_Neg_Scr_ds:=final_rec_stats_join_ds(curr_dual_valid_prev_dual_valid<0);
 
 Dual_Pos_Scr_ds_stats_layout:= record
 
        Dual_Pos_Scr_ds.product; 
      	Dual_Pos_Scr_ds.version;
      	Dual_Pos_Scr_ds.process1 ;
      	Dual_Pos_Scr_ds.customer ;
      	Dual_Pos_Scr_ds.model1 ;
  decimal19_2 Dual_Pos_Scr_Chg:=ave(group,Dual_Pos_Scr_ds.curr_dual_valid_prev_dual_valid) ;
 end;
 Dual_Pos_Scr_ds_stats:=table(Dual_Pos_Scr_ds,Dual_Pos_Scr_ds_stats_layout,product,version,process1,customer,model1);
 
 // Dual_Pos_Scr_ds_stats;
 
  Dual_Neg_Scr_ds_stats_layout:= record
 
        Dual_Neg_Scr_ds.product; 
      	Dual_Neg_Scr_ds.version;
      	Dual_Neg_Scr_ds.process1 ;
      	Dual_Neg_Scr_ds.customer ;
      	Dual_Neg_Scr_ds.model1 ;
  decimal19_2 Dual_Neg_Scr_Chg:=ave(group,Dual_Neg_Scr_ds.curr_dual_valid_prev_dual_valid) ;
 end;
 Dual_Neg_Scr_ds_stats:=table(Dual_Neg_Scr_ds,Dual_Neg_Scr_ds_stats_layout,product,version,process1,customer,model1);
 
 // Dual_Neg_Scr_ds_stats;
 
 join1_layout:= record
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;
	string80 ks_flag;
  decimal19_4 diverg_stat;
	string30 ND_Stat_Flag_10;
	string30 ND_Stat_Flag_05;
	decimal19_2	z_score;
	decimal19_2 prev_response_count;
	decimal19_2 prev_mean;
	decimal19_2	prev_std_dev;	
	decimal19_2 prev_max_value;
	decimal19_2 prev_min_value;
	decimal19_2 prev_invalid;	
	decimal19_2 curr_response_count;
	decimal19_2 curr_mean;
	decimal19_2	curr_std_dev;
	decimal19_2 curr_max_value;
	decimal19_2 curr_min_value;	
	decimal19_2 curr_invalid;	
	decimal19_2 Diff_Response_Count;
	decimal19_2 diff_mean;
	decimal19_2 diff_std_dev;
	decimal19_2 diff_invalid;
	decimal19_2 Bin_Shift_05;
	decimal19_2 No_Of_Bins;
 
 
 end;
 
 join1:=join(table_max_ks_out_project,final_rec_ds,      left.product = right.product and
                                                       	 left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(join1_layout),
			self.ks_flag 	:= left.ks_flag ;
			self.diverg_stat := left.diverg_stat;
			self.ND_Stat_Flag_10 	:= if(abs((right.curr_mean - right.prev_mean) / (sqrt((right.prev_std_dev*right.prev_std_dev)/ left.prev_response_count + 
			                                                              (right.curr_std_dev*right.curr_std_dev) / left.curr_response_count))) > 1.645, 'Different', 'Same');	
			self.ND_Stat_Flag_05 := if(abs((right.curr_mean - right.prev_mean) / (sqrt((right.prev_std_dev*right.prev_std_dev)/ left.prev_response_count + 
			                                                              (right.curr_std_dev*right.curr_std_dev) / left.curr_response_count))) > 1.96, 'Different', 'Same');
			self.z_score 	:=   ((right.curr_mean - right.prev_mean) / (sqrt((right.prev_std_dev*right.prev_std_dev)/ left.prev_response_count + 
			                                                              (right.curr_std_dev*right.curr_std_dev) / left.curr_response_count)));
			
			self.prev_response_count 	:= left.prev_response_count ;
			self.prev_mean 	:= right.prev_mean ;
			self.prev_std_dev := right.prev_std_dev;
			self.prev_max_value 	:= right.prev_max_value ;
			self.prev_min_value 	:= right.prev_min_value ;
			self.prev_invalid := left.prev_invalid;	
			self.curr_response_count := left.curr_response_count;			
      self.curr_mean := right.curr_mean;		 
			self.curr_std_dev := right.curr_std_dev;
			self.curr_max_value := right.curr_max_value;
			self.curr_min_value := right.curr_min_value;
			self.curr_invalid := left.curr_invalid;	
			self.diff_response_count:=left.curr_response_count - left.prev_response_count;
			self.diff_mean:=right.curr_mean - right.prev_mean;
			self.diff_std_dev:=right.curr_std_dev - right.prev_std_dev;
			self.diff_invalid:=left.curr_invalid - left.prev_invalid;
			self.Bin_Shift_05 := left.Bin_Shift_05;	
			self.No_Of_Bins := left.No_Of_Bins;	
			
			self:=right;
	));
	
	// join1;

join2_layout:= record
   recordof(join1_layout);
  decimal19_2 Dual_Mean_Chg;
			decimal19_2 Dual_count;
	decimal19_2 Dual_Max_Chg ;
 end;


join2:=join(join1,dual_rec_ds_mean,                      left.product = right.product and
                                                       	 left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(join2_layout),
			
			self.Dual_Mean_Chg := right.Dual_Mean_Chg;	
					self.Dual_count := right.Dual_count;	
			self.Dual_Max_Chg := right.Dual_Max_Chg;	
			
			self:=left;
	));
											 
 	// join2;
	
  	 join3_layout:= record		 
		 	  recordof(join2_layout);			
				decimal19_2 Dual_Perc_Pos_chg;
			 	decimal19_2 Dual_Perc_Neg_chg;
        
     end;
					
					         
          join3:=join(join2,final_rec_stats_join_ds_stats,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join3_layout),
         			
         			self.Dual_Perc_Pos_chg 	:= (right.Dual_Perc_Pos/left.curr_response_count)*100 ;
         			self.Dual_Perc_Neg_chg := (right.Dual_Perc_Neg/left.curr_response_count)*100 ;
         			self:=left;
         	));
         	// join3;

      	
				
	join4_layout:= record		 
		   	recordof(join3_layout);			
				decimal19_5 perc_To_Default;
			
        
    end;
					
					
          
          join4:=join(join3,count_to_default_rec_ds,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join4_layout),
         			
         			self.perc_To_Default 	:= (right.count_to_default/left.curr_response_count)*100 ;
         					
         			self:=left;
         	),left outer);
					
					// join4;
					
					
					
						join5_layout:= record		 
		   	recordof(join4_layout);			
				
			 	decimal19_5 perc_From_Default;
				
        
    end;
					
					
          
          join5:=join(join4,count_from_default_rec_ds,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join5_layout),
         			
         			self.perc_From_Default 	:= (right.count_from_default/left.curr_response_count)*100 ;
         					
         			self:=left;
         	),left outer);
					
					
								join6_layout:= record		 
		   	recordof(join5_layout);			
			
				decimal19_2 pct_score_same;
        
    end;
					
					
          
          join6:=join(join5,score_name_layout_ds,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join6_layout),
         			
         			self.pct_score_same 	:= (right.score_name/left.curr_response_count)*100 ;
         					
         			self:=left;
         	),left outer);
					
					// join5;
					
 				join7_layout:= record
   		                	recordof(join6_layout);
   				              decimal19_2 Dual_Pos_Scr_Chg;
             end;
   					
   					
             
             join7:=join(join6,Dual_Pos_Scr_ds_stats,       left.product = right.product and
                                                                    left.version = right.version and
            			                                                   left.process1 = right.process1 and
            			                                                   left.customer = right.customer and
            																												 left.model1 = right.model1 ,
            			transform(recordof(join7_layout),
            			
            			self.Dual_Pos_Scr_Chg 	:= right.Dual_Pos_Scr_Chg ;
            			self:=left;
            	),left outer);
							
							
							// join5;
   		
    					join8_layout:= record      		 
      		                  	recordof(join7_layout);
      		                    decimal19_2 Dual_Neg_Scr_Chg;
                 end;
      					
      					
                
                join8:=join(join7,Dual_Neg_Scr_ds_stats,       left.product = right.product and
                                                                       left.version = right.version and
               			                                                   left.process1 = right.process1 and
               			                                                   left.customer = right.customer and
               																												 left.model1 = right.model1 ,
               			transform(recordof(join8_layout),               			
               			self.Dual_Neg_Scr_Chg 	:= right.Dual_Neg_Scr_Chg ;             			
      							self:=left;
               	),left outer);
								
								
      
      
     
			
			    // join8;
			
/* 			join9_layout:= record      		 
         		                  	recordof(join8_layout);      		               													
   															decimal19_2 Default_Score_Chng;
                                 string30 Default_Score_Flag;
                        end;
   											 
   
         					
         					
                   
                   join9:=join(join8,Default_Score_Chng_layout_ds,       left.product = right.product and
                                                                          left.version = right.version and
                  			                                                   left.process1 = right.process1 and
                  			                                                   left.customer = right.customer and
                  																												 left.model1 = right.model1 ,
                  			transform(recordof(join9_layout),               			
                  			self.Default_Score_Chng 	:= right.Default_Score_Chng ;  
   										self.Default_Score_Flag :=IF((real)right.Default_Score_Chng > 3, 'Score_Alert', 'NA');
         							self:=left;
                  	),left outer);
   								
   								
         
*/
      
      // join9;
			
			

   

			join10_layout:= record      		 
      		                  	recordof(join8_layout);      		               													
															decimal19_2 Prev_Default;
                           
                     end;
											 

      					
      					
                
                join10:=join(join8,default_rec_ds_1,       left.product = right.product and
                                                                       left.version = right.version and
               			                                                   left.process1 = right.process1 and
               			                                                   left.customer = right.customer and
               																												 left.model1 = right.model1 ,
               			transform(recordof(join10_layout),               			
               			self.Prev_Default 	:= right.prev_default ;  
						
      							self:=left;
               	),left outer);



		join11_layout:= record      		 
      		                  	recordof(join10_layout);      		               													
															decimal19_2 curr_default;
                           
                     end;
											 

      					
      					
                
                join11:=join(join10,default_rec_ds_2,       left.product = right.product and
                                                                       left.version = right.version and
               			                                                   left.process1 = right.process1 and
               			                                                   left.customer = right.customer and
               																												 left.model1 = right.model1 ,
               			transform(recordof(join11_layout),               			
               			self.curr_default 	:= right.curr_default ;  
						
      							self:=left;
               	),left outer);
								
// RV_Attributes_V3_XML_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;
// RV_Attributes_V3_BATCH_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_Experian_infile;
// RV_Attributes_V3_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_CapOne_infile;
// RV_Attributes_V2_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
// RV_Attributes_V2_BATCH_CreditAcceptance_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_infile;
// RV_Scores_XML_Tmobile_rvt1212_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_infile;
// RV_Scores_XML_Tmobile_rvt1210_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_infile;
// RV_Scores_XML_Santander_1304_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_1_infile;
// RV_Scores_XML_Santander_1304_2_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_2_infile;
// RV_Scores_V4_XML_ENOVA_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_V4_XML_ENOVA_infile;
RV_V4_Generic_infile := scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_V5_Generic_infile := scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_V3_Generic_infile:= scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile; 
// RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile;
BC10_Scores_Chase_BNK4_infile := scoring_project_pip.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;
CBBL_Scores_XML_Chase_infile:= scoring_project_pip.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;
// ITA_Attributes_V3_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_infile;
// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile :=  scoring_project_pip.Input_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile;
LI_Generic_msn1210_1_infile := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;
IT60_Scores_Paro_msn605_infile:=scoring_project_pip.Input_Sample_Names.IT60_Scores_Paro_msn605_infile;
IT61_Scores_BATCH_Paro_msn605_rsn804_infile := scoring_project_pip.Input_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_infile;
IT61_Scores_XML_Paro_msn605_rsn804_infile:=scoring_project_pip.Input_Sample_Names.IT61_Scores_XML_Paro_msn605_rsn804_infile;
PRIO_Scores_Chase_PIO2_infile := scoring_project_pip.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;
BIID_Scores_Batch_Chase_infile := scoring_project_pip.Input_Sample_Names.BIID_Scores_Batch_Chase_infile;
BIID_Scores_XML_Generic_infile := scoring_project_pip.Input_Sample_Names.BIID_Scores_XML_Generic_infile;
BIID_Scores_BATCH_Generic_infile :=scoring_project_pip.Input_Sample_Names.BIID_Scores_BATCH_Generic_infile;
IID_Scores_V0_XML_Generic_infile := scoring_project_pip.Input_Sample_Names.IID_Scores_V0_XML_Generic_infile;
IID_Scores_V0_BATCH_Generic_infile :=scoring_project_pip.Input_Sample_Names.IID_Scores_V0_BATCH_Generic_infile;
// FP_V2_Generic_FP1109_0_infile := scoring_project_pip.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;
FP_V3_Generic_FP31505_0_infile := scoring_project_pip.Input_Sample_Names.FP_V3_Generic_FP31505_0_infile;
FP_V201_American_Express_FP1109_0_infile := scoring_project_pip.Input_Sample_Names.FP_V2_American_Express_FP1109_0_infile;
BIIDv2_Scores_XML_Generic_infile:= scoring_project_pip.Input_Sample_Names.BIIDv2_Scores_XML_Generic_infile;



input_file_count_ds_rec:=record
  string80 product; 
	string80 customer ;
	string80 process1;
  string80 model1;
	string80 version;
	decimal19_2 input_file_count;
end;


biid_layout_input:=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.bus_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
                End;
								
	BIID_Scores_BATCH_Generic_infile_cnt:=count(dataset(BIID_Scores_BATCH_Generic_infile,biid_layout_input,thor));
	BIID_Scores_Batch_Chase_infile_cnt:=count(dataset(BIID_Scores_Batch_Chase_infile,biid_layout_input,thor));
	BIID_Scores_XML_Generic_infile_cnt:=count(dataset(BIID_Scores_XML_Generic_infile,biid_layout_input,thor));	
	BC10_Scores_Chase_BNK4_infile_cnt:=count(dataset(BC10_Scores_Chase_BNK4_infile,biid_layout_input,thor));		
	CBBL_Scores_XML_Chase_infile_cnt:=count(dataset(CBBL_Scores_XML_Chase_infile,biid_layout_input,thor));								
  BIIDv2_Scores_XML_Generic_infile_cnt:=count(dataset(BIIDv2_Scores_XML_Generic_infile,biid_layout_input,thor));  
							
								
bestbuy_layout_input :=RECORD
  Scoring_Project_Macros.Regression.global_layout;
  Scoring_Project_Macros.Regression.pii_layout pii1;
  Scoring_Project_Macros.Regression.pii_layout pii2;
  Scoring_Project_Macros.Regression.runtime_layout;
  END;
	
	// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile_cnt:=count(dataset(ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile,bestbuy_layout_input,thor));	
	
file_count_function(string infile_name) := function

layout_input :=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
                End;
							 
return count(dataset( infile_name,layout_input, thor));
                            
end;

  input_file_count_ds:=DATASET([ 
	                               {'BusinessInstantId','Generic','Batch','bnap','0',BIID_Scores_BATCH_Generic_infile_cnt},
	                               {'BusinessInstantId','Generic','Batch','bnas','0',BIID_Scores_BATCH_Generic_infile_cnt},
																 {'BusinessInstantId','Generic','Batch','bnat','0',BIID_Scores_BATCH_Generic_infile_cnt},
																 {'BusinessInstantId','Generic','Batch','bvi','0',BIID_Scores_BATCH_Generic_infile_cnt},
																 
                                 {'BusinessInstantId','Chase','Batch','bnap','0',BIID_Scores_Batch_Chase_infile_cnt},
																 {'BusinessInstantId','Chase','Batch','bnas','0',BIID_Scores_Batch_Chase_infile_cnt},
																 {'BusinessInstantId','Chase','Batch','bnat','0',BIID_Scores_Batch_Chase_infile_cnt},
																 {'BusinessInstantId','Chase','Batch','bvi','0',BIID_Scores_Batch_Chase_infile_cnt},
																 
      												   {'BusinessInstantId','Generic','XML','bnap','0',BIID_Scores_XML_Generic_infile_cnt},
																 {'BusinessInstantId','Generic','XML','bnas','0',BIID_Scores_XML_Generic_infile_cnt},
																 {'BusinessInstantId','Generic','XML','bnat','0',BIID_Scores_XML_Generic_infile_cnt},
																 {'BusinessInstantId','Generic','XML','bvi','0',BIID_Scores_XML_Generic_infile_cnt},

	                               {'BusinessInstantIdv2','Generic','XML','bvi','0',50000},
	                               {'BusinessInstantIdv2','Generic','XML','rep1_cvi','0',50000},
																 {'BusinessInstantIdv2','Generic','XML','bus2exec_index_rep1','0',50000},

            										 // {'FraudPoint','Generic','XML','fp1109_0','2',file_count_function(FP_V2_Generic_FP1109_0_infile)},
            										 {'FraudPoint','American_Express','XML','fp1109_0','201',file_count_function(FP_V201_American_Express_FP1109_0_infile)},
																 
		/* FP v3 */														 
																 {'FraudPoint','Generic','XML','fp31505_0_flapsd','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_fls','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_fla','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flaps','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flapd','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flasd','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flpsd','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flap','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flps','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flsd','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flad','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
																 {'FraudPoint','Generic','XML','fp31505_0_flas','3',file_count_function(FP_V3_Generic_FP31505_0_infile)},
		/* FP v3*/														 														 
      													 // {'FraudPoint','Generic','Batch','fp1109_0','2',file_count_function(FP_V2_Generic_FP1109_0_infile)},
            															 
																 // {'IT60','Paro','XML','score1','',file_count_function(IT60_Scores_Paro_msn605_infile)},  					
      													 // {'IT60','Paro','Batch','score1','',file_count_function(IT60_Scores_Paro_msn605_infile)}, 					
																 
                                 // {'IT61','Paro','XML','score1','',file_count_function(IT61_Scores_XML_Paro_msn605_rsn804_infile)},  
																 // {'IT61','Paro','XML','score3','',file_count_function(IT61_Scores_XML_Paro_msn605_rsn804_infile)},  
																	
      												   {'IT61','Paro','Batch','score1','',file_count_function(IT61_Scores_BATCH_Paro_msn605_rsn804_infile)},  	
																 // {'IT61','Paro','Batch','score3','',file_count_function(IT61_Scores_BATCH_Paro_msn605_rsn804_infile)},	
																 
																 {'InstantId','Generic','XML','cvi','',file_count_function(IID_Scores_V0_XML_Generic_infile)},
																 {'InstantId','Generic','XML','nap','',file_count_function(IID_Scores_V0_XML_Generic_infile)},
																 {'InstantId','Generic','XML','nas','',file_count_function(IID_Scores_V0_XML_Generic_infile)},
																	 
      												   {'InstantId','Generic','Batch','cvi','',file_count_function(IID_Scores_V0_BATCH_Generic_infile)},
																 {'InstantId','Generic','Batch','nap','',file_count_function(IID_Scores_V0_BATCH_Generic_infile)},
																 {'InstantId','Generic','Batch','nas','',file_count_function(IID_Scores_V0_BATCH_Generic_infile)},
            																								 
            										 {'LeadIntegrity','Generic','XML','msn1106_0','4',file_count_function(LI_Generic_msn1210_1_infile)},
      													 {'LeadIntegrity','Generic','Batch','msn1106_0','4',file_count_function(LI_Generic_msn1210_1_infile)},
																 
            										 {'BNK4','Chase','XML','fd_score','',BC10_Scores_Chase_BNK4_infile_cnt},
      													 {'BNK4','Chase','Batch','fd_score','',BC10_Scores_Chase_BNK4_infile_cnt},
																 
      													 {'PIO2','Chase','XML','fp_score','',file_count_function(PRIO_Scores_Chase_PIO2_infile)},
      													 {'PIO2','Chase','Batch','fp_score','',file_count_function(PRIO_Scores_Chase_PIO2_infile)},
																 
      													 {'CBBL','Chase','XML','fd_score','',CBBL_Scores_XML_Chase_infile_cnt},	
																 {'CBBL','Chase','XML','fp_score','',CBBL_Scores_XML_Chase_infile_cnt},	
																 
      													 // {'RiskView','BestBuy','XML','CDN1109_1','',ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile_cnt},																 
            													
            										 // {'RiskView','T-Mobile','XML','rvt1210_1','',file_count_function(RV_Scores_XML_Tmobile_rvt1210_1_infile)},
																 
																 // {'RiskView','T-Mobile','XML','rvt1212_1','',file_count_function(RV_Scores_XML_Tmobile_rvt1212_1_infile)},
            														
      													 // {'RiskView','santander','XML','rva1304_1','',file_count_function(RV_Scores_XML_Santander_1304_1_infile)},
																 
																 // {'RiskView','santander','XML','rva1304_2','',file_count_function(RV_Scores_XML_Santander_1304_2_infile)},
																 
                                 // {'RiskView','RegionalAcceptance','XML','rva1008_1','',file_count_function(RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile)},
																 
            										 {'RiskView','Generic','XML','rva1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 {'RiskView','Generic','XML','rvb1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 {'RiskView','Generic','XML','rvg1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 // {'RiskView','Generic','XML','rvr1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 {'RiskView','Generic','XML','rvt1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 // {'RiskView','Generic','XML','rvp1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 
																 {'RiskView','Generic','Batch','rva1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 {'RiskView','Generic','Batch','rvb1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 {'RiskView','Generic','Batch','rvg1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 // {'RiskView','Generic','Batch','rvr1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 {'RiskView','Generic','Batch','rvt1003_0','3',file_count_function(RV_V3_Generic_infile)},
																 
																 {'RiskView','Generic','XML','rva1104_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','XML','rvb1104_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','XML','rvg1103_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','XML','rvr1103_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','XML','rvt1104_0','4',file_count_function(RV_V4_Generic_infile)},
																 // {'RiskView','Generic','XML','rvp1104_0','4',file_count_function(RV_V4_Generic_infile)}	,	
																 
																 // {'RiskView','Generic_Prescreen','XML','RVA1503_0','5',file_count_function(RV_V5_Generic_infile)},
																 // {'RiskView','Generic_Prescreen','XML','RVB1503_0','5',file_count_function(RV_V5_Generic_infile)},
																 // {'RiskView','Generic_Prescreen','XML','RVG1502_0','5',file_count_function(RV_V5_Generic_infile)},
																 // {'RiskView','Generic_Prescreen','XML','RVT1503_0','5',file_count_function(RV_V5_Generic_infile)},
																 
																 {'RiskView','Generic','XML','RVA1503_0','5',file_count_function(RV_V5_Generic_infile)},
																 {'RiskView','Generic','XML','RVB1503_0','5',file_count_function(RV_V5_Generic_infile)},
																 {'RiskView','Generic','XML','RVG1502_0','5',file_count_function(RV_V5_Generic_infile)},
																 {'RiskView','Generic','XML','RVT1503_0','5',file_count_function(RV_V5_Generic_infile)},
																 {'RiskView','Generic','XML','RVS1706_0','5',file_count_function(RV_V5_Generic_infile)},

																 {'RiskView','Generic','Batch','rva1104_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','Batch','rvb1104_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','Batch','rvg1103_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','Batch','rvr1103_0','4',file_count_function(RV_V4_Generic_infile)},
																 {'RiskView','Generic','Batch','rvt1104_0','4',file_count_function(RV_V4_Generic_infile)},
																 
																 
																 
																 {'Small_Business_Analytics_SBFE','Generic','','SBOM1601','',15215},
																 {'Small_Business_Analytics_SBFE','Generic','','SBBM1601','',15215},
																 {'Small_Business_Analytics_NonSBFE','Generic','','SLBO1702','',15215},
																 {'Small_Business_Analytics_NonSBFE','Generic','','SLBB1702','',15215},
																 {'Small_Business_Analytics_NonSBFE','Generic','','SLBO1809','',15215},
																 {'Small_Business_Analytics_NonSBFE','Generic','','SLBB1809','',15215}
																															 
																       																		
      													 // {'RiskView','Enova','XML','rvg1103_0','2',file_count_function(RV_Scores_V4_XML_ENOVA_infile)}
																 
																 	 
																 
                                 ],input_file_count_ds_rec);


/* // need to come up with a way to make file count dynamic
   // modifications noted below as of 2/18/2015 -Nathan
   input_file_count_ds:=DATASET([ {'BusinessInstantId','Generic','Batch',25000},
                                        {'BusinessInstantId','Chase','Batch',25000},
   																		  {'BusinessInstantId','Generic','XML',25000},
         														   {'FraudPoint','Generic','XML',25000},
   																		  {'FraudPoint','Generic','Batch',25000},
         															 {'IT60','Paro','XML',25000},  						// modified per 20141106 sample
   																		 {'IT60','Paro','Batch',25000}, 					// modified per 20141106 sample
                                        {'IT61','Paro','XML',6512},  						// modified per 20141216 sample
   																     {'IT61','Paro','Batch',25000},  					// modified per 20141105 sample
         															 {'InstantId','Generic','XML',25000},
   																		 {'InstantId','Generic','Batch',25000},
         															 {'LeadIntegrity','Generic','XML',25000},
   																		 {'LeadIntegrity','Generic','Batch',25000},
         															 {'BNK4','Chase','XML',25000},
   																		 {'BNK4','Chase','Batch',25000},
   																		 {'PIO2','Chase','XML',25000},
   																		 {'PIO2','Chase','Batch',25000},
   																		 {'CBBL','Chase','XML',3582},							// modified per 20141216 sample
   																		 {'RiskView','BestBuy','XML',25000},
         															 {'RiskView','BestBuy_10k','XML',10000},
         															 {'RiskView','T-Mobile','XML',25000},
         															 {'RiskView','T-Mobile_10k','XML',10000},
   																		 {'RiskView','santander','XML',25000},
                                        {'RiskView','RegionalAcceptance','XML',25000},
         															 {'RiskView','Generic','XML',25000},
   																		 {'RiskView','Generic','Batch',25000},
   																		 {'RiskView','Enova','XML',25000}
                                ],input_file_count_ds_rec);

   */   
       
                 input_file_count_ds_result:=join(join11,input_file_count_ds,  left.product = right.product and
                                                                               left.customer = right.customer and
																																							 left.process1=right.process1 and
																																							 left.model1 = right.model1 and
																																							 trim(left.version,left,right)=trim(right.version,left,right)
                     																												
                     		                     	); 	
   
	 
	  final_layout:= record
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;
	string80 ks_flag;
  decimal19_4 diverg_stat;
	string30 ND_Stat_Flag_10;
	string30 ND_Stat_Flag_05;
	decimal19_2	z_score;
  string30 Default_Score_Flag;
	decimal19_2 Default_Score_Chng;
	decimal19_2 Input_File_Count;
	decimal19_2 prev_response_count;
	decimal19_2 prev_mean;
	decimal19_2	prev_std_dev;	
	decimal19_2 prev_max_value;
	decimal19_2 prev_min_value;
	decimal19_2 prev_invalid;	
	decimal19_2 Prev_Default;
	decimal19_2 curr_response_count;
	decimal19_2 curr_mean;
	decimal19_2	curr_std_dev;
	decimal19_2 curr_max_value;
	decimal19_2 curr_min_value;	
	decimal19_2 curr_invalid;	
	decimal19_2 curr_default;
	decimal19_2 Diff_Response_Count;
	decimal19_2 diff_mean;
	decimal19_2 diff_std_dev;
	decimal19_2 diff_invalid;
	decimal19_2 Diff_Default;
	decimal19_2 Bin_Shift_05;
	decimal19_2 No_Of_Bins;
	decimal19_2 Dual_Mean_Chg;
	decimal19_2 Dual_Max_Chg ;
	decimal19_2 Dual_Perc_Pos_chg;
	decimal19_2 Dual_Perc_Neg_chg;
	decimal19_5 perc_To_Default;
 	decimal19_5 perc_From_Default;
  decimal19_2 Dual_Pos_Scr_Chg;
	decimal19_2 Dual_Neg_Scr_Chg;
	decimal19_2 Dual_count;
	decimal19_2 pct_score_same;	
 end;
      	 result_1:=project(input_file_count_ds_result,transform(final_layout,self.Diff_Default:=left.curr_default-left.Prev_Default,
				 
				                                                 			self.Default_Score_Chng 	:= left.curr_default-left.Prev_Default ;  
   										                                        self.Default_Score_Flag :=IF(abs(left.curr_default-left.Prev_Default) > 3, 'Score_Alert', 'NA'),self:=left));
				 
				 
						 
				 			 result:=project(result_1,transform(final_layout,self.product:=if(left.customer in['BestBuy_10k'  ,'BestBuy'],'ChargeBackDefender',left.product),self:=left));
				 
				 input_file_count_ds_pjt:=project(input_file_count_ds,transform(recordof(input_file_count_ds),self.product:=if(left.customer in['BestBuy_10k'  ,'BestBuy'],'ChargeBackDefender',left.product),self:=left));
						 
						
				 FCRA_result:=result(product='RiskView');
				 
				 
				 NON_FCRA_result:=result(product<>'RiskView');
																									 
				
							
	//************		KS Report Exception Handling **********************
	

	        FCRA_alert_file_list:=join(input_file_count_ds_pjt(product='RiskView'),FCRA_result,trim(left.product,left,right)= trim(right.product,left,right) and 
													                 trim(left.version,left,right)= trim(right.version,left,right) and 
																					 trim(left.process1,left,right)= trim(right.process1,left,right) and 
																					 trim(left.customer,left,right)= trim(right.customer,left,right) and
																					 trim(left.model1,left,right)= trim(right.model1,left,right), 
																 transform(recordof(input_file_count_ds) -input_file_count,self:=left),left only
																																															 );
	        Non_FCRA_alert_file_list:=join(input_file_count_ds_pjt(product<>'RiskView'),NON_FCRA_result,trim(left.product,left,right)= trim(right.product,left,right) and 
													                 trim(left.version,left,right)= trim(right.version,left,right) and 
																					 trim(left.process1,left,right)= trim(right.process1,left,right) and 
																					 trim(left.customer,left,right)= trim(right.customer,left,right) and
																					 trim(left.model1,left,right)= trim(right.model1,left,right), 
																 transform(recordof(input_file_count_ds) -input_file_count,self:=left),left only
																																															);
	  
          alert_file_list:= FCRA_alert_file_list + Non_FCRA_alert_file_list;
							
						
				  lay_alert := RECORD
					INTEGER order;
					STRING line;
					END;

	        					
					alert_msg_body := PROJECT(dedup(sort(alert_file_list,product,customer,process1,model1,version),product,customer,process1,model1,version), TRANSFORM(lay_alert, SELF.order := 2;
						          SELF.line := (TRIM(LEFT.product) )[1..25]  + LEFT.customer [1..23] + LEFT.process1[1..18]  + LEFT.model1[1..13] + LEFT.version[1..13];
						          SELF := LEFT));		

			

					line_heading := ('product' ) + '\t\t\t' + 'customer' + '\t\t\t' + 'process'+ '\t\t' +  'model'+ '\t\t' + 'version';

					head_cert_realtime := DATASET([{1,    
					''	+ '\n'

					+ line_heading + '\n'
					+ '-------------------------------------------------------------------------------------'
					}], lay_alert); 		

					main_head_ds := DATASET([{3,  'KS Report ' + prev_date + ' vs ' + curr_date +' did not run properly for the following products or versions' + '\n'
					+ '\n'
					}], lay_alert);


					alert_msg:= IF(count(alert_file_list)<69,main_head_ds) + head_cert_realtime + alert_msg_body ;



			  	lay_alert Xform_func(lay_alert L,lay_alert R) := TRANSFORM
					SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
					self := l;
					END;

					alert_msg_file := ITERATE(alert_msg, Xform_func(LEFT, RIGHT));
					
				
					// alert_msg_file;

				
	//********************************************************************	
							
 			  fcra_alert_msg:=	if(count(FCRA_result)<28,'\n ALERT: This FCRA report did not run properly for all products or versions','');
   			
   			nonfcra_alert_msg:=	if(count(NON_FCRA_result)<41,'\n ALERT: This NON-FCRA report did not run properly for all products or versions','');
   																									 
   				 // result;
   
      			out_file := output(FCRA_result , ,'~ScoringQA::out::ks1::FCRA_result' + curr_date, CSV(heading(single), quote('"')), overwrite );
    			
      			
      			string out_file_layout := '';
      
      			
            outfile := dataset('~ScoringQA::out::ks1::FCRA_result' + curr_date, typeof(out_file_layout));
      			
      
            no_of_records := count(outfile);
      			
      			
      			myrec := record, maxlength(9999999) 
      			unsigned code0; 
      			unsigned code1;
      			string line; end;
      
      			myrec ref(outfile l, integer c) := transform 
      			self.code0 := c; 
      			self.code1 := c + 1 ;
      			// self := l; 
            self.line := if( c = 1, 	'                        KS(FCRA) Report Dates   ' +  prev_date + '_VS_' + curr_date + '\n' + l.line 	, l.line);
      			
      			// self.line := if(c = 2 , 'FCRA CUSTOM'   + '\n' + l.line, if(c = 5 , 'FCRA FLAGSHIP'   + '\n' + l.line,
      			                  // if(c = 27 , 'Non Fcra Custom'   + '\n' + l.line, if(c = 32 , 'Non Fcra Flagship'   + '\n' + l.line, l.line)))) ; 
      			end;
      
      			outputs := project(outfile, ref(left, counter));
      			
      			// outputs;
      
      			MyRec Xform(myrec L,myrec R) := TRANSFORM
      			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
      			self := l;
      			END;
      
      			XtabOut := iterate(outputs,Xform(left,right));
      			
            // XtabOut[no_of_records];
      
      						// send_file := fileservices.SendEmailAttachText('isabel.ma@lexisnexisrisk.com',
      			send_file := fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.KS_Success_list,
      			 'KS(FCRA)'  +  'test results Direct from Thor ',
      																				 prev_date + ' vs ' + curr_date + '\nPlease view attachment.'+ fcra_alert_msg ,
      																				 XtabOut[no_of_records].line ,
      																				 'text/plain; charset=ISO-8859-3', 
      																				 'KS_FCRA' +  prev_date + '_VS_' + curr_date + '.csv',
      																				 ,
      																				 ,
      																				 'Scoring_QA@risk.lexisnexis.com');
      																				 
      					out_file1 := output(NON_FCRA_result , ,'~ScoringQA::out::ks1::NON_FCRA_result' + curr_date, CSV(heading(single), quote('"')), overwrite);
      			
      			
      			// string out_file_layout := '';
      
      			
            outfile1 := dataset('~ScoringQA::out::ks1::NON_FCRA_result' + curr_date, typeof(out_file_layout));
      			
      
            no_of_records1 := count(outfile1);
      			
      			
      			myrec1 := record, maxlength(9999999) 
      			unsigned code0; 
      			unsigned code1;
      			string line; end;
      
      			myrec1 ref1(outfile1 l, integer c) := transform 
      			self.code0 := c; 
      			self.code1 := c + 1 ;
      			// self := l; 
            self.line := if( c = 1, 	'                        KS(NON_FCRA) Report Dates   ' +  prev_date + '_VS_' + curr_date + '\n' + l.line 	, l.line);
      			
      			// self.line := if(c = 2 , 'FCRA CUSTOM'   + '\n' + l.line, if(c = 5 , 'FCRA FLAGSHIP'   + '\n' + l.line,
      			                  // if(c = 27 , 'Non Fcra Custom'   + '\n' + l.line, if(c = 32 , 'Non Fcra Flagship'   + '\n' + l.line, l.line)))) ; 
      			end;
      
      			outputs1 := project(outfile1, ref1(left, counter));
      			
      			// outputs;
      
      			MyRec1 Xform1(myrec L,myrec R) := TRANSFORM
      			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
      			self := l;
      			END;
      
      			XtabOut1 := iterate(outputs1,Xform1(left,right));
      			
      			
            // XtabOut[no_of_records];
      
      			
      					// send_file1 := fileservices.SendEmailAttachText('isabel.ma@lexisnexisrisk.com',
      			send_file1 := fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.KS_Success_list,
      			      			 'KS(NON_FCRA)'  +  'test results Direct from Thor ',
      																				 prev_date + ' vs ' + curr_date + '\nPlease view attachment.' + nonfcra_alert_msg,
      																				 XtabOut1[no_of_records1].line ,
      																				 'text/plain; charset=ISO-8859-3', 
      																				 'KS_NON_FCRA' +  prev_date + '_VS_' + curr_date + '.csv',
      																				 ,
      																				 ,
      																				 'Scoring_QA@risk.lexisnexis.com');	
																							 
					   send_file2 :=FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list, 'KS Report Exceptions ' , alert_msg_file[COUNT(alert_msg_file)].line);																		 
					   // send_file2 :=FileServices.SendEmail('isabel.Ma@lexisnexisrisk.com, Matthew.Ludewig@lexisnexisrisk.com', 'KS Report Exceptions ' , alert_msg_file[COUNT(alert_msg_file)].line);																		 
      																				 
      																				 
           sequential ( out_file, send_file ,out_file1,send_file1,IF(count(alert_file_list)>0,send_file2));																				 
     																 
     
   
      
      EXPORT bwr_ks_test := 'todo';
      