EXPORT layout_email_Batch_out xfm_email_make_flat(BatchServices.Layouts.email.rec_results_raw le,
                                                  DATASET(BatchServices.Layouts.email.rec_results_raw) allRows) := 
	TRANSFORM
	
		SELF.acctno              := le.acctno;
		
		self.src_1						 := allRows[1].email_src;
	  self.orig_first_name_1       := allRows[1].orig_first_name;
		self.orig_last_name_1        := allRows[1].orig_last_name;
		self.orig_address_1          := allRows[1].orig_address;
		self.orig_city_1             := allRows[1].orig_city;
		self.orig_state_1            := allRows[1].orig_state;
		self.orig_zip_1              := allRows[1].orig_zip;
		self.orig_zip4_1             := allRows[1].orig_zip4;
		self.orig_email_1            := allRows[1].orig_email;
		self.orig_ip_1               := allRows[1].orig_ip;
		self.orig_login_date_1       := allRows[1].orig_login_date;
		self.orig_site_1             := allRows[1].orig_site;	
				
		self.title_1			 := allRows[1].title;				
		self.fname_1			 := allRows[1].fname;				
		self.mname_1			 := allRows[1].mname;			
		self.lname_1       := allRows[1].lname;				
		self.name_suffix_1 := allRows[1].name_suffix;				
		self.prim_range_1  := allRows[1].prim_range; 					
		self.predir_1      := allRows[1].predir;
		self.prim_name_1   := allRows[1].prim_name;				
		self.addr_suffix_1 := allRows[1].addr_suffix;  			
		self.postdir_1     := allRows[1].postdir; 		
		self.unit_desig_1  := allRows[1].unit_desig;	
		self.sec_range_1   := allRows[1].sec_range;				
		self.p_city_name_1 := allRows[1].p_city_name;				
		self.v_city_name_1 := allRows[1].v_city_name; 		 
		self.st_1          := allRows[1].st;						   
		self.zip_1         := allRows[1].zip;					  
		self.zip4_1        := allRows[1].zip4;									
		self.best_ssn_1              := allrows[1].best_ssn;
		self.best_dob_1              := allRows[1].best_dob;
		self.process_date_1          := allRows[1].process_date;
		
		//2
		self.src_2						 := allRows[2].email_src;
		self.orig_first_name_2       := allRows[2].orig_first_name;
		self.orig_last_name_2        := allRows[2].orig_last_name;
		self.orig_address_2          := allRows[2].orig_address;
		self.orig_city_2             := allRows[2].orig_city;
		self.orig_state_2            := allRows[2].orig_state;
		self.orig_zip_2              := allRows[2].orig_zip;
		self.orig_zip4_2             := allRows[2].orig_zip4;
		self.orig_email_2            := allRows[2].orig_email;
		self.orig_ip_2               := allRows[2].orig_ip;
		self.orig_login_date_2       := allRows[2].orig_login_date;
		self.orig_site_2             := allRows[2].orig_site;	
	
		self.title_2			 := allRows[2].title;				
		self.fname_2			   := allRows[2].fname;				
		self.mname_2			   := allRows[2].mname;			
		self.lname_2         := allRows[2].lname;				
		self.name_suffix_2   := allRows[2].name_suffix;				
		self.prim_range_2    := allRows[2].prim_range; 				
		self.predir_2        := allRows[2].predir;
		self.prim_name_2     := allRows[2].prim_name;	
		self.addr_suffix_2   := allRows[2].addr_suffix;  			
		self.postdir_2       := allRows[2].postdir; 			
		self.unit_desig_2    := allRows[2].unit_desig;		
		self.sec_range_2     := allRows[2].sec_range;				
		self.p_city_name_2   := allRows[2].p_city_name;				
		self.v_city_name_2   := allRows[2].v_city_name; 		 
		self.st_2            := allRows[2].st;						   
		self.zip_2           := allRows[2].zip;					  
		self.zip4_2          := allRows[2].zip4;									
		self.best_ssn_2              := allrows[2].best_ssn;
		self.best_dob_2              := allRows[2].best_dob;
		self.process_date_2          := allRows[2].process_date;
		
		
		//3
		self.src_3						 := allRows[3].email_src;
		self.orig_first_name_3       := allRows[3].orig_first_name;
		self.orig_last_name_3        := allRows[3].orig_last_name;
		self.orig_address_3          := allRows[3].orig_address;
		self.orig_city_3             := allRows[3].orig_city;
		self.orig_state_3            := allRows[3].orig_state;
		self.orig_zip_3              := allRows[3].orig_zip;
		self.orig_zip4_3             := allRows[3].orig_zip4;
		self.orig_email_3            := allRows[3].orig_email;
		self.orig_ip_3               := allRows[3].orig_ip;
		self.orig_login_date_3       := allRows[3].orig_login_date;
		self.orig_site_3             := allRows[3].orig_site;	

		self.title_3			 := allRows[3].title;				
		self.fname_3			 := allRows[3].fname;				
		self.mname_3			 := allRows[3].mname;			
		self.lname_3       := allRows[3].lname;				
		self.name_suffix_3 := allRows[3].name_suffix;				
		self.prim_range_3  := allRows[3].prim_range; 			
		self.predir_3      := allRows[3].predir;
		self.prim_name_3   := allRows[3].prim_name;			
		self.addr_suffix_3 := allRows[3].addr_suffix;  			
		self.postdir_3     := allRows[3].postdir; 		
		self.unit_desig_3  := allRows[3].unit_desig;		
		self.sec_range_3   := allRows[3].sec_range;				
		self.p_city_name_3 := allRows[3].p_city_name;				
		self.v_city_name_3 := allRows[3].v_city_name; 	 
		self.st_3          := allRows[3].st;				   
		self.zip_3         := allRows[3].zip;			  
		self.zip4_3        := allRows[3].zip4;								
		self.best_ssn_3              := allrows[3].best_ssn;
		self.best_dob_3              := allRows[3].best_dob;
		self.process_date_3          := allRows[3].process_date;
		
		
		//4
		self.src_4						 := allRows[4].email_src;
		self.orig_first_name_4       := allRows[4].orig_first_name;
		self.orig_last_name_4        := allRows[4].orig_last_name;
		self.orig_address_4          := allRows[4].orig_address;
		self.orig_city_4             := allRows[4].orig_city;
		self.orig_state_4            := allRows[4].orig_state;
		self.orig_zip_4              := allRows[4].orig_zip;
		self.orig_zip4_4             := allRows[4].orig_zip4;
		self.orig_email_4            := allRows[4].orig_email;
		self.orig_ip_4               := allRows[4].orig_ip;
		self.orig_login_date_4       := allRows[4].orig_login_date;
		self.orig_site_4             := allRows[4].orig_site;	

	  self.title_4			 := allRows[4].title;				
		self.fname_4			 := allRows[4].fname;				
		self.mname_4			 := allRows[4].mname;			
		self.lname_4       := allRows[4].lname;				
		self.name_suffix_4 := allRows[4].name_suffix;				
		self.prim_range_4  := allRows[4].prim_range; 				
		self.predir_4      := allRows[4].predir;
		self.prim_name_4   := allRows[4].prim_name;				
		self.addr_suffix_4 := allRows[4].addr_suffix;  			
		self.postdir_4     := allRows[4].postdir; 				
		self.unit_desig_4  := allRows[4].unit_desig;		
		self.sec_range_4   := allRows[4].sec_range;				
		self.p_city_name_4 := allRows[4].p_city_name;				
		self.v_city_name_4 := allRows[4].v_city_name; 			 
		self.st_4          := allRows[4].st;						   
		self.zip_4         := allRows[4].zip;					  
		self.zip4_4        := allRows[4].zip4;								
		self.best_ssn_4              := allrows[4].best_ssn;
		self.best_dob_4              := allRows[4].best_dob;
		self.process_date_4          := allRows[4].process_date;
	
		
		//5
		self.src_5						 := allRows[5].email_src;
		self.orig_first_name_5       := allRows[5].orig_first_name;
		self.orig_last_name_5        := allRows[5].orig_last_name;
		self.orig_address_5          := allRows[5].orig_address;
		self.orig_city_5             := allRows[5].orig_city;
		self.orig_state_5            := allRows[5].orig_state;
		self.orig_zip_5              := allRows[5].orig_zip;
		self.orig_zip4_5             := allRows[5].orig_zip4;
		self.orig_email_5            := allRows[5].orig_email;
		self.orig_ip_5               := allRows[5].orig_ip;
		self.orig_login_date_5       := allRows[5].orig_login_date;
		self.orig_site_5             := allRows[5].orig_site;	

		self.title_5	  		 := allRows[5].title;				
		self.fname_5			   := allRows[5].fname;				
		self.mname_5			   := allRows[5].mname;			
		self.lname_5         := allRows[5].lname;				
		self.name_suffix_5   := allRows[5].name_suffix;				
		self.prim_range_5    := allRows[5].prim_range; 					
		self.predir_5        := allRows[5].predir;
		self.prim_name_5     := allRows[5].prim_name;				
		self.addr_suffix_5   := allRows[5].addr_suffix;  			
		self.postdir_5       := allRows[5].postdir; 			
		self.unit_desig_5    := allRows[5].unit_desig;	
		self.sec_range_5     := allRows[5].sec_range;			
		self.p_city_name_5   := allRows[5].p_city_name;					
		self.v_city_name_5   := allRows[5].v_city_name; 		 
		self.st_5            := allRows[5].st;						   
		self.zip_5           := allRows[5].zip;				  
		self.zip4_5          := allRows[5].zip4;							
		self.best_ssn_5              := allrows[5].best_ssn;
		self.best_dob_5              := allRows[5].best_dob;
		self.process_date_5          := allRows[5].process_date;
		
		
		// 6
		self.src_6						 := allRows[6].email_src;
		self.orig_first_name_6       := allRows[6].orig_first_name;
		self.orig_last_name_6        := allRows[6].orig_last_name;
		self.orig_address_6          := allRows[6].orig_address;
		self.orig_city_6             := allRows[6].orig_city;
		self.orig_state_6            := allRows[6].orig_state;
		self.orig_zip_6              := allRows[6].orig_zip;
		self.orig_zip4_6             := allRows[6].orig_zip4;
		self.orig_email_6            := allRows[6].orig_email;
		self.orig_ip_6               := allRows[6].orig_ip;
		self.orig_login_date_6       := allRows[6].orig_login_date;
		self.orig_site_6             := allRows[6].orig_site;	

		self.title_6	  		   := allRows[6].title;				
		self.fname_6			     := allRows[6].fname;				
		self.mname_6			     := allRows[6].mname;			
		self.lname_6           := allRows[6].lname;				
		self.name_suffix_6     := allRows[6].name_suffix;				
		self.prim_range_6      := allRows[6].prim_range; 				
		self.predir_6          := allRows[6].predir;
		self.prim_name_6       := allRows[6].prim_name;				
		self.addr_suffix_6     := allRows[6].addr_suffix;  				
		self.postdir_6         := allRows[6].postdir; 		
		self.unit_desig_6      := allRows[6].unit_desig;	
		self.sec_range_6       := allRows[6].sec_range;				
		self.p_city_name_6     := allRows[6].p_city_name;				
		self.v_city_name_6     := allRows[6].v_city_name; 		 
		self.st_6              := allRows[6].st;					   
		self.zip_6             := allRows[6].zip;					  
		self.zip4_6            := allRows[6].zip4;								
		self.best_ssn_6        := allrows[6].best_ssn;
		self.best_dob_6        := allRows[6].best_dob;
		self.process_date_6    := allRows[6].process_date;
	
		
		// 7
		self.src_7						 := allRows[7].email_src;
		self.orig_first_name_7       := allRows[7].orig_first_name;
		self.orig_last_name_7        := allRows[7].orig_last_name;
		self.orig_address_7          := allRows[7].orig_address;
		self.orig_city_7             := allRows[7].orig_city;
		self.orig_state_7            := allRows[7].orig_state;
		self.orig_zip_7              := allRows[7].orig_zip;
		self.orig_zip4_7             := allRows[7].orig_zip4;
		self.orig_email_7            := allRows[7].orig_email;
		self.orig_ip_7               := allRows[7].orig_ip;
		self.orig_login_date_7       := allRows[7].orig_login_date;
		self.orig_site_7             := allRows[7].orig_site;	

			self.title_7			         := allRows[7].title;				
		self.fname_7			           := allRows[7].fname;				
		self.mname_7			           := allRows[7].mname;			
		self.lname_7                 := allRows[7].lname;				
		self.name_suffix_7 := allRows[7].name_suffix;				
		self.prim_range_7  := allRows[7].prim_range; 				
		self.predir_7      := allRows[7].predir;
		self.prim_name_7   := allRows[7].prim_name;				
		self.addr_suffix_7 := allRows[7].addr_suffix;  		
		self.postdir_7     := allRows[7].postdir; 			
		self.unit_desig_7  := allRows[7].unit_desig;		
		self.sec_range_7   := allRows[7].sec_range;			
		self.p_city_name_7 := allRows[7].p_city_name;				
		self.v_city_name_7 := allRows[7].v_city_name; 		 
		self.st_7          := allRows[7].st;						   
		self.zip_7         := allRows[7].zip;				  
		self.zip4_7        := allRows[7].zip4;								
		self.best_ssn_7              := allrows[7].best_ssn;
		self.best_dob_7              := allRows[7].best_dob;
		self.process_date_7          := allRows[7].process_date;
	
		
		// 8
		self.src_8						 := allRows[8].email_src;
		self.orig_first_name_8       := allRows[8].orig_first_name;
		self.orig_last_name_8        := allRows[8].orig_last_name;
		self.orig_address_8          := allRows[8].orig_address;
		self.orig_city_8             := allRows[8].orig_city;
		self.orig_state_8            := allRows[8].orig_state;
		self.orig_zip_8              := allRows[8].orig_zip;
		self.orig_zip4_8             := allRows[8].orig_zip4;
		self.orig_email_8            := allRows[8].orig_email;
		self.orig_ip_8               := allRows[8].orig_ip;
		self.orig_login_date_8       := allRows[8].orig_login_date;
		self.orig_site_8             := allRows[8].orig_site;	

		self.title_8	  		         := allRows[8].title;				
		self.fname_8			           := allRows[8].fname;				
		self.mname_8			           := allRows[8].mname;			
		self.lname_8                 := allRows[8].lname;				
		self.name_suffix_8           := allRows[8].name_suffix;				
		self.prim_range_8            := allRows[8].prim_range; 				
		self.predir_8                := allRows[8].predir;
		self.prim_name_8             := allRows[8].prim_name;				
		self.addr_suffix_8           := allRows[8].addr_suffix;  			
		self.postdir_8               := allRows[8].postdir;			
		self.unit_desig_8            := allRows[8].unit_desig;		
		self.sec_range_8             := allRows[8].sec_range;				
		self.p_city_name_8           := allRows[8].p_city_name;					
		self.v_city_name_8           := allRows[8].v_city_name; 			 
		self.st_8                    := allRows[8].st;					   
		self.zip_8                   := allRows[8].zip;				  
		self.zip4_8                  := allRows[8].zip4;								
		self.best_ssn_8              := allrows[8].best_ssn;
		self.best_dob_8              := allRows[8].best_dob;
		self.process_date_8          := allRows[8].process_date;
		
		
		// 9
		self.src_9						 := allRows[9].email_src;
		self.orig_first_name_9       := allRows[9].orig_first_name;
		self.orig_last_name_9        := allRows[9].orig_last_name;
		self.orig_address_9          := allRows[9].orig_address;
		self.orig_city_9             := allRows[9].orig_city;
		self.orig_state_9            := allRows[9].orig_state;
		self.orig_zip_9              := allRows[9].orig_zip;
		self.orig_zip4_9             := allRows[9].orig_zip4;
		self.orig_email_9            := allRows[9].orig_email;
		self.orig_ip_9               := allRows[9].orig_ip;
		self.orig_login_date_9       := allRows[9].orig_login_date;
		self.orig_site_9             := allRows[9].orig_site;	

		self.title_9			         := allRows[9].title;				
		self.fname_9			           := allRows[9].fname;				
		self.mname_9			           := allRows[9].mname;			
		self.lname_9                 := allRows[9].lname;				
		self.name_suffix_9           := allRows[9].name_suffix;				
		self.prim_range_9            := allRows[9].prim_range; 				
		self.predir_9                := allRows[9].predir;
		self.prim_name_9             := allRows[9].prim_name;				
		self.addr_suffix_9           := allRows[9].addr_suffix;  				
		self.postdir_9               := allRows[9].postdir; 			
		self.unit_desig_9            := allRows[9].unit_desig;		
		self.sec_range_9             := allRows[9].sec_range;			
		self.p_city_name_9           := allRows[9].p_city_name;				
		self.v_city_name_9           := allRows[9].v_city_name; 		 
		self.st_9                    := allRows[9].st;					   
		self.zip_9                   := allRows[9].zip;				  
		self.zip4_9                  := allRows[9].zip4;								
		self.best_ssn_9              := allrows[9].best_ssn;
		self.best_dob_9              := allRows[9].best_dob;
		self.process_date_9          := allRows[9].process_date;
	
		
		//10
		self.src_10						 := allRows[10].email_src;
		self.orig_first_name_10      := allRows[10].orig_first_name;
		self.orig_last_name_10       := allRows[10].orig_last_name;
		self.orig_address_10         := allRows[10].orig_address;
		self.orig_city_10            := allRows[10].orig_city;
		self.orig_state_10           := allRows[10].orig_state;
		self.orig_zip_10             := allRows[10].orig_zip;
		self.orig_zip4_10            := allRows[10].orig_zip4;
		self.orig_email_10           := allRows[10].orig_email;
		self.orig_ip_10              := allRows[10].orig_ip;
		self.orig_login_date_10      := allRows[10].orig_login_date;
		self.orig_site_10            := allRows[10].orig_site;	

		self.title_10			   := allRows[10].title;				
		self.fname_10			   := allRows[10].fname;				
		self.mname_10			   := allRows[10].mname;			
		self.lname_10        := allRows[10].lname;				
		self.name_suffix_10  := allRows[10].name_suffix;				
		self.prim_range_10   := allRows[10].prim_range; 					
		self.predir_10       := allRows[10].predir;
		self.prim_name_10    := allRows[10].prim_name;		
		self.addr_suffix_10  := allRows[10].addr_suffix;  				
		self.postdir_10      := allRows[10].postdir; 		
		self.unit_desig_10   := allRows[10].unit_desig;			
		self.sec_range_10    := allRows[10].sec_range;			
		self.p_city_name_10  := allRows[10].p_city_name;					
		self.v_city_name_10  := allRows[10].v_city_name; 			 
		self.st_10           := allRows[10].st;					   
		self.zip_10          := allRows[10].zip;				  
		self.zip4_10         := allRows[10].zip4;									
		self.best_ssn_10              := allrows[10].best_ssn;
		self.best_dob_10              := allRows[10].best_dob;
		self.process_date_10          := allRows[10].process_date;
		
		self := [];
end;		