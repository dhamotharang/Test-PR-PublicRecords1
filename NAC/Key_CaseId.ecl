import doxie,data_services;
d := Files().Base(case_identifier<>'');

export Key_CaseId := INDEX(d, {case_identifier}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC::key::caseid_' + doxie.version_superkey);