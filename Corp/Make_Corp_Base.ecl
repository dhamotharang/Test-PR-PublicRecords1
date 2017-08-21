import ut, Corp, fieldstats;

#workunit('name', 'Corporate Base Creation ' + corp.Corp_Build_Date);
							  
// Project corp to base layout
Corp.Layout_Corp_Base FormatCorpBase(Corp.Layout_Corp_Temp l) := transform
self := l;
end;

Corp_Base := project(Corp.Corp_Updated_Corp, FormatCorpBase(left));

//output(Corp_Base,,'BASE::Corp_Base_' + Corp.Corp_Build_Date, overwrite);
ut.MAC_SF_BuildProcess(corp_base,'~thor_data400::base::corp_base',do1,2)

// Project corp supplemental to base layout
Corp.Layout_Corp_Supp_Base FormatCorpSuppBase(Corp.Layout_Corp_Supp_Temp l) := transform
self := l;
end;

Corp_Supp_Base := project(Corp.Corp_Updated_Supp, FormatCorpSuppBase(left));

//output(Corp_Supp_Base,,'BASE::Corp_Supp_Base_' + Corp.Corp_Build_Date, overwrite);
ut.MAC_SF_BuildProcess(corp_supp_base,'~thor_data400::base::corp_supp_base',do2,2)

// Project contacts to base layout
Corp.Layout_Corp_Cont_Base FormatCorpContBase(Corp.Layout_Corp_Cont_Temp l) := transform
self := l;
end;

Corp_Cont_Base := project(Corp.Corp_Updated_Cont, FormatCorpContBase(left));

//output(Corp_Cont_Base,,'BASE::Corp_Cont_Base_' + Corp.Corp_Build_Date, overwrite);
ut.MAC_SF_BuildProcess(corp_cont_base,'~thor_data400::base::corp_cont_base',do3,2)

// Join events to corp base to assign bdids
Layout_Corp_BDID_List := record
unsigned6 bdid;
string30  corp_key;
end;

Layout_Corp_BDID_List InitCorpBDID(Corp.Layout_Corp_Base l) := transform
self := l;
end;

Corp_Event_BDID_Init := project(Corp_Base, InitCorpBDID(left));
Corp_Event_BDID_Dedup := dedup(Corp_Event_BDID_Init, bdid, corp_key, all);
Corp_Event_BDID_Dedup_Dist := distribute(Corp_Event_BDID_Dedup, hash(corp_key));

Corp_Event_Dist := distribute(Corp.Corp_Updated_Event, hash(corp_key));

// Join events to corp base to assign bdids
Corp.Layout_Corp_Event_Base AssignEventBDID(Corp.Layout_Corp_Event_Temp l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;

Corp_Event_Base := join(Corp_Event_Dist,
                        Corp_Event_BDID_Dedup_Dist,
						left.corp_key = right.corp_key,
						AssignEventBDID(left, right),
						left outer,
						local);
						
//output(Corp_Event_Base,,'BASE::Corp_Event_Base_'  + Corp.Corp_Build_Date, overwrite);
ut.mac_sf_buildprocess(Corp_Event_Base,'~thor_data400::base::corp_event_base',do4,2)

fieldstats.mac_stat_file(corp_event_base,stats,'corp_base',50,5,true,
						bdid,'number','M',
						corp_key,'string','M',
						corp_state_origin,'string','F',
						corp_sos_charter_nbr,'string','M',
						event_filing_date,'string','F');


emailx := fileservices.sendemail('jtrost@seisint.com; lbentley@seisint.com; rvanheusen@seisint.com; cmaroney@seisint.com','CORP_FieldPop_Stats','Finished Corp Build ' + ut.getDate +  '\r\n \r\n ' +
			  'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

sequential(do1,do2,do3,do4,stats,emailx);
