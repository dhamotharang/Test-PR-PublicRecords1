//By John J. Bulten 20070510 based on PL with totals & cov dates-no license types
//Group PL by license type, with counts and max dates
//W20070926-152720 PL by County/City

#option('skipFileFormatCrcCheck', 1);
dDev := Prof_License.file_prof_license_base;
tPLType := sort(table(dDev,{source_st,vendor,profession_or_board,license_type,
                            max(group,issue_date),max(group,date_last_seen),
							max(group,expiration_date),count(group)},
                      source_st,vendor,profession_or_board,license_type,few),
                source_st,vendor,profession_or_board,license_type);

output(table(dDev,{source_st,county_name,count(group)},source_st,county_name),all);