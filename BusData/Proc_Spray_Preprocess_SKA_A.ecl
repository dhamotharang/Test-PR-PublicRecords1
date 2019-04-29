IMPORT address, ut, HEADER, NID, AID, BusData;


EXPORT Proc_Spray_Preprocess_ska_a(String filedate) := FUNCTION

ds_ska := BusData.File_In_SKA_A;
// output(ds_ska,named('ska'));
trim2Upper( string incode ) := function
	return StringLib.StringToUpperCase ( trim(incode));
end;

temprec := record
	layouts_ska.raw;
	string73 name;
end;

temprec t_Name_ska(ds_ska le) := TRANSFORM
	self.name := trim(le.FIRST_NAME) + ' '+ trim(le.MIDDLE) + ' '+ trim(le.LAST_NAME);
	self      := le;
end;

d_ska_name := project(ds_ska,t_Name_ska(left));

Clean_Name_ska(DATASET(temprec) pInput) := FUNCTION
	NID.Mac_CleanFullNames(pInput, cleaned_names,name);
	RETURN cleaned_names;
end;

CleanName_owner	:= Clean_Name_ska(d_ska_name) ;

layouts_ska.parserec t_CleanName_ska(CleanName_owner le) := TRANSFORM
    self.TTL                     := le.TTL;
    self.FIRST_NAME              := le.FIRST_NAME;
    self.MIDDLE                  := le.MIDDLE;
    self.LAST_NAME               := le.LAST_NAME;
    self.T1                      := le.T1;
    self.DO                      := le.DO;
    self.DEPTCODE                := le.DEPTCODE;
    self.DEPT_EXPL               := le.DEPT_EXPL;
    self.KEY_FILE                := trim2Upper(BusData.mod_Tables_SKA.decode_Depfile(le.DEPTCODE));
    self.COMPANY1                := le.COMPANY1;
    self.ADDRESS1                := le.ADDRESS1;
    self.CITY                    := le.CITY;
    self.STATE                   := le.STATE;
    self.ZIP                     := le.ZIP;
    self.ADDRESS2                := le.ADDRESS2;
    self.CITY2                   := le.CITY2; 
    self.STATE2                  := le.STATE2;
    self.ZIP2                    := le.ZIP2;
    self.FIPS                    := le.FIPS;
    self.PHONE                   := le.PHONE;
    self.SPEC                    := le.SPEC; 
    self.SPEC_EXPL               := le.SPEC_EXPL;
    self.SPEC2                   := le.SPEC2;
    self.SPEC2_EXPL              := trim2Upper(BusData.mod_Tables_SKA.decode_SpecDeptCode(le.SPEC2));
    self.SPEC3                   := le.SPEC3;
    self.SPEC3_EXPL              := trim2Upper(BusData.mod_Tables_SKA.decode_SpecDeptCode(le.SPEC3));
    self.ID                      := le.ID;
    self.PERSID                  := le.PERSID;
    self.OWNER                   := le.OWNER;
    self.EMAILAVAIL              := le.EMAILAVAIL;
    self.title                   := if ( le.nametype = 'P',le.cln_title,'');           
    self.fname                   := if ( le.nametype = 'P',le.cln_fname,'') ;        
    self.mname                   := if ( le.nametype = 'P',le.cln_mname,'');         
    self.lname                   := if ( le.nametype = 'P',le.cln_lname,'');         
    self.name_suffix             := if ( le.nametype = 'P',le.cln_suffix,'');         
    self.name_score              := '';         
    self                         := [];
    self                         := le;
END;	  

name_clean_ska := project(CleanName_owner, t_CleanName_ska(LEFT));

// ADD CLEAN ADDRESS

layout_addr_in_mailing := record
	name_clean_ska;
	string addr_line1;
end;

layout_addr_in_mailing get_addr_mailing(name_clean_ska l) := transform
	self.addr_line1 := trim(l.CITY) + ' '+ trim(l.STATE) + ' '+ trim(l.ZIP);
	self := l;
end;

la_raw_addr_ska := project(name_clean_ska, get_addr_mailing(left));

address.mac_address_clean(la_raw_addr_ska, ADDRESS1, addr_line1, true, la_clean_addr_ska_a); 

layout_addr_clean := record
	name_clean_ska;
end;

layout_addr_clean get_parserecd_addr(la_clean_addr_ska_a l) := Transform
	self.clean_address := l.clean;
	self := l;
end;

name_clean2_ska := project(la_clean_addr_ska_a, get_parserecd_addr(left)) : persist('~thor_data400::persist::ska_clean');

// ADD CLEAN ADDRESS2

layout_addr2_in_mailing := record
	name_clean2_ska;
	string addr_line1;
end;

layout_addr2_in_mailing get_addr_mailing2(name_clean2_ska l) := transform
	self.addr_line1 := trim(l.CITY2) + ' '+ trim(l.STATE2) + ' '+ trim(l.ZIP2);
	self := l;
end;

la_raw_addr2_ska := project(name_clean2_ska, get_addr_mailing2(left));

address.mac_address_clean(la_raw_addr2_ska, ADDRESS2, addr_line1, true ,la_clean2_addr_ska_a); 

layout_addr_clean2 := record
	name_clean2_ska;
end;

layouts_ska.parserec get_parserecd_addr2(la_clean2_addr_ska_a l) := Transform
	self.clean2_address := l.clean;
	self := l;
end;

la_parserecddr := project(la_clean2_addr_ska_a, get_parserecd_addr2(left)) ;

BusData.Layout_SKA_Verified_In t_Convfinal( la_parserecddr l) := transform
  // self.title                   := l.clntitle;                      
  self.mail_prim_range          := l.clean_address[1..10]      ;	 
  self.mail_predir              := l.clean_address[11..12]     ;	 
  self.mail_prim_name           := l.clean_address[13..40]     ;	 
  self.mail_addr_suffix         := l.clean_address[41..44]  	 ;   
  self.mail_postdir             := l.clean_address[45..46]    	;  
  self.mail_unit_desig          := l.clean_address[47..56]  	 ;   
  self.mail_sec_range           := l.clean_address[57..64]  	 ;   
  self.mail_p_city_name         := l.clean_address[65..89]  	 ;   
  self.mail_v_city_name         := l.clean_address[90..114] 	 ;   
  self.mail_st                  := l.clean_address[115..116]   ;	 
  self.mail_zip                 := l.clean_address[117..121]   ;	 
  self.mail_zip4                := l.clean_address[122..125]   ;	 
  self.mail_cart                := l.clean_address[126..129]   ;	 
  self.mail_cr_sort_sz          := l.clean_address[130]     	 ;   
  self.mail_lot                 := l.clean_address[131..134]   ;	 
  self.mail_lot_order           := l.clean_address[135]     	 ;   
  self.mail_dbpc                := l.clean_address[136..137]   ;	 
  self.mail_chk_digit           := l.clean_address[138]     	 ;   
  self.mail_rec_type            := l.clean_address[139..140]   ;   
  self.mail_ace_fips_state      :=  l.clean_address[141..142]  ;   
  self.mail_county              := l.clean_address[143..145]  	;  
  self.mail_geo_lat             := l.clean_address[146..155]  	;  
  self.mail_geo_long            := l.clean_address[156..166]   ;	 
  self.mail_msa                 := l.clean_address[167..170]  	;  
  self.mail_geo_blk             := l.clean_address[171..177]   ;   
  self.mail_geo_match           := l.clean_address[178]     	 ;	 
  self.mail_err_stat            := l.clean_address[179..182] ;	   
  self.alt_prim_range           := l.clean2_address[1..10]      ;  
  self.alt_predir               := l.clean2_address[11..12]     ;  
  self.alt_prim_name            := l.clean2_address[13..40]     ;  
  self.alt_addr_suffix          := l.clean2_address[41..44]  	 ;   
  self.alt_postdir              := l.clean2_address[45..46]    	;  
  self.alt_unit_desig           := l.clean2_address[47..56]  	 ;   
  self.alt_sec_range            := l.clean2_address[57..64]  	 ;   
  self.alt_p_city_name          := l.clean2_address[65..89]  	 ;   
  self.alt_v_city_name          := l.clean2_address[90..114] 	 ;   
  self.alt_st                   := l.clean2_address[115..116]   ;  
  self.alt_zip                  := l.clean2_address[117..121]   ;  
  self.alt_zip4                 := l.clean2_address[122..125]   ;  
  self.alt_cart                 := l.clean2_address[126..129]   ;  
  self.alt_cr_sort_sz           := l.clean2_address[130]     	 ;   
  self.alt_lot                  := l.clean2_address[131..134]   ;  
  self.alt_lot_order            := l.clean2_address[135]     	 ;   
  self.alt_dbpc                 := l.clean2_address[136..137]   ;  
  self.alt_chk_digit            := l.clean2_address[138]     	 ;   
  self.alt_rec_type             := l.clean2_address[139..140]   ;  
  self.alt_ace_fips_state       := l.clean2_address[141..142]   ;  
  self.alt_county              := l.clean2_address[143..145]  	;  
  self.alt_geo_lat             := l.clean2_address[146..155]  	;  
  self.alt_geo_long            := l.clean2_address[156..166]   ;   
  self.alt_msa                 := l.clean2_address[167..170]  	;  
  self.alt_geo_blk             := l.clean2_address[171..177]   ;   
  self.alt_geo_match           := l.clean2_address[178]     	 ;	 
  self.alt_err_stat            := l.clean2_address[179..182] ;     
  // self.company_title            := l.T1;                        
  // self.company_name             := l.company1;                      
  // self.address1                 := l.address;                      
  self.lf                       := '';                             
  self                          := l;                                                       
  self                          := [];                                                       

end;

dSKAVerified := project(la_parserecddr, t_Convfinal( left));


ska_final := output(dSKAVerified,,'~thor_data400::base::ska_'+filedate,overwrite);

super_file := sequential(
							FileServices.ClearSuperFile('~thor_data400::base::ska'),
							FileServices.addSuperFile('~thor_data400::base::ska','~thor_data400::base::ska_'+filedate)
				);

return Sequential(BusData.Proc_SKA_Spray_In(filedate).spray_all_a, ska_final, super_file);

end;

