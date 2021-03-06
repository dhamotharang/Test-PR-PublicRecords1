import ut, risk_indicators, gong, header_services, header ;

ut.mac_suppress_by_phonetype(File_Gong_History_FullEx,phone10,st,histGong_out,true,did);

/* Swap City Names - V City provides a better quality of names - Bug 42318 */
header.Mac_Apply_Title(histGong_out, name_prefix, name_first, name_middle, temp_apply_title) ;

trSwapCityNames := project(temp_apply_title, 
											transform(recordof(histGong_out),
												self.p_city_name := left.v_city_name;
												self.v_city_name := left.p_city_name;
												self := left));

Gong.macRecordSuppression(trSwapCityNames, trSwapCityNamesFilt, phone10) ;

layout_gong_inj := RECORD
 gong.Layout_history ;
 string2 eor ;
END;

header_services.Supplemental_Data.mac_verify('file_gong_inj.txt', layout_gong_inj , attr);

gong_append_in := attr();

gong_in := PROJECT (gong_append_in, transform(Layout_historyaid, self := left)) ;

trSwapCityNamesFiltWithGong := trSwapCityNamesFilt + gong_in ;

export File_History_Full_Prepped_for_Keys := trSwapCityNamesFiltWithGong:persist('~thor_data400::persist::gong_history_full_prepped_for_keys');
