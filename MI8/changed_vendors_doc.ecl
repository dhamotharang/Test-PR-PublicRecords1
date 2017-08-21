
import crim_cp_ln;

current_lfn := fileservices.GetSuperFileSubName('~thor_data400::base::crim_vendor_stats_doc',1);
father_lfn  := fileservices.GetSuperFileSubName('~thor_data400::base::crim_vendor_stats_doc_father',1);
lfn_index := StringLib.StringFind(current_lfn,'stats_doc',1)+5;

current_stats := file_vendor_stats_doc;
father_stats  := file_vendor_stats_father_doc;

string8 current_version_date := current_stats[1].version_date;
string8 father_version_date := father_stats[1].version_date;

layout_vendor_stats_doc to_delta(current_stats l, father_stats r) := transform
self := l;
end;
delta_stats := join(current_stats,father_stats,
									left.data_type=right.data_type and 
									left.vendor=right.vendor and 
									left.total_off_records=right.total_off_records and
									left.total_crm_off_records=right.total_crm_off_records and
									left.total_crm_pun_records=right.total_crm_pun_records,left only);
									
results := sort(delta_stats,data_type,vendor);
											
output(current_lfn[lfn_index..(lfn_index+30)],named('Current_stats_wuid_doc'));
output(current_version_date,named('Current_version_date_doc'));
output( father_lfn[lfn_index..(lfn_index+30)],named('Father_stats_wuid_doc'));
output( father_version_date,named('Father_version_date_doc'));
output( choosen(results,1000),named('Changed_vendors_doc'));

export changed_vendors_doc := results : persist('~thor_data400::persist::crim_changed_vendors_for_cp_doc');
