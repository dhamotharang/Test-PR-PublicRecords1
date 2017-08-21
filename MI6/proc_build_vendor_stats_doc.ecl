

export proc_build_vendor_stats_doc(string8 vdate) := function

import ut;
import crim_common;

ds_off			:= file_offender_doc(data_type = '1') ;
ds_crm_off	:= file_crim_offenses_doc;
ds_crm_pun  := file_crim_punishment_doc;

ds_all_record := record
string8 version_date := vdate;
string2 vendor := ds_off.vendor;
string1 data_type := ds_off.data_type;
unsigned4 total_off_records := count(group);
unsigned4 total_crm_off_records := 0;
unsigned4 total_crm_pun_records := 0;
end;
stat_ds_off := table(ds_off,ds_all_record,vendor,data_type,few);

ds_crm_off_record := record
string2 vendor := ds_crm_off.vendor;
unsigned4 total_crm_off_records := count(group);
end;
stat_ds_crm_off := table(ds_crm_off,ds_crm_off_record,vendor,few);

////////
ds_crm_pun_record := record
string2 vendor := ds_crm_pun.vendor;
unsigned4 total_crm_pun_records := count(group);
end;
stat_ds_crm_pun := table(ds_crm_pun,ds_crm_pun_record,vendor,few);
////////

ds_all_record to_join1(stat_ds_off l, stat_ds_crm_off r) := transform
self.vendor  := l.vendor;
self.total_crm_off_records := r.total_crm_off_records;
self := l;
end;
ds_join1 := join(stat_ds_off,stat_ds_crm_off,left.vendor=right.vendor,to_join1(left,right),left outer);

//////
ds_all_record to_join2(ds_join1 l, stat_ds_crm_pun r) := transform
self.vendor  := l.vendor;
self.total_crm_pun_records := r.total_crm_pun_records;
self := l;
end;
ds_join2 := join(ds_join1,stat_ds_crm_pun,left.vendor=right.vendor,to_join2(left,right),left outer);
//////

ut.MAC_SF_BuildProcess(ds_join2,'~thor_data400::base::crim_vendor_stats_doc',step1,3);

return step1;
end;





