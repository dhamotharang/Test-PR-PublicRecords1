f := Business_Header.File_Business_Contacts;

// Find contacts from D&B
layout_contact_slim := record
f.bdid;
f.did;
f.vendor_id;
f.record_type;
end;

dnb_contacts_slim := table(f(from_hdr = 'N', source = 'D'), layout_contact_slim);

// Stats with non-zero DID
layout_dnb_counts := record
Total_Records := count(group);
Total_Active_Duns := count(group, dnb_contacts_slim.vendor_id[1]<>'D');
Total_Active_Duns_Current := count(group, dnb_contacts_slim.vendor_id[1]<>'D' and dnb_contacts_slim.record_type='C');
Total_Active_Duns_Historical := count(group, dnb_contacts_slim.vendor_id[1]<>'D' and dnb_contacts_slim.record_type='H');
Total_Inactive_Duns := count(group, dnb_contacts_slim.vendor_id[1]='D');
Total_Inactive_Duns_Current := count(group, dnb_contacts_slim.vendor_id[1]='D' and dnb_contacts_slim.record_type='C');
Total_Inactive_Duns_Historical := count(group, dnb_contacts_slim.vendor_id[1]='D' and dnb_contacts_slim.record_type='H');
end;

dnb_counts := table(dnb_contacts_slim, layout_dnb_counts);

output(dnb_counts, named('DNB_Contacts_Base_Counts'));

dnb_contacts_slim_dedup_active := dedup(dnb_contacts_slim(did <> 0, vendor_id[1]<>'D', record_type='C'), bdid, did, all); // total unique active

// DNB file
dbf := DNB.File_DNB_Contacts_Base;

layout_dnb_contact_slim := record
dbf.did;
dbf.bdid;
dbf.record_type;
dbf.active_duns_number;
end;

dbf_slim := table(dbf(did <> 0, active_duns_number='Y', record_type = 'H'), layout_dnb_contact_slim);
dbf_slim_dedup := dedup(dbf_slim, bdid, did, all);

dnb_contacts_active := join(dnb_contacts_slim_dedup_active,
					   dbf_slim_dedup,
					   left.bdid = right.bdid and
					     left.did = right.did,
					   left only,
					   hash);
					   

dnb_contacts_active_dedup := dedup(dnb_contacts_active, did, all);


output(count(dnb_contacts_active_dedup), named('Unique_Active_Current_with_ADL'));
