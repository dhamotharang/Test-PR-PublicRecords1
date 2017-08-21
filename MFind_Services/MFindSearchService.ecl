/*--SOAP--
<message name="MFindSearch" wuTimeout="300000">
	<part name = 'DID'			type = 'xsd:string'/>
	<part name="VID" type="xsd:string" />
  <part name="UnParsedFullName" 	type="xsd:string"/>	
	<part name="FirstName" type='xsd:string' />
	<part name="MiddleName" type='xsd:string' />
	<part name="LastName" type = 'xsd:string' />
	<part name="AllowNicknames" type='xsd:boolean' />
	<part name="PhoneticMatch" type='xsd:boolean' />
	<part name="MilitaryBranch" type='xsd:string' />
	<part name="Gender" type='xsd:string' />
	<part name="Addr" type='xsd:string' />
	<part name="City" type="xsd:string" />
	<part name="State" type='xsd:string' />
	<part name="Zip" 	type = 'xsd:string' />
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="Phone" 	type = 'xsd:string' />
  <part name="NoDeepDive" type="xsd:boolean"/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
	<part name="MaxResults"  type = 'xsd:unsignedInt' />
	<part name="MaxResultsThisTime" type = 'xsd:unsignedInt' />
	<part name="SkipRecords" type = 'xsd:unsignedInt' />
</message>
*/
/*--INFO-- This service searches all Mfind datafiles.*/

export MFindSearchService := macro

output(MFind_services.MFindSearch, named('Results'));

endmacro;
