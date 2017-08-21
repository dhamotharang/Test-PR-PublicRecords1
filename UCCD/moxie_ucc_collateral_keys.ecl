import uccd,lib_keylib,lib_stringlib;

Layout_WithExpCollateral_Filepos := record
	uccd.layout_moxie_withEXpCollateral;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
 
h := uccd.File_WithExpCollateral2_Base_Dev;

//output(h);

MyFields := record
h.ucc_key;
h.event_key;
h.__filepos;
end;
  
t := table(h, MyFields);

base_key_Name := '~thor_data400::key::moxie.ucc2_collateral.';

k1 := BUILDINDEX( t, {ucc_key,event_key,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ucc_key.event_key_' + uccd.version_development, moxie);
			


unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(uccd.Layout_withEXpCollateral) + max(h, __filepos): global;
headersize := if (sizeof(uccd.Layout_withEXpCollateral)>215, sizeof(uccd.Layout_withEXpCollateral), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},base_key_Name + 'fpos.data_' + uccd.version_development);
kFPos				:= BUILDINDEX(dfile,moxie);

export moxie_ucc_collateral_Keys
 :=
  parallel
	(
	 k1
	,kFPos
	)
  ;

			