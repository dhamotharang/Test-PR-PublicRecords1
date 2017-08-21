//#workunit ('name', 'Query DNB Contacts Stats with ADL ' + dnb.version);
dnb_contacts := DNB.File_DNB_Contacts_Base;

layout_dnb_contacts_slim := record
dnb_contacts.bdid;
dnb_contacts.did;
dnb_contacts.duns_number;
dnb_contacts.active_duns_number;
dnb_contacts.record_type;
end;

dnb_contacts_slim := table(dnb_contacts(did <> 0), layout_dnb_contacts_slim);

// Stats with non-zero DID
layout_dnb_counts := record
Total_Records := count(group);
Total_Active_Duns := count(group, dnb_contacts_slim.active_duns_number='Y');
Total_Active_Duns_Current := count(group, dnb_contacts_slim.active_duns_number='Y' and dnb_contacts_slim.record_type='C');
Total_Active_Duns_Historical := count(group, dnb_contacts_slim.active_duns_number='Y' and dnb_contacts_slim.record_type='H');
Total_Inactive_Duns := count(group, dnb_contacts_slim.active_duns_number='N');
Total_Inactive_Duns_Current := count(group, dnb_contacts_slim.active_duns_number='N' and dnb_contacts_slim.record_type='C');
Total_Inactive_Duns_Historical := count(group, dnb_contacts_slim.active_duns_number='N' and dnb_contacts_slim.record_type='H');
end;

dnb_counts := table(dnb_contacts_slim, layout_dnb_counts);

do1 := output(dnb_counts, named('DNB_Contacts_Base_Counts'));

dnb_contacts_slim_dedup_active := dedup(dnb_contacts_slim(active_duns_number='Y', record_type='C'), did, all); // total unique active

do2 := output(count(dnb_contacts_slim_dedup_active), named('Unique_Active_Current_with_ADL'));

export Query_DNB_Contact_Counts_with_ADL := parallel(do1, do2);

