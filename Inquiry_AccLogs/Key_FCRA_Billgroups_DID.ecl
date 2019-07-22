import doxie, ut, vault, _control;



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_Billgroups_DID := vault.Inquiry_Acclogs.Key_FCRA_Billgroups_DID;

#ELSE
export Key_FCRA_Billgroups_DID := INDEX(Inquiry_AccLogs.File_FCRA_Inquiry_Billgroups_DID().File, {did}, {Inquiry_AccLogs.File_FCRA_Inquiry_Billgroups_DID().File},
																'~thor_data400::key::inquiry_table::fcra::' + doxie.Version_SuperKey + '::billgroups_did');

#END;

