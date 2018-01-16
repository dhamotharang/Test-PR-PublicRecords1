import doxie,Data_Services;

typeof(patriot.file_patriot_keybuild) upper(patriot.file_patriot_keybuild le) :=
TRANSFORM
	SELF.country := Stringlib.StringToUpperCase(le.country);
	SELF := le;
END;

p := PROJECT(patriot.File_Patriot_keybuild,upper(LEFT));

export key_patriot_file := index(p,
{
pty_key,
source,
orig_pty_name,
orig_vessel_name,
country,
name_type,
cname,
title,
fname,
mname,
lname,
suffix,
a_score,
prim_range,
predir,
prim_name,
addr_suffix,
postdir,
unit_desig,
sec_range,
p_city_name,
v_city_name,
st,
zip},{p},Data_Services.Data_location.Prefix()+'thor_data400::key::patriot_File_Full_' + doxie.Version_SuperKey);