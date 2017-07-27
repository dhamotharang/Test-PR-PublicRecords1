import ut, sexoffender, fieldstats;

inf := sexoffender.allpeople;
inf2 := sexoffender.alloffenses;

fieldstats.mac_stat_file(inf,stat1,'sexoffender_main',50,5,false,
					Person_ID,'string','M',
					lname,'string','M',
					COUNTY,'string','F',
					seisint_primary_key,'string','M',
					risk_level_code,'string','F')

fieldstats.mac_stat_file(inf2,stat2,'sexoffender_offenses',50,4,false,					Seisint_Primary_Key,'string','M',
					conviction_date,'string','F',
					offense_code_or_statute,'string','F',
					court_case_number,'string','M')


ut.MAC_SF_BuildProcess(sexoffender.MainFile,'~thor_data400::base::sex_offender_main'+ doxie_build.buildstate,out1)
ut.MAC_SF_BuildProcess(sexoffender.OffenseFile,'~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate,out2)

email := fileservices.sendemail('eneiberg@seisint.com; cmaroney@seisint.com; bbartels@seisint.com','Sex Offender Stats',
				'Sex Offender Build Complete ' + ut.GetDate + ' \r\n' +
				'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

export Proc_Build_SO_Search_Base := parallel(/*stat1,stat2,*/out1,out2/*, email*/);