
IMPORT BatchServices;

EXPORT layout_OthersUsingSSN_Batch_out xfm_OthersUsingSSN_make_flat(BatchServices.Layouts.OthersUsingSSN.rec_results_raw le,
                                                                    DATASET(BatchServices.Layouts.OthersUsingSSN.rec_results_raw) allRows) := 
	TRANSFORM
	
		SELF.acctno                := le.acctno;
		
		SELF.other_first_name_1    := allRows[1].fname;  
		SELF.other_middle_name_1   := allRows[1].mname; 
		SELF.other_last_name_1     := allRows[1].lname;   
		SELF.other_name_suffix_1   := allRows[1].name_suffix; 
		SELF.other_ssn_1           := allRows[1].ssn;         
		SELF.other_dob_1           := (STRING8)allRows[1].dob;         
		SELF.other_dod_1           := allRows[1].dod;         
		
		SELF.other_first_name_2    := allRows[2].fname;  
		SELF.other_middle_name_2   := allRows[2].mname;  
		SELF.other_last_name_2     := allRows[2].lname;  
		SELF.other_name_suffix_2   := allRows[2].name_suffix; 
		SELF.other_ssn_2           := allRows[2].ssn;    
		SELF.other_dob_2           := (STRING8)allRows[2].dob;    
		SELF.other_dod_2           := allRows[2].dod;    
		
		SELF.other_first_name_3    := allRows[3].fname;  
		SELF.other_middle_name_3   := allRows[3].mname;  
		SELF.other_last_name_3     := allRows[3].lname;  
		SELF.other_name_suffix_3   := allRows[3].name_suffix; 
		SELF.other_ssn_3           := allRows[3].ssn;    
		SELF.other_dob_3           := (STRING8)allRows[3].dob;    
		SELF.other_dod_3           := allRows[3].dod;    
		
		SELF.other_first_name_4    := allRows[4].fname;  
		SELF.other_middle_name_4   := allRows[4].mname;  
		SELF.other_last_name_4     := allRows[4].lname;  
		SELF.other_name_suffix_4   := allRows[4].name_suffix; 
		SELF.other_ssn_4           := allRows[4].ssn;    
		SELF.other_dob_4           := (STRING8)allRows[4].dob;   
		SELF.other_dod_4           := allRows[4].dod;     
		
		SELF.other_first_name_5    := allRows[5].fname;  
		SELF.other_middle_name_5   := allRows[5].mname;  
		SELF.other_last_name_5     := allRows[5].lname;  
		SELF.other_name_suffix_5   := allRows[5].name_suffix; 
		SELF.other_ssn_5           := allRows[5].ssn;    
		SELF.other_dob_5           := (STRING8)allRows[5].dob;    
		SELF.other_dod_5           := allRows[5].dod;    
		
		SELF.other_first_name_6    := allRows[6].fname;  
		SELF.other_middle_name_6   := allRows[6].mname;  
		SELF.other_last_name_6     := allRows[6].lname;  
		SELF.other_name_suffix_6   := allRows[6].name_suffix; 
		SELF.other_ssn_6           := allRows[6].ssn;    
		SELF.other_dob_6           := (STRING8)allRows[6].dob;    
		SELF.other_dod_6           := allRows[6].dod;    
		
		SELF.other_first_name_7    := allRows[7].fname;  
		SELF.other_middle_name_7   := allRows[7].mname;  
		SELF.other_last_name_7     := allRows[7].lname;  
		SELF.other_name_suffix_7   := allRows[7].name_suffix; 
		SELF.other_ssn_7           := allRows[7].ssn;    
		SELF.other_dob_7           := (STRING8)allRows[7].dob;    
		SELF.other_dod_7           := allRows[7].dod;    	
		
		SELF.other_first_name_8    := allRows[8].fname;   
		SELF.other_middle_name_8   := allRows[8].mname;   
		SELF.other_last_name_8     := allRows[8].lname;   
		SELF.other_name_suffix_8   := allRows[8].name_suffix; 
		SELF.other_ssn_8           := allRows[8].ssn;     
		SELF.other_dob_8           := (STRING8)allRows[8].dob;     
		SELF.other_dod_8           := allRows[8].dod;    	 
		
		SELF.other_first_name_9    := allRows[9].fname;   
		SELF.other_middle_name_9   := allRows[9].mname;   
		SELF.other_last_name_9     := allRows[9].lname;   
		SELF.other_name_suffix_9   := allRows[9].name_suffix;  
		SELF.other_ssn_9           := allRows[9].ssn;     
		SELF.other_dob_9           := (STRING8)allRows[9].dob;     
		SELF.other_dod_9           := allRows[9].dod;    	 
		
		SELF.other_first_name_10   := allRows[10].fname;  
		SELF.other_middle_name_10  := allRows[10].mname;  
		SELF.other_last_name_10    := allRows[10].lname;  
		SELF.other_name_suffix_10  := allRows[10].name_suffix; 
		SELF.other_ssn_10          := allRows[10].ssn;    
		SELF.other_dob_10          := (STRING8)allRows[10].dob;    
		SELF.other_dod_10          := allRows[10].dod;    	
	
		SELF                       := le;
		
	END;