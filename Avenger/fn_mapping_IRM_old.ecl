import ut, lib_stringlib, address;
#option('multiplePersistInstances',FALSE);

EXPORT fn_mapping_IRM_old(dataset(avenger.layout_in.quiz) pInFile) := function

//dedup quiz input files
InFile_dedup := dedup(sort(distribute(pInFile, hash(CONVERSATION_ID)), record, local), record, local);

//exclude invalid account 
invalid_account := avenger.file_in.invalid_idm_account(account_id <> '');

InFile_dedup tjoin(InFile_dedup le, invalid_account ri) := transform

self.conversation_id := if(le.ACCOUNT = ri.Account_id, '', le.conversation_id);
self := le;

end;


infile_quiz_has_invalid := join(InFile_dedup, invalid_account,
left.ACCOUNT = right.Account_id, tjoin(left, right), left outer, lookup);

//filter out invalid account

infile_quiz_has_valid := infile_quiz_has_invalid(conversation_id <> '' and trans_client_id <> '');  

//remove special characters
ut.CleanFields(infile_quiz_has_valid, clean_quiz)

avenger.layout_common.old tmap_irm_quiz(clean_quiz le) := transform

fixDate := avenger.fncleanfunctions.tDateAdded(avenger.fncleanfunctions.clean_fields(le.TRANSACTION_DATE));
fixTime := avenger.fncleanfunctions.tTimeAdded(avenger.fncleanfunctions.clean_fields(fixDate));

boolean identity_found := avenger.fncleanfunctions.clean_fields(le.PROCHECK_Link_ID) <> '' or avenger.fncleanfunctions.clean_fields(le.PROID_link_id) <> '' or 
avenger.fncleanfunctions.clean_fields(le.ID_DISCOVERY_Link_ID) <> '' or avenger.fncleanfunctions.clean_fields(le.selected_link_id) <> '';

self.Cust_Account	:=	if(avenger.fncleanfunctions.clean_fields(le.ACCOUNT) <> '', avenger.fncleanfunctions.clean_fields(le.ACCOUNT), '-1');
self.Cust_UserName 	:=	if(avenger.fncleanfunctions.clean_fields(le.CUST_USERNAME) <> '',avenger.fncleanfunctions.clean_fields(le.CUST_USERNAME), '-1');
self.Cust_AgentName	:=	if(avenger.fncleanfunctions.clean_fields(le.OPER_USERNAME) <> '',avenger.fncleanfunctions.clean_fields(le.OPER_USERNAME), '-1');
self.Cust_Business_Name	:=	if(avenger.fncleanfunctions.clean_fields(le.Business_Name) <> '', avenger.fncleanfunctions.clean_fields(le.Business_Name), '-1');
self.Cust_Business_TaxID	:=	if(avenger.fncleanfunctions.clean_fields(le.TaxID) <> '', avenger.fncleanfunctions.clean_fields(le.TaxID),
if(avenger.fncleanfunctions.clean_fields(le.FEIN) <> '', avenger.fncleanfunctions.clean_fields(le.FEIN), '-1'));
self.Cust_Workflow_Name	:=	if(avenger.fncleanfunctions.clean_fields(le.ALIAS_NAME) <> '', 	avenger.fncleanfunctions.clean_fields(le.ALIAS_NAME), '-1');
self.Cust_IPAddress :=  if(avenger.fncleanfunctions.clean_fields(le.SOURCE_IP) <> '',	avenger.fncleanfunctions.clean_fields(le.SOURCE_IP), '-1');
self.Tran_type       := '3';
self.Tran_Number	:=	if(avenger.fncleanfunctions.clean_fields(le.TRANS_NUM_ID) <> '', avenger.fncleanfunctions.clean_fields(le.TRANS_NUM_ID), '-2');
self.Tran_Date	:=	if(fixTime <> '', fixTime, '-2');
self.Tran_Day := avenger.getcode_old.trandaycode(ut.weekday((unsigned)fixTime[1..8]));
self.Tran_ID	:=	if(avenger.fncleanfunctions.clean_fields(le.TRANS_CLIENT_ID) <> '', avenger.fncleanfunctions.clean_fields(le.TRANS_CLIENT_ID), '-2');
self.Tran_Product_Sequence	:=	if(avenger.fncleanfunctions.clean_fields(le.PRODUCT_SEQUENCE) <> '', avenger.fncleanfunctions.clean_fields(le.PRODUCT_SEQUENCE), '-2');
self.Tran_Group_Name	:=	if(avenger.fncleanfunctions.clean_fields(le.GROUP_NAME) <> '', avenger.fncleanfunctions.clean_fields(le.GROUP_NAME), '-2');
self.Tran_Group_code	:=	avenger.getcode_old.TranGroupCode(avenger.fncleanfunctions.clean_fields(le.GROUP_NAME));
self.Tran_Group_Seq	:=	if(avenger.fncleanfunctions.clean_fields(le.GROUP_SEQUENCE)	<> '', avenger.fncleanfunctions.clean_fields(le.GROUP_SEQUENCE), '-2');
self.Tran_Verif_Prod_Used	:=	avenger.getcode_old.TranSubProdName(avenger.fncleanfunctions.clean_fields(le.SUB_PRODUCT_NAME));
self.Tran_Verif_Prod_Seq	:=	if(avenger.fncleanfunctions.clean_fields(le.SUB_PRODUCT_SEQUENCE) <> '', avenger.fncleanfunctions.clean_fields(le.SUB_PRODUCT_SEQUENCE), '-2');
self.Tran_Conversation_ID	:=	if(avenger.fncleanfunctions.clean_fields(le.CONVERSATION_ID) <> '', avenger.fncleanfunctions.clean_fields(le.CONVERSATION_ID), '-2');
self.Input_LexID	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_Link_ID) <> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_Link_ID), '-1');
self.Input_Name_First	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_FIRST_NAME) <> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_FIRST_NAME), '-1');
self.Input_Name_Last	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_LAST_NAME) <> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_LAST_NAME), '-1');

clean_inputed_DOB := Avenger.fncleanfunctions.clean_irm_dob(avenger.fncleanfunctions.clean_fields(le.INPUTED_DOB));
self.Input_DOB	:=	if(clean_inputed_DOB <> '',clean_inputed_DOB, '-1');
clean_inputed_phone := Avenger.fncleanfunctions.clean_phone(avenger.fncleanfunctions.clean_fields(le.INPUTED_Phone_Number));
self.Input_Phone	:=	if(clean_inputed_phone <> '',clean_inputed_phone, '-1');
self.Input_Street	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_STREET)	<> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_STREET), '-1');
self.Input_City	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_CITY)	<> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_CITY), '-1');
self.Input_State	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_STATE) <> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_STATE), '-1');
self.Input_Zip	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_ZIP) <> '',	avenger.fncleanfunctions.clean_fields(le.INPUTED_ZIP), '-1');
self.Input_SSN	:=	if(avenger.fncleanfunctions.clean_fields(le.INPUTED_SSN) <> '', avenger.fncleanfunctions.clean_fields(le.INPUTED_SSN), '-1');

clean_selected_link_id := avenger.fncleanfunctions.clean_fields(le.SELECTED_Link_ID);
clean_selected_DOB := Avenger.fncleanfunctions.clean_irm_dob(avenger.fncleanfunctions.clean_fields(le.SELECTED_DOB));

self.Selected_LexID	:=	if(clean_selected_link_id <> '',clean_selected_link_id, '-3');
self.Selected_Name_First	:=	if(avenger.fncleanfunctions.clean_fields(le.SELECTED_FIRST_NAME) <> '', avenger.fncleanfunctions.clean_fields(le.SELECTED_FIRST_NAME),
if(clean_selected_link_id <> '', '-2', '-3'))	;
self.Selected_Name_Last	:=	if(avenger.fncleanfunctions.clean_fields(le.SELECTED_LAST_NAME) <> '', avenger.fncleanfunctions.clean_fields(le.SELECTED_LAST_NAME),
if(clean_selected_link_id <> '', '-2', '-3'));
self.Selected_SSN	:=	if(avenger.fncleanfunctions.clean_fields(le.Selected_SSN) <> '', avenger.fncleanfunctions.clean_fields(le.Selected_SSN),
if(clean_selected_link_id <> '', '-2', '-3'));
self.Selected_DOB	:=	if(clean_selected_DOB <> '',clean_selected_DOB,
if(clean_selected_link_id <> '' and clean_selected_DOB = '', '-2', '-3'));
self.Selected_Street	:=	if(avenger.fncleanfunctions.clean_fields(le.Selected_Street) <> '', avenger.fncleanfunctions.clean_fields(le.Selected_Street),
if(clean_selected_link_id <> '', '-2', '-3'));
self.Selected_City	:=	if(avenger.fncleanfunctions.clean_fields(le.Selected_City) <> '', avenger.fncleanfunctions.clean_fields(le.Selected_City),
if(clean_selected_link_id <> '', '-2', '-3'));
self.Selected_State	:=	if(avenger.fncleanfunctions.clean_fields(le.Selected_State) <> '', avenger.fncleanfunctions.clean_fields(le.Selected_State),
if(clean_selected_link_id <> '', '-2', '-3'));
self.Selected_Zip	:=	if(avenger.fncleanfunctions.clean_fields(le.Selected_Zip) <> '', avenger.fncleanfunctions.clean_fields(le.Selected_Zip),
if(clean_selected_link_id <> '', '-2', '-3'));
self.Discovery_step := 
If(avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION) = '0' and avenger.fncleanfunctions.clean_fields(le.IS_AUTHENTICATION) ='0', '1', 
IF(avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION) = '1' or avenger.fncleanfunctions.clean_fields(le.IS_AUTHENTICATION) = '1', '0' , 
if(identity_found, '-2', '-3')));

self.Discovery_Identity_Unique_Count	:=	if(self.Discovery_step = '1' and avenger.fncleanfunctions.clean_fields(le.UNIQUE_IDENTITY_COUNT) <> '',
avenger.fncleanfunctions.clean_fields(le.UNIQUE_IDENTITY_COUNT),if(self.Discovery_step = '0' and avenger.fncleanfunctions.clean_fields(le.UNIQUE_IDENTITY_COUNT) <> '', '-1', 
if(identity_found and avenger.fncleanfunctions.clean_fields(le.UNIQUE_IDENTITY_COUNT) = '', '-2', '-3')));

identity_located_convert := avenger.getcode_old.DiscoveryIdentitylocated(avenger.fncleanfunctions.clean_fields(le.IDENTITY_LOCATED));
self.Discovery_Identity_Located	:=	if(self.Discovery_step = '1' and identity_located_convert <> '',identity_located_convert,
if(self.Discovery_step = '0', '-1', if(identity_found and identity_located_convert = '', '-2', '-3')));

self.Discovery_LexID_Returned	:=	if(self.Discovery_step = '1' and avenger.fncleanfunctions.clean_fields(le.ID_DISCOVERY_Link_ID)	<> '',avenger.fncleanfunctions.clean_fields(le.ID_DISCOVERY_Link_ID), 
if(self.Discovery_step = '0', '-1', '-3'));
self.Discovery_WorkflowConfig_ID	:=	if(self.Discovery_step = '1' and avenger.fncleanfunctions.clean_fields(le.ID_DISCOVERY_ALIAS) <> '', 	avenger.fncleanfunctions.clean_fields(le.ID_DISCOVERY_ALIAS), 
if(self.Discovery_step = '0','-1', if(identity_found and avenger.fncleanfunctions.clean_fields(le.ID_DISCOVERY_ALIAS) = '', '-2', '-3')));
self.Verif_Step	:=	if(avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION) in ['0', '1'], avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION),
if(identity_found and avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION) = '', '-2', '-3'));
self.Verif_SysResponseTime	:=	if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.VERIF_RESPONSE_TIME) <> '',
avenger.fncleanfunctions.clean_fields(le.VERIF_RESPONSE_TIME), if(self.Verif_Step = '0', '-1',
if(identity_found and avenger.fncleanfunctions.clean_fields(le.VERIF_RESPONSE_TIME) = '', '-2', '-3')));
self.Verif_Outcome	:=	if(self.Verif_Step = '1'and avenger.fncleanfunctions.clean_fields(le.VERIF_STATUS) <> '',
avenger.fncleanfunctions.clean_fields(le.VERIF_STATUS), if(self.Verif_Step = '0', '-1',
if(identity_found and avenger.fncleanfunctions.clean_fields(le.VERIF_STATUS) = '', '-2', '-3')));
self.Verif_NumChecks	:=	if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.NUM_VERIF_CHKS) <> '',
avenger.fncleanfunctions.clean_fields(le.NUM_VERIF_CHKS), if(identity_found	and avenger.fncleanfunctions.clean_fields(le.NUM_VERIF_CHKS) = '', '-2', '-3')));
self.Verif_NumChecks_Passed	:= if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.NUM_VERIF_CHKS_PASS) <> '',
avenger.fncleanfunctions.clean_fields(le.NUM_VERIF_CHKS_PASS), if(identity_found and avenger.fncleanfunctions.clean_fields(le.NUM_VERIF_CHKS_PASS) = '', '-2', '-3')));
self.Verif_NoDataFound	:=	if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND) <> '',
avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND), if(identity_found and avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND) = '', '-2', '-3')));
self.Verif_NoDataFound_Status	:=	if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND_STATUS) <> '',
avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND_STATUS), if(identity_found and avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND_STATUS) = '', '-2', '-3')));
self.Verif_Error	:=	if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.VERIF_ERROR) <> '',
avenger.fncleanfunctions.clean_fields(le.VERIF_ERROR), if(identity_found and avenger.fncleanfunctions.clean_fields(le.VERIF_NO_DATA_FOUND_STATUS) = '', '-2', '-3')));
self.Verif_Error_Status	:=	if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.VERIF_ERROR_STATUS) <> '',
avenger.fncleanfunctions.clean_fields(le.VERIF_ERROR_STATUS), if(identity_found and avenger.fncleanfunctions.clean_fields(le.VERIF_ERROR_STATUS) = '', '-2', '-3')));
self.Verif_LexID_Returned	:=	if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.PROCHECK_Link_ID) <> '', avenger.fncleanfunctions.clean_fields(le.PROCHECK_Link_ID),
if(self.Verif_Step = '0', '-1', '-3'));
self.Verif_WorkflowConfig_ID	:=	if(self.Verif_Step = '0', '-1', if(self.Verif_Step = '1' and avenger.fncleanfunctions.clean_fields(le.PROCHECK_ALIAS) <> '',
avenger.fncleanfunctions.clean_fields(le.PROCHECK_ALIAS), if(identity_found and avenger.fncleanfunctions.clean_fields(le.PROCHECK_ALIAS)	<> '', '-2', '-3')));

clean_auth_lexID := avenger.fncleanfunctions.clean_fields(le.PROID_Link_ID);
self.Auth_Step	:=	if(avenger.fncleanfunctions.clean_fields(le.IS_AUTHENTICATION) in ['0', '1'], avenger.fncleanfunctions.clean_fields(le.IS_AUTHENTICATION),
if(identity_found and avenger.fncleanfunctions.clean_fields(le.IS_AUTHENTICATION) = '', '-2', '-3'));
self.Auth_ResponseTime	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and avenger.fncleanfunctions.clean_fields(le.AUTH_RESPONSE_TIME) <> '',
 avenger.fncleanfunctions.clean_fields(le.AUTH_RESPONSE_TIME), if(identity_found and avenger.fncleanfunctions.clean_fields(le.AUTH_RESPONSE_TIME) = '', '-2', '-3')));
self.Auth_Score	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and avenger.fncleanfunctions.clean_fields(le.AUTH_SCORE) <> '',
 avenger.fncleanfunctions.clean_fields(le.AUTH_SCORE), if(identity_found and avenger.fncleanfunctions.clean_fields(le.AUTH_SCORE) = '', '-2', '-3')));
self.Auth_RequiredScore	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and avenger.fncleanfunctions.clean_fields(le.AUTH_REQU_SCORE) <> '',
 avenger.fncleanfunctions.clean_fields(le.AUTH_REQU_SCORE), if(identity_found and avenger.fncleanfunctions.clean_fields(le.AUTH_REQU_SCORE) = '', '-2', '-3')));

auth_status_convert := avenger.getcode_old.Authstatus(avenger.fncleanfunctions.clean_fields(le.AUTH_STATUS));
self.Auth_Outcome	:=	if(self.auth_step = '0', '-1', if(self.Auth_Step = '1' and auth_status_convert<> '', auth_status_convert,
if(identity_found and auth_status_convert = '', '-2', '-3')));

auth_status_code_convert := avenger.getcode_old.Authstatuscode(avenger.fncleanfunctions.clean_fields(le.AUTH_STATUS_CODE));
self.Auth_Outcome_Code	:=	if(self.auth_step = '0', '-1', if(self.Auth_Step = '1' and auth_status_code_convert <> '', auth_status_code_convert,
if(identity_found and auth_status_code_convert = '', '-2', '-3')));

auth_pass_convert := avenger.getcode_old.AuthPASS(avenger.fncleanfunctions.clean_fields(le.Auth_Pass));
self.Auth_Pass	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and Auth_Pass_convert <> '',Auth_Pass_convert,
if(identity_found and  Auth_Pass_convert = '', '-2', '-3')));

auth_fail_convert := avenger.getcode_old.AuthFail(avenger.fncleanfunctions.clean_fields(le.Auth_Fail));
self.Auth_Fail	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and auth_fail_convert <> '',auth_fail_convert,
if(identity_found and auth_fail_convert = '', '-2', '-3')));

auth_fail_status_convert := avenger.getcode_old.AuthFail(avenger.fncleanfunctions.clean_fields(le.Auth_Fail_Status));
self.Auth_Fail_Status	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and auth_fail_status_convert <> '',auth_fail_status_convert, 
if(identity_found and auth_fail_status_convert = '', '-2', '-3')));

auth_optout_convert := avenger.getcode_old.Authoptout(avenger.fncleanfunctions.clean_fields(le.AUTH_OPT_OUT));
self.Auth_OptOut	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and auth_optout_convert <> '',auth_optout_convert,
if(identity_found and auth_optout_convert = '', '-2', '-3')));

Auth_UnableToGengerate_convert := avenger.getcode_old.Authunabletogen(avenger.fncleanfunctions.clean_fields(le.AUTH_UNABLE_TO_GEN));
self.Auth_UnableToGengerate	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and Auth_UnableToGengerate_convert <> '',Auth_UnableToGengerate_convert,
if(identity_found and Auth_UnableToGengerate_convert = '', '-2', '-3')));

Auth_Error_convert := avenger.getcode_old.Autherror(avenger.fncleanfunctions.clean_fields(le.AUTH_ERROR));
self.Auth_Error	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and Auth_Error_convert <> '',Auth_Error_convert,
if(identity_found and Auth_Error_convert = '', '-2', '-3')));
self.Auth_Quiz_Expired	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and avenger.fncleanfunctions.clean_fields(le.AUTH_QUIZ_EXPIRE) in ['0', '1'],
avenger.fncleanfunctions.clean_fields(le.AUTH_QUIZ_EXPIRE) , if(identity_found and  avenger.fncleanfunctions.clean_fields(le.AUTH_QUIZ_EXPIRE) = '', '-2', '-3')));
self.Auth_LexID_Returned	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and clean_auth_lexID <> '', clean_auth_lexID, '-3'));
self.Auth_WorkflowConfig_ID	:=	if(self.Auth_Step = '0', '-1', if(self.Auth_Step = '1' and avenger.fncleanfunctions.clean_fields(le.PROID_ALIAS)	<> '', 
avenger.fncleanfunctions.clean_fields(le.PROID_ALIAS), if(identity_found and avenger.fncleanfunctions.clean_fields(le.PROID_ALIAS) = '', '-2', '-3')));
self.Question_Subset_Number	:=	if(avenger.fncleanfunctions.clean_fields(le.product_sequence) <> '', avenger.fncleanfunctions.clean_fields(le.product_sequence),
if(identity_found, '-2', '-3')); //need confirm with IDM side???
self.Question_Category_String	:=	if(avenger.fncleanfunctions.clean_fields(le.NAME) <> '', avenger.fncleanfunctions.clean_fields(le.NAME),
if(identity_found, '-2', '-3'));
self.Question_Form  := if(regexfind('_FillInTheBlank', avenger.fncleanfunctions.clean_fields(le.NAME)), '1', 
if(avenger.fncleanfunctions.clean_fields(le.NAME) <> '', '2', if(identity_found, '-2', '-3')));//need confirm how to code
self.Question_Type_Custom	:=	if(avenger.fncleanfunctions.clean_fields(le.IS_CUSTOM) <> '', avenger.fncleanfunctions.clean_fields(le.IS_CUSTOM),
if(identity_found, '-2', '-3'))	;
//self.Question_Type_Diversionary	:=	avenger.fncleanfunctions.clean_fields(le.IS_RESERVED);
self.Question_AnswerReal_NOA := if(avenger.fncleanfunctions.clean_fields(le.IS_RESERVED) <> '', avenger.fncleanfunctions.clean_fields(le.IS_RESERVED),
if(identity_found, '-2', '-3')); //confirmed with JOHN

Item_status_convert := avenger.getcode_old.ITEMSTATUS(avenger.fncleanfunctions.clean_fields(le.ITEM_STATUS));
self.Question_Answer_Grade_OutcomeType	:=	if(Item_status_convert <> '', Item_status_convert, if(identity_found, '-2', '-3'));

quiz_status_convert := avenger.getcode_old.quizoutcome(fncleanfunctions.clean_fields(le.QUIZ_STATUS));
quiz1_status_convert := avenger.getcode_old.quizoutcome(fncleanfunctions.clean_fields(le.QUIZ1_STATUS));
quiz2_status_convert := avenger.getcode_old.quizoutcome(fncleanfunctions.clean_fields(le.QUIZ1_STATUS));

self.Quiz_Outcome	:=	if(quiz_status_convert <> '', quiz_status_convert, if(identity_found, '-2', '-3'));
self.Quiz_Outcome_1	:=	if(quiz1_status_convert <> '', quiz1_status_convert, if(identity_found, '-2', '-3'));
self.Quiz_Outcome_2	:=	if(quiz2_status_convert <> '', quiz2_status_convert, if(identity_found, '-2', '-3'));

quiz_outcome_code_convert := avenger.getcode_old.quizoutcomecode(avenger.fncleanfunctions.clean_fields(le.QUIZ_STATUS_CODE));
self.Quiz_Outcome_Code	:=	if(quiz_outcome_code_convert <> '', quiz_outcome_code_convert, if(identity_found, '-2', '-3'));
self.Cust_Reference_ID	:= if(avenger.fncleanfunctions.clean_fields(le.CLIENT_REFERENCE_ID) <> '', avenger.fncleanfunctions.clean_fields(le.CLIENT_REFERENCE_ID),
if(identity_found, '-2', '-3'));
self.Quiz_Outcome_TimeOut := if(self.Quiz_Outcome_Code = '8', '1', if(identity_found, '-2', '-3'));//need confirm with IDM contacts-difference between time out and opt out
//IS_VERIFICATION including '1' for verification data, otherwise '0'
self.Quiz_Outcome_VerificationOnlyData := if(avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION) in ['0', '1'],
avenger.fncleanfunctions.clean_fields(le.IS_VERIFICATION),if(identity_found, '-2', '-3'));

string inputed_addr_line1 := trim(avenger.fncleanfunctions.clean_fields(le.INPUTED_STREET), left,right);
string inputed_addr_line2 :=  avenger.fncleanfunctions.clean_fields(le.INPUTED_CITY) +  if(avenger.fncleanfunctions.clean_fields(le.INPUTED_CITY) <> '',', ',' ') 
+ avenger.fncleanfunctions.clean_fields(le.INPUTED_STATE)+ ' '+ avenger.fncleanfunctions.clean_fields(le.INPUTED_ZIP)[1..5];

string clean_addr := Address.cleanaddress182(inputed_addr_line1, inputed_addr_line2);

self.clean_addresprimaryrange := clean_addr[1..10];
self.clean_addrespredirectional := clean_addr[11..12];
self.clean_addresprimaryname := clean_addr[13..40];
self.clean_addresaddresssuffix := clean_addr[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
self.clean_addrespostdirectional := clean_addr[45..46];
self.clean_addresunitdesignation := clean_addr[47..56];
self.clean_addressecondaryrange := clean_addr[57..64];
self.clean_addrespostalcity := clean_addr[65..89];
self.clean_addresvanitycity := clean_addr[90..114];
self.clean_addresstate := clean_addr[115..116];
self.clean_addreszip := clean_addr[117..121];
self.clean_addreszip4 := clean_addr[122..125];
/*self.cart := clean_addr[126..129];
self.cr_sort_sz := clean_addr[130];
self.lot := clean_addr[131..134];
self.lot_order := clean_addr[135];*/
self.clean_addresdbpc := clean_addr[136..137];
self.clean_addrescheckdigit := clean_addr[138];
self.clean_addresrecordtype := clean_addr[139..140];
self.clean_addrescounty := clean_addr[141..145];
self.clean_addreslatitude := clean_addr[146..155];
self.clean_addreslongitude := clean_addr[156..166];
self.clean_addresmsa := clean_addr[167..170];
self.clean_addresgeoblock := clean_addr[171..177];
self.clean_addresgeomatchcode := clean_addr[178];
self.clean_addreserrorstatus := clean_addr[179..182];
self := [];

end;

common_IRM_quiz := project(clean_quiz, tmap_irm_quiz(left));

//filter out testing records and dedup

common_irm_quiz_dedup := dedup(sort(distribute(common_IRM_quiz, hash(Tran_Conversation_ID)),
 record, local), record, local):persist('~thor_data400::persist::avenger_idm_quiz_old');

return common_irm_quiz_dedup;
end;