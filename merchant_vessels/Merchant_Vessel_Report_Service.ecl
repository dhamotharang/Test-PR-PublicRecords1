/*--SOAP--
<message name = 'MerchantVesselReportService'>
	<part name = 'HullId' 		type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
	<part name = 'MaxResults'	type = 'xsd:unsignedInt'/>
	<part name = 'MaxResultsThisTime'	type = 'xsd:unsignedInt'/>
	<part name = 'SkipRecords'	type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service reports on the Merchant Vessels File. */

import doxie;

export Merchant_Vessel_Report_Service() := macro

doxie.MAC_Header_Field_Declare();

df := merchant_vessels.Merchant_Vessel_Records;

doxie.MAC_Marshall_Results(df,outf);

output(choosen(outf,all),named('RESULTS'));

endmacro;
