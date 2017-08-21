export Process_xADL2_Layouts := MODULE
import SALT20;
shared h := File_PersonHeader;//The input file
export Key := index(h,{DID},{h},'~key::PRTE_PersonLinkingADL2V3_PersonHeader'); // Base key for header file
export InputLayout := record,maxlength(4096)
  unsigned4 UniqueId; // This had better be unique or it will all break horribly
  h.NAME_SUFFIX;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.CITY;
  h.STATE;
  h.ZIP;
  h.ZIP4;
  h.COUNTY;
  h.SSN5;
  h.SSN4;
  h.DOB;
  h.PHONE;
  string MAINNAME;//Wordbag field for concept
  string FULLNAME;//Wordbag field for concept
  string ADDR1;//Wordbag field for concept
  string LOCALE;//Wordbag field for concept
  string ADDRS;//Wordbag field for concept
// Below only used in header search (data returning) case
  boolean MatchRecords := false; // Only show records which match
  boolean FullMatch := false; // Only show DID if it has a record which fully matches
  SALT20.UIDType Entered_DID := 0; // Allow user to enter 4660384 to pull data
end;
export HardKeyMatch(InputLayout le) :=(le.FNAME <> (typeof(le.FNAME))'' AND le.LNAME <> (typeof(le.LNAME))'' AND le.STATE <> (typeof(le.STATE))'') OR (le.LNAME <> (typeof(le.LNAME))'' AND le.FNAME <> (typeof(le.FNAME))'' AND le.ZIP <> (typeof(le.ZIP))'') OR (le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'' AND le.PRIM_NAME <> (typeof(le.PRIM_NAME))'' AND le.ZIP <> (typeof(le.ZIP))'') OR (le.SSN5 <> (typeof(le.SSN5))'' AND le.SSN4 <> (typeof(le.SSN4))'') OR (le.SSN4 <> (typeof(le.SSN4))'' AND le.FNAME <> (typeof(le.FNAME))'') OR (le.DOB <> (typeof(le.DOB))'' AND le.LNAME <> (typeof(le.LNAME))'') OR (le.PHONE <> (typeof(le.PHONE))'') OR (le.ZIP <> (typeof(le.ZIP))'' AND le.PRIM_RANGE <> (typeof(le.PRIM_RANGE))'') OR false;
EXPORT LayoutScoredFetch := RECORD,MAXLENGTH(32000) // Nulls required for linkpaths that do not have field
  h.DID;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT20.UIDType Reference := 0;//Presently for batch
  TYPEOF(h.NAME_SUFFIX) NAME_SUFFIX := (TYPEOF(h.NAME_SUFFIX))'';
  UNSIGNED2 NAME_SUFFIXWeight := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  UNSIGNED2 FNAMEWeight := 0;
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  UNSIGNED2 MNAMEWeight := 0;
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  UNSIGNED2 LNAMEWeight := 0;
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  UNSIGNED2 PRIM_RANGEWeight := 0;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  UNSIGNED2 PRIM_NAMEWeight := 0;
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  UNSIGNED2 SEC_RANGEWeight := 0;
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  UNSIGNED2 CITYWeight := 0;
  TYPEOF(h.STATE) STATE := (TYPEOF(h.STATE))'';
  UNSIGNED2 STATEWeight := 0;
  TYPEOF(h.ZIP) ZIP := (TYPEOF(h.ZIP))'';
  UNSIGNED2 ZIPWeight := 0;
  TYPEOF(h.ZIP4) ZIP4 := (TYPEOF(h.ZIP4))'';
  UNSIGNED2 ZIP4Weight := 0;
  TYPEOF(h.COUNTY) COUNTY := (TYPEOF(h.COUNTY))'';
  UNSIGNED2 COUNTYWeight := 0;
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))'';
  UNSIGNED2 SSN5Weight := 0;
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))'';
  UNSIGNED2 SSN4Weight := 0;
  unsigned2 DOB_year := 0;
  unsigned1 DOB_month := 0;
  unsigned1 DOB_day := 0;
  unsigned2 DOBWeight_year := 0;
  unsigned2 DOBWeight_month := 0;
  unsigned2 DOBWeight_day := 0;
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))'';
  UNSIGNED2 PHONEWeight := 0;
  string MAINNAME := ''; // Concepts always a wordbag
  unsigned2 MAINNAMEWeight := 0;
  string FULLNAME := ''; // Concepts always a wordbag
  unsigned2 FULLNAMEWeight := 0;
  string ADDR1 := ''; // Concepts always a wordbag
  unsigned2 ADDR1Weight := 0;
  string LOCALE := ''; // Concepts always a wordbag
  unsigned2 LOCALEWeight := 0;
  string ADDRS := ''; // Concepts always a wordbag
  unsigned2 ADDRSWeight := 0;
  unsigned4 keys_used; // A bitmap of the keys used
end;
export LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := transform
  self.NAME_SUFFIXWeight := IF ( le.NAME_SUFFIXWeight>ri.NAME_SUFFIXWeight, le.NAME_SUFFIXWeight, ri.NAME_SUFFIXWeight );
  self.NAME_SUFFIX := IF ( le.NAME_SUFFIXWeight>ri.NAME_SUFFIXWeight, le.NAME_SUFFIX, ri.NAME_SUFFIX );
  self.FNAMEWeight := IF ( le.FNAMEWeight>ri.FNAMEWeight, le.FNAMEWeight, ri.FNAMEWeight );
  self.FNAME := IF ( le.FNAMEWeight>ri.FNAMEWeight, le.FNAME, ri.FNAME );
  self.MNAMEWeight := IF ( le.MNAMEWeight>ri.MNAMEWeight, le.MNAMEWeight, ri.MNAMEWeight );
  self.MNAME := IF ( le.MNAMEWeight>ri.MNAMEWeight, le.MNAME, ri.MNAME );
  self.LNAMEWeight := IF ( le.LNAMEWeight>ri.LNAMEWeight, le.LNAMEWeight, ri.LNAMEWeight );
  self.LNAME := IF ( le.LNAMEWeight>ri.LNAMEWeight, le.LNAME, ri.LNAME );
  self.PRIM_RANGEWeight := IF ( le.PRIM_RANGEWeight>ri.PRIM_RANGEWeight, le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  self.PRIM_RANGE := IF ( le.PRIM_RANGEWeight>ri.PRIM_RANGEWeight, le.PRIM_RANGE, ri.PRIM_RANGE );
  self.PRIM_NAMEWeight := IF ( le.PRIM_NAMEWeight>ri.PRIM_NAMEWeight, le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  self.PRIM_NAME := IF ( le.PRIM_NAMEWeight>ri.PRIM_NAMEWeight, le.PRIM_NAME, ri.PRIM_NAME );
  self.SEC_RANGEWeight := IF ( le.SEC_RANGEWeight>ri.SEC_RANGEWeight, le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  self.SEC_RANGE := IF ( le.SEC_RANGEWeight>ri.SEC_RANGEWeight, le.SEC_RANGE, ri.SEC_RANGE );
  self.CITYWeight := IF ( le.CITYWeight>ri.CITYWeight, le.CITYWeight, ri.CITYWeight );
  self.CITY := IF ( le.CITYWeight>ri.CITYWeight, le.CITY, ri.CITY );
  self.STATEWeight := IF ( le.STATEWeight>ri.STATEWeight, le.STATEWeight, ri.STATEWeight );
  self.STATE := IF ( le.STATEWeight>ri.STATEWeight, le.STATE, ri.STATE );
  self.ZIPWeight := IF ( le.ZIPWeight>ri.ZIPWeight, le.ZIPWeight, ri.ZIPWeight );
  self.ZIP := IF ( le.ZIPWeight>ri.ZIPWeight, le.ZIP, ri.ZIP );
  self.ZIP4Weight := IF ( le.ZIP4Weight>ri.ZIP4Weight, le.ZIP4Weight, ri.ZIP4Weight );
  self.ZIP4 := IF ( le.ZIP4Weight>ri.ZIP4Weight, le.ZIP4, ri.ZIP4 );
  self.COUNTYWeight := IF ( le.COUNTYWeight>ri.COUNTYWeight, le.COUNTYWeight, ri.COUNTYWeight );
  self.COUNTY := IF ( le.COUNTYWeight>ri.COUNTYWeight, le.COUNTY, ri.COUNTY );
  self.SSN5Weight := IF ( le.SSN5Weight>ri.SSN5Weight, le.SSN5Weight, ri.SSN5Weight );
  self.SSN5 := IF ( le.SSN5Weight>ri.SSN5Weight, le.SSN5, ri.SSN5 );
  self.SSN4Weight := IF ( le.SSN4Weight>ri.SSN4Weight, le.SSN4Weight, ri.SSN4Weight );
  self.SSN4 := IF ( le.SSN4Weight>ri.SSN4Weight, le.SSN4, ri.SSN4 );
  self.DOBWeight_year := IF ( le.DOBWeight_year>ri.DOBWeight_year, le.DOBWeight_year, ri.DOBWeight_year );
  self.DOB_year := IF ( le.DOBWeight_year>ri.DOBWeight_year, le.DOB_year, ri.DOB_year );
  self.DOBWeight_month := IF ( le.DOBWeight_month>ri.DOBWeight_month, le.DOBWeight_month, ri.DOBWeight_month );
  self.DOB_month := IF ( le.DOBWeight_month>ri.DOBWeight_month, le.DOB_month, ri.DOB_month );
  self.DOBWeight_day := IF ( le.DOBWeight_day>ri.DOBWeight_day, le.DOBWeight_day, ri.DOBWeight_day );
  self.DOB_day := IF ( le.DOBWeight_day>ri.DOBWeight_day, le.DOB_day, ri.DOB_day );
  self.PHONEWeight := IF ( le.PHONEWeight>ri.PHONEWeight, le.PHONEWeight, ri.PHONEWeight );
  self.PHONE := IF ( le.PHONEWeight>ri.PHONEWeight, le.PHONE, ri.PHONE );
  self.MAINNAMEWeight := IF ( le.MAINNAMEWeight>ri.MAINNAMEWeight, le.MAINNAMEWeight, ri.MAINNAMEWeight );
  self.MAINNAME := IF ( le.MAINNAMEWeight>ri.MAINNAMEWeight, le.MAINNAME, ri.MAINNAME );
  self.FULLNAMEWeight := IF ( le.FULLNAMEWeight>ri.FULLNAMEWeight, le.FULLNAMEWeight, ri.FULLNAMEWeight );
  self.FULLNAME := IF ( le.FULLNAMEWeight>ri.FULLNAMEWeight, le.FULLNAME, ri.FULLNAME );
  self.ADDR1Weight := IF ( le.ADDR1Weight>ri.ADDR1Weight, le.ADDR1Weight, ri.ADDR1Weight );
  self.ADDR1 := IF ( le.ADDR1Weight>ri.ADDR1Weight, le.ADDR1, ri.ADDR1 );
  self.LOCALEWeight := IF ( le.LOCALEWeight>ri.LOCALEWeight, le.LOCALEWeight, ri.LOCALEWeight );
  self.LOCALE := IF ( le.LOCALEWeight>ri.LOCALEWeight, le.LOCALE, ri.LOCALE );
  self.ADDRSWeight := IF ( le.ADDRSWeight>ri.ADDRSWeight, le.ADDRSWeight, ri.ADDRSWeight );
  self.ADDRS := IF ( le.ADDRSWeight>ri.ADDRSWeight, le.ADDRS, ri.ADDRS );
  self.keys_used := le.keys_used | ri.keys_used;
  self.Weight := 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + self.SSN5Weight + self.SSN4Weight +  self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day + self.PHONEWeight + 0 /* accounted in parent concept */ + MAX(self.MAINNAMEWeight,self.FNAMEWeight + self.MNAMEWeight + self.LNAMEWeight) + self.NAME_SUFFIXWeight + 0 /* accounted in parent concept */ + 0 /* accounted in parent concept */ + self.PRIM_RANGEWeight + self.PRIM_NAMEWeight + self.SEC_RANGEWeight + self.ZIP4Weight + self.COUNTYWeight + self.CITYWeight + self.STATEWeight + self.ZIPWeight;
  self := le;
end;
shared OutputLayout_Base := record,maxlength(32000)
  boolean Verified := false; // has found possible results
  boolean Ambiguous := false; // has >= 20 dids within an order of magnitude of best
  boolean ShortList := false; // has < 20 dids within an order of magnitude of best
  boolean Handful := false; // has <6 IDs within two orders of magnitude of best
  boolean Resolved := false; // certain with 3 nines of accuracy
  dataset(LayoutScoredFetch) Results;
end;
export OutputLayout := record(OutputLayout_Base),maxlength(32000)
  InputLayout;
end;
export OutputLayout_Batch := record(OutputLayout_Base),maxlength(32006)
  SALT20.UIDType Reference;
end;
export MAC_Add_ResolutionFlags() := macro
  self.Verified := exists(self.results);
  self.Ambiguous := COUNT(self.results(Weight>=MAX(self.results,Weight)-1)) >= 20;
  self.ShortList := COUNT(self.results(Weight>=MAX(self.results,Weight)-1)) < 20 and self.verified;
  self.Handful := COUNT(self.results(Weight>=MAX(self.results,Weight)-3)) < 6 and self.verified;
  self.Resolved := COUNT(self.results(Weight>=MAX(self.results,Weight)-5)) = 1;
endmacro;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
OutputLayout_Batch into(in_data le) := TRANSFORM
  SELF.Reference := le.Reference;
  SELF.Results := DATASET([le],LayoutScoredFetch);
  MAC_Add_ResolutionFlags()
END;
OutputLayout_Batch Create_Output(OutputLayout_Batch le, OutputLayout_Batch ri) := TRANSFORM
  SELF.Results := le.results+ri.results;
  SELF.Reference := le.Reference;
  MAC_Add_ResolutionFlags()
END;
  r := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),DID),LEFT.DID=RIGHT.DID,Combine_Scores(LEFT,RIGHT));
  r1 := ROLLUP( PROJECT(TOPN(r,100,-Weight),into(LEFT)),TRUE, Create_Output(LEFT,RIGHT) );
  RR0 := GROUP(r1);
  SALT20.MAC_External_AddPcnt(RR0,LayoutScoredFetch,OutputLayout_Batch,4660488,RR1);
  RETURN RR1;
END;
export KeysUsedToText(unsigned4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'FLST,','') + IF(k&(1<<2)<>0,'LFZ,','') + IF(k&(1<<3)<>0,'ADDRESS3,','') + IF(k&(1<<4)<>0,'S,','') + IF(k&(1<<5)<>0,'SSN4,','') + IF(k&(1<<6)<>0,'DO,','') + IF(k&(1<<7)<>0,'PH,','') + IF(k&(1<<8)<>0,'ZPRF,','');
  return list[1..length(trim(list))-1]; // Strim last ,
end;
export Layout_RolledEntity := record,maxlength(63000)
  SALT20.UIDType DID;
  dataset(SALT20.Layout_FieldValueList) SSN5_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) SSN4_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) DOB_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) PHONE_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) FULLNAME_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) ADDRS_Values := dataset([],SALT20.Layout_FieldValueList);
end;
shared RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self.DID := le.DID;
  self.SSN5_values := SALT20.fn_combine_fieldvaluelist(le.SSN5_values,ri.SSN5_values);
  self.SSN4_values := SALT20.fn_combine_fieldvaluelist(le.SSN4_values,ri.SSN4_values);
  self.DOB_values := SALT20.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
  self.PHONE_values := SALT20.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
  self.FULLNAME_values := SALT20.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
  self.ADDRS_values := SALT20.fn_combine_fieldvaluelist(le.ADDRS_values,ri.ADDRS_values);
end;
  return rollup( sort( distribute( infile, hash(DID) ), DID, local ), left.DID = right.DID, RollValues(left,right),local);
end;
export RolledEntities(dataset(recordof(Key)) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self.DID := le.DID;
  self.SSN5_Values := IF ( (string)le.SSN5 = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.SSN5)}],SALT20.Layout_FieldValueList));
  self.SSN4_Values := IF ( (string)le.SSN4 = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.SSN4)}],SALT20.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT20.Layout_FieldValueList),dataset([{(SALT20.StrType)le.DOB}],SALT20.Layout_FieldValueList));
  self.PHONE_Values := IF ( (string)le.PHONE = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.PHONE)}],SALT20.Layout_FieldValueList));
  self.FULLNAME_Values := IF ( (string)le.FNAME = '' AND (string)le.MNAME = '' AND (string)le.LNAME = '' AND (string)le.NAME_SUFFIX = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.FNAME) + ' ' + trim((string)le.MNAME) + ' ' + trim((string)le.LNAME) + ' ' + trim((string)le.NAME_SUFFIX)}],SALT20.Layout_FieldValueList));
  self.ADDRS_Values := IF ( (string)le.PRIM_RANGE = '' AND (string)le.PRIM_NAME = '' AND (string)le.SEC_RANGE = '' AND (string)le.ZIP4 = '' AND (string)le.COUNTY = '' AND (string)le.CITY = '' AND (string)le.STATE = '' AND (string)le.ZIP = '',dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.PRIM_RANGE) + ' ' + trim((string)le.PRIM_NAME) + ' ' + trim((string)le.SEC_RANGE) + ' ' + trim((string)le.ZIP4) + ' ' + trim((string)le.COUNTY) + ' ' + trim((string)le.CITY) + ' ' + trim((string)le.STATE) + ' ' + trim((string)le.ZIP)}],SALT20.Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
  return RollEntities(AsFieldValues);
end;
end;
