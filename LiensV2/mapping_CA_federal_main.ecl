import LiensV2, address;

liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_liens_DID L) := transform

self := L;

end;

CA_federal_main_temp := project(liensV2.CA_federal_DID, tmakemain(left));
CA_federal_main_temp_sort  := sort(CA_federal_main_temp, tmsid, rmsid, -process_date, -orig_filing_date, -filing_date);
CA_federal_main_temp_dedup := dedup(CA_federal_main_temp_sort, except process_date);

liensv2.Layout_liens_main_module.layout_liens_main tmakefatrecord(CA_federal_main_temp L) := transform

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;

file_fat := project(CA_federal_main_temp_dedup, tmakefatrecord(left));

liensv2.Layout_liens_main_module.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module.layout_liens_main L, liensv2.Layout_liens_main_module.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module.layout_filing_status);
self := L;
end;

CA_federal_main_out := rollup(file_fat,rmsid,tmakechildren(left, right));

export mapping_CA_federal_main:= CA_federal_main_out;

