import doxie,data_services;
d := Files.Payload(Case_Identifier<>'');

export Key_CaseId := INDEX(d, {Case_Identifier}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::caseid_' + doxie.version_superkey);