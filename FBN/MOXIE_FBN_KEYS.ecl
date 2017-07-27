import fbn,Lib_KeyLib;
#workunit ('name', 'Build FBN Keys ' + fbn.FBN_Build_Date);

h := fbn.File_FBN_Keybuild;

MyFields := record
h.bdid;            // Seisint Business Identifier
h.__filepos;
end;
  
t := table(h, MyFields);

BUILDINDEX( t, {bdid,(big_endian unsigned8 )__filepos},
			fbn.Base_Key_Name + 'bdid.key', moxie,overwrite);