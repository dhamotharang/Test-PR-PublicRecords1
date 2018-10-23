/*--SOAP--
<message name="VotersSearch" wuTimeout="300000">
	<part name="DID" type = 'xsd:string'/>
  <part name="SSN" type="xsd:string"/>
	<part name="FirstName"  type='xsd:string' />
	<part name="MiddleName" type='xsd:string' />
	<part name="LastName"   type = 'xsd:string' />
	<part name="MaidenName"   type = 'xsd:string' />

	<part name="AllowNicknames" type='xsd:boolean' />
	<part name="PhoneticMatch" type='xsd:boolean' />

  <part name="DOB" type="xsd:unsignedInt"/>
	<part name="WorkPhone" type = 'xsd:string' />
	<part name="HomePhone" type = 'xsd:string' />

	<part name = "Addr" type='xsd:string' />
	<part name = "City" type="xsd:string" />
	<part name = "State" type='xsd:string' />
	<part name = "Zip" 	type = 'xsd:string' />
  <part name="County" type="xsd:string"/>
  <part name = "ZipRadius" type="xsd:unsignedInt"/>

	<part name = "GLBPurpose"	type = "xsd:byte"/>
	<part name = "DPPAPurpose"	type = "xsd:byte"/>
	<part name=  "ApplicationType"  type="xsd:string"/>
  <part name = "PenaltThreshold" 		type="xsd:unsignedInt"/>
	<part name = "MaxResults"  type = 'xsd:unsignedInt' />
	<part name = "MaxResultsThisTime" type = 'xsd:unsignedInt' />
	<part name = "SkipRecords" type = 'xsd:unsignedInt' />
  <part name = "NoDeepDive" type="xsd:boolean"/>

  <part name="SSNMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service searches Voters datafiles.*/

EXPORT VotersSearchService := MACRO

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#stored('ScoreThreshold',10);
	#stored('PenaltThreshold',10);
	// output(VotersV2_Services.VotersSearchService_records, named('Results'));

	recs := VotersV2_Services.VotersSearchService_records;

  Text_Search.MAC_Append_ExternalKey(recs, recs2, intformat(l.vtid,15,1) );

	doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));

ENDMACRO;
