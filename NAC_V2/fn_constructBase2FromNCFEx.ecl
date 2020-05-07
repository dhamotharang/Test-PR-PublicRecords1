﻿IMPORT Std;

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

		b1 := DISTRIBUTE(base, HASH32(GroupId, ProgramState, ProgramCode, CaseId));
		addr := DISTRIBUTE(addresses, HASH32(GroupId, ProgramState, ProgramCode, CaseId));
		// Match client specific addresses first
		ds_cl_match := JOIN(b1, addr(clientId<>'',(integer)clientid<>0),
					left.GroupId=right.GroupId
					and left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId
					and left.ClientId=right.ClientId,
					xAddress(LEFT,RIGHT),
					Inner, KEEP(2), LOCAL);
		// No client matches
		ds_cl_nomatch := JOIN(b1, addr(clientId<>'',(integer)clientid<>0),
					left.GroupId=right.GroupId
					and left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId
					and left.ClientId=right.ClientId,
					TRANSFORM(nac_v2.Layout_Base2, self := left;),
					LEFT Only, LOCAL);
		// case matched
		ds_ca_match := JOIN(ds_cl_nomatch, addr(clientId='' OR (integer)clientid=0),
					left.GroupId=right.GroupId
					and left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					xAddress(LEFT,RIGHT),
					Inner, KEEP(2), LOCAL);
		// No case matches
		ds_ca_nomatch := JOIN(ds_cl_nomatch, addr(clientId<>'' Or (integer)clientid=0),
					left.GroupId=right.GroupId
					and left.ProgramState=right.ProgramState
					and left.ProgramCode=right.ProgramCode
					and left.CaseId=right.CaseId,
					TRANSFORM(nac_v2.Layout_Base2, self := left;),
					LEFT Only, LOCAL);
		
		return ds_cl_match + ds_ca_match + ds_ca_nomatch;
END;


EXPORT fn_constructBase2FromNCFEx(DATASET($.Layouts2.rNac2Ex) ds, string8 version) := FUNCTION

	ca1 := DISTRIBUTE(PROJECT(ds(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										)), hash32(CaseId));
										
	cases := DEDUP(SORT(ca1(errors=0), CaseId,ProgramState,ProgramCode,GroupId, -seqnum, local),
									CaseId,ProgramState,ProgramCode,GroupId, local);

	cl1 := DISTRIBUTE(PROJECT(ds(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											)
										), HASH32(ClientId));

	clients := DEDUP(SORT(cl1(errors=0), ClientId,CaseId,ProgramState,ProgramCode,GroupId,-seqnum, local),
									ClientId,CaseId,ProgramState,ProgramCode,GroupId, local);

	ad1 := DISTRIBUTE(PROJECT(ds(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self := [])), HASH32(CaseId, ClientId));

	addresses := DEDUP(SORT(ad1(errors=0), CaseId,ClientId,ProgramState,ProgramCode,GroupId,AddressType,-seqnum, local),
									CaseId,ClientId,ProgramState,ProgramCode,GroupId,AddressType, local);

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
								self.NCF_FileTime := left.filename[20..25];
								self.created := left.created;
								self.updated := left.updated;
								self.replaced := left.replaced;
								self := [];
								));

	ds2 := JOIN(DISTRIBUTE(ds1, HASH32(GroupId, ProgramState,ProgramCode,CaseId)),
				DISTRIBUTE(clients, HASH32(GroupId, ProgramState,ProgramCode,CaseId)),
								left.GroupId=right.GroupId
								AND left.ProgramState=right.ProgramState
								AND left.ProgramCode=right.ProgramCode
								AND left.CaseId=right.CaseId,
				TRANSFORM(layout_Base2,
					self.case_Last_Name := if(right.HHIndicator='Y', right.LastName, left.LastName);
					self.case_First_Name := if(right.HHIndicator='Y', right.FirstName, left.FirstName);
					self.case_Middle_Name := if(right.HHIndicator='Y', right.MiddleName, left.MiddleName);
					self.case_Name_Suffix := if(right.HHIndicator='Y', right.NameSuffix, left.NameSuffix);
					// save case information
					self.ProgramState := left.ProgramState;
					self.ProgramCode := left.ProgramCode;
					self.GroupId := left.GroupId;
					self.CaseId := left.CaseId;
					self.RegionCode := left.RegionCode;
					self.CountyCode := left.CountyCode;
					self.CountyName := left.CountyName;
					self.case_Monthly_Allotment := left.case_Monthly_Allotment;
					self.case_Phone1 := left.case_Phone1;
					self.case_Phone2 := left.case_Phone2;
					self.case_Email := left.case_Email;
					self.filename := left.filename;
					self.OrigGroupId := left.OrigGroupId;
					self.Created := left.Created;
					self.Updated := left.Updated;
										
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
					self.EndDate_Raw := right.EndDate;
					self.StartDate := IF(right.PeriodType='M',fn_FirstDayOfMonth(right.StartDate), (integer)right.StartDate);
					self.EndDate := IF(right.PeriodType='M',fn_LastDayOfMonth(right.EndDate), (integer)right.EndDate);
					
					// create unique id. For backward compatibility, this is limited to 6 bytes
					year2020 := Std.Date.FromJulianYMD(2020,1,1); 	// nothing before 2020
					year := Std.Date.FromJulianYMD((unsigned)(right.filename[11..14]),(unsigned)(right.filename[15..16]),(unsigned)(right.filename[17..18]));
					id := year - year2020;		// good for 50 years
					self.PrepRecSeq := if(right.filename='',0,
						HASHCRC(right.GroupId,right.ProgramCode) | (id << 32) );

					self := right;
					self := left;
					), LEFT OUTER, LOCAL);
					
	// add head of household as case name
	ds3 := JOIN(DISTRIBUTE(ds2(case_last_name=''), HASH32(ProgramState,ProgramCode,CaseId)),
				DISTRIBUTE(clients(HHIndicator='Y'), HASH32(ProgramState,ProgramCode,CaseId)),
								left.GroupId=right.GroupId
								AND left.ProgramState=right.ProgramState
								AND left.ProgramCode=right.ProgramCode
								AND left.CaseId=right.CaseId,
				TRANSFORM(layout_Base2,
					self.case_Last_Name := if(right.HHIndicator='Y', right.LastName, left.LastName);
					self.case_First_Name := if(right.HHIndicator='Y', right.FirstName, left.FirstName);
					self.case_Middle_Name := if(right.HHIndicator='Y', right.MiddleName, left.MiddleName);
					self.case_Name_Suffix := if(right.HHIndicator='Y', right.NameSuffix, left.NameSuffix);
					self := left;
					), LEFT OUTER, KEEP(1), LOCAL);
					
	ds4 := ds2(case_last_name<>'') + ds3;
	
	ds5 := JoinAddresses(ds4, addresses);

	return ds5;

END;