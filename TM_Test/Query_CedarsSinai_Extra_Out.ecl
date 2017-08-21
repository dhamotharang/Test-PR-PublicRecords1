import ut, Census_Data;

layout_cedars_sinai_temp := record
unsigned4 seq;
TM_Test.Layout_CedarsSinai_Out;
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
self.phone := l.best_phone;
self.DOD_Year := l.best_dod[1..4];
self.clean_address := addrcleanlib.cleanAddress182(trim(l.best_addr1), trim(l.best_city) + ', ' + trim(l.best_state) + ' ' + trim(l.best_zip));
self.fips_county := self.clean_address[143..145];
self := l;
end;

//cs_match :=TM_Test.cedarssinai_match;
cs_match := dataset('TMTEST::cedars_sinai_match', TM_Test.Layout_CedarsSinai_Base, flat);

cs_out_init := project(cs_match, FormatOutput(left));

Census_Data.MAC_Fips2County(cs_out_init,State,fips_county,county_name,cs_out_county)

// Check for output address in target counties
target_counties := ['LOS ANGELES', 'VENTURA', 'SAN BERNARDINO', 'RIVERSIDE', 'ORANGE'];


cedars_sinai_out_extra := project(sort(cs_out_county(Address_Block <> '', not (State = 'CA' and county_name in target_counties)), seq),
                             transform(TM_Test.Layout_CedarsSinai_Out, self := left));

count(cedars_sinai_out_extra);				    
output(cedars_sinai_out_extra, all);

output(cedars_sinai_out_extra,,'OUT::CedarsSinai_Extra_CSV',csv(
heading(
'CnBio_System_ID, CnBio_Import_ID, CnBio_ID, CnBio_Title_1, CnBio_First_Name,' +
'CnBio_Middle_Name, CnBio_Last_Name, CnAdrAll_1_01_Addrline1, CnAdrAll_1_01_Addrline2,' +
'CnAdrAll_1_01_Addrline3, CnAdrAll_1_01_City, CnAdrAll_1_01_State, CnAdrAll_1_01_ZIP,' +
'CnAdrAll_1_01_Type, CnAdrAll_1_01_CntryShrtDscriptin, Address_Block, City,' +
'State, Zip_Code, DPC, Country, Phone, DOD_Year\n',single),
separator(','),
terminator('\n'),
quote('"')),overwrite);

