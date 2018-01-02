Import Data_Services, doxie,ut;

SlimLayout	:= RECORD

BusReg.Layout_BusReg_Company - [Append_MailRawAID,Append_MailACEAID,Append_LocRawAID,Append_LocACEAID,Append_RARawAID,
																Append_RAACEAID,Append_Off1RawAID,Append_Off1ACEAID,Clean_mailing_address1,Clean_mailing_address2,
																Clean_location_address1,Clean_location_address2,Clean_RA_address1,Clean_RA_address2,
																Clean_officer1_address1,Clean_officer1_address2,source_rec_id];
		
end;
	
df := PROJECT(busreg.File_BusReg_Company(bdid != 0),TRANSFORM(slimLayout,SELF := LEFT;));

export key_busreg_company_bdid := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::busreg_company_bdid_' + doxie.Version_SuperKey);
