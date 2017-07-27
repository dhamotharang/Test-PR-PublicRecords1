IMPORT banko;

/*--SOAP--
<message name="AdditionalEventsServiceFCRA">
  <part name="CourtCode"          type="xsd:string"/>
  <part name="CaseKey"            type="xsd:string"/>
  <part name="TMSId"            	type="xsd:string"/>
  <part name="CaseId"            	type="xsd:string"/>
  <part name="IsCaseCourtSearch" 	type="xsd:boolean"/>
	<part name="IsCaseIdSearch"     type="xsd:boolean"/>
	<part name="IsTMSIdSearch"     	type="xsd:boolean"/>		
  <part name="EnteredDate"       	type="xsd:string"/>
</message>
*/
/*--INFO--
Additional Events query.
*/

EXPORT AdditionalEventsServiceFCRA() := MACRO

	STRING courtcode_in  						:= '' 		: STORED('CourtCode');
	STRING casekey_in  							:= '' 		: STORED('CaseKey');
	STRING tmsid_in	     						:= '' 		: STORED('TMSId');
	STRING caseid_in								:= '' 		: STORED('CaseId');
	STRING date_since	      				:= '' 		: STORED('EnteredDate');
	BOOLEAN isCaseCourtSearch	      := FALSE 	: STORED('IsCaseCourtSearch');
	BOOLEAN isCaseIdSearch	      	:= FALSE 	: STORED('IsCaseIdSearch');
	BOOLEAN isTMSIdSearch	      		:= FALSE 	: STORED('IsTMSIdSearch');	

	BOOLEAN isFCRA := TRUE;

	res_case_court := banko.key_Banko_courtcode_casenumber(isFCRA)(KEYED(casekey = casekey_in AND court_code = courtcode_in));
	res_tmsid      := banko.key_Banko_courtcode_casenumber(isFCRA)(KEYED(casekey = tmsid_in[8.. ] AND court_code = tmsid_in[3..7]));
	res_caseid	   := banko.key_Banko_courtcode_casenumber(isFCRA)(KEYED(caseid = caseid_in) AND WILD(casekey) AND WILD(court_code));

	res := map(isCaseCourtSearch 		=> res_case_court,
							isCaseIdSearch 			=> res_caseid,
							isTMSIdSearch      	=> res_tmsid);

	output(res(entereddate >= date_since), NAMED('Results'));
ENDMACRO;

// banko.AdditionalEventsServiceFCRA();
