export Key_PersonHeader_ := MODULE
import SALT20,ut;
import PersonLinkingADL2; // Import modules for  attribute definitions
shared h := CandidatesForKey;//The input file - distributed by DID
SALT20.Layout_Uber_Plus IntoInversion(h le,unsigned2 c) := transform
  self.word := choose(c,(string)le.NAME_SUFFIX,(string)le.FNAME,(string)le.MNAME,(string)le.LNAME,(string)le.PRIM_RANGE,(string)le.PRIM_NAME,(string)le.SEC_RANGE,(string)le.CITY,(string)le.STATE,(string)le.ZIP,(string)le.ZIP4,(string)le.COUNTY,(string)le.SSN5,(string)le.SSN4,(string)(le.DOB_year*10000+le.DOB_month*100+le.DOB_day),(string)le.PHONE,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  self.field := c;
  self.uid := le.DID
end;
nfields_r := SALT20.Fn_Reduce_UBER_Local(normalize(h,21,IntoInversion(left,counter))(word<>''));
SALT20.MAC_Expand_Normal_Field(h,FNAME,17,DID,nfields4352);
SALT20.MAC_Expand_Normal_Field(h,MNAME,17,DID,nfields4353);
SALT20.MAC_Expand_Normal_Field(h,LNAME,17,DID,nfields4354);
nfields17 := nfields4352+nfields4353+nfields4354;//Collect wordbags for parts of concept field
SALT20.MAC_Expand_Normal_Field(h,FNAME,18,DID,nfields1179648);
SALT20.MAC_Expand_Normal_Field(h,MNAME,18,DID,nfields1179649);
SALT20.MAC_Expand_Normal_Field(h,LNAME,18,DID,nfields1179650);
nfields4608 := nfields1179648+nfields1179649+nfields1179650;//Collect wordbags for parts of concept field
SALT20.MAC_Expand_Normal_Field(h,NAME_SUFFIX,18,DID,nfields4609);
nfields18 := nfields4608+nfields4609;//Collect wordbags for parts of concept field
SALT20.MAC_Expand_Normal_Field(h,PRIM_RANGE,19,DID,nfields4864);
SALT20.MAC_Expand_Normal_Field(h,PRIM_NAME,19,DID,nfields4865);
SALT20.MAC_Expand_Normal_Field(h,SEC_RANGE,19,DID,nfields4866);
SALT20.MAC_Expand_Normal_Field(h,ZIP4,19,DID,nfields4867);
nfields19 := nfields4864+nfields4865+nfields4866+nfields4867;//Collect wordbags for parts of concept field
SALT20.MAC_Expand_Normal_Field(h,COUNTY,20,DID,nfields5120);
SALT20.MAC_Expand_Normal_Field(h,CITY,20,DID,nfields5121);
SALT20.MAC_Expand_Normal_Field(h,STATE,20,DID,nfields5122);
SALT20.MAC_Expand_Normal_Field(h,ZIP,20,DID,nfields5123);
nfields20 := nfields5120+nfields5121+nfields5122+nfields5123;//Collect wordbags for parts of concept field
SALT20.MAC_Expand_Normal_Field(h,PRIM_RANGE,21,DID,nfields1376256);
SALT20.MAC_Expand_Normal_Field(h,PRIM_NAME,21,DID,nfields1376257);
SALT20.MAC_Expand_Normal_Field(h,SEC_RANGE,21,DID,nfields1376258);
SALT20.MAC_Expand_Normal_Field(h,ZIP4,21,DID,nfields1376259);
nfields5376 := nfields1376256+nfields1376257+nfields1376258+nfields1376259;//Collect wordbags for parts of concept field
SALT20.MAC_Expand_Normal_Field(h,COUNTY,21,DID,nfields1376512);
SALT20.MAC_Expand_Normal_Field(h,CITY,21,DID,nfields1376513);
SALT20.MAC_Expand_Normal_Field(h,STATE,21,DID,nfields1376514);
SALT20.MAC_Expand_Normal_Field(h,ZIP,21,DID,nfields1376515);
nfields5377 := nfields1376512+nfields1376513+nfields1376514+nfields1376515;//Collect wordbags for parts of concept field
nfields21 := nfields5376+nfields5377;//Collect wordbags for parts of concept field
invert_records := nfields_r;
shared DataForKey0 := SALT20.Fn_Reduce_UBER_Local( invert_records );
  r0 := record
    DataForKey0.uid;
    unsigned6 InCluster := count(group);
  end;
  shared ClusterSizes := table(DataForKey0,r0,uid,local);// Set up for Specificity_Local
  SALT20.MAC_Specificity_Local(DataForKey0,word,uid,word_nulls,SALT20.Layout_Uber_Nulls,word_specificity,word_switch,word_values);
export ValueKey := index(word_values,{word},{word_values},'~key::PRTE_PersonLinkingADL2V3PersonHeaderWords');
  SALT20.Layout_Uber_Plus add_id(SALT20.Layout_Uber_Plus le,word_values ri,boolean patch_default) := transform
    self.word_id := ri.id;
    self := le;
  end;
  SALT20.Mac_Choose_JoinType(DataForKey0,word_nulls,word_values,word,word_weight100,add_id,DataForKey1);
  SALT20.Layout_Uber_Record slim(DataForKey1 le) := transform
    self := le;
  end;
  DataForKey2 := sort(project(DataForKey1,slim(left)),whole record,skew(1));
export Key := index(DataForKey2,{DataForKey2},{},'~key::PRTE_PersonLinkingADL2V3PersonHeaderRefs');
export RawFetch( typeof(h.NAME_SUFFIX) param_NAME_SUFFIX, typeof(h.FNAME) param_FNAME, typeof(h.MNAME) param_MNAME, typeof(h.LNAME) param_LNAME, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.CITY) param_CITY, typeof(h.STATE) param_STATE, typeof(h.ZIP) param_ZIP, typeof(h.ZIP4) param_ZIP4, typeof(h.COUNTY) param_COUNTY, typeof(h.SSN5) param_SSN5, typeof(h.SSN4) param_SSN4,UNSIGNED4 param_DOB, typeof(h.PHONE) param_PHONE,STRING param_MAINNAME,STRING param_FULLNAME,STRING param_ADDR1,STRING param_LOCALE,STRING param_ADDRS) := 
  FUNCTION
 //Create wordstream from parameters
    SALT20.MAC_Field_To_UberStream(param_NAME_SUFFIX,1,ValueKey,WS1);
    SALT20.MAC_Field_To_UberStream(param_FNAME,2,ValueKey,WS2);
    SALT20.MAC_Field_To_UberStream(param_MNAME,3,ValueKey,WS3);
    SALT20.MAC_Field_To_UberStream(param_LNAME,4,ValueKey,WS4);
    SALT20.MAC_Field_To_UberStream(param_PRIM_RANGE,5,ValueKey,WS5);
    SALT20.MAC_Field_To_UberStream(param_PRIM_NAME,6,ValueKey,WS6);
    SALT20.MAC_Field_To_UberStream(param_SEC_RANGE,7,ValueKey,WS7);
    SALT20.MAC_Field_To_UberStream(param_CITY,8,ValueKey,WS8);
    SALT20.MAC_Field_To_UberStream(param_STATE,9,ValueKey,WS9);
    SALT20.MAC_Field_To_UberStream(param_ZIP,10,ValueKey,WS10);
    SALT20.MAC_Field_To_UberStream(param_ZIP4,11,ValueKey,WS11);
    SALT20.MAC_Field_To_UberStream(param_COUNTY,12,ValueKey,WS12);
    SALT20.MAC_Field_To_UberStream(param_SSN5,13,ValueKey,WS13);
    SALT20.MAC_Field_To_UberStream(param_SSN4,14,ValueKey,WS14);
    SALT20.MAC_Field_To_UberStream(param_DOB,15,ValueKey,WS15);
    SALT20.MAC_Field_To_UberStream(param_PHONE,16,ValueKey,WS16);
    SALT20.MAC_Field_To_UberStream(param_MAINNAME,17,ValueKey,WS17);
    SALT20.MAC_Field_To_UberStream(param_FULLNAME,18,ValueKey,WS18);
    SALT20.MAC_Field_To_UberStream(param_ADDR1,19,ValueKey,WS19);
    SALT20.MAC_Field_To_UberStream(param_LOCALE,20,ValueKey,WS20);
    SALT20.MAC_Field_To_UberStream(param_ADDRS,21,ValueKey,WS21);
    wds := WS1+WS2+WS3+WS4+WS5+WS6+WS7+WS8+WS9+WS10+WS11+WS12+WS13+WS14+WS15+WS16+WS17+WS18+WS19+WS20+WS21;
    SALT20.MAC_Collate_Uber_Matches(Key,Wds,steppedmatches);
    return steppedmatches;
  END;
export ScoredDIDFetch( typeof(h.NAME_SUFFIX) param_NAME_SUFFIX, typeof(h.FNAME) param_FNAME, typeof(h.MNAME) param_MNAME, typeof(h.LNAME) param_LNAME, typeof(h.PRIM_RANGE) param_PRIM_RANGE, typeof(h.PRIM_NAME) param_PRIM_NAME, typeof(h.SEC_RANGE) param_SEC_RANGE, typeof(h.CITY) param_CITY, typeof(h.STATE) param_STATE, typeof(h.ZIP) param_ZIP, typeof(h.ZIP4) param_ZIP4, typeof(h.COUNTY) param_COUNTY, typeof(h.SSN5) param_SSN5, typeof(h.SSN4) param_SSN4,UNSIGNED4 param_DOB, typeof(h.PHONE) param_PHONE,STRING param_MAINNAME,STRING param_FULLNAME,STRING param_ADDR1,STRING param_LOCALE,STRING param_ADDRS) := FUNCTION
  RawData := RawFetch(param_NAME_SUFFIX,param_FNAME,param_MNAME,param_LNAME,param_PRIM_RANGE,param_PRIM_NAME,param_SEC_RANGE,param_CITY,param_STATE,param_ZIP,param_ZIP4,param_COUNTY,param_SSN5,param_SSN4,param_DOB,param_PHONE,param_MAINNAME,param_FULLNAME,param_ADDR1,param_LOCALE,param_ADDRS);
  Process_xADL2_Layouts.LayoutScoredFetch Score(RawData le) := transform
    self.keys_used := 1 << 0; // Set bitmap for key used
    self.DID := le.uid;
    self.Weight := le.Weight; // Already rolled up in collate_uber
    self := le;
  end;
  return rollup(project(nofold(RawData),Score(left)),left.DID = right.DID,Process_xADL2_Layouts.combine_scores(left,right));
end;
end;
