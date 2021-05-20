//Email notice for new offenses that have not been categorized

 dslayout := RECORD
  string60 seisint_primary_key;
  string320 offense_description;
  string180 offense_description_2;
  string30 offense_category;
  string1 victim_minor;
 END;

exceptList 		:= dataset('~thor_data400::persist::hd::sex_offender_offenses_no_category', dslayout, flat);

email_notice 	:= if(count(exceptList(offense_category='')) > 0
										,sequential(output(exceptList, all, named('Unclassified_Sex_Offenses_List'))
												,output(exceptList,,'~thor_data400::persist::hd::sex_offender_offenses_no_category.csv', csv(heading(1), terminator('\r\n'), separator('|')), overwrite, named('Unclassified_Sex_Offenses_List_CSV'))
												,fileservices.SendEmail('cindy.loizzo@lexisnexis.com;judy.tao@lexisnexis.com;Darren.Knowles@lexisnexis.com;tarun.patel@lexisnexis.com;angela.herzberg@lexisnexis.com', 'Sex Offender: Uncategorized Offense List Available', 'The latest uncategorized sex offense list now is available.  Please see: '+'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit))
										,fileservices.SendEmail('cindy.loizzo@lexisnexis.com;judy.tao@lexisnexis.com;Darren.Knowles@lexisnexis.com;tarun.patel@lexisnexis.com;angela.herzberg@lexisnexis.com', 'Sex Offender: No Uncategorized Offense List', 'There are no uncategorized sex offenses in this build'));
	export UncategorizedOffenseList := email_notice;