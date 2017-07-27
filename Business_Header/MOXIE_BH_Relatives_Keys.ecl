import Business_Header,Lib_KeyLib;

h := Business_Header.File_Business_Relatives_Keybuild;

MyFields := record
    h.bdid1;            // Seisint Business Identifier
	h.name_address;
	h.corp_charter_number;
	h.fbn_filing;
	h.fein;
	h.phone;
	h.bankruptcy_filing;
	h.__filepos;
end;
  
bdid1_records := table(h(bdid1 <> ''), MyFields);

k1 := BUILDINDEX( bdid1_records, {bdid1,name_address,corp_charter_number,fbn_filing,fein,
							phone,bankruptcy_filing,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Relatives + 'bdid1.name_address.corp_charter_number.fbn_filing.fein.phone.bankruptcy_filing.key', moxie,overwrite);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Business_Header.Layout_Business_Relatives_Out) * count(h) : global;
headersize := sizeof(Business_Header.Layout_Business_Relatives_Out) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.Base_Key_Name_Relatives + 'fpos.data.key');

k2 := buildindex(dfile,moxie,overwrite);

export MOXIE_BH_Relatives_Keys := sequential(k1,k2);
