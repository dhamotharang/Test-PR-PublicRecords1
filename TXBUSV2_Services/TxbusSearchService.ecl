/*--SOAP--
<message name="TxbusSearch" wuTimeout="300000">
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
  <part name="UnParsedFullName" 	type="xsd:string"/>	
	<part name="FirstName" type='xsd:string' />
	<part name="MiddleName" type='xsd:string' />
	<part name="LastName" type = 'xsd:string' />
	<part name="AllowNicknames" type='xsd:boolean' />
	<part name="PhoneticMatch" type='xsd:boolean' />
	<part name="CompanyName" type='xsd:string' />
	<part name="TaxPayerNumber" type='xsd:string' />
	<part name="Addr" type='xsd:string' />
	<part name="City" type="xsd:string" />
	<part name="State" type='xsd:string' />
	<part name="Zip" 	type = 'xsd:string' />
  <part name="County" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="Phone" 	type = 'xsd:string' />
  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="RecordByDate" type="xsd:string"/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
	<part name="MaxResults"  type = 'xsd:unsignedInt' />
	<part name="MaxResultsThisTime" type = 'xsd:unsignedInt' />
	<part name="SkipRecords" type = 'xsd:unsignedInt' />
</message>
*/
/*--INFO-- This service searches all Txbus datafiles.*/

export TxbusSearchService := macro
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#constant('getBdidsbyExecutive',FALSE)
	#constant('SearchIgnoresAddressOnly',true)

	business_header.doxie_MAC_Field_Declare()

	params := module(TxbusV2_services.Interfaces.search_params)
	 export boolean is_search := bdid_value = 0 and did_value = '' and taxpayer_number = '';
	END;

	// output(TxbusV2_services.TxBusSearch(params), named('Results'));

	recs := TxbusV2_services.TxBusSearch(params);
	
  Text_Search.MAC_Append_ExternalKey(recs, recs2, l.taxpayer_number);
	
	doxie.MAC_Marshall_Results(recs2, recs_marshalled);

	OUTPUT(recs_marshalled, NAMED('Results'));


endmacro;
