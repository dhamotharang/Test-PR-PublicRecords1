import ut, sexoffender, fieldstats, doxie_build ,scrubs_sexoffender_main,scrubs_sexoffender_offense,std,PromoteSupers;

inf 	:= Mapping_Accurint_Person_As_Common;
inf2 	:= Mapping_Accurint_Offenses_As_Common;

fieldstats.mac_stat_file(inf,stat1,'sexoffender_main',50,5,false,
					Person_ID,'string','M',
					lname,'string','M',
					COUNTY,'string','F',
					seisint_primary_key,'string','M',
					risk_level_code,'string','F')

fieldstats.mac_stat_file(inf2,stat2,'sexoffender_offenses',50,4,false,
					Seisint_Primary_Key,'string','M',
					conviction_date,'string','F',
					offense_code_or_statute,'string','F',
					court_case_number,'string','M')


PromoteSupers.MAC_SF_BuildProcess(Hygenics_SOff.MainFile,'~thor_data400::base::sex_offender_main'+ doxie_build.buildstate,out1,,,true)
PromoteSupers.MAC_SF_BuildProcess(Hygenics_SOff.OffenseFile,'~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate,out2,,,true)


// Run scrubs stats and email scrubs reports
statsMain := scrubs_sexoffender_main.fnRunScrubs((string)std.date.today(),'tarun.patel@lexisnexis.com');
statsOffense := scrubs_sexoffender_offense.fnRunScrubs((string)std.date.today(),'tarun.patel@lexisnexis.com');
//emailReport := Hygenics_SOff.email_scrubs_reports;

//Find Unclassifed Offense Category Records
	slimLayout := record
		string60    Seisint_Primary_Key;
		string320   offense_description;
		string180   offense_description_2;
		string30    offense_category;
		string1     victim_minor;
	end;
	
	slimLayout findExcept(inf2 l):= transform
		self := l;
	end;

	exceptList 	:= project(inf2(trim(offense_category, left, right)=''), findExcept(left)): persist('~thor_data400::Persist::hd::Sex_Offender_Offenses_no_category');

export Proc_Build_SO_Search_Base := parallel(stat1, stat2, out1, out2, output(exceptList)
                                         ,statsMain,statsOffense//,emailReport																		 
																			 );