/*2011-04-20T20:52:42Z (t gibson)
Bug 76499
*/
import ut;

r_temp := record
 Gong.File_Gong_full;
 unsigned6 did_temp:=0;
end;

ta1 := table(Gong.File_Gong_full,r_temp);

ut.mac_suppress_by_phonetype(ta1,phone10,st,currGong0,true,did_temp);

/* Swap City Names - V City provides a better quality of names - Bug 42318 */

currGong := project(currGong0,transform(recordof(Gong.File_Gong_full),
												self.p_city_name := left.v_city_name;
												self.v_city_name := left.p_city_name;
												self := left));

Gong.macRecordSuppression(currGong, currGongFilt, phone10);

export File_Gong_Full_Prepped_For_Keys := distribute(currGongFilt,random());