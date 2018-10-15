//*
// Returns the LexID for each record in the infile
// The field names in the infile are passed by parameter in this macro.

export mac_xlinking_on_roxie(infile, IDL ='', Input_SNAME = '', Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_Gender = '', Input_Derived_Gender = '',
														Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',
														Input_DOB = '', Input_Phone= '', Input_DL_STATE = '',Input_DL_NBR = '', 
														outfile, weight_score = 30, Distance = 3, Segmentation = true, Input_RelFname = '', Input_RelLname = '', DisableDobForce = 'InsuranceHeader_xLink.Config.DOB_NotUseForce') := MACRO

IMPORT InsuranceHeader_xLink;

#UNIQUENAME(hasUniqueId)
	ut.hasField(infile, UniqueId, %hasUniqueId%);
	
	#uniquename(layout_seq)
	%layout_seq% := record
		#IF (~%hasUniqueID%) unsigned6 UniqueID; #END
		recordof(infile);
	end;

	#uniquename(assignSeq)
	%layout_seq% %AssignSeq%(infile l, unsigned6 cnt) := transform
		self.uniqueID := #IF (%hasUniqueID%) l.uniqueID; #ELSE cnt; #END
		self := l;
	end;

#uniquename(infile_seq)
%infile_seq% := project(infile, %AssignSeq%(left, counter));

#uniquename(into)
IDLExternalLinking.xIDLConstants.in_new_layout %into%(%infile_seq% le) := transform
  self.UniqueId := le.uniqueId;
  #IF ( #TEXT(Input_SNAME) <> '' )
    self.SNAME := (typeof(SELF.SNAME))le.Input_SNAME;
  #ELSE
    self.SNAME := (typeof(SELF.SNAME))'';
  #END
  #IF ( #TEXT(Input_FNAME) <> '' )
    self.FNAME := (typeof(SELF.FNAME))le.Input_FNAME;
  #ELSE
    self.FNAME := (typeof(SELF.FNAME))'';
  #END
  #IF ( #TEXT(Input_MNAME) <> '' )
    self.MNAME := (typeof(SELF.MNAME))le.Input_MNAME;
  #ELSE
    self.MNAME := (typeof(SELF.MNAME))'';
  #END
  #IF ( #TEXT(Input_LNAME) <> '' )
    self.LNAME := (typeof(SELF.LNAME))le.Input_LNAME;
  #ELSE
    self.LNAME := (typeof(SELF.LNAME))'';
  #END
  #IF ( #TEXT(Input_GENDER) <> '' )
    self.DERIVED_GENDER := (typeof(SELF.DERIVED_GENDER))le.Input_GENDER;
  #ELSEIF ( #TEXT(Input_DERIVED_GENDER) <> '' )
		self.DERIVED_GENDER := (typeof(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
	#ELSE
		self.DERIVED_GENDER := (typeof(SELF.DERIVED_GENDER))'';
  #END  
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    self.PRIM_NAME := (typeof(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    self.PRIM_NAME := (typeof(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    self.PRIM_RANGE := (typeof(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    self.PRIM_RANGE := (typeof(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    self.SEC_RANGE := (typeof(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    self.SEC_RANGE := (typeof(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_CITY) <> '' )
    self.CITY := (typeof(SELF.CITY))le.Input_CITY;
  #ELSE
    self.CITY := (typeof(SELF.CITY))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    self.ST := (typeof(SELF.ST))le.Input_ST;
  #ELSE
    self.ST := (typeof(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    self.ZIP_cases := Dataset([{le.Input_Zip, 100}],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases) ;
  #ELSE
    self.ZIP_cases := Dataset([],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases) ;
  #END
  #IF ( #TEXT(Input_SSN) <> '' )
    self.SSN5 := InsuranceHeader_xLink.mod_SSNParse(le.Input_SSN).ssn5;
		self.SSN4 := InsuranceHeader_xLink.mod_SSNParse(le.Input_SSN).ssn4;
  #ELSE
    self.SSN5 := '';
		SELF.SSN4 := '';
  #END
  #IF ( #TEXT(Input_DOB) <> '' )
    self.DOB := (typeof(SELF.DOB))le.Input_DOB;
  #ELSE
    self.DOB := (typeof(SELF.DOB))'';
  #END
	 #IF ( #TEXT(Input_PHONE) <> '' )
    self.PHONE := (typeof(SELF.PHONE))le.Input_PHONE;
  #ELSE
    self.PHONE := (typeof(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_DL_STATE) <> '' )
    self.DL_STATE := (typeof(SELF.DL_STATE))le.Input_DL_STATE;
  #ELSE
    self.DL_STATE := (typeof(SELF.DL_STATE))'';
  #END
  #IF ( #TEXT(Input_DL_NBR) <> '' )
    self.DL_NBR := (typeof(SELF.DL_NBR))le.Input_DL_NBR;
  #ELSE
    self.DL_NBR := (typeof(SELF.DL_NBR))'';
  #END  
	#IF ( #TEXT(Input_RelFname) <> '' )
		self.fname2 := (typeof(SELF.fname2))le.Input_RelFname;
  #ELSE
    self.fname2 := (typeof(SELF.fname2))'';
  #END
	#IF ( #TEXT(Input_RelLname) <> '' )
		self.lname2 := (typeof(SELF.lname2))le.Input_RelLname;
  #ELSE
    self.lname2 := (typeof(SELF.lname2))'';
  #END		
  self.SRC := (typeof(SELF.SRC))'';
  self.SOURCE_RID := (typeof(SELF.SOURCE_RID))'';  
	self.MaxIDs := IDLExternalLinking.Constants.max_idls,
	SELF.disableForce := DisableDobForce;
	self := [];
end;
#uniquename(pr)
  %pr% := project(%infile_seq%,%into%(left)); // Into roxie input format
#uniquename(res_out)
	%res_out% := InsuranceHeader_xLink.MEOW_xIDL(%pr%).Raw_Results;
	// InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch(%pr%, UniqueId,SNAME, fname, mname, lname, derived_gender, 
																// prim_range, prim_name, SEC_RANGE, CITY, ST, ZIP,																
																// SSN5, SSN4, DOB, PHONE, DL_STATE, DL_NBR,
																// , , ,%res_out%, true);

	#UNIQUENAME(result_trim)
	IDLExternalLinking.mac_trim_xidl_layout(%res_out%, %result_trim%, UniqueId);
	// IDLExternalLinking.mac_trim_xidl_layout(%res_out%, %result_trim%, reference);

// select a DID base only on distance and make sure the score is 75 or greater	
	#UNIQUENAME(trimLayout)
	%trimLayout% := recordof(%result_trim%);
	
	#UNIQUENAME(resultsDistance)
	IDLExternalLinking.mac_distance (%result_trim%, %resultsDistance%, weight_score, distance)
	
	#UNIQUENAME(forSegmentation)
	%forSegmentation% := %resultsDistance%(xIDL=0);
	
	#UNIQUENAME(resultsSeg)
	IDLExternalLinking.mac_segmentation(%forSegmentation%, %resultsSeg%, weight_score, distance);

	#UNIQUENAME(isCustomerTest)
	%isCustomerTest% := IDLExternalLinking.Constants.isCustomerTest;
	
	#UNIQUENAME(result)
	%result% := IF (segmentation and ~%isCustomerTest%, %resultsDistance%(xIDL>0) + %resultsSeg%, %resultsDistance%); 
	
	// Prepare to return results for one DID only
	#UNIQUENAME(resultsLayout)
	%resultsLayout% := RECORDOF(%result%.results);	
	
	#UNIQUENAME(file_out_final)	
	IDLExternalLinking.mac_score(%result%, %file_out_final%, weight_score, distance);
	
	/*****************************************/

	#UNIQUENAME(flatResult)
	%resultsLayout% %flatResult%(%file_out_final% L, %resultsLayout% R):=TRANSFORM									
			res := project(r, TRANSFORM(%resultsLayout%, 
					SELF := LEFT));
			SELF.reference := l.reference;					
		  SELF :=res;			
	END;
	
	#UNIQUENAME(allCandidates)
	%allCandidates% := DEDUP(NORMALIZE(%file_out_final%,LEFT.results,%flatResult%(LEFT, RIGHT)), RECORD, ALL);
	
	OutFile := %allCandidates%;
// output(%infile_seq%, named('withseq'));
// output(%pr%, named('internal_layout'));
// output(%res_out%, named('result_from_service'));
// output(%result_trim%, named('result_trim'));
// output(%resultsDistance%, named('resultsDistance'));
// output(%resultsSeg%, named('resultsSeg'));		
// output(%result%, named('result'));
// output(%file_out_final%, named('file_out_final'));
// output(%allCandidates%, named('allCandidates'));
ENDMACRO;