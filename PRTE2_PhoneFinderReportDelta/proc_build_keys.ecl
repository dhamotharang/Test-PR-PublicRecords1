
import dx_PhoneFinderReportDelta,_control, PRTE2_Common, PRTE, prte2, dops;


EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	doDOPS 	:= is_running_in_prod AND NOT skipDOPS;


//identities_lexid
identities_lexid := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Index);
identities_lexidKey := INDEX(identities_lexid,
{  
 lexid;
 transaction_id;
},{identities_lexid},
  '~prte::key::' + filedate + '::phonefinderreportdelta::identities_lexid');


//identities
identities := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Index);
identitiesKey := INDEX(identities,
{  
 transaction_id;
},{identities},
  '~prte::key::' + filedate + '::phonefinderreportdelta::identities');	


//otherphones
 otherphones := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Index);
 otherphoneskey := INDEX(otherphones,
 {transaction_id;
  phonenumber;
 },{otherphones},
  '~prte::key::' + filedate + '::phonefinderreportdelta::otherphones');		


//riskindicators
riskindicators := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Index);
riskindicatorskey := INDEX(RiskIndicators,
{ transaction_id;
  },{riskindicators},
  '~prte::key::' + filedate + '::phonefinderreportdelta::riskindicators');		

	
//sources	
sources := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Sources_Index);
sourceskey := INDEX(sources,
{ transaction_id;
  },{sources},
  '~prte::key::' + filedate + '::phonefinderreportdelta::sources');		
	
	
//Transactions_CompanyId	
Transactions_CompanyId := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_CompanyId);
Transactions_CompanyIdkey := INDEX(Transactions_CompanyId,
{company_id;
 transaction_date;
  },{Transactions_CompanyId},
  '~prte::key::' + filedate + '::phonefinderreportdelta::Transactions_CompanyId');		
		

//transactions_companyrefcode	
transactions_companyrefcode := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_CompanyRefCode);
transactions_companyrefcodekey := INDEX(transactions_companyrefcode,
{company_id;
 reference_code;
 transaction_date
 },{transactions_companyrefcode},
  '~prte::key::' + filedate + '::phonefinderreportdelta::transactions_companyrefcode');	
	
	
	//transactions_date
transactions_date := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_date);
transactions_datekey := INDEX(transactions_date,
{transaction_date
 },{transactions_date},
  '~prte::key::' + filedate + '::phonefinderreportdelta::transactions_date');	

	//transactions_phone
transactions_phone := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Index);
transactions_phonekey := INDEX(transactions_phone,
{phonenumber;
 transaction_date
 },{transactions_phone},
  '~prte::key::' + filedate + '::phonefinderreportdelta::transactions_phone');	
	
//transactions
transactions := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Index);
transactionskey := INDEX(transactions,
{transaction_id;
 },{transactions},
  '~prte::key::' + filedate + '::phonefinderreportdelta::transactions');	
	
	//transactions_refcode
	transactions_refcode := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_RefCode);
transactions_refcodekey := INDEX(transactions_refcode,
{reference_code;
 transaction_date;
 },{transactions_refcode},
  '~prte::key::' + filedate + '::phonefinderreportdelta::Transactions_refcode');	
	
//transactions_userid

transactions_userid := dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_userid);
transactions_useridkey := INDEX(transactions_userid,
{user_id;
 transaction_date;
 },{transactions_userid},
  '~prte::key::' + filedate + '::phonefinderreportdelta::Transactions_userid');	

//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean :='N');
		
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops),NoUpdate);
	
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

 Return sequential
 (parallel
 (
 BUILDindex(identities_lexidKey),
 BUILDindex(identitiesKey),
 BUILDindex(otherphonesKey),
 BUILDindex(riskindicatorsKey),
 BUILDindex(sourcesKey),
 BUILDindex(Transactions_CompanyIdkey),
 BUILDindex(Transactions_CompanyRefCodekey),
 BUILDindex(Transactions_datekey),
 BUILDindex(Transactions_phonekey),
 BUILDindex(Transactionskey),
 BUILDindex(Transactions_refcodekey),
 BUILDindex(Transactions_useridkey)
 ),
 PerformUpdateOrNot,
 key_validation);

 End;
	
	
	
		