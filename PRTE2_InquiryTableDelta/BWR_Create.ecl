import  STD,PRTE2, _control, PRTE, dops, orbit3;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'InquiryTableDeltaKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

address_update_Build :=              DATASET([ ],PRTE2_InquiryTableDelta.address_update);
did_update_Build :=                  DATASET([ ],PRTE2_InquiryTableDelta.did_update);
email_update_Build :=                DATASET([ ],PRTE2_InquiryTableDelta.email_update);
fein_update_Build :=                 DATASET([ ],PRTE2_InquiryTableDelta.fein_update);
phone_update_Build :=                DATASET([ ],PRTE2_InquiryTableDelta.phone_update);
ssn_update_Build :=                  DATASET([ ],PRTE2_InquiryTableDelta.ssn_update);
transaction_id_update_Build :=       DATASET([ ],PRTE2_InquiryTableDelta.transaction_id_update);


address_update_Key := INDEX(address_update_Build,
{zip, prim_name, prim_range,sec_range},{address_update_Build},
'~prte::key::inquiry::' + pversion + '::address_update'); 

did_update_Key := INDEX(did_update_Build,
{s_did},{did_update_Build},
'~prte::key::inquiry::' + pversion + '::did_update'); 

email_update_Key := INDEX(email_update_Build,
{email_address},{email_update_Build},
'~prte::key::inquiry::' + pversion + '::email_update'); 

fein_update_Key := INDEX(fein_update_Build,
{appended_ein},{fein_update_Build},
'~prte::key::inquiry::' + pversion + '::fein_update'); 

phone_update_Key := INDEX(phone_update_Build,
{phone10},{phone_update_Build},
'~prte::key::inquiry::' + pversion + '::phone_update'); 

ssn_update_Key := INDEX(ssn_update_Build,
{ssn},{ssn_update_Build},
'~prte::key::inquiry::' + pversion + '::ssn_update'); 

transaction_id_update_Key := INDEX(transaction_id_update_Build,
{transaction_id},{transaction_id_update_Build},
'~prte::key::inquiry::' + pversion + '::transaction_id_update');

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

  key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dops_name, 'N'), named(dops_name+'Validation'));

  BUILD(address_update_Key);
	BUILD(did_update_Key);
	BUILD(email_update_Key);
	BUILD(fein_update_Key);
	BUILD(phone_update_Key);
	BUILD(ssn_update_Key);
	BUILD(transaction_id_update_Key);
	
	key_validation;
	PerformUpdateOrNot;
	build_orbit (pversion);
	
output ('successful');