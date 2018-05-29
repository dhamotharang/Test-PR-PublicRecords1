/*--SOAP--
<message name="SearchAlertRequest" wuTimeout="300000">
  <part name="UniqueID"						type="xsd:string"/>
	<part name="Industry"						type="xsd:string"/>
	<part name="Product"						type="xsd:string"/>
	<part name="RetroDate"					type="xsd:string"/>
  <part name="DateRange"					type="xsd:integer"/>
  <part name="IndustryKBA"				type="xsd:boolean"/>
  <part name="Velocity"						type="xsd:boolean"/>
	<part name="GLBPurpose"					type="xsd:byte"/>
  <part name="SearchAlertRequest"	type="tns:XmlDataSet" cols="80" rows="30" />
	<part	name="Gateways"						type="tns:XmlDataSet" cols="80" rows="25"/>
</message>
*/

import	Address,AutoStandardI,Doxie,iesp,ut;

export	Velocity_SearchService	:=
macro
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	#constant('useonlybestdid',true);
	
  rec_in     := iesp.SearchAlert.t_SearchAlertRequest;
	ds_in      := dataset([],rec_in) : STORED('SearchAlertRequest',few);
	gateways := Gateway.Configuration.Get();
	// gateways	 := dataset([],risk_indicators.Layout_Gateways_In) : STORED('Gateways');
	first_row  := ds_in[1] : INDEPENDENT;
  search_by  := global(first_row.searchBy);
  
	// Set options
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	options	:=	global(first_row.options);
	
	// #STORE input search parameters
	iesp.ECL2ESP.SetInputReportBy(project(search_by,transform(iesp.bpsreport.t_BpsReportBy,self	:=	left;self	:=	[])));
	
	// Get the associated industry/product/function counts for the inquiry
	results := inquiry_services.velocity_records(search_by,options,gateways);
	
	output(results,named('Results'));
endmacro;

// Inquiry_Services.Velocity_SearchService();

/*--INFO-- Searches against the Inquiry Velocity Search Service*/
/*--HELP-- 
<pre>
&lt;SearchAlertRequest&gt;
	&lt;Row&gt;
		&lt;User&gt;
			&lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
		&lt;/User&gt;
		&lt;Options&gt;
			&lt;IndustryKBA&gt;&lt;/IndustryKBA&gt;
			&lt;Velocity&gt;&lt;/Velocity&gt;
		&lt;/Options&gt;
		&lt;SearchBy&gt;
			&lt;UniqueID&gt;&lt;/UniqueID&gt;
			&lt;Name&gt;
				&lt;Last&gt;&lt;/Last&gt;
				&lt;First&gt;&lt;/First&gt;
				&lt;Middle&gt;&lt;/Middle&gt;
				&lt;suffix&gt;&lt;/suffix&gt;
				&lt;full&gt;&lt;/full&gt;
			&lt;/Name&gt;    
			&lt;Address&gt;
				&lt;StreetName&gt;&lt;/StreetName&gt;
				&lt;StreetNumber&gt;&lt;/StreetNumber&gt;
				&lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
				&lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
				&lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
				&lt;UnitNumber&gt;&lt;/UnitNumber&gt;
				&lt;StateCityZip&gt;&lt;/StateCityZip&gt;
				&lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
				&lt;City&gt;&lt;/City&gt;
				&lt;State&gt;&lt;/State&gt;
				&lt;Zip5&gt;&lt;/Zip5&gt;
				&lt;County&gt;&lt;/County&gt;
			&lt;/Address&gt;
			&lt;Phone10&gt;&lt;/Phone10&gt;
			&lt;DOB&gt;
				&lt;Year&gt;&lt;/Year&gt;
				&lt;Month&gt;&lt;/Month&gt;
				&lt;Day&gt;&lt;/Day&gt;
			&lt;/DOB&gt;
			&lt;SSN&gt;&lt;/SSN&gt;
			&lt;Industry&gt;&lt;/Industry&gt;
			&lt;Product&gt;&lt;/Product&gt;
			&lt;RetroDate&gt;
				&lt;Year&gt;&lt;/Year&gt;
				&lt;Month&gt;&lt;/Month&gt;
				&lt;Day&gt;&lt;/Day&gt;
			&lt;/RetroDate&gt;
			&lt;DateRange&gt;&lt;/DateRange&gt;
		&lt;/SearchBy&gt;
	&lt;/Row&gt;
&lt;/SearchAlertRequest&gt;
</pre>
*/