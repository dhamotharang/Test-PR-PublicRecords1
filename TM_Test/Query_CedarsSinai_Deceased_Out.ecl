layout_cedars_sinai_temp := record
unsigned4 seq;
TM_Test.Layout_CedarsSinai_Out;
string8  	best_dod;
string182 clean_address;
string3 fips_county;
string18 county_name := '';
end;

// Initialize match data in output format
layout_cedars_sinai_temp FormatOutput(TM_Test.Layout_CedarsSinai_Base l) := transform
self.Address_Block := l.best_addr1;
self.City := l.best_city;
self.State := l.best_state;
self.Zip_Code := l.best_zip + if(l.best_zip4 <> '', '-' + l.best_zip4, '');
self.DPC := '';
self.Country := 'USA';
self.clean_address := addrcleanlib.cleanAddress182(trim(l.best_addr1), trim(l.best_city) + ', ' + trim(l.best_state) + ' ' + trim(l.best_zip));
self.fips_county := self.clean_address[143..145];
self := l;
end;

cs_out_init := project(TM_Test.cedarssinai_match, FormatOutput(left));

Census_Data.MAC_Fips2County(cs_out_init,State,fips_county,county_name,cs_out_county)

// Check for output address in target counties
target_counties := ['LOS ANGELES', 'VENTURA', 'SAN BERNARDINO', 'RIVERSIDE', 'ORANGE'];


layout_cedars_sinai_temp CheckTargetCounty(layout_cedars_sinai_temp l) := transform
self.Address_Block := if(l.county_name in target_counties, l.Address_Block, '');
self.City := if(l.county_name in target_counties, l.City, '');
self.State := if(l.county_name in target_counties, l.State, '');
self.Zip_Code := if(l.county_name in target_counties, l.Zip_Code, '');
self.DPC := if(l.county_name in target_counties, l.DPC, '');
self.Country := if(l.county_name in target_counties, l.Country, '');
self.best_dod := if(l.county_name in target_counties, l.best_dod, '');
self := l;
end;

cs_out_fixed := project(cs_out_county, CheckTargetCounty(left));

count(cs_out_fixed(best_dod <> ''));
output(cs_out_fixed(best_dod <> ''),all);
