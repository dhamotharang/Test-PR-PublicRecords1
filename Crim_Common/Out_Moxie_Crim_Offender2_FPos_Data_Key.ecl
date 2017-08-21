rMoxieFileForKeybuildLayout
 :=
  record
	Crim_Common.Layout_Moxie_Crim_Offender2.previous;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

h := dataset('~thor_data400::base::crim_offender2_did_' + Crim_Common.Version_Development,rMoxieFileForKeybuildLayout,flat);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Crim_Common.Layout_Moxie_Crim_Offender2.previous) * count(h) : global;
headersize := sizeof(Crim_Common.Layout_Moxie_Crim_Offender2.previous) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'~thor_data400::key::moxie.crim_offender2_did.fpos.data.key');

export Out_Moxie_Crim_Offender2_FPos_Data_Key := buildindex(dfile,moxie,overwrite);