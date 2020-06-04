IMPORT  PRTE2_DCA, PRTE2, PromoteSupers, Address, ut, AID, AID_Support, std,Census_data,mdr;

EXPORT proc_build_base := FUNCTION
get_county_name(string2 st_in, string3 county_in) := 
		        Census_data.Key_Fips2County(keyed(st_in = state_code AND
                                              county_in = county_fips))[1].county_name;

PRTE2.CleanFields(Files.incoming,ClnIncoming);
	
	dsCleanFile := PRTE2.AddressCleaner(ClnIncoming,  
                                      ['address_1'],
                                      ['address_2'],
                                      ['city'],
                                      ['state'],
                                      ['zip'],
                                      ['clean_address'],
                                      ['addr_rawaid']
                                      );
 
dsFile	:=	Project(dsCleanFile, Transform(Layouts.base,
//Clean Name
			cleanName := Address.CleanPersonFML73_fields(Left.full_name); 
			self.title:=if(left.cust_name != 'IN_PR',CleanName.title,left.title);
			self.fname:=if(left.cust_name != 'IN_PR',CleanName.fname,left.fname);
			self.mname:=if(left.cust_name != 'IN_PR',CleanName.mname,left.mname);
			self.lname:=if(left.cust_name != 'IN_PR',CleanName.lname,left.lname);
			self.name_suffix:=if(left.cust_name != 'IN_PR',CleanName.name_suffix,left.name_suffix);
      self.name_score:=if(left.cust_name != 'IN_PR',CleanName.name_score,left.name_score);
		 
 // Clean Address fields     
			self.rawaid         := left.addr_rawaid;
		  self.z5             := left.clean_address.zip;
      self.dpbc           := left.clean_address.dbpc;
      self.ace_fips_st    := left.clean_address.fips_state;
      self.county         := left.clean_address.fips_county;
			self.county_number  := left.clean_address.fips_county;
			
      self                := left.clean_address;
						  
      self.address_2      := ''; // address cleaner is population field when incoming field is blank
      self.age            := (string)ut.Age((integer)left.dob_formatted);
      self.ADDRESS_TYPE_CODE						:= left.ADDRESS_TYPE_CODE;
      self.ADDRESS_TYPE 		       			:= MAP(TRIM(left.ADDRESS_TYPE_CODE,left,right) = 'G' => 'General Delivery',
																					 TRIM(left.ADDRESS_TYPE_CODE,left,right) = 'H' => 'High-rise Dwelling',
																					 TRIM(left.ADDRESS_TYPE_CODE,left,right) = 'R' => 'Rural Route',
																					 TRIM(left.ADDRESS_TYPE_CODE,left,right) = 'P' => 'Post Office Box',
																					 TRIM(left.ADDRESS_TYPE_CODE,left,right) = 'S' => 'Single Family Dwelling',
																								 '');
      self.KEY                        		:= hash32(trim(TRIM(left.LAST_NAME,left,right) + 
																						 TRIM(left.FIRST_NAME,left,right) +
																						 TRIM(left.DOB_FORMATTED,left,right)                                                       
                                              ));
			
      self.CRRT_CODE :=left.cart; 
			self.county_name := get_county_name(left.clean_address.st, left.clean_address.fips_county);
			self.did:=if(left.did =0,prte2.fn_AppendFakeID.did(self.fname, self.lname, left.link_ssn, left.link_dob, left.cust_name),left.did);
			
			self := left;
      self := [];			
			
));

addGlobalSID 	 := mdr.macGetGlobalSID(dsFile,'Americanstudent','source','global_sid'); 

PromoteSupers.MAC_SF_BuildProcess(addGlobalSID,prte2.constants.prefix + 'base::american_student_list', base_file);
  
	Return base_file;
		
END;