IMPORT doxie,ut,Inquiry_AccLogs,Data_Services;

// t:=table(INQL_v2.File_MBS.FILE(opt_out='1'),{company_id,gc_id,mbs_company_name});
// d:= dedup(distribute(t,hash(company_id,gc_id,mbs_company_name)),all);

key_layout := RECORD
unsigned8 company_id;
string gc_id;
string mbs_company_name;
unsigned8 __internal_fpos__;
END;

d := dataset([], key_layout);

export key_lookup_company_optout := INDEX(d, {(unsigned8)company_id}, {d}, 
Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table::lookup_company_optout_' + doxie.Version_SuperKey);
