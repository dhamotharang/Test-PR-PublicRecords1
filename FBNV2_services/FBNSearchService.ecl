/*--SOAP--
<message name="FBNSearchService">
  <part name="IndustryClass" 							type="xsd:string"/>
  <part name="TMSID" 							type="xsd:string"/>
  <part name="RMSID" 							type="xsd:string"/>
  <part name="FilingJurisdiction"	type='xsd:string'/>
  <part name="FilingNumber"				type='xsd:string'/>
  <part name="FilingDateBegin"		type='xsd:string'/>
  <part name="FilingDateEnd"		type='xsd:string'/>

  <part name="DID" 					type="xsd:string"/>
  <part name="BDID" 				type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
  <part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   			type="xsd:string"/>
  <part name="MiddleName"  			type="xsd:string"/>
  <part name="LastName"    			type="xsd:string"/>
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="Addr"	       			type="xsd:string"/>
  <part name="City"        			type="xsd:string"/>
  <part name="State"       			type="xsd:string"/>
  <part name="Zip"         			type="xsd:string"/>
  <part name="County"           type="xsd:string"/>
  <part name="MileRadius"  			type="xsd:unsignedInt"/>

	<part name="TwoPartySearch"             type="xsd:boolean"/>
  <part name="Entity2_DID" 								type="xsd:string"/>
  <part name="Entity2_BDID" 							type="xsd:string"/>
  <part name="Entity2_CompanyName" 				type="xsd:string"/>
	<part name="Entity2_UnParsedFullName" 	type="xsd:string"/>
  <part name="Entity2_FirstName"   				type="xsd:string"/>
  <part name="Entity2_MiddleName"  				type="xsd:string"/>
  <part name="Entity2_LastName"    				type="xsd:string"/>
  <part name="Entity2_AllowNickNames" 		type="xsd:boolean"/>
  <part name="Entity2_PhoneticMatch"  		type="xsd:boolean"/>
  <part name="Entity2_Addr"	       				type="xsd:string"/>
  <part name="Entity2_City"        				type="xsd:string"/>
  <part name="Entity2_State"       				type="xsd:string"/>
  <part name="Entity2_Zip"         				type="xsd:string"/>
  <part name="Entity2_County"             type="xsd:string"/>
  <part name="Entity2_ZipRadius"  				type="xsd:unsignedInt"/>

  <part name="Phone"	  			type="xsd:string"/>
  <part name="SkipRecords" 			type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" 			type="xsd:byte"/>
  <part name="GLBPurpose" 			type="xsd:byte"/>
  <part name="ExactOnly"   			type="xsd:boolean"/>
  <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
  <part name="MaxResults" 			type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" 	type="xsd:unsignedInt"/>
  <part name="SkipRecords" 			type="xsd:unsignedInt"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>    
</message>
*/
/*--INFO-- This service searches the FBNV2 files.*/


export FBNSearchService() := macro
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('getBdidsbyExecutive',FALSE);

	// output(FBNV2_Services.FBNV2_records, named('Results'));

	recs := FBNV2_Services.FBNV2_records;
	
	Text_Search.MAC_Append_ExternalKey(recs, recs2, l.tmsid + l.rmsid);

	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

endmacro;
