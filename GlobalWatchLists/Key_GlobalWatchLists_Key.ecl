import doxie;

f := File_GlobalWatchLists_Keybuild;

f fix_vessels(f le) :=
TRANSFORM
	SELF.orig_pty_name := IF(le.orig_vessel_name<>'',le.orig_vessel_name,le.orig_pty_name);
	SELF.cname := IF(le.orig_vessel_name<>'',Stringlib.StringToUppercase(le.orig_vessel_name),le.cname);
	SELF.country := le.country;
	SELF.address_country := Stringlib.StringToUppercase(le.address_country);
	SELF.first_name := Stringlib.StringToUppercase(le.first_name);
	SELF.last_name := Stringlib.StringToUppercase(le.last_name);
	SELF := le;
END;
vessels_fixed := PROJECT(f,fix_vessels(LEFT));

export key_GlobalWatchLists_key := INDEX(vessels_fixed,{pty_key},{vessels_fixed},'~thor_data400::key::globalwatchlists::globalwatchlists_key_'+doxie.Version_SuperKey);