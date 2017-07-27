import Gong,Gong_v2,ut;

gongBuilding  := Gong_v2.File_Base_Building_Indexes;


unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSize	:= sizeof(Gong.layout_gong) * count(gongBuilding) : global;
gHeaderSize	:= sizeof(Gong.layout_gong) : global;

dIndex		:= index(gongBuilding,{f:= moxietransform(__filepos, gRawSize, gHeaderSize)},{gongBuilding},Gong_v2.thor_cluster+'key::moxie::gong.fpos.data.key');

export proc_build_moxie_fpos_data_key	:=	buildindex(dIndex,moxie,overwrite);