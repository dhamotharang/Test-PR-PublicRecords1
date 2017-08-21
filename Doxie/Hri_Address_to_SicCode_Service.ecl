/*--SOAP--
<message name="HriAddressToSiccodeRequest" fast_display = "true">
  <part name="AddressLine1" type="xsd:string"/>
  <part name="AddressLine2" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
</message>
*/
/*--INFO-- This service searches the sic_code description of a given address.*/
/*--RESULT-- xslt.html */

/*
<message name="HriAddressToSiccodeService" wuTimeout="300000">
*/

import risk_indicators, address, codes;

export hri_address_to_siccode_service := macro

string120 addr1_val := '' : stored('AddressLine1');
string120 addr2_val := '' : stored('AddressLine2');
string25 city_val := '' : stored('City');
string2 st_val := '' : stored('State');
string5 zip_val := '' : stored('Zip');

Address.Layout_Batch_In setupAddr() := transform
  self.uid := 0;
  self.addr1 := addr1_val;
  self.addr2 := addr2_val;
  self.city_name := city_val;
  self.st := st_val;
  self.zip := zip_val;
end;

addr_in := dataset([setupAddr()]);

cleaned := Address.fn_AddressCleanBatch(addr_in);

slim_addr_rec := record
	string5  z5,
  string28 prim_name,
  string4  suffix, 
  string2  predir,
  string2  postdir,
  string10 prim_range,
  string8  sec_range,
  string4  sic_code_internal := '',
  string12  sic_code_general := '',
	string150 sic_code_description := '',
end;

slim_addr_rec parse_slim_addr(cleaned le) := transform
  self.z5 := le.zip;
  self.suffix := le.addr_suffix;
	self := le;
end;

slim_recs := project(cleaned, parse_slim_addr(left));

A2S_key := risk_indicators.Key_HRI_Address_To_Sic;

slim_addr_rec get_sic_code(A2S_key r) := transform
     self.sic_code_internal := r.sic_code;
     self.sic_code_general :=  map( r.sic_code =  '2330' => '0971',
						      r.sic_code =  '2335' => '2710 or 2711',
						      r.sic_code =  '2265' => '4311', 
						      r.sic_code =  '2325' => '4449',
						      r.sic_code =  '2310' => '4783',
						      r.sic_code =  '2300' => '4822',
						      r.sic_code =  '2285' => '6515',
						      r.sic_code =  '2210' => '7011',
						      r.sic_code =  '2230' => '7021',
						      r.sic_code =  '2290' => '7032',
						      r.sic_code =  '2215' => '7033',
						      r.sic_code =  '2340' => '7291',
						      r.sic_code =  '2305' => '7323',
						      r.sic_code =  '2220' => '7331',
						      r.sic_code =  '2280' => '7334',
						      r.sic_code =  '2320' => '7389',
						      r.sic_code =  '2275' => '8051',
						      r.sic_code =  '2260' => '8062',
						      r.sic_code =  '2315' => '8063',
						      r.sic_code =  '2345' => '8211',
						      r.sic_code =  '2270' => '8221',
						      r.sic_code =  '2350' => '8222',
						      r.sic_code =  '2355' => '8231',
						      r.sic_code =  '2225' => '9223',
						      r.sic_code =  '2295' => '9711',
						      '');

	self.sic_code_description := codes.VARIOUS_HRI_FILES.HRI_CODE(r.sic_code);
	self := r;
end;

final_recs := join(slim_recs,A2S_key,
                   left.z5=right.z5 and 
                   left.prim_name=right.prim_name and                     
                   left.suffix=right.suffix and
                   left.predir=right.predir and
                   left.postdir=right.postdir and
                   left.prim_range=right.prim_range and     
			    ut.nneq(left.sec_range,right.sec_range), 
   	              get_sic_code(right));

final_sort := sort(final_recs,record);
final_dedup := dedup(final_sort,record);

output(final_dedup);

endmacro;