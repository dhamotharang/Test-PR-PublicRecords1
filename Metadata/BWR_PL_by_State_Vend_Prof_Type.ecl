//By John J. Bulten 20070510 based on PL with totals & cov dates-no license types
//Group PL by license type, with counts and max dates
//W20070803-102416, W20070808-135646
//W20071015-145403 textually parsed in Excel

#option('skipFileFormatCrcCheck', 1);
dDev := Prof_License.file_prof_license_base;
tPLType := sort(table(dDev,{source_st,vendor,profession_or_board,license_type,
                            min(group,issue_date),max(group,issue_date),
                            min(group,date_last_seen),max(group,date_last_seen),
							min(group,expiration_date),max(group,expiration_date),count(group)},
                      source_st,vendor,profession_or_board,license_type,few),
                source_st,vendor,profession_or_board,license_type);

output(tPLType,all);