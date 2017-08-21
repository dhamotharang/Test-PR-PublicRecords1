/*2011-04-20T20:52:42Z (t gibson)
Bug 76499
*/
/*
import ut, gong;

r_temp := record
 File_Gong_full;
 unsigned6 did_temp:=0;
end;

//ta1 := table(File_Gong_full,r_temp);
/ta1 := PROJECT(File_Gong_full, TRANSFORM(r_temp,
						self.did_temp := left.did;
						self := LEFT;));
ta1 := File_Gong_full;
ut.mac_suppress_by_phonetype(ta1,phone10,st,currGong0,true,did);

/* Swap City Names - V City provides a better quality of names - Bug 42318 

currGong := project(currGong0,transform(recordof(File_Gong_full),
												self.p_city_name := left.v_city_name;
												self.v_city_name := left.p_city_name;
												self := left));

Gong.macRecordSuppression(currGong, currGongFilt, phone10);
*/
export File_Gong_Full_Prepped_For_Keys := 		
				DISTRIBUTE(dedup(
					PROJECT(gong_neustar.File_History_Full_Prepped_for_Keys(current_record_flag='Y'),recordof(Gong_Neustar.File_Gong_full)),
					record, except sequence_number,all))				//, phone10, name_last, name_first)
						: persist('~thor::persist::neustar::gong_full_prepped_for_keys');