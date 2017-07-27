/*--SOAP--
<message name="ReportServiceFCRA">

	<!-- Property Keys -->
  <part name="DID"								type="xsd:string"/>
	
	<!-- Property Tuning -->
	<part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	<part name="LookupType"					type="xsd:string"/>
	<part name="AllPropRecords"			type="xsd:boolean"/>
	<part name="AllParcelRecords"		type="xsd:boolean"/>
	
	<!-- Data Restrictions -->
	<part name="LnBranded"					type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="AllowAll"						type="xsd:boolean"/>
	
	<!-- Privacy -->
  <part name="SSNMask"						type="xsd:string"/>
	<part name="NonSubjectSuppression"  			type="xsd:unsignedInt"/>
	
	<!-- Record management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
  
  <!-- Full File Disclosure -->	
  <part name="FFDOptionsMask" 	      type="xsd:string"/>
    
</message>
*/
/*--INFO-- Search for Property Records via simple keys. */
import FCRA;

export ReportServiceFCRA() := macro
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
	boolean isFCRA := true;
	// compute results
	#CONSTANT('usePropMarshall', true);
	
	// FFD				 
	string  strFFDOptionsMask_in	 := '0' : stored('FFDOptionsMask');
	integer8 valFFDOptionsMask 		 := ut.BinaryStringToInteger(STD.Str.Reverse(strFFDOptionsMask_in));
	
	//  Fill FCRA.iRules
	iRulesParams := module (FCRA.iRules)
		export integer8 FFDOptionsMask := valFFDOptionsMask;
  end;
		
	raw_combined := LN_PropertyV2_Services.ReportService_records(isFCRA,nss,iRulesParams);
	raw := raw_combined.Records;
	statements := raw_combined.Statements;

	// standard record counts & limits
	doxie.MAC_Header_Field_Declare(isFCRA)
	
	// doxie.MAC_Marshall_Results(raw,cooked)
	LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw,cooked);

	// display results
	output(cooked, named('Results'));
	output(statements, named('ConsumerStatements'));

endmacro;


