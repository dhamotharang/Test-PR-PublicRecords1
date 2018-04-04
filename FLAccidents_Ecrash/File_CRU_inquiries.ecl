import ut,Data_Services ; 
export File_CRU_inquiries := dataset(Data_Services.Data_location.Prefix('ntlcrash')+'thor_data400::base::ntlcrash_inquiry',FLAccidents_Ecrash.Layout_CRU_inquiries,thor)(ACCT_NBR not in ['533302','533303','535863','530209','536379' ] );
