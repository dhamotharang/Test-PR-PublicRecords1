//By John J. Bulten 20070419 based on PL with totals & cov dates-no license types
//Group PL by state, vendor, profession, license type, and 3 dates

#option('skipFileFormatCrcCheck', 1);
dDev := Prof_License.file_prof_license_base;
tPLState := sort(table(dDev,{source_st,count(group)},source_st,few),source_st);
tPLVendor := sort(table(dDev,{vendor,count(group)},vendor,few),vendor);
tPLProf := sort(table(dDev,{profession_or_board,count(group)},profession_or_board,few),profession_or_board);
tPLType := sort(table(dDev,{license_type,count(group)},license_type,few),license_type);
tPLDateProc := sort(table(dDev,{issue_date,count(group)},issue_date,few),issue_date);
tPLDateSeen := sort(table(dDev,{date_last_seen,count(group)},date_last_seen,few),date_last_seen);
tPLDateExpir := sort(table(dDev,{expiration_date,count(group)},expiration_date,few),expiration_date);

parallel(
output(tPLState,all),
output(tPLVendor,all),
output(tPLProf,all),
output(tPLType,all),
output(tPLDateProc,all),
output(tPLDateSeen,all),
output(tPLDateExpir,all)
);