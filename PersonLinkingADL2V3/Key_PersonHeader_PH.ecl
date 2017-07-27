/*2011-08-04T12:35:09Z (Jose Bello)
Bug: 84022
*/
export Key_PersonHeader_PH := MODULE
import SALT20,ut,doxie;
import PersonLinkingADL2; // Import modules for  attribute definitions
shared h := CandidatesForKey;//The input file - distributed by DID
layout := record // project out required fields
// Compulsory and optional fields
  h.PHONE;
  h.FNAME_PreferredName;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.DID; // using existing id field
// Extra credit fields
  h.CITY;
  h.STATE;
  h.SSN5;
  h.SSN4;
//Scores for various field components
  h.PHONE_weight100 ; // Contains 100x the specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_e2p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_e2p_Weight100;
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  h.STATE_weight100 ; // Contains 100x the specificity
  h.SSN5_weight100 ; // Contains 100x the specificity
  unsigned2 SSN5_e1_Weight100 := h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2); // Precompute edit-distance specificity
  h.SSN4_weight100 ; // Contains 100x the specificity
  unsigned2 SSN4_e1_Weight100 := h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2); // Precompute edit-distance specificity
  UNSIGNED2 FNAME_initial_weight100 := 0; // Weight if only first character matches
  UNSIGNED2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_PersonHeader).Specificities[1];
DataForKey0 := dedup(sort(table(h(PHONE NOT IN SET(s.nulls_PHONE,PHONE)),layout),whole record,local),whole record,local); // Project out the fields in match candidates required for this linkpath
export Key := index(DataForKey0,,ut.Data_Location.Person_header+'thor_data400::key::PersonLinkingADL2V3PersonHeaderPHRefs_' + doxie.version_superkey);
export RawFetch( typeof(h.PHONE) param_PHONE, typeof(h.FNAME) param_FNAME, typeof(h.MNAME) param_MNAME, typeof(h.LNAME) param_LNAME,UNSIGNED4 param_DOB) := 
    STEPPED( LIMIT( Key(
          ( PHONE = param_PHONE and param_PHONE <> (typeof(PHONE))'' )
      AND (( FNAME = param_FNAME  OR FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME) or FNAME[1..length(trim(param_FNAME))] = param_FNAME or param_FNAME[1..length(trim(FNAME))] = FNAME or metaphonelib.DMetaPhone1(FNAME)=metaphonelib.DMetaPhone1(param_FNAME) or PersonLinkingADL2V3.WithinEditX(FNAME,param_FNAME)  )
        AND ( MNAME = param_MNAME or MNAME[1..length(trim(param_MNAME))] = param_MNAME or param_MNAME[1..length(trim(MNAME))] = MNAME or ut.WithinEditN(MNAME,param_MNAME,2)  )
        AND ( LNAME = param_LNAME or LNAME = (typeof(LNAME))'' or param_LNAME = (typeof(LNAME))'' or metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) or PersonLinkingADL2V3.WithinEditX(LNAME,param_LNAME, Constants.LNAME_LENGTH_EDIT2)  )
        OR SALT20.fn_concept_wordbag_oneweight.Match3((string)FNAME,FNAME_weight100,true,0,true,(string)MNAME,MNAME_weight100,true,0,true,(string)LNAME,LNAME_weight100,true,0,false,(string)param_FNAME,0,(string)param_MNAME,0,(string)param_LNAME,0)>= 0 )
      AND (( param_DOB div 10000 = DOB_year OR param_DOB div 10000 = 0 OR DOB_year = 0) AND ( param_DOB div 100 % 100 = DOB_month OR param_DOB div 100 % 100 = 0 OR DOB_month = 0) AND ( param_DOB % 100 = DOB_day OR param_DOB % 100 = 0 OR DOB_day = 0))),5000,skip,keyed),DID);
export ScoredDIDFetch( typeof(h.PHONE) param_PHONE, typeof(h.FNAME) param_FNAME, typeof(h.MNAME) param_MNAME, typeof(h.LNAME) param_LNAME,UNSIGNED4 param_DOB, typeof(h.CITY) param_CITY, typeof(h.STATE) param_STATE, typeof(h.SSN5) param_SSN5, typeof(h.SSN4) param_SSN4) := FUNCTION
  RawData := RawFetch(param_PHONE,param_FNAME,param_MNAME,param_LNAME,param_DOB);
  Process_xADL2_Layouts.LayoutScoredFetch Score(RawData le) := transform
    self.keys_used := 1 << 10; // Set bitmap for key used
    self.PHONEWeight := IF ( le.PHONE <> param_PHONE,0,(le.PHONE_weight100+50)/100);
    self.FNAMEWeight := (50+MAP ( le.FNAME = param_FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (typeof(le.FNAME))'' or param_FNAME = (typeof(param_FNAME))'' => 0,
           le.FNAME = param_FNAME[1..length(trim(le.FNAME))] => le.FNAME_weight100,
           PersonLinkingADL2V3.WithinEditX(le.FNAME,param_FNAME) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME),le.FNAME_e2p_weight100,le.FNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(param_FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..length(trim(param_FNAME))] = param_FNAME => SALT20.Fn_Interpolate_Initial(le.FNAME,param_FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (typeof(le.MNAME))'' or param_MNAME = (typeof(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..length(trim(le.MNAME))] => le.MNAME_weight100,
           ut.WithinEditN(le.MNAME,param_MNAME,2) => le.MNAME_e2_weight100,
           le.MNAME[1..length(trim(param_MNAME))] = param_MNAME => SALT20.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
           le.LNAME = (typeof(le.LNAME))'' or param_LNAME = (typeof(param_LNAME))'' => 0,
           PersonLinkingADL2V3.WithinEditX(le.LNAME,param_LNAME, Constants.LNAME_LENGTH_EDIT2) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e2p_weight100,le.LNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
           0))/100;
    self.MAINNAMEWeight := (50+SALT20.fn_concept_wordbag_oneweight.Match3((string)le.FNAME,le.FNAME_weight100,true,0,true,(string)le.MNAME,le.MNAME_weight100,true,0,true,(string)le.LNAME,le.LNAME_weight100,true,0,false,(string)param_FNAME,0,(string)param_MNAME,0,(string)param_LNAME,0))/100; // Concept could score even if fields do not
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
    self.CITYWeight := (50+MAP ( le.CITY = param_CITY  => le.CITY_weight100,
           le.CITY = (typeof(le.CITY))'' or param_CITY = (typeof(param_CITY))'' => 0,
           0))/100;
    self.STATEWeight := (50+MAP ( le.STATE = param_STATE  => le.STATE_weight100,
           le.STATE = (typeof(le.STATE))'' or param_STATE = (typeof(param_STATE))'' => 0,
           0))/100;
    self.SSN5Weight := (50+MAP ( le.SSN5 = param_SSN5  => le.SSN5_weight100,
           le.SSN5 = (typeof(le.SSN5))'' or param_SSN5 = (typeof(param_SSN5))'' => 0,
           ut.WithinEditN(le.SSN5,param_SSN5,1) => le.SSN5_e1_weight100,
           0))/100;
    self.SSN4Weight := (50+MAP ( le.SSN4 = param_SSN4  => le.SSN4_weight100,
           le.SSN4 = (typeof(le.SSN4))'' or param_SSN4 = (typeof(param_SSN4))'' => 0,
           ut.WithinEditN(le.SSN4,param_SSN4,1) => le.SSN4_e1_weight100,
           0))/100;
    self.Weight :=self.PHONEWeight +MAX(self.MAINNAMEWeight,self.FNAMEWeight + self.MNAMEWeight + self.LNAMEWeight) + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +self.CITYWeight +self.STATEWeight +self.SSN5Weight +self.SSN4Weight;
    self := le;
  end;
  return rollup(project(nofold(RawData),Score(left)),left.DID = right.DID,Process_xADL2_Layouts.combine_scores(left,right));
end;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT20.UIDType Reference;//How to recognize this record in the subsequent
  typeof(h.PHONE) PHONE := (typeof(h.PHONE))'';
  SALT20.StrType MAINNAME := (SALT20.StrType)'';
  typeof(h.FNAME) FNAME := (typeof(h.FNAME))'';
  typeof(h.MNAME) MNAME := (typeof(h.MNAME))'';
  typeof(h.LNAME) LNAME := (typeof(h.LNAME))'';
  unsigned4 DOB := 0;
  typeof(h.CITY) CITY := (typeof(h.CITY))'';
  typeof(h.STATE) STATE := (typeof(h.STATE))'';
  typeof(h.SSN5) SSN5 := (typeof(h.SSN5))'';
  typeof(h.SSN4) SSN4 := (typeof(h.SSN4))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xADL2_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := transform
    self.Reference := ri.reference; // Copy reference field
    self.keys_used := 1 << 10; // Set bitmap for key used
    self.PHONEWeight := IF ( le.PHONE <> ri.PHONE,0,(le.PHONE_weight100+50)/100);
    self.FNAMEWeight := (50+MAP ( le.FNAME = ri.FNAME  => le.FNAME_weight100,
           le.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(ri.FNAME) => le.FNAME_PreferredName_weight100,
           le.FNAME = (typeof(le.FNAME))'' or ri.FNAME = (typeof(ri.FNAME))'' => 0,
           le.FNAME = ri.FNAME[1..length(trim(le.FNAME))] => le.FNAME_weight100,
           PersonLinkingADL2V3.WithinEditX(le.FNAME,ri.FNAME) => IF( metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME),le.FNAME_e2p_weight100,le.FNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.FNAME)=metaphonelib.DMetaPhone1(ri.FNAME)=>le.FNAME_p_weight100,
           le.FNAME[1..length(trim(ri.FNAME))] = ri.FNAME => SALT20.Fn_Interpolate_Initial(le.FNAME,ri.FNAME,le.FNAME_weight100,le.FNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (typeof(le.MNAME))'' or ri.MNAME = (typeof(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..length(trim(le.MNAME))] => le.MNAME_weight100,
           ut.WithinEditN(le.MNAME,ri.MNAME,2) => le.MNAME_e2_weight100,
           le.MNAME[1..length(trim(ri.MNAME))] = ri.MNAME => SALT20.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
    self.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
           le.LNAME = (typeof(le.LNAME))'' or ri.LNAME = (typeof(ri.LNAME))'' => 0,
           PersonLinkingADL2V3.WithinEditX(le.LNAME,ri.LNAME, Constants.LNAME_LENGTH_EDIT2) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e2p_weight100,le.LNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
           0))/100;
    self.MAINNAMEWeight := (50+                        SALT20.fn_concept_wordbag_oneweight.Match3((string)le.FNAME,le.FNAME_weight100,true,0,true,(string)le.MNAME,le.MNAME_weight100,true,0,true,(string)le.LNAME,le.LNAME_weight100,true,0,false,(string)ri.FNAME,0,(string)ri.MNAME,0,(string)ri.LNAME,0))/100; // Concept could score even if fields do not
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
    self.CITYWeight := (50+MAP ( le.CITY = ri.CITY  => le.CITY_weight100,
           le.CITY = (typeof(le.CITY))'' or ri.CITY = (typeof(ri.CITY))'' => 0,
           0))/100;
    self.STATEWeight := (50+MAP ( le.STATE = ri.STATE  => le.STATE_weight100,
           le.STATE = (typeof(le.STATE))'' or ri.STATE = (typeof(ri.STATE))'' => 0,
           0))/100;
    self.SSN5Weight := (50+MAP ( le.SSN5 = ri.SSN5  => le.SSN5_weight100,
           le.SSN5 = (typeof(le.SSN5))'' or ri.SSN5 = (typeof(ri.SSN5))'' => 0,
           ut.WithinEditN(le.SSN5,ri.SSN5,1) => le.SSN5_e1_weight100,
           0))/100;
    self.SSN4Weight := (50+MAP ( le.SSN4 = ri.SSN4  => le.SSN4_weight100,
           le.SSN4 = (typeof(le.SSN4))'' or ri.SSN4 = (typeof(ri.SSN4))'' => 0,
           ut.WithinEditN(le.SSN4,ri.SSN4,1) => le.SSN4_e1_weight100,
           0))/100;
    self.Weight :=self.PHONEWeight +MAX(self.MAINNAMEWeight,self.FNAMEWeight + self.MNAMEWeight + self.LNAMEWeight) + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +self.CITYWeight +self.STATEWeight +self.SSN5Weight +self.SSN4Weight;
    self := le;
  end;
J0 := JOIN(Recs(PHONE <> (typeof(PHONE))''),Key,LEFT.PHONE = RIGHT.PHONE
     AND 
      (( LEFT.FNAME = RIGHT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR PersonLinkingADL2V3.WithinEditX(LEFT.FNAME,RIGHT.FNAME)  OR RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) )
        AND ( LEFT.MNAME = RIGHT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR ut.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2) )
        AND ( LEFT.LNAME = RIGHT.LNAME OR LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR PersonLinkingADL2V3.WithinEditX(LEFT.LNAME,RIGHT.LNAME, Constants.LNAME_LENGTH_EDIT2) )
        // OR                         SALT20.fn_concept_wordbag_oneweight.Match3((string)RIGHT.FNAME,RIGHT.FNAME_weight100,true,0,true,(string)RIGHT.MNAME,RIGHT.MNAME_weight100,true,0,true,(string)RIGHT.LNAME,RIGHT.LNAME_weight100,true,0,false,(string)LEFT.FNAME,0,(string)LEFT.MNAME,0,(string)LEFT.LNAME,0)>= 0 )
        OR                         SALT20.fn_concept_wordbag_oneweight.Match3((string)RIGHT.FNAME,RIGHT.FNAME_weight100,true,0,true,(string)RIGHT.MNAME,RIGHT.MNAME_weight100,true,0,true,(string)RIGHT.LNAME,RIGHT.LNAME_weight100,true,0,false,(string)LEFT.FNAME,0,(string)LEFT.MNAME,0,(string)LEFT.LNAME,0)> 0 )
     AND (((unsigned)left.DOB div 10000 = right.DOB_year OR (unsigned)left.DOB div 10000 = 0 OR right.DOB_year = 0) AND ((unsigned)left.DOB div 100 % 100 = right.DOB_month OR (unsigned)left.DOB div 100 % 100  = 0 OR right.DOB_month = 0) AND ((unsigned)left.DOB % 100= right.DOB_day OR (unsigned)left.DOB % 100 = 0 OR right.DOB_day = 0)),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PHONE = RIGHT.PHONE,5000)); // Use indexed join (used for smaller batches
J1 := JOIN(Recs(PHONE <> (typeof(PHONE))''),PULL(Key),LEFT.PHONE = RIGHT.PHONE
     AND 
      (( LEFT.FNAME = RIGHT.FNAME OR LEFT.FNAME[1..LENGTH(TRIM(RIGHT.FNAME))] = RIGHT.FNAME OR RIGHT.FNAME[1..LENGTH(TRIM(LEFT.FNAME))] = LEFT.FNAME OR metaphonelib.DMetaPhone1(LEFT.FNAME)=metaphonelib.DMetaPhone1(RIGHT.FNAME) OR PersonLinkingADL2V3.WithinEditX(LEFT.FNAME,RIGHT.FNAME)  OR RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) )
        AND ( LEFT.MNAME = RIGHT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR ut.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2) )
        AND ( LEFT.LNAME = RIGHT.LNAME OR LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR PersonLinkingADL2V3.WithinEditX(LEFT.LNAME,RIGHT.LNAME, Constants.LNAME_LENGTH_EDIT2) )
        // OR                         SALT20.fn_concept_wordbag_oneweight.Match3((string)RIGHT.FNAME,RIGHT.FNAME_weight100,true,0,true,(string)RIGHT.MNAME,RIGHT.MNAME_weight100,true,0,true,(string)RIGHT.LNAME,RIGHT.LNAME_weight100,true,0,false,(string)LEFT.FNAME,0,(string)LEFT.MNAME,0,(string)LEFT.LNAME,0)>= 0 )
        OR                         SALT20.fn_concept_wordbag_oneweight.Match3((string)RIGHT.FNAME,RIGHT.FNAME_weight100,true,0,true,(string)RIGHT.MNAME,RIGHT.MNAME_weight100,true,0,true,(string)RIGHT.LNAME,RIGHT.LNAME_weight100,true,0,false,(string)LEFT.FNAME,0,(string)LEFT.MNAME,0,(string)LEFT.LNAME,0)> 0 )
     AND (((unsigned)left.DOB div 10000 = right.DOB_year OR (unsigned)left.DOB div 10000 = 0 OR right.DOB_year = 0) AND ((unsigned)left.DOB div 100 % 100 = right.DOB_month OR (unsigned)left.DOB div 100 % 100  = 0 OR right.DOB_month = 0) AND ((unsigned)left.DOB % 100= right.DOB_day OR (unsigned)left.DOB % 100 = 0 OR right.DOB_day = 0)),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.PHONE = RIGHT.PHONE,5000),HASH); // PULL used to cause non-indexed join
  RETURN IF(AsIndex,J0,J1);
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
export MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_PHONE='',Input_FNAME='',Input_MNAME='',Input_LNAME='',Input_DOB='',Input_CITY='',Input_STATE='',Input_SSN5='',Input_SSN4='',output_file,AsIndex='true') := MACRO
#IF(#TEXT(Input_PHONE)<>'')
  #uniquename(trans)
  PersonLinkingADL2V3.Key_PersonHeader_PH.InputLayout_Batch %trans%(InFile le) := transform
    self.Reference := le.Input_Ref;
    self.PHONE := (typeof(self.PHONE))le.Input_PHONE;
    #if ( #TEXT(Input_FNAME) <> '' )
      self.FNAME := (typeof(self.FNAME))le.Input_FNAME;
    #end
    #if ( #TEXT(Input_MNAME) <> '' )
      self.MNAME := (typeof(self.MNAME))le.Input_MNAME;
    #end
    #if ( #TEXT(Input_LNAME) <> '' )
      self.LNAME := (typeof(self.LNAME))le.Input_LNAME;
    #end
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #if ( #TEXT(Input_CITY) <> '' )
      self.CITY := (typeof(self.CITY))le.Input_CITY;
    #end
    #if ( #TEXT(Input_STATE) <> '' )
      self.STATE := (typeof(self.STATE))le.Input_STATE;
    #end
    #if ( #TEXT(Input_SSN5) <> '' )
      self.SSN5 := (typeof(self.SSN5))le.Input_SSN5;
    #end
    #if ( #TEXT(Input_SSN4) <> '' )
      self.SSN4 := (typeof(self.SSN4))le.Input_SSN4;
    #end
  end;
  #uniquename(p)
  %p% := project(Infile,%trans%(left));
  output_file := PersonLinkingADL2V3.Key_PersonHeader_PH.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := dataset([],PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
end;
