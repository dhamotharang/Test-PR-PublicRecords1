import ut;

business_header.doxie_MAC_Field_Declare();

typeof(business_header.File_Business_Header_Plus) xt(business_header.file_business_header_plus L) := transform	
	self := L;
end;

string28		 pnv := pname_value 	: global;
string10		 prv := prange_value 	: global;
string8		 srv := sec_range_value  : global;
string2		 stv := state_value 	: global;
set of integer4 zpv := if (zip_val != '', if (mile_radius_value = 0, 
										[(integer4)zip_val],
										ziplib.zipswithinradius(zip_val,mile_radius_value)),
								  if (city_zip_value = '', 
										[], 
										ziplib.zipswithinradius(city_zip_value,if (mile_radius_value = 0, 5, mile_radius_value)))) : global;

outf := fetch(business_header.file_business_header_plus, business_header.Key_Business_Header_Address(keyed(pn = pnv) and
											 keyed(st = stv) and
											 keyed(prv = '' or pr = prv) and
											 keyed(zpv = [] or zip in zpv) and
											 keyed(srv = '' or sr = srv)),
											 right.__filepos,xt(LEFT));
											 
											 

export Fetch_By_Addr := outf;
