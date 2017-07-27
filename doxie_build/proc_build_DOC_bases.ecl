import fieldstats, ut,corrections;


inf := corrections.AllOffenders;

fieldstats.mac_stat_file(inf,stats,'doc_offenders',50,5,
					offender_key,'string','M',
					lname,'string','M',
					orig_state,'string','F',
					case_num,'string','M',
					prim_name,'string','M')

inf2 := corrections.AllOffenses;

fieldstats.mac_stat_file(inf2,stats2,'doc_offenses',50,5,
					offender_key,'string','M',
					orig_state,'string','F',
					offense_key,'string','M',
					cty_conv,'string','M',
					off_code,'string','F')

inf3 := corrections.AllPunishments;

fieldstats.mac_stat_file(inf3,stats3,'doc_punishment',50,5,
					offender_key,'string','M',
					sent_length,'string','F',
					orig_state,'string','F',
					par_cur_stat,'string','F',
					sch_rel_dt,'string','F')

inf4 := corrections.AllActivities;

fieldstats.mac_stat_file(inf4,stats4,'doc_activities',50,4,
					offender_key,'string','M',
					state_origin,'string','F',
					case_number,'string','M',
					event_desc_1,'string','M')

inf5 := corrections.AllCourtOffenses;

fieldstats.mac_stat_file(inf5,stats5,'doc_CourtOffenses',50,6,
					offender_key,'string','M',
					state_origin,'string','F',
					le_agency_cd,'string','F',
					arr_statute,'string','M',
					court_desc,'string','M',
					sent_date,'string','F')

					
email := fileservices.sendemail('eneiberg@seisint.com;cmaroney@seisint.com;bbartels@seisint.com',
						'DOC Offender Stats',
						'DOC Build Complete, on ' + ut.GetDate + '\r\n' + 
						'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');


export proc_build_DOC_bases := sequential(stats,stats2,stats3,stats4,stats5,proc_build_DOC_offenders,proc_build_DOC_activity,proc_build_DOC_offenses,proc_build_DOC_court_offenses,proc_build_DOC_punishment,email);