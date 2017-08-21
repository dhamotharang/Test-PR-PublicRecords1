Import doxie,Data_Services;

f_vintelligence 				:= VINA.file_vina_base;
// remove all new fields
tbl_vin									:= PROJECT(f_vintelligence,transform({VINA.layout_vina_infile-[crlf]},SELF:=LEFT;));

//BUG 198611
tbl_vin_dedup						:= DEDUP(SORT(DISTRIBUTE(tbl_vin,HASH(match_vin)),RECORD,LOCAL),RECORD, EXCEPT proactive_vin);

EXPORT key_vin 					:= index(tbl_vin_dedup,
																 {
																		string1 l_vin1 := match_vin[1],
																		string1 l_vin2 := match_vin[2],
																		string1 l_vin3 := match_vin[3],
																		string1 l_vin4 := match_vin[4],
																		string1 l_vin5 := match_vin[5],
																		string1 l_vin6 := match_vin[6],
																		string1 l_vin7 := match_vin[7],
																		string1 l_vin8 := match_vin[8],
																		string1 l_vin9 := match_vin[9],
																		string1 l_vin10 := match_vin[10],
																		string1 l_vin11 := match_vin[11],
																		string1 l_vin12 := match_vin[12],
																		string1 l_vin13 := match_vin[13],
																		string1 l_vin14 := match_vin[14],
																		string1 l_vin15 := match_vin[15],
																		string1 l_vin16 := match_vin[16],
																		string1 l_vin17 := match_vin[17]
																 },{tbl_vin},
																 Data_Services.Data_location.Prefix('Vina')+'thor_data400::key::vina::vin_'+doxie.Version_SuperKey);