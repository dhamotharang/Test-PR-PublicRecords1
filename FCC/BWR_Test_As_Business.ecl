#workunit('name', 'FCC as bus header test');

a1 := fcc.fFCC_Licenses_As_Business_Header	(FCC.File_FCC_base); 
b1 := fcc.fFCC_licenses_As_Business_Contact	(FCC.File_FCC_base);

output(enth(a1, 10000), named('FccAsBusinessHeaderSample'	),all);
output(enth(b1, 10000), named('FccAsBusinessContactSample'	),all);
