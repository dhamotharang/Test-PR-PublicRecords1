IMPORT AutoStandardI;

// Create a master module of all the penalty paramters
globalMod := AutoStandardI.GlobalModule();

lBatchIn := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon  := PhoneFinder_Services.Layouts.PhoneFinder.Common;

EXPORT GetPenalty :=
MODULE

	// Penalty for address
	EXPORT GetAddrPenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING2  predir          := pfCommon.batch_in.predir;
			EXPORT STRING10 prim_range      := pfCommon.batch_in.prim_range;
			EXPORT STRING28 prim_name       := pfCommon.batch_in.prim_name;
			EXPORT STRING2  postdir         := pfCommon.batch_in.postdir;
			EXPORT STRING4  suffix          := pfCommon.batch_in.addr_suffix;
			EXPORT STRING8  sec_range       := pfCommon.batch_in.sec_range;
			EXPORT STRING25 city            := pfCommon.batch_in.p_city_name;
			EXPORT STRING2  st              := pfCommon.batch_in.st;
			EXPORT STRING5  z5              := pfCommon.batch_in.z5;
			EXPORT STRING   city_field      := pfCommon.city_name;
			EXPORT STRING   pname_field     := pfCommon.prim_name;
			EXPORT STRING   postdir_field   := pfCommon.postdir;
			EXPORT STRING   prange_field    := pfCommon.prim_range;
			EXPORT STRING   predir_field    := pfCommon.predir;
			EXPORT STRING   state_field     := pfCommon.st;
			EXPORT STRING   suffix_field    := pfCommon.suffix;
			EXPORT STRING   zip_field       := pfCommon.zip;
			EXPORT STRING   sec_range_field := pfCommon.sec_range;
			EXPORT BOOLEAN  allow_wildcard  := FALSE;
			EXPORT STRING   city2_field     := '';
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_Addr.full));
	END;
	
	// Penalty for name
	EXPORT GetNamePenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING30 FirstName      := pfCommon.batch_in.name_first;
			EXPORT STRING30 MiddleName     := pfCommon.batch_in.name_middle;
			EXPORT STRING30 LastName       := pfCommon.batch_in.name_last;
			EXPORT STRING   fname_field    := pfCommon.fname;
			EXPORT STRING   mname_field    := pfCommon.mname;
			EXPORT STRING   lname_field    := pfCommon.lname;
			EXPORT BOOLEAN  allow_wildcard := FALSE;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full));
	END;
	
	// Penalty for phone
	EXPORT GetPhonePenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING15 phone       := pfCommon.batch_in.homephone;
			EXPORT STRING   phone_field := (STRING)pfCommon.phone;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Phone.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_Phone.full));
	END;
	
	// Penalty for DID
	EXPORT GetDIDPenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING14 did       := (STRING)pfCommon.batch_in.orig_did;
			EXPORT STRING   did_field := (STRING)pfCommon.did;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_DID.full));
	END;
	
	// Penalty for DOB
	EXPORT GetDOBPenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT UNSIGNED8 dob       := (UNSIGNED)pfCommon.batch_in.dob;
			EXPORT STRING    dob_field := (STRING)pfCommon.dob;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_DOB.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_DOB.full));
	END;
	
	// Penalty for SSN
	EXPORT GetSSNPenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING11 ssn       := pfCommon.batch_in.ssn;
			EXPORT STRING   ssn_field := pfCommon.ssn;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_SSN.full));
	END;
	
	// Penalty for county
	EXPORT GetcountyPenalty(lCommon pfCommon) :=
	FUNCTION
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING30 county       := '';
			EXPORT STRING   county_field := pfCommon.county_name;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_county.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_county.full));
	END;

END;