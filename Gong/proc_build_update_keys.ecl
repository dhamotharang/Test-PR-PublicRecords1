export proc_build_update_keys(filedate) :=
macro
#workunit('priority','high');
#option('sortindexpayload',false);

#uniquename(prt_title)
#uniquename(prt_recs)
#uniquename(wrt_recs)

%prt_title% := output('200 new gong sample records ...');
%prt_recs% := output(choosen(enth(gong.File_Daily_Additions((unsigned)phone10<>0),200),200));
%wrt_recs% := output(dedup(sort(gong.File_Daily_Deletions((unsigned)phone7<>0),
                                area_code, phone7), area_code, phone7),,
                     '~thor_data400::in::gong_daily_remove' + thorlib.wuid(),overwrite);


#uniquename(prt_sample)

%prt_sample% := sequential(%prt_title%, %prt_recs%,%wrt_recs%,
                         FileServices.sendemail('qualityassurance@seisint.com','GONG DAILY SAMPLE READY','at ' + thorlib.WUID()));

#uniquename(pre1)
#uniquename(pre2)

%pre1% := ut.SF_MaintBuilding('~thor_data400::base::gong_daily_additions');
%pre2% := fileservices.addsuperfile('~thor_data400::base::gong_daily_deletions_building',
                                  '~thor_data400::in::gong_daily_remove' + thorlib.wuid());

#uniquename(bk1)
#uniquename(bk2)
#uniquename(bk3)
#uniquename(bk4)
#uniquename(bk5)
#uniquename(bk6)
#uniquename(bk7)
#uniquename(mv1)
#uniquename(mv2)
#uniquename(mv3)
#uniquename(mv4)
#uniquename(mv5)
#uniquename(mv6)
#uniquename(mv7)

%bk1% := buildindex(gong.key_did_add,'~thor_data400::key::gong_daily::'+filedate+'::did_add' ,overwrite);
%mv1% := sequential(
			FileServices.ClearSuperFile('~thor_data400::key::gong_did_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_did_add_father', 
						   '~thor_data400::key::gong_did_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_did_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_did_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::did_add' ));

%bk2% := buildindex(gong.key_hhid_add,'~thor_data400::key::gong_daily::'+filedate+'::hhid_add' ,overwrite);
%mv2% := sequential(
			FileServices.ClearSuperFile('~thor_data400::key::gong_hhid_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_hhid_add_father', 
	  					   '~thor_data400::key::gong_hhid_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_hhid_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_hhid_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::hhid_add' ));

%bk3% := buildindex(gong.key_address_add,'~thor_data400::key::gong_daily::'+filedate+'::address_add' ,overwrite);
%mv3% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_address_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_address_add_father', 
						   '~thor_data400::key::gong_address_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_address_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_address_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::address_add' ));
						   
%bk4% := buildindex(DayBatchEda.Key_gong_add_phone,
	             '~thor_data400::key::gong_daily::'+filedate+'::phone_add' ,overwrite);
%mv4% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_phone_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_phone_add_father', 
						   '~thor_data400::key::gong_phone_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_phone_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_phone_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::phone_add' ));
						   
%bk5% := buildindex(DayBatchEda.key_gong_add_batch_czsslf,
	             '~thor_data400::key::gong_daily::'+filedate+'::czsslf_add' ,overwrite);
%mv5% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_czsslf_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_czsslf_add_father', 
						   '~thor_data400::key::gong_czsslf_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_czsslf_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_czsslf_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::czsslf_add' ));						   

%bk6% := buildindex(DayBatchEda.key_gong_add_batch_lczf,
	             '~thor_data400::key::gong_daily::'+filedate+'::lczf_add' ,overwrite);
%mv6% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_lczf_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_lczf_add_father', 
						   '~thor_data400::key::gong_lczf_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_lczf_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_lczf_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::lczf_add' ));						   

%bk7% := buildindex(gong.key_remove,'~thor_data400::key::gong_daily::'+filedate+'::remove' ,overwrite,few);
%mv7% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_remove_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_remove_father', 
						   '~thor_data400::key::gong_remove_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_remove_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_remove_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::remove' ));

#uniquename(eda1)
#uniquename(eda2)
#uniquename(eda3)
#uniquename(eda4)
#uniquename(eda5)
#uniquename(mv8)
#uniquename(mv9)
#uniquename(mv10)
#uniquename(mv11)
#uniquename(mv12)

%eda1% := buildindex(EDA_VIA_XML.Key_npa_nxx_line_add,'~thor_data400::key::gong_daily::'+filedate+'::eda_npa_nxx_line_add' ,overwrite);
%mv8% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_father', 
						   '~thor_data400::key::gong_eda_npa_nxx_line_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_npa_nxx_line_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::eda_npa_nxx_line_add' ));

%eda2% := buildindex(EDA_VIA_XML.Key_st_bizword_city_add,'~thor_data400::key::gong_daily::'+filedate+'::eda_st_bizword_city_add' ,overwrite);
%mv9% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_father', 
						   '~thor_data400::key::gong_eda_st_bizword_city_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_bizword_city_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::eda_st_bizword_city_add' ));

%eda3% := buildindex(EDA_VIA_XML.Key_st_city_prim_name_prim_range_add,'~thor_data400::key::gong_daily::'+filedate+'::eda_st_city_prim_name_prim_range_add' ,overwrite);
%mv10% := sequential(	  
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_father', 
						   '~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::eda_st_city_prim_name_prim_range_add' ));

%eda4% := buildindex(EDA_VIA_XML.Key_st_lname_city_add,'~thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_city_add' ,overwrite);
%mv11% := sequential(	
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_father', 
						   '~thor_data400::key::gong_eda_st_lname_city_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_city_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_city_add' ));

%eda5% := buildindex(EDA_VIA_XML.Key_st_lname_fname_city_add,'~thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_fname_city_add' ,overwrite);
%mv12% := sequential(	 
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_father', 
						   '~thor_data400::key::gong_eda_st_lname_fname_city_add_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_eda_st_lname_fname_city_add_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::eda_st_lname_fname_city_add' ));
						   
// **** History Keys *** //

#uniquename(hist1)
#uniquename(hist2)
#uniquename(hist3)
#uniquename(hist4)
#uniquename(mvhist1)
#uniquename(mvhist2)
#uniquename(mvhist3)
#uniquename(mvhist4)

%hist1% := buildindex(gong.key_daily_history_address,'~thor_data400::key::gong_daily::'+filedate+'::address' ,overwrite);
%mvhist1% := sequential(	 
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_address_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_address_father', 
						   '~thor_data400::key::gong_daily_address_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_address_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_address_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::address' ));

%hist2% := buildindex(gong.Key_daily_History_Phone,'~thor_data400::key::gong_daily::'+filedate+'::phone' ,overwrite);
%mvhist2% := sequential(	 
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_phone_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_phone_father', 
						   '~thor_data400::key::gong_daily_phone_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_phone_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_phone_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::phone' ));
						   
%hist3% := buildindex(gong.Key_daily_History_Name,'~thor_data400::key::gong_daily::'+filedate+'::name' ,overwrite);
%mvhist3% := sequential(	 
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_name_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_name_father', 
						   '~thor_data400::key::gong_daily_name_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_name_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_name_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::name' ));

%hist4% := buildindex(gong.Key_daily_History_Zip_Name,'~thor_data400::key::gong_daily::'+filedate+'::zip_name' ,overwrite);
%mvhist4% := sequential(	 
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_zip_name_father'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_zip_name_father', 
						   '~thor_data400::key::gong_daily_zip_name_built',, true),
			FileServices.ClearSuperFile('~thor_data400::key::gong_daily_zip_name_built'),
			FileServices.AddSuperFile('~thor_data400::key::gong_daily_zip_name_built', 
						   '~thor_data400::key::gong_daily::'+filedate+'::zip_name' ));



#uniquename(post1)
#uniquename(post2)

%post1% := ut.SF_MaintBuilt('~thor_data400::base::gong_daily_additions');
%post2% := sequential(
		fileservices.startsuperfiletransaction(),
			fileservices.clearsuperfile('~thor_data400::base::gong_daily_deletions_built'),
			fileservices.addsuperfile('~thor_data400::base::gong_daily_deletions_built',
			                          '~thor_data400::base::gong_daily_deletions',0,true),
		fileservices.finishsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::base::gong_daily_deletions_building',true));

#uniquename(full1)
#uniquename(full2)		

%full1% := parallel(%bk1%,%bk2%,%bk3%,%bk4%,%bk5%,%bk6%,%eda1%,%eda2%,%eda3%,%eda4%,%eda5%,
					%hist1%,%hist2%,%hist3%,%hist4%);
%full2% := %bk7%;

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
#uniquename(out12)
// -- History Keys ---- 
#uniquename(out13)
#uniquename(out14)
#uniquename(out15)
#uniquename(out16)

ut.mac_sk_move('~thor_data400::key::gong_did_add','Q',%out1%)
ut.mac_sk_move('~thor_data400::key::gong_hhid_add','Q',%out2%)
ut.mac_sk_move('~thor_data400::key::gong_address_add','Q',%out3%)
ut.mac_sk_move('~thor_data400::key::gong_phone_add','Q',%out4%)
ut.mac_sk_move('~thor_data400::key::gong_czsslf_add','Q',%out5%)
ut.mac_sk_move('~thor_data400::key::gong_lczf_add','Q',%out6%)
ut.mac_sk_move('~thor_data400::key::gong_remove','Q',%out7%)
ut.mac_sk_move('~thor_data400::key::gong_eda_npa_nxx_line_add','Q',%out8%)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_bizword_city_add','Q',%out9%)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add','Q',%out10%)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_city_add','Q',%out11%)
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_fname_city_add','Q',%out12%)
ut.mac_sk_move('~thor_data400::key::gong_daily_address','Q',%out13%)
ut.mac_sk_move('~thor_data400::key::gong_daily_phone','Q',%out14%)
ut.mac_sk_move('~thor_data400::key::gong_daily_name','Q',%out15%)
ut.mac_sk_move('~thor_data400::key::gong_daily_zip_name','Q',%out16%)

#uniquename(move1)
#uniquename(strata)

%move1% := parallel(%out1%, %out2%, %out3%, %out4%, %out5%, %out6%, %out7%, %out8%, %out9%, %out10%, %out11%, %out12%,
					 %out13%,%out14%,%out15%,%out16%);

%strata% := Gong.strata_popFileDailyAdditions;

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)

RoxieKeyBuild.Mac_Daily_Email_Local('GONG','SUCC', filedate, %send_succ_msg%,lssi.Notification_Email_Address);
RoxieKeyBuild.Mac_Daily_Email_Local('GONG','FAIL', filedate, %send_fail_msg%,lssi.Failure_Notification_Email_Address);

sequential(%prt_sample%, %pre1%,%pre2%,%full1%,%full2%,
			parallel(%mv1%,%mv2%,%mv3%,%mv4%,%mv5%,%mv6%,%mv8%,%mv9%,%mv10%,%mv11%,%mv12%,%mvhist1%,%mvhist2%,
					%mvhist3%,%mvhist4%,%mv7%),
			%post1%,%post2%,%move1%,%strata%) :
          success(%send_succ_msg%),
           failure(%send_fail_msg%);

endmacro;
			 