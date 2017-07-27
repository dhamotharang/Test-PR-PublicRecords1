/*--SOAP--
<message name="SearchService">
	<!-- XML INPUT -->
	<part name="ResidentialQualitySearchRequest" 		type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="_TransactionId" 										type="xsd:string"/>
	</message>
*/

/*--HELP--
AddressNeighborhood Request XML:
<pre>
&lt;Dataset&gt;
&lt;Row&gt;
	 &lt;options&gt;
	 &lt;/options&gt;
   &lt;SearchBy&gt;
      &lt;address&gt;
	      &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
	      &lt;unitnumber&gt;&lt;/unitnumber&gt;
	      &lt;city&gt;&lt;/city&gt;
	      &lt;state&gt;&lt;/state&gt;
	      &lt;zip5&gt;&lt;/zip5&gt;
	      &lt;zip4&gt;&lt;/zip4&gt;
      &lt;/address&gt;
   &lt;/SearchBy&gt;
&lt;/Row&gt;
&lt;/Dataset&gt;
</pre>
*/

import Address_Attributes, iesp;

export Residential_Search_Service := macro

	// Get XML input 
	ds_xml := DATASET ([], iesp.Residential_Quality.t_ResidentialQualitySearchRequest)	: STORED ('ResidentialQualitySearchRequest', FEW);
	string    trans_id := '' : stored('_TransactionId');

	ds_in := ds_xml[1];
	
	street_address := ds_in.SearchBy.Address.StreetAddress1;
	apt 					 := ds_in.SearchBy.Address.UnitNumber;
	city 					 := ds_in.SearchBy.Address.city;
	state  				 := ds_in.SearchBy.Address.state;
	zip 					 := ds_in.SearchBy.Address.zip5;
	zip4 					 := ds_in.SearchBy.Address.zip4;
	
	report_data_in := dataset([{street_address, apt, city, state, zip, zip4}], Address_Attributes.Layouts.address_in);

	// Get Data
	results := address_attributes.get_ResidentialSearch(report_data_in);

	output(results, named('results'));

ENDMACRO;

// Address_Attributes.Residential_Search_Service();

// For testing/debugging in a web form xml text area
/*
<Dataset>
<Row>
	 <options>
			<ReturnCount></ReturnCount>
			<ReturnType></ReturnType>
			<SurroundingPropertyCount></SurroundingPropertyCount>
			<GeoRadiusMiles></GeoRadiusMiles>
	 </options>
   <searchby>
      <address>
	      <streetaddress1>420 MONARCH CIR</streetaddress1>
	      <streetaddress2></streetaddress2>
	      <city>ROCK SPRINGS</city>
	      <state>WY</state>
	      <zip5>82901</zip5>
	      <zip4></zip4>
      </address>
   </searchby>
</Row>
</Dataset>
*/

