
import LiensV2, address;

liensv2.layout_liens_main_temp tmakemain(liensV2.Layout_liens_DID L) := transform

self := L;

end;

IL_main_temp := project(LiensV2.ILFederal_DID, tmakemain(left));

IL_main_temp_sort  := sort(IL_main_temp, tmsid, rmsid, -process_date);
IL_main_temp_dedup := dedup(IL_main_temp_sort, except process_date);

liensv2.Layout_liens_main_module.layout_liens_main tmakefatrecord(IL_main_temp L) := transform

self.filing_status := row(L,liensv2.Layout_liens_main_module.layout_filing_status);
self := L;

end;

file_fat := project(IL_main_temp_dedup, tmakefatrecord(left));

liensv2.Layout_liens_main_module.layout_liens_main tmakechildren(liensv2.Layout_liens_main_module.layout_liens_main L, liensv2.Layout_liens_main_module.layout_liens_main R) := transform

self.filing_status := L.filing_status + row({r.filing_status[1].filing_status, r.filing_status[1].filing_status_desc},liensv2.Layout_liens_main_module.layout_filing_status);
self := L;
end;

IL_main_out := rollup(file_fat,rmsid,tmakechildren(left, right));

export mapping_ILFDLN_main:= IL_main_out ;





