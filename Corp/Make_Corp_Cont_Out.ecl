#workunit('name', 'Corporate Contacts Output File Creation ' + corp.Corp_Build_Date);

// Format Corp Contact Output
corp_cont_output := corp.corp_cont_out;

corp_cont_out_dist := distribute(corp_cont_output, hash(corp_key));
corp_cont_out_sort := sort(corp_cont_out_dist, except bdid, local);
corp_cont_out_dedup := dedup(corp_cont_out_sort, except bdid, local);
output(corp_cont_out_dedup,,'OUT::Corp_Cont_' + Corp.Corp_Build_Date, overwrite);
//ut.MAC_SF_BuildProcess(corp.cor_cont_out,'~thor_data400::out::corp_cont',do1,2);

