EXPORT bwr_PostBeneficiaryFraud(	roxieIP,
																	// Gateway, 
																	threads, 
																	timeout, 
																	retry, 
																	infile_name,
																	outfile_name, 
																	num_records
																	):= functionmacro


IMPORT Models, Riskwise, Scoring_Project, ut;

//********************************************************************
// roxieIP := roxie_ip;
// retry := Retrys;
// timeout := Timeouts;
// threads := Thread;
// num_records := records_ToRun;
// filetag := 'pbf_test';

// infile_name := Input_file_name;
// outfile_name := Output_file_name;

// roxieIP := riskwise.shortcuts.prod_batch_neutral;
// roxieIP := 'http://1.1.1';
// roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;
// retry := 3;
// timeout := 120;
// threads := 1;
// num_records := 5;
// filetag := 'pbf_test';

// infile_name := ut.foreign_prod + '~scoring_project::in::riskview_xml_generic_version4_20140528';
// outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4' + filetag + '_' +  ut.GetDate;

//********************************************************************

input_layout := RECORD
		Scoring_Project_Macros.Regression.global_layout;
		Scoring_Project_Macros.Regression.pii_layout;
		Scoring_Project_Macros.Regression.runtime_layout;
END;

f1 := CHOOSEN(DATASET(infile_name, input_layout, CSV(HEADING(single), QUOTE('"'))), num_records);
ds_pii := DISTRIBUTE(f1, HASH64(accountnumber));


layout_soapin := RECORD	
		INTEGER DPPAPurpose; 
		INTEGER GLBPurpose; 
		STRING DataPermissionMask;
		STRING DataRestrictionMask;
		DATASET(Models.Layout_PostBeneficiaryFraud.BatchInput) PBF_batch_in;
		DATASET(gateway.Layouts.config) gateways;
		STRING    RealTimePermissibleUse := '' ; 
		UNSIGNED1 RelativeDepthLevel ; 
		BOOLEAN   IncludeAllAttributeCategories ; 
		BOOLEAN   IncludeRelativeAndAssociates ; 
		BOOLEAN   IncludeDriversLicense ; 
		BOOLEAN   IncludeProperty ; 
		BOOLEAN   IncludeInHouseMotorVehicle ; 
		BOOLEAN   IncludeRealTimeMotorVehicle ; 
		BOOLEAN   IncludeWatercraftAndAircraft ; 
		BOOLEAN   IncludeProfessionalLicense ; 
		BOOLEAN   IncludeBusinessAffiliations ; 
		BOOLEAN   IncludePeopleAtWork ; 
		BOOLEAN   IncludeBankruptcyLiensJudgements ; 
		BOOLEAN   IncludeCriminalSOFR ; 
		BOOLEAN   IncludeUCCFilings ; 
END;

Models.Layout_PostBeneficiaryFraud.BatchInput batchin_trans(input_layout le) := TRANSFORM
		SELF.acctno 							:= (STRING)le.AccountNumber;
		// SELF.unparsed_full_name 	:= le. ;
		SELF.name_first						:= le.FirstName;
		SELF.name_middle					:= le.MiddleName;
		SELF.name_last 						:= le.LastName;
		SELF.ssn 									:= le.SSN;
		SELF.dob 									:= le.DateOfBirth;
		SELF.street_address 			:= le.StreetAddress;
		SELF.p_city_name 					:= le.City;
		SELF.st 									:= le.State;
		SELF.z5 									:= le.Zip;
		SELF.home_phone 					:= le.HomePhone;
		SELF.dl_number						:= le.DLNumber;
		SELF.dl_state 						:= le.DLState;
		// SELF.case_number 					:= le. ;
		// SELF.claim_amount 				:= le. ;
		// SELF.input_state 					:= le. ;
		// SELF.input_date 					:= le. ;
		// SELF.mvr_vehicle_threshold := le. ;
		// SELF.number_of_mvr 				:= le. ;
		// SELF.number_of_properties := le. ;
		// SELF.number_of_adults 		:= le. ;
		// SELF.filler 							:= le. ;
		
		SELF := [];		
END;

layout_soapin soap_trans(ds_pii le) := TRANSFORM
		SELF.pbf_batch_in 				:= PROJECT(le, batchin_trans(left)); 	
		SELF.DPPAPurpose 					:= IF(le.DPPA <> '', (INTEGER)le.DPPA, 5); 
		SELF.GLBPurpose 					:= IF(le.GLB <> '', (INTEGER)le.GLB, 1); 
		SELF.DataRestrictionMask	:= IF(le.DRM <> '', le.DRM, '0000000000000000');
		SELF.IncludeAllAttributeCategories 	:= 1;
		SELF.gateways 						:= [];
		SELF := [];
END;

input_soap := PROJECT(ds_pii, soap_trans(LEFT));

// OUTPUT(CHOOSEN(input_soap, 25), NAMED('input_soap'));

xlayout := RECORD
	Models.Layout_PostBeneficiaryFraud.Final_Output;
	STRING errorcode;
END;

xlayout myFail(input_soap le) := TRANSFORM
	SELF.errorcode 	:= FAILCODE + FAILMESSAGE;
	// SELF.acctno 		:= 'xxx';
	SELF := le;
	SELF := [];
END;
	
pbf_results := SOAPCALL(input_soap, roxieIP,
				'Models.PostBeneficiaryFraud_Batch_Service', {input_soap}, 
				DATASET(xlayout), RETRY(retry), TIMEOUT(timeout),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
// final_results := OUTPUT(CHOOSEN(pbf_results, 25), NAMED('pbf_results'));
final_results := OUTPUT(pbf_results,,outfile_name,CSV(HEADING(single), QUOTE('"')), OVERWRITE);

return final_results;

endmacro;
/*
//********* SAMPLE XML INPUT ******************

<models.postbeneficiaryfraud_batch_serviceRequest>
		<returncurrent>1</returncurrent>
		<workhard>1</workhard>
		<allowwildcard>1</allowwildcard>

		<pbf_batch_in>
				<Row>
						<acctno>[XXXXXXXXX string30 XXXXXXXXX]</acctno>
						<unparsed_full_name>[XXXXXXXXXXXXXXXXXXXXXXXXXXXXX string70 XXXXXXXXXXXXXXXXXXXXXXXXXXXXX]</unparsed_full_name>
						<name_first>[X string15 XX]</name_first>
						<name_middle>[XXXXXXXXX string30 XXXXXXXXX]</name_middle>
						<name_last>[XXXX string20 XXXX]</name_last>
						<ssn>[string9]</ssn>
						<dob>[string]</dob>
						<street_address>[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX string120 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]</street_address>
						<p_city_name>[XXXXXXXXX string30 XXXXXXXXX]</p_city_name>
						<st>[]</st>
						<z5>[str]</z5>
						<home_phone>[string10]</home_phone>
						<dl_number>[XXXX string20 XXXX]</dl_number>
						<dl_state>[]</dl_state>
						<case_number>[XXXXXXXXXXXXXXXXXXX string50 XXXXXXXXXXXXXXXXXXX]</case_number>
						<claim_amount>[ string11]</claim_amount>
						<input_state>[]</input_state>
						<input_date>[string]</input_date>
						<mvr_vehicle_threshold>[ string11]</mvr_vehicle_threshold>
						<number_of_mvr>1</number_of_mvr>
						<number_of_properties>1</number_of_properties>
						<number_of_adults>1</number_of_adults>
						<filler>[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX string120 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]</filler>
				</Row>
		</pbf_batch_in>

		<includeallattributecategories>1</includeallattributecategories>
		<includerelativeandassociates>1</includerelativeandassociates>
		<includedriverslicense>1</includedriverslicense>
		<includeproperty>1</includeproperty>
		<includeinhousemotorvehicle>1</includeinhousemotorvehicle>
		<includerealtimemotorvehicle>1</includerealtimemotorvehicle>
		<includewatercraftandaircraft>1</includewatercraftandaircraft>
		<includeprofessionallicense>1</includeprofessionallicense>
		<includebusinessaffiliations>1</includebusinessaffiliations>
		<includepeopleatwork>1</includepeopleatwork>
		<includebankruptcyliensjudgements>1</includebankruptcyliensjudgements>
		<includecriminalsofr>1</includecriminalsofr>
		<includeuccfilings>1</includeuccfilings>

		<gateways>
				<Row>
						<servicename>String</servicename>
						<url>String</url>
				</Row>
				<Row>
						<servicename>String</servicename>
						<url>String</url>
				</Row>
		</gateways>

		<_transactionid>String</_transactionid>
		<_batchjobid>String</_batchjobid>
		<_batchspecid>String</_batchspecid>
		<datapermissionmask>String</datapermissionmask>
		<allowdppa>1</allowdppa>
		<allowall>1</allowall>
		<dppapurpose>32716</dppapurpose>
		<allowglb>1</allowglb>
		<glbpurpose>32716</glbpurpose>
		<selecttimeframe>String</selecttimeframe>
		<relativedepthlevel>32716</relativedepthlevel>
		<includeminors>1</includeminors>
		<industryclass>String</industryclass>
		<datarestrictionmask>String</datarestrictionmask>
		<run_deep_dive>1</run_deep_dive>
		<phonetics>1</phonetics>
		<nicknames>1</nicknames>
		<match_name>1</match_name>
		<match_city>1</match_city>
		<match_street_address>1</match_street_address>
		<match_state>1</match_state>
		<match_zip>1</match_zip>
		<addr>String</addr>
		<addressorigin>32716</addressorigin>
		<agehigh>32716</agehigh>
		<agelow>32716</agelow>
		<allowdateseen>1</allowdateseen>
		<allowfuzzydobmatch>1</allowfuzzydobmatch>
		<allowleadinglname>1</allowleadinglname>
		<allownicknames>1</allownicknames>
		<applicationtype>String</applicationtype>
		<asisname>String</asisname>
		<bpsleadingnamematch>1</bpsleadingnamematch>
		<checknamevariants>1</checknamevariants>
		<cleanfmlname>1</cleanfmlname>
		<cn>String</cn>
		<company>String</company>
		<companyname>String</companyname>
		<corpname>String</corpname>
		<county>String</county>
		<currentresidentsonly>1</currentresidentsonly>
		<datefirstseen>32716</datefirstseen>
		<datelastseen>32716</datelastseen>
		<democustomername>String</democustomername>
		<distancethreshold>32716</distancethreshold>
		<excludelessors>1</excludelessors>
		<fname3>String</fname3>
		<fuzzysecrange>32716</fuzzysecrange>
		<household>1</household>
		<keepoldssns>1</keepoldssns>
		<lfmname>String</lfmname>
		<lname>String</lname>
		<lname4>String</lname4>
		<lnbranded>1</lnbranded>
		<lookuptype>String</lookuptype>
		<middlename>String</middlename>
		<mileradius>32716</mileradius>
		<moxievehicles>1</moxievehicles>
		<nameasis>String</nameasis>
		<nonexclusion>1</nonexclusion>
		<onlyexactmatches>1</onlyexactmatches>
		<othercity1>String</othercity1>
		<otherlastname1>String</otherlastname1>
		<otherstate1>String</otherstate1>
		<otherstate2>String</otherstate2>
		<partytype>String</partytype>
		<phone>String</phone>
		<phoneticdistancematch>1</phoneticdistancematch>
		<phoneticmatch>1</phoneticmatch>
		<postalcode>String</postalcode>
		<primname>String</primname>
		<primrange>String</primrange>
		<relativefirstname1>String</relativefirstname1>
		<relativefirstname2>String</relativefirstname2>
		<rid>String</rid>
		<scorethreshold>32716</scorethreshold>
		<searchgoodssnonly>1</searchgoodssnonly>
		<searchignoresaddressonly>1</searchignoresaddressonly>
		<sec_range>String</sec_range>
		<secrange>String</secrange>
		<seisintadlservice>String</seisintadlservice>
		<simplifiedcontactreturn>1</simplifiedcontactreturn>
		<ssntypos>1</ssntypos>
		<st>String</st>
		<st_orig>String</st_orig>
		<statecityzip>String</statecityzip>
		<street_name>String</street_name>
		<strictmatch>1</strictmatch>
		<unparsedfullname>String</unparsedfullname>
		<useonlybestdid>1</useonlybestdid>
		<usessnfallback>1</usessnfallback>
		<usingkeepssns>1</usingkeepssns>
		<z5>String</z5>
		<zipradius>32716</zipradius>
		<includenonregulatedvehiclesources>1</includenonregulatedvehiclesources>
		<year>String</year>
		<make>String</make>
		<model>String</model>
		<lastname>String</lastname>
		<firstname>String</firstname>
		<entrp_month_value>String</entrp_month_value>
		<includecriminalindicators>1</includecriminalindicators>
		<twopartysearch>1</twopartysearch>
		<did>String</did>
		<ssn>String</ssn>
		<city>String</city>
		<state>String</state>
		<zip>String</zip>
		<predir>String</predir>
		<postdir>String</postdir>
		<suffix>String</suffix>
		<prim_name>String</prim_name>
		<prim_range>String</prim_range>
		<bdid>String</bdid>
		<entity2_did>String</entity2_did>
		<entity2_ssn>String</entity2_ssn>
		<entity2_lastname>String</entity2_lastname>
		<entity2_unparsedfullname>String</entity2_unparsedfullname>
		<entity2_firstname>String</entity2_firstname>
		<entity2_middlename>String</entity2_middlename>
		<entity2_city>String</entity2_city>
		<entity2_state>String</entity2_state>
		<entity2_addr>String</entity2_addr>
		<entity2_zip>String</entity2_zip>
		<entity2_zipradius>32716</entity2_zipradius>
		<entity2_bdid>String</entity2_bdid>
		<entity2_companyname>String</entity2_companyname>
		<penaltthreshold>32716</penaltthreshold>
		<ssnmask>String</ssnmask>
		<dlmask>32716</dlmask>
		<titleissuedate>String</titleissuedate>
		<previoustitleissuedate>String</previoustitleissuedate>
		<displaymatchedparty>1</displaymatchedparty>
		<fullnamematch>1</fullnamematch>
		<realtimepermissibleuse>String</realtimepermissibleuse>
		<referencecode>String</referencecode>
		<billingcode>String</billingcode>
		<queryid>String</queryid>
		<subcustomerid>String</subcustomerid>
		<match_comp_name>1</match_comp_name>
		<match_fein>1</match_fein>
		<extramatchcodes>1</extramatchcodes>
		<addsupplemental>1</addsupplemental>
		<nodidappend>1</nodidappend>
		<daysback>32716</daysback>
		<includeblankdod>1</includeblankdod>
		<excludedmvpii>1</excludedmvpii>
		<partialnamematchcodes>1</partialnamematchcodes>
		<matchcode_adl_append>1</matchcode_adl_append>
		<matchcode_includes>String</matchcode_includes>
</models.postbeneficiaryfraud_batch_serviceRequest>
*/