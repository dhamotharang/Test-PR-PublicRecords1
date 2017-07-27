import DID_Add,gong,header_slimsort,ut,didville,fair_isaac;

//Slim the gong file
gng := Gong.File_Gong_full;

matchset := ['A','P'];

//DID gong file
DID_Add.MAC_Match_Flex(gng,matchset,junk,junk,name_first,name_middle,
	name_last,name_suffix,prim_range,prim_name,sec_range,z5,st,phone10,
	did,Layout_Gong_DID,false,junk, 
	75,gng_out)

export DID_Gong := gng_out : persist('persist::gong_did');