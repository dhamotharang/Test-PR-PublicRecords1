/*
	This function takes in an uncorrected header, and applies any corrections needed.  It then returns the corrected header.
	it is a copy of Risk_Indicators.Header_Corrections_Function that has been modified for use on roxie

	this code also applies person context overrides from header_correct_record_id that were added in GetOverrideFlags

	this is applied to qh and person header.

*/

IMPORT Header, ut, FCRA, Address, STD, risk_indicators, PublicRecords_KEL, dx_Header;

EXPORT Header_Corrections_Function_Roxie (DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_Doxie__Key_Header) base_hf_uncorrected) := FUNCTION

overrideHeaderDID := fcra.Key_Override_Header_DID;

/* *****************************************
 *           Apply Corrections             *
 ******************************************* */
todaysdate := (string) risk_indicators.iid_constants.todaydate; // for checking derog's fcra-date compliance 
 
tempHeader := PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).tempHeader;

	
Layout_Working := RECORD
	INTEGER UIDAppend;
	INTEGER G_ProcUID;
	Boolean HeaderRec;
	STRING Archive_Date;
	data57 DPMBitMAP;
	dx_Header.layout_header;
	STRING20 oldFname;
	STRING20 newFname;
	STRING20 oldMname;
	STRING20 newMname;
	STRING20 oldLname;
	STRING20 newLname;
	STRING5 oldNameSuffix;
	STRING5 newNameSuffix;
	STRING10 oldPrimRange;
	STRING10 newPrimRange;
	STRING2 oldPredir;
	STRING2 newPredir;
	STRING28 oldPrimName;
	STRING28 newPrimName;
	STRING4 oldSuffix;
	STRING4 newSuffix;
	STRING2 oldPostdir;
	STRING2 newPostdir;
	STRING10 oldUnitDesig;
	STRING10 newUnitDesig;
	STRING8 oldSecRange;
	STRING8 newSecRange;
	STRING25 oldCityName;
	STRING25 newCityName;
	STRING2 oldSt;
	STRING2 newSt;
	STRING5 oldZip;
	STRING5 newZip;
	STRING4 oldZip4;
	STRING4 newZip4;
	STRING9 oldSSN;
	STRING9 newSSN;
	STRING8 oldDOB;
	STRING8 newDOB;
	BOOLEAN isCorrected;
	Risk_Indicators.layout_overrides.header_correct_record_id;
END;

Layout_Working combineHeaderCorrections(recordof(base_hf_uncorrected) le, recordof(overrideHeaderDID) ri) := TRANSFORM
	// correct fields where a correction was done OR suppressed
	SELF.fname := IF(TRIM(ri.head.fname) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Fname] = '1', ri.head.fname, le.fname);
	SELF.mname := IF(TRIM(ri.head.mname) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Mname] = '1', ri.head.mname, le.mname);
	SELF.lname := IF(TRIM(ri.head.lname) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Lname] = '1', ri.head.lname, le.lname);
	SELF.name_suffix := IF(TRIM(ri.head.name_suffix) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.NameSuffix] = '1', ri.head.name_suffix, le.name_suffix);
	SELF.prim_range := IF(TRIM(ri.head.prim_range) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.PrimRange] = '1', ri.head.prim_range, le.prim_range);
	SELF.predir := IF(TRIM(ri.head.predir) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Predir] = '1', ri.head.predir, le.predir);
	SELF.prim_name := IF(TRIM(ri.head.prim_name) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.PrimName] = '1', ri.head.prim_name, le.prim_name);
	SELF.suffix := IF(TRIM(ri.head.suffix) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Suffix] = '1', ri.head.suffix, le.suffix);
	SELF.postdir := IF(TRIM(ri.head.postdir) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Postdir] = '1', ri.head.postdir, le.postdir);
	SELF.unit_desig := IF(TRIM(ri.head.unit_desig) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.UnitDesig] = '1', ri.head.unit_desig, le.unit_desig);
	SELF.sec_range := IF(TRIM(ri.head.sec_range) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.SecRange] = '1', ri.head.sec_range, le.sec_range);
	SELF.city_name := IF(TRIM(ri.head.city_name) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.CityName] = '1', ri.head.city_name, le.city_name);
	SELF.st := IF(TRIM(ri.head.st) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.St] = '1', ri.head.st, le.st);
	SELF.zip := IF(TRIM(ri.head.zip) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Zip] = '1', ri.head.zip, le.zip);
	SELF.zip4 := IF(TRIM(ri.head.zip4) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Zip4] = '1', ri.head.zip4, le.zip4);
	SELF.ssn := IF(TRIM(ri.head.ssn) <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.SSN] = '1', ri.head.ssn, le.ssn);
	SELF.dob := IF(ri.head.dob<>0 OR ri.blankout[Risk_Indicators.iid_constants.suppress.DOB] = '1', ri.head.dob, le.dob);
	
	// check to see what was changed to what AND if changed, then populate the fields for the next PROJECT
	fnameCorrected := ri.head.fname <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Fname] = '1';	// correction field will only be populated if a correction was done
	SELF.oldFname := IF(fnameCorrected, le.fname, '');			// only populate the old if there is a new
	SELF.newFname := IF(fnameCorrected, ri.head.fname, '');	// only populate the new if there is a new
	
	mnameCorrected := ri.head.mname <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Mname] = '1';	// correction field will only be populated if a correction was done
	SELF.oldmname := IF(mnameCorrected, le.mname, '');			// only populate the old if there is a new
	SELF.newmname := IF(mnameCorrected, ri.head.mname, '');	// only populate the new if there is a new
	
	lnameCorrected := ri.head.lname <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Lname] = '1';	// correction field will only be populated if a correction was done
	SELF.oldLname := IF(lnameCorrected, le.lname, '');			// only populate the old if there is a new
	SELF.newLname := IF(lnameCorrected, ri.head.lname, '');	// only populate the new if there is a new
	
	nameSuffixCorrected := ri.head.name_suffix <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.NameSuffix] = '1';	// correction field will only be populated if a correction was done
	SELF.oldNameSuffix := IF(nameSuffixCorrected, le.name_suffix, '');			// only populate the old if there is a new
	SELF.newNameSuffix := IF(nameSuffixCorrected, ri.head.name_suffix, '');	// only populate the new if there is a new
	
	// check to see if any part of the address was corrected, if so, then populate all fields in the address so we can compare later to see what the original address was
	addrCorrected := 	ri.head.prim_range <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.PrimName] = '1' OR 
										ri.head.predir <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Predir] = '1' OR 
										ri.head.prim_name <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.PrimName] = '1' OR
										ri.head.suffix <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Suffix] = '1' OR 
										ri.head.postdir <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Postdir] = '1' OR 
										ri.head.unit_desig <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.UnitDesig] = '1' OR
										ri.head.sec_range <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.SecRange] = '1';
	
	primRangeCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldPrimRange := IF(primRangeCorrected, le.prim_range, '');			// only populate the old if there is a new
	SELF.newPrimRange := IF(primRangeCorrected, ri.head.prim_range, '');	// only populate the new if there is a new
	
	predirCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldPredir := IF(predirCorrected, le.predir, '');			// only populate the old if there is a new
	SELF.newPredir := IF(predirCorrected, ri.head.predir, '');	// only populate the new if there is a new
	
	primNameCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldPrimName := IF(primNameCorrected, le.prim_name, '');			// only populate the old if there is a new
	SELF.newPrimName := IF(primNameCorrected, ri.head.prim_name, '');	// only populate the new if there is a new
	
	suffixCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldSuffix := IF(suffixCorrected, le.suffix, '');			// only populate the old if there is a new
	SELF.newSuffix := IF(suffixCorrected, ri.head.suffix, '');	// only populate the new if there is a new

	postdirCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldPostDir := IF(postDirCorrected, le.postdir, '');			// only populate the old if there is a new
	SELF.newPostDir := IF(postdirCorrected, ri.head.postdir, '');	// only populate the new if there is a new
	
	unitDesigCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldUnitDesig := IF(unitDesigCorrected, le.unit_desig, '');			// only populate the old if there is a new
	SELF.newUnitDesig := IF(unitDesigCorrected, ri.head.unit_desig, '');	// only populate the new if there is a new
	
	secRangeCorrected := addrCorrected; // correction field will only be populated if a correction was done
	SELF.oldSecRange := IF(secRangeCorrected, le.sec_range, '');			// only populate the old if there is a new
	SELF.newSecRange := IF(secRangeCorrected, ri.head.sec_range, '');	// only populate the new if there is a new
	
	cityNameCorrected := addrCorrected AND ri.head.city_name <> '' OR ri.blankout[12] = '1';	// correction field will only be populated if a correction was done
	SELF.oldCityname := IF(cityNameCorrected, le.city_name, '');			// only populate the old if there is a new
	SELF.newCityName := IF(cityNameCorrected, ri.head.city_name, '');	// only populate the new if there is a new
	
	stCorrected := addrCorrected AND ri.head.st <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.St] = '1';	// correction field will only be populated if a correction was done
	SELF.oldSt := IF(stCorrected, le.st, '');			// only populate the old if there is a new
	SELF.newSt := IF(stCorrected, ri.head.st, '');	// only populate the new if there is a new
	
	zipCorrected := addrCorrected AND ri.head.zip <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Zip] = '1';	// correction field will only be populated if a correction was done
	SELF.oldZip := IF(zipCorrected, le.zip, '');			// only populate the old if there is a new
	SELF.newZip := IF(zipCorrected, ri.head.zip, '');	// only populate the new if there is a new
	
	zip4Corrected := addrCorrected AND ri.head.zip4 <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.Zip4] = '1';	// correction field will only be populated if a correction was done
	SELF.oldZip4 := IF(zip4Corrected, le.zip4, '');			// only populate the old if there is a new
	SELF.newZip4 := IF(zip4Corrected, ri.head.zip4, '');	// only populate the new if there is a new
	
	ssnCorrected := ri.head.ssn <> '' OR ri.blankout[Risk_Indicators.iid_constants.suppress.SSN] = '1';	// correction field will only be populated if a correction was done
	SELF.oldSSN := IF(ssnCorrected, le.ssn, '');			// only populate the old if there is a new
	SELF.newSSN := IF(ssnCorrected, ri.head.ssn, '');	// only populate the new if there is a new
	
	dobCorrected := ri.head.dob<>0 OR ri.blankout[Risk_Indicators.iid_constants.suppress.DOB] = '1';	// correction field will only be populated if a correction was done
	SELF.oldDOB := IF(dobCorrected, (STRING)le.dob, '');			// only populate the old if there is a new
	SELF.newDOB := IF(dobCorrected, (STRING)ri.head.dob, '');	// only populate the new if there is a new
	
	SELF.isCorrected := (STRING)ri.head.rid NOT IN ['','0'] or ri.head.persistent_record_id<>0;
	
	SELF := le;
END;


corrPlusHeader := JOIN(base_hf_uncorrected, overrideHeaderDID, // this includes quick header
										LEFT.did<>0 AND 
										KEYED(LEFT.did = RIGHT.did) AND
										(
											(left.rid=right.head.rid)  // old way
												or 
											(left.persistent_record_id=right.head.persistent_record_id) // new way, using persistent_record_id
											) and 
									//dont correct those what will later be suppressed
									(trim((string)right.did) + trim((string)right.head.rid) not in left.header_correct_record_id)// old way - exclude corrected records from prior to 11/13/2012
									and 
										(trim((string)right.head.persistent_record_id ) not in left.header_correct_record_id)  // new way - using persistent_record_id	
																	AND (trim((string)right.head.rid) not in left.header_correct_record_id), //sometimes persist id is blank and all we have is a rid
										combineHeaderCorrections(LEFT, RIGHT), 
											atmost(ut.limits.HEADER_PER_DID),
												LEFT OUTER);	
										
corrOnly := corrPlusHeader(isCorrected);
unCorrOnly := corrPlusHeader(~isCorrected);

Layout_Working correctFutureData(unCorrOnly le, corrOnly ri) := TRANSFORM
	SELF.fname := IF((TRIM(ri.oldFname) <> '' OR TRIM(ri.newFname) <> '') AND TRIM(ri.oldFname)=TRIM(le.fname), ri.newFname, le.fname);
	SELF.mname := IF((TRIM(ri.oldMname) <> '' OR TRIM(ri.newMname) <> '') AND TRIM(ri.oldMname)=TRIM(le.mname), ri.newMname, le.mname);
	SELF.lname := IF((TRIM(ri.oldLname) <> '' OR TRIM(ri.newLname) <> '') AND TRIM(ri.oldLname)=TRIM(le.lname), ri.newLname, le.lname);
	SELF.name_suffix := IF((TRIM(ri.oldNameSuffix) <> '' OR TRIM(ri.newNameSuffix) <> '') AND TRIM(ri.oldNameSuffix)=TRIM(le.name_suffix), ri.newNameSuffix, le.name_suffix);
	
	// need to check same address here and not individual parts before changing them
	origAddr := IF(ri.oldPrimName <> '' OR ri.oldPrimRange <> '', 
															address.Addr1FromComponents(ri.oldPrimRange,ri.oldPreDir,ri.oldPrimName,ri.oldSuffix,ri.oldPostDir,ri.oldUnitDesig,ri.oldSecRange),// use old because it has been corrected
															address.Addr1FromComponents(ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,ri.unit_desig,ri.sec_range));	// use original because there is no old address because is has not been corrected
	sameAddr := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range) = origAddr;
	SELF.prim_range := IF((TRIM(ri.oldPrimRange) <> '' OR TRIM(ri.newPrimRange) <> '') AND sameAddr, ri.newPrimRange, le.prim_range);
	SELF.predir := IF((TRIM(ri.oldPreDir) <> '' OR TRIM(ri.newPreDir) <> '') AND sameAddr, ri.newPreDir, le.predir);
	SELF.prim_name := IF((TRIM(ri.oldPrimName) <> '' OR TRIM(ri.newPrimName) <> '') AND sameAddr, ri.newPrimName, le.prim_name);
	SELF.suffix := IF((TRIM(ri.oldSuffix) <> '' OR TRIM(ri.newSuffix) <> '') AND sameAddr, ri.newSuffix, le.suffix);
	SELF.postdir := IF((TRIM(ri.oldPostDir) <> '' OR TRIM(ri.newPostDir) <> '') AND sameAddr, ri.newPostDir, le.postdir);
	SELF.unit_desig := IF((TRIM(ri.oldUnitDesig) <> '' OR TRIM(ri.newUnitDesig) <> '') AND sameAddr, ri.newUnitDesig, le.unit_desig);
	SELF.sec_range := IF((TRIM(ri.oldSecRange) <> '' OR TRIM(ri.newSecRange) <> '') AND sameAddr, ri.newSecRange, le.sec_range);
	SELF.city_name := IF((TRIM(ri.oldCityName) <> '' OR TRIM(ri.newCityName) <> '') AND sameAddr, ri.newCityName, le.city_name);
	SELF.st := IF((TRIM(ri.oldSt) <> '' OR TRIM(ri.newSt) <> '') AND sameAddr, ri.newSt, le.st);
	SELF.zip := IF((TRIM(ri.oldZip) <> '' OR TRIM(ri.newZip) <> '') AND sameAddr, ri.newZip, le.Zip);
	SELF.zip4 := IF((TRIM(ri.oldZip4) <> '' OR TRIM(ri.newZip4) <> '') AND sameAddr, ri.newZip4, le.Zip4);
	
	SELF.ssn := IF((TRIM(ri.oldSSN) <> '' OR TRIM(ri.newSSN) <> '') AND TRIM(ri.oldSSN)=TRIM(le.ssn), ri.newSSN, le.ssn);
	SELF.dob := IF((TRIM(ri.oldDOB) <> '' OR TRIM(ri.newDOB) <> '') AND TRIM(ri.oldDOB)=TRIM((STRING)le.dob), (UNSIGNED)ri.newDOB, le.dob);
	
	// keep the old/new fields for below rollup
	SELF.oldFname := IF(sameAddr AND (TRIM(ri.oldFname) <> '' OR TRIM(ri.newFname) <> ''), ri.oldFname, '');
	SELF.newFname := IF(sameAddr AND (TRIM(ri.oldFname) <> '' OR TRIM(ri.newFname) <> ''), ri.newFname, '');
	SELF.oldMname := IF(sameAddr AND (TRIM(ri.oldMname) <> '' OR TRIM(ri.newMname) <> ''), ri.oldMname, '');
	SELF.newMname := IF(sameAddr AND (TRIM(ri.oldMname) <> '' OR TRIM(ri.newMname) <> ''), ri.newMname, '');
	SELF.oldLname := IF(sameAddr AND (TRIM(ri.oldLname) <> '' OR TRIM(ri.newLname) <> ''), ri.oldLname, '');
	SELF.newLname := IF(sameAddr AND (TRIM(ri.oldLname) <> '' OR TRIM(ri.newLname) <> ''), ri.newLname, '');
	SELF.oldNameSuffix := IF(sameAddr AND (TRIM(ri.oldNameSuffix) <> '' OR TRIM(ri.newNameSuffix) <> ''), ri.oldNameSuffix, '');
	SELF.newNameSuffix := IF(sameAddr AND (TRIM(ri.oldNameSuffix) <> '' OR TRIM(ri.newNameSuffix) <> ''), ri.newNameSuffix, '');
	SELF.oldPrimRange := IF(sameAddr AND (TRIM(ri.oldPrimRange) <> '' OR TRIM(ri.newPrimRange) <> ''), ri.oldPrimRange, '');
	SELF.newPrimRange := IF(sameAddr AND (TRIM(ri.oldPrimRange) <> '' OR TRIM(ri.newPrimRange) <> ''), ri.newPrimRange, '');
	SELF.oldPredir := IF(sameAddr AND (TRIM(ri.oldPredir) <> '' OR TRIM(ri.newPredir) <> ''), ri.oldPredir, '');
	SELF.newPredir := IF(sameAddr AND (TRIM(ri.oldPredir) <> '' OR TRIM(ri.newPredir) <> ''), ri.newPredir, '');
	SELF.oldPrimName := IF(sameAddr AND (TRIM(ri.oldPrimName) <> '' OR TRIM(ri.newPrimName) <> ''), ri.oldPrimName, '');
	SELF.newPrimName := IF(sameAddr AND (TRIM(ri.oldPrimName) <> '' OR TRIM(ri.newPrimName) <> ''), ri.newPrimName, '');
	SELF.oldSuffix := IF(sameAddr AND (TRIM(ri.oldSuffix) <> '' OR TRIM(ri.newSuffix) <> ''), ri.oldSuffix, '');
	SELF.newSuffix := IF(sameAddr AND (TRIM(ri.oldSuffix) <> '' OR TRIM(ri.newSuffix) <> ''), ri.newSuffix, '');
	SELF.oldPostdir := IF(sameAddr AND (TRIM(ri.oldPostdir) <> '' OR TRIM(ri.newPostdir) <> ''), ri.oldPostdir, '');
	SELF.newPostdir := IF(sameAddr AND (TRIM(ri.oldPostdir) <> '' OR TRIM(ri.newPostdir) <> ''), ri.newPostdir, '');
	SELF.oldUnitDesig := IF(sameAddr AND (TRIM(ri.oldUnitDesig) <> '' OR TRIM(ri.newUnitDesig) <> ''), ri.oldUnitDesig, '');
	SELF.newUnitDesig := IF(sameAddr AND (TRIM(ri.oldUnitDesig) <> '' OR TRIM(ri.newUnitDesig) <> ''), ri.newUnitDesig, '');
	SELF.oldSecRange := IF(sameAddr AND (TRIM(ri.oldSecRange) <> '' OR TRIM(ri.newSecRange) <> ''), ri.oldSecRange, '');
	SELF.newSecRange := IF(sameAddr AND (TRIM(ri.oldSecRange) <> '' OR TRIM(ri.newSecRange) <> ''), ri.newSecRange, '');
	SELF.oldCityName := IF(sameAddr AND (TRIM(ri.oldCityName) <> '' OR TRIM(ri.newCityName) <> ''), ri.oldCityName, '');
	SELF.newCityName := IF(sameAddr AND (TRIM(ri.oldCityName) <> '' OR TRIM(ri.newCityName) <> ''), ri.newCityName, '');
	SELF.oldSt := IF(sameAddr AND (TRIM(ri.oldSt) <> '' OR TRIM(ri.newSt) <> ''), ri.oldSt, '');
	SELF.newSt := IF(sameAddr AND (TRIM(ri.oldSt) <> '' OR TRIM(ri.newSt) <> ''), ri.newSt, '');
	SELF.oldZip := IF(sameAddr AND (TRIM(ri.oldZip) <> '' OR TRIM(ri.newZip) <> ''), ri.oldZip, '');
	SELF.newZip := IF(sameAddr AND (TRIM(ri.oldZip) <> '' OR TRIM(ri.newZip) <> ''), ri.newZip, '');
	SELF.oldZip4 := IF(sameAddr AND (TRIM(ri.oldZip4) <> '' OR TRIM(ri.newZip4) <> ''), ri.oldZip4, '');
	SELF.newZip4 := IF(sameAddr AND (TRIM(ri.oldZip4) <> '' OR TRIM(ri.newZip4) <> ''), ri.newZip4, '');
	SELF.oldSSN := IF(sameAddr AND (TRIM(ri.oldSSN) <> '' OR TRIM(ri.newSSN) <> ''), ri.oldSSN, '');
	SELF.newSSN := IF(sameAddr AND (TRIM(ri.oldSSN) <> '' OR TRIM(ri.newSSN) <> ''), ri.newSSN, '');
	SELF.oldDOB := IF(sameAddr AND (TRIM(ri.oldDOB) <> '' OR TRIM(ri.newDOB) <> ''), ri.oldDOB, '');
	SELF.newDOB := IF(sameAddr AND (TRIM(ri.oldDOB) <> '' OR TRIM(ri.newDOB) <> ''), ri.newDOB, '');
	
	SELF := le;	// keep the remaining left fields
END;
finalCorr := JOIN(unCorrOnly, CorrOnly, 
									LEFT.DID = RIGHT.Did AND
									left.uidappend=right.uidappend and//new
									((TRIM(RIGHT.oldFname) <> '' OR TRIM(RIGHT.newFname) <> '') AND RIGHT.oldFname=LEFT.fname OR	
									(TRIM(RIGHT.oldMname) <> '' OR TRIM(RIGHT.newMname) <> '') AND RIGHT.oldMname=LEFT.mname  OR
									(TRIM(RIGHT.oldLname) <> '' OR TRIM(RIGHT.newLname) <> '') AND RIGHT.oldLname=LEFT.lname OR
									(TRIM(RIGHT.oldNameSuffix) <> '' OR TRIM(RIGHT.newNameSuffix) <> '') AND RIGHT.oldNameSuffix=LEFT.name_suffix  OR
									(TRIM(RIGHT.oldSSN) <> '' OR TRIM(RIGHT.newSSN) <> '') AND RIGHT.oldSSN=LEFT.ssn OR
									(TRIM(RIGHT.oldDOB) <> '' OR TRIM(RIGHT.newDOB) <> '') AND RIGHT.oldDOB=(STRING)LEFT.dob OR
									// same address AND an address field is different
									address.Addr1FromComponents(RIGHT.oldPrimRange,RIGHT.oldPredir,RIGHT.oldPrimName,RIGHT.oldSuffix,RIGHT.oldPostDir,RIGHT.oldUnitDesig,RIGHT.oldSecRange) = 
									address.Addr1FromComponents(LEFT.Prim_Range,LEFT.PreDir,LEFT.Prim_Name,LEFT.Suffix,LEFT.PostDir,LEFT.Unit_Desig,LEFT.Sec_Range)), 
									correctFutureData(LEFT, RIGHT), ALL, LEFT OUTER);
								
//this rollup likes to dedup QH records and turn QH records with dt first seen, dt last seen populated and a rec type of 1 into QH records with blank dates and a rec type of 2.. something seems funny here
						
								
// doing the above join results in too many records per rid (potentially), we need to rollup by rid and figure out which field to keep from the multiple choices
layout_working getCorrectCorrections(finalCorr le, finalCorr ri) := TRANSFORM
	SELF.fname := map(TRIM(le.fname)=TRIM(ri.fname) => le.fname,	// same on both, keep left
										(TRIM(le.oldFname) <> '' OR TRIM(le.newFname) <> '') AND TRIM(le.newFname)=TRIM(le.fname) => le.fname,	// correction on this rid and left matches new, so keep left
										(TRIM(le.oldFname) <> '' OR TRIM(le.newFname) <> '') => ri.fname, // correction on this rid and left doesnt match new, so keep right
										(TRIM(ri.oldFname) <> '' OR TRIM(ri.newFname) <> '') => ri.fname,	// correction on this rid and right had the correction, so keep right?
										le.fname);	// default to keep left
	SELF.mname := map(TRIM(le.mname)=TRIM(ri.mname) => le.mname,	// same on both, keep left
										(TRIM(le.oldmname) <> '' OR TRIM(le.newmname) <> '') AND TRIM(le.newmname)=TRIM(le.mname) => le.mname,	// correction on this rid and left matches new, so keep left
										(TRIM(le.oldmname) <> '' OR TRIM(le.newmname) <> '') => ri.mname, // correction on this rid and left doesnt match new, so keep right
										(TRIM(ri.oldMname) <> '' OR TRIM(ri.newMname) <> '') => ri.mname,	// correction on this rid and right had the correction, so keep right?
										le.mname);	// default to keep left
	SELF.lname := map(TRIM(le.lname)=TRIM(ri.lname) => le.lname,	// same on both, keep left
										(TRIM(le.oldlname) <> '' OR TRIM(le.newlname) <> '') AND TRIM(le.newlname)=TRIM(le.lname) => le.lname,	// correction on this rid and left matches new, so keep left
										(TRIM(le.oldlname) <> '' OR TRIM(le.newlname) <> '') => ri.lname, // correction on this rid and left doesnt match new, so keep right
										(TRIM(ri.oldLname) <> '' OR TRIM(ri.newLName) <> '') => ri.lname,	// correction on this rid and right had the correction, so keep right?
										le.lname);	// default to keep left
	SELF.name_suffix := map(TRIM(le.name_suffix)=TRIM(ri.name_suffix) => le.name_suffix,	// same on both, keep left
													(TRIM(le.oldNameSuffix) <> '' OR TRIM(le.newNameSuffix) <> '') AND TRIM(le.newNameSuffix)=TRIM(le.name_suffix) => le.name_suffix,	// correction on this rid and left matches new, so keep left
													(TRIM(le.oldNameSuffix) <> '' OR TRIM(le.newNameSuffix) <> '') => ri.name_suffix, // correction on this rid and left doesnt match new, so keep right
													(TRIM(ri.oldNameSuffix) <> '' OR TRIM(ri.newNameSuffix) <> '') => ri.name_suffix,	// correction on this rid and right had the correction, so keep right?
													le.name_suffix);	// default to keep left
	SELF.prim_range := map(	TRIM(le.prim_range)=TRIM(ri.prim_range) => le.prim_range,	// same on both, keep left
													(TRIM(le.oldPrimRange) <> '' OR TRIM(le.newPrimRange) <> '') AND TRIM(le.newPrimRange)=TRIM(le.prim_range) => le.prim_range,	// correction on this rid and left matches new, so keep left
													(TRIM(le.oldPrimRange) <> '' OR TRIM(le.newPrimRange) <> '') => ri.prim_range, // correction on this rid and left doesnt match new, so keep right
													(TRIM(ri.oldPrimRange) <> '' OR TRIM(ri.newPrimRange) <> '') => ri.prim_range,	// correction on this rid and right had the correction, so keep right?
													le.prim_range);	// default to keep left
	SELF.predir := map(	TRIM(le.predir)=TRIM(ri.predir) => le.predir,	// same on both, keep left
											(TRIM(le.oldpredir) <> '' OR TRIM(le.newpredir) <> '') AND TRIM(le.newpredir)=TRIM(le.predir) => le.predir,	// correction on this rid and left matches new, so keep left
											(TRIM(le.oldpredir) <> '' OR TRIM(le.newpredir) <> '') => ri.predir, // correction on this rid and left doesnt match new, so keep right
											(TRIM(ri.oldPredir) <> '' OR TRIM(ri.newPredir) <> '') => ri.predir,	// correction on this rid and right had the correction, so keep right?
											le.predir);	// default to keep left
	SELF.prim_name := map(TRIM(le.prim_name)=TRIM(ri.prim_name) => le.prim_name,	// same on both, keep left
												(TRIM(le.oldPrimName) <> '' OR TRIM(le.newPrimName) <> '') AND TRIM(le.newPrimName)=TRIM(le.prim_name) => le.prim_name,	// correction on this rid and left matches new, so keep left
												(TRIM(le.oldPrimName) <> '' OR TRIM(le.newPrimName) <> '') => ri.prim_name, // correction on this rid and left doesnt match new, so keep right
												(TRIM(ri.oldPrimName) <> '' OR TRIM(ri.newPrimName) <> '') => ri.prim_name,	// correction on this rid and right had the correction, so keep right?
												le.prim_name);	// default to keep left
	SELF.suffix := map(	TRIM(le.suffix)=TRIM(ri.suffix) => le.suffix,	// same on both, keep left
											(TRIM(le.oldsuffix) <> '' OR TRIM(le.newsuffix) <> '') AND TRIM(le.newsuffix)=TRIM(le.suffix) => le.suffix,	// correction on this rid and left matches new, so keep left
											(TRIM(le.oldsuffix) <> '' OR TRIM(le.newsuffix) <> '') => ri.suffix, // correction on this rid and left doesnt match new, so keep right
											(TRIM(ri.oldSuffix) <> '' OR TRIM(ri.newSuffix) <> '') => ri.suffix,	// correction on this rid and right had the correction, so keep right?
											le.suffix);	// default to keep left
	SELF.postdir := map(TRIM(le.postdir)=TRIM(ri.postdir) => le.postdir,	// same on both, keep left
											(TRIM(le.oldpostdir) <> '' OR TRIM(le.newpostdir) <> '') AND TRIM(le.newpostdir)=TRIM(le.postdir) => le.postdir,	// correction on this rid and left matches new, so keep left
											(TRIM(le.oldpostdir) <> '' OR TRIM(le.newpostdir) <> '') => ri.postdir, // correction on this rid and left doesnt match new, so keep right
											(TRIM(ri.oldPostdir) <> '' OR TRIM(ri.newPostdir) <> '') => ri.postdir,	// correction on this rid and right had the correction, so keep right?
											le.postdir);	// default to keep left
	SELF.unit_desig := map(	TRIM(le.unit_desig)=TRIM(ri.unit_desig) => le.unit_desig,	// same on both, keep left
													(TRIM(le.oldUnitDesig) <> '' OR TRIM(le.newUnitDesig) <> '') AND TRIM(le.newUnitDesig)=TRIM(le.unit_desig) => le.unit_desig,	// correction on this rid and left matches new, so keep left
													(TRIM(le.oldUnitDesig) <> '' OR TRIM(le.newUnitDesig) <> '') => ri.unit_desig, // correction on this rid and left doesnt match new, so keep right
													(TRIM(ri.oldUnitDesig) <> '' OR TRIM(ri.newUnitDesig) <> '') => ri.unit_desig,	// correction on this rid and right had the correction, so keep right?
													le.unit_desig);	// default to keep left
	SELF.sec_range := map(TRIM(le.sec_range)=TRIM(ri.sec_range) => le.sec_range,	// same on both, keep left
												(TRIM(le.oldSecRange) <> '' OR TRIM(le.newSecRange) <> '') AND TRIM(le.newSecRange)=TRIM(le.sec_range) => le.sec_range,	// correction on this rid and left matches new, so keep left
												(TRIM(le.oldSecRange) <> '' OR TRIM(le.newSecRange) <> '') => ri.sec_range, // correction on this rid and left doesnt match new, so keep right
												(TRIM(ri.oldSecRange) <> '' OR TRIM(ri.newSecRange) <> '') => ri.sec_range,	// correction on this rid and right had the correction, so keep right?
												le.sec_range);	// default to keep left
	SELF.city_name := map(TRIM(le.city_name)=TRIM(ri.city_name) => le.city_name,	// same on both, keep left
												(TRIM(le.oldCityName) <> '' OR TRIM(le.newCityName) <> '') AND TRIM(le.newCityName)=TRIM(le.city_name) => le.city_name,	// correction on this rid and left matches new, so keep left
												(TRIM(le.oldCityName) <> '' OR TRIM(le.newCityName) <> '') => ri.city_name, // correction on this rid and left doesnt match new, so keep right
												(TRIM(ri.oldCityName) <> '' OR TRIM(ri.newCityName) <> '') => ri.city_name,	// correction on this rid and right had the correction, so keep right?
												le.city_name);	// default to keep left
	SELF.st := map(	TRIM(le.st)=TRIM(ri.st) => le.st,	// same on both, keep left
									(TRIM(le.oldst) <> '' OR TRIM(le.newst) <> '') AND TRIM(le.newst)=TRIM(le.st) => le.st,	// correction on this rid and left matches new, so keep left
									(TRIM(le.oldst) <> '' OR TRIM(le.newst) <> '') => ri.st, // correction on this rid and left doesnt match new, so keep right
									(TRIM(ri.oldSt) <> '' OR TRIM(ri.newSt) <> '') => ri.st,	// correction on this rid and right had the correction, so keep right?
									le.st);	// default to keep left
	SELF.zip := map(TRIM(le.zip)=TRIM(ri.zip) => le.zip,	// same on both, keep left
									(TRIM(le.oldzip) <> '' OR TRIM(le.newzip) <> '') AND TRIM(le.newzip)=TRIM(le.zip) => le.zip,	// correction on this rid and left matches new, so keep left
									(TRIM(le.oldzip) <> '' OR TRIM(le.newzip) <> '') => ri.zip, // correction on this rid and left doesnt match new, so keep right
									(TRIM(ri.oldZip) <> '' OR TRIM(ri.newZip) <> '') => ri.zip,	// correction on this rid and right had the correction, so keep right?
									le.zip);	// default to keep left
	SELF.zip4 := map(	TRIM(le.zip4)=TRIM(ri.zip4) => le.zip4,	// same on both, keep left
										(TRIM(le.oldzip4) <> '' OR TRIM(le.newzip4) <> '') AND TRIM(le.newzip4)=TRIM(le.zip4) => le.zip4,	// correction on this rid and left matches new, so keep left
										(TRIM(le.oldzip4) <> '' OR TRIM(le.newzip4) <> '') => ri.zip4, // correction on this rid and left doesnt match new, so keep right
										(TRIM(ri.oldZip4) <> '' OR TRIM(ri.newZip4) <> '') => ri.zip4,	// correction on this rid and right had the correction, so keep right?
										le.zip4);	// default to keep left
	SELF.ssn := map(TRIM(le.ssn)=TRIM(ri.ssn) => le.ssn,	// same on both, keep left
									(TRIM(le.oldssn) <> '' OR TRIM(le.newssn) <> '') AND TRIM(le.newssn)=TRIM(le.ssn) => le.ssn,	// correction on this rid and left matches new, so keep left
									(TRIM(le.oldssn) <> '' OR TRIM(le.newssn) <> '') => ri.ssn, // correction on this rid and left doesnt match new, so keep right
									(TRIM(ri.oldSSN) <> '' OR TRIM(ri.newSSN) <> '') => ri.ssn,	// correction on this rid and right had the correction, so keep right?
									le.ssn);	// default to keep left
	SELF.dob := map((le.dob)=(ri.dob) => le.dob,	// same on both, keep left
									(TRIM(le.olddob) <> '' OR TRIM(le.newdob) <> '') AND TRIM(le.newdob)=TRIM((STRING)le.dob) => le.dob,	// correction on this rid and left matches new, so keep left
									(TRIM(le.olddob) <> '' OR TRIM(le.newdob) <> '') => ri.dob, // correction on this rid and left doesnt match new, so keep right
									(TRIM(ri.oldDOB) <> '' OR TRIM(ri.newDOB) <> '') => ri.dob,	// correction on this rid and right had the correction, so keep right?
									le.dob);	// default to keep left
									
	SELF := le;	// keep the remaining left fields
END;
sortedSet := SORT(finalCorr, did, persistent_record_id,-Fname,-Mname,-Lname,-Name_Suffix,-Prim_Range,-Predir,-Prim_Name,-Suffix,-Postdir,-Unit_Desig,-Sec_Range,-City_Name,-St,-Zip,-Zip4,-SSN,-DOB);
finalCorr2 := ROLLUP(sortedSet, 
										LEFT.did = RIGHT.did AND 
										LEFT.persistent_record_id=RIGHT.persistent_record_id and
										left.uidappend=right.uidappend and//new
										left.headerrec=right.headerrec, //new -- seems to keep us from rollup up QH records
												getCorrectCorrections(LEFT,RIGHT));									
									
base_hf := PROJECT(finalCorr2 + corrOnly, TRANSFORM(tempHeader, SELF := LEFT, self.first_ingest_date := []));//first_ingest_date will be populated later


// do left only join with the suppressions file.  if suppression exists, can't use that header record
//flag suppressions will be removed from this key soon aug 2020??
valid_header_records_old := join(base_hf, FCRA.Key_Override_Flag_DID,
	KEYED((string)left.did = right.l_did) and
		right.file_id = FCRA.FILE_ID.hdr and
		left.persistent_record_id = (unsigned)right.record_id,
	transform(tempHeader, self := left),
	atmost(ut.limits.HEADER_PER_DID),
	left only);
	
//	header_correct_record_id was grabbed from person context which will be the only suppressions soon aug 2020??
valid_header_records := valid_header_records_old((trim((string)did) + trim((string)rid) not in header_correct_record_id	)// old way - exclude corrected records from prior to 11/13/2012
																									and (trim((string)persistent_record_id ) not in header_correct_record_id) AND // new way - using persistent_record_id	
																												trim((string)rid) not in header_correct_record_id);   //sometimes persist id is blank and all we have is a rid

// output(base_hf_uncorrected, named('base_hf_uncorrected'));	
// output(corrPlusHeader, named('corrPlusHeader'));	
// output(corrOnly, named('corrOnly'));	
// output(unCorrOnly, named('unCorrOnly'));	
// output(finalCorr, named('finalCorr'));	
// output(sortedSet, named('sortedSet'));	
// output(finalCorr2, named('finalCorr2'));	
// output(base_hf, named('base_hf'));	
// output(valid_header_records_old, named('valid_header_records_old'));	
// output(valid_header_records, named('valid_header_records'));	
	
/* ****************************************************
 * Corrections have been applied - Continue as normal *
 ****************************************************** */
	RETURN valid_header_records;

END;