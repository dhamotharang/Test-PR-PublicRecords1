#workunit('name', 'FCC as bus header test');

a1 := fcc.FCC_Licenses_As_Business_Header; 
b1 := fcc.FCC_licenses_As_Business_Contact;

output(a1,,'out::fcc_as_bus_header',overwrite);
output(enth(a1, 10000), all);
output(b1,,'out::fcc_as_bus_contact',overwrite);
output(enth(b1, 10000), all);
