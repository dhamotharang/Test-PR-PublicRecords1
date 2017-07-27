import Business_Header_SS,DID_Add,gong,header_slimsort,ut,didville,fair_isaac,_Control,business_header;


gng := Gong.File_Gong_Full_Prepped_For_Keys;

layout_bdid := record
 unsigned6 BDID := 0;
 gng;
end;



matchset := ['A','P'];

//BDID gong file
Business_Header_SS.MAC_Match_Flex(gng,matchset,
									listed_name,
									prim_range,
									prim_name,
									z5,
									sec_range,
									st,
									phone10,
									filler,
									BDID,
									layout_bdid,
									false, filler,  //these should default to zero in definition
									gng_out)

export File_BDID_Gong := gng_out : persist('~thor_dell400_2::persist::gong_bdid'/*,_Control.TargetQueue.BDL_400*/);