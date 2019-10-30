export mac_xlinking_on_roxie_withinDistance_custom (infile,Input_UniqueID,Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
																							Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',
																							Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',
																							Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
																							Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
																							Input_SOURCE_RID = '',OutFile, Input_IDL = '', Match_Records = false, Full_Match = false, score = 45, distance = 0,Max_ID = 10) := MACRO

#uniquename(in_score)
%in_score% := score;
#uniquename(in_distance)
%in_distance% := distance;

#uniquename(into)
Health_Provider_Services.Process_xLNPID_Layouts.InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := (typeof(SELF.uniqueId))le.Input_UniqueID;
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
    SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
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
  #IF ( #TEXT(Input_IDL) <> '' )
    self.ENTERED_LNPID := (typeof(SELF.ENTERED_LNPID))le.Input_IDL;

  #ELSE
    self.ENTERED_LNPID := (typeof(SELF.ENTERED_LNPID))'';
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
	self.MatchRecords := match_Records;
	self.fullMatch    := full_match;
	self.maxids 			:= IF (Max_ID > 0, Max_ID, 10);
	self := [];
END;

#uniquename(c0)
%c0% := record
	integer uniqueId;
	integer weight;	
	unsigned8 lnpid;
	string40 vendor_id;
	string2	src;
	unsigned8 did;
	boolean is_state_sanction;
	boolean is_oig_sanction;
	boolean is_opm_sanction;
	unsigned4 KeysFailed;
	unsigned4 global_sid;
end;

#uniquename(pr)
%pr% := project(infile,%into%(left)); // Into roxie input format
#uniquename(res_out)
// output (%pr%);
%res_out% := project(Health_Provider_Services.MEOW_xLNPID(%pr%,true).Data_,transform(%c0%, self.global_sid := left.cnp_classid; self := left;));
// output (%res_out%);
#uniquename(res_out_trim)
%res_out_trim% := sort(dedup(%res_out%, uniqueId, lnpid, weight), uniqueId, -weight);

// Added code to return multiple groups within distance
#uniquename(r0)
%r0% := record
	integer uniqueId;
	unsigned8 lnpid;
	integer weight;
end;

#uniquename(r1)
%r1% := record
	unsigned8 lnpid;
	integer weight;
end;

#uniquename(r2)
%r2% := record
	integer uniqueId;
	dataset(%r1%) DIDs {MAXCOUNT(100)};
end;

#uniquename(g1)
%g1% := group(sort(project(%res_out_trim%,%r0%), uniqueId, lnpid, weight), uniqueId,lnpid);

#uniquename(xform)
%r2% %xform%(recordof(%g1%) l, dataset(recordof(%g1%)) allRows) := transform
	maxScore := max(allrows, weight);
	self.uniqueId 	:= l.uniqueId;
	self.DIDs				:= choosen(PROJECT(allRows(weight >= %in_score% and weight >= (maxScore - %in_distance%)), %r1%), 100);
end;
#uniquename(res)
%res% := rollup(%g1%, group, %xform%(left, rows(left)));

#uniquename(xform1)
%r0% %xform1%(recordof(%res%) l, integer c) := transform
	self.uniqueId := l.uniqueId;
	self.lnpid := l.DIDs[c].lnpid;
	self.weight := l.DIDs[c].weight;
end;
#uniquename(res1)
%res1% := sort(normalize(%res%, count(left.dids), %xform1%(left, counter)), -weight);
#uniquename(res2)
%res2% := dedup(sort(join(%res_out%, %res1%, left.uniqueid = right.uniqueid and left.lnpid = right.lnpid and left.weight = right.weight),uniqueid,lnpid,src,vendor_id,-weight),uniqueid,lnpid,src,vendor_id);
#uniquename(res4)
%res4% := join(%res2%, AppendProviderAttributes.Key_Provider_Attributes_V3, KEYED(left.lnpid = right.lnpid),transform(recordof(%res2%), self.did := right.lexid; self := left;),left outer);
// output (%res2%);
#uniquename(res3)
%res3% := %res_out% (lnpid = 0);
// output (%res3%);
outfile := if (exists(%res3%),sort(%res4% + %res3%,uniqueid,lnpid,src,vendor_id),%res4%);
endmacro;