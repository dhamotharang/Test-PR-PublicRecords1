import Prof_License;

dProlicPersist	:=	dataset('~thor_data400::persist::prof_licenses',Prof_License.layout_proflic_out,flat);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSize	:= sizeof(Prof_License.layout_proflic_out) * count(dProlicPersist) : global;
gHeaderSize	:= sizeof(Prof_License.layout_proflic_out) : global;

dIndex		:= index(Prof_License.File_Base_Building_Indexes,{f:= moxietransform(__filepos, gRawSize, gHeaderSize)},{Prof_License.File_Base_Building_Indexes},'~thor_data400::key::prof_licenses.fpos.data.key');

export proc_build_moxie_fpos_data_key	:=	buildindex(dIndex,moxie,overwrite);