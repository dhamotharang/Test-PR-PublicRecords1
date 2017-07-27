// Picked from zz_IDLExternalLinking.mac_xlinking_on_roxie

EXPORT MAC_SALT_search(infile, IDL ='', Input_SNAME = '', Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_Gender = '', Input_Derived_Gender = '',
														Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',
														Input_DOB = '', Input_Phone, Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = '',
														outfile, weight_score = 30, Distance = 3, Segmentation = TRUE, allcandidates = FALSE) := MACRO

IMPORT InsuranceHeader_xLink;

#UNIQUENAME(layout_seq)
%layout_seq% := RECORD
	UNSIGNED4 UniqueID;
	RECORDOF(infile);
END;

#UNIQUENAME(assignSeq)
%layout_seq% %AssignSeq%(infile l, UNSIGNED4 cnt) := TRANSFORM
	SELF.uniqueID := cnt;
	SELF := l;
end;

#UNIQUENAME(infile_seq)
%infile_seq% := PROJECT(infile, %AssignSeq%(LEFT, COUNTER));

#UNIQUENAME(into)
InsuranceHeader_xLink.Process_xIDL_Layouts.InputLayout %into%(%infile_seq% le) := TRANSFORM
  SELF.UniqueId := le.uniqueId;
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
    // SELF.GENDER := (TYPEOF(SELF.GENDER))'';
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
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
    SELF.ZIP := (TYPEOF(SELF.ZIP))'';
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
  #IF ( #TEXT(Input_SRC) <> '' )
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
  #ELSE
    SELF.SRC := (TYPEOF(SELF.SRC))'';
  #END
  #IF ( #TEXT(Input_SOURCE_RID) <> '' )
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))le.Input_SOURCE_RID;
  #ELSE
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))'';
  #END
	SELF.MaxIDs := 100, //zz_IDLExternalLinking.Constants.max_idls
	self := [];
end;
#UNIQUENAME(pr)
  %pr% := PROJECT(%infile_seq%,%into%(left)); // Into roxie input format
#UNIQUENAME(res_out)
%res_out% := InsuranceHeader_xLink.MEOW_xIDL(%pr%).Raw_Results;

outfile := %res_out%;

ENDMACRO;