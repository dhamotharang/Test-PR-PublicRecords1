/*--SOAP--
<message name="Deathv2SearchService">
  
  <part name="DID" 								type="xsd:string"/>
	<part name="StateDeathID" 			type="xsd:string"/>
  <part name='SSN'								type='xsd:string'/>
  <part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"    				type="xsd:string"/>
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="County"             type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="Phone"	  					type="xsd:string"/>
	<part name="DOB" 								type="xsd:unsignedInt"/>
	<part name="DOD" 								type="xsd:unsignedInt"/>
  <part name="MileRadius"  				type="xsd:unsignedInt"/>
  <part name="MaxResults"  				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="SSNMask" 						type="xsd:string"/>
  <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
	<part name="NoDeepDive" 				type="xsd:boolean"/>
	<part name="IncludeBlankDOD" 				type="xsd:boolean"/>
    
</message>
*/
/*--INFO-- This service searches the Death files.*/


export SearchService() := macro
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);

	// output(DeathV2_Services.Search_records, named('Results'));

	recs := DeathV2_Services.Search_records;
  Text_Search.MAC_Append_ExternalKey(recs, recs2, l.state_death_id);
	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;




