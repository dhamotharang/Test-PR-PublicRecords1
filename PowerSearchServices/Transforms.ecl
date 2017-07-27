IMPORT iesp,Address;

EXPORT Transforms := MODULE

	EXPORT Layouts.answerRec clnPropAddr(Layouts.answerRec L) := TRANSFORM
		BOOLEAN isPropRec := TRIM(L.source_doc_type)='LNPropV2' AND TRIM(L.address.line1) != '';
		a := address.GetCleanAddress(L.address.line1,L.address.csz,address.Components.Country.US).str_addr;
		clnAddr := Address.CleanFields(a);
		SELF.address.prim_range := IF(isPropRec,clnAddr.prim_range,L.address.prim_range);
		SELF.address.predir := IF(isPropRec,clnAddr.predir,L.address.predir);
		SELF.address.prim_name := IF(isPropRec,clnAddr.prim_name,L.address.prim_name);
		SELF.address.addr_suffix := IF(isPropRec,clnAddr.addr_suffix,L.address.addr_suffix);
		SELF.address.postdir := IF(isPropRec,clnAddr.postdir,L.address.postdir);
		SELF.address.unit_desig := IF(isPropRec,clnAddr.unit_desig,L.address.unit_desig);
		SELF.address.sec_range := IF(isPropRec,clnAddr.sec_range,L.address.sec_range);
		SELF.address.city_name := IF(isPropRec,clnAddr.p_city_name,L.address.city_name);
		SELF.address.st:= IF(isPropRec,clnAddr.st,L.address.st);
		SELF.address.zip5 := IF(isPropRec,clnAddr.zip,L.address.zip5);
		SELF.address.zip4 := IF(isPropRec,clnAddr.zip4,L.address.zip4);
		SELF := L;
	END;

	EXPORT Layouts.answerRec assignAnswers(Layouts.answerRec L,INTEGER C) := TRANSFORM
		SELF.key := 0;
		SELF.seq := C;
		N := L.name;
		A := L.address;
		SELF.source := stringLib.stringToUpperCase(TRIM(L.company_name)+' '+TRIM(N.fname)+' '
			+TRIM(N.mname)+' '+TRIM(N.lname)+' '+TRIM(N.name_suffix)+' '+TRIM(N.full_name)+' '
			+TRIM(A.prim_range)+' '+TRIM(A.predir)+' '+TRIM(A.prim_name)+' '+TRIM(A.addr_suffix)+' '
			+TRIM(A.postdir)+' '+TRIM(A.unit_desig)+' '+TRIM(A.sec_range)+' '+TRIM(A.city_name)+' '
			+TRIM(A.st)+' '+TRIM(A.zip5)+' '+TRIM(A.zip4)+' '+TRIM(A.line1)+' '+TRIM(A.csz)+' '
			+TRIM(L.phone)+' '+TRIM(L.ssn)+' '+TRIM(L.fein)+' '+TRIM(L.dob));
		SELF := L;
		SELF := [];
	END;

	EXPORT Layouts.answerRec scoreAnswers(Layouts.answerRec L, Layouts.scoreRec R) := TRANSFORM
		SELF.argScore := IF(stringLib.stringFind(L.source,TRIM(R.searchArg),1)>0,R.score,0);
		SELF := L;
	END;

	EXPORT Layouts.answerRec rollupAnswers(Layouts.answerRec L, Layouts.answerRec R) := TRANSFORM
		SELF.argScore := L.argScore + R.argScore;
		SELF := L;
	END;

	EXPORT iesp.powersearch.t_PowerSearchRecord pwrSrchRec(Layouts.answerRec L) := TRANSFORM
		SELF.DOB := iesp.ECL2ESP.toDate((UNSIGNED)L.dob);
		SELF.DOD := iesp.ECL2ESP.toDate((UNSIGNED)L.dod);
		self.deceased := L.deceased;
		SELF.UniqueId := INTFORMAT(L.did,12,1);
		SELF.BusinessId := INTFORMAT(L.bdid,12,1);
		SELF.BusinessIDs.ProxID := l.proxid,
		SELF.businessIDs.UltID := l.ultid,
		SELF.businessIDs.OrgID := l.orgid,
		SELF.businessIDs.SeleID := l.seleid,
		SELF.businessIDs.DotID := l.dotid,
		SELF.BusinessIDs.EmpID := l.empid,
		SELF.BusinessIDs.PowID := l.powid,
		SELF.IdValue := '',
		UNSIGNED2 LEN := LENGTH(TRIM(L.dt_last_seen));
		UNSIGNED4 DTE := (UNSIGNED)L.dt_last_seen;
		SELF.LastSeen := MAP(LEN=8 =>	iesp.ECL2ESP.toDate(DTE),
			LEN=6 => iesp.ECL2ESP.toDateYM(DTE),
			ROW({0,0,0},iesp.share.t_Date));
		SELF.SourceDocType := L.source_doc_type;
		SELF.RecordId := L.record_id;
		SELF.CompanyName := L.company_name;
		N := L.name;
		A := L.address;
		SELF.Name := iesp.ECL2ESP.SetName (N.fname,N.mname,N.lname,N.name_suffix,'',N.full_name);
		SELF.Address := iesp.ECL2ESP.SetAddress(A.prim_name,A.prim_range,A.predir,A.postdir,
											A.addr_suffix,A.unit_desig,A.sec_range,A.city_name,
											A.st,A.zip5,A.zip4,'',
											'', A.line1, '', if (A.prim_name = '', A.csz, '')); //prefer parsed components on a web-side
		SELF.Phone10 := L.phone;
		SELF.SSN := L.ssn;
		SELF.FEIN := L.fein;
	END;

END;