//f := TM_Test.cedarssinai_out;
f := dataset('TMTEST::cedars_sinai_out', TM_Test.Layout_CedarsSinai_Out, flat);

output(f,,'OUT::CedarsSinai_CSV',csv(
heading(
'CnBio_System_ID, CnBio_Import_ID, CnBio_ID, CnBio_Title_1, CnBio_First_Name,' +
'CnBio_Middle_Name, CnBio_Last_Name, CnAdrAll_1_01_Addrline1, CnAdrAll_1_01_Addrline2,' +
'CnAdrAll_1_01_Addrline3, CnAdrAll_1_01_City, CnAdrAll_1_01_State, CnAdrAll_1_01_ZIP,' +
'CnAdrAll_1_01_Type, CnAdrAll_1_01_CntryShrtDscriptin, Address_Block, City,' +
'State, Zip_Code, DPC, Country, Phone, DOD_Year\n',single),
separator(','),
terminator('\n'),
quote('"')),overwrite);
