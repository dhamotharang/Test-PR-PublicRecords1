﻿IMPORT  PRTE2_DCA, PRTE2, PromoteSupers, Address, ut, AID, AID_Support, std;

EXPORT proc_build_base := FUNCTION

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
			self.title          := CleanName.title;
			self.fname          := CleanName.fname;
			self.mname          := CleanName.mname;   
			self.lname          := CleanName.lname;
			self.name_suffix    := CleanName.name_suffix;	
      SELF.name_score   	:= CleanName.name_score;
 // Clean Address fields     
			self.rawaid         := left.addr_rawaid;
		  self.z5             := left.clean_address.zip;
      self.dpbc           := left.clean_address.dbpc;
      self.ace_fips_st    := left.clean_address.fips_state;
      self.county         := left.clean_address.fips_county;
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
			
      self := left;
      self := [];			
			
));

 dsAppendDid  := project(dsFile, transform( Layouts.base,
                          //generating fake DID  
                          SELF.did 		:= prte2.fn_AppendFakeID.did(left.fname, left.lname, left.link_ssn, left.link_dob, left.cust_name);
                          self := left;
                          ));

	PromoteSupers.MAC_SF_BuildProcess(dsAppendDid,prte2.constants.prefix + 'base::american_student_list', base_file);
  
	Return base_file;
		
END;