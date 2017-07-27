/*--SOAP--
<message name="AMEX.AdditionalDataService">
  <part name="Account" type="xsd:string" required="1"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="SSNMask" type="xsd:string"/>

  <part name="CountRelsAtAddrs" type="xsd:boolean"/>
  <part name="MaxRelatives" type="xsd:unsignedInt"/>
  <part name="RelativeDepth" type="xsd:byte"/> 

	<part name="LnBranded" type="xsd:boolean"/>
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="BSVersion" type = 'xsd:integer'/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	
	<part name="IsFCRA" type="xsd:boolean"/>
	<part name="SuppressNearDups" type="xsd:boolean"/>
</message>
*/
/*--INFO--*/

import AMEX,doxie, contactCard, autostandardI,risk_indicators;

export AdditionalDataService := MACRO

doxie.MAC_Header_Field_Declare()
#CONSTANT('IsCRS', true);

#stored('DialContactPrecision',ContactCard.constants.default_DialContactPrecision)
#stored('MaxRelatives',ContactCard.constants.max_relatives)
#stored('RelativeDepth',ContactCard.constants.default_RelativeDepth)
unsigned1 version := 255					: stored('BSVersion');	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
boolean   isFCRA := false 				: stored('IsFCRA');
boolean   suppressNearDups := false: stored('SuppressNearDups');
boolean   ln_branded := false			: stored('LnBranded');
boolean   Count_RelsAtAddrs := true	: stored('CountRelsAtAddrs');
string30  Account 		 := ''	: stored('Account');


dids := dataset([{did_value}], doxie.layout_references);
results := AMEX.getAdditionalData(dids, 
															Account,	
															DPPA_Purpose,
															GLB_Purpose, 
															history_date, 
															isFCRA,
															AutoStandardI.GlobalModule().DataRestrictionMask,
															ssn_mask_value, 
															probation_override_value,
															ln_branded,
															version,
															suppressNearDups,
															Count_RelsAtAddrs
														 ).results;
														 
output(results, named('Results'));

ENDMACRO;
//AdditionalDataService();