// Begin code to produce match candidates
IMPORT SALT311,STD;
EXPORT match_candidates(DATASET(layout_Address_Link) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := InsuranceHeader_Address.BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{RID,DID,src,dt_first_seen,dt_last_seen,prim_range,prim_range_alpha,prim_range_num,prim_range_fract,predir,prim_name,prim_name_num,prim_name_alpha,addr_suffix,addr_ind,postdir,unit_desig,sec_range,sec_range_alpha,sec_range_num,city,st,zip,rec_cnt,src_cnt,addr,locale,ADDRESS_GROUP_ID}),HASH(ADDRESS_GROUP_ID));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 DID_pop := AVE(GROUP,IF((thin_table.DID  IN SET(s.nulls_DID,DID) OR thin_table.DID = (TYPEOF(thin_table.DID))''),0,100));
  REAL8 prim_range_alpha_pop := AVE(GROUP,IF((thin_table.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR thin_table.prim_range_alpha = (TYPEOF(thin_table.prim_range_alpha))''),0,100));
  REAL8 prim_range_num_pop := AVE(GROUP,IF((thin_table.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR thin_table.prim_range_num = (TYPEOF(thin_table.prim_range_num))''),0,100));
  REAL8 prim_range_fract_pop := AVE(GROUP,IF((thin_table.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR thin_table.prim_range_fract = (TYPEOF(thin_table.prim_range_fract))''),0,100));
  REAL8 prim_name_num_pop := AVE(GROUP,IF((thin_table.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR thin_table.prim_name_num = (TYPEOF(thin_table.prim_name_num))''),0,100));
  REAL8 prim_name_alpha_pop := AVE(GROUP,IF((thin_table.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR thin_table.prim_name_alpha = (TYPEOF(thin_table.prim_name_alpha))''),0,100));
  REAL8 sec_range_alpha_pop := AVE(GROUP,IF((thin_table.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR thin_table.sec_range_alpha = (TYPEOF(thin_table.sec_range_alpha))''),0,100));
  REAL8 sec_range_num_pop := AVE(GROUP,IF((thin_table.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR thin_table.sec_range_num = (TYPEOF(thin_table.sec_range_num))''),0,100));
  REAL8 city_pop := AVE(GROUP,IF((thin_table.city  IN SET(s.nulls_city,city) OR thin_table.city = (TYPEOF(thin_table.city))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''),0,100));
  REAL8 addr_pop := AVE(GROUP,IF(((thin_table.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR thin_table.prim_range_num = (TYPEOF(thin_table.prim_range_num))'') AND (thin_table.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR thin_table.prim_range_alpha = (TYPEOF(thin_table.prim_range_alpha))'') AND (thin_table.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR thin_table.prim_range_fract = (TYPEOF(thin_table.prim_range_fract))'') AND (thin_table.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR thin_table.prim_name_num = (TYPEOF(thin_table.prim_name_num))'') AND (thin_table.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR thin_table.prim_name_alpha = (TYPEOF(thin_table.prim_name_alpha))'') AND (thin_table.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR thin_table.sec_range_num = (TYPEOF(thin_table.sec_range_num))'') AND (thin_table.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR thin_table.sec_range_alpha = (TYPEOF(thin_table.sec_range_alpha))'')),0,100));
  REAL8 locale_pop := AVE(GROUP,IF(((thin_table.city  IN SET(s.nulls_city,city) OR thin_table.city = (TYPEOF(thin_table.city))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'')),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT311.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 prim_range_alpha_prop := 0;
  UNSIGNED1 prim_range_num_prop := 0;
  UNSIGNED1 prim_range_fract_prop := 0;
  UNSIGNED1 prim_name_num_prop := 0;
  UNSIGNED1 prim_name_alpha_prop := 0;
  UNSIGNED1 sec_range_alpha_prop := 0;
  UNSIGNED1 sec_range_num_prop := 0;
  UNSIGNED1 addr_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT311.mac_prop_field(thin_table(prim_range_alpha NOT IN SET(s.nulls_prim_range_alpha,prim_range_alpha)),prim_range_alpha,ADDRESS_GROUP_ID,prim_range_alpha_props); // For every DID find the best FULL prim_range_alpha
layout_withpropvars take_prim_range_alpha(with_props le,prim_range_alpha_props ri) := TRANSFORM
  SELF.prim_range_alpha := IF ( le.prim_range_alpha IN SET(s.nulls_prim_range_alpha,prim_range_alpha) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', ri.prim_range_alpha, le.prim_range_alpha );
  SELF.prim_range_alpha_prop := le.prim_range_alpha_prop + IF ( le.prim_range_alpha IN SET(s.nulls_prim_range_alpha,prim_range_alpha) and ri.prim_range_alpha NOT IN SET(s.nulls_prim_range_alpha,prim_range_alpha) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj5 := JOIN(with_props,prim_range_alpha_props,left.ADDRESS_GROUP_ID=right.ADDRESS_GROUP_ID,take_prim_range_alpha(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(prim_range_num NOT IN SET(s.nulls_prim_range_num,prim_range_num)),prim_range_num,ADDRESS_GROUP_ID,prim_range_num_props); // For every DID find the best FULL prim_range_num
layout_withpropvars take_prim_range_num(with_props le,prim_range_num_props ri) := TRANSFORM
  SELF.prim_range_num := IF ( le.prim_range_num IN SET(s.nulls_prim_range_num,prim_range_num) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', ri.prim_range_num, le.prim_range_num );
  SELF.prim_range_num_prop := le.prim_range_num_prop + IF ( le.prim_range_num IN SET(s.nulls_prim_range_num,prim_range_num) and ri.prim_range_num NOT IN SET(s.nulls_prim_range_num,prim_range_num) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj6 := JOIN(pj5,prim_range_num_props,left.ADDRESS_GROUP_ID=right.ADDRESS_GROUP_ID,take_prim_range_num(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(prim_range_fract NOT IN SET(s.nulls_prim_range_fract,prim_range_fract)),prim_range_fract,ADDRESS_GROUP_ID,prim_range_fract_props); // For every DID find the best FULL prim_range_fract
layout_withpropvars take_prim_range_fract(with_props le,prim_range_fract_props ri) := TRANSFORM
  SELF.prim_range_fract := IF ( le.prim_range_fract IN SET(s.nulls_prim_range_fract,prim_range_fract) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', ri.prim_range_fract, le.prim_range_fract );
  SELF.prim_range_fract_prop := le.prim_range_fract_prop + IF ( le.prim_range_fract IN SET(s.nulls_prim_range_fract,prim_range_fract) and ri.prim_range_fract NOT IN SET(s.nulls_prim_range_fract,prim_range_fract) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj7 := JOIN(pj6,prim_range_fract_props,left.ADDRESS_GROUP_ID=right.ADDRESS_GROUP_ID,take_prim_range_fract(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(sec_range_alpha NOT IN SET(s.nulls_sec_range_alpha,sec_range_alpha)),sec_range_alpha,ADDRESS_GROUP_ID,sec_range_alpha_props); // For every DID find the best FULL sec_range_alpha
layout_withpropvars take_sec_range_alpha(with_props le,sec_range_alpha_props ri) := TRANSFORM
  SELF.sec_range_alpha := IF ( le.sec_range_alpha IN SET(s.nulls_sec_range_alpha,sec_range_alpha) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', ri.sec_range_alpha, le.sec_range_alpha );
  SELF.sec_range_alpha_prop := le.sec_range_alpha_prop + IF ( le.sec_range_alpha IN SET(s.nulls_sec_range_alpha,sec_range_alpha) and ri.sec_range_alpha NOT IN SET(s.nulls_sec_range_alpha,sec_range_alpha) and ri.ADDRESS_GROUP_ID<>(TYPEOF(ri.ADDRESS_GROUP_ID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj17 := JOIN(pj7,sec_range_alpha_props,left.ADDRESS_GROUP_ID=right.ADDRESS_GROUP_ID,take_sec_range_alpha(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field_init(thin_table(sec_range_num NOT IN SET(s.nulls_sec_range_num,sec_range_num)),sec_range_num,ADDRESS_GROUP_ID,sec_range_num_props); // For every DID find the best FULL sec_range_num
layout_withpropvars take_sec_range_num(with_props le,sec_range_num_props ri) := TRANSFORM
  SELF.sec_range_num := IF ( le.sec_range_num = ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))], ri.sec_range_num, le.sec_range_num );
  SELF.sec_range_num_prop := IF ( LENGTH(TRIM(le.sec_range_num)) < LENGTH(TRIM(ri.sec_range_num)) and le.sec_range_num=ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))],LENGTH(TRIM(ri.sec_range_num)) - LENGTH(TRIM(le.sec_range_num)) , le.sec_range_num_prop ); // Store the amount propogated
  SELF := le;
  END;
SHARED pj18 := JOIN(pj17,sec_range_num_props,left.ADDRESS_GROUP_ID=right.ADDRESS_GROUP_ID AND (left.sec_range_num='' OR left.sec_range_num[1]=right.sec_range_num[1]),take_sec_range_num(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
pj18 do_computes(pj18 le) := TRANSFORM
  SELF.addr := IF (Fields.InValid_addr((SALT311.StrType)le.prim_range_num,(SALT311.StrType)le.prim_range_alpha,(SALT311.StrType)le.prim_range_fract,(SALT311.StrType)le.prim_name_num,(SALT311.StrType)le.prim_name_alpha,(SALT311.StrType)le.sec_range_num,(SALT311.StrType)le.sec_range_alpha)>0,0,HASH32((SALT311.StrType)le.prim_range_num,(SALT311.StrType)le.prim_range_alpha,(SALT311.StrType)le.prim_range_fract,(SALT311.StrType)le.prim_name_num,(SALT311.StrType)le.prim_name_alpha,(SALT311.StrType)le.sec_range_num,(SALT311.StrType)le.sec_range_alpha)); // Combine child fields into 1 for specificity counting
  SELF.addr_prop := IF( le.prim_range_num_prop > 0, 1, 0 ) + IF( le.prim_range_alpha_prop > 0, 2, 0 ) + IF( le.prim_range_fract_prop > 0, 4, 0 ) + IF( le.sec_range_num_prop > 0, 32, 0 ) + IF( le.sec_range_alpha_prop > 0, 64, 0 );
  SELF.locale := IF (Fields.InValid_locale((SALT311.StrType)le.city,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)>0,0,HASH32((SALT311.StrType)le.city,(SALT311.StrType)le.st,(SALT311.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj18,do_computes(left)) : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mc_props::Address_Link',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 DID_pop := AVE(GROUP,IF((propogated.DID  IN SET(s.nulls_DID,DID) OR propogated.DID = (TYPEOF(propogated.DID))''),0,100));
  REAL8 prim_range_alpha_pop := AVE(GROUP,IF((propogated.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR propogated.prim_range_alpha = (TYPEOF(propogated.prim_range_alpha))''),0,100));
  REAL8 prim_range_num_pop := AVE(GROUP,IF((propogated.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR propogated.prim_range_num = (TYPEOF(propogated.prim_range_num))''),0,100));
  REAL8 prim_range_fract_pop := AVE(GROUP,IF((propogated.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR propogated.prim_range_fract = (TYPEOF(propogated.prim_range_fract))''),0,100));
  REAL8 prim_name_num_pop := AVE(GROUP,IF((propogated.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR propogated.prim_name_num = (TYPEOF(propogated.prim_name_num))''),0,100));
  REAL8 prim_name_alpha_pop := AVE(GROUP,IF((propogated.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR propogated.prim_name_alpha = (TYPEOF(propogated.prim_name_alpha))''),0,100));
  REAL8 sec_range_alpha_pop := AVE(GROUP,IF((propogated.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR propogated.sec_range_alpha = (TYPEOF(propogated.sec_range_alpha))''),0,100));
  REAL8 sec_range_num_pop := AVE(GROUP,IF((propogated.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR propogated.sec_range_num = (TYPEOF(propogated.sec_range_num))''),0,100));
  REAL8 city_pop := AVE(GROUP,IF((propogated.city  IN SET(s.nulls_city,city) OR propogated.city = (TYPEOF(propogated.city))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''),0,100));
  REAL8 addr_pop := AVE(GROUP,IF(((propogated.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR propogated.prim_range_num = (TYPEOF(propogated.prim_range_num))'') AND (propogated.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR propogated.prim_range_alpha = (TYPEOF(propogated.prim_range_alpha))'') AND (propogated.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR propogated.prim_range_fract = (TYPEOF(propogated.prim_range_fract))'') AND (propogated.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR propogated.prim_name_num = (TYPEOF(propogated.prim_name_num))'') AND (propogated.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR propogated.prim_name_alpha = (TYPEOF(propogated.prim_name_alpha))'') AND (propogated.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR propogated.sec_range_num = (TYPEOF(propogated.sec_range_num))'') AND (propogated.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR propogated.sec_range_alpha = (TYPEOF(propogated.sec_range_alpha))'')),0,100));
  REAL8 locale_pop := AVE(GROUP,IF(((propogated.city  IN SET(s.nulls_city,city) OR propogated.city = (TYPEOF(propogated.city))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'')),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT311.MAC_Pivot(PoPS, poprec);
  SHARED MAC_RollupCandidates(inCandidates, sortFields, groupFields, addBuddies) := FUNCTIONMACRO
    Grpd0 := GROUP(SORT(
      DISTRIBUTE(TABLE(inCandidates, {inCandidates #IF(addBuddies) , UNSIGNED2 Buddies := 0 #END}), HASH(ADDRESS_GROUP_ID)),
      ADDRESS_GROUP_ID, #EXPAND(sortFields), LOCAL),
      ADDRESS_GROUP_ID, #EXPAND(groupFields), LOCAL);
    Grpd0 Tr0(Grpd0 le, Grpd0 ri) := TRANSFORM
      SELF.Buddies := le.Buddies + ri.Buddies + 1;
      SELF := le;
    END;
    RETURN UNGROUP(ROLLUP(Grpd0,TRUE,Tr0(LEFT,RIGHT)));// Only one copy of each record
  ENDMACRO;
  SHARED fieldList := 'DID,prim_range_alpha,prim_range_num,prim_range_fract,prim_name_num,prim_name_alpha,sec_range_alpha,sec_range_num,city,st,zip';
  SHARED fieldListWithPropFlags := fieldList + ',prim_range_alpha_prop,prim_range_num_prop,prim_range_fract_prop,prim_name_num_prop,prim_name_alpha_prop,sec_range_alpha_prop,sec_range_num_prop,addr_prop';
  GrpdRoll_withpropfields := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldListWithPropFlags, TRUE);
  GrpdRoll_nopropfields := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldList, TRUE);
SHARED h0 := IF(Config.FastSlice, GrpdRoll_nopropFields, GrpdRoll_withpropfields);
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT311.UIDType ADDRESS_GROUP_ID1;
  SALT311.UIDType ADDRESS_GROUP_ID2;
  SALT311.UIDType RID1 := 0;
  SALT311.UIDType RID2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [prim_range_num,prim_name_num,prim_name_alpha,city]; // remove wordbag fields which need to be expanded
  INTEGER2 DID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DID_isnull := (h0.DID  IN SET(s.nulls_DID,DID) OR h0.DID = (TYPEOF(h0.DID))''); // Simplify later processing 
  INTEGER2 prim_range_alpha_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_alpha_isnull := (h0.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR h0.prim_range_alpha = (TYPEOF(h0.prim_range_alpha))''); // Simplify later processing 
  STRING20 prim_range_num := h0.prim_range_num; // Expanded wordbag field
  INTEGER2 prim_range_num_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_num_isnull := (h0.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR h0.prim_range_num = (TYPEOF(h0.prim_range_num))''); // Simplify later processing 
  INTEGER2 prim_range_fract_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_fract_isnull := (h0.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR h0.prim_range_fract = (TYPEOF(h0.prim_range_fract))''); // Simplify later processing 
  STRING56 prim_name_num := h0.prim_name_num; // Expanded wordbag field
  INTEGER2 prim_name_num_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_num_isnull := (h0.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR h0.prim_name_num = (TYPEOF(h0.prim_name_num))''); // Simplify later processing 
  STRING100 prim_name_alpha := h0.prim_name_alpha; // Expanded wordbag field
  INTEGER2 prim_name_alpha_weight100 := 0; // Contains 100x the specificity
  INTEGER2 prim_name_alpha_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_alpha_isnull := (h0.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR h0.prim_name_alpha = (TYPEOF(h0.prim_name_alpha))''); // Simplify later processing 
  INTEGER2 sec_range_alpha_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_alpha_isnull := (h0.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR h0.sec_range_alpha = (TYPEOF(h0.sec_range_alpha))''); // Simplify later processing 
  INTEGER2 sec_range_num_weight100 := 0; // Contains 100x the specificity
  INTEGER2 sec_range_num_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_num_isnull := (h0.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR h0.sec_range_num = (TYPEOF(h0.sec_range_num))''); // Simplify later processing 
  STRING50 city := h0.city; // Expanded wordbag field
  INTEGER2 city_weight100 := 0; // Contains 100x the specificity
  BOOLEAN city_isnull := (h0.city  IN SET(s.nulls_city,city) OR h0.city = (TYPEOF(h0.city))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  INTEGER2 addr_weight100 := 0; // Contains 100x the specificity
  BOOLEAN addr_isnull := ((h0.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR h0.prim_range_num = (TYPEOF(h0.prim_range_num))'') AND (h0.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR h0.prim_range_alpha = (TYPEOF(h0.prim_range_alpha))'') AND (h0.prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR h0.prim_range_fract = (TYPEOF(h0.prim_range_fract))'') AND (h0.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR h0.prim_name_num = (TYPEOF(h0.prim_name_num))'') AND (h0.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR h0.prim_name_alpha = (TYPEOF(h0.prim_name_alpha))'') AND (h0.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR h0.sec_range_num = (TYPEOF(h0.sec_range_num))'') AND (h0.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR h0.sec_range_alpha = (TYPEOF(h0.sec_range_alpha))'')); // Simplify later processing 
  INTEGER2 locale_weight100 := 0; // Contains 100x the specificity
  BOOLEAN locale_isnull := ((h0.city  IN SET(s.nulls_city,city) OR h0.city = (TYPEOF(h0.city))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))'')); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j12 := JOIN(h1,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_city(layout_candidates le,Specificities(ih).city_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.city_weight100 := MAP (le.city_isnull => 0, patch_default and ri.field_specificity=0 => s.city_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.city := IF( ri.field_specificity<>0 or ri.word<>'',SELF.city_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.city, s.city_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j12,s.nulls_city,Specificities(ih).city_values_persisted,city,city_weight100,add_city,j11);
layout_candidates add_sec_range_num(layout_candidates le,Specificities(ih).sec_range_num_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_num_weight100 := MAP (le.sec_range_num_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_num_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.sec_range_num_initial_char_weight100 := MAP (le.sec_range_num_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j11,s.nulls_sec_range_num,Specificities(ih).sec_range_num_values_persisted,sec_range_num,sec_range_num_weight100,add_sec_range_num,j10);
layout_candidates add_sec_range_alpha(layout_candidates le,Specificities(ih).sec_range_alpha_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_alpha_weight100 := MAP (le.sec_range_alpha_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_alpha_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j10,s.nulls_sec_range_alpha,Specificities(ih).sec_range_alpha_values_persisted,sec_range_alpha,sec_range_alpha_weight100,add_sec_range_alpha,j9);
layout_candidates add_prim_range_fract(layout_candidates le,Specificities(ih).prim_range_fract_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_fract_weight100 := MAP (le.prim_range_fract_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_fract_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j9,s.nulls_prim_range_fract,Specificities(ih).prim_range_fract_values_persisted,prim_range_fract,prim_range_fract_weight100,add_prim_range_fract,j8);
layout_candidates add_prim_name_alpha(layout_candidates le,Specificities(ih).prim_name_alpha_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_alpha_weight100 := MAP (le.prim_name_alpha_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_alpha_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_alpha_initial_char_weight100 := MAP (le.prim_name_alpha_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF.prim_name_alpha := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_alpha_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_alpha, s.prim_name_alpha_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j8,s.nulls_prim_name_alpha,Specificities(ih).prim_name_alpha_values_persisted,prim_name_alpha,prim_name_alpha_weight100,add_prim_name_alpha,j7);
layout_candidates add_prim_range_alpha(layout_candidates le,Specificities(ih).prim_range_alpha_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_alpha_weight100 := MAP (le.prim_range_alpha_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_alpha_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j7,s.nulls_prim_range_alpha,Specificities(ih).prim_range_alpha_values_persisted,prim_range_alpha,prim_range_alpha_weight100,add_prim_range_alpha,j6);
layout_candidates add_prim_name_num(layout_candidates le,Specificities(ih).prim_name_num_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_num_weight100 := MAP (le.prim_name_num_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_num_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_num := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_num_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_name_num, s.prim_name_num_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j6,s.nulls_prim_name_num,Specificities(ih).prim_name_num_values_persisted,prim_name_num,prim_name_num_weight100,add_prim_name_num,j5);
layout_candidates add_prim_range_num(layout_candidates le,Specificities(ih).prim_range_num_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_num_weight100 := MAP (le.prim_range_num_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_num_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_range_num := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_range_num_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.prim_range_num, s.prim_range_num_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j5,s.nulls_prim_range_num,Specificities(ih).prim_range_num_values_persisted,prim_range_num,prim_range_num_weight100,add_prim_range_num,j4);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j4,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j3);
layout_candidates add_locale(layout_candidates le,Specificities(ih).locale_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.locale_weight100 := MAP (le.locale_isnull => 0, patch_default and ri.field_specificity=0 => s.locale_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j3,s.nulls_locale,Specificities(ih).locale_values_persisted,locale,locale_weight100,add_locale,j2);
layout_candidates add_addr(layout_candidates le,Specificities(ih).addr_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.addr_weight100 := MAP (le.addr_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j2,s.nulls_addr,Specificities(ih).addr_values_persisted,addr,addr_weight100,add_addr,j1);
layout_candidates add_DID(layout_candidates le,Specificities(ih).DID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DID_weight100 := MAP (le.DID_isnull => 0, patch_default and ri.field_specificity=0 => s.DID_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j1,s.nulls_DID,Specificities(ih).DID_values_persisted,DID,DID_weight100,add_DID,j0);
//Using HASH(did) to get smoother distribution
SHARED j0_dist := DISTRIBUTE(j0, HASH(ADDRESS_GROUP_ID));
SHARED Annotated_NoDedup := j0_dist : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mc_nodedup',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // No dedup- for aggressive slicing
SHARED Annotated_Dedup := IF(Config.FastSlice, j0_dist, MAC_RollupCandidates(Annotated_NoDedup, fieldListWithPropFlags, fieldList, FALSE));
SHARED Annotated := Annotated_Dedup : PERSIST('~temp::ADDRESS_GROUP_ID::InsuranceHeader_Address::mc',EXPIRE(InsuranceHeader_Address.Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.DID_weight100 + Annotated.addr_weight100 + Annotated.locale_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
TotalWeight_NoDedup := Annotated_NoDedup.DID_weight100 + Annotated_NoDedup.addr_weight100 + Annotated_NoDedup.locale_weight100;
SHARED Linkable_NoDedup := TotalWeight_NoDedup >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(IF(Config.FastSlice, Annotated, Annotated_NoDedup),{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(IF(Config.FastSlice, Annotated, Annotated_NoDedup)(buddies>0), { RID });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
EXPORT Candidates_ForSlice := IF(Config.FastSlice, Candidates, Annotated_NoDedup(Linkable_NoDedup));
END;
