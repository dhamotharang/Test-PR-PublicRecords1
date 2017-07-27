Import Data_Services, doxie;

slimLayout	:=	record
	BusReg.Layout_BusReg_Contact - [Prep_addr_line1, prep_addr_line_last, Append_RawAID, Append_ACEAID];
end;

df := PROJECT(busreg.File_BusReg_Contact(bdid != 0),TRANSFORM(slimLayout,SELF := LEFT;));

export key_busreg_contact_bdid := index(df,{bdid},{df},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::busreg_contact_bdid_' + doxie.Version_SuperKey);
