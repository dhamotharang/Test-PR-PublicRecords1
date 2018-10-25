EXPORT macxLinkingWithDescriptions(infile, Input_SNAME = '', Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_Gender = '', Input_Derived_Gender = '',
														Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',
														Input_DOB = '', Input_Phone = '', Input_DL_STATE = '',Input_DL_NBR = '', 
														weight_score = 30, Distance = 3, Segmentation = true, forceIndex=true, in_prefix = 'Adl') := FUNCTIONMACRO

IMPORT UT;
IMPORT RAMPS;
IMPORT InsuranceHeader_xLink;
IMPORT hipie_ecl;

 layout := RECORD
  RECORDOF(infile);
  unsigned6 prefix_Lexid;
  unsigned2 xadl2_weight;
  unsigned2 xadl2_score;
  unsigned4 xadl2_keys_used;
  unsigned2 xadl2_distance;
  string20 xadl2_matches;
  string xadl2_keys_desc;
  string xadl2_matches_desc;
 END;

extendedLayout := RECORD
 layout,
 InsuranceHeader_xLink.DebugFields 
END;
                          

 ds := PROJECT(infile, 
   TRANSFORM( extendedLayout, SELF := LEFT, self := []));

 RAMPS.mac_xLinking_on_thor_Boca (ds, prefix_Lexid, Input_SNAME, Input_FNAME,Input_MNAME,Input_LNAME,Input_Gender, Input_Derived_Gender,
														Input_PRIM_NAME,Input_PRIM_RANGE,Input_SEC_RANGE,Input_CITY,Input_ST,Input_ZIP,Input_SSN,
														Input_DOB, Input_Phone, Input_DL_STATE,Input_DL_NBR, 
														outfile, weight_score, Distance, Segmentation, forceIndex);

 xlinkResultsPrep := PROJECT(outfile, TRANSFORM(extendedLayout,
  self.xlink_keys_desc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.xlink_keys);
  self.xlink_matches_desc := InsuranceHeader_xLink.fn_MatchesToText(left.xlink_matches);
  self := left; 
  )); 

 xlinkResultsPrep1 := hipie_ecl.macFieldRename(xlinkResultsPrep, in_prefix, 'prefix_',,TRUE);
 xlinkResultsPrep2 := hipie_ecl.macFieldRename(xlinkResultsPrep1, in_prefix + '_xadl2_', 'xadl2_',,TRUE);
 xlinkResultsPrep3 := hipie_ecl.macFieldRename(xlinkResultsPrep2, in_prefix + '_xlink_', 'xlink_',,TRUE);
 RETURN xlinkResultsPrep3;
 
ENDMACRO;