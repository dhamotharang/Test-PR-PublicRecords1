export Stats(

	 dataset(layouts.input.sprayed)	pDataset
	,string 												pFileType

) :=
function

	// -- Stats
	dFor_Stats := project(pDataset,transform({layouts.input.sprayed,string File}, self := left;self.File := pFileType));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dFor_Stats.File  ;
		Subject1_First_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject1.First_Name		<>'',1,0));
		Subject1_Middle_Name_CountNonBlank  := sum(group,if(dFor_Stats.Subject1.Middle_Name 	<>'',1,0));
		Subject1_Last_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject1.Last_Name   	<>'',1,0));
		Subject1_Suffix_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject1.Suffix      	<>'',1,0));
		Subject1_DOB_MMDDYYYY_CountNonBlank := sum(group,if(dFor_Stats.Subject1.DOB_MMDDYYYY	<>'',1,0));
		Subject1_DL_CountNonBlank 					:= sum(group,if(dFor_Stats.Subject1.DL          	<>'',1,0));
		Subject1_DL_State_CountNonBlank  		:= sum(group,if(dFor_Stats.Subject1.DL_State    	<>'',1,0));
		Subject1_Gender_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject1.Gender      	<>'',1,0));
		Subject1_SSN_CountNonBlank  				:= sum(group,if(dFor_Stats.Subject1.SSN         	<>'',1,0));
		Subject1_Policy_No_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject1.Policy_No    	<>'',1,0));
    
		Subject1_CURRENT_ADDRESS_Street_Name_CountNonBlank	:= sum(group,if(dFor_Stats.Subject1.CURRENT_ADDRESS.Street_Name    	<>'',1,0));
		Subject1_FORMER_ADDRESS_Street_Name_CountNonBlank		:= sum(group,if(dFor_Stats.Subject1.FORMER_ADDRESS.Street_Name    	<>'',1,0));

		Subject2_First_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject2.First_Name		<>'',1,0));
		Subject2_Middle_Name_CountNonBlank  := sum(group,if(dFor_Stats.Subject2.Middle_Name 	<>'',1,0));
		Subject2_Last_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject2.Last_Name   	<>'',1,0));
		Subject2_Suffix_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject2.Suffix      	<>'',1,0));
		Subject2_DOB_MMDDYYYY_CountNonBlank := sum(group,if(dFor_Stats.Subject2.DOB_MMDDYYYY	<>'',1,0));
		Subject2_DL_CountNonBlank 					:= sum(group,if(dFor_Stats.Subject2.DL          	<>'',1,0));
		Subject2_DL_State_CountNonBlank  		:= sum(group,if(dFor_Stats.Subject2.DL_State    	<>'',1,0));
		Subject2_Gender_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject2.Gender      	<>'',1,0));
		Subject2_SSN_CountNonBlank  				:= sum(group,if(dFor_Stats.Subject2.SSN         	<>'',1,0));
		Subject2_Policy_No_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject2.Policy_No    	<>'',1,0));
    
		Subject2_CURRENT_ADDRESS_Street_Name_CountNonBlank	:= sum(group,if(dFor_Stats.Subject2.CURRENT_ADDRESS.Street_Name    	<>'',1,0));
		Subject2_FORMER_ADDRESS_Street_Name_CountNonBlank		:= sum(group,if(dFor_Stats.Subject2.FORMER_ADDRESS.Street_Name    	<>'',1,0));

		Subject3_First_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject3.First_Name		<>'',1,0));
		Subject3_Middle_Name_CountNonBlank  := sum(group,if(dFor_Stats.Subject3.Middle_Name 	<>'',1,0));
		Subject3_Last_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject3.Last_Name   	<>'',1,0));
		Subject3_Suffix_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject3.Suffix      	<>'',1,0));
		Subject3_DOB_MMDDYYYY_CountNonBlank := sum(group,if(dFor_Stats.Subject3.DOB_MMDDYYYY	<>'',1,0));
		Subject3_DL_CountNonBlank 					:= sum(group,if(dFor_Stats.Subject3.DL          	<>'',1,0));
		Subject3_DL_State_CountNonBlank  		:= sum(group,if(dFor_Stats.Subject3.DL_State    	<>'',1,0));
		Subject3_Gender_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject3.Gender      	<>'',1,0));
		Subject3_SSN_CountNonBlank  				:= sum(group,if(dFor_Stats.Subject3.SSN         	<>'',1,0));
		Subject3_Policy_No_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject3.Policy_No    	<>'',1,0));
    
		Subject3_CURRENT_ADDRESS_Street_Name_CountNonBlank	:= sum(group,if(dFor_Stats.Subject3.CURRENT_ADDRESS.Street_Name    	<>'',1,0));
		Subject3_FORMER_ADDRESS_Street_Name_CountNonBlank		:= sum(group,if(dFor_Stats.Subject3.FORMER_ADDRESS.Street_Name    	<>'',1,0));

		Subject4_First_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject4.First_Name		<>'',1,0));
		Subject4_Middle_Name_CountNonBlank  := sum(group,if(dFor_Stats.Subject4.Middle_Name 	<>'',1,0));
		Subject4_Last_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject4.Last_Name   	<>'',1,0));
		Subject4_Suffix_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject4.Suffix      	<>'',1,0));
		Subject4_DOB_MMDDYYYY_CountNonBlank := sum(group,if(dFor_Stats.Subject4.DOB_MMDDYYYY	<>'',1,0));
		Subject4_DL_CountNonBlank 					:= sum(group,if(dFor_Stats.Subject4.DL          	<>'',1,0));
		Subject4_DL_State_CountNonBlank  		:= sum(group,if(dFor_Stats.Subject4.DL_State    	<>'',1,0));
		Subject4_Gender_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject4.Gender      	<>'',1,0));
		Subject4_SSN_CountNonBlank  				:= sum(group,if(dFor_Stats.Subject4.SSN         	<>'',1,0));
		Subject4_Policy_No_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject4.Policy_No    	<>'',1,0));
    
		Subject4_CURRENT_ADDRESS_Street_Name_CountNonBlank	:= sum(group,if(dFor_Stats.Subject4.CURRENT_ADDRESS.Street_Name    	<>'',1,0));
		Subject4_FORMER_ADDRESS_Street_Name_CountNonBlank		:= sum(group,if(dFor_Stats.Subject4.FORMER_ADDRESS.Street_Name    	<>'',1,0));

		Subject5_First_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject5.First_Name		<>'',1,0));
		Subject5_Middle_Name_CountNonBlank  := sum(group,if(dFor_Stats.Subject5.Middle_Name 	<>'',1,0));
		Subject5_Last_Name_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject5.Last_Name   	<>'',1,0));
		Subject5_Suffix_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject5.Suffix      	<>'',1,0));
		Subject5_DOB_MMDDYYYY_CountNonBlank := sum(group,if(dFor_Stats.Subject5.DOB_MMDDYYYY	<>'',1,0));
		Subject5_DL_CountNonBlank 					:= sum(group,if(dFor_Stats.Subject5.DL          	<>'',1,0));
		Subject5_DL_State_CountNonBlank  		:= sum(group,if(dFor_Stats.Subject5.DL_State    	<>'',1,0));
		Subject5_Gender_CountNonBlank  			:= sum(group,if(dFor_Stats.Subject5.Gender      	<>'',1,0));
		Subject5_SSN_CountNonBlank  				:= sum(group,if(dFor_Stats.Subject5.SSN         	<>'',1,0));
		Subject5_Policy_No_CountNonBlank  	:= sum(group,if(dFor_Stats.Subject5.Policy_No    	<>'',1,0));
    
		Subject5_CURRENT_ADDRESS_Street_Name_CountNonBlank	:= sum(group,if(dFor_Stats.Subject5.CURRENT_ADDRESS.Street_Name    	<>'',1,0));
		Subject5_FORMER_ADDRESS_Street_Name_CountNonBlank		:= sum(group,if(dFor_Stats.Subject5.FORMER_ADDRESS.Street_Name    	<>'',1,0));
	end;                                                            
	
	dfill_stats := table(dFor_Stats, layout_stat, File,few);
	
	return dfill_stats;

end;