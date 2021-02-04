import  STD,PRTE2, _control, PRTE, dops, orbit3;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'FCRA_InquiryHistoryKeys';

pversion:=(string8)STD.Date.CurrentDate(True);


encrypted_Build :=              DATASET([ ],PRTE2_Inquiry_History.encrypted);
group_rid_Build :=               DATASET([ ],PRTE2_Inquiry_History.group_rid);
lexid_Build :=                  DATASET([ ],PRTE2_Inquiry_History.lexid);

encrypted_Key := INDEX(encrypted_Build,
{group_rid},{encrypted_Build},
'~prte::key::inquiryhistory::fcra::' + pversion + '::group_rid::encrypted'); 

group_rid_Key := INDEX(group_rid_Build,
{group_rid},{group_rid_Build},
'~prte::key::inquiryhistory::fcra::' + pversion + '::group_rid'); 

lexid_Key := INDEX(lexid_Build,
{appended_did},{lexid_Build},
'~prte::key::inquiryhistory::fcra::' + pversion + '::lexid'); 


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

  key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dops_name, 'N'), named(dops_name+'Validation'));

  BUILD(encrypted_Key);
	BUILD(group_rid_Key);
	BUILD(lexid_Key);
		
	key_validation;
	PerformUpdateOrNot;
	build_orbit (pversion);
	
output ('successful');