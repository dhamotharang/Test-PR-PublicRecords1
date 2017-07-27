/*--SOAP--
<message name="VendorSrc_Lookup_Service">
	<part name="source" type="xsd:string"/>
	<part name="file_id" type="xsd:string"/>
 </message>
*/

export VendorSrc_Lookup_Service := MACRO

string input_Source := ''   : stored('Source');
string file_id := ''   : stored('file_id');

Results1 := choosen(Misc.Key_VendorSrc().Vendor_Source(keyed(source_code=stringlib.stringtouppercase(trim(input_source)))), 10);

filtered_results := results1(input_file_id=stringlib.stringtouppercase(trim(file_id)));

Results := choosen(if(file_id='', results1, filtered_results), 1);
			
output(Results, named('Results'));

ENDMACRO;

 // misc.VendorSrc_Lookup_Service();