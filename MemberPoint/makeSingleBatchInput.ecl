EXPORT makeSingleBatchInput := functionmacro

	MemberPoint.Layouts.BatchIn xform1() := transform
			self.acctno 			 := '1';	
			self.did					 := (unsigned) report_by.UniqueId;
			dsCleanName1	:= 	Address.CleanNameFields(Address.CleanPersonFML73(report_by.Name.Full));
			name_first 		:=  if(glbMod.FirstName <> '',glbMod.FirstName , dsCleanName1.fname);
			name_last  		:=  if(glbMod.FirstName <> '',glbMod.LastName, dsCleanName1.lname);
			name_middle   :=  if(glbMod.FirstName <> '',glbMod.MiddleName, dsCleanName1.mname);
			name_suffix   :=  if(glbMod.FirstName <> '' ,glbMod.NameSuffix , dsCleanName1.name_suffix);
			
		  self.name_first    := name_first;
   		self.name_middle   := name_middle;
   		self.name_last     := name_last ;
   		self.name_suffix   := name_suffix;
   		//BatchShare.Layouts.ShareAddress - [addr, county_name];		
			addr1			 				:= Address.Addr1FromComponents(report_by.Address.StreetNumber, report_by.Address.StreetPreDirection, report_by.Address.StreetName,
																			 report_by.Address.StreetSuffix, report_by.Address.StreetPostDirection, 
																			 report_by.Address.UnitDesignation, report_by.Address.UnitNumber);
			addr2 						:= Address.Addr2FromComponents(report_by.Address.City, report_by.Address.State, report_by.Address.Zip5);
			addr1_final 			:= if (addr1 = '', report_by.Address.StreetAddress1, addr1);
			clean_addr 				:= address.GetCleanAddress(addr1_final,addr2,address.Components.country.US);
			ca								:= clean_addr.results;
			self.prim_range 	:= ca.prim_range;
			self.prim_name 		:= ca.prim_name;
			self.sec_range 		:= ca.sec_range;
			self.addr_suffix 	:= ca.suffix;
			self.predir 			:= ca.predir;
			self.postdir 			:= ca.postdir;
			self.unit_desig 	:= ca.unit_desig;
			self.p_city_name 	:= ca.p_city;
			self.z5						:= ca.zip;
			self.zip4					:= ca.zip4;
			self.st						:= ca.state;	
   		//BatchShare.Layouts.SharePII;
			self.SSNLast4  		:= stringlib.stringfilter(report_by.SSNLast4,'0123456789'); 
			self.ssn			  	:= stringlib.stringfilter(report_by.SSN,'0123456789');
   		self.dob					:= IF(glbMod.DOB=0, '', (string)glbMod.DOB);
			
		// Record Type
		self.record_type      			:= report_by.RecordType ; // minor or non minor
		// Primary Address Date
		self.primary_address_date  	:= iesp.ECL2ESP.t_DateToString8(report_by.AddressDate) ;
		// Enrollment Date
		self.enrollment_date  			:= iesp.ECL2ESP.t_DateToString8(report_by.EnrollmentDate) ;
		// P_Phone number
		self.primary_phone_number  	:= report_by.Phone ;
		// Email
		self.email  								:= report_by.Email ;
		dsCleanName2	:= 	Address.CleanNameFields(Address.CleanPersonFML73(report_by.GuardianName.Full));
		guardian_name_first 	:=  if(report_by.GuardianName.First <> '',report_by.GuardianName.First, dsCleanName2.fname);
		guardian_name_last  	:=  if(report_by.GuardianName.Last <> '',report_by.GuardianName.Last, dsCleanName2.lname);
		// Guardian First Name
		self.guardian_name_first  	:= guardian_name_first;
		// Guardian Last Name
		self.guardian_name_last  		:= guardian_name_last;
		// Guardian DOB
		self.guardian_DOB  					:= iesp.ECL2ESP.t_DateToString8(report_by.GuardianDOB) ;
		// Guardian SSN
		self.GuardianSSNLast4  			:= stringlib.stringfilter(report_by.GuardianSSNLast4,'0123456789'); 
		self.guardian_SSN						:= stringlib.stringfilter(report_by.GuardianSSN,'0123456789'); 

			//self := [];
	end;


	BatchIn := dataset([xform1()]);
// OUTPUT(glbMod.DOB, named('Iglb'));
// OUTPUT(BatchIn[1].dob, named('Iout'));
	return(BatchIn);
endmacro;