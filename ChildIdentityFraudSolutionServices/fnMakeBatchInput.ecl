EXPORT fnMakeBatchInput() := functionmacro
	ChildIdentityFraudSolutionServices.Layouts.BatchIn xform1() := transform
 		self.acctno := '1';	
   		//BatchShare.Layouts.ShareName;
   		self.name_first    := glbMod.FirstName;
   		self.name_middle   := glbMod.MiddleName;
   		self.name_last     := glbMod.LastName;
   		self.name_suffix   := glbMod.NameSuffix;
   		//BatchShare.Layouts.ShareAddress - [addr, county_name];		
			addr1			 			:= Address.Addr1FromComponents(report_by.Address.StreetNumber, report_by.Address.StreetPreDirection, report_by.Address.StreetName,
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
   		self.ssn			  := glbMod.ssn;
   		self.dob				:= (string)glbMod.DOB;
   		self.Identity_Type_Indicator := report_by.IdentityType; // TEMP verify once iesp layouts are available.

			//self := [];
	end;


	BatchIn := dataset([xform1()]);
	return(BatchIn);
endmacro;