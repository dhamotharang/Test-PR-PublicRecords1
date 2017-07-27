export proc_build_full_keys(filedate,build_keys) :=
macro

#uniquename(pre1)
%pre1% := ut.SF_MaintBuilding('~thor_data400::base::gong');

#uniquename(bk_did)
#uniquename(bk_bdid)
#uniquename(bk_hhid)
#uniquename(bk_addr)
#uniquename(bk_phone)
#uniquename(bk_czsslf)
#uniquename(bk_lczf)
#uniquename(bk_npa_nxx_line)
#uniquename(bk_st_lname_city)
#uniquename(bk_st_lname_fname_city)
#uniquename(bk_st_bizword_city)
#uniquename(bk_st_city_prim_name_prim_range)

RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_did,'~thor_data400::key::gong_weekly::'+filedate+'::did', 
								 '~thor_data400::key::gong_did',
                                         %bk_did%,4);
										 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_bdid,'~thor_data400::key::gong_weekly::'+filedate+'::bdid', 
								 '~thor_data400::key::gong_bdid',
                                         %bk_bdid%,4);
								 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_hhid,'~thor_data400::key::gong_weekly::'+filedate+'::hhid', 
								  '~thor_data400::key::gong_hhid',
                                          %bk_hhid%,4);
								  
// RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_address,'~thor_data400::key::gong_weekly::'+filedate+'::address', 
									// '~thor_data400::key::gong_address',
                                             // %bk_addr%,4); // attribute has been deleted
									
RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.Key_gong_phone,
                       '~thor_data400::key::gong_weekly::'+filedate+'::phone', 
				   '~thor_data400::key::gong_phone',
                       %bk_phone%,4);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.key_gong_batch_czsslf,
                       '~thor_data400::key::gong_weekly::'+filedate+'::czsslf', 
				   '~thor_data400::key::gong_czsslf',
                       %bk_czsslf%,4);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.key_gong_batch_lczf,
                       '~thor_data400::key::gong_weekly::'+filedate+'::lczf', 
				   '~thor_data400::key::gong_lczf',
                       %bk_lczf%,4);
											 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_npa_nxx_line,
           '~thor_data400::key::gong_weekly::'+filedate+'::eda_npa_nxx_line', 
				   '~thor_data400::key::gong_eda_npa_nxx_line',
           %bk_npa_nxx_line%,4);
					 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_lname_city,
           '~thor_data400::key::gong_weekly::'+filedate+'::eda_st_lname_city', 
				   '~thor_data400::key::gong_eda_st_lname_city',
           %bk_st_lname_city%,4);
					 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_lname_fname_city,
           '~thor_data400::key::gong_weekly::'+filedate+'::eda_st_lname_fname_city', 
				   '~thor_data400::key::gong_eda_st_lname_fname_city',
           %bk_st_lname_fname_city%,4);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_bizword_city,
           '~thor_data400::key::gong_weekly::'+filedate+'::eda_st_bizword_city', 
				   '~thor_data400::key::gong_eda_st_bizword_city',
           %bk_st_bizword_city%,4);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_city_prim_name_prim_range,
           '~thor_data400::key::gong_weekly::'+filedate+'::eda_st_city_prim_name_prim_range', 
				   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range',
           %bk_st_city_prim_name_prim_range%,4);




/*
#uniquename(NewName)	
%NewName%	:= business_header.keynames.NewConvention;
#uniquename(OldName)	
%OldName%	:= business_header.keynames.OldConvention;
*/
#uniquename(Buildkey5)
#uniquename(Buildkey6)
#uniquename(BuildFCRAkey4)
#uniquename(BuildFCRAkey5)

#uniquename(MoveKeyToBuilt5)
#uniquename(MoveKeyToBuilt6)
#uniquename(MoveFCRAKeyToBuilt4)
#uniquename(MoveFCRAKeyToBuilt5)

#uniquename(MoveKeyToQA1)
#uniquename(MoveKeyToQA2)
#uniquename(MoveFCRAKeyToQA2)
#uniquename(MoveFCRAKeyToQA3)

RoxieKeyBuild.Mac_SK_BuildProcess_Local( risk_indicators.key_phone_table, '~thor_data400::key::business_header::'+filedate+'::hri::phone10','~thor_data400::key::phone_table',%Buildkey5%);
RoxieKeyBuild.Mac_SK_BuildProcess_Local( risk_indicators.Key_Phone_Table_v2, '~thor_data400::key::business_header::'+filedate+'::hri::phone10_v2','~thor_data400::key::phone_table_v2',%Buildkey6%);

RoxieKeyBuild.Mac_SK_BuildProcess_Local( risk_indicators.key_phone_table_filtered, '~thor_data400::key::business_header::filtered::'+filedate+'::hri::phone10','~thor_data400::key::phone_table_filtered',%BuildFCRAkey4%);
RoxieKeyBuild.Mac_SK_BuildProcess_Local( risk_indicators.key_phone_table_fcra_v2 ,'~thor_data400::key::business_header::filtered::'+filedate+'::hri::phone10_v2','~thor_data400::key::phone_table_filtered_v2',%BuildFCRAkey5%);


RoxieKeyBuild.Mac_SK_Move_To_Built( '~thor_data400::key::business_header::'+filedate+'::hri::phone10',	'~thor_data400::key::phone_table',	%MoveKeyToBuilt5%);
RoxieKeyBuild.Mac_SK_Move_To_Built( '~thor_data400::key::business_header::'+filedate+'::hri::phone10_v2', '~thor_data400::key::phone_table_v2',	%MoveKeyToBuilt6%);
RoxieKeyBuild.Mac_SK_Move_To_Built( '~thor_data400::key::business_header::filtered::'+filedate+'::hri::phone10', '~thor_data400::key::phone_table_filtered',	%MoveFCRAKeyToBuilt4%);
RoxieKeyBuild.Mac_SK_Move_To_Built( '~thor_data400::key::business_header::filtered::'+filedate+'::hri::phone10_v2', '~thor_data400::key::phone_table_filtered_v2',	%MoveFCRAKeyToBuilt5%);

ut.mac_sk_move('~thor_data400::key::phone_table','Q',%MoveKeyToQA1%);
ut.mac_sk_move('~thor_data400::key::phone_table_v2','Q',%MoveKeyToQA2%);
ut.mac_sk_move('~thor_data400::key::phone_table_filtered','Q',%MoveFCRAKeyToQA2%);
ut.mac_sk_move('~thor_data400::key::phone_table_filtered_v2','Q',%MoveFCRAKeyToQA3%);


#uniquename(kpg)
					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_cbrs.key_phone_gong, '~thor_data400::key::cbrs.phone10_gong','~thor_data400::key::gong_weekly::'+filedate+'::cbrs.phone10_gong', 
					 %kpg%);

#uniquename(mv_did)
#uniquename(mv_bdid)
#uniquename(mv_hhid)
#uniquename(mv_addr)
#uniquename(mv_phone)
#uniquename(mv_czsslf)
#uniquename(mv_lczf)
#uniquename(mv_npa_nxx_line)
#uniquename(mv_st_lname_city)
#uniquename(mv_st_lname_fname_city)
#uniquename(mv_st_bizword_city)
#uniquename(mv_st_city_prim_name_prim_range)

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::did', 
								 '~thor_data400::key::gong_did',
                                         %mv_did%,4);
										 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::bdid', 
								 '~thor_data400::key::gong_bdid',
                                         %mv_bdid%,4);
								 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::hhid', 
								  '~thor_data400::key::gong_hhid',
                                          %mv_hhid%,4);
								  
// RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::address', 
									// '~thor_data400::key::gong_address',
                                             // %mv_addr%,4); // attribute has been deleted
									
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::phone', 
				   '~thor_data400::key::gong_phone',
                       %mv_phone%,4);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::czsslf', 
				   '~thor_data400::key::gong_czsslf',
                       %mv_czsslf%,4);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::lczf', 
				   '~thor_data400::key::gong_lczf',
                       %mv_lczf%,4);
											 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::eda_npa_nxx_line', 
				   '~thor_data400::key::gong_eda_npa_nxx_line',
           %mv_npa_nxx_line%,4);
					 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::eda_st_lname_city', 
				   '~thor_data400::key::gong_eda_st_lname_city',
           %mv_st_lname_city%,4);
					 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::eda_st_lname_fname_city', 
				   '~thor_data400::key::gong_eda_st_lname_fname_city',
           %mv_st_lname_fname_city%,4);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::eda_st_bizword_city', 
				   '~thor_data400::key::gong_eda_st_bizword_city',
           %mv_st_bizword_city%,4);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+filedate+'::eda_st_city_prim_name_prim_range', 
				   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range',
           %mv_st_city_prim_name_prim_range%,4);

#uniquename(kpg1)
					 
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::cbrs.phone10_gong','~thor_data400::key::gong_weekly::'+filedate+'::cbrs.phone10_gong', 
					 %kpg1%);

#uniquename(full1)






%full1% := if (fileservices.getsuperfilesubname('~thor_data400::base::gong',1) =      
fileservices.getsuperfilesubname('~thor_data400::base::gong_built',1),
		   output('base file BASE = BUILT, Nothing done.'),
		   sequential(parallel(%bk_did%,
								%bk_bdid%,
								%bk_hhid%,
								// %bk_addr%, // attribute has been deleted
								%bk_phone%,
								%bk_czsslf%,
								%bk_lczf%,
								%bk_npa_nxx_line%,
								%bk_st_lname_city%,
								%bk_st_lname_fname_city%,
								%bk_st_bizword_city%,
								%bk_st_city_prim_name_prim_range%,
								%kpg%,
								%Buildkey5%,
								%Buildkey6%,
								%BuildFCRAkey4%,
								%BuildFCRAkey5%
								),
			parallel(			%mv_did%,
								%mv_bdid%,
								%mv_hhid%,
								// %mv_addr%, // attribute has been deleted
								%mv_phone%,
								%mv_czsslf%,
								%mv_lczf%,
								%mv_npa_nxx_line%,
								%mv_st_lname_city%,
								%mv_st_lname_fname_city%,
								%mv_st_bizword_city%,
								%mv_st_city_prim_name_prim_range%,
								%MoveKeyToBuilt5%,
								%MoveKeyToBuilt6%,
								%MoveFCRAKeyToBuilt4%,
								%MoveFCRAKeyToBuilt5%,
								%kpg1%)));

#uniquename(post1)
		   
%post1% := ut.SF_MaintBuilt('~thor_data400::base::gong');
#uniquename(out0)
#uniquename(out1)
#uniquename(out2)
#uniquename(out3)
#uniquename(out4)
#uniquename(out5)
#uniquename(out6)
#uniquename(out7)
#uniquename(out8)
#uniquename(out9)
#uniquename(out10)
#uniquename(out11)
#uniquename(kpg2)

ut.mac_sk_move('~thor_data400::key::gong_bdid','Q',%out0%);
ut.mac_sk_move('~thor_data400::key::gong_did','Q',%out1%);
ut.mac_sk_move('~thor_data400::key::gong_hhid','Q',%out2%);
// ut.mac_sk_move('~thor_data400::key::gong_address','Q',%out3%); // attribute has been deleted
ut.mac_sk_move('~thor_data400::key::gong_phone','Q',%out4%);
ut.mac_sk_move('~thor_data400::key::gong_czsslf','Q',%out5%);
ut.mac_sk_move('~thor_data400::key::gong_lczf','Q',%out6%);
ut.mac_sk_move('~thor_data400::key::gong_eda_npa_nxx_line','Q',%out7%);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_city','Q',%out8%);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_fname_city','Q',%out9%);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_bizword_city','Q',%out10%);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_city_prim_name_prim_range','Q',%out11%);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.phone10_gong','Q', %kpg2%);

#uniquename(move1)




%move1% := parallel(%out0%,%out1%, %out2%, %out4%, %out5%, %out6%, %out7%, %out8%, %out9%, %out10%, %out11%, %kpg2%,%MoveKeyToQA1%,%MoveKeyToQA2%,%MoveFCRAKeyToQA2%,%MoveFCRAKeyToQA3%);

build_keys := sequential(%pre1%,%full1%,%post1%,%move1%);

endmacro;