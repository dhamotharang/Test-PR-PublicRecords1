import doxie, NID;

df := dnb.File_DNB_Contacts_Base(lname != '', fname != '');

dfrec := record
	df;
	string20	pfname := NID.PreferredFirstVersionedStr(df.fname, NID.version);
end;

df2 := table(df,dfrec);

export Key_DnB_ContactName := index(df2,{lname,pfname,company_st,company_zip,mname},{duns_number},'~thor_data400::key::dnb_contactName_' + doxie.Version_SuperKey);
