export Key_PersonHeader_ZPRF := MODULE
import SALT20,ut;
import PersonLinkingADL2; // Import modules for  attribute definitions
shared h := CandidatesForKey;//The input file - distributed by DID
layout := record // project out required fields
// Compulsory and optional fields
  h.ZIP;
  h.PRIM_RANGE;
  h.FNAME_PreferredName;
  h.FNAME;
  h.DID; // using existing id field
// Extra credit fields
  h.LNAME;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
//Scores for various field components
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_e1_Weight100;
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_e2p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_e2p_Weight100;
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_e1_Weight100;
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  UNSIGNED2 FNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_PersonHeader).Specificities[1];
DataForKey0 := dedup(sort(table(h(ZIP NOT IN SET(s.nulls_ZIP,ZIP),PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE)),layout),whole record,local),whole record,local); // Project out the fields in match candidates required for this linkpath
layout note_init2(layout le,Specificities(File_PersonHeader).FNAME_values_persisted ri) := transform
  self.FNAME_initial_weight100 := ri.field_specificity * 100;
  self := le;
end;
DataForKey2 := join(DataForKey0,Specificities(File_PersonHeader).FNAME_values_persisted(length(trim(FNAME))=1),left.FNAME[1]=right.FNAME[1],note_init2(left,right),lookup,left outer); // Append specificities for initials of FNAME
export Key := index(DataForKey2,,'~key::PRTE_PersonLinkingADL2V3PersonHeaderZPRFRefs');
export RawFetch( typeof(h.ZIP) param_ZIP, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.FNAME) param_FNAME) := 
    STEPPED( LIMIT( Key(
          ( ZIP = param_ZIP and param_ZIP <> (typeof(ZIP))'' )
      AND ( PRIM_RANGE = param_PRIM_RANGE and param_PRIM_RANGE <> (typeof(PRIM_RANGE))'' )
      AND ( FNAME = param_FNAME  OR FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME) or FNAME[1..length(trim(param_FNAME))] = param_FNAME or param_FNAME[1..length(trim(FNAME))] = FNAME or metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) or ut.WithinEditN(FNAME,param_FNAME,2)  )),5000,skip,keyed),DID);
export ScoredDIDFetch( typeof(h.ZIP) param_ZIP, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.FNAME) param_FNAME, typeof(h.LNAME) param_LNAME, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.SEC_RANGE) param_SEC_RANGE,UNSIGNED4 param_DOB) := FUNCTION
  RawData := RawFetch(param_ZIP,param_PRIM_RANGE,param_FNAME);
  Process_xADL2_Layouts.LayoutScoredFetch Score(RawData le) := transform
    self.keys_used := 1 << 8; // Set bitmap for key used
    self.ZIPWeight := IF ( le.ZIP <> param_ZIP,0,(le.ZIP_weight100+50)/100);
    self.PRIM_RANGEWeight := IF ( le.PRIM_RANGE <> param_PRIM_RANGE,0,(le.PRIM_RANGE_weight100+50)/100);
    self.FNAMEWeight := (50+MAP ( le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (typeof(le.FNAME))'' or param_FNAME = (typeof(param_FNAME))'' => 0,
           le.FNAME = param_FNAME[1..length(trim(le.FNAME))] => le.FNAME_weight100,
           ut.WithinEditN(le.FNAME,param_FNAME,2) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e2p_weight100,le.FNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..length(trim(param_FNAME))] = param_FNAME => SALT20.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
           le.LNAME = (typeof(le.LNAME))'' or param_LNAME = (typeof(param_LNAME))'' => 0,
           ut.WithinEditN(le.LNAME,param_LNAME,2) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e2p_weight100,le.LNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           0))/100;
    self.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
           le.PRIM_NAME = (typeof(le.PRIM_NAME))'' or param_PRIM_NAME = (typeof(param_PRIM_NAME))'' => 0,
           ut.WithinEditN(le.PRIM_NAME,param_PRIM_NAME,1) => le.PRIM_NAME_e1_weight100,
           0))/100;
    self.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (typeof(le.SEC_RANGE))'' or param_SEC_RANGE = (typeof(param_SEC_RANGE))'' => 0,
           0))/100;
    self.DOBWeight_year := (50+MAP ( le.DOB_year = 0 => 0,
       le.DOB_year = ((unsigned)param_DOB) div 10000  => le.DOB_year_weight100,
       ABS(le.DOB_year - ((unsigned)param_DOB) div 10000) < 2  => le.DOB_year_weight100-158, //YEAR_SHIFT
      0))/100;
    self.DOBWeight_month := (50+MAP ( le.DOB_month = 0 => 0,
      le.DOB_month = ((unsigned)param_DOB) div 100 % 100  => le.DOB_month_weight100,
      le.DOB_month = 1 AND le.DOB_day = 1 => +0, // SOFT1 
      le.DOB_month = ((unsigned)param_DOB) % 100 AND le.DOB_day = ((unsigned)param_DOB) div 100 % 100 => le.DOB_month_weight100-100, // MDDM
      0))/100;
    self.DOBWeight_day := (50+MAP ( le.DOB_day = 0 => 0,
      le.DOB_day = ((unsigned)param_DOB) % 100  => le.DOB_day_weight100,
      le.DOB_day = 1 => 0, // SOFT1 
      le.DOB_month = ((unsigned)param_DOB) % 100 AND le.DOB_day = ((unsigned)param_DOB) div 100 % 100 => le.DOB_day_weight100-100, // MDDM
      0))/100;
    self.Weight :=self.ZIPWeight +self.PRIM_RANGEWeight +self.FNAMEWeight +self.LNAMEWeight +self.PRIM_NAMEWeight +self.SEC_RANGEWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day;
    self := le;
  end;
  return rollup(project(nofold(RawData),Score(left)),left.DID = right.DID,Process_xADL2_Layouts.combine_scores(left,right));
end;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT20.UIDType Reference;//How to recognize this record in the subsequent
  typeof(h.ZIP) ZIP := (typeof(h.ZIP))'';
  typeof(h.PRIM_RANGE) PRIM_RANGE := (typeof(h.PRIM_RANGE))'';
  typeof(h.FNAME) FNAME := (typeof(h.FNAME))'';
  typeof(h.LNAME) LNAME := (typeof(h.LNAME))'';
  typeof(h.PRIM_NAME) PRIM_NAME := (typeof(h.PRIM_NAME))'';
  typeof(h.SEC_RANGE) SEC_RANGE := (typeof(h.SEC_RANGE))'';
  unsigned4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xADL2_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := transform
    self.Reference := ri.reference; // Copy reference field
    self.keys_used := 1 << 8; // Set bitmap for key used
    self.ZIPWeight := IF ( le.ZIP <> ri.ZIP,0,(le.ZIP_weight100+50)/100);
    self.PRIM_RANGEWeight := IF ( le.PRIM_RANGE <> ri.PRIM_RANGE,0,(le.PRIM_RANGE_weight100+50)/100);
    self.FNAMEWeight := (50+MAP ( le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (typeof(le.FNAME))'' or ri.FNAME = (typeof(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME[1..length(trim(le.FNAME))] => le.FNAME_weight100,
           ut.WithinEditN(le.FNAME,ri.FNAME,2) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e2p_weight100,le.FNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..length(trim(ri.FNAME))] = ri.FNAME => SALT20.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
           le.LNAME = (typeof(le.LNAME))'' or ri.LNAME = (typeof(ri.LNAME))'' => 0,
           ut.WithinEditN(le.LNAME,ri.LNAME,2) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e2p_weight100,le.LNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           0))/100;
    self.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
           le.PRIM_NAME = (typeof(le.PRIM_NAME))'' or ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0,
           ut.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1) => le.PRIM_NAME_e1_weight100,
           0))/100;
    self.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (typeof(le.SEC_RANGE))'' or ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0,
           0))/100;
    self.DOBWeight_year := (50+MAP ( le.DOB_year = 0 => 0,
       le.DOB_year = ((unsigned)ri.DOB) div 10000  => le.DOB_year_weight100,
       ABS(le.DOB_year - ((unsigned)ri.DOB) div 10000) < 2  => le.DOB_year_weight100-158, //YEAR_SHIFT
      0))/100;
    self.DOBWeight_month := (50+MAP ( le.DOB_month = 0 => 0,
      le.DOB_month = ((unsigned)ri.DOB) div 100 % 100  => le.DOB_month_weight100,
      le.DOB_month = 1 AND le.DOB_day = 1 => +0, // SOFT1 
      le.DOB_month = ((unsigned)ri.DOB) % 100 AND le.DOB_day = ((unsigned)ri.DOB) div 100 % 100 => le.DOB_month_weight100-100, // MDDM
      0))/100;
    self.DOBWeight_day := (50+MAP ( le.DOB_day = 0 => 0,
      le.DOB_day = ((unsigned)ri.DOB) % 100  => le.DOB_day_weight100,
      le.DOB_day = 1 => 0, // SOFT1 
      le.DOB_month = ((unsigned)ri.DOB) % 100 AND le.DOB_day = ((unsigned)ri.DOB) div 100 % 100 => le.DOB_day_weight100-100, // MDDM
      0))/100;
    self.Weight :=self.ZIPWeight +self.PRIM_RANGEWeight +self.FNAMEWeight +self.LNAMEWeight +self.PRIM_NAMEWeight +self.SEC_RANGEWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day;
    self := le;
  end;
J0 := JOIN(Recs(ZIP <> (typeof(ZIP))'',PRIM_RANGE <> (typeof(PRIM_RANGE))''),Key,LEFT.ZIP = RIGHT.ZIP
     AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
     AND ( LEFT.FNAME = RIGHT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR ut.WithinEditN(LEFT.FNAME,RIGHT.FNAME,2)  OR RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.ZIP = RIGHT.ZIP
     AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,5000)); // Use indexed join (used for smaller batches
J1 := JOIN(Recs(ZIP <> (typeof(ZIP))'',PRIM_RANGE <> (typeof(PRIM_RANGE))''),PULL(Key),LEFT.ZIP = RIGHT.ZIP
     AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE
     AND ( LEFT.FNAME = RIGHT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR ut.WithinEditN(LEFT.FNAME,RIGHT.FNAME,2)  OR RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.ZIP = RIGHT.ZIP
     AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE,5000),HASH); // PULL used to cause non-indexed join
  RETURN IF(AsIndex,J0,J1);
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
export MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_ZIP='',Input_PRIM_RANGE='',Input_FNAME='',Input_LNAME='',Input_PRIM_NAME='',Input_SEC_RANGE='',Input_DOB='',output_file,AsIndex='true') := MACRO
#IF(#TEXT(Input_ZIP)<>'' AND #TEXT(Input_PRIM_RANGE)<>'')
  #uniquename(trans)
  PRTE_PersonLinkingADL2V3.Key_PersonHeader_ZPRF.InputLayout_Batch %trans%(InFile le) := transform
    self.Reference := le.Input_Ref;
    self.ZIP := (typeof(self.ZIP))le.Input_ZIP;
    self.PRIM_RANGE := (typeof(self.PRIM_RANGE))le.Input_PRIM_RANGE;
    #if ( #TEXT(Input_FNAME) <> '' )
      self.FNAME := (typeof(self.FNAME))le.Input_FNAME;
    #end
    #if ( #TEXT(Input_LNAME) <> '' )
      self.LNAME := (typeof(self.LNAME))le.Input_LNAME;
    #end
    #if ( #TEXT(Input_PRIM_NAME) <> '' )
      self.PRIM_NAME := (typeof(self.PRIM_NAME))le.Input_PRIM_NAME;
    #end
    #if ( #TEXT(Input_SEC_RANGE) <> '' )
      self.SEC_RANGE := (typeof(self.SEC_RANGE))le.Input_SEC_RANGE;
    #end
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
  end;
  #uniquename(p)
  %p% := project(Infile,%trans%(left));
  output_file := PRTE_PersonLinkingADL2V3.Key_PersonHeader_ZPRF.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := dataset([],PRTE_PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
end;
