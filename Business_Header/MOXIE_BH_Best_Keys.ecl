import Business_Header,Lib_KeyLib;

h := Business_Header.File_Business_Header_Best_Keybuild;

MyFields := record
    h.bdid;            // Seisint Business Identifier
	h.__filepos;
end;
  
bdid_records := table(h(bdid <> ''), MyFields);

k1 := BUILDINDEX( bdid_records, {bdid,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Header_Best + 'bdid.key', moxie,overwrite);

/////////////////////////////////////////////////			
// FPOS DATA KEY	
/////////////////////////////////////////////////			
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Business_Header.Layout_BH_Best_Out) * count(h) : global;
headersize := sizeof(Business_Header.Layout_BH_Best_Out) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.Base_Key_Name_Header_Best + 'fpos.data.key');

k2 := buildindex(dfile,moxie,overwrite);

			
export MOXIE_BH_Best_Keys := parallel(k1,k2);