#workunit('name', 'EBR as bus header test');

a1 := Experian_Business_Reports.EBR_As_Business_Header; 
b1 := Experian_Business_Reports.EBR_As_Business_Contact;

output(a1,,'out::ebr_as_bus_header',overwrite);
output(b1,,'out::ebr_as_bus_contact',overwrite);
