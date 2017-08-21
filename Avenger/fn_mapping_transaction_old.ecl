import ut;
EXPORT fn_mapping_transaction_old(dataset(avenger.layout_in.transaction) pInFile) := function

//mapping verid transaction
avenger.layout_common.old tmap_verid_transaction(pInFile le) := transform
fixDate_TRANSACTIONSTARTTIME := avenger.fncleanfunctions.tDateAdded(le.TRANSACTIONSTARTTIME);
fixTime_TRANSACTIONSTARTTIME := avenger.fncleanfunctions.tTimeAdded(fixDate_TRANSACTIONSTARTTIME);

fixDate_FINALIZATIONDATE := avenger.fncleanfunctions.tDateAdded(le.FINALIZATIONDATE);
fixTime_FINALIZATIONDATE := avenger.fncleanfunctions.tTimeAdded(fixDate_FINALIZATIONDATE);

fixDate_LASTTOUCHEDTIME := avenger.fncleanfunctions.tDateAdded(le.LASTTOUCHEDTIME);
fixTime_LASTTOUCHEDTIME := avenger.fncleanfunctions.tTimeAdded(fixDate_LASTTOUCHEDTIME);

fixDate_DETERMINATORTIME := avenger.fncleanfunctions.tDateAdded(le.DETERMINATORTIME);
fixTime_DETERMINATORTIME := avenger.fncleanfunctions.tTimeAdded(fixDate_DETERMINATORTIME);

fixDate_DISPOSITIONDATE := avenger.fncleanfunctions.tDateAdded(le.DISPOSITIONDATE);
fixTime_DISPOSITIONDATE := avenger.fncleanfunctions.tTimeAdded(fixDate_DISPOSITIONDATE);

TotalTime_tran := (string)((unsigned)fixTime_TRANSACTIONSTARTTIME[10..] - (unsigned)fixTime_TRANSACTIONSTARTTIME[10..]);

valid_ADLID := Avenger.fncleanfunctions.clean_ADL(le.ADLID);

self.Cust_Account  := if(le.accountname <> '', le.accountname, '-1');
self.Cust_Username := if(le.USERNAME <> '', le.USERNAME, '-1');
self.Cust_AgentName	:= if(le.AGENTNAME <> '', le.AGENTNAME, '-1');
self.Cust_Business_Name	 := if(le.COMPANYNAME <> '', le.COMPANYNAME, '-1');
self.Cust_Business_TaxID	:= if(le.FEIN <> '', le.FEIN, '-1');
self.Cust_Workflow_Name	:= if(le.PARAMETERLISTFIELD <> '', le.PARAMETERLISTFIELD, '-1');
self.Cust_Consumer_Type	:= if(trim(le.CONTACTTYPE, left,right) in ['1', '2'], le.CONTACTTYPE, '-2');
self.Cust_Purchase_Amt	:= if(le.AMOUNT <> '', le.AMOUNT, 'VERIFICATION');
self.Cust_IPAddress	 := if(le.REMOTEADDRESS <> '',le.REMOTEADDRESS, '-1');
self.Tran_type       := if(le.sourceenvtypefield <> '1' or le.modetypefield NOT in ['','3'], '', '2');
self.Tran_Date	:= 	if(fixDate_TRANSACTIONSTARTTIME <> '',fixDate_TRANSACTIONSTARTTIME,'-2');
SELF.Tran_TotalTime := if(TotalTime_tran <> '', TotalTime_tran, '-2');
self.Tran_Day := avenger.getcode_old.trandaycode(ut.weekday((unsigned)fixDate_TRANSACTIONSTARTTIME[1..8]));
self.Tran_Conversation_ID	:=	if(le.TRANSACTIONID <> '', trim(le.TRANSACTIONID,left,right), '-2');
self.Tran_ID	:= 	if(le.TRANSACTIONID <> '', trim(le.TRANSACTIONID,left,right), '-2');
self.Tran_Final_Status	:= 	avenger.getcode_old.tranfinalstatus(trim(le.FINALSTATUSTYPEFIELD, left,right));
self.Tran_Finalization_Date	:= 	if(fixDate_FINALIZATIONDATE[1..8] <> '', fixDate_FINALIZATIONDATE[1..8], '-2');
self.Tran_Finalization_Time	:= 	if(fixTime_FINALIZATIONDATE[10..] <> '', fixTime_FINALIZATIONDATE[10..], '-2');
self.Tran_Fail_ReasonCode	:= 	if(le.REASONTYPEFIELD <> '', le.REASONTYPEFIELD, '-2');
self.Tran_Process_Type	:= 	if(le.PROCESSTYPEFIELD <> '', le.PROCESSTYPEFIELD, '-2');
self.Tran_Channel_Type	:= 	avenger.getcode_old.TranChannelType(trim(le.VENUETYPEFIELD,left,right));
self.Tran_Channel_API_ReqType	:= 	avenger.getcode_old.TranChannelAPIType(trim(le.REQUESTENTRYTYPEFIELD,left,right));
self.Tran_Channel_BatchID	:= 	if(self.Tran_Channel_Type = '2' and le.BATCHID <> '', le.BATCHID, if(le.BATCHID <> '', '-1', '-2'));
self.Tran_Source_Type	:= 	if(le.SOURCEENVTYPEFIELD <> '', le.SOURCEENVTYPEFIELD, '-2');
self.Tran_LN_ServerName	:= 	if(le.SERVERNAME	<> '', le.SERVERNAME, '-2');
self.Tran_ConsumerIP	:= 	if(le.IPADDRESS <> '', le.IPADDRESS, '-1');
self.Tran_Unique_IdentityID	:= 	if(le.UNIQUEIDENTITYID <> '', le.UNIQUEIDENTITYID, '-2');
self.Tran_TaskLevel_Orig	:= 	avenger.getcode_old.TranTaskLevelOrig(trim(le.ORIGINALTASKLEVEL, left,right));
self.Tran_TaskLevel_Final	:= 	avenger.getcode_old.TranTaskLevelfinal(trim(le.FINALTASKLEVEL, left,right));
self.Tran_Query_Check	:= 	if(le.QUERYCHECKSUM <> '', le.QUERYCHECKSUM, '-2');
self.Tran_CustomerID_Hashed	:= 	if(le.CUSTOMERIDHASHED <> '', le.CUSTOMERIDHASHED, '-2');
self.Tran_SequenceNumber	:= 	if(le.SEQUENCENUMBER <> '', le.SEQUENCENUMBER, '-2');
self.Tran_Record_Update_Time	:= 	if(fixDate_LASTTOUCHEDTIME <> '',fixDate_LASTTOUCHEDTIME, '-2');
self.Tran_Determinator_Time	:= 	if(fixDate_DETERMINATORTIME <> '',fixDate_DETERMINATORTIME, '-2');
agentrisk_convert := avenger.getcode_old.AGENTRISKASSESMENT(le.AGENTRISKASSESMENTTYPEFIELD);
self.Cust_Agent_Risk_AssesType	:= 	if(agentrisk_convert <> '', agentrisk_convert, if(valid_ADLID <> '', '-2', '-3'));
self.Input_LexID	:= '-1';
self.Input_Name_First	:= 	if(le.NAMEFIRST <> '', le.NAMEFIRST, '-1')	;
self.Input_Name_Last	:= 	if(le.NAMELAST <> '', le.NAMELAST, '-1');
self.Input_Name_Prefix	:= 	if(le.NAMEPREFIX <> '', le.NAMEPREFIX, '-1');
self.Input_Name_Middle	:= 	if(le.NAMEMIDDLE <> '', le.NAMEMIDDLE, '-1');
self.Input_Name_Suffix	:= 	if(le.NAMESUFFIX <> '', le.NAMESUFFIX, '-1');
clean_input_DOB := Avenger.fncleanfunctions.clean_tran_dob(le.BIRTHYEAR,le.BIRTHMONTH,le.BIRTHDAY);
self.Input_DOB	:= 	if(clean_input_DOB <> '',clean_input_DOB, '-1');
self.Input_Phone	:= 	if(Avenger.fncleanfunctions.clean_phone(le.HOMEPHONE) <> '', Avenger.fncleanfunctions.clean_phone(le.HOMEPHONE), '-1');
self.Input_DL_Number	:= 	if(le.DRIVERSLICENSENUMBER	<> '', le.DRIVERSLICENSENUMBER, '-1');
self.Input_DL_State	:= 	if(le.DRIVERSLICENSESTATE	<> '', le.DRIVERSLICENSESTATE, '-1');
temp_input_street := trim(le.STREET1,left,right) + ' ' + if(trim(le.STREET1,left,right) != trim(le.STREET2,left,right) and le.STREET2 <> '', le.STREET2 + ' ', '') + trim(le.SUITE,left,right);
self.Input_Street	:= 	if(temp_input_street <> '', temp_input_street, '-1');
self.Input_City	:= 	if(le.CITY	<> '', le.CITY, '-1');
self.Input_State	:= 	if(le.STATE	<> '', le.STATE, '-1');
self.Input_Zip	:= 	if((trim(le.ZIP)+ trim(le.Zip4)) <> '', trim(le.ZIP)+ trim(le.Zip4), '-1');
self.Input_Country	:= 	if(le.COUNTRY	<> '', le.COUNTRY, '-1');
self.Input_SSN	:= 	if(le.Encryptedssn	<> '', le.Encryptedssn, '-1');
self.Input_SSN_Type_Length	:= 	avenger.getcode_old.InputSSNType(trim(le.SSNTYPEFIELD, left,right));
self.Input_SSN_Encrypted	:= 	if(le.ENCRYPTEDSSN	<> '', le.ENCRYPTEDSSN, '-1');
//self.Discovery_Identity_Located	:= 	if(Avenger.fncleanfunctions.clean_ADL(le.ADLID) <> '', '1', '0')	;
self.Discovery_Identity_Located	:= 	if(le.LOCATESTATUSTYPEFIELD <> '', le.LOCATESTATUSTYPEFIELD, if(valid_ADLID <> '',  '-2', '-3'));
self.Discovery_Identity_BestScore	:= 	if(le.LOCATEBESTSCORE <> '', le.LOCATEBESTSCORE, if(valid_ADLID <> '',  '-2', '-3'));
self.Discovery_Identity_MaxScore	:= 	if(le.LOCATEMAXSCORE <> '', le.LOCATEMAXSCORE, if(valid_ADLID <> '',  '-2', '-3'));
self.Discovery_Identity_PassThreshold	:= 	if(le.LOCATETHRESHOLD <> '', le.LOCATETHRESHOLD, if(valid_ADLID <> '',  '-2', '-3'));
self.Product_IID_Used	:=	if(le.WAS_IID_USED <> '', le.WAS_IID_USED, if(valid_ADLID <> '',  '-2', '-3'));
self.Product_IID_CVI	:=	if(le.WAS_IID_USED = '1' and le.IID_CVI <> '', le.IID_CVI, if(le.IID_CVI <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_NAS	:=	if(le.WAS_IID_USED = '1' and le.IID_NAS <> '', le.IID_NAS, if(le.IID_NAS <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_NAP	:=	if(le.WAS_IID_USED = '1' and le.IID_NAP <> '', le.IID_NAP, if(le.IID_NAP <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicators	:=	if(le.WAS_IID_USED = '1' and le.IID_RISK_INDICATORS <> '', le.IID_RISK_INDICATORS, if(le.IID_RISK_INDICATORS <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicator1 := if(le.WAS_IID_USED = '1' and trim(le.IID_RISK_INDICATORS[1..2], left, right) <> '', trim(le.IID_RISK_INDICATORS[1..2], left, right), if(trim(le.IID_RISK_INDICATORS[1..2], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicator2 := if(le.WAS_IID_USED = '1' and trim(le.IID_RISK_INDICATORS[4..6], left, right) <> '', trim(le.IID_RISK_INDICATORS[4..6], left, right), if(trim(le.IID_RISK_INDICATORS[4..6], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicator3 := if(le.WAS_IID_USED = '1' and trim(le.IID_RISK_INDICATORS[8..10], left, right) <> '', trim(le.IID_RISK_INDICATORS[8..10], left, right), if(trim(le.IID_RISK_INDICATORS[8..10], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicator4 := if(le.WAS_IID_USED = '1' and trim(le.IID_RISK_INDICATORS[12..14], left, right) <> '', trim(le.IID_RISK_INDICATORS[12..14], left, right), if(trim(le.IID_RISK_INDICATORS[12..14], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicator5 := if(le.WAS_IID_USED = '1' and trim(le.IID_RISK_INDICATORS[16..18], left, right) <> '', trim(le.IID_RISK_INDICATORS[16..18], left, right), if(trim(le.IID_RISK_INDICATORS[16..18], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RiskIndicator6 := if(le.WAS_IID_USED = '1' and trim(le.IID_RISK_INDICATORS[20..22], left, right) <> '', trim(le.IID_RISK_INDICATORS[20..22], left, right), if(trim(le.IID_RISK_INDICATORS[20..22], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_Used	:=	if(le.WAS_FP_USED <> '', le.WAS_FP_USED, if(valid_ADLID <> '',  '-2', '-3'));
self.Product_IID_FP_Score	:=	if(le.WAS_FP_USED = '1' and le.IID_FP_SCORE <> '', le.IID_FP_SCORE, if(le.IID_FP_SCORE <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicators	:=	if(le.WAS_FP_USED = '1' and le.IID_FP_RISK_INDICATORS <> '', le.IID_FP_RISK_INDICATORS, if(le.IID_FP_RISK_INDICATORS <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndices	:=	if(le.WAS_FP_USED = '1' and le.IID_FP_RISK_INDICES <> '', le.IID_FP_RISK_INDICES, if(le.IID_FP_RISK_INDICES <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_RedFlag_RiskIndicators	:=	if(le.WAS_IID_USED = '1' and le.IID_RED_FLAG_RISK_INDICATORS <> '', le.IID_RED_FLAG_RISK_INDICATORS, if(le.IID_RED_FLAG_RISK_INDICATORS <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicator1 := if(le.WAS_FP_USED = '1' and trim(le.IID_FP_RISK_INDICATORS[1..2], left, right) <> '', trim(le.IID_FP_RISK_INDICATORS[1..2], left, right), if(trim(le.IID_FP_RISK_INDICATORS[1..2], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicator2 := if(le.WAS_FP_USED = '1' and trim(le.IID_FP_RISK_INDICATORS[4..6], left, right) <> '', trim(le.IID_FP_RISK_INDICATORS[4..6], left, right), if(trim(le.IID_FP_RISK_INDICATORS[4..6], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicator3 := if(le.WAS_FP_USED = '1' and trim(le.IID_FP_RISK_INDICATORS[8..10], left, right) <> '', trim(le.IID_FP_RISK_INDICATORS[8..10], left, right), if(trim(le.IID_FP_RISK_INDICATORS[8..10], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicator4 := if(le.WAS_FP_USED = '1' and trim(le.IID_FP_RISK_INDICATORS[12..14], left, right) <> '', trim(le.IID_FP_RISK_INDICATORS[12..14], left, right), if(trim(le.IID_FP_RISK_INDICATORS[12..14], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicator5 := if(le.WAS_FP_USED = '1' and trim(le.IID_FP_RISK_INDICATORS[16..18], left, right) <> '', trim(le.IID_FP_RISK_INDICATORS[16..18], left, right), if(trim(le.IID_FP_RISK_INDICATORS[16..18], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RiskIndicator6 := if(le.WAS_FP_USED = '1' and trim(le.IID_FP_RISK_INDICATORS[20..22], left, right) <> '', trim(le.IID_FP_RISK_INDICATORS[20..22], left, right), if(trim(le.IID_FP_RISK_INDICATORS[20..22], left, right) <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));

FP_RI_Stolen      := avenger.fncleanfunctions.get_Stolen(le.IID_FP_RISK_INDICES);
FP_RI_Synthetic   := avenger.fncleanfunctions.get_Synthetic(le.IID_FP_RISK_INDICES);
FP_RI_Manipulated := avenger.fncleanfunctions.get_Manipulated(le.IID_FP_RISK_INDICES);
FP_RI_Friendly    := avenger.fncleanfunctions.get_Friendly(le.IID_FP_RISK_INDICES);
FP_RI_Vulnerable  := avenger.fncleanfunctions.get_Vulnerable(le.IID_FP_RISK_INDICES);
FP_RI_Suspicous   := avenger.fncleanfunctions.get_Suspicous(le.IID_FP_RISK_INDICES);

self.Product_IID_FP_RI_Stolen      := if(le.WAS_FP_USED = '1' and FP_RI_Stolen <> '', FP_RI_Stolen, if(FP_RI_Stolen <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RI_Synthetic   := if(le.WAS_FP_USED = '1' and FP_RI_Synthetic <> '', FP_RI_Synthetic, if(FP_RI_Synthetic <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RI_Manipulated := if(le.WAS_FP_USED = '1' and FP_RI_Manipulated <> '', FP_RI_Manipulated, if(FP_RI_Manipulated <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RI_Friendly    :=  if(le.WAS_FP_USED = '1' and FP_RI_Friendly <> '', FP_RI_Friendly, if(FP_RI_Friendly <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RI_Vulnerable  := if(le.WAS_FP_USED = '1' and FP_RI_Vulnerable <> '', FP_RI_Vulnerable, if(FP_RI_Vulnerable <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));
self.Product_IID_FP_RI_Suspicous   := if(le.WAS_FP_USED = '1' and FP_RI_Suspicous <> '', FP_RI_Suspicous, if(FP_RI_Suspicous <> '', '-1', 
if(valid_ADLID <> '',  '-2', '-3')));

self.Product_FlexID_Used	:=	if(le.WAS_FLEXID_USED <> '', le.WAS_FLEXID_USED, if(valid_ADLID <> '',  '-2', '-3'));
self.Product_OFAC_StatusType	:=	if(le.OFACSTATUSTYPEFIELD	<> '', avenger.getcode_old.TRANOFACSTATUSTYPE(le.OFACSTATUSTYPEFIELD),if(valid_ADLID <> '',  '-2', '-3'));
self.Cust_Fraud_Type_Prov	:=	if(le.FRAUDTYPEFIELD	<> '', le.FRAUDTYPEFIELD, if(valid_ADLID <> '',  '-2', '-3'));

CustFraudStatus_return := avenger.getcode_old.CustFraudStatus(le.DISPOSITIONSTATUSTYPEFIELD, le.FRAUDTYPEFIELD);
self.Cust_Fraud_Status	:=	if(CustFraudStatus_return <> '', CustFraudStatus_return, if(valid_ADLID <> '',  '-2', '-3'));
self.Cust_Fraud_Status_LastUpdated	:=	if(self.Cust_Fraud_Status = '1' and fixDate_DISPOSITIONDATE <> '',
fixDate_DISPOSITIONDATE, if(fixDate_DISPOSITIONDATE <> '', '-1', if(valid_ADLID <> '', '-2', '-3')));
self.Cust_Reference_ID	:=	if(self.Cust_Fraud_Status = '1' and le.REFERENCEID <> '',
le.REFERENCEID, if(self.Cust_Fraud_Status = '0', '-1', if(valid_ADLID <> '' and le.REFERENCEID = '', '-2', '-3')));
self.auth_step := '1'; 
self.Auth_LexID_Returned := if(valid_ADLID <> '', valid_ADLID, '-3');
self.Auth_Unique_ID := if(le.UNIQUEAUTHENTICATIONID <> '', le.UNIQUEAUTHENTICATIONID, if(valid_ADLID <> '', '-2', '-3'));
self.Selected_LexID := if(valid_ADLID <> '', valid_ADLID, '-3');
self := [];
end;


common_verid_transaction := project(pInFile, tmap_verid_transaction(left));

//filter out invalid tran_id and tran_date and do dedup 

common_verid_transaction_dedup := dedup(sort(distribute(common_verid_transaction(tran_id <> ''), hash(tran_id)), record, local), record, local);

return common_verid_transaction_dedup;

end;
