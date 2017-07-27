import Address;

export Mapping_FDIC (string filedate) := function

	file_in := govdata.File_FDIC_In;

	govdata.Layouts_FDIC.Base_Aid tMapFDIC(file_in l) := transform
		
		self.Process_Date							:= filedate;

		self.prep_addr_line1					:= address.Addr1FromComponents(stringlib.stringtouppercase(trim(l.Address,left,right))
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																 ,''
																																);
		self.prep_addr_last_line			:= address.Addr2FromComponents(stringlib.stringtouppercase(trim(l.City,left,right))
																																 ,stringlib.stringtouppercase(trim(l.STALP,left,right))
																																 ,trim(l.zip)[1..5]
																																);
		self 													:= l;
		self													:= [];
	end;

	MapFDIC := project(file_in, tMapFDIC(LEFT));

	return MapFDIC;
end;;