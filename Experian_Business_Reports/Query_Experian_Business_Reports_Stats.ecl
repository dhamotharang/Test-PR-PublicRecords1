#workunit('name', 'EBR as bus header test');

a1 := Experian_Business_Reports.EBR_As_Business_Header; 
b1 := Experian_Business_Reports.EBR_As_Business_Contact;

output(a1,,'out::ebr_as_bus_header',overwrite);
output(b1,,'out::ebr_as_bus_contact',overwrite);

output(a1, all);
output(b1, all);

/*
dcaa := dca.File_DCA_all_In;

// Count Unique BDIDs in the Business Header file
layout_dca_slim := record
dcaa.Enterprise_;
end;

dca_slim := table(dcaa, layout_dca_slim);

layout_dca_stat := record
dca_slim.Enterprise_;
cnt := count(group);
end;

dca_stats := table(dca_slim, layout_dca_stat, Enterprise_);

count(dca_stats);  // number of unique bdids
output(dca_stats, all);
*/