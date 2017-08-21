import Gong,Gong_v2,ut;

File_HHCnts_Building_Indexes := 
	dataset(gong_v2.thor_cluster+'base::gong_hhcnts',
			{Gong.Layout_Gong_hhcnts,unsigned8 __filepos{ virtual(fileposition)}},thor,unsorted);
			
gongBuilding  := File_HHCnts_Building_Indexes;

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSize	:= sizeof(Gong.Layout_Gong_hhcnts) * count(gongBuilding) : global;
gHeaderSize	:= sizeof(Gong.Layout_Gong_hhcnts) : global;

dIndex		:= index(gongBuilding,{f:= moxietransform(__filepos, gRawSize, gHeaderSize)},{gongBuilding},Gong_v2.thor_cluster+'key::moxie::gong.fpos.hhcnts.data.key');

export proc_build_moxie_fpos_data_key_hhcnts	:=	buildindex(dIndex,moxie,overwrite);