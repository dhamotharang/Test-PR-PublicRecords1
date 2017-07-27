import doxie, ut, risk_indicators;


export Key_Inquiry_Billgroups_DID := INDEX(Inquiry_AccLogs.File_Inquiry_Billgroups_DID().File, {did}, {Inquiry_AccLogs.File_Inquiry_Billgroups_DID().File},
																'~thor_data400::key::inquiry_table::' + doxie.Version_SuperKey + '::billgroups_did');

