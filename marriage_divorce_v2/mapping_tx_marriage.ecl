import ut;

marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Marriage_TX_In le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;

 //divorce info
 self.filing_type  					:= '3';
 self.vendor       					:= 'TXM&D';
 self.source_file  					:= 'TX DEPT OF HEALTH';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'TX';
 
 //husband
 self.party1_name_format 		:= 'L';
 self.party1_type						:= 'G';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.HName)='','UNKNOWN',trim(le.HName)));
 self.party1_age						:=REGEXREPLACE('([.?-~])',le.HAGE,'');
   
//wife 
 self.party2_name_format 		:= 'L';
 self.party2_type						:= 'B';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.WNAME)='','UNKNOWN',trim(le.WNAME)));
 self.party2_age						:=REGEXREPLACE('([.?-~])',le.WAGE,'');
 
 
 //marriage info
 //v_marr_dt									 := stringlib.stringfindreplace(REGEXREPLACE('([.?-~])',trim(le.MARRDATE),''),'/',''); 
 self.marriage_dt        		 := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(le.MARRDATE);

                                 
 self.marriage_filing_number := trim(le.fnum);
 self.marriage_county        := trim(le.CNTYOFAPPMARRIAGE);
 
 
 
 self := [];

 
end;

export mapping_tx_marriage := project(marriage_divorce_v2.File_Marriage_TX_In,t_map_to_common(left));// : persist('mar_div_tx_mar');