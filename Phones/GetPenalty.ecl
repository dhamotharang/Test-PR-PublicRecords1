IMPORT AutoStandardI;

EXPORT GetPenalty :=
MODULE

	// Penalty for address
	EXPORT GetAddrPenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(AutoStandardI.GlobalModule()),VIRTUAL
			EXPORT STRING2  predir          := pRow.batch_in.predir;
			EXPORT STRING10 prim_range      := pRow.batch_in.prim_range;
			EXPORT STRING28 prim_name       := pRow.batch_in.prim_name;
			EXPORT STRING2  postdir         := pRow.batch_in.postdir;
			EXPORT STRING4  suffix          := pRow.batch_in.addr_suffix;
			EXPORT STRING8  sec_range       := pRow.batch_in.sec_range;
			EXPORT STRING25 city            := pRow.batch_in.p_city_name;
			EXPORT STRING2  st              := pRow.batch_in.st;
			EXPORT STRING5  z5              := pRow.batch_in.z5;
			EXPORT STRING   city_field      := pRow.city_name;
			EXPORT STRING   pname_field     := pRow.prim_name;
			EXPORT STRING   postdir_field   := pRow.postdir;
			EXPORT STRING   prange_field    := pRow.prim_range;
			EXPORT STRING   predir_field    := pRow.predir;
			EXPORT STRING   state_field     := pRow.st;
			EXPORT STRING   suffix_field    := pRow.suffix;
			EXPORT STRING   zip_field       := pRow.zip;
			EXPORT STRING   sec_range_field := pRow.sec_range;
			EXPORT BOOLEAN  allow_wildcard  := FALSE;
			EXPORT STRING   city2_field     := '';
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_Addr.full));
	ENDMACRO;
	
	// Penalty for name
	EXPORT GetNamePenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(AutoStandardI.GlobalModule()),VIRTUAL
			EXPORT STRING30 FirstName      := pRow.batch_in.name_first;
			EXPORT STRING30 MiddleName     := pRow.batch_in.name_middle;
			EXPORT STRING30 LastName       := pRow.batch_in.name_last;
			EXPORT STRING   fname_field    := pRow.fname;
			EXPORT STRING   mname_field    := pRow.mname;
			EXPORT STRING   lname_field    := pRow.lname;
			EXPORT BOOLEAN  allow_wildcard := FALSE;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full));
	ENDMACRO;
	
	// Penalty for phone
	EXPORT GetPhonePenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(AutoStandardI.GlobalModule()),VIRTUAL
			EXPORT STRING15 phone       := pRow.batch_in.homephone;
			EXPORT STRING   phone_field := (STRING)pRow.phone;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_Phone.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_Phone.full));
	ENDMACRO;
	
	// Penalty for DID
	EXPORT GetDIDPenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(globalMod),VIRTUAL
			EXPORT STRING14 did       := (STRING)pRow.batch_in.orig_did;
			EXPORT STRING   did_field := (STRING)pRow.did;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_DID.full));
	ENDMACRO;
	
	// Penalty for DOB
	EXPORT GetDOBPenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(AutoStandardI.GlobalModule()),VIRTUAL
			EXPORT UNSIGNED8 dob       := (UNSIGNED)pRow.batch_in.dob;
			EXPORT STRING    dob_field := (STRING)pRow.dob;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_DOB.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_DOB.full));
	ENDMACRO;
	
	// Penalty for SSN
	EXPORT GetSSNPenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(AutoStandardI.GlobalModule()),VIRTUAL
			EXPORT STRING11 ssn       := pRow.batch_in.ssn;
			EXPORT STRING   ssn_field := pRow.ssn;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_SSN.full));
	ENDMACRO;
	
	// Penalty for county
	EXPORT GetcountyPenalty(pRow) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI;
		
		tempMod := MODULE(AutoStandardI.GlobalModule()),VIRTUAL
			EXPORT STRING30 county       := '';
			EXPORT STRING   county_field := pRow.county_name;
		END;
		
		RETURN AutoStandardI.LIBCALL_PenaltyI_county.val(PROJECT(tempMod,AutoStandardI.LIBIN.PenaltyI_county.full));
	ENDMACRO;

END;