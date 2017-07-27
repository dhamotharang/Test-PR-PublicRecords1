
IMPORT standard, ut, doxie; 

EXPORT file_SearchAutokey() := 
	FUNCTION
		
		pBase := DCA.File_DCA_Base;
		
		EXPORT rec := RECORD
			DCA.Layout_DCA_Base.bdid;
			STRING105 company_name; 	
			STRING45  company_phone;
			STRING2   Level;
			STRING9   Root;
			STRING4   Sub;
			STRING105 Parent_Name;
			STRING15  Parent_Number;			
			string9   Enterprise_num                                                              ;
			string9   Parent_Enterprise_number     																							 ;  
			Standard.L_Address.base bus_addr;
			UNSIGNED1 zero             :=  0;
			STRING1   blank            := '';
			STRING1   blank_prim_name  := '';
			STRING1   blank_prim_range := '';
			STRING1   blank_st         := '';
			STRING1   blank_city       := '';
			STRING1   blank_zip5       := '';
			STRING1   blank_sec_range  := '';
		END;

		rec tranBC(DCA.Layout_DCA_Base  pInput) :=
			TRANSFORM
				SELF.BDID                     := pInput.BDID;
				SELF.company_name             := pInput.Name;
				SELF.company_phone            := pInput.Phone;
				SELF.bus_addr.prim_range      := pInput.prim_range;
				SELF.bus_addr.predir          := pInput.predir;
				SELF.bus_addr.prim_name       := pInput.prim_name;
				SELF.bus_addr.addr_suffix     := pInput.addr_suffix;
				SELF.bus_addr.postdir         := pInput.postdir;
				SELF.bus_addr.unit_desig      := pInput.unit_desig;
				SELF.bus_addr.sec_range       := pInput.sec_range;
				SELF.bus_addr.p_city_name     := pInput.p_city_name;
				SELF.bus_addr.v_city_name     := pInput.v_city_name;
				SELF.bus_addr.st              := pInput.st;
				SELF.bus_addr.zip5            := pInput.z5;
				SELF.bus_addr.zip4            := pInput.zip4;
				SELF.bus_addr.fips_state      := '';
				SELF.bus_addr.fips_county     := pInput.county;
				SELF.bus_addr.addr_rec_type   := '';
				SELF                          := pInput;
			END;

		b := PROJECT(pBase, tranBC(LEFT));

		RETURN b;
		
	END;