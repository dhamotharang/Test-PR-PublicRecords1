rMoxieFileForKeybuildLayout
 :=
  record
	Drivers.Layout_DL_ToMike;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

h := dataset(Drivers.Cluster + 'out::dl_tomike',rMoxieFileForKeybuildLayout,flat);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Drivers.Layout_DL_ToMike) * count(h) : global;
headersize := sizeof(Drivers.Layout_DL_ToMike) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'~thor_200::key::moxie.dl.fpos.data.key');

export Out_Moxie_Dev_FPos_Data_Key := buildindex(dfile,moxie,overwrite);