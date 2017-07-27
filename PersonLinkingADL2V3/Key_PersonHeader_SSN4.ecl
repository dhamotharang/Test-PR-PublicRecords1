/*2011-08-04T12:33:37Z (Jose Bello)
Bug: 84022
*/
export Key_PersonHeader_SSN4 := MODULE
import SALT20,ut,doxie;
import PersonLinkingADL2; // Import modules for  attribute definitions
shared h := CandidatesForKey;//The input file - distributed by DID
layout := record // project out required fields
// Compulsory and optional fields
  h.SSN4;
  h.FNAME_PreferredName;
  h.FNAME;
  h.LNAME;
  h.DID; // using existing id field
// Extra credit fields
  h.DOB_year;
  h.DOB_month;
  h.DOB_day;
  h.SSN5;
//Scores for various field components
  h.SSN4_weight100 ; // Contains 100x the specificity
  unsigned2 SSN4_e1_Weight100 := h.SSN4_weight100 + 100*log(h.SSN4_cnt/h.SSN4_e1_cnt)/log(2); // Precompute edit-distance specificity
  h.FNAME_weight100 ; // Contains 100x the specificity
  h.FNAME_p_Weight100;
  h.FNAME_e2_Weight100;
  h.FNAME_e2p_Weight100;
  h.FNAME_PreferredName_Weight100;
  h.LNAME_weight100 ; // Contains 100x the specificity
  h.LNAME_p_Weight100;
  h.LNAME_e2_Weight100;
  h.LNAME_e2p_Weight100;
  h.DOB_year_weight100 ; // Contains 100x the specificity
  h.DOB_month_weight100 ; // Contains 100x the specificity
  h.DOB_day_weight100 ; // Contains 100x the specificity
  h.SSN5_weight100 ; // Contains 100x the specificity
  unsigned2 SSN5_e1_Weight100 := h.SSN5_weight100 + 100*log(h.SSN5_cnt/h.SSN5_e1_cnt)/log(2); // Precompute edit-distance specificity
END;
s := Specificities(File_PersonHeader).Specificities[1];
DataForKey0 := dedup(sort(table(h(SSN4 NOT IN SET(s.nulls_SSN4,SSN4),FNAME NOT IN SET(s.nulls_FNAME,FNAME)),layout),whole record,local),whole record,local); // Project out the fields in match candidates required for this linkpath
export Key := index(DataForKey0,,ut.Data_Location.Person_header+'thor_data400::key::PersonLinkingADL2V3PersonHeaderSSN4Refs_' + doxie.version_superkey);
export RawFetch( typeof(h.SSN4) param_SSN4, typeof(h.FNAME) param_FNAME, typeof(h.LNAME) param_LNAME) := 
    STEPPED( LIMIT( Key(
          ( SSN4 = param_SSN4 and param_SSN4 <> (typeof(SSN4))'' )
      AND ( FNAME = param_FNAME AND FNAME_PreferredName = PersonLinkingADL2.FNPreferName(param_FNAME)  and param_FNAME <> (typeof(FNAME))'' )
      AND ( LNAME = param_LNAME or LNAME = (typeof(LNAME))'' or param_LNAME = (typeof(LNAME))'' or metaphonelib.DMetaPhone1(LNAME)=metaphonelib.DMetaPhone1(param_LNAME) or PersonLinkingADL2V3.WithinEditX(LNAME,param_LNAME, Constants.LNAME_LENGTH_EDIT2)  )),5000,skip,keyed),DID);
export ScoredDIDFetch( typeof(h.SSN4) param_SSN4, typeof(h.FNAME) param_FNAME, typeof(h.LNAME) param_LNAME,UNSIGNED4 param_DOB, typeof(h.SSN5) param_SSN5) := FUNCTION
  RawData := RawFetch(param_SSN4,param_FNAME,param_LNAME);
  Process_xADL2_Layouts.LayoutScoredFetch Score(RawData le) := transform
    self.keys_used := 1 << 7; // Set bitmap for key used
    self.SSN4Weight := IF ( le.SSN4 <> param_SSN4,0,(le.SSN4_weight100+50)/100);
    self.FNAMEWeight := IF ( le.FNAME <> param_FNAME,0,(le.FNAME_weight100+50)/100);
    self.LNAMEWeight := (50+MAP ( le.LNAME = param_LNAME  => le.LNAME_weight100,
           le.LNAME = (typeof(le.LNAME))'' or param_LNAME = (typeof(param_LNAME))'' => 0,
           PersonLinkingADL2V3.WithinEditX(le.LNAME,param_LNAME, Constants.LNAME_LENGTH_EDIT2) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME),le.LNAME_e2p_weight100,le.LNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(param_LNAME)=>le.LNAME_p_weight100,
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
    self.SSN5Weight := (50+MAP ( le.SSN5 = param_SSN5  => le.SSN5_weight100,
           le.SSN5 = (typeof(le.SSN5))'' or param_SSN5 = (typeof(param_SSN5))'' => 0,
           ut.WithinEditN(le.SSN5,param_SSN5,1) => le.SSN5_e1_weight100,
           0))/100;
    self.Weight :=self.SSN4Weight +self.FNAMEWeight +self.LNAMEWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +self.SSN5Weight;
    self := le;
  end;
  return rollup(project(nofold(RawData),Score(left)),left.DID = right.DID,Process_xADL2_Layouts.combine_scores(left,right));
end;
//Now code for the Thor batch version of the computation
// First the 'clean' functional interface
EXPORT InputLayout_Batch := RECORD
  SALT20.UIDType Reference;//How to recognize this record in the subsequent
  typeof(h.SSN4) SSN4 := (typeof(h.SSN4))'';
  typeof(h.FNAME) FNAME := (typeof(h.FNAME))'';
  typeof(h.LNAME) LNAME := (typeof(h.LNAME))'';
  unsigned4 DOB := 0;
  typeof(h.SSN5) SSN5 := (typeof(h.SSN5))'';
END;
EXPORT ScoredFetch_Batch(DATASET(InputLayout_Batch) recs,BOOLEAN AsIndex) := FUNCTION
  Process_xADL2_Layouts.LayoutScoredFetch Score_Batch(Key le,recs ri) := transform
    self.Reference := ri.reference; // Copy reference field
    self.keys_used := 1 << 7; // Set bitmap for key used
    self.SSN4Weight := IF ( le.SSN4 <> ri.SSN4,0,(le.SSN4_weight100+50)/100);
    self.FNAMEWeight := IF ( le.FNAME <> ri.FNAME,0,(le.FNAME_weight100+50)/100);
    self.LNAMEWeight := (50+MAP ( le.LNAME = ri.LNAME  => le.LNAME_weight100,
           le.LNAME = (typeof(le.LNAME))'' or ri.LNAME = (typeof(ri.LNAME))'' => 0,
           PersonLinkingADL2V3.WithinEditX(le.LNAME,ri.LNAME, Constants.LNAME_LENGTH_EDIT2) => IF( metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME),le.LNAME_e2p_weight100,le.LNAME_e2_weight100),
           metaphonelib.DMetaPhone1(le.LNAME)=metaphonelib.DMetaPhone1(ri.LNAME)=>le.LNAME_p_weight100,
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
    self.SSN5Weight := (50+MAP ( le.SSN5 = ri.SSN5  => le.SSN5_weight100,
           le.SSN5 = (typeof(le.SSN5))'' or ri.SSN5 = (typeof(ri.SSN5))'' => 0,
           ut.WithinEditN(le.SSN5,ri.SSN5,1) => le.SSN5_e1_weight100,
           0))/100;
    self.Weight :=self.SSN4Weight +self.FNAMEWeight +self.LNAMEWeight + self.DOBWeight_year + self.DOBWeight_month + self.DOBWeight_day +self.SSN5Weight;
    self := le;
  end;
J0 := JOIN(Recs(SSN4 <> (typeof(SSN4))'',FNAME <> (typeof(FNAME))''),Key,LEFT.SSN4 = RIGHT.SSN4
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND ( LEFT.LNAME = RIGHT.LNAME OR LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR PersonLinkingADL2V3.WithinEditX(LEFT.LNAME,RIGHT.LNAME, Constants.LNAME_LENGTH_EDIT2) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.SSN4 = RIGHT.SSN4
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) ,5000)); // Use indexed join (used for smaller batches
J1 := JOIN(Recs(SSN4 <> (typeof(SSN4))'',FNAME <> (typeof(FNAME))''),PULL(Key),LEFT.SSN4 = RIGHT.SSN4
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) 
     AND ( LEFT.LNAME = RIGHT.LNAME OR LEFT.LNAME = (TYPEOF(LEFT.LNAME))'' OR RIGHT.LNAME = (TYPEOF(RIGHT.LNAME))'' OR metaphonelib.DMetaPhone1(LEFT.LNAME)=metaphonelib.DMetaPhone1(RIGHT.LNAME) OR PersonLinkingADL2V3.WithinEditX(LEFT.LNAME,RIGHT.LNAME, Constants.LNAME_LENGTH_EDIT2) ),Score_Batch(RIGHT,LEFT),
    ATMOST(LEFT.SSN4 = RIGHT.SSN4
     AND LEFT.FNAME = RIGHT.FNAME AND RIGHT.FNAME_PreferredName = PersonLinkingADL2.FNPreferName(LEFT.FNAME) ,5000),HASH); // PULL used to cause non-indexed join
  RETURN IF(AsIndex,J0,J1);
END;
// Now the sloppier macro to allow processing of an 'arbitrary' file
export MAC_ScoredFetch_Batch(InFile,Input_Ref,Input_SSN4='',Input_FNAME='',Input_LNAME='',Input_DOB='',Input_SSN5='',output_file,AsIndex='true') := MACRO
#IF(#TEXT(Input_SSN4)<>'' AND #TEXT(Input_FNAME)<>'')
  #uniquename(trans)
  PersonLinkingADL2V3.Key_PersonHeader_SSN4.InputLayout_Batch %trans%(InFile le) := transform
    self.Reference := le.Input_Ref;
    self.SSN4 := (typeof(self.SSN4))le.Input_SSN4;
    self.FNAME := (typeof(self.FNAME))le.Input_FNAME;
    #if ( #TEXT(Input_LNAME) <> '' )
      self.LNAME := (typeof(self.LNAME))le.Input_LNAME;
    #end
    #if ( #TEXT(Input_DOB) <> '' )
      self.DOB := (unsigned4)le.Input_DOB;
    #end
    #if ( #TEXT(Input_SSN5) <> '' )
      self.SSN5 := (typeof(self.SSN5))le.Input_SSN5;
    #end
  end;
  #uniquename(p)
  %p% := project(Infile,%trans%(left));
  output_file := PersonLinkingADL2V3.Key_PersonHeader_SSN4.ScoredFetch_Batch(%p%,AsIndex);
#ELSE
  output_file := dataset([],PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch); // Compulsory fields missing
#END
ENDMACRO;
end;
