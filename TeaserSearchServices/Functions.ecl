import AutoStandardI, doxie, iesp, standard, ut, Header, NID, Address, Suppress, Email_Data, std, American_student_list, dx_header;

export Functions := MODULE
	
	shared UNSIGNED2 OLD_MaxCountNames := 5;
	shared UNSIGNED2 OLD_MaxCountAddresses := 5;	
			
	export PrefFirstMatch2(string20 pfname, string20 r) := function
			return  NID.mod_PFirstTools.SubLinPFR(pfname, r) or pfname[1..length(trim(r))]=r;
	end;
	export TeaserSearchServices.Layouts.records_plus combine(Header.layout_teaser l, 
																			DATASET(Header.layout_teaser) r, 
																			boolean IncludeAllAddresses = false) := TRANSFORM
		// need to calc penalties on each of the historical records, then preserve the lowest for the group
		layout_pen := record(Header.layout_teaser)
			unsigned1 name_penalt; 
			unsigned1 addr_penalt;
			unsigned1 penalt;
		end;
		
		layout_pen calcPen(Header.layout_teaser rec) := transform
			name_p := doxie.FN_Tra_Penalty_Name(rec.fname,rec.mname,rec.lname);
			addr_p := doxie.FN_Tra_Penalty_Addr('','',rec.prim_name,'','','',rec.city_name,rec.st,rec.zip) +
																					// this will slighty penalize each of the non-current addresses
																					// so that a match on current address will bubble to the top
																					IF(rec.isCurrent, 0, 1);
			self.name_penalt := name_p;
			self.addr_penalt := addr_p;
			self.penalt := name_p + addr_p;
			self := rec;
		end;

		with_pen := project(r, calcPen(LEFT));

		self.penalt := MIN(with_pen, penalt);
		
		layout_name_pen := record(iesp.share.t_Name)
			unsigned1 penalt;
			unsigned1 nameOrder;
		end;
		
		layout_name_pen xformName(with_pen ri) := TRANSFORM
			self.Prefix := ri.title;
			self.First := ri.fname;
			self.Middle := ri.mname;
			self.Last := ri.lname;
			self.Suffix := ri.name_suffix;
			self.penalt := ri.name_penalt;
			self.nameOrder := ri.nameOrder;
			self := [];
		END;
		
		names := PROJECT(with_pen, xformName(LEFT));

		// allow for mname NNEQ behavior; keep the longest of the equiv mnames
		nneq_mname(string mn1, string mn2) := mn1 = '' or mn2 = '' or mn1 = mn2 or 
																					mn1[1] = mn2 or mn1 = mn2[1];

		layout_name_pen getNames(names l, names r) := transform
			self.middle := if(length(l.middle) > length(r.middle), l.middle, r.middle);
			self := l;
		end;
		
		names_ddp := ROLLUP(SORT(names, last, first, middle, prefix, suffix), 
											 left.last = right.last and
											 left.first = right.first and
											 nneq_mname(left.middle, right.middle) and
											 ut.nneq(left.prefix, right.prefix) and
											 ut.nneq(left.suffix, right.suffix), getNames(left, right));
		 SELF.Names := PROJECT(TOPN(names_ddp, 
									if(IncludeAllAddresses, iesp.Constants.ThinRps.MaxCountNames, 
														OLD_MaxCountNames), -nameOrder, penalt),
													 iesp.share.t_Name);
		
		iesp.thinrolluppersonsearch.t_ThinRpsAddress makeAddrs(Header.layout_teaser ri) := TRANSFORM
			self.DateLastSeen := iesp.ECL2ESP.toDateYM(ri.dt_last_seen);
			self.VendorDateLastSeen := iesp.ECL2ESP.toDateYM(ri.dt_vendor_last_reported);
			self.City := ri.city_name;
			self.State := ri.st;
			self.Zip5 := ri.zip;
			self.Zip4 := ri.zip4;
			self := [];
		END;
		uniqAddrs := DEDUP(SORT(r, prim_name, city_name, zip, -dt_last_seen, -dt_vendor_last_reported, record), prim_name, city_name, zip);
		// need to combine the slimmed addresses and dedup, keeping the best addr first
		allAddrs := DEDUP(PROJECT(SORT(uniqAddrs, -dt_last_seen, -dt_vendor_last_reported),makeAddrs(LEFT)), city, zip5);
		SELF.Addresses := CHOOSEN(allAddrs, if(IncludeAllAddresses, 
													iesp.Constants.ThinRps.MaxCountAddresses, 
																OLD_MaxCountAddresses));

		yob(integer4 dob) := dob div 10000;
		mob(integer4 dob) := (dob % 10000) div 100;
		day(integer4 dob) := dob % 100;
		EquivDates(integer4 d1, integer4 d2) := ut.nneq_int((string)(yob(d1)),(string)(yob(d2))) and 
																					 ut.nneq_int((string)mob(d1),(string)mob(d2)) and
																					 ut.nneq_int((string)day(d1),(string)day(d2));
		
		uniqDOBs := DEDUP(SORT(r, dob), equivDates(LEFT.dob, RIGHT.dob), RIGHT);
		iesp.thinrolluppersonsearch.t_ThinRpsDOB makeDOB(Header.layout_teaser ri) := TRANSFORM
			self.DOB := iesp.ECL2ESP.toDate(ri.dob);			
			self.Age := ut.Age(ri.dob);
		END;
		
		self.DOBs := project(uniqDOBs, makeDOB(LEFT));

		uniqDODs := DEDUP(SORT(r, dod), equivDates(LEFT.dod, RIGHT.dod), RIGHT);
		iesp.thinrolluppersonsearch.t_ThinRpsDOD makeDOD(Header.layout_teaser ri) := TRANSFORM
			self.DOD := iesp.ECL2ESP.toDate(ri.dod);
			self.DeadAge := IF(ri.dod<>0 and ri.dob<>0, (ri.dod-ri.dob) div 10000, 0);
		END;
		
		self.DODs := project(uniqDODs, makeDOD(LEFT));
		
		self.UniqueId := INTFORMAT(l.did,12,1);
		self := l;
		self.Relatives := [];
		self.RelativesNew	:=	[];
	END;

	export AddPhoneIndicator(dataset(TeaserSearchServices.Layouts.records_plus) recs_in, boolean display_phone) := function
	
		recs_pres := project(recs_in, transform(doxie.layout_presentation,
																						self.city_name := left.Addresses[1].city,
																						self.st := left.Addresses[1].state,
																						self.zip := left.Addresses[1].zip5,
																						self.did := (unsigned6) left.uniqueId,
																						self.fname := left.Names[1].First,
																						self.lname := left.Names[1].Last,
																						// append gong rolls up by RID, so need them unique
																						self.rid := counter,
																						self := left,
																						self := []));
																						
		recs_hhid := join(recs_pres, dx_header.key_did_hhid(), keyed(left.did = right.did), 
											transform(doxie.layout_presentation, 
																self.hhid := right.hhid,
																self := left),
                      // not sure why keep(1), there can be more than one match;
                      // but to be consistent with it, I'm using limit(0)
											left outer, limit (0), keep(1));
																					 
		recs_dids := project(recs_in, transform(doxie.layout_references,
																	self.did := (unsigned6) left.uniqueId));
		
		// Call doxie relative dids to retrieve necessary relative info
		rel_dids := doxie.relative_dids(recs_dids);
							
		recs_append := doxie.Append_Gong(recs_hhid,rel_dids);

		recs_in setPhoneInd(recs_in le, recs_append ri) := transform
			hasPhone := ri.did <> 0 and ri.tnt in ['B', 'V'] and ri.listed_phone <> '';
			phoneNum := if(hasPhone, ri.listed_phone[1..3] + ri.listed_phone[4..4]+'XXXXXX','');
			
			self.addresses := project(le.addresses, 
																transform(iesp.thinrolluppersonsearch.t_ThinRpsAddress, 
																// addresses are reverse chron; only the first one can get the phone indicator
																phn_flag := counter = 1 and hasPhone;															
																self.phoneIndicator	:= phn_flag;															
																self.phone := if(phn_flag and display_phone, phoneNum, '');
																self := left));
			self := le;
		end;
		
		with_ind := join(recs_in, recs_append, (unsigned6) left.uniqueId = right.did, 
										 setPhoneInd(left,right));	 
		return with_ind;
	end;

	export historicalNamesAddrs(dataset(doxie.layout_references) dids, boolean IncludeAllAddresses,
                              doxie.IDataAccess mod_access) := function

		uniq_dids := dedup(sort(dids, did), did);
		
		hist_recs_pre := join(uniq_dids, Header.Key_Teaser_cnsmr_did, keyed(left.did = right.did), 
											transform(Header.layout_teaser, self := right), 
											limit(ut.limits.FETCH_KEYED, SKIP));
    hist_recs := Suppress.MAC_SuppressSource(hist_recs_pre,mod_access);                  
		recs_grp := group(sort(hist_recs, did, -isCurrent), did);
		recs_history := rollup(recs_grp, GROUP, combine(LEFT,ROWS(LEFT), IncludeAllAddresses));
		return recs_history;
	end;
			
	export AddRelativeNames(dataset(TeaserSearchServices.Layouts.records_plus) recs_in,
	                        string32 application_type_value) := function
		dids := PROJECT(recs_in,TRANSFORM(doxie.layout_references, SELF.did := (unsigned)LEFT.UniqueId));
		dids_grpd := group(sort(dids, did), did);
		rels := doxie.relative_names(dids_grpd,false, true);
			
		TeaserSearchServices.Layouts.records_plus addRels(recs_in le, rels ri) :=
		TRANSFORM
		
			iesp.ThinRollupPersonSearch.t_ThinRpsRelative xformRelsNew(Standard.Name_DID	r)	:=
			TRANSFORM
				self.Name.First		:=	r.fname;
				self.Name.Middle	:=	r.mname;
				self.Name.Last		:=	r.lname;
				self.Name.Suffix	:=	r.name_suffix;
				self.UniqueID			:=	intformat(r.DID,12,1);
				self							:=	[];
			END;

			SELF.RelativesNew := PROJECT(CHOOSEN(ri.names,iesp.Constants.ThinRps.MaxCountRelatives),xformRelsNew(LEFT));
			
			iesp.share.t_Name xformRels(Standard.Name_DID	r)	:=
			TRANSFORM
				self.First	:=	r.fname;
				self.Middle	:=	r.mname;
				self.Last		:=	r.lname;
				self.Suffix	:=	r.name_suffix;
				self				:=	[];
			END;
			
			SELF.Relatives := PROJECT(CHOOSEN(ri.names,iesp.Constants.ThinRps.MaxCountRelatives),xformRels(LEFT));
			
			SELF := le;
		END;
		
		// adding necessary suppression here for relatives V3 	
		relsSuppressed := PROJECT(rels, TRANSFORM(RECORDOF(LEFT),
		                      tmpNames := PROJECT(LEFT.Names, TRANSFORM(LEFT));
													Suppress.MAC_Suppress(tmpNames,tmpNamesSuppressed,
		                       application_type_value,Suppress.Constants.LinkTypes.DID,DID);	
                         SELF.Names := tmpNamesSuppressed; 
											   SELF := LEFT;
												 ));
													
		with_rels := JOIN(recs_in, relsSuppressed, (UNSIGNED6)LEFT.UniqueId=RIGHT.did, addRels(LEFT,RIGHT), LOOKUP, LEFT OUTER);
																																					      
		return with_rels;
	end;
	
	export getFakeAddress(iesp.thinrolluppersonsearch.t_ThinRpsSearchRecord inrec) := function
		rnd:=random() : independent;
		rndID:=rnd%1195;
		validatedRndID:=if(rndID>1000,rndID-1000,rndID);
		getData:=TeaserSearchServices.Fake_Address_Info(id=validatedRndID);
		//create fake data based on last address....
		iesp.thinrolluppersonsearch.t_ThinRpsAddress appendFakeData(iesp.thinrolluppersonsearch.t_ThinRpsSearchRecord inrec, String2 fakeState, String fakeCity, String5 fakeZip) := transform
			integer4 CntAddresses := count(inrec.Addresses);
			fakeYear := inrec.Addresses[CntAddresses].DateLastSeen.year - 1;
			fakeMonth := inrec.Addresses[CntAddresses].DateLastSeen.month;
			fakeDay := inrec.Addresses[CntAddresses].DateLastSeen.day;
			self.DateLastSeen.Year := fakeYear;
			self.DateLastSeen.Month := fakeMonth;
			self.DateLastSeen.Day := fakeDay;
			self.VendorDateLastSeen.Year := fakeYear;			
			self.VendorDateLastSeen.Month := fakeMonth;
			self.VendorDateLastSeen.Day := fakeDay;
			self.VendorDateFirstSeen.Year := fakeYear;
			self.VendorDateFirstSeen.Month := fakeMonth;
			self.VendorDateFirstSeen.day := fakeDay;
			self.City := fakeCity;
			self.State := fakeState;
			self.Zip5 := fakeZip;
			self.Zip4 := '';
			self.PhoneIndicator := false;
			self.Phone := '';
		end;
		//project results
		results:=project(inrec,appendFakeData(left,getData[1].State,getData[1].City_Name,getData[1].zip));
		return results;
	end;
	
	/*--- FakeData for Intelius ---*/
	export getExtendedFakeAddress(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord inrec) := function
		rnd:=random() : independent;
		rndID:=rnd%1195;
		validatedRndID:=if(rndID>1000,rndID-1000,rndID);
		getData:=TeaserSearchServices.Fake_Address_Info(id=validatedRndID);
	
		//create fake data based on last address....
		iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchAddress appendFakeDataExtended(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord inrec, String2 fakeState, String fakeCity, String5 fakeZip) := transform
			integer4 CntAddresses := count(inrec.Addresses);
			fakeYear := inrec.Addresses[CntAddresses].DateLastSeen.year - 1;
			fakeMonth := inrec.Addresses[CntAddresses].DateLastSeen.month;
			fakeDay := inrec.Addresses[CntAddresses].DateLastSeen.day;
			self.DateLastSeen.Year := fakeYear;
			self.DateLastSeen.Month := fakeMonth;
			self.DateLastSeen.Day := fakeDay;
			self.VendorDateLastSeen.Year := fakeYear;			
			self.VendorDateLastSeen.Month := fakeMonth;
			self.VendorDateLastSeen.Day := fakeDay;
			self.VendorDateFirstSeen.Year := fakeYear;
			self.VendorDateFirstSeen.Month := fakeMonth;
			self.VendorDateFirstSeen.day := fakeDay;
			self.StreetNumber := inrec.Addresses[1].StreetNumber;
			self.StreetPreDirection := inrec.Addresses[1].StreetPreDirection;
			self.StreetName := inrec.Addresses[1].StreetName;
			self.StreetSuffix := inrec.Addresses[1].StreetSuffix;
			self.StreetPostDirection := inrec.Addresses[1].StreetPostDirection;
			self.UnitDesignation := inrec.Addresses[1].UnitDesignation;
			self.UnitNumber := inrec.Addresses[1].UnitNumber;
			self.StreetAddress1 := inrec.Addresses[1].StreetAddress1;
			self.StreetAddress2 := '';
			self.City := fakeCity;
			self.State := fakeState;
			self.Zip5 := fakeZip;
			self.zip4 := '';
			self.County := '';
			self.PostalCode := '';
			self.StateCityZip := Address.Addr2FromComponents(fakeCity, fakeState, fakeZip);
			self.Phones := [];
		end;
		//project results
		results := project(inrec,appendFakeDataExtended(left,getData[1].State,getData[1].City_Name,getData[1].zip));
		return results;
	end;
	
	

	/*--- getAdditionalData appends extra data from doxie.header_records_byDID for ThinTeaserRollup 
				while preserving original ThinTeaser did order: ---*/
	export getAdditionalData(dataset(TeaserSearchServices.Layouts.records) in_rec, 
														boolean AllAddresses, 
														boolean IncludeFullHistory, 
														boolean IncludePhones,
														boolean DtcPhoneAddressTeaserMask,	
														boolean IncludePhoneNumber,
														boolean IncludeAddress,
														boolean IncludeEmailAddress,	
														boolean IncludeEducationInformation,
														string32 application_Type_value) := function
    
    glb_mod := AutoStandardI.GlobalModule();
    mod_access := module(doxie.compliance.GetGlobalDataAccessModuleTranslated (glb_mod))
                   EXPORT string32 application_type := application_Type_value;
                  end;


		/*--- Sequence results to preserve order from tempresults ---*/
		seq_records := record(TeaserSearchServices.Layouts.records)
			unsigned seq;
		end;
		
		seq_records getSequence(in_rec L, integer C) := transform
			self.seq := C;
			self := L;
		end;
		inrec_seq := project(in_rec, getSequence(left, counter));
		
		/*--- Get additional data through doxie.header_records_byDID ---*/
		dids := project(in_rec, transform(doxie.layout_references_hh, self.did := (integer)left.uniqueId));
		additional_data_recs := doxie.header_records_byDID(dids,include_dailies := false, 
																														IncludeAllRecords := true, 
																														GongByDidOnly := true);
																														
		/*--- Format addresses ---*/
		address_rec := record
			doxie.Layout_presentation;
			dataset(iesp.share.t_PhoneInfo) Phones {MAXCOUNT(iesp.Constants.ThinRpsExt.MaxPhones)};
		end;
		
		sorted_address := project(sort(additional_data_recs, did, prim_range, predir, prim_name, suffix, postdir, 
														sec_range, city_name, st, zip,
														-dt_last_seen),
														transform(address_rec, self.Phones := [],
																									 self := left));
																									 
		iesp.share.t_PhoneInfo addPhoneInfo(address_rec L) := transform
			self.Phone10:=l.phone;
     	self.PubNonpub:=l.publish_code;
			self.ListingPhone10:=l.phone;
			self.ListingName:=l.listed_name;
			self.TimeZone:=l.timezone;
			self.ListingTimeZone:='';
		end;
		
		address_rec rollupAddr(address_rec L, address_rec R) := transform
				boolean hasEmptyAddress := L.prim_name = '' and L.prim_range = '';
				self.dt_vendor_last_reported	:= if(R.dt_vendor_last_reported > L.dt_vendor_last_reported or hasEmptyAddress,
																						R.dt_vendor_last_reported,
																						L.dt_vendor_last_reported);
				self.dt_vendor_first_reported := if(R.dt_vendor_first_reported < L.dt_vendor_first_reported and R.dt_vendor_first_reported <> 0 or hasEmptyAddress,
																						R.dt_vendor_first_reported,
																						L.dt_vendor_first_reported);
				self.dt_last_seen := if(R.dt_last_seen > L.dt_last_seen,
																R.dt_last_seen,
																L.dt_last_seen);
				self.prim_range := if(L.prim_range <> '', L.prim_range, R.prim_range);
				self.predir := if(L.predir <> '', L.predir, R.predir);
				self.prim_name := if(L.prim_name <> '', L.prim_name, R.prim_name);
				self.suffix := if(L.suffix <> '', L.suffix, R.suffix);
				self.postdir := if(L.postdir <> '', L.postdir, R.postdir);
				self.sec_range := if(L.sec_range <> '', L.sec_range, R.sec_range);
				self.unit_desig := map(L.sec_range <> '' => L.unit_desig,
															R.sec_range <> '' => R.unit_desig,
															'');
				self.city_name := if(L.city_name <> '', L.city_name, R.city_name);
				self.st := if(L.st <> '', L.st, R.st);
				self.zip := if(L.zip <> '', L.zip, R.zip);
				Phones := L.Phones + project(R, addPhoneInfo(left)); 
				self.Phones := choosen(Phones(Phone10 != ''), iesp.Constants.ThinRpsExt.MaxPhones);
				self := L;
		end;
		
		//rollup addresses and re-sort by dates last seen
		rolled_address := sort(rollup(sorted_address, LEFT.did = RIGHT.did and
																	(LEFT.prim_range = RIGHT.prim_range or LEFT.prim_range = '') and 
																	ut.nneq(LEFT.predir, RIGHT.predir) and
																	(LEFT.prim_name = RIGHT.prim_name or LEFT.prim_name = '') and 
																  ut.nneq(LEFT.suffix, RIGHT.suffix) and
																  ut.nneq(LEFT.postdir, RIGHT.postdir) and
																  ut.nneq(LEFT.sec_range, RIGHT.sec_range) and
																  ut.nneq(LEFT.city_name, RIGHT.city_name) and 
																  ut.nneq(LEFT.st, RIGHT.st) and
																	ut.nneq(LEFT.zip, RIGHT.zip),
																	rollupAddr(left, right)), 
														did, -dt_last_seen, -dt_vendor_last_reported, dt_first_seen);
																	
		//Select addresses based on input options
		addresses := map(AllAddresses => rolled_address, //keep all addresses
										IncludeFullHistory => dedup(rolled_address, did, keep(OLD_MaxCountAddresses)), //keep 5 most recent addresses to match ThinTeaserService (line 84)
										dedup(rolled_address, did)); // keep only most recent address
										
		/*--- Format additional data ---*/
		data_rollup_rec := record
			unsigned did;
			dataset(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchAddress) Addresses {MAXCOUNT(iesp.Constants.ThinRpsExt.MaxAddresses)};
		end;
		
		iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchAddress setAddresses(address_rec L) := transform
			self.StreetAddress1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range);
			self.StreetAddress2 := '';
			self.StreetNumber := L.prim_range;
			self.StreetPreDirection := L.predir;
			self.StreetName := L.prim_name;
			self.StreetSuffix := L.suffix;
			self.StreetPostDirection := L.postdir;
			self.UnitDesignation := L.unit_desig;
			self.UnitNumber := L.sec_range;
			self.City := L.city_name;
			self.State := L.st;
			self.zip5 := L.zip;
			self.zip4 := L.zip4;
			self.County := L.county_name;
			self.PostalCode := '';
			self.StateCityZip := Address.Addr2FromComponents(l.city_name, l.st, l.zip);
			dt_vendor_last_seen := iesp.ECL2ESP.toDateYM((unsigned3)L.dt_vendor_last_reported); 
			dt_last_seen := iesp.ECL2ESP.toDateYM((unsigned3)L.dt_last_seen);
			self.DateLastSeen := dt_last_seen;
			self.VendorDateLastSeen.Year := dt_vendor_last_seen.year;
			self.VendorDateLastSeen.Month := dt_vendor_last_seen.month;
			self.VendorDateLastSeen.Day := dt_vendor_last_seen.day;
			self.VendorDateFirstSeen := [];
			self.Phones := if(IncludePhones OR IncludePhoneNumber, L.phones, dataset([], iesp.share.t_PhoneInfo));		
		end;
		
		data_rollup_rec rollupHeaderRec(data_rollup_rec L, data_rollup_rec R) := transform
			self.did := L.did;
			Address := L.Addresses + R.Addresses;
			self.Addresses := choosen(Address, iesp.Constants.ThinRpsExt.MaxAddresses);
		end;
		//rollup based on did
		rollup_extra_data_rec := rollup(project(addresses, transform(data_rollup_rec, 
																																		self.Addresses := project(left, setAddresses(left)),
																																		self := Left)),
																																		left.did = right.did, 
																		rollupHeaderRec(left, right));
		
		/*--- Join extra data with original ThinTeaser results (in_rec) ---*/
		seq_rollup_rec := record
			unsigned seq;
			iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord;
		end;

		seq_rollup_rec AddExtraData(seq_records L, data_rollup_rec R) := transform
			self.seq := L.seq;
			self.Addresses := choosen(R.Addresses, iesp.Constants.ThinRpsExt.MaxAddresses);
			self := L; //everything else from original TeaserSearch
			self := [];
		end;
		
		recs_w_extra := join(inrec_seq, rollup_extra_data_rec, 
												left.UniqueId = intformat (right.did, 12, 1), 
												AddExtraData(left, right),
												limit(0), keep(1), //1:1 matching 
												left outer); 
		
		/*--- Sort by seq to preserve ThinTeaser original order ---*/
		sort_recs := project(sort(recs_w_extra, seq), TRANSFORM(
						iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
		        SELF := LEFT;						
						));
				        
		 AddressesTmp := PROJECT(sort_recs, 	TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,		                                   
											 MaskedAddresses := PROJECT(CHOOSEN(left.addresses,iesp.Constants.ThinRpsExt.MaxAddresses),
											                       TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchMaskedAddress,
											                  StreetNumOrig := LEFT.StreetNumber;
																				prim_rangeMasked := TeaserSearchServices.Constants.AddrMaskString; 
                                        StreetNum := If (DtcPhoneAddressTeaserMask, prim_rangeMasked, LEFT.streetNumber);											                          
											                  SELF.StreetNumber := StreetNum;
																				// special case to masks streetName if PO BOX only is in the 
																				MaskStreetName := IF ( DtcPhoneAddressTeaserMask AND
																			                       ((STD.Str.Find(LEFT.StreetName, 'PO',1) > 0) AND
																			                       (STD.str.Find(LEFT.StreetName, 'BOX',1) > 0) AND																														 
																			                        StreetNumOrig = '') 
																															OR 
																															(DTCPhoneAddressTeaserMask AND
																															(STD.str.Find(LEFT.StreetName, 'RR ',1) > 0) AND
																															 StreetNumOrig = ''),
																												     TeaserSearchServices.Constants.AddrMaskString,
																												      LEFT.StreetName
																														);
                                         SELF.StreetName := MaskStreetName;			
																				 STRING60 nonmaskedStreetInfo := Trim(LEFT.StreetPreDirection + ' ' + 
																																	MaskStreetName + ' ' +  
																																	LEFT.StreetSuffix + ' ' + 
																																	LEFT.StreetPostDirection + ' ' +
																																	LEFT.UnitDesignation + ' ' +
																																	LEFT.UnitNumber, left, right);
																			   SELF.StreetAddress1 := If (DtcPhoneAddressTeaserMask, prim_rangeMasked + ' ' + nonmaskedStreetInfo, 
																			                      LEFT.StreetNumber + ' ' +
																			                      NonMaskedStreetInfo); 	
                                            
                                         SELF.Phones :=IF (DtcPhoneAddressTeaserMask and IncludePhoneNumber,																					                        																																										
																													 PROJECT(choosen(LEFT.Phones,iesp.Constants.ThinRpsExt.MaxPhones), TRANSFORM(iesp.share.t_StringArrayItem,
 																															tmpPhone10 := TRIM(LEFT.Phone10, LEFT, RIGHT);																																					     
																															SELF.value := if (tmpphone10 <> '', 																																										     																												
																																							'(' + tmpPhone10[1..3] + ') ' + TeaserSearchServices.Constants.phoneMaskString, LEFT.Phone10);																													
																															SELF := [];
																													 )), 																																
																												   dataset([],iesp.share.t_StringArrayItem)
																												 );																																		
                           SELF := LEFT;																														
												));
											 MaskedPhonesOnly := IF (DtcPhoneAddressTeaserMask and IncludePhoneNumber AND (NOT(IncludeAddress)),											                             
											                        PROJECT(MaskedAddresses, TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchMaskedAddress,
																									    SELF.Phones :=  IF (DtcPhoneAddressTeaserMask and IncludePhoneNumber,
																					                                 PROJECT(CHOOSEN(LEFT.Phones, iesp.Constants.ThinRpsExt.MaxPhones), 
																																					           TRANSFORM(iesp.share.t_StringArrayItem,																																					     
                                                                                tmpPhone10 := LEFT.value;																																					     
																																								SELF.value := if (tmpphone10 <> '', 																																										     																												
																																												 '(' + tmpPhone10[1..3] + ') ' + TeaserSearchServices.Constants.phoneMaskString, LEFT.value);																																												 
																																								SELF := [];
																																		            )), 																																		            
																																								dataset([],iesp.share.t_StringArrayItem)
																																		          );																																		
                                                         SELF := []))																																																									
																											);																																																				       
											 SELF.MaskedAddresses := IF (DtcPhoneAddressTeaserMask and IncludeAddress,											                              
																									  MaskedAddresses,
																										IF (DtcPhoneAddressTeaserMask and IncludePhoneNumber AND (NOT(IncludeAddress)),
																										       MaskedPhonesOnly,
																										       dataset([],iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchMaskedAddress)
																							 ));											                               											 											
											 SELF := LEFT;
											 SELF := []));
											      													
	  //Student data routines
    college_name_rec := record
                         unsigned6 DID;
                         string50 LN_COLLEGE_NAME;
                         unsigned4 global_sid;
                         unsigned8 record_sid;
                        end;  
                            
    student_data := join(dedup(sort(AddressesTmp,UniqueID),UniqueID),American_student_list.key_DID,
                          keyed((integer)right.L_DID = (integer)left.UniqueID) and 
                          right.LN_college_name <> '',
                          transform(recordof(college_name_rec), self := right),
                          limit(0), keep(iesp.Constants.ThinRpsExt.MaxCountCollegeAddresses)) ;
                          
    student_data_suppressed := Suppress.MAC_SuppressSource(student_data,mod_access,did);
     
  // now hit the email did key and get back email addressess and mask them.			
	// did suppression already done.
     sort_recs_WithEmail := PROJECT(AddressesTmp,
			                         TRANSFORM(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
															    didValDS := DATASET([{(UNSIGNED6) LEFT.uniqueID}],
																	                   doxie.layout_references);
															 UNSIGNED6 didVal := (UNSIGNED6) LEFT.UniqueID;											 
															 SELF.MaskedEmailAddresses := 
															      IF (DtcPhoneAddressTeaserMask and IncludeEmailAddress,
															             JOIN(didValDS,Email_Data.Key_Did,
																	           LEFT.did = RIGHT.did,
																						 TRANSFORM( iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchEmail,
																							  tmpEmail := TRIM(RIGHT.clean_email,LEFT,RIGHT);
																								// code to mask email here
																								len := LENGTH(tmpemail);
																								AtSignPos := std.str.find(tmpEmail,TeaserSearchServices.Constants.Atsign);
																								MaskItAll := NOT(AtSignPos > 0);
																								PositionOfLastDot := len - 3; // as in 3 from end 'abc@yahoo.com
																								maskString := '*******************************************'; // 																												
																								MaskedEmail := tmpEmail[1] +
																													    maskString[1..AtSignPos-2] + 
																														 TeaserSearchServices.Constants.AtSign + 
																														 maskstring[1..positionOfLastDot-AtSignPos-1] +
																														 tmpEmail[len-3..len];
																													//  ^^ 2 here is 1 past 1st char and 1 less than where @ sign is
																																																																																																																				
																							  SELF.MaskedEmailAddress := MaskedEmail;
																									),LIMIT(0), KEEP(iesp.Constants.ThinRpsExt.MaxEmailAddresses) 
																									//  ^^^^^ no choosen needed cause of this keep
																							),
																						DATASET([], IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchEmail)
																					);																					
                               college_name := TRIM(student_data_suppressed(did = DIDval)[1].ln_college_name,LEFT,RIGHT);
                               SELF.CollegeAddresses := CHOOSEN(
															                           IF (IncludeEducationInformation,
																												    PROJECT(
																												     PROJECT(American_student_list.key_Address_List(keyed(LN_COLLEGE_NAME = college_name)),
																														         TRANSFORM(LEFT)),                                                            											 
																															TRANSFORM(IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchCollegeAddress,																							 
																																SELF.city  := LEFT.v_city_name;
																																SELF.state := LEFT.st)),																													 
																														DATASET([], IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchCollegeAddress)
																												 ),
																											 iesp.Constants.ThinRpsExt.MaxCountCollegeAddresses
																											 );                              		
																	 SELF := LEFT;																														
                              )); 																		 
		// output(sort_recs, named('sort_recs'));	
		// output(addressesTmp, named('AddressesTmp'));	 			 
		 // output(sort_recs_WithEmail, named('sort_recs_WithEmail'));
   
    
		RETURN sort_recs_WithEmail;
	end;
	export getCounts(dataset(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord) inrecs,
							integer IncludeCounts,
							string32 application_Type_value) := FUNCTION
									 
   dsLookups := JOIN(inrecs, doxie.key_D2C_lookup(),
              (unsigned6) LEFT.UNIQUEID =  RIGHT.DID,							   							  					  
								 TRANSFORM(recordOf(right),
								 self := RIGHT;
								 ),limit(0), keep(1)
								 );		
								 
   dsLookupsIndexed := NORMALIZE(dsLookups,count(TeaserSearchServices.Constants.Category),
                            TRANSFORM({unsigned6 didValue;
														 iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedPersonCount; 
														 integer categoryIndex},
														   self.Didvalue := LEFT.did;
														   self.Category := TeaserSearchServices.Constants.Category[counter].categoryString;																				 
													     self.Count  := choose(Counter
													                   ,LEFT.Addresses_cnt
															          ,LEFT.PhonesPlus_cnt
															          ,LEFT.Email_cnt
																	,LEFT.Education_Student_cnt
																	,LEFT.Possible_Relatives_and_Associates_cnt
																	,LEFT.Possible_Properties_owned_cnt
																      ,LEFT.Criminal_Records_cnt
																	,LEFT.Sexual_Offenses_cnt
																	,LEFT.Liens_and_Judgements_cnt
																	,LEFT.Bankruptcies_cnt
																	,LEFT.Marriage_and_Divorce_cnt
																	,LEFT.Professional_Licenses_cnt
																	,LEFT.People_at_Work_possible_employment_records_cnt
																	,LEFT.Businesses_records_cnt
																	,LEFT.Corporate_affiliations_cnt
																	,LEFT.UCC_cnt
																	,LEFT.Hunting_and_Fishing_Permits_cnt
																	,LEFT.Concealed_Weapon_Permits_cnt
																	,LEFT.Firearms_and_Explosives_cnt
																	,LEFT.FAA_Aircraft_cnt
																	,LEFT.FAA_Pilot_cnt 
																);																											
															self.categoryIndex := counter;
															self.exists := '';
														 ));
													 														 																		
  outrecs := project(inRecs, 
           transform(iesp.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedSearchRecord,
					 uniqueID := left.UniqueID;
			     self.uniqueID := left.UniqueId;
      			                             																												   
										CountSet := dsLookupsIndexed(didvalue = (unsigned6) UniqueID);
										self.personCounts := choosen( 
										   if (IncludeCounts > 1,
										     project(countSet,                                       											 
													 TRANSFORM(IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedPersonCount,																							 													  
														 SELF.category  := Countset(categoryIndex = counter)[1].Category;
														 SELF.count := if (includeCounts = 3, countset(categoryIndex = counter)[1].Count, 0);
														 self.exists := if (includeCounts = 2 and countset(categoryIndex = counter)[1].Count > 0, 'Y','');
													)),												  
													dataset([], IESP.thinrolluppersonextendedsearch.t_ThinRollupPersonExtendedPersonCount)
											)
										, iesp.Constants.ThinRpsExt.MaxCountPersonCounts); // MAXCOUNT FOR CHOOSEN
										self := Left;
										));								   									 									 
                 // output(inrecs, named('inRecs'));		
			 // output(dsLookups, named('dsLookups'));												 
			 // output(dsLookupsIndexed, named('dsLookupsIndexed'));		       												 
                // output(outrecs, named('outrecs'));
			 RETURN(outrecs);														
    end;														
	
end;