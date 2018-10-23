/*--SOAP--
<message name="MDSearchServiceFCRA">

	<!-- MD Keys -->
	<part name="IndustryCLASS"					type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="RecordID"					type="xsd:string"/>
	<part name="DID"							type="xsd:string"/>
	<part name="NonSubjectSuppression"  			type="xsd:unsignedInt"/>
	
	<part name="FilingNumber"			type="xsd:string"/>
	<part name="FilingType"				type="xsd:string"/>
	<part name="FilingSubType"		type="xsd:string"/>
	<part name="FilingJurisdiction"	type="xsd:string"/>
	<part name="County"						type="xsd:string"/>
  <part name="FilingDateBegin"	type='xsd:string'/>
  <part name="FilingDateEnd"		type='xsd:string'/>

	<!-- Autokey search fields -->
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
	<part name="DOB" 							type="xsd:unsignedInt"/>
	<part name="SSN" 							type="xsd:string"/>
	<part name="LookupType"				type="xsd:string"/>

	<!-- Autokey Tuning -->
	<part name="AllowNickNames" 	type="xsd:boolean"/>
	<part name="PhoneticMatch"  	type="xsd:boolean"/>
	<part name="ExactOnly"   			type="xsd:boolean"/>
	<part name="NoDeepDive" 			type="xsd:boolean"/>
	<part name="ZipRadius"  			type="xsd:unsignedInt"/>

	<!-- MD Tuning -->
	<part name="PenaltThreshold"	type="xsd:unsignedInt"/>

  <!-- 2nd Party Search Criteria -->
	<part name="Entity2_DID" 								type="xsd:string"/>
	<part name="Entity2_UnParsedFullName" 	type="xsd:string"/>
	<part name="Entity2_FirstName"   				type="xsd:string"/>
	<part name="Entity2_MiddleName"  				type="xsd:string"/>
	<part name="Entity2_LastName"    				type="xsd:string"/>
	<part name="Entity2_Addr"	       				type="xsd:string"/>
	<part name="Entity2_City"        				type="xsd:string"/>
	<part name="Entity2_State"       				type="xsd:string"/>
	<part name="Entity2_Zip"         				type="xsd:string"/>
	<part name="Entity2_SSN"								type="xsd:string"/>
  <part name="Entity2_DOB"		            type="xsd:unsignedInt"/>
	<part name="Entity2_AllowNickNames" 		type="xsd:boolean"/>
	<part name="Entity2_PhoneticMatch"  		type="xsd:boolean"/>
	<part name="Entity2_ExactOnly"   	      type="xsd:boolean"/>
	<part name="Entity2_NoDeepDive" 	      type="xsd:boolean"/>
	<part name="Entity2_ZipRadius"  				type="xsd:unsignedInt"/>
	
	<!-- Marshalling -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>

	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
  
  <!-- Consumer Person Context -->
  <part name="FFDOptionsMask" 	      type="xsd:string"/>
  <part name="FCRAPurpose" type="xsd:string"/>
    
</message>
*/
/*--INFO-- Search for Marriage & Divorce Records via simple keys or autokeys. */
import text_search,doxie,FCRA,Gateway,FFD,std;

export MDSearchServiceFCRA() := macro
	#constant('NoDeepDive', true);
	#constant('DidOnly', true) // for picklist
	
	boolean isFCRA := true;
	

	//soap call for remote DIDs
	//------------------------------------------------------------------------------------
	// gateways := dataset([], Gateway.layouts.config) : stored ('gateways', few);
	gateways := Gateway.Configuration.Get();
	picklist_res := FCRA.PickListSoapcall.non_esdl(gateways);
	//------------------------------------------------------------------------------------

  rdid := (unsigned6)picklist_res[1].Records[1].UniqueId;

	//non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);

  //  Fill FCRA.iRules
	iRulesParams := module (FCRA.iRules)
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
  end;
	
	// Generate the full report
	tmp := marriage_divorce_v2_Services.MDSearchService_Records(rdid,nss,isFCRA,iRulesParams);
	raw := tmp.records;
	statements  := tmp.statements;
	consumer_alerts  := tmp.ConsumerAlerts;
  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, false);
	
  Text_Search.MAC_Append_ExternalKey(raw, raw2, INTFORMAT(l.record_id,15,1));
	// And chop it up as necessary
	doxie.MAC_Header_Field_Declare(isFCRA)
	doxie.MAC_Marshall_Results(raw2, cooked)
	
	// We're outta here
	output(cooked, named('Results'));
	output(statements,named('ConsumerStatements'));
	output(consumer_alerts,named('ConsumerAlerts'));
	output(input_consumer,named('Consumer'));
endmacro;
// MDSearchServiceFCRA();