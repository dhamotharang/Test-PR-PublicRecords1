
//pop stats


   dob_stats := record
   count_ := count(group);
   integer orig_pmghouseold_id_cnt    		:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_pmghouseold_id <> '',1,0));
	 integer orig_pmghouseold_id_prcntg    	:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_pmghouseold_id <> '',100,0));
	 
	 integer orig_pmgindividual_id_cnt    		:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_pmgindividual_id <> '',1,0));
	 integer orig_pmgindividual_id_prcntg    	:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_pmgindividual_id <> '',100,0));
	 
	 integer orig_first_name_cnt    		:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_first_name <> '',1,0));
	 integer orig_first_name_prcntg    	:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_first_name <> '',100,0));
	 
	 integer orig_last_name_cnt     		:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_last_name <> '',1,0));
	 integer orig_last_name_prcntg     	:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_last_name <> '',100,0));
	 
	 integer orig_email_cnt   	:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_email <> '',1,0));
	 integer orig_email_prcntg  := ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_email <> '',100,0));
	 
	 integer orig_address_cnt    				:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_address <> '',1,0));
	 integer orig_address_prcntg    			:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_address <> '',100,0));
	 
	 integer orig_city_cnt    			  	:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_city <> '',1,0));
	 integer orig_city_prcntg    			  := ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_city <> '',100,0));
	 integer orig_state_cnt  	 		    	:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_state <> '',1,0));
	 integer orig_state_prcntg  	 		  := ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_state <> '',100,0));
	 integer orig_zip_cnt    				  	:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_zip <> '',1,0));
	 integer orig_zip_prcntg    				:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_zip <> '',100,0));
	 integer orig_zip4_cnt    				  	:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_zip4 <> '',1,0));
	 integer orig_zip4_prcntg    				:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_zip4 <> '',100,0));
	 //integer orig_phone_cnt   					:= sum(group, if(dDID_records.orig_phone <> '',1,0));
	 //integer orig_phone_prcntg   				:= ave(group, if(dDID_records.orig_phone <> '',100,0));
	 integer orig_login_date_cnt  	:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_login_date <> '',1,0));
	 integer orig_login_date_prcntg := ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_login_date <> '',100,0));
	 integer orig_ip_cnt   				:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_ip <> '',1,0));
	 integer orig_ip_prcntg   		:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_ip <> '',100,0));
	 //integer orig_dob_cnt   						:= sum(group, if(dDID_records.orig_dob <> '',1,0));
	 //integer orig_dob_prcntg   					:= ave(group, if(dDID_records.orig_dob <> '',100,0));
	 integer orig_site_cnt   						:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_site <> '',1,0));
	 integer orig_site_prcntg   					:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_site <> '',100,0));
	 integer orig_source_cnt   						:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_source <> '',1,0));
	 integer orig_source_prcntg   					:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_source <> '',100,0));
	 integer orig_e360_id_cnt   						:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_e360_id <> '',1,0));
	 integer orig_e360_id_prcntg   					:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_e360_id <> '',100,0));
	 integer orig_teramedia_id_cnt   						:= sum(group, if(Standardized_Entiera_Data_DIDSSN.orig_teramedia_id <> '',1,0));
	 integer orig_teramedia_id_prcntg   					:= ave(group, if(Standardized_Entiera_Data_DIDSSN.orig_teramedia_id <> '',100,0));
	 
	 
	 
	 
	//integer orig_record_id_cnt  	    	:= sum(group, if(dDID_records.orig_record_id <> '',1,0));
    //integer orig_record_id_prcntg  	  := ave(group, if(dDID_records.orig_record_id <> '',100,0));
	 unsigned6 did_cnt   					  		:= sum(group, if(Standardized_Entiera_Data_DIDSSN.did  <> 0,1,0));
   unsigned6 did_prcntg    					  := AVE(group, if(Standardized_Entiera_Data_DIDSSN.did  <> 0,100,0));
end;

entiera_pop_stats := table(Standardized_Entiera_Data_DIDSSN,dob_stats,few);
output(entiera_pop_stats,all,named('entiera_pop_stats'));
//output(choosen(dataline_dob_pop_stats,1000),,named('Entiera_Data_Sample'));
//output(choosen(dataline_dob_pop_stats,1000),,named('Entiera_Data_Sample'));;

