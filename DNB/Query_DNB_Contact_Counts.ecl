//#workunit ('name', 'Query DNB Contacts Stats ' + dnb.version);
dnb_companies := DNB.File_DNB_Contacts_Base;

layout_dnb_companies_slim := record
dnb_companies.duns_number;
dnb_companies.active_duns_number;
dnb_companies.record_type;
end;

dnb_companies_slim := table(dnb_companies, layout_dnb_companies_slim);

layout_dnb_counts := record
Total_Records := count(group);
Total_Active_Duns := count(group, dnb_companies_slim.active_duns_number='Y');
Total_Active_Duns_Current := count(group, dnb_companies_slim.active_duns_number='Y' and dnb_companies_slim.record_type='C');
Total_Active_Duns_Historical := count(group, dnb_companies_slim.active_duns_number='Y' and dnb_companies_slim.record_type='H');
Total_Inactive_Duns := count(group, dnb_companies_slim.active_duns_number='N');
Total_Inactive_Duns_Current := count(group, dnb_companies_slim.active_duns_number='N' and dnb_companies_slim.record_type='C');
Total_Inactive_Duns_Historical := count(group, dnb_companies_slim.active_duns_number='N' and dnb_companies_slim.record_type='H');
end;

dnb_counts := table(dnb_companies_slim, layout_dnb_counts);

do1 := output(dnb_counts, named('DNB_Contacts_Base_Counts'));

dnb_companies_slim_dedup_active := dedup(dnb_companies_slim(active_duns_number='Y'), duns_number); // total unique active
dnb_companies_slim_dedup_inactive := dedup(dnb_companies_slim(active_duns_number='N'), duns_number); // total unique inactive

do2 := output(count(dnb_companies_slim_dedup_active), named('Unique_Active_Duns_Numbers_Contacts'));
do3 := output(count(dnb_companies_slim_dedup_inactive), named('Unique_Inactive_Duns_Numbers_Contacts'));

export Query_DNB_Contact_Counts := parallel(do1, do2, do3);