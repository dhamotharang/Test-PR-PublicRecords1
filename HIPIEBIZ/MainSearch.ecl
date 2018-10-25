/*--SOAP--
<message name="BIZSearch">
	<!-- Search Criteria -->
  <part name="BusinessName"			        type="xsd:string"/>
	<part name="BusinessAddress"	        type="xsd:string"/>
	<part name="BusinessCity"			        type="xsd:string"/>
	<part name="BusinessState"	  	      type="xsd:string"/>
	<part name="BusinessZip"			        type="xsd:string"/>
	<part name="FEIN"							        type="xsd:string"/>
	<part name="CustomerAccount"          type="xsd:string"/>
  <part name="OfficerName"		          type="xsd:string"/>
	<part name="OfficerAddress"	          type="xsd:string"/>
	<part name="OfficerCity"		          type="xsd:string"/>
	<part name="OfficerState"		          type="xsd:string"/>
	<part name="OfficerZip"			          type="xsd:string"/>
	<part name="SSN"                      type="xsd:string"/>
	<part name="ShowNewBusinesses"        type="xsd:integer"/>
	<part name="JOBID"			              type="xsd:string"/>
	<part name="InternalRoxieServiceUrl"  type="xsd:string"/>
</message>
*/
/*--INFO-- */

EXPORT MainSearch := MACRO
	IMPORT HIPIEBIZ;
  #OPTION('soapTraceLevel', '8');

  STRING JOBID                    := '00000001' : STORED('JOBID');

	STRING InternalRoxieServiceUrl  := 'http://rampsroxieinternal.risk.regn.net:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Prod/DR DNS!
	// STRING InternalRoxieServiceUrl  := 'http://10.176.71.40:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //PROD IP
	// STRING InternalRoxieServiceUrl  := 'http://10.191.25.4:9876/roxie/' : STORED('InternalRoxieServiceUrl'); // DR IP
  // STRING InternalRoxieServiceUrl  := 'http://10.173.22.132:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Cert
  // STRING InternalRoxieServiceUrl  := 'http://10.173.22.201:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Dev
  STRING ServiceName              := 'hipiebiz.search_' + JOBID;
  STRING XPathName                := ServiceName+'Response';
  
  BIZSearchInput:= RECORD
    STRING customeraccount{XPATH('customeraccount')}:='';
    STRING businessname{XPATH('businessname')}:='';
    STRING businessaddress{XPATH('businessaddress')}:='';
    STRING businesscity{XPATH('businesscity')}:='';
    STRING businessstate{XPATH('businessstate')}:='';
    STRING businesszip{XPATH('businesszip')}:='';
    STRING fein{XPATH('fein')}:='';
    STRING officername{XPATH('officername')}:='';
    STRING officeraddress{XPATH('officeraddress')}:='';
    STRING officercity{XPATH('officercity')}:='';
    STRING officerstate{XPATH('officerstate')}:='';
    STRING officerzip{XPATH('officerzip')}:='';
    STRING ssn{XPATH('ssn')}:='';
    INTEGER shownewbusinesses{XPATH('shownewbusinesses')}:=0;
  END;
  
  BIZSearchOutput := RECORD
    INTEGER seq{XPATH('seq')};
    STRING businessname{XPATH('businessname')};
    STRING businessaddress{XPATH('businessaddress')};
    STRING businesscity{XPATH('businesscity')};
    STRING businessstate{XPATH('businessstate')};
    STRING businesszip{XPATH('businesszip')};
    STRING fein{XPATH('fein')};
    STRING officername{XPATH('officername')};
    STRING officeraddress{XPATH('officeraddress')};
    STRING officercity{XPATH('officercity')};
    STRING officerstate{XPATH('officerstate')};
    STRING officerzip{XPATH('officerzip')};
    STRING ssn{XPATH('ssn')};
    STRING customeraccount{XPATH('customeraccount')};
    STRING customer_account{XPATH('customer_account')};
    STRING suffix{XPATH('suffix')};
    STRING legal_name{XPATH('legal_name')};
    STRING dba_name{XPATH('dba_name')};
    STRING bus_contact_name{XPATH('bus_contact_name')};
    STRING bus_addr{XPATH('bus_addr')};
    STRING bus_secondary_addr{XPATH('bus_secondary_addr')};
    STRING bus_city{XPATH('bus_city')};
    STRING bus_state{XPATH('bus_state')};
    STRING bus_zip{XPATH('bus_zip')};
    STRING busi_mailing_addr{XPATH('busi_mailing_addr')};
    STRING bus_secondary_mailing_addr{XPATH('bus_secondary_mailing_addr')};
    STRING bus_mailing_city{XPATH('bus_mailing_city')};
    STRING bus_mailing_state{XPATH('bus_mailing_state')};
    STRING bus_mailing_zip{XPATH('bus_mailing_zip')};
    STRING ro_name_1{XPATH('ro_name_1')};
    STRING ro_ssn_1{XPATH('ro_ssn_1')};
    STRING ro_name_2{XPATH('ro_name_2')};
    STRING ro_ssn_2{XPATH('ro_ssn_2')};
    STRING ro_name_3{XPATH('ro_name_3')};
    STRING ro_ssn_3{XPATH('ro_ssn_3')};
    STRING bus_ph_nbr{XPATH('bus_ph_nbr')};
    STRING contact_ph_nbr{XPATH('contact_ph_nbr')};
    STRING regd_agent_name{XPATH('regd_agent_name')};
    STRING regd_agent_address{XPATH('regd_agent_address')};
    STRING regd_agent_secondary_mail_addr{XPATH('regd_agent_secondary_mail_addr')};
    STRING regd_agent_mail_city{XPATH('regd_agent_mail_city')};
    STRING regd_agent_mail_state{XPATH('regd_agent_mail_state')};
    STRING regd_agent_mail_zip{XPATH('regd_agent_mail_zip')};
    STRING regd_agent_phone{XPATH('regd_agent_phone')};
    STRING naics_cd{XPATH('naics_cd')};
    STRING sic{XPATH('sic')};
    STRING bus_type{XPATH('bus_type')};
    STRING bus_status{XPATH('bus_status')};
    STRING tax_type_code{XPATH('tax_type_code')};
    STRING tax_type_desc{XPATH('tax_type_desc')};
    STRING tax_type_code_2{XPATH('tax_type_code_2')};
    STRING tax_type_desc_2{XPATH('tax_type_desc_2')};
    STRING tax_type_code_3{XPATH('tax_type_code_3')};
    STRING tax_type_desc_3{XPATH('tax_type_desc_3')};
    STRING tax_type_code_4{XPATH('tax_type_code_4')};
    STRING tax_type_desc_4{XPATH('tax_type_desc_4')};
    STRING tax_type_code_5{XPATH('tax_type_code_5')};
    STRING tax_type_desc_5{XPATH('tax_type_desc_5')};
    STRING tax_type_code_6{XPATH('tax_type_code_6')};
    STRING tax_type_desc_6{XPATH('tax_type_desc_6')};
    STRING tax_type_code_7{XPATH('tax_type_code_7')};
    STRING tax_type_desc_7{XPATH('tax_type_desc_7')};
    STRING fein_ssn_desc{XPATH('fein_ssn_desc')};
    STRING tax_permit_num{XPATH('tax_permit_num')};
    STRING tax_permit_status{XPATH('tax_permit_status')};
    STRING tax_permit_start_date{XPATH('tax_permit_start_date')};
    STRING tax_permit_dt_last_seen{XPATH('tax_permit_dt_last_seen')};
    STRING tax_permit_exp_dt{XPATH('tax_permit_exp_dt')};
    STRING agi{XPATH('agi')};
    STRING ui_claims{XPATH('ui_claims')};
    STRING date_of_last_ui_claim{XPATH('date_of_last_ui_claim')};
    STRING total_employees{XPATH('total_employees')};
    STRING total_amt_wth{XPATH('total_amt_wth')};
    STRING lexid_ro_1{XPATH('lexid_ro_1')};
    STRING lexid_score_ro_1{XPATH('lexid_score_ro_1')};
    STRING verify_best_ssn_score_ro_1{XPATH('verify_best_ssn_score_ro_1')};
    STRING verify_best_name_score_ro_1{XPATH('verify_best_name_score_ro_1')};
    STRING best_ssn_ro_1{XPATH('best_ssn_ro_1')};
    STRING best_dob_ro_1{XPATH('best_dob_ro_1')};
    STRING best_dod_ro_1{XPATH('best_dod_ro_1')};
    STRING best_fname_ro_1{XPATH('best_fname_ro_1')};
    STRING best_mname_ro_1{XPATH('best_mname_ro_1')};
    STRING best_lname_ro_1{XPATH('best_lname_ro_1')};
    STRING best_name_suffix_ro_1{XPATH('best_name_suffix_ro_1')};
    STRING best_address_ro_1{XPATH('best_address_ro_1')};
    STRING best_city_ro_1{XPATH('best_city_ro_1')};
    STRING best_state_ro_1{XPATH('best_state_ro_1')};
    STRING best_zip_ro_1{XPATH('best_zip_ro_1')};
    STRING best_zip4_ro_1{XPATH('best_zip4_ro_1')};
    STRING best_addr_date_ro_1{XPATH('best_addr_date_ro_1')};
    STRING lexid_ro_2{XPATH('lexid_ro_2')};
    STRING lexid_score_ro_2{XPATH('lexid_score_ro_2')};
    STRING verify_best_ssn_score_ro_2{XPATH('verify_best_ssn_score_ro_2')};
    STRING verify_best_name_score_ro_2{XPATH('verify_best_name_score_ro_2')};
    STRING best_ssn_ro_2{XPATH('best_ssn_ro_2')};
    STRING best_dob_ro_2{XPATH('best_dob_ro_2')};
    STRING best_dod_ro_2{XPATH('best_dod_ro_2')};
    STRING best_fname_ro_2{XPATH('best_fname_ro_2')};
    STRING best_mname_ro_2{XPATH('best_mname_ro_2')};
    STRING best_lname_ro_2{XPATH('best_lname_ro_2')};
    STRING best_name_suffix_ro_2{XPATH('best_name_suffix_ro_2')};
    STRING best_address_ro_2{XPATH('best_address_ro_2')};
    STRING best_city_ro_2{XPATH('best_city_ro_2')};
    STRING best_state_ro_2{XPATH('best_state_ro_2')};
    STRING best_zip_ro_2{XPATH('best_zip_ro_2')};
    STRING best_zip4_ro_2{XPATH('best_zip4_ro_2')};
    STRING best_addr_date_ro_2{XPATH('best_addr_date_ro_2')};
    STRING lexid_ro_3{XPATH('lexid_ro_3')};
    STRING lexid_score_ro_3{XPATH('lexid_score_ro_3')};
    STRING verify_best_ssn_score_ro_3{XPATH('verify_best_ssn_score_ro_3')};
    STRING verify_best_name_score_ro_3{XPATH('verify_best_name_score_ro_3')};
    STRING best_ssn_ro_3{XPATH('best_ssn_ro_3')};
    STRING best_dob_ro_3{XPATH('best_dob_ro_3')};
    STRING best_dod_ro_3{XPATH('best_dod_ro_3')};
    STRING best_fname_ro_3{XPATH('best_fname_ro_3')};
    STRING best_mname_ro_3{XPATH('best_mname_ro_3')};
    STRING best_lname_ro_3{XPATH('best_lname_ro_3')};
    STRING best_name_suffix_ro_3{XPATH('best_name_suffix_ro_3')};
    STRING best_address_ro_3{XPATH('best_address_ro_3')};
    STRING best_city_ro_3{XPATH('best_city_ro_3')};
    STRING best_state_ro_3{XPATH('best_state_ro_3')};
    STRING best_zip_ro_3{XPATH('best_zip_ro_3')};
    STRING best_zip4_ro_3{XPATH('best_zip4_ro_3')};
    STRING best_addr_date_ro_3{XPATH('best_addr_date_ro_3')};
    STRING physicaladdressprimaryrange{XPATH('physicaladdressprimaryrange')};
    STRING physicaladdresspredirectional{XPATH('physicaladdresspredirectional')};
    STRING physicaladdressprimaryname{XPATH('physicaladdressprimaryname')};
    STRING physicaladdressaddresssuffix{XPATH('physicaladdressaddresssuffix')};
    STRING physicaladdresspostdirectional{XPATH('physicaladdresspostdirectional')};
    STRING physicaladdressunitdesignation{XPATH('physicaladdressunitdesignation')};
    STRING physicaladdresssecondaryrange{XPATH('physicaladdresssecondaryrange')};
    STRING physicaladdresspostalcity{XPATH('physicaladdresspostalcity')};
    STRING physicaladdressvanitycity{XPATH('physicaladdressvanitycity')};
    STRING physicaladdressstate{XPATH('physicaladdressstate')};
    STRING physicaladdresszip{XPATH('physicaladdresszip')};
    STRING physicaladdresszip4{XPATH('physicaladdresszip4')};
    STRING physicaladdressdbpc{XPATH('physicaladdressdbpc')};
    STRING physicaladdresscheckdigit{XPATH('physicaladdresscheckdigit')};
    STRING physicaladdressrecordtype{XPATH('physicaladdressrecordtype')};
    STRING physicaladdresscounty{XPATH('physicaladdresscounty')};
    STRING physicaladdresslatitude{XPATH('physicaladdresslatitude')};
    STRING physicaladdresslongitude{XPATH('physicaladdresslongitude')};
    STRING physicaladdressmsa{XPATH('physicaladdressmsa')};
    STRING physicaladdressgeoblock{XPATH('physicaladdressgeoblock')};
    STRING physicaladdressgeomatchcode{XPATH('physicaladdressgeomatchcode')};
    STRING physicaladdresserrorstatus{XPATH('physicaladdresserrorstatus')};
    INTEGER physicaladdresscachehit{XPATH('physicaladdresscachehit')};
    INTEGER physicaladdresscleanerhit{XPATH('physicaladdresscleanerhit')};
    STRING physicaladdresscleanedaddress{XPATH('physicaladdresscleanedaddress')};
    STRING physicaladdressinputaddress{XPATH('physicaladdressinputaddress')};
    INTEGER physicaladdressnoaddressinput{XPATH('physicaladdressnoaddressinput')};
    INTEGER physicaladdressnoaddresscleanererror{XPATH('physicaladdressnoaddresscleanererror')};
    STRING physicaladdresserrorcodedescription{XPATH('physicaladdresserrorcodedescription')};
    STRING mailingaddressprimaryrange{XPATH('mailingaddressprimaryrange')};
    STRING mailingaddresspredirectional{XPATH('mailingaddresspredirectional')};
    STRING mailingaddressprimaryname{XPATH('mailingaddressprimaryname')};
    STRING mailingaddressaddresssuffix{XPATH('mailingaddressaddresssuffix')};
    STRING mailingaddresspostdirectional{XPATH('mailingaddresspostdirectional')};
    STRING mailingaddressunitdesignation{XPATH('mailingaddressunitdesignation')};
    STRING mailingaddresssecondaryrange{XPATH('mailingaddresssecondaryrange')};
    STRING mailingaddresspostalcity{XPATH('mailingaddresspostalcity')};
    STRING mailingaddressvanitycity{XPATH('mailingaddressvanitycity')};
    STRING mailingaddressstate{XPATH('mailingaddressstate')};
    STRING mailingaddresszip{XPATH('mailingaddresszip')};
    STRING mailingaddresszip4{XPATH('mailingaddresszip4')};
    STRING mailingaddressdbpc{XPATH('mailingaddressdbpc')};
    STRING mailingaddresscheckdigit{XPATH('mailingaddresscheckdigit')};
    STRING mailingaddressrecordtype{XPATH('mailingaddressrecordtype')};
    STRING mailingaddresscounty{XPATH('mailingaddresscounty')};
    STRING mailingaddresslatitude{XPATH('mailingaddresslatitude')};
    STRING mailingaddresslongitude{XPATH('mailingaddresslongitude')};
    STRING mailingaddressmsa{XPATH('mailingaddressmsa')};
    STRING mailingaddressgeoblock{XPATH('mailingaddressgeoblock')};
    STRING mailingaddressgeomatchcode{XPATH('mailingaddressgeomatchcode')};
    STRING mailingaddresserrorstatus{XPATH('mailingaddresserrorstatus')};
    INTEGER mailingaddresscachehit{XPATH('mailingaddresscachehit')};
    INTEGER mailingaddresscleanerhit{XPATH('mailingaddresscleanerhit')};
    STRING mailingaddresscleanedaddress{XPATH('mailingaddresscleanedaddress')};
    STRING mailingaddressinputaddress{XPATH('mailingaddressinputaddress')};
    INTEGER mailingaddressnoaddressinput{XPATH('mailingaddressnoaddressinput')};
    INTEGER mailingaddressnoaddresscleanererror{XPATH('mailingaddressnoaddresscleanererror')};
    STRING mailingaddresserrorcodedescription{XPATH('mailingaddresserrorcodedescription')};
    INTEGER legalphysicalultid{XPATH('legalphysicalultid')};
    INTEGER legalphysicalorgid{XPATH('legalphysicalorgid')};
    INTEGER legalphysicalseleid{XPATH('legalphysicalseleid')};
    INTEGER legalphysicalproxid{XPATH('legalphysicalproxid')};
    INTEGER legalphysicalpowid{XPATH('legalphysicalpowid')};
    INTEGER legalphysicaldotid{XPATH('legalphysicaldotid')};
    INTEGER legalphysicalempid{XPATH('legalphysicalempid')};
    INTEGER dbaphysicalultid{XPATH('dbaphysicalultid')};
    INTEGER dbaphysicalorgid{XPATH('dbaphysicalorgid')};
    INTEGER dbaphysicalseleid{XPATH('dbaphysicalseleid')};
    INTEGER dbaphysicalproxid{XPATH('dbaphysicalproxid')};
    INTEGER dbaphysicalpowid{XPATH('dbaphysicalpowid')};
    INTEGER dbaphysicaldotid{XPATH('dbaphysicaldotid')};
    INTEGER dbaphysicalempid{XPATH('dbaphysicalempid')};
    INTEGER legalmailingultid{XPATH('legalmailingultid')};
    INTEGER legalmailingorgid{XPATH('legalmailingorgid')};
    INTEGER legalmailingseleid{XPATH('legalmailingseleid')};
    INTEGER legalmailingproxid{XPATH('legalmailingproxid')};
    INTEGER legalmailingpowid{XPATH('legalmailingpowid')};
    INTEGER legalmailingdotid{XPATH('legalmailingdotid')};
    INTEGER legalmailingempid{XPATH('legalmailingempid')};
    INTEGER dbamailingultid{XPATH('dbamailingultid')};
    INTEGER dbamailingorgid{XPATH('dbamailingorgid')};
    INTEGER dbamailingseleid{XPATH('dbamailingseleid')};
    INTEGER dbamailingproxid{XPATH('dbamailingproxid')};
    INTEGER dbamailingpowid{XPATH('dbamailingpowid')};
    INTEGER dbamailingdotid{XPATH('dbamailingdotid')};
    INTEGER dbamailingempid{XPATH('dbamailingempid')};
    INTEGER ultid{XPATH('ultid')};
    INTEGER orgid{XPATH('orgid')};
    INTEGER seleid{XPATH('seleid')};
    INTEGER proxid{XPATH('proxid')};
    INTEGER powid{XPATH('powid')};
    INTEGER empid{XPATH('empid')};
    INTEGER dotid{XPATH('dotid')};
    INTEGER businessisultinput{XPATH('businessisultinput')};
    INTEGER businessisseleinput{XPATH('businessisseleinput')};
    INTEGER businessisproxinput{XPATH('businessisproxinput')};
    STRING bestultcompanyname{XPATH('bestultcompanyname')};
    STRING bestultfein{XPATH('bestultfein')};
    STRING bestultprimaryrange{XPATH('bestultprimaryrange')};
    STRING bestultpredirectional{XPATH('bestultpredirectional')};
    STRING bestultprimaryname{XPATH('bestultprimaryname')};
    STRING bestultaddresssuffix{XPATH('bestultaddresssuffix')};
    STRING bestultpostdirectional{XPATH('bestultpostdirectional')};
    STRING bestultunitdesignation{XPATH('bestultunitdesignation')};
    STRING bestultsecondaryrange{XPATH('bestultsecondaryrange')};
    STRING bestultpostalcity{XPATH('bestultpostalcity')};
    STRING bestultvanitycity{XPATH('bestultvanitycity')};
    STRING bestultstate{XPATH('bestultstate')};
    STRING bestultzip{XPATH('bestultzip')};
    STRING bestultzip4{XPATH('bestultzip4')};
    STRING bestultcounty{XPATH('bestultcounty')};
    STRING bestultphone{XPATH('bestultphone')};
    INTEGER bestultdatefirstseen{XPATH('bestultdatefirstseen')};
    INTEGER bestultdatelastseen{XPATH('bestultdatelastseen')};
    INTEGER bestultincorporationdate{XPATH('bestultincorporationdate')};
    STRING bestultsic{XPATH('bestultsic')};
    STRING bestultnaics{XPATH('bestultnaics')};
    STRING bestselecompanyname{XPATH('bestselecompanyname')};
    STRING bestselefein{XPATH('bestselefein')};
    STRING bestseleprimaryrange{XPATH('bestseleprimaryrange')};
    STRING bestselepredirectional{XPATH('bestselepredirectional')};
    STRING bestseleprimaryname{XPATH('bestseleprimaryname')};
    STRING bestseleaddresssuffix{XPATH('bestseleaddresssuffix')};
    STRING bestselepostdirectional{XPATH('bestselepostdirectional')};
    STRING bestseleunitdesignation{XPATH('bestseleunitdesignation')};
    STRING bestselesecondaryrange{XPATH('bestselesecondaryrange')};
    STRING bestselepostalcity{XPATH('bestselepostalcity')};
    STRING bestselevanitycity{XPATH('bestselevanitycity')};
    STRING bestselestate{XPATH('bestselestate')};
    STRING bestselezip{XPATH('bestselezip')};
    STRING bestselezip4{XPATH('bestselezip4')};
    STRING bestselecounty{XPATH('bestselecounty')};
    STRING bestselephone{XPATH('bestselephone')};
    INTEGER bestseledatefirstseen{XPATH('bestseledatefirstseen')};
    INTEGER bestseledatelastseen{XPATH('bestseledatelastseen')};
    INTEGER bestseleincorporationdate{XPATH('bestseleincorporationdate')};
    STRING bestselesic{XPATH('bestselesic')};
    STRING bestselenaics{XPATH('bestselenaics')};
    BOOLEAN bestseleisactive{XPATH('bestseleisactive')};
    BOOLEAN bestseleisdefunct{XPATH('bestseleisdefunct')};
    STRING bestproxcompanyname{XPATH('bestproxcompanyname')};
    STRING bestproxfein{XPATH('bestproxfein')};
    STRING bestproxprimaryrange{XPATH('bestproxprimaryrange')};
    STRING bestproxpredirectional{XPATH('bestproxpredirectional')};
    STRING bestproxprimaryname{XPATH('bestproxprimaryname')};
    STRING bestproxaddresssuffix{XPATH('bestproxaddresssuffix')};
    STRING bestproxpostdirectional{XPATH('bestproxpostdirectional')};
    STRING bestproxunitdesignation{XPATH('bestproxunitdesignation')};
    STRING bestproxsecondaryrange{XPATH('bestproxsecondaryrange')};
    STRING bestproxpostalcity{XPATH('bestproxpostalcity')};
    STRING bestproxvanitycity{XPATH('bestproxvanitycity')};
    STRING bestproxstate{XPATH('bestproxstate')};
    STRING bestproxzip{XPATH('bestproxzip')};
    STRING bestproxzip4{XPATH('bestproxzip4')};
    STRING bestproxcounty{XPATH('bestproxcounty')};
    STRING bestproxphone{XPATH('bestproxphone')};
    INTEGER bestproxdatefirstseen{XPATH('bestproxdatefirstseen')};
    INTEGER bestproxdatelastseen{XPATH('bestproxdatelastseen')};
    INTEGER bestproxincorporationdate{XPATH('bestproxincorporationdate')};
    STRING bestproxsic{XPATH('bestproxsic')};
    STRING bestproxnaics{XPATH('bestproxnaics')};
    STRING mappininfo{XPATH('mappininfo')};
    INTEGER bipattributesisnew{XPATH('bipattributesisnew')};
    INTEGER bipattributesinactive{XPATH('bipattributesinactive')};
    STRING ultentitycontextuid{XPATH('ultentitycontextuid')};
    STRING seleentitycontextuid{XPATH('seleentitycontextuid')};
    STRING proxentitycontextuid{XPATH('proxentitycontextuid')};
    STRING physicalcleanaddresssearchstring{XPATH('physicalcleanaddresssearchstring')};
    STRING physicalinputaddresssearchstring{XPATH('physicalinputaddresssearchstring')};
    STRING mailingcleanaddresssearchstring{XPATH('mailingcleanaddresssearchstring')};
    STRING mailinginputaddresssearchstring{XPATH('mailinginputaddresssearchstring')};
    STRING bestselenaicsdescription{XPATH('bestselenaicsdescription')};
    STRING bestselesicdescription{XPATH('bestselesicdescription')};
    STRING bestproxnaicsdescription{XPATH('bestproxnaicsdescription')};
    STRING bestproxsicdescription{XPATH('bestproxsicdescription')};
    INTEGER bizrecid {XPATH('bizrecid')};
    BOOLEAN nobipidflag {XPATH('nobipidflag')};
    BOOLEAN isnewproxflag	{XPATH('isnewproxflag')};
    BOOLEAN isnewseleflag {XPATH('isnewseleflag')};
    BOOLEAN isnewultflag {XPATH('isnewultflag')};
    STRING officerfirstname {XPATH('officerfirstname')}; 
    STRING officermiddlename {XPATH('officermiddlename')}; 
    STRING officerlastname {XPATH('officerlastname')}; 
    STRING officernamesuffix {XPATH('officernamesuffix')}; 
    STRING reportedofficerentitycontextuid {XPATH('reportedofficerentitycontextuid')};
    INTEGER shownewbusinesses {XPATH('shownewbusinesses')};
    INTEGER soapcallerrorcode {XPATH('soapcallerrorcode')};
    STRING soapcallerrordescription {XPATH('soapcallerrordescription')};
  END;
  
	string BusinessName 		:= '' : STORED('BusinessName');
	string BusinessAddress	:= '' : STORED('BusinessAddress');
	string BusinessCity			:= '' : STORED('BusinessCity');
	string BusinessState		:= '' : STORED('BusinessState');
	string BusinessZip			:= '' : STORED('BusinessZip');
	string FEIN 						:= '' : STORED('FEIN');
	string OfficerName 		  := '' : STORED('OfficerName');
	string OfficerAddress	  := '' : STORED('OfficerAddress');
	string OfficerCity		  := '' : STORED('OfficerCity');
	string OfficerState		  := '' : STORED('OfficerState');
	string OfficerZip			  := '' : STORED('OfficerZip');
	string SSN              := '' : STORED('SSN');
	string CustomerAccount  := '' : STORED('CustomerAccount');
  INTEGER ShowNewBusinesses := 0 : STORED('ShowNewBusinesses');
  
  BIZSearchOutput SetError (BIZSearchInput L) := transform
    SELF.soapcallerrorcode  := FAILCODE,
    SELF.soapcallerrordescription := FAILMESSAGE,
    SELF := L;
    SELF := [];
  end;
  
	BIZSearchInput tInput() := TRANSFORM
		SELF.BusinessName   := BusinessName;
		SELF.BusinessAddress:= BusinessAddress;
		SELF.BusinessCity   := BusinessCity;
		SELF.BusinessState  := BusinessState;
		SELF.BusinessZip    := BusinessZip;
		SELF.FEIN           := FEIN;
		SELF.OfficerName 		:= OfficerName;
		SELF.OfficerAddress	:= OfficerAddress;
		SELF.OfficerCity		:= OfficerCity;
		SELF.OfficerState		:= OfficerState;
		SELF.OfficerZip			:= OfficerZip;
		SELF.SSN            := SSN;
		SELF.CustomerAccount:= CustomerAccount;
    SELF.ShowNewBusinesses := ShowNewBusinesses;
	END;
  dIn :=DATASET([tInput()]);
  
  dOut := SOAPCALL(dIn,InternalRoxieServiceUrl,ServiceName,{dIn},DATASET(BIZSearchOutput),ONFAIL(SetError(LEFT)), TIMEOUT(3), RETRY(1));

  OUTPUT(dOut, NAMED('Results'));
ENDMACRO;