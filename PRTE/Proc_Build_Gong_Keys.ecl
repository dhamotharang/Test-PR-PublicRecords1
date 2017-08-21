import	_control, PRTE_CSV;

export Proc_Build_Gong_Keys(string pIndexVersion) := function


// g_did := Watchdog.DID_Gong;
// ut.mac_SF_Move('~thor_data400::base::gong_did','P',mv_gong2prod);

//lstUpdateNo   := fileservices.GetSuperFileSubCount(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2') : global; 
//lstUpdateName := fileservices.GetSuperFileSubName(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2',lstUpdateNo) : global;
//rundate   := stringlib.stringfilter(lstUpdateName,'0123456789')[4..11] : global;


rKeyGong__key__did	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__did;
end;
dKeyGong__key__did	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__did(did<>0), rKeyGong__key__did);
kKeyGong__key__did := index(dKeyGong__key__did, 
                             {l_did},	//{unsigned6 l_did := did},
							 {dKeyGong__key__did},
 '~prte::key::gong::' + pIndexVersion + '::did');
/*
rKeyGong__key__bdid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__bdid;
end;
dKeyGong__key__bdid	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__bdid, rKeyGong__key__bdid);
kKeyGong__key__bdid := index(dKeyGong__key__bdid(did<>0), 
                             {unsigned6 l_did := did},{gong.File_Gong_Did},
 '~prte::key::gong::' + pIndexVersion + '::did');
*/
rKeyGong__key__address	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__address;
end;
/*
dKeyGong__key__address	:= 	
	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__address(trim(prim_name)<>'', trim(z5)<>''),
			rKeyGong__key__address);
kKeyGong__key__address := index(dKeyGong__key__address, 
  {prim_name, st, z5, prim_range, sec_range, predir, suffix}, 
  {phone10, listed_name, fname, mname, lname, name_suffix, dual_name_flag, 
	 date_first_seen, listing_type, publish_code, omit_phone},
 '~prte::key::gong::' + pIndexVersion + '::address');
*/
//*RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_did,'~thor_data400::key::gong_weekly::'+rundate+'::did','~thor_data400::key::gong_did',bk_did,4);										 
//?RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_bdid,'~thor_data400::key::gong_weekly::'+rundate+'::bdid','~thor_data400::key::gong_bdid',bk_bdid,4);								 
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.Key_gong_phone,'~thor_data400::key::gong_weekly::'+rundate+'::phone','~thor_data400::key::gong_phone',bk_phone,4);
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.key_gong_batch_czsslf,'~thor_data400::key::gong_weekly::'+rundate+'::czsslf','~thor_data400::key::gong_czsslf',bk_czsslf,4);
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.key_gong_batch_lczf,'~thor_data400::key::gong_weekly::'+rundate+'::lczf','~thor_data400::key::gong_lczf',bk_lczf,4);											
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_npa_nxx_line,'~thor_data400::key::gong_weekly::'+rundate+'::eda_npa_nxx_line','~thor_data400::key::gong_eda_npa_nxx_line',bk_npa_nxx_line,4);		
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_lname_city,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_lname_city','~thor_data400::key::gong_eda_st_lname_city',bk_st_lname_city,4);			
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_lname_fname_city,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_lname_fname_city','~thor_data400::key::gong_eda_st_lname_fname_city',bk_st_lname_fname_city,4);
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_bizword_city,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_bizword_city','~thor_data400::key::gong_eda_st_bizword_city',bk_st_bizword_city,4);
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_city_prim_name_prim_range,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_city_prim_name_prim_range','~thor_data400::key::gong_eda_st_city_prim_name_prim_range',bk_st_city_prim_name_prim_range,4);
//*RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_address_current,'~thor_data400::key::gong_weekly::'+rundate+'::address_current','~thor_data400::key::gong_address_current',bk_addr_curr,4);									
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.Key_SurnameCount,'~thor_data400::key::gong_weekly::'+rundate+'::surnamecnt','~thor_data400::key::gong_surnamecnt',bk_srnmct,4);										 			 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_cbrs.key_phone_gong, '~thor_data400::key::cbrs.phone10_gong','~thor_data400::key::gong_weekly::'+rundate+'::cbrs.phone10_gong',kpg);

/****************  Gong HISTORY KEYS ***************************************/
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Address,'~thor_data400::key::gong_history_address','~thor_data400::key::gong_history::'+rundate+'::address',bk_addr);
rKeyGong__key__history__address	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__address;
end;
dKeyGong__key__history__address	:= 	
	project(PRTE_CSV.Gong.dthor_data400__key__gong_history__address,
			rKeyGong__key__history__address);
kKeyGong__key__history__address := index(dKeyGong__key__history__address, 
             {prim_name,
		    st,    z5, prim_range,    sec_range,
			current_flag, business_flag},
		    //boolean current_flag := if(current_record_flag='Y',true,false),
		    //boolean business_flag := if(listing_type_bus='B',true,false)},
		    {dKeyGong__key__history__address},
			'~prte::key::gong_history::' + pIndexVersion + '::address');
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Phone,'~thor_data400::key::gong_history_phone','~thor_data400::key::gong_history::'+rundate+'::phone',bk_phone);
rKeyGong__key__history__phone	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__phone;
end;
dKeyGong__key__history__phone	:= 	
	project(PRTE_CSV.Gong.dthor_data400__key__gong_history__phone(trim(prim_name)<>'', trim(z5)<>''),
			rKeyGong__key__history__phone);
kKeyGong__key__history__phone := index(dKeyGong__key__history__phone, 
              //{p7 := phone7,p3 := area_code,st,
			  //  boolean current_flag := if(current_record_flag='Y',true,false),
			  //  boolean business_flag := if(listing_type_bus='B',true,false)},
			  {p7, p3, st, current_flag, business_flag},
		    {dKeyGong__key__history__phone},
			'~prte::key::gong_history::' + pIndexVersion + '::phone');
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Did,'~thor_data400::key::gong_history_did','~thor_data400::key::gong_history::'+rundate+'::did',bk_did);
rKeyGong__key__history__did	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__did;
end;
dKeyGong__key__history__did	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_history__did(did<>0), rKeyGong__key__history__did);
kKeyGong__key__history__did := index(dKeyGong__key__history__did, 
                          //{unsigned6 l_did := did, 
						  //boolean current_flag := if(current_record_flag='Y',true,false),
						  //boolean business_flag := if(listing_type_bus='B',true,false)},
						  {l_did, current_flag, business_flag},
						  {dKeyGong__key__history__did},
 '~prte::key::gong_history::' + pIndexVersion + '::did');								 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Hhid,'~thor_data400::key::gong_history_hhid','~thor_data400::key::gong_history::'+rundate+'::hhid',bk_hhid);
rKeyGong__key__history__hhid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__hhid;
end;
dKeyGong__key__history__hhid	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_history__hhid(hhid<>0), rKeyGong__key__history__hhid);
kKeyGong__key__history__hhid := index(dKeyGong__key__history__hhid, 
                            //{unsigned6 s_hhid := hhid,
						    //boolean current_flag := if(current_record_flag='Y',true,false),
						    //boolean business_flag := if(listing_type_bus='B',true,false)},
						  {s_hhid, current_flag, business_flag},
						  {dKeyGong__key__history__hhid},
 '~prte::key::gong_history::' + pIndexVersion + '::hhid');

////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_BDID,'~thor_Data400::key::gong_hist_bdid','~thor_data400::key::gong_history::'+rundate+'::bdid',bk_bdid);
rKeyGong__key__history__bdid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__bdid;
end;
dKeyGong__key__history__bdid	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_history__bdid(bdid<>0), rKeyGong__key__history__bdid);
kKeyGong__key__history__bdid := index(dKeyGong__key__history__bdid, 
 						  {bdid},
						  {dKeyGong__key__history__bdid},
 '~prte::key::gong_history::' + pIndexVersion + '::bdid');								 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Name,'~thor_data400::key::gong_history_name','~thor_data400::key::gong_history::'+rundate+'::name',bk_name);
rKeyGong__key__history__name	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__name;
end;
dKeyGong__key__history__name := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__name(trim(name_last)<>''), rKeyGong__key__history__name);
kKeyGong__key__history__name := index(dKeyGong__key__history__name, 
            //{string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
				{dph_name_last,
							name_last,
							st,
              p_name_first, //string20 p_name_first := NID.PreferredFirstNew(name_first),
							name_first},
						  {dKeyGong__key__history__name},
 '~prte::key::gong_history::' + pIndexVersion + '::name');								 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_zip_name,'~thor_data400::key::gong_history_zip_name','~thor_data400::key::gong_history::'+rundate+'::zip_name',bk_zip_name);					
rKeyGong__key__history__zip_name	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__zip_name;
end;
dKeyGong__key__history__zip_name := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__zip_name(metaphonelib.DMetaPhone1(name_last) <> ''),
											rKeyGong__key__history__zip_name);
kKeyGong__key__history__zip_name := index(dKeyGong__key__history__zip_name, 
             //{string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
			 {dph_name_last, zip5, p_name_first,
				//		  integer4 zip5 := (integer4)z5,
              //string20 p_name_first := NID.PreferredFirstNew(name_first),
						  name_last,
						  name_first
					       },
						  {dKeyGong__key__history__zip_name},
 '~prte::key::gong_history::' + pIndexVersion + '::zip_name');								 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_npa_nxx_line,'~thor_data400::key::gong_history_npa_nxx_line','~thor_data400::key::gong_history::'+rundate+'::npa_nxx_line',bk_npa_nxx_line);
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Surname,'~thor_data400::key::gong_history::qa::surnames','~thor_data400::key::gong_history::'+rundate+'::surnames',bk_surname);
rKeyGong__key__history__surname	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__surnames;
end;
dKeyGong__key__history__surname := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__surnames, rKeyGong__key__history__surname);
kKeyGong__key__history__surname := index(dKeyGong__key__history__surname, 
	{k_name_last,k_name_first,k_st},
	{dKeyGong__key__history__surname},
 '~prte::key::gong_history::' + pIndexVersion + '::surname');								 

//??RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Relocations.key_wdtgGong,'~thor_data400::key::gong_history_wdtg','~thor_data400::key::gong_history::'+rundate+'::wdtg',bk_wdtg);					 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_companyname,'~thor_data400::key::gong_history_companyname','~thor_data400::key::gong_history::'+rundate+'::companyname',bk_cmp_name);
rKeyGong__key__history__companyname	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__companyname;
end;
dKeyGong__key__history__companyname := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__companyname(listed_name_new<>''),
										rKeyGong__key__history__companyname);
kKeyGong__key__history__companyname := index(dKeyGong__key__history__companyname, 
						  {listed_name_new, st, p_city_name,current_flag},
						  //boolean current_flag := if(current_record_flag='Y',true,false)}, 
							{dKeyGong__key__history__companyname},
 '~prte::key::gong_history::' + pIndexVersion + '::companyname');								 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_city_st_name,'~thor_data400::key::gong_history_city_st_name','~thor_data400::key::gong_history::'+rundate+'::city_st_name',bk_csn);
rKeyGong__key__history__city_st_name	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__city_st_name;
end;
dKeyGong__key__history__city_st_name := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__city_st_name(trim(p_city_name)<>'', name_last<>''),
										rKeyGong__key__history__city_st_name);
kKeyGong__key__history__city_st_name := index(dKeyGong__key__history__city_st_name, 
			    //   {unsigned4 city_code := HASH((qstring25)city_name);
	            {city_code, st, dph_name_last,
						  //string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
						  name_last,
				//		  string20 p_name_first := NID.PreferredFirstVersionedStr(name_first, NID.version),
				 p_name_first, name_first},
							{dKeyGong__key__history__city_st_name},
 '~prte::key::gong_history::' + pIndexVersion + '::city_st_name');								 
////RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Gong.key_history_wild_name_zip,'~thor_data400::key::gong_history_wild_name_zip','~thor_data400::key::gong_history::'+rundate+'::wild_name_zip',bk_wnzip);
rKeyGong__key__history__wild_name_zip	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_history__wild_name_zip;
end;
dKeyGong__key__history__wild_name_zip := project(PRTE_CSV.Gong.dthor_data400__key__gong_history__wild_name_zip,
										rKeyGong__key__history__wild_name_zip);
kKeyGong__key__history__wild_name_zip := index(dKeyGong__key__history__wild_name_zip, 
             {name_last,
						  st,
						  name_first,zip5},
						  //integer4 zip5 := (integer4)z5},
							{dKeyGong__key__history__wild_name_zip},
 '~prte::key::gong_history::' + pIndexVersion + '::wild_name_zip');								 
/****************  End Gong HISTORY KEYS ***************************************/


// moved from full keys build - needs history completed to create 
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_did,'~thor_data400::key::gong_weekly::'+rundate+'::did','~thor_data400::key::gong_did',bk_did_curr,4);
// ?

//*RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_hhid,'~thor_data400::key::gong_weekly::'+rundate+'::hhid','~thor_data400::key::gong_hhid',bk_hhid_curr,4);
rKeyGong__key__hhid	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__hhid;
end;
dKeyGong__key__hhid	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__hhid(hhid<>0),
							rKeyGong__key__hhid);
kKeyGong__key__hhid := index(dKeyGong__key__hhid, 
                             {s_hhid},	//{unsigned6 s_hhid := hhid},
							 {dKeyGong__key__hhid},
 '~prte::key::gong::' + pIndexVersion + '::hhid');

////RoxieKeyBuild.Mac_SK_BuildProcess_Local(risk_indicators.Key_Phone_Table_v2, '~thor_data400::key::business_header::'+rundate+'::hri::phone10_v2','~thor_data400::key::phone_table_v2',Buildkey6);
////RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_cn,'~thor_data400::key::gong_weekly::'+rundate+'::cn','~thor_data400::key::gong_cn',bk_cn,4);
rKeyGong__key__cn	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__cn;
end;
dKeyGong__key__cn	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__cn,
							rKeyGong__key__cn);
kKeyGong__key__cn := index(dKeyGong__key__cn, 
               {string6 dph_cn := metaphonelib.DMetaPhone1(cn), cn, st, p_city_name, v_city_name, z5},{listed_name, phone10},
	 '~prte::key::gong::' + pIndexVersion + '::cn');

////RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_cn_to_company,'~thor_data400::key::gong_weekly::'+rundate+'::cn_to_company','~thor_data400::key::gong_cn_to_company',bk_cn_to_company,4);
rKeyGong__key__cn_to_company	:=
record
	PRTE_CSV.Gong.rthor_data400__key__gong_weekly__cn_to_company;
end;
dKeyGong__key__cn_to_company	:= 	project(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__cn_to_company,
							rKeyGong__key__cn_to_company);
kKeyGong__key__cn_to_company := index(dKeyGong__key__cn_to_company, 
					 {listed_name, st, p_city_name, z5, phone10}, 
					{dKeyGong__key__cn_to_company},
	 '~prte::key::gong::' + pIndexVersion + '::cn_to_company');

////RoxieKeyBuild.Mac_SK_BuildProcess_Local( risk_indicators.key_phone_table_fcra_v2 ,'~thor_data400::key::business_header::filtered::'+rundate+'::hri::phone10_v2','~thor_data400::key::phone_table_filtered_v2',BuildFCRAkey5);



	return	sequential(
				parallel(
				// Gong history keys
					build(kKeyGong__key__history__address, update),
					build(kKeyGong__key__history__phone, update),
					build(kKeyGong__key__history__did, update),
					build(kKeyGong__key__history__hhid, update),
					build(kKeyGong__key__history__bdid, update),
					build(kKeyGong__key__history__name, update),
					build(kKeyGong__key__history__zip_name, update),
					build(kKeyGong__key__history__surname, update),
					build(kKeyGong__key__history__companyname, update),
					build(kKeyGong__key__history__city_st_name, update),
					build(kKeyGong__key__history__wild_name_zip, update),
				//
					build(kKeyGong__key__did			, update),
					build(kKeyGong__key__hhid			, update),
					build(kKeyGong__key__cn				, update),
					build(kKeyGong__key__cn_to_company	, update)
				),
				PRTE.UpdateVersion('Gong Keys',										//	Package name
					 pIndexVersion,												//	Package version
					 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
					'B',		//	B = Boca, A = Alpharetta
					'N',		//	N = Non-FCRA, F = FCRA
					'N'			//	N = Do not also include boolean, Y = Include boolean, too
					)
				);

end;