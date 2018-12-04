IMPORT InsuranceHeader_Salt_T46,IDL_Header,InsuranceHeader_PreProcess,suppress,STD;

EXPORT proc_Slender(STRING version) := MODULE
 
   	SHARED layout := InsuranceHeader_Salt_T46.Layout_Header;
   
   	SHARED hdr := IDL_Header.files.DS_SALT_ITER_OUTPUT;
   
   	SHARED inDS := InsuranceHeader_Salt_T46.file_chunky;
   
   	ssns := DEDUP(SORT(DISTRIBUTE(PROJECT(inDS(ssn <> '' AND ssn[..5] <> '00000'),TRANSFORM({string9 ssn,boolean hardForce,boolean fnameSwitch,boolean mnameSwitch,boolean lnameSwitch,boolean snameSwitch},SELF := LEFT)),HASH(ssn)),ssn,LOCAL),ssn,LOCAL);
   	didSSN := JOIN(DISTRIBUTE(hdr(ssn <> ''),HASH(ssn)),ssns,LEFT.ssn = RIGHT.ssn,TRANSFORM({unsigned8 did,recordof(right)},SELF := LEFT,SELF := RIGHT),LOCAL);
   
	 /*Candidate dids*/
	 
   	SHARED ods := ROLLUP(SORT(DISTRIBUTE(didSSN,did),did,LOCAL),TRANSFORM(recordof(left),self.hardForce := IF(left.hardForce OR right.hardForce,TRUE,FALSE), self.fnameSwitch := IF(left.fnameSwitch OR right.fnameSwitch,TRUE,FALSE), self.mnameSwitch := IF(left.mnameSwitch OR right.mnameSwitch,TRUE,FALSE), self.lnameSwitch := IF(left.lnameSwitch OR right.lnameSwitch,TRUE,FALSE), self.snameSwitch := IF(left.snameSwitch OR right.snameSwitch,TRUE,FALSE),self := left),did,LOCAL);
   	 	
   	SHARED layout2 := RECORD
   		layout;
   		boolean fnameswitch;
			boolean mnameswitch;
   		boolean lnameswitch;
			boolean snameswitch;
   	END;
   
		OUTPUT(COUNT(ods),named('candidateDids'));
		
   	infilePre := JOIN(DISTRIBUTE(hdr(TRIM(STD.str.filterout(ssn,'0'),ALL) <> '' OR dob <> 0 OR fname <> '' OR mname <> '' OR lname <> '' OR sname <> ''),did),ods,LEFT.did = RIGHT.did,TRANSFORM(layout2,SELF := LEFT, SELF := RIGHT),LOCAL);
   
   	tab := TABLE(infilePre,{infilePre.did,unsigned cnt := COUNT(GROUP)},did,LOCAL);
   	infile := JOIN(infilePre,tab(cnt > 9999),LEFT.did = RIGHT.did,TRANSFORM(LEFT),LOCAL,LEFT ONLY):PERSIST('temp::insuranceHeader::DID::slender_candidates', EXPIRE(30));
   
   	ssnFilt := DEDUP(SORT(infile(TRIM(STD.str.filterout(ssn,'0'),ALL) <> ''),did,ssn,LOCAL),LEFT.did=RIGHT.did AND LEFT.ssn=RIGHT.ssn,LOCAL);
		ssnTab := TABLE(ssnFilt,{ssnFilt.did;unsigned cnt:= COUNT(GROUP)},did,skew(1.0));
   	dobDed := DEDUP(SORT(infile(dob <> 0),did,dob,LOCAL),LEFT.did=RIGHT.did AND (LEFT.dob=RIGHT.dob OR (((STRING)LEFT.dob)[..6] = ((STRING)RIGHT.dob)[..6] AND(((STRING)LEFT.dob)[7..] IN ['00','01'] OR ((STRING)RIGHT.dob)[7..] IN ['00','01']))),LOCAL);
   	dobTab := TABLE(dobDed,{dobDed.did;unsigned cnt:= COUNT(GROUP)},did,skew(1.0));	
		hardForceDids := TABLE(ods(hardForce),{ods.did}); //hardForce = TRUE always applied
   	targets := DEDUP(SORT(DISTRIBUTE(TABLE(ssnTab(cnt > 1),{ssnTab.did}) + TABLE(dobTab(cnt > 1),{dobTab.did}) + hardForceDids,did),did,LOCAL),did,LOCAL);
		SHARED	infile2 := JOIN(infile,targets,LEFT.did=RIGHT.did,TRANSFORM(recordof(LEFT),SELF := LEFT),LOCAL);
   
   	layout2 splitEm(layout2 L, layout2 R) := TRANSFORM
   		dobsL := (STRING)L.dob;
   		dobsR := (STRING)R.dob;
   		isSame := IF(L.ssn = R.ssn AND L.dob = R.dob AND IF(R.fnameSwitch,L.fname = R.fname,TRUE) AND IF(R.mnameSwitch,L.mname = R.mname,TRUE) AND IF(R.lnameSwitch,L.lname = R.lname,TRUE) AND IF(R.snameSwitch,L.sname = R.sname,TRUE),TRUE,FALSE);
   		SELF.did := IF(isSame AND L.did > 0, L.did,R.rid);
   		SELF := R;
   	END;
   
   	splitPreF := SORT(DISTRIBUTE(infile2(fnameSwitch AND not (lnameSwitch or mnameSwitch or snameSwitch)),did),did,ssn,dob,fname,rid,LOCAL);
   	splitPreM := SORT(DISTRIBUTE(infile2(mnameSwitch AND not (fnameSwitch or lnameSwitch or snameSwitch)),did),did,ssn,dob,mname,rid,LOCAL);
   	splitPreL := SORT(DISTRIBUTE(infile2(lnameSwitch AND not (fnameSwitch or mnameSwitch or snameSwitch)),did),did,ssn,dob,lname,rid,LOCAL);
   	splitPreS := SORT(DISTRIBUTE(infile2(snameSwitch AND not (fnameSwitch or lnameSwitch or mnameSwitch)),did),did,ssn,dob,sname,rid,LOCAL);
   	splitPreFM := SORT(DISTRIBUTE(infile2(fnameSwitch AND mnameSwitch AND not (lnameSwitch or snameSwitch)),did),did,ssn,dob,fname,mname,rid,LOCAL);
   	splitPreFL := SORT(DISTRIBUTE(infile2(fnameSwitch AND lnameSwitch AND not (mnameSwitch or snameSwitch)),did),did,ssn,dob,fname,lname,rid,LOCAL);
   	splitPreFS := SORT(DISTRIBUTE(infile2(fnameSwitch AND snameSwitch AND not (mnameSwitch or lnameSwitch)),did),did,ssn,dob,fname,sname,rid,LOCAL);
   	splitPreML := SORT(DISTRIBUTE(infile2(mnameSwitch AND lnameSwitch AND not (fnameSwitch or snameSwitch)),did),did,ssn,dob,mname,lname,rid,LOCAL);
   	splitPreMS := SORT(DISTRIBUTE(infile2(mnameSwitch AND snameSwitch AND not (fnameSwitch or lnameSwitch)),did),did,ssn,dob,mname,sname,rid,LOCAL);
   	splitPreLS := SORT(DISTRIBUTE(infile2(lnameSwitch AND snameSwitch AND not (fnameSwitch or mnameSwitch)),did),did,ssn,dob,lname,sname,rid,LOCAL);
   	splitPreFML := SORT(DISTRIBUTE(infile2(fnameSwitch AND mnameSwitch AND lnameSwitch AND not snameSwitch),did),did,ssn,dob,fname,mname,lname,rid,LOCAL);
   	splitPreFMS := SORT(DISTRIBUTE(infile2(fnameSwitch AND mnameSwitch AND snameSwitch AND not lnameSwitch),did),did,ssn,dob,fname,mname,sname,rid,LOCAL);
   	splitPreFLS := SORT(DISTRIBUTE(infile2(fnameSwitch AND lnameSwitch AND snameSwitch AND not mnameSwitch),did),did,ssn,dob,fname,lname,sname,rid,LOCAL);
   	splitPreMLS := SORT(DISTRIBUTE(infile2(mnameSwitch AND lnameSwitch AND snameSwitch AND not fnameSwitch),did),did,ssn,dob,mname,lname,sname,rid,LOCAL);
   	splitPreAll := SORT(DISTRIBUTE(infile2(fnameSwitch AND mnameSwitch AND lnameSwitch AND snameSwitch),did),did,ssn,dob,fname,mname,lname,sname,rid,LOCAL);
		
   	splitF := ITERATE(splitPreF,splitEm(LEFT,RIGHT),LOCAL);
   	splitM := ITERATE(splitPreM,splitEm(LEFT,RIGHT),LOCAL);
   	splitL := ITERATE(splitPreL,splitEm(LEFT,RIGHT),LOCAL);
   	splitS := ITERATE(splitPreS,splitEm(LEFT,RIGHT),LOCAL);
   	splitFM := ITERATE(splitPreFM,splitEm(LEFT,RIGHT),LOCAL);
   	splitFL := ITERATE(splitPreFL,splitEm(LEFT,RIGHT),LOCAL);
   	splitFS := ITERATE(splitPreFS,splitEm(LEFT,RIGHT),LOCAL);
   	splitML := ITERATE(splitPreML,splitEm(LEFT,RIGHT),LOCAL);
   	splitMS := ITERATE(splitPreMS,splitEm(LEFT,RIGHT),LOCAL);
   	splitLS := ITERATE(splitPreLS,splitEm(LEFT,RIGHT),LOCAL);
   	splitFML := ITERATE(splitPreFML,splitEm(LEFT,RIGHT),LOCAL);
   	splitFMS := ITERATE(splitPreFMS,splitEm(LEFT,RIGHT),LOCAL);
   	splitFLS := ITERATE(splitPreFLS,splitEm(LEFT,RIGHT),LOCAL);
   	splitMLS := ITERATE(splitPreMLS,splitEm(LEFT,RIGHT),LOCAL);
   	splitAll := ITERATE(splitPreAll,splitEm(LEFT,RIGHT),LOCAL);
		
   	SHARED rolled := DEDUP(SORT(DISTRIBUTE(splitF+splitM+splitL+splitS+splitFM+splitFL+splitFS+splitML+splitMS+splitLS+splitFML+splitFMS+splitFLS+splitMLS+splitAll,rid),rid,-did,local),rid,local);

   	layout3 := RECORD
   		unsigned8 did1;
   		layout;
   	END;
   
   	outputs2 := JOIN(DISTRIBUTE(infile2,rid),DISTRIBUTE(rolled,rid),LEFT.rid = RIGHT.rid,TRANSFORM(layout3,SELF.did1 := LEFT.did;SELF := RIGHT),LOCAL);
   
   	OUTPUT(CHOOSEN(SORT(DISTRIBUTE(outputs2,did1),did1,did,rid,LOCAL),100),named('resultsViewed'));
   	OUTPUT(COUNT(outputs2),named('resultsCnt'));
   	
   	SHARED j0 := JOIN(hdr,rolled,LEFT.rid = RIGHT.rid,TRANSFORM(recordof(left),SELF.did := IF(RIGHT.did > 0,RIGHT.did,LEFT.did);SELF:= LEFT),LEFT OUTER,HASH);
   	SHARED j1 := j0(not(fname = '' and lname = '' and prim_name = '' and city = ''));
		
		d1 := DEDUP(SORT(DISTRIBUTE(j1,did),did,LOCAL),did,LOCAL);
		filteredDids := JOIN(DISTRIBUTE(j0,did),d1,LEFT.did=RIGHT.did,TRANSFORM(LEFT),LEFT ONLY,LOCAL);
		OUTPUT(COUNT(filteredDids),NAMED('filteredDids'));
		
		SHARED j2 := JOIN(DISTRIBUTE(j0,did),d1,LEFT.did=RIGHT.did,TRANSFORM(LEFT),LOCAL);

		SHARED patched := InsuranceHeader_PreProcess.fn_updateDID(j2) : INDEPENDENT;

		SHARED corrected := suppress.applyRegulatory.applyHeaderLinking(patched);
		
		tab_rid := TABLE(DISTRIBUTE(corrected,rid),{corrected.rid,cnt:=COUNT(GROUP)},rid,LOCAL);
		OUTPUT(COUNT(tab_rid(cnt>1)));
				
		SHARED filename := idl_header.files.FILE_IDL_SALT_ITER + version + '_CORRECTED';
   	EXPORT final := OUTPUT(corrected,,filename,OVERWRITE,COMPRESSED);
		EXPORT	updateSF := Sequential(
								FileServices.PromoteSuperFileList([IDL_Header.files.FILE_SALT_ITER_OUTPUT,
																									 IDL_Header.files.FILE_SALT_ITER_OUTPUT_FATHER], filename)
							);

	EXPORT run := sequential(final,updateSF);
END;
