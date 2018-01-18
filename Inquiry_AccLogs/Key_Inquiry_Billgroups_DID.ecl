import doxie, ut, risk_indicators, data_services;


export Key_Inquiry_Billgroups_DID := INDEX(Inquiry_AccLogs.File_Inquiry_Billgroups_DID().File, {did}, {Inquiry_AccLogs.File_Inquiry_Billgroups_DID().File},
																data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::' + doxie.Version_SuperKey + '::billgroups_did');

