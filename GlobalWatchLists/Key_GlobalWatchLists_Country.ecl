Import Doxie;
p := DEDUP(File_GlobalWatchLists_Keybuild
(name_type='Country'),pty_key,address_country,all);

l :=
RECORD
	STRING100 country;
	STRING60 source;
	STRING20 pty_key;
END;



l seq(p le) :=
TRANSFORM
	SELF.country := stringlib.stringtouppercase(le.address_country);
	SELF := le;
END;

proj := PROJECT(p,seq(LEFT));

// buildindex(proj,{country},
// {pty_key},'~thor_data400::key::patriot_countries',few)

export Key_GlobalWatchLists_Country := INDEX(proj,{country},{pty_key},'~thor_data400::key::globalwatchlists::countries_'+doxie.Version_SuperKey);