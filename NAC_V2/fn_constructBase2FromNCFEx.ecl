IMPORT Std;


Layout_Base2 xContact(Layout_Base2 src, Layouts2.rStateContactEx contact) := TRANSFORM
		// fill in contact fields, but do not overwrite if there is a more specific contact
		boolean ignore := src.ContactName <> '';
		self.ContactName := if(ignore, src.ContactName, contact.ContactName);
		self.ContactPhone := if(ignore, src.ContactPhone, contact.ContactPhone);
		self.ContactExt := if(ignore, src.ContactExt, contact.ContactExt);
		self.ContactEmail := if(ignore, src.ContactEmail, contact.ContactEmail);
		
		self := src;
		
END;

AddContacts(DATASET(layout_Base2) base, DATASET(Layouts2.rStateContactEx) contacts) := FUNCTION
		b1 := DISTRIBUTE(base);	//, HASH64(ProgramState, ProgramCode));
		c1 := contacts;	//, HASH64(ProgramState, ProgramCode));
		// add client specific contacts
		b2 := IF(EXISTS(c1(clientId<>'')),		
						JOIN(b1, c1(clientId<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.ClientId=right.ClientId,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b1);
	// add case specific contacts
		b3 := IF(EXISTS(c1(CaseId<>'')),		
						JOIN(b2, c1(CaseId<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CaseId=right.CaseId,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b2);
	// add county contacts
		b4 := IF(EXISTS(c1(ProgramCounty<>'')),		
						JOIN(b3, c1(ProgramCounty<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.CountyName=right.ProgramCounty,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b3);
	// add regional contacts
		b5 := IF(EXISTS(c1(ProgramRegion<>'')),		
						JOIN(b4, c1(ProgramRegion<>''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode
							and left.RegionCode=right.ProgramRegion,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP),
						b4);
	// add default contact
		b6 := JOIN(b5, c1(ClientId='',CaseId='',ProgramCounty='',ProgramRegion=''),
							left.ProgramState=right.ProgramState
							and left.ProgramCode=right.ProgramCode,
							xContact(LEFT,RIGHT),
							LEFT OUTER, KEEP(1), MANY LOOKUP);

	return b6;
END;

	$.Layout_Base2 xAddress($.Layout_Base2 src, $.Layouts2.rAddressEx addr) := TRANSFORM
	
							self.Physical_AddressCategory := IF(addr.AddressType in ['P','B'],addr.AddressCategory,src.Physical_AddressCategory);	
							self.Physical_Street1 := IF(addr.AddressType in ['P','B'],addr.Street1,src.Physical_Street1);
							self.Physical_Street2 := IF(addr.AddressType in ['P','B'],addr.Street2,src.Physical_Street2);
							self.Physical_City := IF(addr.AddressType in ['P','B'],addr.City,src.Physical_City);
							self.Physical_State := IF(addr.AddressType in ['P','B'],addr.State,src.Physical_State);
							self.Physical_Zip := IF(addr.AddressType in ['P','B'],addr.ZipCode,src.Physical_Zip);
							
							self.Mailing_AddressCategory := IF(addr.AddressType in ['M','B'],addr.AddressCategory,src.Mailing_AddressCategory);	
							self.Mailing_Street1 := IF(addr.AddressType in ['M','B'],addr.Street1,src.Mailing_Street1);
							self.Mailing_Street2 := IF(addr.AddressType in ['M','B'],addr.Street2,src.Mailing_Street2);
							self.Mailing_City := IF(addr.AddressType in ['M','B'],addr.City,src.Mailing_City);
							self.Mailing_State := IF(addr.AddressType in ['M','B'],addr.State,src.Mailing_State);
							self.Mailing_Zip := IF(addr.AddressType in ['M','B'],addr.ZipCode,src.Mailing_Zip);
							
							self.Prepped_addr1 := addr.Prepped_addr1;
							self.Prepped_addr2 := addr.Prepped_addr2;
							self.AddressType := addr.AddressType;

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

JoinAddresses(DATASET($.layout_Base2) base, DATASET($.Layouts2.rAddressEx) addresses) := FUNCTION

		b1 := DISTRIBUTE(base, HASH64(ProgramState, ProgramCode, CaseId));
		addr := DISTRIBUTE(addresses, HASH64(ProgramState, ProgramCode, CaseId));
		// Match client specific addresses first
		ds1m := JOIN(b1, addr(clientId<>'',AddressType in ['M','B']),
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId
					and left.ClientId=right.ClientId,
					xAddress(LEFT,RIGHT),
					LEFT OUTER, KEEP(1), LOCAL);
		ds1p := JOIN(ds1m, addr(clientId<>'',AddressType in ['P','B']),
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId
					and left.ClientId=right.ClientId,
					xAddress(LEFT,RIGHT),
					LEFT OUTER, KEEP(1), LOCAL);
					
		ds1 := ds1m + ds1p;

		// Match on caseid
		ds2m := JOIN(b1, addr(clientId='',AddressType in ['M','B']),
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					xAddress(LEFT,RIGHT),
					LEFT OUTER, KEEP(1), LOCAL);
		ds2 := JOIN(ds2m, addr(clientId='',AddressType in ['P','B']),
					left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					xAddress(LEFT,RIGHT),
					LEFT OUTER, KEEP(1), LOCAL);

		return ds2;
END;


EXPORT fn_constructBase2FromNCFEx(DATASET($.Layouts2.rNac2Ex) ds, string8 version) := FUNCTION

	cases := PROJECT(ds(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										));

	clients := PROJECT(ds(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											)
										);

	addresses := PROJECT(ds(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self := []));

	contacts := PROJECT(ds(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;));
										

	ds1 := PROJECT(cases, TRANSFORM(layout_Base2,
								self.ProgramState := left.ProgramState;
								self.ProgramCode := left.ProgramCode;
								self.GroupId :=  left.GroupId;
								self.CaseId := left.CaseId;
								self.StartDate := left.created;
								self.EndDate := left.updated;
								self.case_Monthly_Allotment := left.MonthlyAllotment;
								self.case_Phone1 := left.Phone1;
								self.case_Phone2 := left.Phone2;
								self.case_Email := left.Email;
								self.RegionCode := left.RegionCode;
								self.CountyCode := left.CountyCode;
								self.CountyName := left.CountyName;
								self.ProcessDate := (unsigned4)Version;
								self.filename := left.filename;
								self.NCF_FileDate := (unsigned4)left.filename[11..18];
								self.NCF_FileTime := left.filename[20..26];
								self := [];
								));

	ds2 := JOIN(DISTRIBUTE(ds1, HASH64(ProgramState,ProgramCode,CaseId)),
				DISTRIBUTE(clients, HASH64(ProgramState,ProgramCode,CaseId)),
				left.ProgramState=right.ProgramState AND left.ProgramCode=right.ProgramCode AND left.CaseId=right.CaseId,
				TRANSFORM(layout_Base2,
					self.case_Last_Name := if(right.HHIndicator='Y', right.LastName, left.LastName);
					self.case_First_Name := if(right.HHIndicator='Y', right.FirstName, left.FirstName);
					self.case_Middle_Name := if(right.HHIndicator='Y', right.MiddleName, left.MiddleName);
					self.case_Name_Suffix := if(right.HHIndicator='Y', right.NameSuffix, left.NameSuffix);
					// save case information
					self.ProgramState := left.ProgramState;
					self.ProgramCode := left.ProgramCode;
					self.CaseId := left.CaseId;
					self.RegionCode := left.RegionCode;
					self.CountyCode := left.CountyCode;
					self.CountyName := left.CountyName;
					self.case_Monthly_Allotment := left.case_Monthly_Allotment;
					self.case_Phone1 := left.case_Phone1;
					self.case_Phone2 := left.case_Phone2;
					self.case_Email := left.case_Email;
										
					// add client information
					self.eligibility_status_indicator := right.Eligibility;
					self.eligibility_status_date := right.EffectiveDate;
					self.HoH_Indicator := right.HHIndicator;
					self.ssn_Type_indicator := right.ssnType;
					self.dob_Type_indicator := right.dobType;
					self.Certificate_id_type := right.Certificate;
					self.ABAWDIndicator := right.ABAWDIndicator;
					self.client_phone := right.phone;
					self.client_email := right.email;
					
					// add date information
					self.StartDate_Raw := right.StartDate;
					self.EndDate_Raw := right.StartDate;
					self.StartDate := fn_FirstDayOfMonth(right.StartDate);
					self.EndDate := fn_LastDayOfMonth(right.EndDate);
					
					self := right;
					self := left;
					), INNER, LOCAL);
					
	// add head of household as case name
	ds3 := JOIN(DISTRIBUTE(ds2(case_last_name=''), HASH64(ProgramState,ProgramCode,CaseId)),
				DISTRIBUTE(clients(HHIndicator='Y'), HASH64(ProgramState,ProgramCode,CaseId)),
				left.ProgramState=right.ProgramState AND left.ProgramCode=right.ProgramCode AND left.CaseId=right.CaseId,
				TRANSFORM(layout_Base2,
					self.case_Last_Name := if(right.HHIndicator='Y', right.LastName, left.LastName);
					self.case_First_Name := if(right.HHIndicator='Y', right.FirstName, left.FirstName);
					self.case_Middle_Name := if(right.HHIndicator='Y', right.MiddleName, left.MiddleName);
					self.case_Name_Suffix := if(right.HHIndicator='Y', right.NameSuffix, left.NameSuffix);
					self := left;
					), LEFT OUTER, KEEP(1), LOCAL);
					
	ds4 := ds2(case_last_name<>'') + ds3;
	
	ds5 := JoinAddresses(ds4, addresses);
	
	ds6 := AddContacts(ds5, contacts);


	return ds6;

END;