export Layouts := module

	export reportLineLayoutIn 						:= record,maxlength(137) //vendor Raw layout
	
		string 	 lineVary;	
				
	end;
	
	export reportLineLen 									:= record,maxlength(150)
	
		integer  lineLen;
		reportLineLayoutIn;
		
	end;
			
	export sequencedLines 								:= record  							 //temp layout to sequence records
	
		integer  position := 0;
		string 	 lineVary;	
		
	end;
					
	export keyPositionLines  							:= record
	
		integer  keyValue := 0;
		sequencedLines;
		
	end;
	
	export reportLIne_withSeq							:= record
	
		unsigned1	cnt;
		reportLineLayoutIn;
	
	end;

	export partialLine_Layout 						:= record
	
		integer  keyValue;
		string68 org_name;
		string2  org_type;
		string8  org_id;
		string22 org_type_desc;
		string2  Incorp_State;
		string8  paid_capitol_rep;
		string1  paid_capitol_mills;
		string8  inc_date;
		string3  current_status;
		string10 current_status_date;
		string36 reg_agent_name;
		string32 reg_agent_addr1;
		string30 reg_agent_city;
		string2  reg_agent_state;
		string10 reg_agent_zip;
		
	end; 

	export fullLine_Layout 								:= record

		partialLine_Layout;	
		string37 Corporation_Alpha_Sort_Name;
		string32 reg_agent_addr2;
		string11 most_recent_locator_number;
		string11 most_recent_form20;
		
	end; 
	
	export fullLine_Raw_Base 							:= record
	
		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		fullLine_Layout;	
			
	End;

	//Temporary layouts
	export TempComfichexRawLayout 				:= record
		unsigned 			seqno;
		unsigned 			groupno;
		unsigned 			recno;
		integer  			ctr;
		string133 		lineVary;
		string133 		lineVary1;
		string133 		lineVary2;
		string133 		lineVary3;
		string133 		lineVary4;
		string133 		lineVary5;
		string1000 		lineVary6;
	end;

	export TempComfichexFixedLayoutIn			:= record
		integer  			keyValue;
		string1000		lineVary;
	end;

end;
