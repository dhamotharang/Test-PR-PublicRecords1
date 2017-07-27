import ut;

eda1 := sequential(
	  buildindex(EDA_VIA_XML.Key_npa_nxx_line_add,'~thor_data400::key::gong_eda_npa_nxx_line_add' + thorlib.WUID(),overwrite),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_father', 
						   '~thor_data400::key::gong_eda_npa_nxx_line_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_built', 
						   '~thor_data400::key::gong_eda_npa_nxx_line_add' + thorlib.WUID()));

eda2 := sequential(
	  buildindex(EDA_VIA_XML.Key_st_bizword_city_add,'~thor_data400::key::gong_eda_st_bizword_city_add' + thorlib.WUID(),overwrite),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_father', 
						   '~thor_data400::key::gong_eda_st_bizword_city_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_built', 
						   '~thor_data400::key::gong_eda_st_bizword_city_add' + thorlib.WUID()));

eda3 := sequential(
	  buildindex(EDA_VIA_XML.Key_st_city_prim_name_prim_range_add,'~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add' + thorlib.WUID(),overwrite),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_father', 
						   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built', 
						   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add' + thorlib.WUID()));

eda4 := sequential(
	  buildindex(EDA_VIA_XML.Key_st_lname_city_add,'~thor_data400::key::gong_eda_st_lname_city_add' + thorlib.WUID(),overwrite),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_father', 
						   '~thor_data400::key::gong_eda_st_lname_city_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_built', 
						   '~thor_data400::key::gong_eda_st_lname_city_add' + thorlib.WUID()));

eda5 := sequential(
	  buildindex(EDA_VIA_XML.Key_st_lname_fname_city_add,'~thor_data400::key::gong_eda_st_lname_fname_city_add' + thorlib.WUID(),overwrite),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_father', 
						   '~thor_data400::key::gong_eda_st_lname_fname_city_add_built',, true),
	  FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_built'),
	  FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_built', 
						   '~thor_data400::key::gong_eda_st_lname_fname_city_add' + thorlib.WUID()));

full1 := parallel(eda1,eda2,eda3,eda4,eda5);

ut.mac_sk_move('~thor_data400::key::gong_eda_npa_nxx_line_add','Q',out1)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_bizword_city_add','Q',out2)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add','Q',out3)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_city_add','Q',out4)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_fname_city_add','Q',out5)

move1 := parallel(out1,out2,out3,out4,out5);

export Proc_Build_Update_Keys := sequential(full1,move1);