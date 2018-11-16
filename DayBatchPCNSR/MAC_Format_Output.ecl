export MAC_Format_Output(linked,search) := MACRO
		
		isHit := DayBatchPCNSR.isProcessHit(TRIM(linked.matchCode),TRIM(search));
		retInput := DayBatchPCNSR.returnsInput(search);
		
		fullPhone := MAP(~isHit => '',
										 linked.outdata.area_code <> '' => TRIM(linked.outdata.area_code) + TRIM(linked.outdata.phone_number),
										 TRIM(linked.outdata.phone_number)
										);
		
		isNewPhone := DayBatchUtils.IsLeftComponentNew(fullPhone,linked.indata.phoneno);
		isFullNameMatch := StringLib.StringContains(linked.matchCode,'FL',true);
		isLastNameMatch := StringLib.StringContains(linked.matchCode,'L',true);
		isNewAddress := DayBatchUtils.IsLeftComponentNew(linked.outdata.prim_range,linked.indata.prim_range) OR
										ut.StringSimilar(linked.outdata.prim_name,linked.indata.prim_name) > 3 OR
										DayBatchUtils.IsLeftComponentNew(linked.outdata.zip,linked.indata.z5) OR
										DayBatchUtils.IsLeftComponentNew(linked.outdata.sec_range,linked.indata.sec_range);

		inputAddress := Address.Addr1FromComponents(linked.indata.prim_range,linked.indata.predir,linked.indata.prim_name,
											linked.indata.addr_suffix,linked.indata.postdir,linked.indata.unit_desig,linked.indata.sec_range);
		SELF.phone := fullPhone;
		SELF.phone7 := IF(isHit,linked.outdata.phone_number,'');
		addr1 := MAP(isHit =>
										Address.Addr1FromComponents(linked.outdata.prim_range,linked.outdata.predir,linked.outdata.prim_name,
											linked.outdata.addr_suffix,linked.outdata.postdir,linked.outdata.unit_desig,linked.outdata.sec_range),
								 retInput =>	inputAddress,
								 '');

		SELF.address1 := IF(isHit AND addr1 = '','GENERAL DELIVERY',addr1);
		
		SELF.address2 :=  MAP(isHit => Address.Addr2FromComponents(linked.outdata.p_city_name,linked.outdata.st,linked.outdata.zip),
													retInput => Address.Addr2FromComponents(linked.indata.p_city_name,linked.indata.st,linked.indata.z5),
													''
												);

		SELF.strAddr := IF(retInput,inputAddress,'');

		SELF.zip := MAP(isHit AND linked.outdata.zip <> '' AND linked.outdata.zip4 <> '' => TRIM(linked.outdata.zip) + TRIM(linked.outdata.zip4),
										isHit => linked.outdata.zip,
										retInput => linked.indata.z5,
										''
										 );
										 
		SELF.city := MAP(isHit => linked.outdata.p_city_name,
										 retInput => linked.indata.p_city_name,
										 ''
										 );
										 
		SELF.state := MAP(isHit => linked.outdata.st,
											retInput => linked.indata.st,
											'');

		SELF.incomeCode := MAP(	~isHit => '',
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 125000
															=> '9',
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 100000
															=> '8',		
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 75000
															=> '7',		
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 50000
															=> '6',		
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 40000
															=> '5',		
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 30000
															=> '4',	
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 20000
															=> '3',		
														(UNSIGNED)linked.outdata.find_income_in_1000s >= 15000
															=> '2',		
														(UNSIGNED)linked.outdata.find_income_in_1000s > 0
															=> '1',															
														'0');
		SELF.lengthOfRes := MAP( ~isHit => '',
														(UNSIGNED)linked.outdata.length_of_residence >= 15
															=> 'F',
														(UNSIGNED)linked.outdata.length_of_residence >= 14
															=> 'E',
														(UNSIGNED)linked.outdata.length_of_residence >= 13
															=> 'D',
														(UNSIGNED)linked.outdata.length_of_residence >= 12
															=> 'C',
														(UNSIGNED)linked.outdata.length_of_residence >= 11
															=> 'B',
														(UNSIGNED)linked.outdata.length_of_residence >= 10
															=> 'A',
														(STRING)((UNSIGNED)linked.outdata.length_of_residence)
														);

		SELF.spouseName := IF(isHit AND linked.outdata.spouse_indicator = 'Y',
													linked.outdata.spouse_fname,'');														
		SELF.rptDate := IF(isHit,linked.outdata.refresh_date,'');
		SELF.latitude := IF(isHit,linked.outdata.geo_lat,'');
		SELF.longitude := IF(isHit,linked.outdata.geo_long,'');
		SELF.addr_crt_dt := IF(isHit,linked.outdata.household_arrival_date,'');
		SELF.addr_upt_dt := IF(isHit,linked.outdata.refresh_date,'');
		SELF.resType := MAP(isHit AND linked.outdata.location_type = 'S' => '1',
												isHit AND linked.outdata.location_type = 'M' => '3',
												isHit => '0',
												''
												);				
		SELF.coaFlag := '';//NOT REQUIRED
		SELF.ownType := MAP(isHit AND linked.outdata.own_rent IN ['7','8','9'] => '2',
												isHit AND linked.outdata.own_rent IN ['1','2','3','4','5','6'] => '1',
												isHit => '0',
												''
												);
		SELF.addrChar_in := '';//NOT REQUIRED
		
		SELF.phoneStatus := MAP(isHit AND ~isNewPhone => '1',
														isHit AND isFullNameMatch AND ~isNewAddress => '3',
														isHit AND isLastNameMatch AND ~isNewAddress => '4',
														isHit AND ~isNewAddress => '5',
														''
														);
		altACode := DayBatchUtils.GetNewAreaCode(linked.outdata.area_code,linked.outdata.phone_number);
		altACodeDt := DayBatchUtils.GetNewAreaCodeDate(linked.outdata.area_code,linked.outdata.phone_number);
		
		SELF.altAreaCode := IF(isHit,altACode,'');				
		SELF.altAreaCodeDate := IF(isHit,altACodeDt,'');
		
		firstCode := MAP(isHit AND altACode = '' => 'L',
										 isHit => 'A',
										 '');
		
		secondCode := MAP(isHit AND linked.outdata.business_file_hit_flag = 'Y' => '5',
											isHit AND (isFullNameMatch OR isLastNameMatch) AND ~isNewAddress => '3',
											isHit AND ~isNewAddress => '4',
											''
											);
											
		SELF.iCode := firstCode + secondCode;
		
		SELF.address_type := MAP(isHit AND linked.outdata.address_type = '0' => 'NO ADDRESS',
														 isHit AND linked.outdata.address_type = '1' => 'STREET NAME AND HOUSE NUMBER',
														 isHit AND linked.outdata.address_type = '2' => 'STREET NAME ONLY',
														 isHit AND linked.outdata.address_type = '3' => 'RURAL ROUTE/GENERAL DELIVER',
														 isHit AND linked.outdata.address_type = '4' => 'BOX NUMBER ONLY',
														 isHit AND linked.outdata.address_type = '5' => 'ROUTE AND BOX ONLY',
														 ''
														);

		SELF.statusNameAddress := MAP(isHit AND isFullNameMatch AND ~isNewAddress
																		=> '1',
																	isHit AND isLastNameMatch AND ~isNewAddress
																		=> '2',
																	isHit AND isFullNameMatch AND isNewAddress
																		=> '3',
																	isHit AND isLastNameMatch AND isNewAddress
																		=> '4',
																	isHit AND isNewAddress
																		=> '5',
																	isHit AND ~isNewAddress
																		=> '6',
																	~isHit AND retInput => '0',
																	''
																	);

		SELF.addrChar_out := '';//NOT REQUIRED
		SELF.pobox := '';//NOT REQUIRED
		SELF.acctno := linked.indata.acctno;
		SELF.matchCode := MAP(isHit AND search IN ['USPAGE_FL137Z','USPAGE_FL13Z'] AND linked.matchCode IN ['FL137Z','FL13Z','FL3Z']
														=> 'FAZ',
													isHit AND search IN ['USPAGE_FL137Z','USPAGE_FL13Z'] AND linked.matchCode IN ['L137Z','L13Z','L3Z']
														=> 'LAZ',
													isHit AND search IN ['USPAGE_FL137Z','USPAGE_FL13Z']
														=> 'AZ5',
													isHit => linked.matchCode,
													'');
		
		SELF.fname := MAP(isHit => linked.outdata.fname,
											retInput => linked.indata.name_first,
											'');
		SELF.lname := MAP(isHit => linked.outdata.lname,
											retInput => linked.indata.name_last,
											'');
		SELF.mname := IF(isHit,linked.outdata.mname,'');
		SELF.suffix := IF(isHit,linked.outdata.name_suffix,'');
		SELF.prim_range := MAP(isHit => linked.outdata.prim_range,
													 retInput => linked.indata.prim_range,
													 '');
		SELF.predir := MAP(isHit => linked.outdata.predir,
											 retInput => linked.indata.predir,
											 '');
		SELF.prim_name := MAP(isHit => linked.outdata.prim_name,
													retInput => linked.indata.prim_name,
													'');
		SELF.addr_suffix := MAP(isHit => linked.outdata.addr_suffix,
														retInput => linked.indata.addr_suffix,
														'');
		SELF.postdir := MAP(isHit => linked.outdata.postdir,
												retInput => linked.indata.postdir,
												'');
		SELF.unit_desig := MAP(isHit => linked.outdata.unit_desig,
													 retInput => linked.indata.unit_desig,
													 '');
		SELF.sec_range := MAP(isHit => linked.outdata.sec_range,
													retInput => linked.indata.sec_range,
													'');
		SELF.area_code := IF(isHit,linked.outdata.area_code,'');
		
		SELF.priority := IF(isHit,(STRING)DayBatchPCNSR.getPriority(linked.matchCode,search),'');

		SELF := [];
ENDMACRO;