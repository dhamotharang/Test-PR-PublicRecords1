
import LiensV2, address;

liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_liens_DID L) := transform

self := L;

end;

SA_main_temp := project(LiensV2.Service_Abstract_DID, tmakemain(left));

SA_main_temp_sort  := sort(SA_main_temp, tmsid, rmsid, -process_date);
SA_main_temp_dedup := dedup(SA_main_temp_sort, except process_date);

liensv2.Layout_liens_main_module.layout_liens_main tmakefatrecord(SA_main_temp L) := transform

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;

file_fat := project(SA_main_temp_dedup, tmakefatrecord(left));

liensv2.Layout_liens_main_module.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module.layout_liens_main L, liensv2.Layout_liens_main_module.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module.layout_filing_status);
self := L;
end;

SA_main_out := rollup(file_fat,rmsid,tmakechildren(left, right));

export mapping_Service_Abstract_main:= SA_main_out;






