#OPTION('checkPointRecovery', 1);
import ut;

ds := name_zip_age_ssn4_do_Z;

tf(STRING fname) := datalib.preferredfirstNew(fname, Header_Slimsort.Constants.UsePFNew);
NoBigCounts := ds(Count_A_Z_S_F_M_L < 10000);


ut.MAC_Remove_Withdups(NoBigCounts, HASH(lname, fname[1],zip), 50000, NoBigZip)
NBZ := group(NoBigZip);
ut.MAC_Remove_Withdups(NBZ, HASH(lname, fname[1],ssn4), 50000, NoBigSSN)
NBS := group(NoBigSSN);
ut.MAC_Remove_Withdups(NBS, HASH(lname, fname[1],age), 100000, NoBigMatches)


//ut.MAC_Remove_Withdups(nobigcounts,hash(lname,fname[1]),500000,noBigMatches)

NoBigMatches extract_probation(NoBigMatches L, header_slimsort.Table_DID_OnProbation R ) := transform
	self := L;
end;

dist2 := join(group(NoBigMatches),header_slimsort.Table_DID_OnProbation, left.did = right.did,
		extract_probation(LEFT,RIGHT),left only,hash);

dist := DISTRIBUTE(dist2, HASH((QSTRING)(lname), (QSTRING)(tf(fname)[1]),(INTEGER)zip));

		
export name_zip_age_ssn4 := dist : PERSIST('headerbuild_hss_name_zip_age_ssn4');
