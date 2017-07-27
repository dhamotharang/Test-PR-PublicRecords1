import ut, Corp, fieldstats;

#workunit('name', 'Corporate Base Fix Dates ' + corp.Corp_Build_Date);
							  

ut.MAC_SF_BuildProcess(Corp.corp_fix_dates,'~thor_data400::base::corp_base',do1,2)


ut.MAC_SF_BuildProcess(Corp.corp_supp_fix_dates,'~thor_data400::base::corp_supp_base',do2,2)


ut.MAC_SF_BuildProcess(Corp.corp_cont_fix_dates,'~thor_data400::base::corp_cont_base',do3,2)


ut.mac_sf_buildprocess(Corp.corp_event_fix_dates,'~thor_data400::base::corp_event_base',do4,2)

sequential(do1,do2,do3,do4);
