// Begin code to perform the matching itself
 
IMPORT SALT311,std,ut/*HACK01c*/;
EXPORT matches(DATASET(layout_Address_Link) ih, UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED IntraMatchThreshold := LowerMatchThreshold - Config.SliceDistance;
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  		 /*BEGIN HACK01a*/
	  nbrsOnly (string str) := REGEXREPLACE('[^0-9]',str,'');
    notNull  (string str) := nbrsOnly(str) <> '';
		isNullx   (string str) := nbrsOnly(str) =  '';
		hasMatch (string str1, string str2) := IF(ut.nowords(str2) = 1 AND length(nbrsOnly(str2)) > 1,datalib.stringfind(str1,nbrsOnly(str2),1) > 0,FALSE);
		isRangeNameMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.prim_name,ri.prim_range)) OR 
		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.prim_name,le.prim_range));
		isRangeSecMatch  := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.sec_range_num,ri.prim_range)) OR 
		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.sec_range_num,le.prim_range));
		isSecNameMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and hasMatch(le.prim_name,ri.sec_range_num))  OR 
		                    (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and hasMatch(ri.prim_name,le.sec_range_num));
		isRangeNameMisMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and 
		                            notNull(le.prim_name) and not datalib.stringfind(le.prim_name,nbrsOnly(ri.prim_range),1) > 0) OR
		                       (isNullx(ri.prim_range) and notNull(le.prim_range) and isNullx(le.sec_range_num) and isNullx(ri.sec_range_num) and 
													      notNull(ri.prim_name) and not datalib.stringfind(ri.prim_name,nbrsOnly(le.prim_range),1) > 0);
		isRangeSecMisMatch  := (isNullx(le.prim_range)        and notNull(ri.prim_range) and isNullx(nbrsOnly(le.prim_name)) and isNullx(nbrsOnly(ri.prim_name)) and
		                            notNull(le.sec_range_num) and datalib.stringfind(le.sec_range_num,nbrsOnly(ri.prim_range),1) = 0) OR
		                       (isNullx(ri.prim_range)        and notNull(le.prim_range) and 
													      notNull(ri.sec_range_num) and datalib.stringfind(ri.sec_range_num,nbrsOnly(le.prim_range),1) = 0);
		isSecNameMisMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and
		                            notNull(le.prim_name)  and datalib.stringfind(le.prim_name,nbrsOnly(ri.sec_range_num),1) = 0) OR
		                       (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and
													      notNull(ri.prim_name)  and datalib.stringfind(ri.prim_name,nbrsOnly(le.sec_range_num),1) = 0);
		bonus := MAP(isRangeNameMatch    or isRangeSecMatch or isSecNameMatch       =>  3,
                 isRangeNameMisMatch or isRangeSecMisMatch or isSecNameMisMatch => -9999,
		             le.prim_name_alpha <> '' and ri.prim_name_alpha = '' and le.prim_name_num = '' and ri.prim_name_num <> '' => -3,
								 ri.prim_name_alpha <> '' and le.prim_name_alpha = '' and ri.prim_name_num = '' and le.prim_name_num <> '' => -3,
								 0);    /*END HACK01a*/
		SELF.Rule := c;
  SELF.ADDRESS_GROUP_ID1 := le.ADDRESS_GROUP_ID;
  SELF.ADDRESS_GROUP_ID2 := ri.ADDRESS_GROUP_ID;
  SELF.RID1 := le.RID;
  SELF.RID2 := ri.RID;
  INTEGER2 DID_score_temp := MAP(
                        le.DID_isnull OR ri.DID_isnull => 0,
                        le.DID = ri.DID  => le.DID_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.DID_weight100,ri.DID_weight100),s.DID_switch));
  REAL addr_score_scale := ( le.addr_weight100 + ri.addr_weight100 ) / (le.prim_range_num_weight100 + ri.prim_range_num_weight100 + le.prim_range_alpha_weight100 + ri.prim_range_alpha_weight100 + le.prim_range_fract_weight100 + ri.prim_range_fract_weight100 + le.prim_name_num_weight100 + ri.prim_name_num_weight100 + le.prim_name_alpha_weight100 + ri.prim_name_alpha_weight100 + le.sec_range_num_weight100 + ri.sec_range_num_weight100 + le.sec_range_alpha_weight100 + ri.sec_range_alpha_weight100); // Scaling factor for this concept
  INTEGER2 addr_score_pre := MAP( (le.addr_isnull OR le.prim_range_num_isnull AND le.prim_range_alpha_isnull AND le.prim_range_fract_isnull AND le.prim_name_num_isnull AND le.prim_name_alpha_isnull AND le.sec_range_num_isnull AND le.sec_range_alpha_isnull) OR (ri.addr_isnull OR ri.prim_range_num_isnull AND ri.prim_range_alpha_isnull AND ri.prim_range_fract_isnull AND ri.prim_name_num_isnull AND ri.prim_name_alpha_isnull AND ri.sec_range_num_isnull AND ri.sec_range_alpha_isnull) => 0,
                        le.addr = ri.addr  => le.addr_weight100,
                        0);
  REAL locale_score_scale := ( le.locale_weight100 + ri.locale_weight100 ) / (le.city_weight100 + ri.city_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 locale_score_pre := MAP( (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        le.locale = ri.locale  => le.locale_weight100,
                        0);
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        locale_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip_weight100,ri.zip_weight100),s.zip_switch))*IF(locale_score_scale=0,1,locale_score_scale);
  INTEGER2 prim_range_num_score_temp := MAP(
                        le.prim_range_num_isnull OR ri.prim_range_num_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_range_num,ri.prim_range_num)  => le.prim_range_num_weight100,
                        SALT311.MatchBagOfWords(le.prim_range_num,ri.prim_range_num,31744,1))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 prim_name_num_score_temp := MAP(
                        le.prim_name_num_isnull OR ri.prim_name_num_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_name_num,ri.prim_name_num)  => le.prim_name_num_weight100,
                        SALT311.MatchBagOfWords(le.prim_name_num,ri.prim_name_num,31744,1))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 prim_range_alpha_score_temp := MAP(
                        le.prim_range_alpha_isnull OR ri.prim_range_alpha_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_alpha = ri.prim_range_alpha  => le.prim_range_alpha_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_alpha_weight100,ri.prim_range_alpha_weight100),s.prim_range_alpha_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 prim_name_alpha_score_temp := MAP(
                        le.prim_name_alpha_isnull OR ri.prim_name_alpha_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_name_alpha,ri.prim_name_alpha) OR SALT311.HyphenMatch(le.prim_name_alpha,ri.prim_name_alpha,1)<=2  => MIN(le.prim_name_alpha_weight100,ri.prim_name_alpha_weight100),
                        SALT311.MatchBagOfWords(le.prim_name_alpha,ri.prim_name_alpha,31755,1))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 prim_range_fract_score_temp := MAP(
                        le.prim_range_fract_isnull OR ri.prim_range_fract_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_fract = ri.prim_range_fract  => le.prim_range_fract_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_fract_weight100,ri.prim_range_fract_weight100),s.prim_range_fract_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 sec_range_alpha_score_temp := MAP(
                        le.sec_range_alpha_isnull OR ri.sec_range_alpha_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_alpha = ri.sec_range_alpha  => le.sec_range_alpha_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_alpha_weight100,ri.sec_range_alpha_weight100),s.sec_range_alpha_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 sec_range_num_score_temp := MAP(
                        le.sec_range_num_isnull OR ri.sec_range_num_isnull => 0,
                        addr_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_num = ri.sec_range_num  => le.sec_range_num_weight100,
                        LENGTH(TRIM(le.sec_range_num))>0 and le.sec_range_num = ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))] => le.sec_range_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.sec_range_num))>0 and ri.sec_range_num = le.sec_range_num[1..LENGTH(TRIM(ri.sec_range_num))] => ri.sec_range_num_weight100, // An initial match - take initial specificity
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_num_weight100,ri.sec_range_num_weight100),s.sec_range_num_switch))*IF(addr_score_scale=0,1,addr_score_scale);
  INTEGER2 city_score := MAP(
                        le.city_isnull OR ri.city_isnull => 0,
                        locale_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.city,ri.city) OR SALT311.HyphenMatch(le.city,ri.city,1)<=2  => MIN(le.city_weight100,ri.city_weight100),
                        SALT311.MatchBagOfWords(le.city,ri.city,31768,1))*IF(locale_score_scale=0,1,locale_score_scale);
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        locale_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.st_weight100,ri.st_weight100),s.st_switch))*IF(locale_score_scale=0,1,locale_score_scale);
  INTEGER2 DID_score_unweighted := IF ( DID_score_temp >= Config.DID_Force * 100, DID_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 DID_score := DID_score_unweighted*0.01; 
  INTEGER2 prim_range_num_score := IF ( prim_range_num_score_temp >= Config.prim_range_num_Force * 100, prim_range_num_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_num_score := IF ( prim_name_num_score_temp >= Config.prim_name_num_Force * 100, prim_name_num_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_alpha_score := IF ( prim_range_alpha_score_temp >= Config.prim_range_alpha_Force * 100, prim_range_alpha_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_alpha_score := IF ( prim_name_alpha_score_temp >= Config.prim_name_alpha_Force * 100, prim_name_alpha_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_fract_score := IF ( prim_range_fract_score_temp >= Config.prim_range_fract_Force * 100, prim_range_fract_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 sec_range_alpha_score := IF ( sec_range_alpha_score_temp >= Config.sec_range_alpha_Force * 100, sec_range_alpha_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 sec_range_num_score := IF ( sec_range_num_score_temp >= Config.sec_range_num_Force * 100, sec_range_num_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp >= Config.st_Force * 100, st_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept addr
  INTEGER2 addr_score_ext := SALT311.ClipScore(MAX(addr_score_pre,0) + prim_range_num_score + prim_range_alpha_score + prim_range_fract_score + prim_name_num_score + prim_name_alpha_score + sec_range_num_score + sec_range_alpha_score);// Score in surrounding context
  INTEGER2 addr_score_res := MAX(0,addr_score_pre); // At least nothing
  INTEGER2 addr_score := IF ( addr_score_ext >= 0,addr_score_res,SKIP);
// Compute the score for the concept locale
  INTEGER2 locale_score_ext := SALT311.ClipScore(MAX(locale_score_pre,0) + city_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 locale_score_res := MAX(0,locale_score_pre); // At least nothing
  INTEGER2 locale_score := locale_score_res;
  // Get propagation scores for individual propagated fields
  INTEGER2 addr_score_prop := IF(le.addr_prop+ri.addr_prop>0,addr_score*(0+IF(le.prim_range_num_prop+ri.prim_range_num_prop>0,s.prim_range_num_specificity,0)+IF(le.prim_range_alpha_prop+ri.prim_range_alpha_prop>0,s.prim_range_alpha_specificity,0)+IF(le.prim_range_fract_prop+ri.prim_range_fract_prop>0,s.prim_range_fract_specificity,0)+IF(le.sec_range_num_prop+ri.sec_range_num_prop>0,s.sec_range_num_specificity,0)+IF(le.sec_range_alpha_prop+ri.sec_range_alpha_prop>0,s.sec_range_alpha_specificity,0))/( s.prim_range_num_specificity+ s.prim_range_alpha_specificity+ s.prim_range_fract_specificity+ s.sec_range_num_specificity+ s.sec_range_alpha_specificity),0);
  INTEGER2 prim_range_num_score_prop := MAX(le.prim_range_num_prop,ri.prim_range_num_prop)*prim_range_num_score; // Score if either field propogated
  INTEGER2 prim_range_alpha_score_prop := MAX(le.prim_range_alpha_prop,ri.prim_range_alpha_prop)*prim_range_alpha_score; // Score if either field propogated
  INTEGER2 prim_range_fract_score_prop := MAX(le.prim_range_fract_prop,ri.prim_range_fract_prop)*prim_range_fract_score; // Score if either field propogated
  INTEGER2 sec_range_alpha_score_prop := MAX(le.sec_range_alpha_prop,ri.sec_range_alpha_prop)*sec_range_alpha_score; // Score if either field propogated
  INTEGER2 sec_range_num_score_prop := (MAX(le.sec_range_num_prop,ri.sec_range_num_prop)/MAX(LENGTH(TRIM(le.sec_range_num)),LENGTH(TRIM(ri.sec_range_num))))*sec_range_num_score; // Proportion of longest string propogated
  SELF.Conf_Prop := (0 + addr_score_prop + prim_range_num_score_prop + prim_range_alpha_score_prop + prim_range_fract_score_prop + sec_range_alpha_score_prop + sec_range_num_score_prop) / 100; // Score based on propogated fields
  iComp := (DID_score + IF(addr_score>0,MAX(addr_score,prim_range_num_score + prim_range_alpha_score + prim_range_fract_score + prim_name_num_score + prim_name_alpha_score + sec_range_num_score + sec_range_alpha_score),prim_range_num_score + prim_range_alpha_score + prim_range_fract_score + prim_name_num_score + prim_name_alpha_score + sec_range_num_score + sec_range_alpha_score) + IF(locale_score>0,MAX(locale_score,city_score + st_score + zip_score),city_score + st_score + zip_score)) / 100 + outside + bonus/*HACK01b*/;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-SELF.Conf_Prop >= LowerMatchThreshold OR (le.ADDRESS_GROUP_ID = ri.ADDRESS_GROUP_ID AND (iComp >= IntraMatchThreshold OR iComp-SELF.Conf_Prop >= IntraMatchThreshold)),iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':DID',
  n = 1 => ':zip:prim_range_num',
  n = 2 => ':zip:prim_name_num',
  n = 3 => ':zip:prim_range_alpha:*',
  n = 9 => ':zip:prim_name_alpha:*',
  n = 14 => ':zip:prim_range_fract:*',
  n = 18 => ':zip:sec_range_alpha:*',
  n = 21 => ':zip:sec_range_num:*',
  n = 23 => ':zip:city:st',
  n = 24 => ':prim_range_num:prim_name_num',
  n = 25 => ':prim_range_num:prim_range_alpha:*',
  n = 31 => ':prim_range_num:prim_name_alpha:*',
  n = 36 => ':prim_range_num:prim_range_fract:*',
  n = 40 => ':prim_range_num:sec_range_alpha:*',
  n = 43 => ':prim_range_num:sec_range_num:*',
  n = 45 => ':prim_range_num:city:st',
  n = 46 => ':prim_name_num:prim_range_alpha:*',
  n = 52 => ':prim_name_num:prim_name_alpha:*',
  n = 57 => ':prim_name_num:prim_range_fract:*',
  n = 61 => ':prim_name_num:sec_range_alpha:*',
  n = 64 => ':prim_name_num:sec_range_num:*',
  n = 66 => ':prim_name_num:city:st',
  n = 67 => ':prim_range_alpha:prim_name_alpha:prim_range_fract',
  n = 68 => ':prim_range_alpha:prim_name_alpha:sec_range_alpha',
  n = 69 => ':prim_range_alpha:prim_name_alpha:sec_range_num',
  n = 70 => ':prim_range_alpha:prim_name_alpha:city',
  n = 71 => ':prim_range_alpha:prim_name_alpha:st',
  n = 72 => ':prim_range_alpha:prim_range_fract:sec_range_alpha',
  n = 73 => ':prim_range_alpha:prim_range_fract:sec_range_num',
  n = 74 => ':prim_range_alpha:prim_range_fract:city',
  n = 75 => ':prim_range_alpha:sec_range_alpha:sec_range_num',
  n = 76 => ':prim_range_alpha:sec_range_alpha:city',
  n = 77 => ':prim_range_alpha:sec_range_num:city',
  n = 78 => ':prim_name_alpha:prim_range_fract:sec_range_alpha',
  n = 79 => ':prim_name_alpha:prim_range_fract:sec_range_num',
  n = 80 => ':prim_name_alpha:prim_range_fract:city',
  n = 81 => ':prim_name_alpha:sec_range_alpha:sec_range_num',
  n = 82 => ':prim_name_alpha:sec_range_alpha:city',
  n = 83 => ':prim_name_alpha:sec_range_num:city',
  n = 84 => ':prim_range_fract:sec_range_alpha:sec_range_num',
  n = 85 => ':prim_range_fract:sec_range_alpha:city',
  n = 86 => ':prim_range_fract:sec_range_num:city',
  n = 87 => ':sec_range_alpha:sec_range_num:city','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 88 join conditions of which 45 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:DID(30)
 
dn0 := hfile(~DID_isnull);
dn0_deduped := dn0(DID_weight100>=2600); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.DID = RIGHT.DID
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.DID = RIGHT.DID,10000),HASH);
 
//Fixed fields ->:zip(14):prim_range_num(13)
 
dn1 := hfile(~zip_isnull AND ~prim_range_num_isnull);
dn1_deduped := dn1(zip_weight100 + prim_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,1),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.prim_range_num = RIGHT.prim_range_num,10000),HASH);
 
//Fixed fields ->:zip(14):prim_name_num(13)
 
dn2 := hfile(~zip_isnull AND ~prim_name_num_isnull);
dn2_deduped := dn2(zip_weight100 + prim_name_num_weight100>=2600); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,2),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.prim_name_num = RIGHT.prim_name_num,10000),HASH);
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:zip(14):prim_range_alpha(10):prim_name_alpha(10) also :zip(14):prim_range_alpha(10):prim_range_fract(9) also :zip(14):prim_range_alpha(10):sec_range_alpha(9) also :zip(14):prim_range_alpha(10):sec_range_num(9) also :zip(14):prim_range_alpha(10):city(8) also :zip(14):prim_range_alpha(10):st(6)
 
dn3 := hfile(~zip_isnull AND ~prim_range_alpha_isnull);
dn3_deduped := dn3(zip_weight100 + prim_range_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.prim_name_alpha = RIGHT.prim_name_alpha AND ~LEFT.prim_name_alpha_isnull
    OR    LEFT.prim_range_fract = RIGHT.prim_range_fract AND ~LEFT.prim_range_fract_isnull
    OR    LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,3),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3;
SALT311.mac_select_best_matches(mjs0_t,RID1,RID2,o0);
mjs0 := o0 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::0',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:zip(14):prim_name_alpha(10):prim_range_fract(9) also :zip(14):prim_name_alpha(10):sec_range_alpha(9) also :zip(14):prim_name_alpha(10):sec_range_num(9) also :zip(14):prim_name_alpha(10):city(8) also :zip(14):prim_name_alpha(10):st(6)
 
dn9 := hfile(~zip_isnull AND ~prim_name_alpha_isnull);
dn9_deduped := dn9(zip_weight100 + prim_name_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.prim_range_fract = RIGHT.prim_range_fract AND ~LEFT.prim_range_fract_isnull
    OR    LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,9),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha,10000),HASH);
mjs1_t := mj9;
SALT311.mac_select_best_matches(mjs1_t,RID1,RID2,o1);
mjs1 := o1 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::1',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:zip(14):prim_range_fract(9):sec_range_alpha(9) also :zip(14):prim_range_fract(9):sec_range_num(9) also :zip(14):prim_range_fract(9):city(8) also :zip(14):prim_range_fract(9):st(6)
 
dn14 := hfile(~zip_isnull AND ~prim_range_fract_isnull);
dn14_deduped := dn14(zip_weight100 + prim_range_fract_weight100>=2200); // Use specificity to flag high-dup counts
mj14 := JOIN( dn14_deduped, dn14_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,14),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:zip(14):sec_range_alpha(9):sec_range_num(9) also :zip(14):sec_range_alpha(9):city(8) also :zip(14):sec_range_alpha(9):st(6)
 
dn18 := hfile(~zip_isnull AND ~sec_range_alpha_isnull);
dn18_deduped := dn18(zip_weight100 + sec_range_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj18 := JOIN( dn18_deduped, dn18_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,18),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
mjs2_t := mj14+mj18;
SALT311.mac_select_best_matches(mjs2_t,RID1,RID2,o2);
mjs2 := o2 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::2',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip(14):sec_range_num(9):city(8) also :zip(14):sec_range_num(9):st(6)
 
dn21 := hfile(~zip_isnull AND ~sec_range_num_isnull);
dn21_deduped := dn21(zip_weight100 + sec_range_num_weight100>=2200); // Use specificity to flag high-dup counts
mj21 := JOIN( dn21_deduped, dn21_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,21),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:zip(14):city(8):st(6)
 
dn23 := hfile(~zip_isnull AND ~city_isnull AND ~st_isnull);
dn23_deduped := dn23(zip_weight100 + city_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj23 := JOIN( dn23_deduped, dn23_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.zip = RIGHT.zip
    AND LEFT.city = RIGHT.city
    AND LEFT.st = RIGHT.st
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,23),UNORDERED,
    ATMOST(LEFT.zip = RIGHT.zip
      AND LEFT.city = RIGHT.city
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:prim_range_num(13):prim_name_num(13)
 
dn24 := hfile(~prim_range_num_isnull AND ~prim_name_num_isnull);
dn24_deduped := dn24(prim_range_num_weight100 + prim_name_num_weight100>=2600); // Use specificity to flag high-dup counts
mj24 := JOIN( dn24_deduped, dn24_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,24),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.prim_name_num = RIGHT.prim_name_num,10000),HASH);
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_range_num(13):prim_range_alpha(10):prim_name_alpha(10) also :prim_range_num(13):prim_range_alpha(10):prim_range_fract(9) also :prim_range_num(13):prim_range_alpha(10):sec_range_alpha(9) also :prim_range_num(13):prim_range_alpha(10):sec_range_num(9) also :prim_range_num(13):prim_range_alpha(10):city(8) also :prim_range_num(13):prim_range_alpha(10):st(6)
 
dn25 := hfile(~prim_range_num_isnull AND ~prim_range_alpha_isnull);
dn25_deduped := dn25(prim_range_num_weight100 + prim_range_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj25 := JOIN( dn25_deduped, dn25_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.prim_name_alpha = RIGHT.prim_name_alpha AND ~LEFT.prim_name_alpha_isnull
    OR    LEFT.prim_range_fract = RIGHT.prim_range_fract AND ~LEFT.prim_range_fract_isnull
    OR    LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,25),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha,10000),HASH);
mjs3_t := mj21+mj23+mj24+mj25;
SALT311.mac_select_best_matches(mjs3_t,RID1,RID2,o3);
mjs3 := o3 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::3',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_range_num(13):prim_name_alpha(10):prim_range_fract(9) also :prim_range_num(13):prim_name_alpha(10):sec_range_alpha(9) also :prim_range_num(13):prim_name_alpha(10):sec_range_num(9) also :prim_range_num(13):prim_name_alpha(10):city(8) also :prim_range_num(13):prim_name_alpha(10):st(6)
 
dn31 := hfile(~prim_range_num_isnull AND ~prim_name_alpha_isnull);
dn31_deduped := dn31(prim_range_num_weight100 + prim_name_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj31 := JOIN( dn31_deduped, dn31_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.prim_range_fract = RIGHT.prim_range_fract AND ~LEFT.prim_range_fract_isnull
    OR    LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,31),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha,10000),HASH);
mjs4_t := mj31;
SALT311.mac_select_best_matches(mjs4_t,RID1,RID2,o4);
mjs4 := o4 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::4',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_range_num(13):prim_range_fract(9):sec_range_alpha(9) also :prim_range_num(13):prim_range_fract(9):sec_range_num(9) also :prim_range_num(13):prim_range_fract(9):city(8) also :prim_range_num(13):prim_range_fract(9):st(6)
 
dn36 := hfile(~prim_range_num_isnull AND ~prim_range_fract_isnull);
dn36_deduped := dn36(prim_range_num_weight100 + prim_range_fract_weight100>=2200); // Use specificity to flag high-dup counts
mj36 := JOIN( dn36_deduped, dn36_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,36),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_range_num(13):sec_range_alpha(9):sec_range_num(9) also :prim_range_num(13):sec_range_alpha(9):city(8) also :prim_range_num(13):sec_range_alpha(9):st(6)
 
dn40 := hfile(~prim_range_num_isnull AND ~sec_range_alpha_isnull);
dn40_deduped := dn40(prim_range_num_weight100 + sec_range_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj40 := JOIN( dn40_deduped, dn40_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,40),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
mjs5_t := mj36+mj40;
SALT311.mac_select_best_matches(mjs5_t,RID1,RID2,o5);
mjs5 := o5 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::5',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range_num(13):sec_range_num(9):city(8) also :prim_range_num(13):sec_range_num(9):st(6)
 
dn43 := hfile(~prim_range_num_isnull AND ~sec_range_num_isnull);
dn43_deduped := dn43(prim_range_num_weight100 + sec_range_num_weight100>=2200); // Use specificity to flag high-dup counts
mj43 := JOIN( dn43_deduped, dn43_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,43),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_range_num(13):city(8):st(6)
 
dn45 := hfile(~prim_range_num_isnull AND ~city_isnull AND ~st_isnull);
dn45_deduped := dn45(prim_range_num_weight100 + city_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj45 := JOIN( dn45_deduped, dn45_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND LEFT.city = RIGHT.city
    AND LEFT.st = RIGHT.st
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,45),UNORDERED,
    ATMOST(LEFT.prim_range_num = RIGHT.prim_range_num
      AND LEFT.city = RIGHT.city
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_name_num(13):prim_range_alpha(10):prim_name_alpha(10) also :prim_name_num(13):prim_range_alpha(10):prim_range_fract(9) also :prim_name_num(13):prim_range_alpha(10):sec_range_alpha(9) also :prim_name_num(13):prim_range_alpha(10):sec_range_num(9) also :prim_name_num(13):prim_range_alpha(10):city(8) also :prim_name_num(13):prim_range_alpha(10):st(6)
 
dn46 := hfile(~prim_name_num_isnull AND ~prim_range_alpha_isnull);
dn46_deduped := dn46(prim_name_num_weight100 + prim_range_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj46 := JOIN( dn46_deduped, dn46_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.prim_name_alpha = RIGHT.prim_name_alpha AND ~LEFT.prim_name_alpha_isnull
    OR    LEFT.prim_range_fract = RIGHT.prim_range_fract AND ~LEFT.prim_range_fract_isnull
    OR    LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,46),UNORDERED,
    ATMOST(LEFT.prim_name_num = RIGHT.prim_name_num
      AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha,10000),HASH);
mjs6_t := mj43+mj45+mj46;
SALT311.mac_select_best_matches(mjs6_t,RID1,RID2,o6);
mjs6 := o6 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::6',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_name_num(13):prim_name_alpha(10):prim_range_fract(9) also :prim_name_num(13):prim_name_alpha(10):sec_range_alpha(9) also :prim_name_num(13):prim_name_alpha(10):sec_range_num(9) also :prim_name_num(13):prim_name_alpha(10):city(8) also :prim_name_num(13):prim_name_alpha(10):st(6)
 
dn52 := hfile(~prim_name_num_isnull AND ~prim_name_alpha_isnull);
dn52_deduped := dn52(prim_name_num_weight100 + prim_name_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj52 := JOIN( dn52_deduped, dn52_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.prim_range_fract = RIGHT.prim_range_fract AND ~LEFT.prim_range_fract_isnull
    OR    LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,52),UNORDERED,
    ATMOST(LEFT.prim_name_num = RIGHT.prim_name_num
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha,10000),HASH);
mjs7_t := mj52;
SALT311.mac_select_best_matches(mjs7_t,RID1,RID2,o7);
mjs7 := o7 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::7',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_name_num(13):prim_range_fract(9):sec_range_alpha(9) also :prim_name_num(13):prim_range_fract(9):sec_range_num(9) also :prim_name_num(13):prim_range_fract(9):city(8) also :prim_name_num(13):prim_range_fract(9):st(6)
 
dn57 := hfile(~prim_name_num_isnull AND ~prim_range_fract_isnull);
dn57_deduped := dn57(prim_name_num_weight100 + prim_range_fract_weight100>=2200); // Use specificity to flag high-dup counts
mj57 := JOIN( dn57_deduped, dn57_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND ~LEFT.sec_range_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,57),UNORDERED,
    ATMOST(LEFT.prim_name_num = RIGHT.prim_name_num
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract,10000),HASH);
 
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_name_num(13):sec_range_alpha(9):sec_range_num(9) also :prim_name_num(13):sec_range_alpha(9):city(8) also :prim_name_num(13):sec_range_alpha(9):st(6)
 
dn61 := hfile(~prim_name_num_isnull AND ~sec_range_alpha_isnull);
dn61_deduped := dn61(prim_name_num_weight100 + sec_range_alpha_weight100>=2200); // Use specificity to flag high-dup counts
mj61 := JOIN( dn61_deduped, dn61_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,61),UNORDERED,
    ATMOST(LEFT.prim_name_num = RIGHT.prim_name_num
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
mjs8_t := mj57+mj61;
SALT311.mac_select_best_matches(mjs8_t,RID1,RID2,o8);
mjs8 := o8 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::8',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_name_num(13):sec_range_num(9):city(8) also :prim_name_num(13):sec_range_num(9):st(6)
 
dn64 := hfile(~prim_name_num_isnull AND ~sec_range_num_isnull);
dn64_deduped := dn64(prim_name_num_weight100 + sec_range_num_weight100>=2200); // Use specificity to flag high-dup counts
mj64 := JOIN( dn64_deduped, dn64_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    AND (
          LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,64),UNORDERED,
    ATMOST(LEFT.prim_name_num = RIGHT.prim_name_num
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_name_num(13):city(8):st(6)
 
dn66 := hfile(~prim_name_num_isnull AND ~city_isnull AND ~st_isnull);
dn66_deduped := dn66(prim_name_num_weight100 + city_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj66 := JOIN( dn66_deduped, dn66_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND LEFT.city = RIGHT.city
    AND LEFT.st = RIGHT.st
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,66),UNORDERED,
    ATMOST(LEFT.prim_name_num = RIGHT.prim_name_num
      AND LEFT.city = RIGHT.city
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):prim_name_alpha(10):prim_range_fract(9)
 
dn67 := hfile(~prim_range_alpha_isnull AND ~prim_name_alpha_isnull AND ~prim_range_fract_isnull);
dn67_deduped := dn67(prim_range_alpha_weight100 + prim_name_alpha_weight100 + prim_range_fract_weight100>=2600); // Use specificity to flag high-dup counts
mj67 := JOIN( dn67_deduped, dn67_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,67),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):prim_name_alpha(10):sec_range_alpha(9)
 
dn68 := hfile(~prim_range_alpha_isnull AND ~prim_name_alpha_isnull AND ~sec_range_alpha_isnull);
dn68_deduped := dn68(prim_range_alpha_weight100 + prim_name_alpha_weight100 + sec_range_alpha_weight100>=2600); // Use specificity to flag high-dup counts
mj68 := JOIN( dn68_deduped, dn68_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,68),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
mjs9_t := mj64+mj66+mj67+mj68;
SALT311.mac_select_best_matches(mjs9_t,RID1,RID2,o9);
mjs9 := o9 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::9',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//Fixed fields ->:prim_range_alpha(10):prim_name_alpha(10):sec_range_num(9)
 
dn69 := hfile(~prim_range_alpha_isnull AND ~prim_name_alpha_isnull AND ~sec_range_num_isnull);
dn69_deduped := dn69(prim_range_alpha_weight100 + prim_name_alpha_weight100 + sec_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj69 := JOIN( dn69_deduped, dn69_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,69),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):prim_name_alpha(10):city(8)
 
dn70 := hfile(~prim_range_alpha_isnull AND ~prim_name_alpha_isnull AND ~city_isnull);
dn70_deduped := dn70(prim_range_alpha_weight100 + prim_name_alpha_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj70 := JOIN( dn70_deduped, dn70_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,70),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):prim_name_alpha(10):st(6)
 
dn71 := hfile(~prim_range_alpha_isnull AND ~prim_name_alpha_isnull AND ~st_isnull);
dn71_deduped := dn71(prim_range_alpha_weight100 + prim_name_alpha_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj71 := JOIN( dn71_deduped, dn71_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.st = RIGHT.st
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,71),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.st = RIGHT.st,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):prim_range_fract(9):sec_range_alpha(9)
 
dn72 := hfile(~prim_range_alpha_isnull AND ~prim_range_fract_isnull AND ~sec_range_alpha_isnull);
dn72_deduped := dn72(prim_range_alpha_weight100 + prim_range_fract_weight100 + sec_range_alpha_weight100>=2600); // Use specificity to flag high-dup counts
mj72 := JOIN( dn72_deduped, dn72_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,72),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):prim_range_fract(9):sec_range_num(9)
 
dn73 := hfile(~prim_range_alpha_isnull AND ~prim_range_fract_isnull AND ~sec_range_num_isnull);
dn73_deduped := dn73(prim_range_alpha_weight100 + prim_range_fract_weight100 + sec_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj73 := JOIN( dn73_deduped, dn73_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,73),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
mjs10_t := mj69+mj70+mj71+mj72+mj73;
SALT311.mac_select_best_matches(mjs10_t,RID1,RID2,o10);
mjs10 := o10 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::10',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//Fixed fields ->:prim_range_alpha(10):prim_range_fract(9):city(8)
 
dn74 := hfile(~prim_range_alpha_isnull AND ~prim_range_fract_isnull AND ~city_isnull);
dn74_deduped := dn74(prim_range_alpha_weight100 + prim_range_fract_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj74 := JOIN( dn74_deduped, dn74_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,74),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):sec_range_alpha(9):sec_range_num(9)
 
dn75 := hfile(~prim_range_alpha_isnull AND ~sec_range_alpha_isnull AND ~sec_range_num_isnull);
dn75_deduped := dn75(prim_range_alpha_weight100 + sec_range_alpha_weight100 + sec_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj75 := JOIN( dn75_deduped, dn75_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,75),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):sec_range_alpha(9):city(8)
 
dn76 := hfile(~prim_range_alpha_isnull AND ~sec_range_alpha_isnull AND ~city_isnull);
dn76_deduped := dn76(prim_range_alpha_weight100 + sec_range_alpha_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj76 := JOIN( dn76_deduped, dn76_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,76),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_range_alpha(10):sec_range_num(9):city(8)
 
dn77 := hfile(~prim_range_alpha_isnull AND ~sec_range_num_isnull AND ~city_isnull);
dn77_deduped := dn77(prim_range_alpha_weight100 + sec_range_num_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj77 := JOIN( dn77_deduped, dn77_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,77),UNORDERED,
    ATMOST(LEFT.prim_range_alpha = RIGHT.prim_range_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_name_alpha(10):prim_range_fract(9):sec_range_alpha(9)
 
dn78 := hfile(~prim_name_alpha_isnull AND ~prim_range_fract_isnull AND ~sec_range_alpha_isnull);
dn78_deduped := dn78(prim_name_alpha_weight100 + prim_range_fract_weight100 + sec_range_alpha_weight100>=2600); // Use specificity to flag high-dup counts
mj78 := JOIN( dn78_deduped, dn78_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,78),UNORDERED,
    ATMOST(LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
mjs11_t := mj74+mj75+mj76+mj77+mj78;
SALT311.mac_select_best_matches(mjs11_t,RID1,RID2,o11);
mjs11 := o11 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::11',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//Fixed fields ->:prim_name_alpha(10):prim_range_fract(9):sec_range_num(9)
 
dn79 := hfile(~prim_name_alpha_isnull AND ~prim_range_fract_isnull AND ~sec_range_num_isnull);
dn79_deduped := dn79(prim_name_alpha_weight100 + prim_range_fract_weight100 + sec_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj79 := JOIN( dn79_deduped, dn79_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,79),UNORDERED,
    ATMOST(LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_name_alpha(10):prim_range_fract(9):city(8)
 
dn80 := hfile(~prim_name_alpha_isnull AND ~prim_range_fract_isnull AND ~city_isnull);
dn80_deduped := dn80(prim_name_alpha_weight100 + prim_range_fract_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj80 := JOIN( dn80_deduped, dn80_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,80),UNORDERED,
    ATMOST(LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_name_alpha(10):sec_range_alpha(9):sec_range_num(9)
 
dn81 := hfile(~prim_name_alpha_isnull AND ~sec_range_alpha_isnull AND ~sec_range_num_isnull);
dn81_deduped := dn81(prim_name_alpha_weight100 + sec_range_alpha_weight100 + sec_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj81 := JOIN( dn81_deduped, dn81_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,81),UNORDERED,
    ATMOST(LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_name_alpha(10):sec_range_alpha(9):city(8)
 
dn82 := hfile(~prim_name_alpha_isnull AND ~sec_range_alpha_isnull AND ~city_isnull);
dn82_deduped := dn82(prim_name_alpha_weight100 + sec_range_alpha_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj82 := JOIN( dn82_deduped, dn82_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,82),UNORDERED,
    ATMOST(LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_name_alpha(10):sec_range_num(9):city(8)
 
dn83 := hfile(~prim_name_alpha_isnull AND ~sec_range_num_isnull AND ~city_isnull);
dn83_deduped := dn83(prim_name_alpha_weight100 + sec_range_num_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj83 := JOIN( dn83_deduped, dn83_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,83),UNORDERED,
    ATMOST(LEFT.prim_name_alpha = RIGHT.prim_name_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num
      AND LEFT.city = RIGHT.city,10000),HASH);
mjs12_t := mj79+mj80+mj81+mj82+mj83;
SALT311.mac_select_best_matches(mjs12_t,RID1,RID2,o12);
mjs12 := o12 : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::12',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//Fixed fields ->:prim_range_fract(9):sec_range_alpha(9):sec_range_num(9)
 
dn84 := hfile(~prim_range_fract_isnull AND ~sec_range_alpha_isnull AND ~sec_range_num_isnull);
dn84_deduped := dn84(prim_range_fract_weight100 + sec_range_alpha_weight100 + sec_range_num_weight100>=2600); // Use specificity to flag high-dup counts
mj84 := JOIN( dn84_deduped, dn84_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,84),UNORDERED,
    ATMOST(LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
 
//Fixed fields ->:prim_range_fract(9):sec_range_alpha(9):city(8)
 
dn85 := hfile(~prim_range_fract_isnull AND ~sec_range_alpha_isnull AND ~city_isnull);
dn85_deduped := dn85(prim_range_fract_weight100 + sec_range_alpha_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj85 := JOIN( dn85_deduped, dn85_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,85),UNORDERED,
    ATMOST(LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:prim_range_fract(9):sec_range_num(9):city(8)
 
dn86 := hfile(~prim_range_fract_isnull AND ~sec_range_num_isnull AND ~city_isnull);
dn86_deduped := dn86(prim_range_fract_weight100 + sec_range_num_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj86 := JOIN( dn86_deduped, dn86_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.prim_range_fract = RIGHT.prim_range_fract
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,86),UNORDERED,
    ATMOST(LEFT.prim_range_fract = RIGHT.prim_range_fract
      AND LEFT.sec_range_num = RIGHT.sec_range_num
      AND LEFT.city = RIGHT.city,10000),HASH);
 
//Fixed fields ->:sec_range_alpha(9):sec_range_num(9):city(8)
 
dn87 := hfile(~sec_range_alpha_isnull AND ~sec_range_num_isnull AND ~city_isnull);
dn87_deduped := dn87(sec_range_alpha_weight100 + sec_range_num_weight100 + city_weight100>=2600); // Use specificity to flag high-dup counts
mj87 := JOIN( dn87_deduped, dn87_deduped, LEFT.ADDRESS_GROUP_ID > RIGHT.ADDRESS_GROUP_ID
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND LEFT.city = RIGHT.city
    AND ( left.DID = right.DID OR left.DID_isnull OR right.DID_isnull )
    AND ( left.prim_range_alpha = right.prim_range_alpha OR left.prim_range_alpha_isnull OR right.prim_range_alpha_isnull )
    AND ( left.prim_range_fract = right.prim_range_fract OR left.prim_range_fract_isnull OR right.prim_range_fract_isnull )
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( left.st = right.st OR left.st_isnull OR right.st_isnull )
    ,trans(LEFT,RIGHT,87),UNORDERED,
    ATMOST(LEFT.sec_range_alpha = RIGHT.sec_range_alpha
      AND LEFT.sec_range_num = RIGHT.sec_range_num
      AND LEFT.city = RIGHT.city,10000),HASH);
last_mjs_t :=mj84+mj85+mj86+mj87;
SALT311.mac_select_best_matches(last_mjs_t,RID1,RID2,o);
mjs13 := o : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mj::13',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8+ mjs9+ mjs10+ mjs11+ mjs12+ mjs13;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::all_m',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // To by used by RID and ADDRESS_GROUP_ID
SALT311.mac_avoid_transitives(All_Matches,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mt',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
SALT311.mac_get_BestPerRecord( All_Matches,RID1,ADDRESS_GROUP_ID1,RID2,ADDRESS_GROUP_ID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mr',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
//Now lets see if any slice-outs are needed
SHARED too_big := TABLE(match_candidates(ih).Candidates_ForSlice,{ADDRESS_GROUP_ID, InCluster := COUNT(GROUP)},ADDRESS_GROUP_ID,LOCAL)(InCluster>1000); // ADDRESS_GROUP_ID that are too big for sliceout
SHARED h_ok := JOIN(match_candidates(ih).Candidates_ForSlice,too_big,LEFT.ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID AND (>STRING6<)LEFT.RID<>(>STRING6<)RIGHT.RID,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT311.mac_cluster_breadth(in_matches,RID1,RID2,ADDRESS_GROUP_ID1,o);
SHARED in_matches1 := o;
missed_linkages0 := JOIN(h_ok, in_matches1, LEFT.RID = RIGHT.RID1, TRANSFORM(RECORDOF(in_matches1), SELF.ADDRESS_GROUP_ID1 := LEFT.ADDRESS_GROUP_ID, SELF.RID1 := LEFT.RID, SELF := []), LEFT ONLY, LOCAL); // get back the records with no close matches
missed_linkages := JOIN(missed_linkages0,Specificities(ih).ClusterSizes(InCluster>1),LEFT.ADDRESS_GROUP_ID1=RIGHT.ADDRESS_GROUP_ID,LOCAL); // remove singletons
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.ADDRESS_GROUP_ID1=RIGHT.ADDRESS_GROUP_ID,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::clu',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT311.UIDType RID;  //Outcast
  SALT311.UIDType ADDRESS_GROUP_ID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT311.UIDType Pref_RID; // Prefers this record
  SALT311.UIDType Pref_ADDRESS_GROUP_ID; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.RID := le.RID1;
  self.ADDRESS_GROUP_ID := le.ADDRESS_GROUP_ID1;
  self.Closest := le.Closest;
  self.Pref_RID := ri.RID2;
  self.Pref_ADDRESS_GROUP_ID := ri.ADDRESS_GROUP_ID2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.RID1=RIGHT.RID1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID1 AND LEFT.Pref_ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID2 AND LEFT.Pref_ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.RID=RIGHT.RID,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>Config.SliceDistance),HASH(ADDRESS_GROUP_ID)),ADDRESS_GROUP_ID,-Pref_Margin,RID,pref_ADDRESS_GROUP_ID,pref_RID,LOCAL),ADDRESS_GROUP_ID,LOCAL)) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::Matches::ToSlice',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
// 1024x better in new place
  SALT311.MAC_Avoid_SliceOuts(PossibleMatches,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,ADDRESS_GROUP_ID,Pref_ADDRESS_GROUP_ID,ToSlice,m); // If ADDRESS_GROUP_ID is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::Matches::Matches',EXPIRE(InsuranceHeader_Address.Config.PersistExpire));
 
//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih, s, MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{RID,ADDRESS_GROUP_ID});
  SALT311.utMAC_Patch_Id(ih_thin,ADDRESS_GROUP_ID,BasicMatch(ih).patch_file,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,ihbp); // Perform basic matches
  SALT311.MAC_SliceOut_ByRID(ihbp,RID,ADDRESS_GROUP_ID,ToSlice,RID,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
  SALT311.utMAC_Patch_Id(sliced,ADDRESS_GROUP_ID,Matches,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.RID=RIGHT.RID, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
SALT311.utMAC_Patch_Id(h,ADDRESS_GROUP_ID,Matches,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.RID := le.RID;
    SELF.ADDRESS_GROUP_ID_before := le.ADDRESS_GROUP_ID;
    SELF.ADDRESS_GROUP_ID_after := ri.ADDRESS_GROUP_ID;
    SELF.change_date := (UNSIGNED6)(STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'));
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.RID = RIGHT.RID AND (LEFT.ADDRESS_GROUP_ID<>RIGHT.ADDRESS_GROUP_ID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := InsuranceHeader_Address.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := InsuranceHeader_Address.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
