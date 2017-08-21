EXPORT Process_LNPID_Layouts := MODULE
IMPORT SALT27;
SHARED h := File_HealthProvider;//The input file
EXPORT KeyName := '~'+'key::HealthCareProviderHeader::LNPID::meow';
EXPORT Key := INDEX(h,{LNPID},{h},KeyName);
EXPORT BuildAll := SEQUENTIAL(BUILDINDEX(Key, OVERWRITE));
EXPORT id_stream_layout := RECORD
    UNSIGNED4 UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    UNSIGNED8 LNPID;
  END;
EXPORT InputLayout := RECORD
  UNSIGNED4 UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  h.DID;
  h.DOB;
  h.PHONE;
  h.SNAME;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.GENDER;
  h.DERIVED_GENDER;
  h.LIC_NBR;
  h.ADDRESS_ID;
  h.PRIM_NAME;
  h.PRIM_RANGE;
  h.SEC_RANGE;
  h.V_CITY_NAME;
  h.ST;
  h.ZIP;
  h.CNAME;
  h.TAX_ID;
  h.UPIN;
  h.DEA_NUMBER;
  h.VENDOR_ID;
  h.NPI_NUMBER;
  h.DT_FIRST_SEEN;
  h.DT_LAST_SEEN;
  h.DT_LIC_EXPIRATION;
  h.DT_DEA_EXPIRATION;
  SALT27.StrType MAINNAME;//Wordbag field for concept
  SALT27.StrType FULLNAME;//Wordbag field for concept
  SALT27.StrType FULLNAME_DOB;//Wordbag field for concept
  SALT27.StrType ADDR;//Wordbag field for concept
  SALT27.StrType LOCALE;//Wordbag field for concept
  SALT27.StrType ADDRESS;//Wordbag field for concept
  h.LIC_STATE;
  h.SRC;
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show LNPID if it has a record which fully matches
  SALT27.UIDType Entered_RID := 0; // Allow user to enter RID to pull data
  SALT27.UIDType Entered_LNPID := 0; // Allow user to enter LNPID to pull data
END;
// A function to turn data in the input layout function into 'baby' match candidates form
EXPORT InputToMC(DATASET(InputLayout) Inp) := FUNCTION
  r := RECORD
    inp.DID;
    UNSIGNED2 DOB_year := ((UNSIGNED)inp.DOB) DIV 10000;
    UNSIGNED1 DOB_month := (((UNSIGNED)inp.DOB) DIV 100 ) % 100;
    UNSIGNED1 DOB_day := ((UNSIGNED)inp.DOB) % 100;
    inp.PHONE;
    inp.SNAME;
    STRING5 SNAME_NormSuffix := fn_NormSuffix(inp.SNAME);
    inp.FNAME;
    STRING20 FNAME_PreferredName := fn_PreferredName(inp.FNAME);
    inp.MNAME;
    inp.LNAME;
    inp.GENDER;
    inp.DERIVED_GENDER;
    inp.LIC_NBR;
    STRING25 LIC_NBR_CleanLic := fn_cleanlicense(inp.LIC_NBR);
    inp.ADDRESS_ID;
    inp.PRIM_NAME;
    inp.PRIM_RANGE;
    inp.SEC_RANGE;
    inp.V_CITY_NAME;
    inp.ST;
    inp.ZIP;
    inp.CNAME;
    inp.TAX_ID;
    inp.UPIN;
    inp.DEA_NUMBER;
    inp.VENDOR_ID;
    inp.NPI_NUMBER;
    inp.DT_FIRST_SEEN;
    inp.DT_LAST_SEEN;
    inp.DT_LIC_EXPIRATION;
    inp.DT_DEA_EXPIRATION;
    inp.LIC_STATE;
    inp.SRC;
    RID := inp.Entered_RID;
    LNPID := inp.Entered_LNPID;
  END;
  RETURN TABLE(inp,r);
END;
EXPORT HardKeyMatch(InputLayout le) := ;
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.LNPID;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT27.UIDType Reference := 0;//Presently for batch
  SALT27.UIDType RID := 0;
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.DID) DID := (TYPEOF(h.DID))'';
  INTEGER2 DIDWeight := 0;
  UNSIGNED2 DOB_year := 0;
  UNSIGNED1 DOB_month := 0;
  UNSIGNED1 DOB_day := 0;
  INTEGER2 DOBWeight := 0;
  INTEGER2 DOBWeight_year := 0;
  INTEGER2 DOBWeight_month := 0;
  INTEGER2 DOBWeight_day := 0;
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))'';
  INTEGER2 PHONEWeight := 0;
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  INTEGER2 SNAMEWeight := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  INTEGER2 FNAMEWeight := 0;
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  INTEGER2 MNAMEWeight := 0;
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  INTEGER2 LNAMEWeight := 0;
  TYPEOF(h.GENDER) GENDER := (TYPEOF(h.GENDER))'';
  INTEGER2 GENDERWeight := 0;
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  INTEGER2 DERIVED_GENDERWeight := 0;
  TYPEOF(h.LIC_NBR) LIC_NBR := (TYPEOF(h.LIC_NBR))'';
  INTEGER2 LIC_NBRWeight := 0;
  TYPEOF(h.ADDRESS_ID) ADDRESS_ID := (TYPEOF(h.ADDRESS_ID))'';
  INTEGER2 ADDRESS_IDWeight := 0;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  INTEGER2 PRIM_NAMEWeight := 0;
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  INTEGER2 PRIM_RANGEWeight := 0;
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  INTEGER2 SEC_RANGEWeight := 0;
  TYPEOF(h.V_CITY_NAME) V_CITY_NAME := (TYPEOF(h.V_CITY_NAME))'';
  INTEGER2 V_CITY_NAMEWeight := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  INTEGER2 STWeight := 0;
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  INTEGER2 ZIPWeight := 0;
  TYPEOF(h.CNAME) CNAME := (TYPEOF(h.CNAME))'';
  INTEGER2 CNAMEWeight := 0;
  TYPEOF(h.TAX_ID) TAX_ID := (TYPEOF(h.TAX_ID))'';
  INTEGER2 TAX_IDWeight := 0;
  TYPEOF(h.UPIN) UPIN := (TYPEOF(h.UPIN))'';
  INTEGER2 UPINWeight := 0;
  TYPEOF(h.DEA_NUMBER) DEA_NUMBER := (TYPEOF(h.DEA_NUMBER))'';
  INTEGER2 DEA_NUMBERWeight := 0;
  TYPEOF(h.VENDOR_ID) VENDOR_ID := (TYPEOF(h.VENDOR_ID))'';
  INTEGER2 VENDOR_IDWeight := 0;
  TYPEOF(h.NPI_NUMBER) NPI_NUMBER := (TYPEOF(h.NPI_NUMBER))'';
  INTEGER2 NPI_NUMBERWeight := 0;
  TYPEOF(h.DT_FIRST_SEEN) DT_FIRST_SEEN := (TYPEOF(h.DT_FIRST_SEEN))'';
  INTEGER2 DT_FIRST_SEENWeight := 0;
  TYPEOF(h.DT_LAST_SEEN) DT_LAST_SEEN := (TYPEOF(h.DT_LAST_SEEN))'';
  INTEGER2 DT_LAST_SEENWeight := 0;
  TYPEOF(h.DT_LIC_EXPIRATION) DT_LIC_EXPIRATION := (TYPEOF(h.DT_LIC_EXPIRATION))'';
  INTEGER2 DT_LIC_EXPIRATIONWeight := 0;
  TYPEOF(h.DT_DEA_EXPIRATION) DT_DEA_EXPIRATION := (TYPEOF(h.DT_DEA_EXPIRATION))'';
  INTEGER2 DT_DEA_EXPIRATIONWeight := 0;
  SALT27.StrType MAINNAME := ''; // Concepts always a wordbag
  INTEGER2 MAINNAMEWeight := 0;
  SALT27.StrType FULLNAME := ''; // Concepts always a wordbag
  INTEGER2 FULLNAMEWeight := 0;
  SALT27.StrType FULLNAME_DOB := ''; // Concepts always a wordbag
  INTEGER2 FULLNAME_DOBWeight := 0;
  SALT27.StrType ADDR := ''; // Concepts always a wordbag
  INTEGER2 ADDRWeight := 0;
  SALT27.StrType LOCALE := ''; // Concepts always a wordbag
  INTEGER2 LOCALEWeight := 0;
  SALT27.StrType ADDRESS := ''; // Concepts always a wordbag
  INTEGER2 ADDRESSWeight := 0;
  TYPEOF(h.LIC_STATE) LIC_STATE := (TYPEOF(h.LIC_STATE))'';
  INTEGER2 LIC_STATEWeight := 0;
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  INTEGER2 SRCWeight := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
  SELF.DIDWeight := MAX( le.DIDWeight, ri.DIDWeight );
  SELF.DID := IF ( le.DIDWeight>ri.DIDWeight, le.DID, ri.DID );
  SELF.DOBWeight_year := MAX ( le.DOBWeight_year, ri.DOBWeight_year );
  SELF.DOB_year := IF ( le.DOBWeight_year>ri.DOBWeight_year, le.DOB_year, ri.DOB_year );
  SELF.DOBWeight_month := MAX ( le.DOBWeight_month, ri.DOBWeight_month );
  SELF.DOB_month := IF ( le.DOBWeight_month>ri.DOBWeight_month, le.DOB_month, ri.DOB_month );
  SELF.DOBWeight_day := MAX ( le.DOBWeight_day, ri.DOBWeight_day );
  SELF.DOB_day := IF ( le.DOBWeight_day>ri.DOBWeight_day, le.DOB_day, ri.DOB_day );
  SELF.DOBWeight :=  SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day;
  SELF.PHONEWeight := MAX( le.PHONEWeight, ri.PHONEWeight );
  SELF.PHONE := IF ( le.PHONEWeight>ri.PHONEWeight, le.PHONE, ri.PHONE );
  SELF.SNAMEWeight := MAX( le.SNAMEWeight, ri.SNAMEWeight );
  SELF.SNAME := IF ( le.SNAMEWeight>ri.SNAMEWeight, le.SNAME, ri.SNAME );
  SELF.FNAMEWeight := MAX( le.FNAMEWeight, ri.FNAMEWeight );
  SELF.FNAME := IF ( le.FNAMEWeight>ri.FNAMEWeight, le.FNAME, ri.FNAME );
  SELF.MNAMEWeight := MAX( le.MNAMEWeight, ri.MNAMEWeight );
  SELF.MNAME := IF ( le.MNAMEWeight>ri.MNAMEWeight, le.MNAME, ri.MNAME );
  SELF.LNAMEWeight := MAX( le.LNAMEWeight, ri.LNAMEWeight );
  SELF.LNAME := IF ( le.LNAMEWeight>ri.LNAMEWeight, le.LNAME, ri.LNAME );
  SELF.GENDERWeight := MAX( le.GENDERWeight, ri.GENDERWeight );
  SELF.GENDER := IF ( le.GENDERWeight>ri.GENDERWeight, le.GENDER, ri.GENDER );
  SELF.DERIVED_GENDERWeight := MAX( le.DERIVED_GENDERWeight, ri.DERIVED_GENDERWeight );
  SELF.DERIVED_GENDER := IF ( le.DERIVED_GENDERWeight>ri.DERIVED_GENDERWeight, le.DERIVED_GENDER, ri.DERIVED_GENDER );
  SELF.LIC_NBRWeight := MAX( le.LIC_NBRWeight, ri.LIC_NBRWeight );
  SELF.LIC_NBR := IF ( le.LIC_NBRWeight>ri.LIC_NBRWeight, le.LIC_NBR, ri.LIC_NBR );
  SELF.ADDRESS_IDWeight := MAX( le.ADDRESS_IDWeight, ri.ADDRESS_IDWeight );
  SELF.ADDRESS_ID := IF ( le.ADDRESS_IDWeight>ri.ADDRESS_IDWeight, le.ADDRESS_ID, ri.ADDRESS_ID );
  SELF.PRIM_NAMEWeight := MAX( le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  SELF.PRIM_NAME := IF ( le.PRIM_NAMEWeight>ri.PRIM_NAMEWeight, le.PRIM_NAME, ri.PRIM_NAME );
  SELF.PRIM_RANGEWeight := MAX( le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  SELF.PRIM_RANGE := IF ( le.PRIM_RANGEWeight>ri.PRIM_RANGEWeight, le.PRIM_RANGE, ri.PRIM_RANGE );
  SELF.SEC_RANGEWeight := MAX( le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  SELF.SEC_RANGE := IF ( le.SEC_RANGEWeight>ri.SEC_RANGEWeight, le.SEC_RANGE, ri.SEC_RANGE );
  SELF.V_CITY_NAMEWeight := MAX( le.V_CITY_NAMEWeight, ri.V_CITY_NAMEWeight );
  SELF.V_CITY_NAME := IF ( le.V_CITY_NAMEWeight>ri.V_CITY_NAMEWeight, le.V_CITY_NAME, ri.V_CITY_NAME );
  SELF.STWeight := MAX( le.STWeight, ri.STWeight );
  SELF.ST := IF ( le.STWeight>ri.STWeight, le.ST, ri.ST );
  SELF.ZIPWeight := MAX( le.ZIPWeight, ri.ZIPWeight );
  SELF.ZIP := IF ( le.ZIPWeight>ri.ZIPWeight, le.ZIP, ri.ZIP );
  SELF.CNAMEWeight := MAX( le.CNAMEWeight, ri.CNAMEWeight );
  SELF.CNAME := IF ( le.CNAMEWeight>ri.CNAMEWeight, le.CNAME, ri.CNAME );
  SELF.TAX_IDWeight := MAX( le.TAX_IDWeight, ri.TAX_IDWeight );
  SELF.TAX_ID := IF ( le.TAX_IDWeight>ri.TAX_IDWeight, le.TAX_ID, ri.TAX_ID );
  SELF.UPINWeight := MAX( le.UPINWeight, ri.UPINWeight );
  SELF.UPIN := IF ( le.UPINWeight>ri.UPINWeight, le.UPIN, ri.UPIN );
  SELF.DEA_NUMBERWeight := MAX( le.DEA_NUMBERWeight, ri.DEA_NUMBERWeight );
  SELF.DEA_NUMBER := IF ( le.DEA_NUMBERWeight>ri.DEA_NUMBERWeight, le.DEA_NUMBER, ri.DEA_NUMBER );
  SELF.VENDOR_IDWeight := MAX( le.VENDOR_IDWeight, ri.VENDOR_IDWeight );
  SELF.VENDOR_ID := IF ( le.VENDOR_IDWeight>ri.VENDOR_IDWeight, le.VENDOR_ID, ri.VENDOR_ID );
  SELF.NPI_NUMBERWeight := MAX( le.NPI_NUMBERWeight, ri.NPI_NUMBERWeight );
  SELF.NPI_NUMBER := IF ( le.NPI_NUMBERWeight>ri.NPI_NUMBERWeight, le.NPI_NUMBER, ri.NPI_NUMBER );
  SELF.DT_FIRST_SEENWeight := MAX( le.DT_FIRST_SEENWeight, ri.DT_FIRST_SEENWeight );
  SELF.DT_FIRST_SEEN := IF ( le.DT_FIRST_SEENWeight>ri.DT_FIRST_SEENWeight, le.DT_FIRST_SEEN, ri.DT_FIRST_SEEN );
  SELF.DT_LAST_SEENWeight := MAX( le.DT_LAST_SEENWeight, ri.DT_LAST_SEENWeight );
  SELF.DT_LAST_SEEN := IF ( le.DT_LAST_SEENWeight>ri.DT_LAST_SEENWeight, le.DT_LAST_SEEN, ri.DT_LAST_SEEN );
  SELF.DT_LIC_EXPIRATIONWeight := MAX( le.DT_LIC_EXPIRATIONWeight, ri.DT_LIC_EXPIRATIONWeight );
  SELF.DT_LIC_EXPIRATION := IF ( le.DT_LIC_EXPIRATIONWeight>ri.DT_LIC_EXPIRATIONWeight, le.DT_LIC_EXPIRATION, ri.DT_LIC_EXPIRATION );
  SELF.DT_DEA_EXPIRATIONWeight := MAX( le.DT_DEA_EXPIRATIONWeight, ri.DT_DEA_EXPIRATIONWeight );
  SELF.DT_DEA_EXPIRATION := IF ( le.DT_DEA_EXPIRATIONWeight>ri.DT_DEA_EXPIRATIONWeight, le.DT_DEA_EXPIRATION, ri.DT_DEA_EXPIRATION );
  SELF.MAINNAMEWeight := MAX( le.MAINNAMEWeight, ri.MAINNAMEWeight );
  SELF.FULLNAMEWeight := MAX( le.FULLNAMEWeight, ri.FULLNAMEWeight );
  SELF.FULLNAME_DOBWeight := MAX( le.FULLNAME_DOBWeight, ri.FULLNAME_DOBWeight );
  SELF.ADDRWeight := MAX( le.ADDRWeight, ri.ADDRWeight );
  SELF.LOCALEWeight := MAX( le.LOCALEWeight, ri.LOCALEWeight );
  SELF.ADDRESSWeight := MAX( le.ADDRESSWeight, ri.ADDRESSWeight );
  SELF.LIC_STATEWeight := MAX( le.LIC_STATEWeight, ri.LIC_STATEWeight );
  SELF.LIC_STATE := IF ( le.LIC_STATEWeight>ri.LIC_STATEWeight, le.LIC_STATE, ri.LIC_STATE );
  SELF.SRCWeight := MAX( le.SRCWeight, ri.SRCWeight );
  SELF.SRC := IF ( le.SRCWeight>ri.SRCWeight, le.SRC, ri.SRC );
  SELF.LNPID := IF ( le.LNPID=ri.LNPID, le.LNPID, 0 ); // Zero out if collapsing a parent
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.ForceFailed := (SELF.DOBWeight_year<>0 OR SELF.DOBWeight_month<>0 OR SELF.DOBWeight_day<>0) AND SELF.DOBWeight_year + SELF.DOBWeight_month + SELF.DOBWeight_day < 5 OR SELF.SNAMEWeight < 0 OR SELF.FNAMEWeight < 0 OR SELF.DERIVED_GENDERWeight < 0 OR SELF.FULLNAMEWeight < -3 OR SELF.FULLNAME_DOBWeight < 17;
  SELF.Weight := MAX(0,SELF.DIDWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.GENDERWeight) + MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.LIC_NBRWeight) + MAX(0,SELF.ADDRESS_IDWeight) + MAX(0,SELF.CNAMEWeight) + MAX(0,SELF.TAX_IDWeight) + MAX(0,SELF.UPINWeight) + MAX(0,SELF.DEA_NUMBERWeight) + MAX(0,SELF.VENDOR_IDWeight) + MAX(0,SELF.NPI_NUMBERWeight) + MAX(0,SELF.DT_LIC_EXPIRATIONWeight) + MAX(0,SELF.DT_DEA_EXPIRATIONWeight) + MAX(self.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.V_CITY_NAMEWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.LIC_STATEWeight) + MAX(0,SELF.SRCWeight);
  SELF := le;
END;
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN Resolved := FALSE; // certain with 4 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT27.UIDType Reference;
END;
EXPORT MAC_Add_ResolutionFlags() := MACRO
  SELF.Verified := EXISTS(SELF.results);
  SELF.Ambiguous := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) >= 20;
  SELF.ShortList := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) < 20 AND SELF.verified;
  SELF.Handful := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-3)) < 6 AND SELF.verified;
  SELF.Resolved := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-7)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT27.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.DIDWeight=0,'','|'+IF(le.DIDWeight<0,'-','')+'DID')+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day=0,'','|'+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day<0,'-','')+'DOB')+IF(le.PHONEWeight=0,'','|'+IF(le.PHONEWeight<0,'-','')+'PHONE')+IF(le.SNAMEWeight=0,'','|'+IF(le.SNAMEWeight<0,'-','')+'SNAME')+IF(le.FNAMEWeight=0,'','|'+IF(le.FNAMEWeight<0,'-','')+'FNAME')+IF(le.MNAMEWeight=0,'','|'+IF(le.MNAMEWeight<0,'-','')+'MNAME')+IF(le.LNAMEWeight=0,'','|'+IF(le.LNAMEWeight<0,'-','')+'LNAME')+IF(le.GENDERWeight=0,'','|'+IF(le.GENDERWeight<0,'-','')+'GENDER')+IF(le.DERIVED_GENDERWeight=0,'','|'+IF(le.DERIVED_GENDERWeight<0,'-','')+'DERIVED_GENDER')+IF(le.LIC_NBRWeight=0,'','|'+IF(le.LIC_NBRWeight<0,'-','')+'LIC_NBR')+IF(le.ADDRESS_IDWeight=0,'','|'+IF(le.ADDRESS_IDWeight<0,'-','')+'ADDRESS_ID')+IF(le.PRIM_NAMEWeight=0,'','|'+IF(le.PRIM_NAMEWeight<0,'-','')+'PRIM_NAME')+IF(le.PRIM_RANGEWeight=0,'','|'+IF(le.PRIM_RANGEWeight<0,'-','')+'PRIM_RANGE')+IF(le.SEC_RANGEWeight=0,'','|'+IF(le.SEC_RANGEWeight<0,'-','')+'SEC_RANGE')+IF(le.V_CITY_NAMEWeight=0,'','|'+IF(le.V_CITY_NAMEWeight<0,'-','')+'V_CITY_NAME')+IF(le.STWeight=0,'','|'+IF(le.STWeight<0,'-','')+'ST')+IF(le.ZIPWeight=0,'','|'+IF(le.ZIPWeight<0,'-','')+'ZIP')+IF(le.CNAMEWeight=0,'','|'+IF(le.CNAMEWeight<0,'-','')+'CNAME')+IF(le.TAX_IDWeight=0,'','|'+IF(le.TAX_IDWeight<0,'-','')+'TAX_ID')+IF(le.UPINWeight=0,'','|'+IF(le.UPINWeight<0,'-','')+'UPIN')+IF(le.DEA_NUMBERWeight=0,'','|'+IF(le.DEA_NUMBERWeight<0,'-','')+'DEA_NUMBER')+IF(le.VENDOR_IDWeight=0,'','|'+IF(le.VENDOR_IDWeight<0,'-','')+'VENDOR_ID')+IF(le.NPI_NUMBERWeight=0,'','|'+IF(le.NPI_NUMBERWeight<0,'-','')+'NPI_NUMBER')+IF(le.DT_FIRST_SEENWeight=0,'','|'+IF(le.DT_FIRST_SEENWeight<0,'-','')+'DT_FIRST_SEEN')+IF(le.DT_LAST_SEENWeight=0,'','|'+IF(le.DT_LAST_SEENWeight<0,'-','')+'DT_LAST_SEEN')+IF(le.DT_LIC_EXPIRATIONWeight=0,'','|'+IF(le.DT_LIC_EXPIRATIONWeight<0,'-','')+'DT_LIC_EXPIRATION')+IF(le.DT_DEA_EXPIRATIONWeight=0,'','|'+IF(le.DT_DEA_EXPIRATIONWeight<0,'-','')+'DT_DEA_EXPIRATION')+IF(le.MAINNAMEWeight=0,'','|'+IF(le.MAINNAMEWeight<0,'-','')+'MAINNAME')+IF(le.FULLNAMEWeight=0,'','|'+IF(le.FULLNAMEWeight<0,'-','')+'FULLNAME')+IF(le.FULLNAME_DOBWeight=0,'','|'+IF(le.FULLNAME_DOBWeight<0,'-','')+'FULLNAME_DOB')+IF(le.ADDRWeight=0,'','|'+IF(le.ADDRWeight<0,'-','')+'ADDR')+IF(le.LOCALEWeight=0,'','|'+IF(le.LOCALEWeight<0,'-','')+'LOCALE')+IF(le.ADDRESSWeight=0,'','|'+IF(le.ADDRESSWeight<0,'-','')+'ADDRESS')+IF(le.LIC_STATEWeight=0,'','|'+IF(le.LIC_STATEWeight<0,'-','')+'LIC_STATE')+IF(le.SRCWeight=0,'','|'+IF(le.SRCWeight<0,'-','')+'SRC');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  t := TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW);
  RETURN SORT(t,-Cnt);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
  SELF.Results := ri;
  SELF.Reference := le.Reference;
  MAC_Add_ResolutionFlags()
END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),LNPID),LEFT.LNPID=RIGHT.LNPID,Combine_Scores(LEFT,RIGHT))(SALT27.DebugMode OR ~ForceFailed);
  r1 := ROLLUP( TOPN(r0,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT27.MAC_External_AddPcnt(r1,LayoutScoredFetch,OutputLayout_Batch,22,r2);
  RETURN r2;
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT27.UIDType LNPID;
  DATASET(SALT27.Layout_FieldValueList) DID_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) PHONE_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) GENDER_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) DERIVED_GENDER_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) LIC_NBR_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) ADDRESS_ID_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) CNAME_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) TAX_ID_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) UPIN_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) DEA_NUMBER_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) VENDOR_ID_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) NPI_NUMBER_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) DT_LIC_EXPIRATION_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) DT_DEA_EXPIRATION_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) FULLNAME_DOB_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) LIC_STATE_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) SRC_Values := DATASET([],SALT27.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.DID_values := SALT27.fn_combine_fieldvaluelist(le.DID_values,ri.DID_values);
  SELF.PHONE_values := SALT27.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
  SELF.GENDER_values := SALT27.fn_combine_fieldvaluelist(le.GENDER_values,ri.GENDER_values);
  SELF.DERIVED_GENDER_values := SALT27.fn_combine_fieldvaluelist(le.DERIVED_GENDER_values,ri.DERIVED_GENDER_values);
  SELF.LIC_NBR_values := SALT27.fn_combine_fieldvaluelist(le.LIC_NBR_values,ri.LIC_NBR_values);
  SELF.ADDRESS_ID_values := SALT27.fn_combine_fieldvaluelist(le.ADDRESS_ID_values,ri.ADDRESS_ID_values);
  SELF.CNAME_values := SALT27.fn_combine_fieldvaluelist(le.CNAME_values,ri.CNAME_values);
  SELF.TAX_ID_values := SALT27.fn_combine_fieldvaluelist(le.TAX_ID_values,ri.TAX_ID_values);
  SELF.UPIN_values := SALT27.fn_combine_fieldvaluelist(le.UPIN_values,ri.UPIN_values);
  SELF.DEA_NUMBER_values := SALT27.fn_combine_fieldvaluelist(le.DEA_NUMBER_values,ri.DEA_NUMBER_values);
  SELF.VENDOR_ID_values := SALT27.fn_combine_fieldvaluelist(le.VENDOR_ID_values,ri.VENDOR_ID_values);
  SELF.NPI_NUMBER_values := SALT27.fn_combine_fieldvaluelist(le.NPI_NUMBER_values,ri.NPI_NUMBER_values);
  SELF.DT_FIRST_SEEN_values := SALT27.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
  SELF.DT_LAST_SEEN_values := SALT27.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
  SELF.DT_LIC_EXPIRATION_values := SALT27.fn_combine_fieldvaluelist(le.DT_LIC_EXPIRATION_values,ri.DT_LIC_EXPIRATION_values);
  SELF.DT_DEA_EXPIRATION_values := SALT27.fn_combine_fieldvaluelist(le.DT_DEA_EXPIRATION_values,ri.DT_DEA_EXPIRATION_values);
  SELF.FULLNAME_DOB_values := SALT27.fn_combine_fieldvaluelist(le.FULLNAME_DOB_values,ri.FULLNAME_DOB_values);
  SELF.ADDRESS_values := SALT27.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
  SELF.LIC_STATE_values := SALT27.fn_combine_fieldvaluelist(le.LIC_STATE_values,ri.LIC_STATE_values);
  SELF.SRC_values := SALT27.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(LNPID) ), LNPID, LOCAL ), LEFT.LNPID = RIGHT.LNPID, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LNPID := le.LNPID;
  SELF.DID_Values := IF ( (SALT27.StrType)le.DID = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DID)}],SALT27.Layout_FieldValueList));
  SELF.PHONE_Values := DATASET([{TRIM((SALT27.StrType)le.PHONE)}],SALT27.Layout_FieldValueList);
  SELF.GENDER_Values := IF ( (SALT27.StrType)le.GENDER = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.GENDER)}],SALT27.Layout_FieldValueList));
  SELF.DERIVED_GENDER_Values := IF ( (SALT27.StrType)le.DERIVED_GENDER = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DERIVED_GENDER)}],SALT27.Layout_FieldValueList));
  SELF.LIC_NBR_Values := IF ( (SALT27.StrType)le.LIC_NBR = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.LIC_NBR)}],SALT27.Layout_FieldValueList));
  SELF.ADDRESS_ID_Values := DATASET([{TRIM((SALT27.StrType)le.ADDRESS_ID)}],SALT27.Layout_FieldValueList);
  SELF.CNAME_Values := DATASET([{TRIM((SALT27.StrType)le.CNAME)}],SALT27.Layout_FieldValueList);
  SELF.TAX_ID_Values := IF ( (SALT27.StrType)le.TAX_ID = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.TAX_ID)}],SALT27.Layout_FieldValueList));
  SELF.UPIN_Values := IF ( (SALT27.StrType)le.UPIN = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.UPIN)}],SALT27.Layout_FieldValueList));
  SELF.DEA_NUMBER_Values := IF ( (SALT27.StrType)le.DEA_NUMBER = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.DEA_NUMBER)}],SALT27.Layout_FieldValueList));
  SELF.VENDOR_ID_Values := IF ( (SALT27.StrType)le.VENDOR_ID = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.VENDOR_ID)}],SALT27.Layout_FieldValueList));
  SELF.NPI_NUMBER_Values := IF ( (SALT27.StrType)le.NPI_NUMBER = '',DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.NPI_NUMBER)}],SALT27.Layout_FieldValueList));
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT27.StrType)le.DT_FIRST_SEEN)}],SALT27.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT27.StrType)le.DT_LAST_SEEN)}],SALT27.Layout_FieldValueList);
  SELF.DT_LIC_EXPIRATION_Values := DATASET([{TRIM((SALT27.StrType)le.DT_LIC_EXPIRATION)}],SALT27.Layout_FieldValueList);
  SELF.DT_DEA_EXPIRATION_Values := DATASET([{TRIM((SALT27.StrType)le.DT_DEA_EXPIRATION)}],SALT27.Layout_FieldValueList);
  self.FULLNAME_DOB_Values := IF ( (SALT27.StrType)le.FNAME = '' AND (SALT27.StrType)le.MNAME = '' AND (SALT27.StrType)le.LNAME = '' AND (SALT27.StrType)le.SNAME = '' AND (unsigned)le.DOB = 0,dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.FNAME) + ' ' + TRIM((SALT27.StrType)le.MNAME) + ' ' + TRIM((SALT27.StrType)le.LNAME) + ' ' + TRIM((SALT27.StrType)le.SNAME) + ' ' + (STRING)(((UNSIGNED)le.DOB DIV 100) % 100)+'/'+(STRING)((UNSIGNED)le.DOB % 100)+'/'+(STRING)((UNSIGNED)le.DOB DIV 10000)}],SALT27.Layout_FieldValueList));
  self.ADDRESS_Values := IF ( (SALT27.StrType)le.PRIM_RANGE = '' AND (SALT27.StrType)le.SEC_RANGE = '' AND (SALT27.StrType)le.PRIM_NAME = '' AND (SALT27.StrType)le.V_CITY_NAME = '' AND (SALT27.StrType)le.ST = '' AND (SALT27.StrType)le.ZIP = '',dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT27.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT27.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT27.StrType)le.V_CITY_NAME) + ' ' + TRIM((SALT27.StrType)le.ST) + ' ' + TRIM((SALT27.StrType)le.ZIP)}],SALT27.Layout_FieldValueList));
  SELF.LIC_STATE_Values := DATASET([{TRIM((SALT27.StrType)le.LIC_STATE)}],SALT27.Layout_FieldValueList);
  SELF.SRC_Values := DATASET([{TRIM((SALT27.StrType)le.SRC)}],SALT27.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
END;
