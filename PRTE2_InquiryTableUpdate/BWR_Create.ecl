import  STD,PRTE2, _control, PRTE, dops, orbit3;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'InquiryTableUpdateKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

industry_use_vertical_login_Build := DATASET([ ],PRTE2_InquiryTableUpdate.industry_use_vertical_login);
industry_use_vertical_Build :=       DATASET([ ],PRTE2_InquiryTableUpdate.industry_use_vertical);
lookup_company_optout_Build :=       DATASET([ ],PRTE2_InquiryTableUpdate.lookup_company_optout);
lookup_function_desc_Build :=        DATASET([ ],PRTE2_InquiryTableUpdate.lookup_function_desc);
address_update_Build :=              DATASET([ ],PRTE2_InquiryTableUpdate.address_update);
did_update_Build :=                  DATASET([ ],PRTE2_InquiryTableUpdate.did_update);
email_update_Build :=                DATASET([ ],PRTE2_InquiryTableUpdate.email_update);
fein_update_Build :=                 DATASET([ ],PRTE2_InquiryTableUpdate.fein_update);
ipaddr_update_Build :=               DATASET([ ],PRTE2_InquiryTableUpdate.ipaddr_update);
linkids_update_Build :=              DATASET([ ],PRTE2_InquiryTableUpdate.linkids_update);
name_update_Build :=                 DATASET([ ],PRTE2_InquiryTableUpdate.name_update);
phone_update_Build :=                DATASET([ ],PRTE2_InquiryTableUpdate.phone_update);
ssn_update_Build :=                  DATASET([ ],PRTE2_InquiryTableUpdate.ssn_update);
transaction_id_update_Build :=       DATASET([ ],PRTE2_InquiryTableUpdate.transaction_id_update);
did_Build :=                         DATASET([ ],PRTE2_InquiryTableUpdate.did_layout);

industry_use_vertical_login_Key := INDEX(industry_use_vertical_login_Build,
{s_company_id,s_product_id,s_gc_id},{industry_use_vertical_login_Build},
'~prte::key::inquiry_table::' + pversion + '::industry_use_vertical_login'); 

industry_use_vertical_Key := INDEX(industry_use_vertical_Build,
{s_company_id, s_product_id,s_gc_id},{industry_use_vertical_Build},
'~prte::key::inquiry_table::' + pversion + '::industry_use_vertical'); 

lookup_company_optout_Key := INDEX(lookup_company_optout_Build,
{company_id},{lookup_company_optout_Build},
'~prte::key::inquiry_table::' + pversion + '::lookup_company_optout'); 

lookup_function_desc_Key := INDEX(lookup_function_desc_Build,
{s_product_id, s_transaction_type,s_function_name},{lookup_function_desc_Build},
'~prte::key::inquiry_table::' + pversion + '::lookup_function_desc'); 

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

ipaddr_update_Key := INDEX(ipaddr_update_Build,
{ipaddr},{ipaddr_update_Build},
'~prte::key::inquiry::' + pversion + '::ipaddr_update'); 

linkids_update_Key := INDEX(linkids_update_Build,
{ ultid, orgid, seleid, proxid, powid, empid, dotid},{linkids_update_Build},
'~prte::key::inquiry::' + pversion + '::linkids_update'); 

name_update_Key := INDEX(name_update_Build,
{ fname, mname,lname},{name_update_Build},
'~prte::key::inquiry::' + pversion + '::name_update'); 

phone_update_Key := INDEX(phone_update_Build,
{phone10},{phone_update_Build},
'~prte::key::inquiry::' + pversion + '::phone_update'); 

ssn_update_Key := INDEX(ssn_update_Build,
{ssn},{ssn_update_Build},
'~prte::key::inquiry::' + pversion + '::ssn_update'); 

transaction_id_update_Key := INDEX(transaction_id_update_Build,
{transaction_id},{transaction_id_update_Build},
'~prte::key::inquiry::' + pversion + '::transaction_id_update');

did_Key := INDEX(did_Build,
{did},{did_Build},
'~prte::key::inquiry_table::' + pversion + '::did');  

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

  key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dops_name, 'N'), named(dops_name+'Validation'));

  updateorbit                        := Orbit3.proc_Orbit3_CreateBuild('PRTE - InquirytableUpdateKeys ', pversion, 'PN', true, true, false, _control.MyInfo.EmailAddressNormal);  

  BUILD(industry_use_vertical_login_Key);
  BUILD(industry_use_vertical_Key);
  BUILD(lookup_company_optout_Key);
  BUILD(lookup_function_desc_Key);
  BUILD(address_update_Key);
	BUILD(did_update_Key);
	BUILD(email_update_Key);
	BUILD(fein_update_Key);
	BUILD(ipaddr_update_Key);
	BUILD(linkids_update_Key);
	BUILD(name_update_Key);
	BUILD(phone_update_Key);
	BUILD(ssn_update_Key);
	BUILD(transaction_id_update_Key);
	BUILD(did_Key);
	
	key_validation;
	PerformUpdateOrNot;
	updateorbit;
	
output ('successful');