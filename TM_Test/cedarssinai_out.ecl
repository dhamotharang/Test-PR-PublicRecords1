import ut, Census_Data;

layout_cedars_sinai_temp := record
unsigned4 seq;
Layout_CedarsSinai_Out;
string182 clean_address;
string3 fips_county;
string18 county_name := '';
end;

// Initialize match data in output format
layout_cedars_sinai_temp FormatOutput(Layout_CedarsSinai_Base l) := transform
self.Address_Block := l.best_addr1;
self.City := l.best_city;
self.State := l.best_state;
self.Zip_Code := l.best_zip + if(l.best_zip4 <> '', '-' + l.best_zip4, '');
self.DPC := '';
self.Country := 'USA';
self.phone := l.best_phone;
self.DOD_Year := l.best_dod[1..4];
self.clean_address := addrcleanlib.cleanAddress182(trim(l.best_addr1), trim(l.best_city) + ', ' + trim(l.best_state) + ' ' + trim(l.best_zip));
self.fips_county := self.clean_address[143..145];
self := l;
end;

//cs_match :=TM_Test.cedarssinai_match;
cs_match := dataset('TMTEST::cedars_sinai_match', Layout_CedarsSinai_Base, flat);

cs_out_init := project(cs_match, FormatOutput(left));

Census_Data.MAC_Fips2County(cs_out_init,State,fips_county,county_name,cs_out_county)

// Check for output address in target counties
target_counties := ['LOS ANGELES', 'VENTURA', 'SAN BERNARDINO', 'RIVERSIDE', 'ORANGE'];

layout_cedars_sinai_out_seq := record
unsigned4 seq;
Layout_CedarsSinai_Out;
end;

layout_cedars_sinai_out_seq CheckTargetCounty(layout_cedars_sinai_temp l) := transform
self.Address_Block := if(l.county_name in target_counties, l.Address_Block, '');
self.City := if(l.county_name in target_counties, l.City, '');
self.State := if(l.county_name in target_counties, l.State, '');
self.Zip_Code := if(l.county_name in target_counties, l.Zip_Code, '');
self.DPC := if(l.county_name in target_counties, l.DPC, '');
self.Country := if(l.county_name in target_counties, l.Country, '');
self.Phone := if(l.county_name in target_counties, l.Phone, '');
self.DOD_Year := if(l.county_name in target_counties, l.DOD_Year, '');
self := l;
end;

cs_out_fixed := project(cs_out_county, CheckTargetCounty(left));

// combine with original input
layout_cedars_sinai_seq := record
unsigned4 seq := 0;
layout_cedarssinai_in;
end;

cedars_sinai_seq := dataset('TMTEST::cedars_sinai_seq', layout_cedars_sinai_seq, flat);

cedars_sinai_seq_home := cedars_sinai_seq((Stringlib.StringToUpperCase(CnAdrAll_1_01_Type)='HOME'));

cedars_sinai_seq_home_out := project(cedars_sinai_seq_home,
                                     transform(layout_cedars_sinai_out_seq, self := left));
							  
cedars_sinai_out_combined := project(sort(cs_out_fixed + cedars_sinai_seq_home_out, seq),
                             transform(Layout_CedarsSinai_Out, self := left));

export cedarssinai_out := cedars_sinai_out_combined : persist('TMTEST::cedars_sinai_out');