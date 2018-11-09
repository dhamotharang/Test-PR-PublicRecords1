import Std, HEADER, BankruptcyV2, hygenics_crim, LiensV2, Civil_court, D2C;

/**

Compute the following indicator flags based on input data

  Deceased (join by LexID, “Y” if you got a hit)
  Judgments & Liens (join by LexID, “Y” if you got a hit)
  Civil Court Records (no LexID on the data, “1” if you get a match on Name+City+State, “2” if you get a match on Name+State, “3” if you get a match on Name.  Waterfall into these match criteria.)
  Criminal Court Records (join by LexID, )
  Possible Incarceration (join by LexID)
  Foreclosure (only when commercially available) (not in scope at the moment)
  Bankruptcy (join by LexID, “Y” if you got a hit)
	
	Filter out non direct-to-consumer sources where necessary


**/





fn_getBankruptcy(dataset(Infutor.rIndicatorFlags) srcin) := FUNCTION
		rBankruptcy := RECORD
		 UNSIGNED6 LexId;
		END;
	
		bk := DEDUP(SORT(DISTRIBUTE(PROJECT(BankruptcyV2.file_bankruptcy_search_v3_supp_bip(did<>'000000000000',name_type[1]='D'), TRANSFORM(rBankruptcy,
							self.LexId := (unsigned6)left.did;)), LexId), LexId, LOCAL), LexId, LOCAL);
							
		result := JOIN(srcin, bk, left.LexId=right.LexId, TRANSFORM(Infutor.rIndicatorFlags,
							self.bankruptcy := IF(right.LexId<>0, 'Y', '');
							self := left;
							), LEFT OUTER, LOCAL);
							
		return result;
END;

fn_getCrimCourt(dataset(Infutor.rIndicatorFlags) srcin) := FUNCTION
		rCrimCourt := RECORD
		 UNSIGNED6 	LexId;
		 string1		curr_incar_flag ;
		END;
	
		crim := DEDUP(SORT(
						DISTRIBUTE(PROJECT(hygenics_crim.File_Moxie_Crim_Offender2_Dev(did<>'000000000000',
																	vendor NOT IN d2c.Constants.DOCRestrictedVendors, 
																	record_type not in d2c.Constants.DOCRestrictedDataTypes),
							TRANSFORM(rCrimCourt,
								self.LexId := (unsigned6)left.did;
								self.curr_incar_flag  := left.curr_incar_flag;
							)), LexId), LexId, -curr_incar_flag, LOCAL), LexId, LOCAL);
							
		result := JOIN(srcin, crim, left.LexId=right.LexId, TRANSFORM(Infutor.rIndicatorFlags,
							self.crimCourtRecords := IF(right.LexId<>0, 'Y', '');
							self.curr_incar_flag := IF(right.curr_incar_flag='Y', 'Y', '');
							self := left;
							), LEFT OUTER, LOCAL);
							
		return result;
END;

fn_getLiens(dataset(Infutor.rIndicatorFlags) srcin) := FUNCTION
		rLiens := RECORD
		 UNSIGNED6 	LexId;
		END;
	
		liens1 := DISTRIBUTE(PROJECT(LiensV2.file_liens_party(did<>'000000000000', name_type[1] in ['C','D'],
										NOT d2c.Constants.LiensRestrictedSources(tmsid)),
								TRANSFORM(rLiens,
									self.LexId := (unsigned6)left.did;
								)), LexId);
							
		liens := DEDUP(SORT(liens1, LexId, LOCAL), LexId, LOCAL);
							
		result := JOIN(srcin, liens, left.LexId=right.LexId, TRANSFORM(Infutor.rIndicatorFlags,
							self.judgments := IF(right.LexId<>0, 'Y', '');
							self := left;
							), LEFT OUTER, LOCAL);
							
		return result;
END;

		civilCourtRecords := Civil_court.file_in_civil_court_party(vendor not in D2C.Constants.CivilCourtRestrictedSources);

rCivilCourt := RECORD
	string80	name;
	string2		st;
	string25	city;
END;

makename(string fname, string mname, string lname, string sfx) :=
			Std.Str.CleanSpaces(fname+' '+mname+' '+lname+' '+sfx);

cv := DEDUP(SORT(DISTRIBUTE(
				PROJECT(civilCourtRecords, TRANSFORM(rCivilCourt,
				self.name := makename(left.e1_fname1,left.e1_mname1,left.e1_lname1,left.e1_suffix1);
				self.st := left.st1;
				self.city := left.p_city_name1;
				))(name<>''), HASH32(name)), name, st, city, LOCAL), name, st, city, LOCAL);
				
fn_getCivil(dataset(Infutor.rIndicatorFlags) srcin1) := FUNCTION
		rCivilCourt := RECORD
		 UNSIGNED6 	LexId;
		END;
	
		srcin := DISTRIBUTE(srcin1, hash32(name));
		records := DISTRIBUTE(cv, hash32(name));
		// match name, state, city
		resNSC := JOIN(srcin, records(st<>'',city<>''),
								left.name=right.name AND left.st=right.st AND left.city=right.city,
								TRANSFORM(Infutor.rIndicatorFlags,
									self.civilCourtRecords := IF(right.name='','','1');
									self := left;), LEFT OUTER, KEEP(1), LOCAL);
		resNS  := JOIN(resNSC(civilCourtRecords=''), records(st<>''),
								left.name=right.name AND left.st=right.st,
								TRANSFORM(Infutor.rIndicatorFlags,
									self.civilCourtRecords := IF(right.name='','','2');
									self := left;), LEFT OUTER, KEEP(1), LOCAL);
		resN  := JOIN(resNS(civilCourtRecords=''), records,
								left.name=right.name,
								TRANSFORM(Infutor.rIndicatorFlags,
									self.civilCourtRecords := IF(right.name='','','3');
									self := left;), LEFT OUTER, KEEP(1), LOCAL);
							
		result := resNSC(civilCourtRecords='1') + resNS(civilCourtRecords='2') + resN;
		return result;
END;


fn_getDeceased(dataset(Infutor.rIndicatorFlags) srcin) := FUNCTION
		rDeceased:=RECORD
		 UNSIGNED6 LexId;
		 STRING8 	dod8;
		END;

		dHeaderFormatted := PROJECT(HEADER.File_DID_Death_MasterV3((unsigned6)did<>0, src not in d2c.Constants.DeathRestrictedSources),
					TRANSFORM(rDeceased,
							SELF.LexId := (UNSIGNED6)LEFT.did; 
							self.dod8 := left.dod8;));
						//SELF.dod8:=IF(TRIM(LEFT.dod8)='','UNKNOWN',LEFT.dod8);));
		dsDeceased := DEDUP(SORT(DISTRIBUTE(dHeaderFormatted, LexId),LexId,-dod8,LOCAL), LexId, LOCAL);

		// get deceased
		result := JOIN(srcin, dsDeceased, left.LexId=right.LexId, TRANSFORM(Infutor.rIndicatorFlags,
							self.deceasedFlag := IF(right.dod8='', '', 'Y');
							self := left;
							), LEFT OUTER, LOCAL);
							
		return result;
END;

EXPORT AddIndicatorFlags(dataset(Infutor.rIndicatorFlags) srcin) := FUNCTION

	withDeceased := fn_getDeceased(srcin);
	withBankruptcy := fn_getBankruptcy(withDeceased);
	withCrims := fn_getCrimCourt(withBankruptcy);
	withLiens := fn_getLiens(withCrims);
	withCivilCourt := fn_getCivil(withLiens);
	
	return withCivilCourt;

END;
