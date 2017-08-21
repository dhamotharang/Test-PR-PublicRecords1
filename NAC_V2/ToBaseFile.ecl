import STD, _Validate;
string2 DaysInMonth(string yyyymm) := 
	IntFormat(_Validate.Date.fDaysInMonth((integer)yyyymm[1..4],(integer)yyyymm[5..6]),2,1);
/**

	Convert NCF2 input files to base2 formatted dataset

**/

RollupAddresses(dataset(Nac_V2.Layouts2.rAddressEx) addresses) := FUNCTION

	deduped := DEDUP(SORT(addresses, ProgramState, ProgramCode, CaseID, Prepped_addr1, Prepped_addr2, AddressType, LOCAL),
							ProgramState, ProgramCode, CaseID, Prepped_addr1, Prepped_addr2, AddressType, LOCAL);
							

deduped2 := DEDUP(SORT(DISTRIBUTE(deduped,HASH64(ProgramState, ProgramCode, CaseId)),
							ProgramState, ProgramCode, CaseID, Street1, Street2, City, State, Zipcode, LOCAL),
							ProgramState, ProgramCode, CaseID, Street1, Street2, City, State, Zipcode[1..5], RIGHT, LOCAL);
							
d1 := SORT(deduped2, ProgramState, ProgramCode, CaseID, Prepped_addr1, Prepped_addr2, LOCAL);
//groped := GROUP(d1, ProgramState, ProgramCode, CaseID, ClientId, Prepped_addr1, Prepped_addr2, LOCAL);

rolled := ROLLUP(d1, 
							TRANSFORM(recordof(addresses),
									self.AddressType := 'B'; self := LEFT), 
									ProgramState, ProgramCode, CaseID, Prepped_addr1, Prepped_addr2, LOCAL);

return rolled;
END;

EXPORT ToBaseFile(dataset(Nac_V2.Layouts2.rNac2) nacin) := FUNCTION

	cases := Files('').dsCaseRecords;
	clients := Files('').dsClientRecords;
	addresses := RollupAddresses(Files('').dsAddressRecords);
	contacts := Files('').dsContactRecords;

									
	ds1 := DISTRIBUTE(
					PROJECT(cases, TRANSFORM(Layout_Base2,
										self.case_Monthly_Allotment := left.MonthlyAllotment;
										self.case_Phone1 := left.Phone1;
										self.case_Phone2 := left.Phone2;
										self.case_Email := left.Email;
										self := left;
										self := [];
									)),
						HASH64(ProgramState,ProgramCode,CaseId));
									
	// link to clients
	ds2 := DISTRIBUTE(
				JOIN(ds1, clients,
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					TRANSFORM(Layout_Base2,
							self.ClientId := right.ClientId;
							self.LastName := right.LastName;
							self.FirstName := right.FirstName;
							self.MiddleName := right.MiddleName;
							self.NameSuffix := right.NameSuffix;
							self.Gender := right.Gender;
							self.Race := right.Race;
							self.ethnicity := right.ethnicity;
							self.SSN := right.SSN;
							self.ssn_Type_indicator := right.ssnType;
							self.DOB := right.dob;
							self.dob_Type_indicator := right.dobType;
							self.eligibility_status_indicator := right.Eligibility;
							self.eligibility_status_date := right.EffectiveDate;
							// select phone and email
							self.client_Phone := right.Phone;
							self.client_Email := right.Email;
							self.MonthlyAllotment := right.MonthlyAllotment;
							//
							self.StartDate_Raw := right.StartDate;
							self.EndDate_Raw := right.EndDate;
							sd := TRIM(right.StartDate,LEFT,RIGHT);
							ed := TRIM(right.EndDate,LEFT,RIGHT);
							self.StartDate := (Std.Date.Date_t)IF(LENGTH(sd)=6, sd+'01', sd);
							self.EndDate := (Std.Date.Date_t)IF(LENGTH(ed)=6, ed+DaysInMonth(ed), ed);
							
							self := right;
							self := left;
					),
					LEFT OUTER, LOCAL),
						HASH64(ProgramState,ProgramCode,CaseId));
						
	// find HoH
	/* options:
			1		Normal case, use HoH for Case name
			0		no HoH: use clients
			>1  Multiple HoH ... use earlier effective date
	*/
	ds2hoh := JOIN(ds2, clients(HHIndicator='Y'),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CaseId=right.CaseId,
							TRANSFORM(Layout_Base2,
									self.case_Last_Name := right.LastName;
									self.case_First_Name := right.FirstName;
									self.case_Middle_Name := right.MiddleName;
									self.case_Name_suffix := right.NameSuffix;
									self := left;
							), LEFT OUTER, KEEP(1), LOCAL);
							
	ds2hoh2 := PROJECT(ds2hoh, TRANSFORM(Layout_Base2,
									self.case_Last_Name :=  IF(left.case_Last_Name= '', left.LastName, left.case_Last_Name);
									self.case_First_Name := IF(left.case_First_Name= '', left.FirstName, left.case_First_Name);
									self.case_Middle_Name := IF(left.case_Middle_Name= '', left.MiddleName, left.case_Middle_Name);
									self.case_Name_suffix := IF(left.case_Name_suffix= '', left.NameSuffix, left.case_Name_suffix);
									self := left;
							));
					
	// join to addresses
	
	Layout_Base2 xAddress(Layout_Base2 src, Layouts2.rAddressEx addr) := TRANSFORM
	
							self.Physical_AddressCategory := IF(addr.AddressType in ['P','B'],addr.AddressCategory,'');	
							self.Physical_Street1 := IF(addr.AddressType in ['P','B'],addr.Street1,'');
							self.Physical_Street2 := IF(addr.AddressType in ['P','B'],addr.Street2,'');
							self.Physical_City := IF(addr.AddressType in ['P','B'],addr.City,'');
							self.Physical_State := IF(addr.AddressType in ['P','B'],addr.State,'');
							self.Physical_Zip := IF(addr.AddressType in ['P','B'],addr.ZipCode,'');
							
							self.Mailing_AddressCategory := IF(addr.AddressType in ['M','B'],addr.AddressCategory,'');	
							self.Mailing_Street1 := IF(addr.AddressType in ['M','B'],addr.Street1,'');
							self.Mailing_Street2 := IF(addr.AddressType in ['M','B'],addr.Street2,'');
							self.Mailing_City := IF(addr.AddressType in ['M','B'],addr.City,'');
							self.Mailing_State := IF(addr.AddressType in ['M','B'],addr.State,'');
							self.Mailing_Zip := IF(addr.AddressType in ['M','B'],addr.ZipCode,'');
							
							self.Prepped_addr1 := addr.Prepped_addr1;
							self.Prepped_addr2 := addr.Prepped_addr2;

							self.prim_range := addr.prim_range;
							self.predir := addr.predir;
							self.prim_name := addr.prim_name;
							self.addr_suffix := addr.addr_suffix;
							self.postdir := addr.postdir;
							self.unit_desig := addr.unit_desig;
							self.sec_range := addr.sec_range;
							self.p_city_name := addr.p_city_name;
							self.v_city_name := addr.v_city_name;
							self.st := addr.st;
							self.zip := addr.zip;
							self.zip4 := addr.zip4;
							self.cart := addr.cart;
							self.cr_sort_sz := addr.cr_sort_sz;
							self.lot := addr.lot;
							self.lot_order := addr.lot_order;
							self.dbpc := addr.dbpc;
							self.chk_digit := addr.chk_digit;
							self.rec_type := addr.rec_type;
							self.fips_state := addr.fips_state;
							self.fips_county := addr.fips_county;
							self.geo_lat := addr.geo_lat;
							self.geo_long := addr.geo_long;
							self.msa := addr.msa;
							self.geo_blk := addr.geo_blk;
							self.geo_match := addr.geo_match;
							self.err_stat := addr.err_stat;
							
							self := src;
	
	END;
	
	// Match client specific addresses first
	ds3 := JOIN(ds2hoh2, addresses,
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					xAddress(LEFT,RIGHT),
					LEFT OUTER, LOCAL);

	// Match case specific addresses 
/*	ds3b := JOIN(ds3a(Physical_AddressCategory='',Mailing_AddressCategory=''), addresses(ClientId = ''),
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					xAddress(LEFT,RIGHT),
					LEFT OUTER, LOCAL);

  ds3 := ds3a(Physical_AddressCategory<>'' OR Mailing_AddressCategory<>'') + ds3b;
*/					
	// rollup physical and mailing addresses.
	ds4 :=	ROLLUP(
						SORT(
							DISTRIBUTE(ds3,	HASH64(ProgramState,ProgramCode,CaseId,ClientId)),
							ProgramState,ProgramCode,CaseId,ClientId,StartDate, LOCAL),
							TRANSFORM(Layout_Base2,
								self.Physical_AddressCategory := IF(left.Physical_State='' ,right.Physical_AddressCategory,left.Physical_AddressCategory);	
								self.Physical_Street1 := IF(left.Physical_State='',right.Physical_Street1,left.Physical_Street1);
								self.Physical_Street2 := IF(left.Physical_State='',right.Physical_Street2,left.Physical_Street2);
								self.Physical_City := IF(left.Physical_State='',right.Physical_City,left.Physical_City);
								self.Physical_State := IF(left.Physical_State='',right.Physical_State,left.Physical_State);
								self.Physical_Zip := IF(left.Physical_State='',right.Physical_Zip,left.Physical_Zip);
								
								self.Mailing_AddressCategory := IF(left.Mailing_State='',right.Mailing_AddressCategory,left.Mailing_AddressCategory);	
								self.Mailing_Street1 := IF(left.Mailing_State='',right.Mailing_Street1,left.Mailing_Street1);
								self.Mailing_Street2 := IF(left.Mailing_State='',right.Mailing_Street2,left.Mailing_Street2);
								self.Mailing_City := IF(left.Mailing_State='',right.Mailing_City,left.Mailing_City);
								self.Mailing_State := IF(left.Mailing_State='',right.Mailing_State,left.Mailing_State);
								self.Mailing_Zip := IF(left.Mailing_State='',right.Mailing_Zip,left.Mailing_Zip);
							
								self := left),
							ProgramState,ProgramCode,CaseId,ClientId,StartDate, LOCAL);
							
	// Add state contact
	// for now, all contacts are state or county wide.
	ds5 := DISTRIBUTE(ds4, HASH64(ProgramState, ProgramCode));
	
	ds6 := JOIN(ds5, contacts,
						LEFT.ProgramState=RIGHT.ProgramState
						AND LEFT.ProgramCode=RIGHT.ProgramCode,
						TRANSFORM(Layout_Base2,
							self.ContactName := right.ContactName;
							self.ContactPhone := right.ContactPhone;
							self.ContactExt := right.ContactExt;
							self.ContactEmail := right.ContactEmail;
							self := LEFT;
						),
						LEFT OUTER, LOCAL);


	return ds6;

END;