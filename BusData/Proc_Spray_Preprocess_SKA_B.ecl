IMPORT address, ut, HEADER,NID;

EXPORT Proc_Spray_Preprocess_ska_b(String filedate) := FUNCTION

ds_ska_b := BusData.File_In_SKA_B;

temprec := record
	layouts_ska.raw_b;
	string73 name;
end;

temprec t_Name_ska(ds_ska_b le) := TRANSFORM
	self.name := trim(le.FIRST_NAME) + ' '+ trim(le.MIDDLE) + ' '+ trim(le.LAST_NAME);
	self := le;
end;

d_ska_b_name := project(ds_ska_b,t_Name_ska(left));

Clean_Name_ska_b(DATASET(temprec) pInput) := FUNCTION
	NID.Mac_CleanFullNames(pInput, cleaned_names,name);
	RETURN cleaned_names;
end;

CleanName_owner	:= Clean_Name_ska_b(d_ska_b_name) ;


layouts_ska.parse_ska_b t_CleanName_ska_b(CleanName_owner le) := TRANSFORM
  SELF.TTL                      := le.TTL;
  SELF.FIRST_NAME               := le.FIRST_NAME;
  SELF.MIDDLE                   := le.MIDDLE;
  SELF.LAST_NAME                := le.LAST_NAME;
  SELF.T1                       := le.T1;
  SELF.DEPT_CODE                := le.DEPT_CODE;
  SELF.DEPT_EXPL                := le.DEPT_EXPL;
  SELF.SPEC                     := le.SPEC; 
  SELF.SPEC_EXPL                := le.SPEC_EXPL;
  SELF.DEPT_FILE                := BusData.mod_Tables_SKA.decode_SpecDeptCode(le.SPEC);
  SELF.COMPANY1                 := le.COMPANY1;
  SELF.ADDRESS1                 := le.ADDRESS1;
  SELF.CITY                     := le.CITY;
  SELF.STATE                    := le.STATE;
  SELF.ZIP                      := le.ZIP;
  SELF.AREA_CODE                := le.AREA_CODE;
  SELF.NUMBER                   := le.NUMBER[1..3]+le.NUMBER[5..8];
  SELF.ID                       := le.ID;
  SELF.PERSID                   := le.PERSID;
  SELF.NIXIE_DATE               := le.NIXIE_DATE[7..10] + le.NIXIE_DATE[1..2] + le.NIXIE_DATE[4..5];
  SELF.title                    := if ( le.nametype = 'P',le.cln_title,'');           
  SELF.fname                    := if ( le.nametype = 'P',le.cln_fname,'') ;        
  SELF.mname                    := if ( le.nametype = 'P',le.cln_mname,'');         
  SELF.lname                    := if ( le.nametype = 'P',le.cln_lname,'');         
  SELF.name_suffix              := if ( le.nametype = 'P',le.cln_suffix,'');         
  SELF.name_score               := '';            
  SELF                          := le;
  SELF                          := [];
END;

name_clean_ska_b := project(CleanName_owner, t_CleanName_ska_b(LEFT));

// ADD CLEAN ADDRESS

layout_bddr_in_mailing := record
	name_clean_ska_b;
	string addr_line1;
end;

layout_bddr_in_mailing get_bddr_mailing(name_clean_ska_b l) := transform
	self.addr_line1 := trim(l.CITY) + ' '+ trim(l.STATE) + ' '+ trim(l.ZIP);
	self := l;
end;

la_raw_baddr_ska_b := project(name_clean_ska_b, get_bddr_mailing(left));

address.mac_address_clean(la_raw_baddr_ska_b, ADDRESS1, addr_line1, true, la_clean_baddr_ska_b); //: persist('~thor_data400::persist::ska_b_cleanaddr'); 

layout_bddr_clean := record
	name_clean_ska_b;
end;

layout_bddr_clean get_parsed_bddr(la_clean_baddr_ska_b l) := Transform
	self.clean_address := l.clean;
	self := l;
end;

name_clean2_ska_b := project(la_clean_baddr_ska_b, get_parsed_bddr(left)) : persist('~thor_data400::persist::ska_b_clean');


BusData.Layout_SKA_Nixie_In t_Convfinal( name_clean2_ska_b l) := transform
   // self.title                    := l.title;                    
  SELF.mail_prim_range          := l.clean_address[1..10]      ;	 
  SELF.mail_predir              := l.clean_address[11..12]     ;	 
  SELF.mail_prim_name           := l.clean_address[13..40]     ;	 
  SELF.mail_addr_suffix         := l.clean_address[41..44]  	 ;   
  SELF.mail_postdir             := l.clean_address[45..46]    	;  
  SELF.mail_unit_desig          := l.clean_address[47..56]  	 ;   
  SELF.mail_sec_range           := l.clean_address[57..64]  	 ;   
  SELF.mail_p_city_name         := l.clean_address[65..89]  	 ;   
  SELF.mail_v_city_name         := l.clean_address[90..114] 	 ;   
  SELF.mail_st                  := l.clean_address[115..116]   ;	 
  SELF.mail_zip                 := l.clean_address[117..121]   ;	 
  SELF.mail_zip4                := l.clean_address[122..125]   ;	 
  SELF.mail_cart                := l.clean_address[126..129]   ;	 
  SELF.mail_cr_sort_sz          := l.clean_address[130]     	 ;   
  SELF.mail_lot                 := l.clean_address[131..134]   ;	 
  SELF.mail_lot_order           := l.clean_address[135]     	 ;   
  SELF.mail_dbpc                := l.clean_address[136..137]   ;	 
  SELF.mail_chk_digit           := l.clean_address[138]     	 ;   
  SELF.mail_rec_type            := l.clean_address[139..140]   ;  
  SELF.mail_ace_fips_state      :=  l.clean_address[141..142]   ; 
  SELF.mail_county              := l.clean_address[143..145]  	;  
  SELF.mail_geo_lat             := l.clean_address[146..155]  	;  
  SELF.mail_geo_long            := l.clean_address[156..166]   ;	 
  SELF.mail_msa                 := l.clean_address[167..170]  	;  
  SELF.mail_geo_blk             := l.clean_address[171..177]   ;  
  SELF.mail_geo_match           := l.clean_address[178]     	 ;	 
  SELF.mail_err_stat            := l.clean_address[179..182] ;	   
   // self.T1                       := l.T1;                       
   // self.company_name             := l.company;                     
   // self.address1                 := l.address;                     
   // self.lf                       := '';                            
  SELF                          := l;                                                      
  SELF                          := [];                                                      

end;

dSKANixie := project( name_clean2_ska_b,t_Convfinal( left));

ska_b_final := output(dSKANixie,,'~thor_data400::base::ska_b_'+filedate,overwrite);

super_file_b := sequential(
							FileServices.ClearSuperFile('~thor_data400::base::ska_b'),
							FileServices.addSuperFile('~thor_data400::base::ska_b','~thor_data400::base::ska_b_'+filedate)
				);

return Sequential(Proc_SKA_Spray_In(filedate).spray_all_b,ska_b_final,super_file_b);


end;
