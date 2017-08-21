import ut;

marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Marriage_MI_In le) := transform
 
		
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;

 //divorce info
 self.filing_type  					:= '3';
 self.vendor       					:= 'INGHM';
 self.source_file  					:= 'INGHAM COUNTY CLERK COURT';
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= 'MI';
 
 //husband
 self.party1_type			      := 'G';
 self.party1_name_format 		:= 'F';
 self.party1_name        		:=  stringlib.stringcleanspaces( if(trim(le.LMF_Name1)='','UNKNOWN',trim(le.LMF_Name1)));
 self.party1_age						:= le.Age1;
 self.party1_csz	    		  := le.csz1; 
//wife 
 self.party2_type			      := 'B';
 self.party2_name_format		:= 'F';
 self.party2_name        		:= stringlib.stringcleanspaces( if(trim(le.LMF_Name2)='','UNKNOWN',trim(le.LMF_Name2)));	
 self.party2_age						:= le.Age2;
 self.party2_csz	    		  := le.csz2; 
 self.marriage_filing_dt    := le.filing_dt1;
 self := [];

 
end;

export mapping_mi_marriage := project(marriage_divorce_v2.File_Marriage_MI_In,t_map_to_common(left))(party1_age <> '' and party1_csz <> '' and regexfind('Applicant',party1_name,0) = '');