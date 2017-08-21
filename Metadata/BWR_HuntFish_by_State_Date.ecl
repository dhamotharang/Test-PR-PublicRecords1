//By John J. Bulten 20070419-20070424 Group Hunt Fish by state and date

#option('skipFileFormatCrcCheck', 1);
dDev := eMerges.file_hunters_out;
tPLDateReg := sort(table(dDev,{source_state,min(group,File_Acquired_Date),max(group,File_Acquired_Date),count(group)},source_state,few),source_state);
//tPLDateLic := sort(table(dDev,{source_state,DateLicense,count(group)},source_state,DateLicense,few),source_state,DateLicense);
output(tPLDateReg,all);
//output(tPLDateLic,all);