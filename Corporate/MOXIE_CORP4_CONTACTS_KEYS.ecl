import Corporate,Lib_KeyLib,lib_stringlib;
#workunit ('name', 'Build Corporate Contacts Keys ' + corporate.Corp4_Build_Date);

h := Corporate.File_Corp4_Contacts_Keybuild;

MyFields := record
h.did;
h.bdid;
STRING12 pgid := h.preGLB_did;
string32  sos_charter_nbr := trim(h.sos_ter_nbr,left);
string2   st_orig := lib_stringlib.stringlib.stringtouppercase(h.state_origin);
string40 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);	
string2 st := h.state;
string25  city := h.p_city_name;
string5   z5 := h.zip5;
h.prim_range;
h.predir;
h.prim_name;
string4 suffix :=   h.addr_suffix;
h.postdir;
h.__filepos;
end;


t := table(h, MyFields);

BUILDINDEX( t, {st_orig,sos_charter_nbr,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'st_orig.sos_charter_nbr.key', moxie,overwrite);
BUILDINDEX( t, {lfmname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'lfmname.key', moxie,overwrite);
BUILDINDEX( t, {st,lfmname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'st.lfmname.key', moxie,overwrite);
BUILDINDEX( t, {st,city,lfmname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'st.city.lfmname.key', moxie,overwrite);
BUILDINDEX( t, {z5,prim_name,prim_range,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'z5.prim_name.prim_range.key', moxie,overwrite);
BUILDINDEX( t, {did,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'did.key', moxie,overwrite);
BUILDINDEX( t, {bdid,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'bdid.key', moxie,overwrite);
BUILDINDEX( t, {pgid,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'pgid.key', moxie,overwrite);
BUILDINDEX( t, {z5,prim_name,suffix,predir,postdir,prim_range,lfmname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Contacts + 'z5.street_name.suffix.predir.postdir.prim_range.lfmname.key', moxie,overwrite);