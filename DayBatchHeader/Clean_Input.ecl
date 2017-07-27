import Address;
export Clean_Input(DATASET(DayBatchHeader.Layout_Batch_Address_Input) inData) := FUNCTION
	
	DayBatchHeader.Layout_clean_in getCleanInput(inData l) := TRANSFORM
		SELF.addr1_for_clean := MAP(l.strAddr <> '' => l.strAddr,
																Address.Addr1FromComponents(l.prim_range,'',l.prim_name,
																'','','',l.sec_range));
		SELF.addr2_for_clean := Address.Addr2FromComponents(l.p_city_name,l.st,l.z5);
		SELF.clean_addr := Address.CleanAddress182(SELF.addr1_for_clean,SELF.addr2_for_clean);
		SELF.pobox := 'X';
		SELF.prim_range := SELF.clean_addr[1..10];
		SELF.predir := SELF.clean_addr[11..12];
		SELF.prim_name := SELF.clean_addr[13..40];
		SELF.addr_suffix := SELF.clean_addr[41..44];
		SELF.postdir := SELF.clean_addr[45..46];
		SELF.unit_desig := SELF.clean_addr[47..56];
		SELF.sec_range := SELF.clean_addr[57..64];
		SELF.p_city_name := SELF.clean_addr[65..89];
		SELF.st := if(SELF.clean_addr[115..116]='',
												ziplib.ZipToState2(SELF.clean_addr[117..121]),
												SELF.clean_addr[115..116]);
		SELF.z5	:= SELF.clean_addr[117..121];
		SELF.z4 := SELF.clean_addr[122..125];
		SELF.err_stat := SELF.clean_addr[179..182];
		
		SELF.name_first := stringlib.StringToUpperCase(l.name_first);
		SELF.name_last := stringlib.StringToUpperCase(l.name_last);
		SELF.strAddr := stringlib.StringToUpperCase(l.strAddr);
		SELF := l;
	END;
	
	cleanInput := PROJECT(inData,getCleanInput(LEFT));
	
	return cleanInput;
	
END;