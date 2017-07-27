import ut;

ut.MAC_SK_BuildProcess(EDA_VIA_XML.Key_npa_nxx_line,
           '~thor_data400::key::gong_eda_npa_nxx_line', 
				   '~thor_data400::key::gong_eda_npa_nxx_line',
           bk_npa_nxx_line,4)
					 
ut.MAC_SK_BuildProcess(EDA_VIA_XML.Key_st_lname_city,
           '~thor_data400::key::gong_eda_st_lname_city', 
				   '~thor_data400::key::gong_eda_st_lname_city',
           bk_st_lname_city,4)
					 
ut.MAC_SK_BuildProcess(EDA_VIA_XML.Key_st_lname_fname_city,
           '~thor_data400::key::gong_eda_st_lname_fname_city', 
				   '~thor_data400::key::gong_eda_st_lname_fname_city',
           bk_st_lname_fname_city,4)

ut.MAC_SK_BuildProcess(EDA_VIA_XML.Key_st_bizword_city,
           '~thor_data400::key::gong_eda_st_bizword_city', 
				   '~thor_data400::key::gong_eda_st_bizword_city',
           bk_st_bizword_city,4)

ut.MAC_SK_BuildProcess(EDA_VIA_XML.Key_st_city_prim_name_prim_range,
           '~thor_data400::key::gong_eda_st_city_prim_name_prim_range', 
				   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range',
           bk_st_city_prim_name_prim_range,4)

full1 := parallel(bk_npa_nxx_line,
									bk_st_lname_city,
									bk_st_lname_fname_city,
									bk_st_bizword_city,
									bk_st_city_prim_name_prim_range);
									
ut.mac_sk_move('~thor_data400::key::gong_eda_npa_nxx_line','Q',out1)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_city','Q',out2)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_fname_city','Q',out3)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_bizword_city','Q',out4)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_city_prim_name_prim_range','Q',out5)

move1 := parallel(out1, out2, out3, out4, out5);

export Proc_Build_Full_Keys := sequential(full1,move1);