import avenger, ut;
EXPORT proc_buildbase_old(string filedate) := function
#option('multiplePersistInstances',FALSE);

infile_question := Avenger.file_in.question;
infile_transaction := Avenger.file_in.transaction;
infile_quiz := Avenger.file_in.quiz;
infile_assertion := Avenger.file_in.assertion;
infile_factranking := Avenger.file_in.factranking;

verid_question    := avenger.fn_mapping_question_old(infile_question);
verid_transaction := avenger.fn_mapping_transaction_old(infile_transaction);
IDM_quiz_daily := avenger.fn_mapping_irm_old(infile_quiz);

//filter out invalid tran_date from transaction and question tables

verid_question_filter := verid_question(Question_Time_Start[1..6] != '201307');
verid_transaction_filter := verid_transaction(tran_date[1..6] != '201201');

//filter out question matched invalid transacton

avenger.layout_common.old tjoin_invalid_tran_quest(verid_question_filter le, verid_transaction_filter ri)  := transform

self := le;

end;

verid_question_valid := join(distribute(verid_question_filter, hash(tran_id)),
distribute(verid_transaction_filter(tran_type = ''), hash(tran_id)), left.tran_id = right.tran_id, tjoin_invalid_tran_quest(left, right), left only, local);

avenger.layout_common.old tjoin_tran_quest(verid_transaction_filter le, verid_question_valid ri)  := transform
//common fields between transaction and question
self.Tran_Conversation_ID	:=	if(le.Tran_Conversation_ID <> '', le.Tran_Conversation_ID, ri.Tran_Conversation_ID);
self.tran_id := if(le.TRAN_ID <> '', le.TRAN_ID, ri.TRAN_ID);
self.Selected_LexID := if(le.Selected_LexID <> '', le.Selected_LexID, ri.Selected_LexID);
self.tran_type := if(le.tran_type <> '', le.tran_type, ri.tran_type);
self.Cust_Account  := if(le.Cust_Account <> '', le.Cust_Account, ri.Cust_Account) ;
//fields existing in transaction
self.Cust_Username := le.Cust_Username;
self.Cust_AgentName	:= le.Cust_AgentName;
self.Cust_Business_Name	 := le.Cust_Business_Name;
self.Cust_Business_TaxID	:= le.Cust_Business_TaxID;
self.Cust_Workflow_Name	:= le.Cust_Workflow_Name;
self.Cust_Consumer_Type	:= le.Cust_Consumer_Type;
self.Cust_Purchase_Amt	:= le.Cust_Purchase_Amt;
self.Cust_IPAddress	 := le.Cust_IPAddress;
self.Tran_Date	:= 	le.tran_date;
self.Tran_TotalTime := le.Tran_TotalTime;
self.Tran_Day := le.Tran_Day;
self.Tran_Final_Status	:= 	le.Tran_Final_Status	;
self.Tran_Finalization_Date	:= 	le.Tran_Finalization_Date	;
self.Tran_Finalization_Time	:= 	le.Tran_Finalization_Time	;
self.Tran_Fail_ReasonCode	:= 	le.Tran_Fail_ReasonCode  	;
self.Tran_Process_Type	:= 	le.Tran_Process_Type	;
self.Tran_Channel_type	:= 	le.Tran_Channel_type	;
self.Tran_Channel_API_ReqType	:= 	le.Tran_Channel_API_ReqType	;
self.Tran_Channel_BatchID	:= 	le.Tran_Channel_BatchID	;
self.Tran_Source_Type	:= 	le.Tran_Source_Type	;
self.Tran_LN_ServerName	:= 	le.Tran_LN_ServerName	;
self.Tran_ConsumerIP	:= 	le.Tran_ConsumerIP	;
self.Tran_Unique_IdentityID	:= 	le.Tran_Unique_IdentityID	;
self.Tran_TaskLevel_Orig	:= 	le.Tran_TaskLevel_Orig	;
self.Tran_TaskLevel_Final	:= 	le.Tran_TaskLevel_Final	;
self.Tran_Query_Check	:= 	le.Tran_Query_Check	;
self.Tran_CustomerID_Hashed	:= 	le.Tran_CustomerID_Hashed	;
self.Tran_SequenceNumber	:= 	le.Tran_SequenceNumber	;
self.Tran_Record_Update_Time	:= 	le.Tran_Record_Update_Time;
self.Tran_Determinator_Time	:= 	le.Tran_Determinator_Time	;
self.Cust_Agent_Risk_AssesType	:= 	le.Cust_Agent_Risk_AssesType	;
self.Input_LexID	:= le.Input_LexID;
self.Input_Name_First	:= le.Input_Name_First	;
self.Input_Name_Last	:= 	le.Input_Name_Last ;
self.Input_Name_Prefix	:= 	le.Input_Name_Prefix;
self.Input_Name_Middle	:= 	le.Input_Name_Middle	;
self.Input_Name_Suffix	:= 	le.Input_Name_Suffix;
self.Input_DOB	:= le.Input_DOB;
self.Input_Phone	:= 	le.Input_Phone	;
self.Input_DL_Number	:= 	le.Input_DL_Number	;
self.Input_DL_State	:= 	le.Input_DL_State	;
self.Input_Street	:= 	le.Input_Street	;
self.Input_City	:= 	le.Input_City ;
self.Input_State	:= 	le.Input_State	;
self.Input_Zip	:= 	le.Input_Zip	;
self.Input_Country	:= 	le.Input_Country	;
self.Input_SSN	:= 	le.Input_SSN	;
self.Input_SSN_Type_Length	:= 	le.Input_SSN_Type_Length	;
self.Input_SSN_Encrypted	:= 	le.Input_SSN_Encrypted	;
self.Discovery_Identity_Located	:= 	le.Discovery_Identity_Located	;
/*self.Identity_Located_Status	:= 	le.Identity_Located_Status	;
self.Identity_NotLocated	:= 	le.Identity_NotLocated	;
self.Identity_NotLocated_Status	:= 	le.Identity_NotLocated_Status	;*/
self.Discovery_Identity_BestScore	:= 	le.Discovery_Identity_BestScore	;
self.Discovery_Identity_MaxScore	:= 	le.Discovery_Identity_MaxScore	;
self.Discovery_Identity_PassThreshold	:= 	le.Discovery_Identity_PassThreshold	;
self.Product_IID_Used	:=	le.Product_IID_Used	;
self.Product_IID_CVI	:=	le.Product_IID_CVI	;
self.Product_IID_NAS	:=	le.Product_IID_NAS	;
self.Product_IID_NAP	:=	le.Product_IID_NAP	;
self.Product_IID_RiskIndicators	:=	le.Product_IID_RiskIndicators	;
self.Product_IID_RiskIndicator1 := le.Product_IID_RiskIndicator1;
self.Product_IID_RiskIndicator2 := le.Product_IID_RiskIndicator2;
self.Product_IID_RiskIndicator3 := le.Product_IID_RiskIndicator3;
self.Product_IID_RiskIndicator4 := le.Product_IID_RiskIndicator4;
self.Product_IID_RiskIndicator5 := le.Product_IID_RiskIndicator5;
self.Product_IID_RiskIndicator6 := le.Product_IID_RiskIndicator6;
self.Product_IID_FP_Used	:=	le.Product_IID_FP_Used	;
self.Product_IID_FP_Score	:=	le.Product_IID_FP_Score	;
self.Product_IID_FP_RiskIndicators	:= le.Product_IID_FP_RiskIndicators	;
self.Product_IID_FP_RiskIndicator1 := le.Product_IID_FP_RiskIndicator1;
self.Product_IID_FP_RiskIndicator2 := le.Product_IID_FP_RiskIndicator2; 
self.Product_IID_FP_RiskIndicator3 := le.Product_IID_FP_RiskIndicator3;
self.Product_IID_FP_RiskIndicator4 := le.Product_IID_FP_RiskIndicator4;
self.Product_IID_FP_RiskIndicator5 := le.Product_IID_FP_RiskIndicator5;
self.Product_IID_FP_RiskIndicator6 := le.Product_IID_FP_RiskIndicator6;
self.Product_IID_FP_RiskIndices	:=	le.Product_IID_FP_RiskIndices	;
self.Product_IID_FP_RI_Stolen      := le.Product_IID_FP_RI_Stolen;
self.Product_IID_FP_RI_Synthetic   := le.Product_IID_FP_RI_Synthetic;
self.Product_IID_FP_RI_Manipulated := le.Product_IID_FP_RI_Manipulated;
self.Product_IID_FP_RI_Friendly    := le.Product_IID_FP_RI_Friendly;
self.Product_IID_FP_RI_Vulnerable  := le.Product_IID_FP_RI_Vulnerable;
self.Product_IID_FP_RI_Suspicous   := le.Product_IID_FP_RI_Suspicous;
self.Product_IID_RedFlag_RiskIndicators	:=	le.Product_IID_RedFlag_RiskIndicators	;
self.Product_FlexID_Used	:=	le.Product_FlexID_Used	;
self.Product_OFAC_StatusType	:=	le.Product_OFAC_StatusType	;
self.Cust_Fraud_Type_Prov	:=	le.Cust_Fraud_Type_Prov	;
self.Cust_Fraud_Status	:=	le.Cust_Fraud_Status	;
self.Cust_Fraud_Status_LastUpdated	:=	le.Cust_Fraud_Status_LastUpdated	;
self.Cust_Reference_ID	:=	le.Cust_Reference_ID	;
self.Auth_LexID_Returned := le.Auth_LexID_Returned;
self.Auth_Unique_ID := le.Auth_Unique_ID;
//field existing in question
self.Auth_Score	:= 	ri.Auth_Score;
self.Auth_Outcome	:= 	ri.Auth_Outcome	;
self.Auth_Pass	:= 	ri.Auth_Pass	;
self.Auth_Fail	:= 	ri.Auth_Fail	;
self.Auth_OptOut	:= 	ri.Auth_OptOut	;
self.Auth_UnableToGengerate	:= 	ri.Auth_UnableToGengerate	;
self.Auth_Error	:= 	ri.Auth_Error	;
self.Auth_Quiz_Expired	:= 	ri.Auth_Quiz_Expired	;
self.Question_Set_ID	:=	ri.Question_Set_ID	;
self.Question_ID	:=	ri.Question_ID	;
self.Question_Time_Creation	:=	ri.Question_Time_Creation;
self.Question_Time_Start	:=	ri.Question_Time_Start	;
self.Question_Time_End	:=	ri.Question_Time_End	;
self.Question_Time_Total := ri.Question_Time_Total;
self.Question_Subset_Number	:=	ri.Question_Subset_Number	;
self.Question_Category_Numeric	:=	ri.Question_Category_Numeric	;
self.Question_Set_Type	:=	ri.Question_Set_Type	;
self.Question_Tier_Type	:=	ri.Question_Tier_Type	;
self.Question_Style_Type	:=	ri.Question_Style_Type	;
self.Question_Category_String	:=	ri.Question_Category_String	;
self.Question_Presentation_Position	:=	ri.Question_Presentation_Position	;
self.Question_Presentation_Weight	:=	ri.Question_Presentation_Weight	;
self.Question_Contribution_Weight	:=	ri.Question_Contribution_Weight	;
self.Question_Data_Source	:=	ri.Question_Data_Source    	;
self.Question_Language_Type	:=	ri.Question_Language_Type	;
self.Question_Answer_Grade  	:=	ri.Question_Answer_Grade	;
self.Question_Answer_Grade_OutcomeType	:=	ri.Question_Answer_Grade_OutcomeType	;
//self.Question_Answers_NumSelected	:=	ri.Question_Answers_NumSelected	;
//self.Question_Answers_NumCorrect	:=	ri.Question_Answers_NumCorrect	;
self.Question_Answers_NoneOfAboveSelected	:=	ri.Question_Answers_NoneOfAboveSelected	;
self.Question_Raw_Question	:=	ri.Question_Raw_Question	;
self.Question_Raw_CorrectAnswer	:=	ri.Question_Raw_CorrectAnswer	;
self.Question_Raw_UserAnswer	:=	ri.Question_Raw_UserAnswer  	;
self.Quiz_Outcome   := ri.Quiz_Outcome;
self.Quiz_Outcome_1 := ri.Quiz_Outcome_1;
self.Quiz_Outcome_2  := ri.Quiz_Outcome_2;
//self.Quiz_Status_Passfail  := ri.Quiz_Status_Passfail;
self.Quiz_Outcome_TimeOut  := ri.Quiz_Outcome_TimeOut;
//self.Question_Type_Diversionary := ri.Question_Type_Diversionary;
self.Question_Answers_AOASelected  :=  ri.Question_Answers_AOASelected;
self := le;//probably not necessary and just for safety
self := ri;//probably not necessary and just for safety

end;

verid_question_transaction_comb := join(distribute(verid_transaction_filter(tran_type <> ''), hash(tran_id)),
distribute(verid_question_valid, hash(tran_id)), left.tran_id = right.tran_id, tjoin_tran_quest(left, right), full outer, local):persist('~thor_data400::persist::avenger_verid_quest_trans_comb');

avenger_verid_comb_dedup := dedup(sort(verid_question_transaction_comb, record, local), record, local);

//mapping avenger valid values after join question and transaction table

avenger_verid_comb_dedup tmapping_avenger_values(avenger_verid_comb_dedup le) := transform

boolean identity_found := le.Auth_LexID_Returned not in ['', '-3'] or le.Selected_LexID not in ['', '-3'];
self.Question_Set_ID	:=	if(le.Question_Set_ID	<> '',le.Question_Set_ID, if(identity_found, '-2', '-3'));
self.Question_Time_Creation	:=	if(le.Question_Time_Creation	<> '',le.Question_Time_Creation, if(identity_found, '-2', '-3'));
self.Question_Time_Start	:=	if(le.Question_Time_Start	<> '',le.Question_Time_Start, if(identity_found, '-2', '-3'));
self.Question_Time_End	:=	if(le.Question_Time_End	<> '',le.Question_Time_End, if(identity_found, '-2', '-3'));
self.Question_Time_Total := if(le.Question_Time_Total	<> '',le.Question_Time_Total, if(identity_found, '-2', '-3'));
self.Question_Subset_Number	:=	if(le.Question_Subset_Number	<> '',le.Question_Subset_Number, if(identity_found, '-2', '-3'));
self.Question_Category_Numeric	:=	if(le.Question_Category_Numeric	<> '',le.Question_Category_Numeric, if(identity_found, '-2', '-3'));
self.Question_Set_Type	:=	if(le.Question_Set_Type	<> '',le.Question_Set_Type, if(identity_found, '-2', '-3'));
self.Question_Tier_Type	:=	if(le.Question_Tier_Type	<> '',le.Question_Tier_Type, if(identity_found, '-2', '-3'));
self.Question_Style_Type	:=	if(le.Question_Style_Type	<> '',le.Question_Style_Type, if(identity_found, '-2', '-3'));
self.Question_Category_String	:=	if(le.Question_Category_String	<> '',le.Question_Category_String, if(identity_found, '-2', '-3'));
self.Question_Presentation_Position	:=	if(le.Question_Presentation_Position	<> '',le.Question_Presentation_Position, if(identity_found, '-2', '-3'));
self.Question_Presentation_Weight	:=	if(le.Question_Presentation_Weight	<> '',le.Question_Presentation_Weight, if(identity_found, '-2', '-3'));
self.Question_Contribution_Weight	:=	if(le.Question_Contribution_Weight	<> '',le.Question_Contribution_Weight, if(identity_found, '-2', '-3'));
self.Question_Data_Source	:=	if(le.Question_Data_Source	<> '',le.Question_Data_Source, if(identity_found, '-2', '-3'));
self.Question_Language_Type	:=	if(le.Question_Language_Type	<> '',le.Question_Language_Type, if(identity_found, '-2', '-3'));
self.Question_Answer_Grade  	:=	if(le.Question_Answer_Grade	<> '',le.Question_Answer_Grade, if(identity_found, '-2', '-3'));
self.Question_Answer_Grade_OutcomeType	:=	if(le.Question_Answer_Grade_OutcomeType	<> '',le.Question_Answer_Grade_OutcomeType, if(identity_found, '-2', '-3'));
self.Question_Answers_NoneOfAboveSelected	:=	if(le.Question_Answers_NoneOfAboveSelected	<> '',le.Question_Answers_NoneOfAboveSelected, if(identity_found, '-2', '-3'));
self.Question_Raw_Question	:=	if(le.Question_Raw_Question	<> '',le.Question_Raw_Question, if(identity_found, '-2', '-3'));
self.Question_Raw_CorrectAnswer	:=	if(le.Question_Raw_CorrectAnswer	<> '',le.Question_Raw_CorrectAnswer, if(identity_found, '-2', '-3'));
self.Question_Raw_UserAnswer	:=	if(le.Question_Raw_UserAnswer	<> '',le.Question_Raw_UserAnswer, if(identity_found, '-2', '-3'));
self.Quiz_Outcome   := if(le.Quiz_Outcome	<> '',le.Quiz_Outcome, if(identity_found, '-2', '-3'));
self.Quiz_Outcome_1 := if(le.Quiz_Outcome_1	<> '',le.Quiz_Outcome_1, if(identity_found, '-2', '-3'));
self.Quiz_Outcome_2  := if(le.Quiz_Outcome_2	<> '',le.Quiz_Outcome_2, if(identity_found, '-2', '-3'));
self.Quiz_Outcome_TimeOut  := if(le.Quiz_Outcome_TimeOut	<> '',le.Quiz_Outcome_TimeOut, if(identity_found, '-2', '-3'));
self.Question_Answers_AOASelected  :=  if(le.Question_Answers_AOASelected	<> '',le.Question_Answers_AOASelected, if(identity_found, '-2', '-3'));

self := le;

end;


avenger_verid_mapping:= project(avenger_verid_comb_dedup,tmapping_avenger_values(left));

avenger_verid_daily := avenger_verid_mapping(~(tran_id  <> '' and cust_username  = '' and Tran_Date = ''));

//combine verid, IDM and assertion,verid daily update temporarily removed till VERID daily feed is ready

combine_all := //avenger_verid_daily +
dedup(sort(IDM_quiz_daily + distribute(Avenger.file_base, hash(Tran_Conversation_ID)),record, local),record, local);

create_base := sequential(output(combine_all,,'~thor_data400::base::avenger::combine_all_' + filedate, overwrite, __compressed__),
					fileservices.promotesuperfilelist(['~thor_data400::base::avenger::full_history',
													'~thor_data400::base::avenger::full_history_father'],'~thor_data400::base::avenger::combine_all_' + filedate, true));
											
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
																		
fn_MoveProcessedFiles(STRING ext) := FUNCTION
																				
	addsuper := fileservices.addsuperfile('~thor_data400::in::avenger::'+ext+'::processed', '~thor_data400::in::avenger::'+ext,,true);
	clearsuperin := fileservices.clearsuperfile('~thor_data400::in::avenger::'+ext);

RETURN NOTHOR(SEQUENTIAL(addsuper,clearsuperin));
END;

MoveProcessedFiles := SEQUENTIAL(
																fn_MoveProcessedFiles('idm::quiz');
															//	fn_MoveProcessedFiles('verid::transaction');
															//	fn_MoveProcessedFiles('verid::question');
															);
	

RETURN SEQUENTIAL(create_base, MoveProcessedFiles);

end;
