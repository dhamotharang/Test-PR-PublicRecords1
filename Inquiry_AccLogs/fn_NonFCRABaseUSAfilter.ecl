IMPORT INQL_V2, Data_services; //Temporary
Export fn_NonFCRABaseUSAfilter(string base = 'daily') := Function

File_MBS := Inquiry_AccLogs.File_MBS.File;

NonBatch_Daily_Base 	 := Inquiry_acclogs.File_Bridger_Logs_Common + 
													Inquiry_acclogs.File_Custom_Logs_Common + 
													Inquiry_acclogs.File_Banko_Logs_Common + 
													Inquiry_acclogs.File_Riskwise_Logs_Common + 
													Inquiry_AccLogs.File_IDM_Logs_Common +
													Inquiry_acclogs.File_Accurint_Logs_Common;

Batch_Daily_Base 				:=  Inquiry_AccLogs.File_Batch_Logs_Common + 
														Inquiry_AccLogs.File_BatchR3_Logs_Common;

NonBatch_Hist_Base    := Inquiry_AccLogs.File_Inquiry_MBS(source not in ['BATCHR3','BATCH']);

Batch_Hist_Base    		:= Inquiry_AccLogs.File_Inquiry_MBS(source in ['BATCHR3','BATCH']);

NonBatch_Base 	 := if(base='daily',NonBatch_Daily_Base,NonBatch_Hist_Base);

Batch_Base       := if(base='daily',Batch_Daily_Base,Batch_Hist_Base);

jnByProd		 	:= join(NonBatch_Base, FILE_MBS, 
										 left.search_info.product_code   = right.product_id and                    
										 left.mbs.company_id = right.company_id, 
										 left outer, lookup);	

jnSubAccd    	:= join(project(jnByProd(sub_acct_id = ''), recordof(NonBatch_Base)), File_MBS,  
											 trim(left.mbs.global_company_id,all) = trim(right.gc_id,all),
												left outer, lookup);						
	
NonBatch_Base_MBS				:= jnByProd(sub_acct_id <> '') + jnSubAccd;

Batch_Base_MBS		    	:= join(Batch_Base, FILE_MBS,  
													 trim(left.mbs.global_company_id,all) = trim(right.gc_id,all),
														left outer, lookup);						

// Full_Base_MBS   := NonBatch_Base_MBS + Batch_Base_MBS;

Full_Base_MBS	:= if(base='daily'
                   ,dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa', INQL_v2.Layouts.Common_ThorAdditions, thor)
									 ,dataset(Data_Services.foreign_logs + 'thor_data::base::inql::nonfcra::weekly::qa', INQL_v2.Layouts.Common_ThorAdditions, thor)
									 );
   
USA_Base_MBS       := Full_Base_MBS(country = 'UNITED STATES');

USA_Base := project(USA_Base_MBS, Inquiry_AccLogs.Layout.Common_ThorAdditions);

Return USA_Base; 

end; 
