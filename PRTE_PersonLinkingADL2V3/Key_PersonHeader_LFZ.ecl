export Key_PersonHeader_LFZ := MODULE
import SALT20,ut;
import PersonLinkingADL2; // Import modules for  attribute definitions
shared h := CandidatesForKey;//The input file - distributed by DID
layout := record // project out required fields
// Compulsory and optional fields
  h.LNAME;
  h.FNAME_PreferredName;
  h.FNAME;
  h.ZIP;
  h.DID; // using existing id field
// Extra credit fields
  h.CITY;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SSN5;
  h.SSN4;
  h.MNAME;
  h.SEC_RANGE;
  h.NAME_SUFFIX;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
//Scores for various field components
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_e2p_Weight100;
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_e2p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.ZIP_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_weight100 ; // Contains 100x the specificity
  h.PRIM_RANGE_e1_Weight100;
  h.PRIM_NAME_weight100 ; // Contains 100x the specificity
  h.PRIM_NAME_e1_Weight100;
  h.SSN5_weight100 ; // Contains 100x the specificity
  unsigned2 SSN5_e1_Weight100 := h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2); // Precompute edit-distance specificity
  h.SSN4_weight100 ; // Contains 100x the specificity
  unsigned2 SSN4_e1_Weight100 := h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2); // Precompute edit-distance specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.SEC_RANGE_weight100 ; // Contains 100x the specificity
  h.NAME_SUFFIX_weight100 ; // Contains 100x the specificity
  h.NAME_SUFFIX_e2_Weight100;
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  UNSIGNED2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_PersonHeader).Specificities[1];
DataForKey0 := dedup(sort(table(h(LNAME NOT IN SET(s.nulls_LNAME,LNAME),FNAME NOT IN SET(s.nulls_FNAME,FNAME),ZIP NOT IN SET(s.nulls_ZIP,ZIP)),layout),whole record,local),whole record,local); // Project out the fields in match candidates required for this linkpath
layout note_init8(layout le,Specificities(File_PersonHeader).MNAME_values_persisted ri) := transform
  self.MNAME_initial_weight100 := ri.field_specificity * 100;
  self := le;
end;
DataForKey8 := join(DataForKey0,Specificities(File_PersonHeader).MNAME_values_persisted(length(trim(MNAME))=1),left.MNAME[1]=right.MNAME[1],note_init8(left,right),lookup,left outer); // Append specificities for initials of MNAME
export Key := index(DataForKey8,,'~key::PRTE_PersonLinkingADL2V3PersonHeaderLFZRefs');
export RawFetch( typeof(h.LNAME) param_LNAME, typeof(h.FNAME) param_FNAME, typeof(h.ZIP) param_ZIP) := 
    STEPPED( LIMIT( Key(
          ( LNAME = param_LNAME and param_LNAME <> (typeof(LNAME))'' )
      AND ( FNAME = param_FNAME AND FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME)  and param_FNAME <> (typeof(FNAME))'' )
      AND ( ZIP = param_ZIP and param_ZIP <> (typeof(ZIP))'' )),5000,skip,keyed),DID);
export ScoredDIDFetch( typeof(h.LNAME) param_LNAME, typeof(h.FNAME) param_FNAME, typeof(h.ZIP) param_ZIP, typeof(h.CITY) param_CITY, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.SSN5) param_SSN5, typeof(h.SSN4) param_SSN4, typeof(h.MNAME) param_MNAME, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.NAME_SUFFIX) param_NAME_SUFFIX,UNSIGNED4 param_DOB) := FUNCTION
  RawData := RawFetch(param_LNAME,param_FNAME,param_ZIP);
  Process_xADL2_Layouts.LayoutScoredFetch Score(RawData le) := transform
    self.keys_used := 1 << 2; // Set bitmap for key used
    self.LNAMEWeight := IF ( le.LNAME <> param_LNAME,0,(le.LNAME_weight100+50)/100);
    self.FNAMEWeight := IF ( le.FNAME <> param_FNAME,0,(le.FNAME_weight100+50)/100);
    self.ZIPWeight := IF ( le.ZIP <> param_ZIP,0,(le.ZIP_weight100+50)/100);
    self.CITYWeight := (50+MAP ( le.CITY = param_CITY  => le.CITY_weight100,
           le.CITY = (typeof(le.CITY))'' or param_CITY = (typeof(param_CITY))'' => 0,
           0))/100;
    self.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = param_PRIM_RANGE  => le.PRIM_RANGE_weight100,
           le.PRIM_RANGE = (typeof(le.PRIM_RANGE))'' or param_PRIM_RANGE = (typeof(param_PRIM_RANGE))'' => 0,
           ut.WithinEditN(le.PRIM_RANGE,param_PRIM_RANGE,1) => le.PRIM_RANGE_e1_weight100,
           0))/100;
    self.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = param_PRIM_NAME  => le.PRIM_NAME_weight100,
           le.PRIM_NAME = (typeof(le.PRIM_NAME))'' or param_PRIM_NAME = (typeof(param_PRIM_NAME))'' => 0,
           ut.WithinEditN(le.PRIM_NAME,param_PRIM_NAME,1) => le.PRIM_NAME_e1_weight100,
           0))/100;
    self.SSN5Weight := (50+MAP ( le.SSN5 = param_SSN5  => le.SSN5_weight100,
           le.SSN5 = (typeof(le.SSN5))'' or param_SSN5 = (typeof(param_SSN5))'' => 0,
           ut.WithinEditN(le.SSN5,param_SSN5,1) => le.SSN5_e1_weight100,
           0))/100;
    self.SSN4Weight := (50+MAP ( le.SSN4 = param_SSN4  => le.SSN4_weight100,
           le.SSN4 = (typeof(le.SSN4))'' or param_SSN4 = (typeof(param_SSN4))'' => 0,
           ut.WithinEditN(le.SSN4,param_SSN4,1) => le.SSN4_e1_weight100,
           0))/100;
    self.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (typeof(le.MNAME))'' or param_MNAME = (typeof(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..length(trim(le.MNAME))] => le.MNAME_weight100,
           ut.WithinEditN(le.MNAME,param_MNAME,2) => le.MNAME_e2_weight100,
           le.MNAME[1..length(trim(param_MNAME))] = param_MNAME => SALT20.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = param_SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (typeof(le.SEC_RANGE))'' or param_SEC_RANGE = (typeof(param_SEC_RANGE))'' => 0,
           0))/100;
    self.NAME_SUFFIXWeight := (50+MAP ( le.NAME_SUFFIX = param_NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
           le.NAME_SUFFIX = (typeof(le.NAME_SUFFIX))'' or param_NAME_SUFFIX = (typeof(param_NAME_SUFFIX))'' => 0,
           ut.WithinEditN(le.NAME_SUFFIX,param_NAME_SUFFIX,2) => le.NAME_SUFFIX_e2_weight100,
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
    self.Weight :=self.LNAMEWeight +self.FNAMEWeight +self.ZIPWeight +self.CITYWeight +self.PRIM_RANGEWeight +self.PRIM_NAMEWeight +self.SSN5Weight +self.SSN4Weight +self.MNAMEWeight +self.SEC_RANGEWeight +self.NAME_SUFFIXWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day;
    self := le;
  end;
  return rollup(project(nofold(RawData),Score(left)),left.DID = right.DID,Process_xADL2_Layouts.combine_scores(left,right));
end;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT20.UIDType Reference;//How to recognize this record in the subsequent
  typeof(h.LNAME) LNAME := (typeof(h.LNAME))'';
  typeof(h.FNAME) FNAME := (typeof(h.FNAME))'';
  typeof(h.ZIP) ZIP := (typeof(h.ZIP))'';
  typeof(h.CITY) CITY := (typeof(h.CITY))'';
  typeof(h.PRIM_RANGE) PRIM_RANGE := (typeof(h.PRIM_RANGE))'';
  typeof(h.PRIM_NAME) PRIM_NAME := (typeof(h.PRIM_NAME))'';
  typeof(h.SSN5) SSN5 := (typeof(h.SSN5))'';
  typeof(h.SSN4) SSN4 := (typeof(h.SSN4))'';
  typeof(h.MNAME) MNAME := (typeof(h.MNAME))'';
  typeof(h.SEC_RANGE) SEC_RANGE := (typeof(h.SEC_RANGE))'';
  typeof(h.NAME_SUFFIX) NAME_SUFFIX := (typeof(h.NAME_SUFFIX))'';
  unsigned4 DOB := 0;
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xADL2_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := transform
    self.Reference := ri.reference; // Copy reference field
    self.keys_used := 1 << 2; // Set bitmap for key used
    self.LNAMEWeight := IF ( le.LNAME <> ri.LNAME,0,(le.LNAME_weight100+50)/100);
    self.FNAMEWeight := IF ( le.FNAME <> ri.FNAME,0,(le.FNAME_weight100+50)/100);
    self.ZIPWeight := IF ( le.ZIP <> ri.ZIP,0,(le.ZIP_weight100+50)/100);
    self.CITYWeight := (50+MAP ( le.CITY = ri.CITY  => le.CITY_weight100,
           le.CITY = (typeof(le.CITY))'' or ri.CITY = (typeof(ri.CITY))'' => 0,
           0))/100;
    self.PRIM_RANGEWeight := (50+MAP ( le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
           le.PRIM_RANGE = (typeof(le.PRIM_RANGE))'' or ri.PRIM_RANGE = (typeof(ri.PRIM_RANGE))'' => 0,
           ut.WithinEditN(le.PRIM_RANGE,ri.PRIM_RANGE,1) => le.PRIM_RANGE_e1_weight100,
           0))/100;
    self.PRIM_NAMEWeight := (50+MAP ( le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
           le.PRIM_NAME = (typeof(le.PRIM_NAME))'' or ri.PRIM_NAME = (typeof(ri.PRIM_NAME))'' => 0,
           ut.WithinEditN(le.PRIM_NAME,ri.PRIM_NAME,1) => le.PRIM_NAME_e1_weight100,
           0))/100;
    self.SSN5Weight := (50+MAP ( le.SSN5 = ri.SSN5  => le.SSN5_weight100,
           le.SSN5 = (typeof(le.SSN5))'' or ri.SSN5 = (typeof(ri.SSN5))'' => 0,
           ut.WithinEditN(le.SSN5,ri.SSN5,1) => le.SSN5_e1_weight100,
           0))/100;
    self.SSN4Weight := (50+MAP ( le.SSN4 = ri.SSN4  => le.SSN4_weight100,
           le.SSN4 = (typeof(le.SSN4))'' or ri.SSN4 = (typeof(ri.SSN4))'' => 0,
           ut.WithinEditN(le.SSN4,ri.SSN4,1) => le.SSN4_e1_weight100,
           0))/100;
    self.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (typeof(le.MNAME))'' or ri.MNAME = (typeof(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..length(trim(le.MNAME))] => le.MNAME_weight100,
           ut.WithinEditN(le.MNAME,ri.MNAME,2) => le.MNAME_e2_weight100,
           le.MNAME[1..length(trim(ri.MNAME))] = ri.MNAME => SALT20.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.SEC_RANGEWeight := (50+MAP ( le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
           le.SEC_RANGE = (typeof(le.SEC_RANGE))'' or ri.SEC_RANGE = (typeof(ri.SEC_RANGE))'' => 0,
           0))/100;
    self.NAME_SUFFIXWeight := (50+MAP ( le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
           le.NAME_SUFFIX = (typeof(le.NAME_SUFFIX))'' or ri.NAME_SUFFIX = (typeof(ri.NAME_SUFFIX))'' => 0,
           ut.WithinEditN(le.NAME_SUFFIX,ri.NAME_SUFFIX,2) => le.NAME_SUFFIX_e2_weight100,
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
    self.Weight :=self.LNAMEWeight +self.FNAMEWeight +self.ZIPWeight +self.CITYWeight +self.PRIM_RANGEWeight +self.PRIM_NAMEWeight +self.SSN5Weight +self.SSN4Weight +self.MNAMEWeight +self.SEC_RANGEWeight +self.NAME_SUFFIXWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day;
    self := le;
  end;
J0 := JOIN(Recs(LNAME <> (typeof(LNAME))'',FNAME <> (typeof(FNAME))'',ZIP <> (typeof(ZIP))''),Key,LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.ZIP = RIGHT.ZIP,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.ZIP = RIGHT.ZIP,5000)); // Use indexed join (used for smaller batches
J1 := JOIN(Recs(LNAME <> (typeof(LNAME))'',FNAME <> (typeof(FNAME))'',ZIP <> (typeof(ZIP))''),PULL(Key),LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.ZIP = RIGHT.ZIP,Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.LNAME = RIGHT.LNAME
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.ZIP = RIGHT.ZIP,5000),HASH); // PULL used to cause non-indexed join
  RETURN IF(AsIndex,J0,J1);
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
export MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_LNAME='',Input_FNAME='',Input_ZIP='',Input_CITY='',Input_PRIM_RANGE='',Input_PRIM_NAME='',Input_SSN5='',Input_SSN4='',Input_MNAME='',Input_SEC_RANGE='',Input_NAME_SUFFIX='',Input_DOB='',output_file,AsIndex='true') := MACRO
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(trans)
  PRTE_PersonLinkingADL2V3.Key_PersonHeader_LFZ.InputLayout_Batch %trans%(InFile le) := transform
    self.Reference := le.Input_Ref;
    self.LNAME := (typeof(self.LNAME))le.Input_LNAME;
    self.FNAME := (typeof(self.FNAME))le.Input_FNAME;
    self.ZIP := (typeof(self.ZIP))le.Input_ZIP;
    #if ( #TEXT(Input_CITY) <> '' )
      self.CITY := (typeof(self.CITY))le.Input_CITY;
    #end
    #if ( #TEXT(Input_PRIM_RANGE) <> '' )
      self.PRIM_RANGE := (typeof(self.PRIM_RANGE))le.Input_PRIM_RANGE;
    #end
    #if ( #TEXT(Input_PRIM_NAME) <> '' )
      self.PRIM_NAME := (typeof(self.PRIM_NAME))le.Input_PRIM_NAME;
    #end
    #if ( #TEXT(Input_SSN5) <> '' )
      self.SSN5 := (typeof(self.SSN5))le.Input_SSN5;
    #end
    #if ( #TEXT(Input_SSN4) <> '' )
      self.SSN4 := (typeof(self.SSN4))le.Input_SSN4;
    #end
    #if ( #TEXT(Input_MNAME) <> '' )
      self.MNAME := (typeof(self.MNAME))le.Input_MNAME;
    #end
    #if ( #TEXT(Input_SEC_RANGE) <> '' )
      self.SEC_RANGE := (typeof(self.SEC_RANGE))le.Input_SEC_RANGE;
    #end
    #if ( #TEXT(Input_NAME_SUFFIX) <> '' )
      self.NAME_SUFFIX := (typeof(self.NAME_SUFFIX))le.Input_NAME_SUFFIX;
    #end
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
  end;
  #uniquename(p)
  %p% := project(Infile,%trans%(left));
  output_file := PRTE_PersonLinkingADL2V3.Key_PersonHeader_LFZ.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := dataset([],PRTE_PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
end;
