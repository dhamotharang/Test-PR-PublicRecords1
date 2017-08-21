

export proc_build_vendor_stats_aoc(string8 vdate) := function

import ut;
import crim_common;

ds_off			:= file_offender_aoc(data_type = '2') ;
ds_crt_off	:= file_Court_Offenses_aoc;

ds_all_record := record
string8 version_date := vdate;
string2 vendor := ds_off.vendor;
string1 data_type := ds_off.data_type;
unsigned4 total_off_records := count(group);
unsigned4 total_crt_off_records := 0;
end;
stat_ds_off := table(ds_off,ds_all_record,vendor,data_type,few);

ds_crt_off_record := record
string2 vendor := ds_crt_off.vendor;
unsigned4 total_crt_off_records := count(group);
end;
stat_ds_crt_off := table(ds_crt_off,ds_crt_off_record,vendor,few);

ds_all_record to_join1(stat_ds_off l, stat_ds_crt_off r) := transform
self.vendor  := l.vendor;
self.total_crt_off_records := r.total_crt_off_records;
self := l;
end;
ds_join1 := join(stat_ds_off,stat_ds_crt_off,left.vendor=right.vendor,to_join1(left,right),left outer);

ut.MAC_SF_BuildProcess(ds_join1,'~thor_data400::base::crim_vendor_stats_aoc',step1,3);

return step1;
end;





