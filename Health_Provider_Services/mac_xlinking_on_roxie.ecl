export mac_xlinking_on_roxie(infile,idl = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
															Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',
															Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
															Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
															Input_SOURCE_RID = '',OutFile, score = 45) := MACRO

#uniquename(layout_seq)
%layout_seq% := record
	unsigned4 uniqueID;
	recordof(infile);
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned4 cnt) := transform
	self.uniqueID := cnt;
	self := l;
end;

#uniquename(infile_seq)
%infile_seq% := project(infile, %AssignSeq%(left, counter));

#uniquename(into)
Health_Provider_Services.Process_xLNPID_Layouts.InputLayout %into%(%infile_seq% le) := TRANSFORM
  SELF.UniqueId := le.uniqueId;
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
  #IF ( #TEXT(Input_SNAME) <> '' )
    SELF.SNAME := (TYPEOF(SELF.SNAME))Health_Provider_Services.fn_clean_suffix(le.Input_SNAME);
  #ELSE
    SELF.SNAME := (TYPEOF(SELF.SNAME))'';
  #END
  #IF ( #TEXT(Input_GENDER) <> '' )
    SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
  #ELSE
    SELF.GENDER := (TYPEOF(SELF.GENDER))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
  #ELSE
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))'';
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
    SELF.SSN := (TYPEOF(SELF.SSN))le.Input_SSN;
  #ELSE
    SELF.SSN := (TYPEOF(SELF.SSN))'';
  #END
  #IF ( #TEXT(Input_CNSMR_SSN) <> '' )
    SELF.CNSMR_SSN := (TYPEOF(SELF.CNSMR_SSN))le.Input_SSN;
  #ELSE
    SELF.CNSMR_SSN := (TYPEOF(SELF.CNSMR_SSN))'';
  #END
  #IF ( #TEXT(Input_DOB) <> '' )
    SELF.DOB := (TYPEOF(SELF.DOB))le.Input_DOB;
  #ELSE
    SELF.DOB := (TYPEOF(SELF.DOB))'';
  #END
  #IF ( #TEXT(Input_CNSMR_DOB) <> '' )
    SELF.CNSMR_DOB := (TYPEOF(SELF.CNSMR_DOB))le.Input_DOB;
  #ELSE
    SELF.CNSMR_DOB := (TYPEOF(SELF.CNSMR_DOB))'';
  #END
  #IF ( #TEXT(Input_PHONE) <> '' )
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.Input_PHONE;
  #ELSE
    SELF.PHONE := (TYPEOF(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_LIC_STATE) <> '' )
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
  #ELSE
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))'';
  #END
  #IF ( #TEXT(Input_C_LIC_NBR) <> '' )
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))le.Input_C_LIC_NBR;
  #ELSE
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))'';
  #END
  #IF ( #TEXT(Input_TAX_ID) <> '' )
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))le.Input_TAX_ID;
  #ELSE
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))'';
  #END
  #IF ( #TEXT(Input_BILLING_TAX_ID) <> '' )
    SELF.BILLING_TAX_ID := (TYPEOF(SELF.BILLING_TAX_ID))le.Input_TAX_ID;
  #ELSE
    SELF.BILLING_TAX_ID := (TYPEOF(SELF.BILLING_TAX_ID))'';
  #END
  #IF ( #TEXT(Input_DEA_NUMBER) <> '' )
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))le.Input_DEA_NUMBER;
  #ELSE
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))'';
  #END
  #IF ( #TEXT(Input_VENDOR_ID) <> '' )
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))le.Input_VENDOR_ID;
  #ELSE
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))'';
  #END
  #IF ( #TEXT(Input_NPI_NUMBER) <> '' )
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))le.Input_NPI_NUMBER;
  #ELSE
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))'';
  #END
  #IF ( #TEXT(Input_BILLING_NPI_NUMBER) <> '' )
    SELF.BILLING_NPI_NUMBER := (TYPEOF(SELF.BILLING_NPI_NUMBER))le.Input_NPI_NUMBER;
  #ELSE
    SELF.BILLING_NPI_NUMBER := (TYPEOF(SELF.BILLING_NPI_NUMBER))'';
  #END
  #IF ( #TEXT(Input_UPIN) <> '' )
    SELF.UPIN := (TYPEOF(SELF.UPIN))le.Input_UPIN;
  #ELSE
    SELF.UPIN := (TYPEOF(SELF.UPIN))'';
  #END
  #IF ( #TEXT(Input_DID) <> '' )
    SELF.DID := (TYPEOF(SELF.DID))le.Input_DID;
  #ELSE
    SELF.DID := (TYPEOF(SELF.DID))'';
  #END
  #IF ( #TEXT(Input_BDID) <> '' )
    SELF.BDID := (TYPEOF(SELF.BDID))le.Input_BDID;
  #ELSE
    SELF.BDID := (TYPEOF(SELF.BDID))'';
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
  #IF ( #TEXT(Input_RID) <> '' )
    SELF.RID := (TYPEOF(SELF.RID))'';
  #ELSE
    SELF.RID := (TYPEOF(SELF.RID))'';
  #END
  #IF ( #TEXT(Input_MAINNAME) <> '' )
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))'';
  #ELSE
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))'';
  #END
  #IF ( #TEXT(Input_FULLNAME) <> '' )
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))'';
  #ELSE
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))'';
  #END
  #IF ( #TEXT(Input_ADDR1) <> '' )
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
  #ELSE
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
  #END
  #IF ( #TEXT(Input_LOCALE) <> '' )
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
  #ELSE
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
  #END
  #IF ( #TEXT(Input_ADDRESS) <> '' )
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))'';
  #ELSE
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))'';
  #END
END;

#uniquename(pr)
%pr% := PROJECT(%infile_seq%,%into%(LEFT)); // Into roxie input format
// output (%pr%);
#uniquename(res_out)
%res_out% := Health_Provider_Services.MEOW_xLNPID (%pr%).Raw_Results;
// output (%res_out%);

#uniquename(layout_ref)
%layout_ref% := record
	unsigned8 uniqueID;
	unsigned8 lnpid;
	unsigned3	weight;
	UNSIGNED4 keys_tried;
	UNSIGNED2	best_criteria;
end;

#uniquename(getLNPID)
%layout_ref% %getLNPID% (recordof(%res_out%) l, INTEGER C) := transform,skip (l.Results[c].weight < 25)
	self.uniqueID				:= l.uniqueid;
	self.weight					:= l.Results[c].weight;
	self.keys_tried			:= l.Results[c].keys_used;
	name_weight					:= l.Results[c].fnameweight + l.Results[c].mnameweight + l.Results[c].lnameweight + l.Results[c].snameweight;
	mainname_weight			:= if (l.Results[c].mainnameweight > l.Results[c].fullnameweight,l.Results[c].mainnameweight,l.Results[c].fullnameweight);
	name_score					:= map (mainname_weight > 0 and name_weight > 0 and mainname_weight >= name_weight => mainname_weight, 
															mainname_weight > 0 and name_weight > 0 and mainname_weight <  name_weight => name_weight,0);
	address_score       := if (name_score > 0, l.Results[c].PRIM_RANGEWeight + l.Results[c].PRIM_NameWeight + l.Results[c].Sec_RANGEWeight + l.Results[c].V_CITY_NAMEWeight + l.Results[c].STWeight + l.Results[c].ZIPWeight,0);
  dob_score           := map (name_score > 0 and l.Results[c].DOBWeight > 0 and l.Results[c].DOBWeight > l.Results[c].CNSMR_DOBWeight => l.Results[c].DOBWeight, 
                              name_score > 0 and l.Results[c].CNSMR_DOBWeight > 0 => l.Results[c].CNSMR_DOBWeight,0);
	lic_score 					:= map (name_score > 0 and l.Results[c].C_LIC_NBRWeight > 0 => l.Results[c].C_LIC_NBRWeight, 0);
	npi_score						:= map (name_score > 0 and l.Results[c].NPI_NUMBERWeight > 0 => l.Results[c].NPI_NUMBERWeight, 0);
	dea_score						:= map (name_score > 0 and l.Results[c].DEA_NUMBERWeight > 0 => l.Results[c].DEA_NUMBERWeight, 0);
	tax_score						:= map (name_score > 0 and l.Results[c].BILLING_TAX_IDWeight > 0 => l.Results[c].BILLING_TAX_IDWeight, 0);
	ssn_score						:= map (name_score > 0 and l.Results[c].SSNWeight > 0 => l.Results[c].SSNWeight, 0);
	upin_score					:= map (name_score > 0 and l.Results[c].UPINWeight > 0 => l.Results[c].UPINWeight, 0);
	self.best_criteria	:= map (l.Results[c].weight >= score => name_score + dob_score + lic_score + address_score + npi_score + dea_score + tax_score + ssn_score + upin_score, 
															0);
	self.lnpid					:= l.Results[c].lnpid;
end;

#uniquename(lnpid_file)
%lnpid_file% := normalize (%res_out%,min(count(LEFT.Results),50),%getLNPID%(LEFT,COUNTER));

#uniquename(best_lnpid)
%best_lnpid% := dedup(sort(%lnpid_file%,uniqueID,-best_criteria, -weight),uniqueID);

#uniquename(assignLNPID)
recordof(infile) %assignLNPID% (%infile_seq% l, %best_lnpid% r) := transform
	self.idl	:= if(r.weight >= score,r.lnpid, 0);
	self 			:= l;
	self := [];
end;

outfile := join(%infile_seq%, %best_lnpid%, left.uniqueid = right.uniqueid, %assignLNPID% (left, right), left outer);
endmacro;