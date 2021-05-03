export File_CRU_inquiries := dataset(mod_Utilities.Location + 'thor_data400::base::ntlcrash_inquiry', 
                                     FLAccidents_Ecrash.Layout_CRU_inquiries, thor)(ACCT_NBR not in ['533302','533303','535863','530209','536379' ] );
