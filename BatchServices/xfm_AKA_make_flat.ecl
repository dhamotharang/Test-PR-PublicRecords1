IMPORT BatchServices;

EXPORT layout_AKA_Batch_out 
       xfm_AKA_make_flat(BatchServices.Layouts.AKAs.rec_results_temp le,
                         DATASET(BatchServices.Layouts.AKAs.rec_results_temp) allRows) := TRANSFORM
	
		SELF.acctno                := le.acctno;
		
		SELF.akas_first_name_1    := allRows[1].fname;  
		SELF.akas_middle_name_1   := allRows[1].mname; 
		SELF.akas_last_name_1     := allRows[1].lname;   
		SELF.akas_name_suffix_1   := allRows[1].name_suffix; 
		SELF.akas_ssn_1           := allRows[1].ssn;         
		SELF.akas_dob_1           := allRows[1].dob;         
		
		SELF.akas_first_name_2    := allRows[2].fname;  
		SELF.akas_middle_name_2   := allRows[2].mname;  
		SELF.akas_last_name_2     := allRows[2].lname;  
		SELF.akas_name_suffix_2   := allRows[2].name_suffix; 
		SELF.akas_ssn_2           := allRows[2].ssn;    
		SELF.akas_dob_2           := allRows[2].dob;    
		
		SELF.akas_first_name_3    := allRows[3].fname;  
		SELF.akas_middle_name_3   := allRows[3].mname;  
		SELF.akas_last_name_3     := allRows[3].lname;  
		SELF.akas_name_suffix_3   := allRows[3].name_suffix; 
		SELF.akas_ssn_3           := allRows[3].ssn;    
		SELF.akas_dob_3           := allRows[3].dob;    
		
		SELF.akas_first_name_4    := allRows[4].fname;  
		SELF.akas_middle_name_4   := allRows[4].mname;  
		SELF.akas_last_name_4     := allRows[4].lname;  
		SELF.akas_name_suffix_4   := allRows[4].name_suffix; 
		SELF.akas_ssn_4           := allRows[4].ssn;    
		SELF.akas_dob_4           := allRows[4].dob;   
		
		SELF.akas_first_name_5    := allRows[5].fname;  
		SELF.akas_middle_name_5   := allRows[5].mname;  
		SELF.akas_last_name_5     := allRows[5].lname;  
		SELF.akas_name_suffix_5   := allRows[5].name_suffix; 
		SELF.akas_ssn_5           := allRows[5].ssn;    
		SELF.akas_dob_5           := allRows[5].dob;    
		
		SELF.akas_first_name_6    := allRows[6].fname;  
		SELF.akas_middle_name_6   := allRows[6].mname;  
		SELF.akas_last_name_6     := allRows[6].lname;  
		SELF.akas_name_suffix_6   := allRows[6].name_suffix; 
		SELF.akas_ssn_6           := allRows[6].ssn;    
		SELF.akas_dob_6           := allRows[6].dob;    
		
		SELF.akas_first_name_7    := allRows[7].fname;  
		SELF.akas_middle_name_7   := allRows[7].mname;  
		SELF.akas_last_name_7     := allRows[7].lname;  
		SELF.akas_name_suffix_7   := allRows[7].name_suffix; 
		SELF.akas_ssn_7           := allRows[7].ssn;    
		SELF.akas_dob_7           := allRows[7].dob;    
		
		SELF.akas_first_name_8    := allRows[8].fname;   
		SELF.akas_middle_name_8   := allRows[8].mname;   
		SELF.akas_last_name_8     := allRows[8].lname;   
		SELF.akas_name_suffix_8   := allRows[8].name_suffix; 
		SELF.akas_ssn_8           := allRows[8].ssn;     
		SELF.akas_dob_8           := allRows[8].dob;     
		
		SELF.akas_first_name_9    := allRows[9].fname;   
		SELF.akas_middle_name_9   := allRows[9].mname;   
		SELF.akas_last_name_9     := allRows[9].lname;   
		SELF.akas_name_suffix_9   := allRows[9].name_suffix;  
		SELF.akas_ssn_9           := allRows[9].ssn;     
		SELF.akas_dob_9           := allRows[9].dob;     
		
		SELF.akas_first_name_10   := allRows[10].fname;  
		SELF.akas_middle_name_10  := allRows[10].mname;  
		SELF.akas_last_name_10    := allRows[10].lname;  
		SELF.akas_name_suffix_10  := allRows[10].name_suffix; 
		SELF.akas_ssn_10          := allRows[10].ssn;    
		SELF.akas_dob_10          := allRows[10].dob;    

		SELF.akas_first_name_11   := allRows[11].fname;  
		SELF.akas_middle_name_11  := allRows[11].mname; 
		SELF.akas_last_name_11    := allRows[11].lname;   
		SELF.akas_name_suffix_11  := allRows[11].name_suffix; 
		SELF.akas_ssn_11          := allRows[11].ssn;         
		SELF.akas_dob_11          := allRows[11].dob;         
		
		SELF.akas_first_name_12   := allRows[12].fname;  
		SELF.akas_middle_name_12  := allRows[12].mname;  
		SELF.akas_last_name_12    := allRows[12].lname;  
		SELF.akas_name_suffix_12  := allRows[12].name_suffix; 
		SELF.akas_ssn_12          := allRows[12].ssn;    
		SELF.akas_dob_12          := allRows[12].dob;    
		
		SELF.akas_first_name_13   := allRows[13].fname;  
		SELF.akas_middle_name_13  := allRows[13].mname;  
		SELF.akas_last_name_13    := allRows[13].lname;  
		SELF.akas_name_suffix_13  := allRows[13].name_suffix; 
		SELF.akas_ssn_13          := allRows[13].ssn;    
		SELF.akas_dob_13          := allRows[13].dob;    
		
		SELF.akas_first_name_14   := allRows[14].fname;  
		SELF.akas_middle_name_14  := allRows[14].mname;  
		SELF.akas_last_name_14    := allRows[14].lname;  
		SELF.akas_name_suffix_14  := allRows[14].name_suffix; 
		SELF.akas_ssn_14          := allRows[14].ssn;    
		SELF.akas_dob_14          := allRows[14].dob;   
		
		SELF.akas_first_name_15   := allRows[15].fname;  
		SELF.akas_middle_name_15  := allRows[15].mname;  
		SELF.akas_last_name_15    := allRows[15].lname;  
		SELF.akas_name_suffix_15  := allRows[15].name_suffix; 
		SELF.akas_ssn_15          := allRows[15].ssn;    
		SELF.akas_dob_15          := allRows[15].dob;    
		
		SELF.akas_first_name_16   := allRows[16].fname;  
		SELF.akas_middle_name_16  := allRows[16].mname;  
		SELF.akas_last_name_16    := allRows[16].lname;  
		SELF.akas_name_suffix_16  := allRows[16].name_suffix; 
		SELF.akas_ssn_16          := allRows[16].ssn;    
		SELF.akas_dob_16          := allRows[16].dob;    
		
		SELF.akas_first_name_17   := allRows[17].fname;  
		SELF.akas_middle_name_17  := allRows[17].mname;  
		SELF.akas_last_name_17    := allRows[17].lname;  
		SELF.akas_name_suffix_17  := allRows[17].name_suffix; 
		SELF.akas_ssn_17          := allRows[17].ssn;    
		SELF.akas_dob_17          := allRows[17].dob;    
		
		SELF.akas_first_name_18   := allRows[18].fname;   
		SELF.akas_middle_name_18  := allRows[18].mname;   
		SELF.akas_last_name_18    := allRows[18].lname;   
		SELF.akas_name_suffix_18  := allRows[18].name_suffix; 
		SELF.akas_ssn_18          := allRows[18].ssn;     
		SELF.akas_dob_18          := allRows[18].dob;     
		
		SELF.akas_first_name_19   := allRows[19].fname;   
		SELF.akas_middle_name_19  := allRows[19].mname;   
		SELF.akas_last_name_19    := allRows[19].lname;   
		SELF.akas_name_suffix_19  := allRows[19].name_suffix;  
		SELF.akas_ssn_19          := allRows[19].ssn;     
		SELF.akas_dob_19          := allRows[19].dob;     
		
		SELF.akas_first_name_20  := allRows[20].fname;  
		SELF.akas_middle_name_20 := allRows[20].mname;  
		SELF.akas_last_name_20   := allRows[20].lname;  
		SELF.akas_name_suffix_20 := allRows[20].name_suffix; 
		SELF.akas_ssn_20         := allRows[20].ssn;    
		SELF.akas_dob_20         := allRows[20].dob;    	
		SELF                       := le;
		
	END;