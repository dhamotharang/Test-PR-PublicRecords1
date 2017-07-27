export MAC_Format_Output(linked,search,keepinputssn) := MACRO
	
	isHit := DayBatchHeader.isProcessHit(TRIM(linked.matchCode),TRIM(search));
	retInput := DayBatchHeader.returnsInput(search);
	
	SELF.matchCode := OutputMatchCode(isHit,linked.matchCode,search);	
													
	isSsnMatch := stringLib.StringContains(linked.matchCode,'S',false);
	isFullNameMatch := stringLib.StringContains(linked.matchCode,'FL',false);
	isLastNameMatch := stringLib.StringContains(linked.matchCode,'L',false);
	isAddressMatch := stringLib.StringContains(linked.matchCode,'13',false) AND 
										stringLib.StringContains(linked.matchCode,'Z',false);	
	
	SELF.acctno := linked.indata.acctno;
	SELF.addrChar_in := '';		// Not required
	SELF.SSNChar := '';				// Not required
	SELF.iCode := '';
	SELF.potentialSSN := '';		// IE02 Only right now
	
	// Determine if new address and map to status
	isNewAddress := DayBatchUtils.IsLeftComponentNew(linked.outdata.prim_range,linked.indata.prim_range) OR
									ut.StringSimilar(linked.outdata.prim_name,linked.indata.prim_name) > 3 OR
									DayBatchUtils.IsLeftComponentNew(linked.outdata.zip,linked.indata.z5) OR
									DayBatchUtils.IsLeftComponentNew(linked.outdata.sec_range,linked.indata.sec_range);
	
	self.addrStatus := MAP(isHit AND isNewAddress => '2',
												 isHit => '1',
												 '0'
												);
												
	SELF.addrChar_out	:= '';		// Not required
	
	// if no hit, return the input name if the search is a return input type search
	SELF.fname := MAP(isHit => linked.outdata.fname,
										retInput => linked.indata.name_first,
										''
										);	
										
	SELF.mname := IF(isHit,linked.outdata.mname,'');	// No mname field in input data
	
	SELF.lname := MAP(isHit => linked.outdata.lname,
										retInput => linked.indata.name_last,
										''
										);
	
	SELF.suffix := IF(isHit,linked.outdata.name_suffix,'');	// No suffix field in input data
	
	SELF.ssn := MAP(isHit and keepinputssn and linked.indata.ssn != '' => linked.indata.ssn,
									isHit => linked.outdata.ssn,
									retInput => linked.indata.ssn,
									''
									);
	
	SELF.ssn5A := SELF.ssn;
	
	// Create address1 and address 2 values
	addr1 := MAP(isHit => Address.Addr1FromComponents(linked.outdata.prim_range,linked.outdata.predir,linked.outdata.prim_name,
											linked.outdata.suffix,linked.outdata.postdir,linked.outdata.unit_desig,linked.outdata.sec_range),
								retInput => Address.Addr1FromComponents(linked.indata.prim_range,linked.indata.predir,linked.indata.prim_name,
											linked.indata.addr_suffix,linked.indata.postdir,linked.indata.unit_desig,linked.indata.sec_range),
								''		
							);
							
	SELF.address1 := addr1;
	
	SELF.address2 := MAP(isHit => Address.Addr2FromComponents(linked.outdata.city_name,linked.outdata.st,linked.outdata.zip),
												retInput => Address.Addr2FromComponents(linked.indata.p_city_name,linked.indata.st,linked.indata.z5),
												''
											);
	
	SELF.prim_range := MAP(isHit => linked.outdata.prim_range,
													retInput => linked.indata.prim_range,
													''
												);
	
	SELF.pobox := '';		// Not required
	
	SELF.city := MAP(isHit => linked.outdata.city_name,
										retInput => linked.indata.p_city_name,
										''
									);
									
	SELF.state := MAP(isHit => linked.outdata.st,
										retInput => linked.indata.st,
										''
										);
	
	// decide how to format and output zip
	SELF.zip := MAP(~isHit AND retInput => linked.indata.z5,
										isHit AND linked.outdata.zip <> '' AND linked.outdata.zip4 <> '' => TRIM(linked.outdata.zip) + TRIM(linked.outdata.zip4),
										isHit AND linked.outdata.zip <> '' => linked.outdata.zip,
										''
									);
		
	
	SELF.iAddrCode := MAP(~isHit => 'c',
												isSsnMatch AND linked.outdata.isCreditHeader => 'd',
												isFullNameMatch AND isAddressMatch AND linked.outdata.isCreditHeader => 'e',
												isLastNameMatch AND isAddressMatch AND linked.outdata.isCreditHeader => 'h',												
												isSsnMatch AND ~linked.outdata.isCreditHeader => 'D',
												isFullNameMatch AND isAddressMatch AND ~linked.outdata.isCreditHeader => 'E',
												isLastNameMatch AND isAddressMatch AND ~linked.outdata.isCreditHeader => 'H',												
												''
												);
	
	SELF.ownType := '';						// Not required
	SELF.incomeCode := '';				// Not required
	SELF.lengthOfRes := '';				// Not required
	SELF.resType := '';						// Not required
	SELF.spouseName := '';				// Not required
	
	SELF.phone := MAP(isHit => linked.outdata.phone,
										retInput => linked.indata.phoneno,
										''
										);
	
	SELF.rptDate := (STRING8)linked.outdata.dt_last_seen;
	SELF.addr_crt_dt := (STRING8)linked.outdata.dt_first_seen;
	SELF.addr_upt_dt := (STRING8)linked.outdata.dt_last_seen;
		
	SELF := [];
	
ENDMACRO;