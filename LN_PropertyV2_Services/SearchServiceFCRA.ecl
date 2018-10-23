/*--SOAP--
<message name="SearchServiceFCRA">

	<!-- Autokey search fields -->
  <part name="SSN" 								type="xsd:string"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"   	 			type="xsd:string"/>
  <part name="Addr"	    	   			type="xsd:string"/>
  <part name="City"   	     			type="xsd:string"/>
  <part name="State"	       			type="xsd:string"/>
  <part name="Zip" 	        			type="xsd:string"/>
  <part name="County"             type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
  <part name="Phone"	  	    		type="xsd:string"/>
  <part name="DOB"                type="xsd:unsignedInt"/>


	
	<!-- Autokey Tuning -->
	<part name="AllowNickNames" 		type="xsd:boolean"/>
	<part name="PhoneticMatch"  		type="xsd:boolean"/>
	<part name="ExactOnly"   				type="xsd:boolean"/>
	<part name="ZipRadius"  				type="xsd:unsignedInt"/>

	<!-- Property Keys -->
  <part name="DID"								type="xsd:string"/>
	
	<!-- Property Tuning -->
	<part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	<part name="StrictMatch"				type="xsd:boolean"/>
	<part name="LookupType"					type="xsd:string"/>
	<part name="PartyType"					type="xsd:string"/>
	<part name="IncludeDetails"			type="xsd:boolean"/>
	<part name="PropAddressSearch"	type="xsd:boolean"/>

	<!-- Data Restrictions -->
	<part name="CurrentOnly"				type="xsd:boolean"/>
	<part name="GroupByFidTypeOnly"		type="xsd:boolean"/>
	<part name="CurrentByVendor"		type="xsd:boolean"/>
	<part name="RobustnessScoreSorting" type="xsd:boolean"/>
	<part name="LnBranded"					type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string" default="0"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="AllowAll"						type="xsd:boolean"/>
	<part name="NonSubjectSuppression"  			type="xsd:unsignedInt"/>
		
	<!-- Privacy -->
  <part name="SSNMask"						type="xsd:string"/>

  <!-- Full File Disclosure -->	
  <part name="FFDOptionsMask" 	      type="xsd:string"/>
  <part name="FCRAPurpose" type="xsd:string"/>

	<!-- Record management -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>
  <part name="ReturnHashes"				type="xsd:boolean"/>
  <part name="srch_hashvals"			type="tns:XmlDataSet" cols="70" rows="3"/>	

  // Enhancement/Bug: 64514
  <part name="MatchByBuyerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByMailingAddresses"  type="xsd:boolean"/> 
  <part name="MatchByOwnerAddresses"    type="xsd:boolean"/> 
  <part name="MatchByPropertyAddresses" type="xsd:boolean"/> 
  <part name="MatchBySellerAddresses"   type="xsd:boolean"/> 

  <separator/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <separator/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/

/*--INFO-- Search for Property Records via simple keys and autokeys. It also searches the Forclosures File. (ESP-compliant output)<br/>
  Optionally searches the Notice of Defaults File:
<table border="1">
<tr><th>ExcludeForeclosures</th><th>IncludeNoticeOfDefaults</th><th>Record Types</th></tr>
<tr><td>false</td><td>false</td><td>Foreclosures Only</td></tr>
<tr><td>false</td><td>true</td><td>Foreclosures and Notice of Defaults</td></tr>
<tr><td>true</td><td>true</td><td>Notice of Defaults Only</td></tr>
<tr><td>true</td><td>false</td><td>zip, zilch, zero, zippo, zot, ...</td></tr>
</table>
*/
import FCRA;

export SearchServiceFCRA() := macro
  //Property Search	
	boolean isFCRA := true;
	// compute results
	#CONSTANT('NoDeepDive', true);
	#CONSTANT('usePropMarshall', true);
	#CONSTANT('DisplayMatchedParty', true);
	#constant('DidOnly', true); // for picklist
	
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
	
	raw_combined := LN_PropertyV2_Services.SearchService_records(rdid,nss,isFCRA,iRulesParams);
	raw := raw_combined.Records;
	statements := raw_combined.Statements;
  consumer_alerts := raw_combined.ConsumerAlerts;
  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, false);
	
	// standard record counts & limits
	doxie.MAC_Header_Field_Declare(isFCRA);

	Alerts.mac_ProcessAlerts(raw,LN_PropertyV2_Services.alert,raw_final);

  // create External Key field
  Text_Search.MAC_Append_ExternalKey(raw_final, raw_final2, l.ln_fares_id);
	
	// doxie.MAC_Marshall_Results(raw_final2,cooked)
	LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw_final2, cooked);

	// display Property results
	output(cooked, named('Results'));
	output(statements, named('ConsumerStatements'));
	output(consumer_alerts, named('ConsumerAlerts'));
	output(input_consumer, named('Consumer'));

endmacro;