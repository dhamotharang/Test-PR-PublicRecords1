rMoxieFileForKeybuildLayout
 :=
  record
	Crim_Common.Layout_Moxie_Court_Offenses;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

h := dataset('~thor_data400::base::court_offenses_' + Crim_Common.Version_Development,rMoxieFileForKeybuildLayout,flat);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Crim_Common.Layout_Moxie_Court_Offenses) * count(h) : global;
headersize := sizeof(Crim_Common.Layout_Moxie_Court_Offenses) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'~thor_data400::key::moxie.court_offenses.fpos.data.key');


export Out_Moxie_Court_Offenses_FPos_Data_Key  := buildindex(dfile,moxie,overwrite);
