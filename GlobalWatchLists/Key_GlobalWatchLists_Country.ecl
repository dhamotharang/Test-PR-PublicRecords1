Import	Doxie;

p := DEDUP(File_GlobalWatchLists_Keybuild(GlobalWatchLists.Functions.strClean2Upper(name_type)	=	'COUNTRY'),pty_key,address_country,all);

l :=
RECORD
	STRING100 country;
	STRING60 source;
	STRING20 pty_key;
END;



l seq(p le) :=
TRANSFORM
	SELF.country := GlobalWatchLists.Functions.strClean2Upper(le.address_country);
	SELF := le;
END;

proj := PROJECT(p,seq(LEFT));

export Key_GlobalWatchLists_Country := INDEX(proj,{country},{pty_key},'~thor_data400::key::globalwatchlists::countries_'+doxie.Version_SuperKey);