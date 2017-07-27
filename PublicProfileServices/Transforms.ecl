IMPORT iesp,doxie,MDR;

EXPORT Transforms := MODULE

	EXPORT Layouts.srchRecord initSrch(BOOLEAN validSrch,SET OF STRING srchBy,IParam.searchParams rptByMod) := TRANSFORM
		SELF.validSrch := validSrch;
		SELF.srchBy := srchBy;
		BOOLEAN useName := Constants.NAME IN srchBy;
		SELF.FirstName := IF(useName,rptByMod.FirstName,'');
		SELF.MiddleName := IF(useName,rptByMod.MiddleName,'');
		SELF.Lastname := IF(useName,rptByMod.Lastname,'');
		SELF.SSN := IF(Constants.SSN IN srchBy,rptByMod.SSN,'');
		SELF.DOB := IF(Constants.DOB IN srchBy,rptByMod.DOB,0);
		BOOLEAN useAddr := Constants.ADDR IN srchBy;
		SELF.Addr := IF(useAddr,rptByMod.Addr,'');
		SELF.City :=IF(useAddr,rptByMod.City,'');
		SELF.State := IF(useAddr,rptByMod.State,'');
		SELF.Zip :=IF(useAddr,rptByMod.Zip,'');
	END;

	EXPORT Layouts.hdrDidRecord getDids(Layouts.srchRecord L,INTEGER C) := TRANSFORM
		rptByMod := MODULE(IParam.searchParams)
			EXPORT STRING30  FirstName  := L.FirstName;
			EXPORT STRING30  MiddleName := L.MiddleName;
			EXPORT STRING30  LastName   := L.LastName;
			EXPORT STRING11  SSN := L.SSN;
			EXPORT UNSIGNED8 DOB := L.DOB;
			EXPORT STRING200 Addr  := L.Addr;
			EXPORT STRING25  City  := L.City;
			EXPORT STRING2   State := L.State;
			EXPORT STRING6   Zip   := L.Zip;
		END;	
		hdrDids := IF(L.validSrch,Functions.FetchI_Hdr_Indv_do_hhid(rptByMod));
		SELF.seq := C;
		SELF.didRecs := CHOOSEN(PROJECT(hdrDids,TRANSFORM(Layouts.didRecord,SELF.seq:=C,SELF.srchBy:=L.srchBy,SELF:=LEFT)),Constants.MAX_DIDS);
	END;

	SHARED iesp.public_profile_report.t_PublicProileBirthInfo setDOB(doxie.Layout_Rollup.DOBRec L) := TRANSFORM
		SELF.DOB := iesp.ECL2ESP.toDate(L.DOB)
	END;

	SHARED iesp.public_profile_report.t_PublicProileDeathInfo setDOD(doxie.Layout_Rollup.DODRec L) := TRANSFORM
		SELF.DOD := iesp.ECL2ESP.toDate(L.DOD);
		SELF.Deceased := 'Y';
		SELF.AgeAtDeath := L.dead_age;
	END;

	SHARED iesp.share.t_SSNInfo setSSN(doxie.Layout_Rollup.SSNRec L) := TRANSFORM
		SELF.SSN := L.ssn;
		SELF.Valid := L.valid_ssn;
		SELF.IssuedLocation := L.ssn_issue_place;
		SELF.IssuedStartDate := iesp.ECL2ESP.toDateYM(L.ssn_issue_early);
		SELF.IssuedEndDate := iesp.ECL2ESP.toDateYM(L.ssn_issue_last);
	END;

	SHARED iesp.share.t_Name setName(doxie.Layout_Rollup.NameRec L) := TRANSFORM
		SELF.First := L.fname;
		SELF.Middle := L.mname;
		SELF.Last := L.lname;
		SELF.Suffix := L.name_suffix;
		SELF.Prefix := L.title;
		SELF.Full := '';
	END;

	SHARED iesp.public_profile_report.t_PublicProfileAddress setAddress(doxie.Layout_Rollup.AddrRec L) := TRANSFORM
		SELF.StreetNumber := L.prim_range;
		SELF.StreetPreDirection := L.predir;
		SELF.StreetName := L.prim_name;
		SELF.StreetPostDirection := L.postdir;
		SELF.StreetSuffix := L.suffix;
		SELF.UnitDesignation := L.unit_desig;
		SELF.UnitNumber := L.sec_range;
		SELF.City := L.city_name;
		SELF.State := L.st;
		SELF.Zip5 := L.zip;
		SELF.Zip4 := L.zip4;
		SELF.County := L.county_name;
		SELF.FirstSeen := iesp.ECL2ESP.toDateYM(L.first_seen);
		SELF.LastSeen := iesp.ECL2ESP.toDateYM(L.last_seen);
		SELF := [];
	END;
	
	SHARED iesp.public_profile_report.t_PublicProfileSource setSrc(doxie.Layout_Rollup.RidRec L) := TRANSFORM
		SELF.Name := MDR.sourceTools.TranslateSourceExternal(L.src);
	END;

	SHARED doxie.Layout_Rollup.RidRec rollSrc(doxie.Layout_Rollup.RidRec L,doxie.Layout_Rollup.RidRec R) := TRANSFORM
		SELF.rid := '';
		SELF.src := L.src;
	END;

	EXPORT iesp.public_profile_report.t_CombinationSubject SetSubject(Layouts.hdrRollupRecord L,STRING KEY='') := TRANSFORM
		SELF.UniqueId := (STRING)L.did;
		SELF.FirstSeen := iesp.ECL2ESP.toDateYM(MIN(L.addrRecs(first_seen>0),first_seen));
		SELF.LastSeen := iesp.ECL2ESP.toDateYM(MAX(L.addrRecs(last_seen>0),last_seen));
		SELF.SSNCount := L.SSNCount; 
		SELF.DOBCount := L.DOBCount; 
		Sources := PROJECT(ROLLUP(SORT(L.rids,src),LEFT.src=RIGHT.src,rollSrc(LEFT,RIGHT)),setSrc(LEFT)); 
		SELF.Sources := DEDUP(SORT(Sources,Name),Name); 
		SELF.SourceCount := COUNT(SELF.Sources); 
		SELF.KEY := KEY;
		SELF.SSNInformation := PROJECT(L.SSNRecs,setSSN(LEFT));
		SELF.DeathInformation := PROJECT(L.DODRecs,setDOD(LEFT));
		SELF.BirthInformation := PROJECT(L.DOBRecs,setDOB(LEFT));
		SELF.Names := PROJECT(L.nameRecs,setName(LEFT));
		SELF.Addresses := PROJECT(L.addrRecs,setAddress(LEFT));
	END;

	EXPORT iesp.public_profile_report.t_CombinationResults setCombinationResults(DATASET(iesp.public_profile_report.t_CombinationSubject) Subjects) := TRANSFORM
		SELF.FirstSeen := iesp.ECL2ESP.toDate((INTEGER)MIN(Subjects,iesp.ECL2ESP.t_DateToString8(FirstSeen)));
		SELF.LastSeen := iesp.ECL2ESP.toDate((INTEGER)MAX(Subjects,iesp.ECL2ESP.t_DateToString8(LastSeen)));
		SELF.SubjectCount := COUNT(Subjects);
		nrmSrc := NORMALIZE(Subjects,LEFT.Sources,TRANSFORM(iesp.public_profile_report.t_PublicProfileSource,SELF:=RIGHT));
		SELF.SourceCount := COUNT(DEDUP(SORT(nrmSrc,Name),Name));
		SELF.Subjects := Subjects;
	END;

	EXPORT iesp.public_profile_report.t_NameSSNResults setNameSSNResults(DATASET(iesp.public_profile_report.t_CombinationSubject) Subjects) := TRANSFORM
		SELF.FirstSeen := iesp.ECL2ESP.toDate((INTEGER)MIN(Subjects,iesp.ECL2ESP.t_DateToString8(FirstSeen)));
		SELF.LastSeen := iesp.ECL2ESP.toDate((INTEGER)MAX(Subjects,iesp.ECL2ESP.t_DateToString8(LastSeen)));
		SELF.SubjectCount := COUNT(Subjects);
		nrmSrc := NORMALIZE(Subjects,LEFT.Sources,TRANSFORM(iesp.public_profile_report.t_PublicProfileSource,SELF:=RIGHT));
		SELF.SourceCount := COUNT(DEDUP(SORT(nrmSrc,Name),Name));
		SELF.Subjects := PROJECT(Subjects,iesp.public_profile_report.t_NameSSNSubject);
	END;

	EXPORT iesp.public_profile_report.t_NameAddressResults setNameAddrResults(DATASET(iesp.public_profile_report.t_CombinationSubject) Subjects) := TRANSFORM
		SELF.FirstSeen := iesp.ECL2ESP.toDate((INTEGER)MIN(Subjects,iesp.ECL2ESP.t_DateToString8(FirstSeen)));
		SELF.LastSeen := iesp.ECL2ESP.toDate((INTEGER)MAX(Subjects,iesp.ECL2ESP.t_DateToString8(LastSeen)));
		SELF.SubjectCount := COUNT(Subjects);
		nrmSrc := NORMALIZE(Subjects,LEFT.Sources,TRANSFORM(iesp.public_profile_report.t_PublicProfileSource,SELF:=RIGHT));
		SELF.SourceCount := COUNT(DEDUP(SORT(nrmSrc,Name),Name));
		SELF.Subjects := PROJECT(Subjects,iesp.public_profile_report.t_NameAddressSubject);
	END;

	EXPORT iesp.public_profile_report.t_NameDOBResults setNameDOBResults(DATASET(iesp.public_profile_report.t_CombinationSubject) Subjects) := TRANSFORM
		SELF.FirstSeen := iesp.ECL2ESP.toDate((INTEGER)MIN(Subjects,iesp.ECL2ESP.t_DateToString8(FirstSeen)));
		SELF.LastSeen := iesp.ECL2ESP.toDate((INTEGER)MAX(Subjects,iesp.ECL2ESP.t_DateToString8(LastSeen)));
		SELF.SubjectCount := COUNT(Subjects);
		nrmSrc := NORMALIZE(Subjects,LEFT.Sources,TRANSFORM(iesp.public_profile_report.t_PublicProfileSource,SELF:=RIGHT));
		SELF.SourceCount := COUNT(DEDUP(SORT(nrmSrc,Name),Name));
		SELF.Subjects := PROJECT(Subjects,iesp.public_profile_report.t_NameDOBSubject);
	END;

	EXPORT iesp.public_profile_report.t_AddressResults setAddrResults(DATASET(iesp.public_profile_report.t_CombinationSubject) Subjects) := TRANSFORM
		SELF.FirstSeen := iesp.ECL2ESP.toDate((INTEGER)MIN(Subjects,iesp.ECL2ESP.t_DateToString8(FirstSeen)));
		SELF.LastSeen := iesp.ECL2ESP.toDate((INTEGER)MAX(Subjects,iesp.ECL2ESP.t_DateToString8(LastSeen)));
		SELF.SubjectCount := COUNT(Subjects);
		nrmSrc := NORMALIZE(Subjects,LEFT.Sources,TRANSFORM(iesp.public_profile_report.t_PublicProfileSource,SELF:=RIGHT));
		SELF.SourceCount := COUNT(DEDUP(SORT(nrmSrc,Name),Name));
		SELF.Subjects := PROJECT(Subjects,iesp.public_profile_report.t_AddressSubject);
	END;

	EXPORT iesp.public_profile_report.t_SSNResults setSSNResults(DATASET(iesp.public_profile_report.t_CombinationSubject) Subjects) := TRANSFORM
		SELF.FirstSeen := iesp.ECL2ESP.toDate((INTEGER)MIN(Subjects,iesp.ECL2ESP.t_DateToString8(FirstSeen)));
		SELF.LastSeen := iesp.ECL2ESP.toDate((INTEGER)MAX(Subjects,iesp.ECL2ESP.t_DateToString8(LastSeen)));
		SELF.SubjectCount := COUNT(Subjects);
		nrmSrc := NORMALIZE(Subjects,LEFT.Sources,TRANSFORM(iesp.public_profile_report.t_PublicProfileSource,SELF:=RIGHT));
		SELF.SourceCount := COUNT(DEDUP(SORT(nrmSrc,Name),Name));
		SELF.Subjects := PROJECT(Subjects,iesp.public_profile_report.t_SSNSubject);
	END;

END;