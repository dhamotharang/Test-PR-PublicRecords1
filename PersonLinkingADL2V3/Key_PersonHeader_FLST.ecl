export Key_PersonHeader_FLST := MODULE
import SALT20,ut;
import PersonLinkingADL2; // Import modules for  attribute definitions
shared h := CandidatesForKey;//The input file - distributed by DID
layout := record // project out required fields
// Compulsory fields
  h.FNAME_PreferredName;
  h.FNAME;
  h.LNAME;
  h.STATE;
// Optional fields
  h.DID; // The ID field
  h.MNAME;
// Extra credit fields
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.CITY;
//Scores for various field components
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_e2p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_e2p_Weight100;
  h.STATE_weight100 ; // Contains 100x the specificity
  h.MNAME_weight100 ; // Contains 100x the specificity
  h.MNAME_e2_Weight100;
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  h.CITY_weight100 ; // Contains 100x the specificity
  UNSIGNED2 MNAME_initial_weight100 := 0; // Weight if only first character matches
END;
s := Specificities(File_PersonHeader).Specificities[1];
DataForKey0 := dedup(sort(table(h(FNAME NOT IN SET(s.nulls_FNAME,FNAME),LNAME NOT IN SET(s.nulls_LNAME,LNAME),STATE NOT IN SET(s.nulls_STATE,STATE)),layout),whole record,local),whole record,local); // Project out the fields in match candidates required for this linkpath
layout note_init3(layout le,Specificities(File_PersonHeader).MNAME_values_persisted ri) := transform
  self.MNAME_initial_weight100 := ri.field_specificity * 100;
  self := le;
end;
DataForKey3 := join(DataForKey0,Specificities(File_PersonHeader).MNAME_values_persisted(length(trim(MNAME))=1),left.MNAME[1]=right.MNAME[1],note_init3(left,right),lookup,left outer); // Append specificities for initials of MNAME
export Key := index(DataForKey3,,PersonLinkingADL2V3.Filename_keys.kFLST);
export RawFetch( typeof(h.FNAME) param_FNAME, typeof(h.LNAME) param_LNAME, typeof(h.STATE) param_STATE, typeof(h.MNAME) param_MNAME) := 
    STEPPED( LIMIT( Key(
          ( FNAME = param_FNAME AND FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME)  AND param_FNAME <> (TYPEOF(FNAME))'' )
      AND ( LNAME = param_LNAME AND param_LNAME <> (TYPEOF(LNAME))'' )
      AND ( STATE = param_STATE AND param_STATE <> (TYPEOF(STATE))'' )
      AND ( MNAME[1..LENGTH(TRIM(param_MNAME))] = param_MNAME OR param_MNAME[1..LENGTH(TRIM(MNAME))] = MNAME OR ut.WithinEditN(MNAME,param_MNAME,2)  )),5000,skip,keyed),DID);
export ScoredDIDFetch( typeof(h.FNAME) param_FNAME, typeof(h.LNAME) param_LNAME, typeof(h.STATE) param_STATE, typeof(h.MNAME) param_MNAME,UNSIGNED4 param_DOB, typeof(h.CITY) param_CITY) := FUNCTION
  RawData := RawFetch(param_FNAME,param_LNAME,param_STATE,param_MNAME);
  Process_xADL2_Layouts.LayoutScoredFetch Score(RawData le) := transform
    self.keys_used := 1 << 1; // Set bitmap for key used
    self.FNAMEWeight := IF ( le.FNAME <> param_FNAME,0,(le.FNAME_weight100+50)/100);
    self.LNAMEWeight := IF ( le.LNAME <> param_LNAME,0,(le.LNAME_weight100+50)/100);
    self.STATEWeight := IF ( le.STATE <> param_STATE,0,(le.STATE_weight100+50)/100);
    self.MNAMEWeight := (50+MAP ( le.MNAME = param_MNAME  => le.MNAME_weight100,
           le.MNAME = (typeof(le.MNAME))'' or param_MNAME = (typeof(param_MNAME))'' => 0,
           le.MNAME = param_MNAME[1..length(trim(le.MNAME))] => le.MNAME_weight100,
           ut.WithinEditN(le.MNAME,param_MNAME,2) => le.MNAME_e2_weight100,
           le.MNAME[1..length(trim(param_MNAME))] = param_MNAME => SALT20.Fn_Interpolate_Initial(le.MNAME,param_MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
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
    self.CITYWeight := (50+MAP ( le.CITY = param_CITY  => le.CITY_weight100,
           le.CITY = (typeof(le.CITY))'' or param_CITY = (typeof(param_CITY))'' => 0,
           0))/100;
    self.Weight :=self.FNAMEWeight +self.LNAMEWeight +self.STATEWeight +self.MNAMEWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +self.CITYWeight;
    self := le;
  end;
  return rollup(project(nofold(RawData),Score(left)),left.DID = right.DID,Process_xADL2_Layouts.combine_scores(left,right));
end;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT20.UIDType Reference;//How to recognize this record in the subsequent
  typeof(h.FNAME) FNAME := (typeof(h.FNAME))'';
  typeof(h.LNAME) LNAME := (typeof(h.LNAME))'';
  typeof(h.STATE) STATE := (typeof(h.STATE))'';
  typeof(h.MNAME) MNAME := (typeof(h.MNAME))'';
  unsigned4 DOB := 0;
  typeof(h.CITY) CITY := (typeof(h.CITY))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xADL2_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := transform
    self.Reference := ri.reference; // Copy reference field
    self.keys_used := 1 << 1; // Set bitmap for key used
    self.FNAMEWeight := IF ( le.FNAME <> ri.FNAME,0,(le.FNAME_weight100+50)/100);
    self.LNAMEWeight := IF ( le.LNAME <> ri.LNAME,0,(le.LNAME_weight100+50)/100);
    self.STATEWeight := IF ( le.STATE <> ri.STATE,0,(le.STATE_weight100+50)/100);
    self.MNAMEWeight := (50+MAP ( le.MNAME = ri.MNAME  => le.MNAME_weight100,
           le.MNAME = (typeof(le.MNAME))'' or ri.MNAME = (typeof(ri.MNAME))'' => 0,
           le.MNAME = ri.MNAME[1..length(trim(le.MNAME))] => le.MNAME_weight100,
           ut.WithinEditN(le.MNAME,ri.MNAME,2) => le.MNAME_e2_weight100,
           le.MNAME[1..length(trim(ri.MNAME))] = ri.MNAME => SALT20.Fn_Interpolate_Initial(le.MNAME,ri.MNAME,le.MNAME_weight100,le.MNAME_initial_weight100), // later in sequence as less accurate
           0))/100;
					 
					 
		unsigned2 temp_DOBWeight_year := (50+MAP ( le.DOB_year = 0 => 0,
       le.DOB_year = ((unsigned)ri.DOB) div 10000  => le.DOB_year_weight100,
       ABS(le.DOB_year - ((unsigned)ri.DOB) div 10000) < 2  => le.DOB_year_weight100-158, //YEAR_SHIFT
      0))/100;
    unsigned2 temp_DOBWeight_month := (50+MAP ( le.DOB_month = 0 => 0,
      le.DOB_month = ((unsigned)ri.DOB) div 100 % 100  => le.DOB_month_weight100,
      le.DOB_month = 1 AND le.DOB_day = 1 => +0, // SOFT1 
      le.DOB_month = ((unsigned)ri.DOB) % 100 AND le.DOB_day = ((unsigned)ri.DOB) div 100 % 100 => le.DOB_month_weight100-100, // MDDM
      0))/100;
    unsigned2 temp_DOBWeight_day := (50+MAP ( le.DOB_day = 0 => 0,
      le.DOB_day = ((unsigned)ri.DOB) % 100  => le.DOB_day_weight100,
      le.DOB_day = 1 => 0, // SOFT1 
      le.DOB_month = ((unsigned)ri.DOB) % 100 AND le.DOB_day = ((unsigned)ri.DOB) div 100 % 100 => le.DOB_day_weight100-100, // MDDM
      0))/100;
			
		boolean goodDobWeight := 	IF(temp_DOBWeight_year <> 0 or (temp_DOBWeight_month <> 0 and temp_DOBWeight_day <> 0),
														TRUE, FALSE);
		
    self.DOBWeight_year := IF(goodDobWeight, temp_DOBWeight_year, 0);
    self.DOBWeight_month := IF(goodDobWeight, temp_DOBWeight_month, 0);
    self.DOBWeight_day := IF(goodDobWeight, temp_DOBWeight_day, 0);
		
		self.CITYWeight := (50+MAP ( le.CITY = ri.CITY  => le.CITY_weight100,
           le.CITY = (typeof(le.CITY))'' or ri.CITY = (typeof(ri.CITY))'' => 0,
           0))/100;
    self.Weight :=self.FNAMEWeight +self.LNAMEWeight +self.STATEWeight +self.MNAMEWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +self.CITYWeight;
    self := le;
  end;
J0 := JOIN(Recs(FNAME <> (typeof(FNAME))'',LNAME <> (typeof(LNAME))'',STATE <> (typeof(STATE))''),Key,LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.STATE = RIGHT.STATE
     AND ( LEFT.MNAME = RIGHT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR ut.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.STATE = RIGHT.STATE,50)); // Use indexed join (used for smaller batches
J1 := JOIN(Recs(FNAME <> (typeof(FNAME))'',LNAME <> (typeof(LNAME))'',STATE <> (typeof(STATE))''),PULL(Key),LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.STATE = RIGHT.STATE
     AND ( LEFT.MNAME = RIGHT.MNAME OR LEFT.MNAME[1..LENGTH(TRIM(RIGHT.MNAME))] = RIGHT.MNAME OR RIGHT.MNAME[1..LENGTH(TRIM(LEFT.MNAME))] = LEFT.MNAME OR ut.WithinEditN(LEFT.MNAME,RIGHT.MNAME,2) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND LEFT.LNAME = RIGHT.LNAME
     AND LEFT.STATE = RIGHT.STATE,50),HASH); // PULL used to cause non-indexed join
  RETURN IF(AsIndex,J0,J1);
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
export MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_FNAME='',Input_LNAME='',Input_STATE='',Input_MNAME='',Input_DOB='',Input_CITY='',output_file,AsIndex='true') := MACRO
#IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_STATE)<>'')
  #uniquename(trans)
  PersonLinkingADL2V3.Key_PersonHeader_FLST.InputLayout_Batch %trans%(InFile le) := transform
    self.Reference := le.Input_Ref;
    self.FNAME := (typeof(self.FNAME))le.Input_FNAME;
    self.LNAME := (typeof(self.LNAME))le.Input_LNAME;
    self.STATE := (typeof(self.STATE))le.Input_STATE;
    #if ( #TEXT(Input_MNAME) <> '' )
      self.MNAME := (typeof(self.MNAME))le.Input_MNAME;
    #end
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #if ( #TEXT(Input_CITY) <> '' )
      self.CITY := (typeof(self.CITY))le.Input_CITY;
    #end
  end;
  #uniquename(p)
  %p% := project(Infile,%trans%(left));
  output_file := PersonLinkingADL2V3.Key_PersonHeader_FLST.ScoredFetch_Batch(%p%,AsIndex);	
#ELSE
  output_file := dataset([],PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
end;
