
export layout_vendor_stats_doc := record
string8 version_date;
string2 vendor;
string1 data_type;
unsigned4 total_off_records := 0;
unsigned4 total_crm_off_records := 0;
unsigned4 total_crm_pun_records := 0;
end;