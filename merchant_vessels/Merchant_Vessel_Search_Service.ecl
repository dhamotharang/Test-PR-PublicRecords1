/*--SOAP--
<message name = 'MerchantVesselSearchService'>
	<part name = 'FirstName'			type = 'xsd:string'/>
	<part name = 'MiddleName'		type = 'xsd:string'/>
	<part name = 'LastName'			type = 'xsd:string'/>
	<part name = 'AllowNicknames'		type = 'xsd:boolean'/>
	<part name = 'PhoneticMatches'	type = 'xsd:boolean'/>
	<part name = 'CompanyName'		type = 'xsd:string'/>
	<part name = 'Addr'				type = 'xsd:string'/>
	<part name = 'City'				type = 'xsd:string'/>
	<part name = 'State'			type = 'xsd:string'/>
	<part name = 'Zip'				type = 'xsd:string'/>
	<part name = 'HullId'			type = 'xsd:string'/>
	<part name = 'VesselName'		type = 'xsd:string'/>
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
	<part name = 'MaxResults'		type = 'xsd:unsignedInt'/>
	<part name = 'MaxResultsThisTime'	type = 'xsd:unsignedInt'/>
	<part name = 'SkipRecords'		type = 'xsd:unsignedInt'/>
</message>
*/
/*--INFO-- This service searches the Merchant Vessels File. */

import doxie;

export Merchant_Vessel_Search_Service() := macro

doxie.MAC_Header_Field_Declare();

outf0 := merchant_vessels.Merchant_Vessel_Records;

doxie.MAC_Marshall_Results(outf0,outf1);

PrettyLayout := record
	outf1.fname;
	outf1.mname;
	outf1.lname;
	outf1.compname;
	outf1.name_of_vessel;
	outf1.hull_number;
	outf1.date_last_seen;
	outf1.prim_range;
	outf1.predir;
	outf1.prim_name;
	outf1.suffix;
	outf1.postdir;
	outf1.unit_desig;
	outf1.sec_range;
	outf1.p_city_name;
	outf1.st;
	outf1.zip;
	outf1.zip4;
end;

outf2 := table(outf1,prettylayout);

output(choosen(outf2,all),named('RESULTS'));

endmacro;