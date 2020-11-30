Import doxie,Data_Services,dx_Vintelligence;
EXPORT data_key_Vintelligence:=module
f_vintelligence 				:= VINA.file_vina_base;
// remove all new fields

shared dedup_f_vintelligence := DEDUP(SORT(DISTRIBUTE(f_vintelligence,HASH(match_vin)),RECORD,LOCAL),RECORD, EXCEPT proactive_vin);

shared tbl_vin1									:= PROJECT(dedup_f_vintelligence,transform(dx_Vintelligence.layouts.r_VintelligencePart1,
																	 self.l_vin1  := left.match_vin[1];
																	 self.l_vin2  := left.match_vin[2];
																	 self.l_vin3  := left.match_vin[3];
																	 self.l_vin4  := left.match_vin[4];
																	 self.l_vin5  := left.match_vin[5];
																	 self.l_vin6  := left.match_vin[6];
																	 self.l_vin7  := left.match_vin[7];
																	 self.l_vin8  := left.match_vin[8];
																	 self.l_vin9  := left.match_vin[9];
																	 self.l_vin10 := left.match_vin[10];
																	 self.l_vin11 := left.match_vin[11];
																	 self.l_vin12 := left.match_vin[12];
																	 self.l_vin13 := left.match_vin[13];
																	 self.l_vin14 := left.match_vin[14];
																	 self.l_vin15 := left.match_vin[15];
																	 self.l_vin16 := left.match_vin[16];
																	 self.l_vin17 := left.match_vin[17];
																	 SELF:=LEFT;));
																	 
shared tbl_vin2									:= PROJECT(dedup_f_vintelligence,transform(dx_Vintelligence.layouts.r_VintelligencePart2,
																	 self.l_vin1  := left.match_vin[1];
																	 self.l_vin2  := left.match_vin[2];
																	 self.l_vin3  := left.match_vin[3];
																	 self.l_vin4  := left.match_vin[4];
																	 self.l_vin5  := left.match_vin[5];
																	 self.l_vin6  := left.match_vin[6];
																	 self.l_vin7  := left.match_vin[7];
																	 self.l_vin8  := left.match_vin[8];
																	 self.l_vin9  := left.match_vin[9];
																	 self.l_vin10 := left.match_vin[10];
																	 self.l_vin11 := left.match_vin[11];
																	 self.l_vin12 := left.match_vin[12];
																	 self.l_vin13 := left.match_vin[13];
																	 self.l_vin14 := left.match_vin[14];
																	 self.l_vin15 := left.match_vin[15];
																	 self.l_vin16 := left.match_vin[16];
																	 self.l_vin17 := left.match_vin[17];
																	 SELF:=LEFT;));

export File1:=tbl_vin1;
export File2:=tbl_vin2;
end;