/*
input: reference number

output:
  search record
  bdid result
  bip result
  any bip header records we can find by bdid
  prod biz header key by bdid
  any bip header records we can find by prox
later - put search record thru online macro
*/

myrid := 10412;
// myrid := 8209;
// myrid := 19733;

import BIPV2_Testing,BizLink3,Business_Header_SS, BIPV2_Files;
srid := (string)myrid;
#workunit('name',srid);

searchinput := dataset('~thor_data400::bipv2::xlink::allv2', BIPV2_Testing.layouts.xlink, thor);
mysearchinput := searchinput(rid = myrid);
output(mysearchinput, named('mysearchinput'));

bdidres := dataset('~thor_data400::cemtemp::outfile_v1',BIPV2_Testing.layouts.xlink, thor);
mybdidres := bdidres(rid = myrid);
output(mybdidres, named('bdidResult'));

bipres := dataset('~thor_data400::cemtemp::outfile_v2',BIPV2_Testing.layouts.xlink, thor);
mybipres := bipres(rid = myrid);

output(mybipres, named('bipResult'));

bipheader := BIPV2_Files.files_proxid().DS_PROXID_BASE;
output(bipheader(company_bdid in set(mybdidres, bdid)), all, named('bipHeaderByBdid'));
output(bipheader(proxid in set(mybipres, proxid)), all, named('bipHeaderByProx'));
// output(bipheader(proxid in set(mybipres(weight = max(mybipres, weight)), proxid)), all, named('bipHeaderByTopWeightProx'));

output(Business_Header_SS.Key_BH_BDID_pl(bdid in set(mybdidres, bdid)), all, named('prodHeaderByBdid'));


Matchset := ['A','F','P'];
Business_Header_SS.MAC_Match_Flex
(
	 mysearchinput
	,matchset
	,company_name
	,company_prim_range
	,company_prim_name
	,company_zip
	,company_sec_range
	,company_state
	,company_phone
	,company_fein
	,bdid
	,BIPV2_Testing.layouts.xlink
	,FALSE
	,BDID_score_field
	,outfile_v2_0
	,10												//keep_count							= '1'
	,0												//score_threshold				= '75'
	,												//pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,												//pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	// ,[BIPV2.IDconstants.xlink_version_BIP_dev]
	,[BIPV2.IDconstants.xlink_version_BIP]
	,												//pURL										=	''
	,email_address									
	,company_city												//pCity									= ''	
	,fname	
	,												//pContact_mname					= ''
	,lname			
)
output(outfile_v2_0, named('outfile_v2_0'));
