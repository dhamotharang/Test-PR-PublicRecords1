import watercraft,Data_Services, ut; 

export Files_raw := module

// single name cleaning sources
export AZ := dataset('~thor_data400::in::watercraft_raw_az', Watercraft.layout_AZ_new, flat);
export IA := dataset('~thor_data400::in::watercraft_raw_ia', Watercraft.Layout_IA_new, flat); 
export KS := dataset('~thor_data400::in::watercraft_raw_ks', Watercraft.layout_KS_q3_new, flat);
export ND := dataset('~thor_data400::in::watercraft_raw_nd', Watercraft.layout_ND_new14Q2, flat);
export TX := dataset('~thor_data400::in::watercraft_raw_tx', Watercraft.layout_TX_new_18q3, flat);
//export TX := dataset('~thor_data400::in::watercraft_raw_tx', Watercraft.layout_TX_new, flat);
//export WY := dataset('~thor_data400::in::watercraft_raw_wy', Watercraft.Layout_WY_new_2014, flat);
export WY := dataset('~thor_data400::in::watercraft_raw_wy', Watercraft.Layout_WY_2015_Q1, flat);

// Multiple name cleaning sources 
export AK := dataset('~thor_data400::in::watercraft_raw_ak', Watercraft.layout_ak, flat);
export AL := dataset('~thor_data400::in::watercraft_raw_al', Watercraft.layout_AL_fixed, flat);
//export AL := dataset('~thor_data400::in::watercraft_al_14q2_raw', Watercraft.layout_AL_fixed, flat);

export AR := dataset('~thor_data400::in::watercraft_raw_ar', Watercraft.layout_AR, flat);
export CT := dataset('~thor_data400::in::watercraft_raw_ct', Watercraft.layout_CT_2015Q3, flat);
export GA := dataset('~thor_data400::in::watercraft_raw_ga', Watercraft.Layout_GA_new14Q2, flat);
export FL := dataset('~thor_data400::in::watercraft_raw_fl', Watercraft.layout_FL, flat);
export KY := dataset('~thor_data400::in::watercraft_raw_ky', Watercraft.layout_ky_infolink, flat);
export MA := dataset('~thor_data400::in::watercraft_raw_ma', Watercraft.layout_MA, flat);
export ME := dataset('~thor_data400::in::watercraft_raw_me', Watercraft.layout_ME_18q3_new, flat);
export MI := dataset('~thor_data400::in::watercraft_raw_mi', Watercraft.layout_MI, flat);
export MO := dataset('~thor_data400::in::watercraft_raw_mo', Watercraft.layout_MO, flat);
export MS := dataset('~thor_data400::in::watercraft_raw_ms', Watercraft.layout_MS_new, flat);
export NE := dataset('~thor_data400::in::watercraft_raw_ne', Watercraft.layout_NE, flat);
export NM := dataset('~thor_data400::in::watercraft_raw_nm', Watercraft.layout_NM, flat);
export OH := dataset('~thor_data400::in::watercraft_raw_oh', Watercraft.layout_OH, flat);
export OR_ := dataset('~thor_data400::in::watercraft_raw_or', Watercraft.layout_OR_new_14q3, flat);
export VA := dataset('~thor_data400::in::watercraft_raw_va', Watercraft.layout_VA, flat);
export WA := dataset('~thor_data400::in::watercraft_raw_wa', Watercraft.layout_WA, flat);
export WI := dataset('~thor_data400::in::watercraft_raw_wi', Watercraft.Layout_WI_new.raw, flat);
export CG := dataset('~thor_data400::in::watercraft_raw_CG', Watercraft.layout_CG, flat);

end; 