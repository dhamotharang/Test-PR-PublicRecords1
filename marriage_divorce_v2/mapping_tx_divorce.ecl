import ut;

/*
  string8 	File_Number;
  string32  Husbands_Name;
  string8 	Husbands_Age;
  string32 	Wifes_Name;
  string8 	Wifes_Age;
  string8 	Number_of_Children_Under_18;
  string16	Marriage_Date;
  string16 	Divorce_Date;
  string8 	County_Code_Where_Divorce_Occurred;
  string16 	County_Name_Where_Divorce_Occurred;
  string2 	lf;

*/


marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Divorce_TX_In le) := transform
 
 	
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;

 //divorce info
 self.filing_type  					:= '7';
 self.vendor       					:= 'TXM&D';
 self.source_file  					:= 'TX DEPT OF HEALTH';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'TX';
 
 //husband
 self.party1_name_format 		:= 'L';
 self.party1_type						:= 'H';
 self.party1_name        		:= stringlib.stringcleanspaces( if(trim(le.Husbands_Name)='','UNKNOWN',REGEXREPLACE(',',trim(le.Husbands_Name),'')));
 self.party1_age						:=REGEXREPLACE('([.?-~])',le.Husbands_Age,'');
   
//wife 
 self.party2_name_format 		:= 'L';
 self.party2_type						:= 'W';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.Wifes_Name)='','UNKNOWN',REGEXREPLACE(',',trim(le.Wifes_Name),'')));
 self.party2_age						:= REGEXREPLACE('([.?-~])',le.Wifes_Age,'');
 self.number_of_children		:= REGEXREPLACE('([.?-~])',le.Number_of_Children_Under_18,'');
 
 //marriage info
 //v_marr_dt									 := stringlib.stringfindreplace(REGEXREPLACE('([.?-~])',trim(le.Marriage_Date),''),'/',''); 
 self.marriage_dt        		 := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(le.Marriage_Date);
 
 
 
 //divorce info
 self.divorce_filing_number := trim(le.File_Number);
 self.divorce_county        := trim(le.County_Name_Where_Divorce_Occurred);
 
 //v_div_dt									 := stringlib.stringfindreplace(REGEXREPLACE('([.?-~])',trim(le.Divorce_Date),''),'/',''); 
 self.divorce_dt        		 := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(le.Divorce_Date);
 
 self := [];

 
end;

export mapping_tx_divorce := project(marriage_divorce_v2.File_Divorce_TX_In,t_map_to_common(left));// : persist('mar_div_tx_div');