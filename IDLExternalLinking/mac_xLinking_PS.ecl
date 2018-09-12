﻿/* this is the low level interface to SALT for Person Search queries */
EXPORT mac_xLinking_PS (infile, uID ='', Input_SNAME = '', Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_Gender = '', Input_Derived_Gender = '',
														Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',
														Input_DOB = '', Input_Phone = '', Input_DL_STATE = '',Input_DL_NBR = '', 
														Input_RelFname = '', Input_RelLname = '', outfile) := MACRO

	IMPORT InsuranceHeader_xLink;

	#UNIQUENAME(into)
	IDLExternalLinking.xIDLConstants.in_new_layout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.uId;
  #IF ( #TEXT(Input_SNAME) <> '' )
    SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
  #ELSE
    SELF.SNAME := (TYPEOF(SELF.SNAME))'';
  #END
  #IF ( #TEXT(Input_FNAME) <> '' )
    SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
  #ELSE
    SELF.FNAME := (TYPEOF(SELF.FNAME))'';
  #END
  #IF ( #TEXT(Input_MNAME) <> '' )
    SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
  #ELSE
    SELF.MNAME := (TYPEOF(SELF.MNAME))'';
  #END
  #IF ( #TEXT(Input_LNAME) <> '' )
    SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
  #ELSE
    SELF.LNAME := (TYPEOF(SELF.LNAME))'';
  #END
  #IF ( #TEXT(Input_GENDER) <> '' )
    SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_GENDER;
  #ELSEIF ( #TEXT(Input_DERIVED_GENDER) <> '' )
		SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
	#ELSE
		SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))'';
  #END  
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_CITY) <> '' )
    SELF.CITY := (TYPEOF(SELF.CITY))le.Input_CITY;
  #ELSE
    SELF.CITY := (TYPEOF(SELF.CITY))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
    SELF.ST := (TYPEOF(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP_cases := le.Input_ZIP;
  #ELSE
    SELF.ZIP_cases := DATASET([],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases);
  #END
  #IF ( #TEXT(Input_SSN) <> '' )
    SELF.SSN5 := InsuranceHeader_xLink.mod_SSNParse(le.Input_SSN).ssn5;
		SELF.SSN4 := InsuranceHeader_xLink.mod_SSNParse(le.Input_SSN).ssn4;
  #ELSE
    SELF.SSN5 := '';
		SELF.SSN4 := '';
  #END
  #IF ( #TEXT(Input_DOB) <> '' )
    SELF.DOB := (TYPEOF(SELF.DOB))le.Input_DOB;
  #ELSE
    SELF.DOB := (TYPEOF(SELF.DOB))'';
  #END
	 #IF ( #TEXT(Input_PHONE) <> '' )
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.Input_PHONE;
  #ELSE
    SELF.PHONE := (TYPEOF(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_DL_STATE) <> '' )
    SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))le.Input_DL_STATE;
  #ELSE
    SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))'';
  #END
  #IF ( #TEXT(Input_DL_NBR) <> '' )
    SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))le.Input_DL_NBR;
  #ELSE
    SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))'';
  #END  
	#IF ( #TEXT(Input_RelFname) <> '' )
		SELF.fname2 := (TYPEOF(SELF.fname2))le.Input_RelFname;
  #ELSE
    SELF.fname2 := (TYPEOF(SELF.fname2))'';
  #END
	#IF ( #TEXT(Input_RelLname) <> '' )
		SELF.lname2 := (TYPEOF(SELF.lname2))le.Input_RelLname;
  #ELSE
    SELF.lname2 := (TYPEOF(SELF.lname2))'';
  #END		
  SELF.SRC := (TYPEOF(SELF.SRC))'';
  SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))'';  
	SELF.disableForce := true;  //Person Search requires no DobForce for higher recall
	SELF.MaxIDs := 200,	
	SELF := [];
end;
#uniquename(pr)
  %pr% := project(infile,%into%(left)); // Into roxie input format
#uniquename(res_out)
// Call with 10K Limit - specific for Person Search queries
	%res_out% := InsuranceHeader_xLink.MEOW_xIDL(%pr%, , , 10000).Raw_Results;
	
	// InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch(%pr%, UniqueId,SNAME, fname, mname, lname, derived_gender, 
																// prim_range, prim_name, SEC_RANGE, CITY, ST, ZIP,																
																// SSN5, SSN4, DOB, PHONE, DL_STATE, DL_NBR,
																// , , , fname2, lname2, %res_out%, true, , , ,10000);
	
	// Prepare to return results for one DID only
	#UNIQUENAME(resultsLayout)
	%resultsLayout% := RECORDOF(%res_out%.results);	

	#UNIQUENAME(flatResult)
	%resultsLayout% %flatResult%(%res_out% L, %resultsLayout% R):=TRANSFORM									
			res := project(r, TRANSFORM(%resultsLayout%, 
					SELF := LEFT));
				SELF.reference := l.uniqueid;					
			// SELF.reference := l.reference;					
		  SELF :=res;			
	END;
	
	#UNIQUENAME(allCandidates)
	%allCandidates% := DEDUP(NORMALIZE(%res_out%,LEFT.results,%flatResult%(LEFT, RIGHT)), RECORD, ALL);
	
	OutFile := SORT(%allCandidates%, reference, -weight);
// outfile := %res_out%;
// output(%pr%, named('internal_layout'));
// output(%res_out%, named('result_from_service'));
// output(%allCandidates%, named('allCandidates'));
ENDMACRO;														