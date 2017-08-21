export File_TexasDeath_Data := Module

import ut;

export File_TexasDeath_Base := dataset(ut.foreign_dataland+'~thor_data200::in::texasdeathdata::20090807',
																											Layout_TexasDeath_Data, thor);
fips_rec := record
 string2  state_alpha;
 string2  state_code;
 string3  county_code;
 string40 county_alpha;
 string2  class;
 string1  crlf;
end;

fips_data_county_name := dataset(ut.foreign_prod+'thor_data400::in::fips_code_lookup',fips_rec,flat);
Export TX_fips := fips_data_county_name(state_alpha='TX');

shared newlayout := Record
Recordof(File_TexasDeath_Base);
string3  FipsCounty;
string2  state_code;
End;

shared newlayout tnewFile(File_TexasDeath_Base L, TX_fips R):= Transform
Self.State_Code := r.state_code;
Self.FipsCounty := if(L.County = R.county_alpha, R.county_code,'');
Self := L;
end;

Export	 File_TexasDeath_Base_FIPScode := join(File_TexasDeath_Base, TX_fips,  
                      left.County = right.county_alpha, tnewFile(left,right),
											left outer,lookup);		

End;//Module																											