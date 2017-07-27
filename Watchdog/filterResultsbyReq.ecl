/* Slightly fancy Iterates may need some explanation:

	if you sort by run_date descending, the first pass through
	an Iterate will get changeName records to all have the same
	value -- the high one.  However, FirstNameOnly (and address, phone,etc)
	will be left alone.

	then, sorting ascending, and re-iterating, will result in FNO having
	all set to same as lowest, and the rest left alone.

	we rely on doing things in this order -- first descending, then 
	ascending.
*/

mainResults := getDIDfromDelta;

ResultsFileFmt myIterName(ResultsFileFmt L, ResultsFileFmt R) := TRANSFORM
	SELF := if(R.changeName,
					 if (L.run_date = 0,
						R,
						L),
					 if (R.FirstNameOnly,
						if (L.run_date = 0 or R.run_date <= L.run_date,
							R,
							L),
						 R));
END;

ResultsFileFmt myIterSSN(ResultsFileFmt L, ResultsFileFmt R) := TRANSFORM
	SELF := if(R.changeSSN,
					 if (L.run_date = 0,
						R,
						L),
					 if (R.FirstSSNOnly,
						if (L.run_date = 0 or R.run_date < L.run_date,
							R,
							L),
						 R));
END;
			
ResultsFileFmt myIterAddress(ResultsFileFmt L, ResultsFileFmt R) := TRANSFORM
	SELF := if(R.changeAddress,
					 if (L.run_date = 0,
						R,
						L),
					 if (R.FirstAddressOnly,
						if (L.run_date = 0 or R.run_date < L.run_date,
							R,
							L),
						 R));
END;

ResultsFileFmt myIterPhone(ResultsFileFmt L, ResultsFileFmt R) := TRANSFORM
	SELF := if(R.changePhone,				
					 if (L.run_date = 0,	
						R,					
						L),
					 if (R.FirstPhoneOnly, 
						if (L.run_date = 0 or R.run_date < L.run_date,
							R,					
							L),
						 R));
END;

namesResults := MainResults((title != '' or 
							lname != '' or fname != '' or mname != '' or
							name_suffix != '') and
							(changeName or newName or FirstNameOnly));
namesResultsSorted := sort(namesResults,wid,did,-run_date);
namesResultSortGroup := group(namesResultsSorted,wid,did);

SSNResults := MainResults(SSN != '' and
							(changeSSN or newSSN or FirstSSNOnly));
SSNResultsSorted := sort(SSNResults,wid,did,-run_date);
SSNResultsSortGroup := group(SSNResultsSorted,wid,did);

PhoneResults := MainResults(Phone != '' and
							(changePhone or newPhone or FirstPhoneOnly));
PhoneResultsSorted := sort(PhoneResults,wid,did,-run_date);
PhoneResultsSortGroup := group(PhoneResultsSorted,wid,did);

AddressResults := MainResults((prim_range != '' or
								  predir != '' or
								  prim_name != '' or
								  suffix != '' or
								  postdir != '' or
								  unit_desig != '' or
								  sec_range != '' or
								  city_name != '' or
								  st != '' or
								  zip != '' or
								  zip4 != '') and
								(changeAddress or newAddress or FirstAddressOnly));
AddressResultsSorted := sort(AddressResults,wid,did,-run_date);
AddressResultsSortGroup := group(AddressResultsSorted,wid,did);

DeadPersonResults := MainResults(dod != '' and DeathStatus);
DeadPersonSorted := sort(DeadPersonResults,wid,did,-run_date);
theGratefulDead := group(DeadPersonSorted,wid,did);

nameResIter1 := ITERATE(namesResultSortGroup,myIterName(LEFT,RIGHT));
nameResFinal := ITERATE(sort(nameResIter1,run_date),myIterName(LEFT,RIGHT));

addressResIter1 := ITERATE(AddressResultsSortGroup,myIterAddress(LEFT,RIGHT));
addressResFinal := ITERATE(sort(AddressResIter1,run_date),myIterAddress(LEFT,RIGHT));

phoneResIter1 := ITERATE(PhoneResultsSortGroup,myIterPhone(LEFT,RIGHT));
phoneResFinal := ITERATE(sort(phoneResIter1,run_date),myIterPhone(LEFT,RIGHT));

SSNResIter1 := ITERATE(ssnResultsSortGroup,myIterSSN(LEFT,RIGHT));
SSNResFinal := ITERATE(sort(SSNResIter1,run_date),myIterSSN(LEFT,RIGHT));

myFinalRes := nameResFinal + addressResFinal 
				+ phoneResFinal + SSNResFinal + theGratefulDead;

myFiltFinalRes := myFinalRes(run_date >= (INTEGER)MRTD);
myDgFFRes := group(myFiltFinalRes);
mySortFinalRes := group(sort(myDgFFRes,wid,did,-run_date),wid,did);
myDDFinalRes := dedup(mySortFinalRes);

FinalResFmt := RECORD
	UNSIGNED6 Wid;
	layout_delta;
END;

FinalResFmt finalTrans(ResultsFileFmt L) := TRANSFORM
	SELF := L;
END;


export filterResultsbyReq := PROJECT(myDDFinalRes,finalTrans(LEFT));