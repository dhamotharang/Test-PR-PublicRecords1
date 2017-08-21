nv_mar_filter := dataset('~thor_200::in::mar_div::nv::marriage',marriage_divorce_v2.Layout_Marriage_NV_In,flat,OPT);

export File_Marriage_NV_In := nv_mar_filter( trim(orig_Name1) !='' or trim(orig_Name2)!='' ); 		
