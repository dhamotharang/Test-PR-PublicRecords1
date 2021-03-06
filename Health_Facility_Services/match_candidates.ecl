// Begin code to produce match candidates
IMPORT SALT29,ut;
EXPORT match_candidates(DATASET(layout_HealthFacility) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{CNAME,CNP_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,PRIM_RANGE,PRIM_NAME,SEC_RANGE,V_CITY_NAME,ST,ZIP,TAX_ID,FEIN,PHONE,FAX,LIC_STATE,C_LIC_NBR,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,CLIA_NUMBER,MEDICARE_FACILITY_NUMBER,MEDICAID_NUMBER,NCPDP_NUMBER,TAXONOMY,TAXONOMY_CODE,BDID,SRC,SOURCE_RID,FAC_NAME,ADDR1,LOCALE,ADDRES,LNPID}),HASH(LNPID));
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 CNP_NAME_pop := AVE(GROUP,IF(thin_table.CNP_NAME IN SET(s.nulls_CNP_NAME,CNP_NAME),0,100));
  REAL8 CNP_NUMBER_pop := AVE(GROUP,IF(thin_table.CNP_NUMBER IN SET(s.nulls_CNP_NUMBER,CNP_NUMBER),0,100));
  REAL8 CNP_STORE_NUMBER_pop := AVE(GROUP,IF(thin_table.CNP_STORE_NUMBER IN SET(s.nulls_CNP_STORE_NUMBER,CNP_STORE_NUMBER),0,100));
  REAL8 CNP_BTYPE_pop := AVE(GROUP,IF(thin_table.CNP_BTYPE IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE),0,100));
  REAL8 CNP_LOWV_pop := AVE(GROUP,IF(thin_table.CNP_LOWV IN SET(s.nulls_CNP_LOWV,CNP_LOWV),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(thin_table.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF(thin_table.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF(thin_table.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  REAL8 V_CITY_NAME_pop := AVE(GROUP,IF(thin_table.V_CITY_NAME IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME),0,100));
  REAL8 ST_pop := AVE(GROUP,IF(thin_table.ST IN SET(s.nulls_ST,ST),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF(thin_table.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
  REAL8 TAX_ID_pop := AVE(GROUP,IF(thin_table.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID),0,100));
  REAL8 FEIN_pop := AVE(GROUP,IF(thin_table.FEIN IN SET(s.nulls_FEIN,FEIN),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF(thin_table.PHONE IN SET(s.nulls_PHONE,PHONE),0,100));
  REAL8 FAX_pop := AVE(GROUP,IF(thin_table.FAX IN SET(s.nulls_FAX,FAX),0,100));
  REAL8 LIC_STATE_pop := AVE(GROUP,IF(thin_table.LIC_STATE IN SET(s.nulls_LIC_STATE,LIC_STATE),0,100));
  REAL8 C_LIC_NBR_pop := AVE(GROUP,IF(thin_table.C_LIC_NBR IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR),0,100));
  REAL8 DEA_NUMBER_pop := AVE(GROUP,IF(thin_table.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),0,100));
  REAL8 VENDOR_ID_pop := AVE(GROUP,IF(thin_table.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
  REAL8 NPI_NUMBER_pop := AVE(GROUP,IF(thin_table.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),0,100));
  REAL8 CLIA_NUMBER_pop := AVE(GROUP,IF(thin_table.CLIA_NUMBER IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER),0,100));
  REAL8 MEDICARE_FACILITY_NUMBER_pop := AVE(GROUP,IF(thin_table.MEDICARE_FACILITY_NUMBER IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER),0,100));
  REAL8 MEDICAID_NUMBER_pop := AVE(GROUP,IF(thin_table.MEDICAID_NUMBER IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER),0,100));
  REAL8 NCPDP_NUMBER_pop := AVE(GROUP,IF(thin_table.NCPDP_NUMBER IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER),0,100));
  REAL8 TAXONOMY_pop := AVE(GROUP,IF(thin_table.TAXONOMY IN SET(s.nulls_TAXONOMY,TAXONOMY),0,100));
  REAL8 TAXONOMY_CODE_pop := AVE(GROUP,IF(thin_table.TAXONOMY_CODE IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE),0,100));
  REAL8 BDID_pop := AVE(GROUP,IF(thin_table.BDID IN SET(s.nulls_BDID,BDID),0,100));
  REAL8 SRC_pop := AVE(GROUP,IF(thin_table.SRC IN SET(s.nulls_SRC,SRC),0,100));
  REAL8 SOURCE_RID_pop := AVE(GROUP,IF(thin_table.SOURCE_RID IN SET(s.nulls_SOURCE_RID,SOURCE_RID),0,100));
  REAL8 FAC_NAME_pop := AVE(GROUP,IF(thin_table.FAC_NAME IN SET(s.nulls_FAC_NAME,FAC_NAME),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(thin_table.ADDR1 IN SET(s.nulls_ADDR1,ADDR1),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(thin_table.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
  REAL8 ADDRES_pop := AVE(GROUP,IF(thin_table.ADDRES IN SET(s.nulls_ADDRES,ADDRES),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 CNP_NAME_prop := 0;
  UNSIGNED1 CNP_NUMBER_prop := 0;
  UNSIGNED1 CNP_STORE_NUMBER_prop := 0;
  UNSIGNED1 CNP_BTYPE_prop := 0;
  UNSIGNED1 CNP_LOWV_prop := 0;
  UNSIGNED1 TAX_ID_prop := 0;
  UNSIGNED1 FEIN_prop := 0;
  UNSIGNED1 FAC_NAME_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SALT29.mac_prop_field(with_props(CNP_BTYPE NOT IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE)),CNP_BTYPE,LNPID,CNP_BTYPE_props); // For every DID find the best FULL CNP_BTYPE
layout_withpropvars take_CNP_BTYPE(with_props le,CNP_BTYPE_props ri) := TRANSFORM
  SELF.CNP_BTYPE := IF ( le.CNP_BTYPE IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.CNP_BTYPE, le.CNP_BTYPE );
  SELF.CNP_BTYPE_prop := le.CNP_BTYPE_prop + IF ( le.CNP_BTYPE IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE) and ri.CNP_BTYPE NOT IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(with_props,CNP_BTYPE_props,left.LNPID=right.LNPID,take_CNP_BTYPE(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID)),TAX_ID,LNPID,TAX_ID_props); // For every DID find the best FULL TAX_ID
layout_withpropvars take_TAX_ID(with_props le,TAX_ID_props ri) := TRANSFORM
  SELF.TAX_ID := IF ( le.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.TAX_ID, le.TAX_ID );
  SELF.TAX_ID_prop := le.TAX_ID_prop + IF ( le.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID) and ri.TAX_ID NOT IN SET(s.nulls_TAX_ID,TAX_ID) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(pj4,TAX_ID_props,left.LNPID=right.LNPID,take_TAX_ID(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(FEIN NOT IN SET(s.nulls_FEIN,FEIN)),FEIN,LNPID,FEIN_props); // For every DID find the best FULL FEIN
layout_withpropvars take_FEIN(with_props le,FEIN_props ri) := TRANSFORM
  SELF.FEIN := IF ( le.FEIN IN SET(s.nulls_FEIN,FEIN) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.FEIN, le.FEIN );
  SELF.FEIN_prop := le.FEIN_prop + IF ( le.FEIN IN SET(s.nulls_FEIN,FEIN) and ri.FEIN NOT IN SET(s.nulls_FEIN,FEIN) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj13 := JOIN(pj12,FEIN_props,left.LNPID=right.LNPID,take_FEIN(left,right),LEFT OUTER,HASH,HINT(parallel_match));
pj13 do_computes(pj13 le) := TRANSFORM
  SELF.FAC_NAME := IF (Fields.InValid_FAC_NAME((SALT29.StrType)le.CNP_NAME,(SALT29.StrType)le.CNP_NUMBER,(SALT29.StrType)le.CNP_STORE_NUMBER,(SALT29.StrType)le.CNP_BTYPE,(SALT29.StrType)le.CNP_LOWV),0,HASH32((SALT29.StrType)le.CNP_NAME,(SALT29.StrType)le.CNP_NUMBER,(SALT29.StrType)le.CNP_STORE_NUMBER,(SALT29.StrType)le.CNP_BTYPE,(SALT29.StrType)le.CNP_LOWV)); // Combine child fields into 1 for specificity counting
  SELF.FAC_NAME_prop := IF( le.CNP_BTYPE_prop > 0, 8, 0 );
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.PRIM_NAME),0,HASH32((SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP),0,HASH32((SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRES := IF (Fields.InValid_ADDRES((SALT29.StrType)SELF.ADDR1,(SALT29.StrType)SELF.LOCALE),0,HASH32((SALT29.StrType)SELF.ADDR1,(SALT29.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj13,do_computes(left)) : PERSIST('~temp::LNPID::Health_Facility_Services::mc_props::HealthFacility',EXPIRE(30)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 CNP_NAME_pop := AVE(GROUP,IF(propogated.CNP_NAME IN SET(s.nulls_CNP_NAME,CNP_NAME),0,100));
  REAL8 CNP_NUMBER_pop := AVE(GROUP,IF(propogated.CNP_NUMBER IN SET(s.nulls_CNP_NUMBER,CNP_NUMBER),0,100));
  REAL8 CNP_STORE_NUMBER_pop := AVE(GROUP,IF(propogated.CNP_STORE_NUMBER IN SET(s.nulls_CNP_STORE_NUMBER,CNP_STORE_NUMBER),0,100));
  REAL8 CNP_BTYPE_pop := AVE(GROUP,IF(propogated.CNP_BTYPE IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE),0,100));
  REAL8 CNP_LOWV_pop := AVE(GROUP,IF(propogated.CNP_LOWV IN SET(s.nulls_CNP_LOWV,CNP_LOWV),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(propogated.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF(propogated.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF(propogated.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  REAL8 V_CITY_NAME_pop := AVE(GROUP,IF(propogated.V_CITY_NAME IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME),0,100));
  REAL8 ST_pop := AVE(GROUP,IF(propogated.ST IN SET(s.nulls_ST,ST),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF(propogated.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
  REAL8 TAX_ID_pop := AVE(GROUP,IF(propogated.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID),0,100));
  REAL8 FEIN_pop := AVE(GROUP,IF(propogated.FEIN IN SET(s.nulls_FEIN,FEIN),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF(propogated.PHONE IN SET(s.nulls_PHONE,PHONE),0,100));
  REAL8 FAX_pop := AVE(GROUP,IF(propogated.FAX IN SET(s.nulls_FAX,FAX),0,100));
  REAL8 LIC_STATE_pop := AVE(GROUP,IF(propogated.LIC_STATE IN SET(s.nulls_LIC_STATE,LIC_STATE),0,100));
  REAL8 C_LIC_NBR_pop := AVE(GROUP,IF(propogated.C_LIC_NBR IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR),0,100));
  REAL8 DEA_NUMBER_pop := AVE(GROUP,IF(propogated.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),0,100));
  REAL8 VENDOR_ID_pop := AVE(GROUP,IF(propogated.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
  REAL8 NPI_NUMBER_pop := AVE(GROUP,IF(propogated.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),0,100));
  REAL8 CLIA_NUMBER_pop := AVE(GROUP,IF(propogated.CLIA_NUMBER IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER),0,100));
  REAL8 MEDICARE_FACILITY_NUMBER_pop := AVE(GROUP,IF(propogated.MEDICARE_FACILITY_NUMBER IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER),0,100));
  REAL8 MEDICAID_NUMBER_pop := AVE(GROUP,IF(propogated.MEDICAID_NUMBER IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER),0,100));
  REAL8 NCPDP_NUMBER_pop := AVE(GROUP,IF(propogated.NCPDP_NUMBER IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER),0,100));
  REAL8 TAXONOMY_pop := AVE(GROUP,IF(propogated.TAXONOMY IN SET(s.nulls_TAXONOMY,TAXONOMY),0,100));
  REAL8 TAXONOMY_CODE_pop := AVE(GROUP,IF(propogated.TAXONOMY_CODE IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE),0,100));
  REAL8 BDID_pop := AVE(GROUP,IF(propogated.BDID IN SET(s.nulls_BDID,BDID),0,100));
  REAL8 SRC_pop := AVE(GROUP,IF(propogated.SRC IN SET(s.nulls_SRC,SRC),0,100));
  REAL8 SOURCE_RID_pop := AVE(GROUP,IF(propogated.SOURCE_RID IN SET(s.nulls_SOURCE_RID,SOURCE_RID),0,100));
  REAL8 FAC_NAME_pop := AVE(GROUP,IF(propogated.FAC_NAME IN SET(s.nulls_FAC_NAME,FAC_NAME),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(propogated.ADDR1 IN SET(s.nulls_ADDR1,ADDR1),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(propogated.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
  REAL8 ADDRES_pop := AVE(GROUP,IF(propogated.ADDRES IN SET(s.nulls_ADDRES,ADDRES),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(LNPID)),  WHOLE RECORD, LOCAL ), WHOLE RECORD, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT29.UIDType LNPID1;
  SALT29.UIDType LNPID2;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [CNP_NAME]; // remove wordbag fields which need to be expanded
  STRING240 CNP_NAME := h0.CNP_NAME; // Expanded wordbag field
  INTEGER2 CNP_NAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 CNP_NAME_FAC_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CNP_NAME_isnull := h0.CNP_NAME  IN SET(s.nulls_CNP_NAME,CNP_NAME); // Simplify later processing 
  INTEGER2 CNP_NAME_FAC_NAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 CNP_NUMBER_weight100 := 0; // Contains 100x the specificity
  INTEGER2 CNP_NUMBER_FAC_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CNP_NUMBER_isnull := h0.CNP_NUMBER  IN SET(s.nulls_CNP_NUMBER,CNP_NUMBER); // Simplify later processing 
  INTEGER2 CNP_NUMBER_FAC_NAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 CNP_STORE_NUMBER_weight100 := 0; // Contains 100x the specificity
  INTEGER2 CNP_STORE_NUMBER_FAC_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CNP_STORE_NUMBER_isnull := h0.CNP_STORE_NUMBER  IN SET(s.nulls_CNP_STORE_NUMBER,CNP_STORE_NUMBER); // Simplify later processing 
  INTEGER2 CNP_STORE_NUMBER_FAC_NAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 CNP_BTYPE_weight100 := 0; // Contains 100x the specificity
  INTEGER2 CNP_BTYPE_FAC_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CNP_BTYPE_isnull := h0.CNP_BTYPE  IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE); // Simplify later processing 
  INTEGER2 CNP_BTYPE_FAC_NAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 CNP_LOWV_weight100 := 0; // Contains 100x the specificity
  INTEGER2 CNP_LOWV_FAC_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CNP_LOWV_isnull := h0.CNP_LOWV  IN SET(s.nulls_CNP_LOWV,CNP_LOWV); // Simplify later processing 
  INTEGER2 CNP_LOWV_FAC_NAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_RANGE_isnull := h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE); // Simplify later processing 
  UNSIGNED PRIM_RANGE_cnt := 0; // Number of instances with this particular field value
  UNSIGNED PRIM_RANGE_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_NAME_isnull := h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME); // Simplify later processing 
  UNSIGNED PRIM_NAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED PRIM_NAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEC_RANGE_isnull := h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE); // Simplify later processing 
  INTEGER2 V_CITY_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN V_CITY_NAME_isnull := h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME); // Simplify later processing 
  UNSIGNED V_CITY_NAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED V_CITY_NAME_p_cnt := 0; // Number of names instances matching this one phonetically
  UNSIGNED V_CITY_NAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED V_CITY_NAME_e2p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  INTEGER2 ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ST_isnull := h0.ST  IN SET(s.nulls_ST,ST); // Simplify later processing 
  INTEGER2 ZIP_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ZIP_isnull := h0.ZIP  IN SET(s.nulls_ZIP,ZIP); // Simplify later processing 
  INTEGER2 TAX_ID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TAX_ID_isnull := h0.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID); // Simplify later processing 
  INTEGER2 FEIN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FEIN_isnull := h0.FEIN  IN SET(s.nulls_FEIN,FEIN); // Simplify later processing 
  INTEGER2 PHONE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PHONE_isnull := h0.PHONE  IN SET(s.nulls_PHONE,PHONE); // Simplify later processing 
  UNSIGNED PHONE_cnt := 0; // Number of instances with this particular field value
  STRING10 PHONE_CleanPhone := (STRING10)'';
  UNSIGNED PHONE_CleanPhone_cnt := 0; // Number of names instances matching this one using CleanPhone
  INTEGER2 FAX_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FAX_isnull := h0.FAX  IN SET(s.nulls_FAX,FAX); // Simplify later processing 
  UNSIGNED FAX_cnt := 0; // Number of instances with this particular field value
  STRING10 FAX_CleanPhone := (STRING10)'';
  UNSIGNED FAX_CleanPhone_cnt := 0; // Number of names instances matching this one using CleanPhone
  INTEGER2 LIC_STATE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LIC_STATE_isnull := h0.LIC_STATE  IN SET(s.nulls_LIC_STATE,LIC_STATE); // Simplify later processing 
  INTEGER2 C_LIC_NBR_weight100 := 0; // Contains 100x the specificity
  BOOLEAN C_LIC_NBR_isnull := h0.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR); // Simplify later processing 
  UNSIGNED C_LIC_NBR_cnt := 0; // Number of instances with this particular field value
  UNSIGNED C_LIC_NBR_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 DEA_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DEA_NUMBER_isnull := h0.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER); // Simplify later processing 
  INTEGER2 VENDOR_ID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN VENDOR_ID_isnull := h0.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID); // Simplify later processing 
  INTEGER2 NPI_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NPI_NUMBER_isnull := h0.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER); // Simplify later processing 
  INTEGER2 CLIA_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CLIA_NUMBER_isnull := h0.CLIA_NUMBER  IN SET(s.nulls_CLIA_NUMBER,CLIA_NUMBER); // Simplify later processing 
  INTEGER2 MEDICARE_FACILITY_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MEDICARE_FACILITY_NUMBER_isnull := h0.MEDICARE_FACILITY_NUMBER  IN SET(s.nulls_MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER); // Simplify later processing 
  INTEGER2 MEDICAID_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MEDICAID_NUMBER_isnull := h0.MEDICAID_NUMBER  IN SET(s.nulls_MEDICAID_NUMBER,MEDICAID_NUMBER); // Simplify later processing 
  INTEGER2 NCPDP_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NCPDP_NUMBER_isnull := h0.NCPDP_NUMBER  IN SET(s.nulls_NCPDP_NUMBER,NCPDP_NUMBER); // Simplify later processing 
  INTEGER2 TAXONOMY_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TAXONOMY_isnull := h0.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY); // Simplify later processing 
  INTEGER2 TAXONOMY_CODE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TAXONOMY_CODE_isnull := h0.TAXONOMY_CODE  IN SET(s.nulls_TAXONOMY_CODE,TAXONOMY_CODE); // Simplify later processing 
  INTEGER2 BDID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN BDID_isnull := h0.BDID  IN SET(s.nulls_BDID,BDID); // Simplify later processing 
  INTEGER2 SRC_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SRC_isnull := h0.SRC  IN SET(s.nulls_SRC,SRC); // Simplify later processing 
  INTEGER2 SOURCE_RID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SOURCE_RID_isnull := h0.SOURCE_RID  IN SET(s.nulls_SOURCE_RID,SOURCE_RID); // Simplify later processing 
  INTEGER2 FAC_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FAC_NAME_isnull := (h0.CNP_NAME  IN SET(s.nulls_CNP_NAME,CNP_NAME) AND h0.CNP_NUMBER  IN SET(s.nulls_CNP_NUMBER,CNP_NUMBER) AND h0.CNP_STORE_NUMBER  IN SET(s.nulls_CNP_STORE_NUMBER,CNP_STORE_NUMBER) AND h0.CNP_BTYPE  IN SET(s.nulls_CNP_BTYPE,CNP_BTYPE) AND h0.CNP_LOWV  IN SET(s.nulls_CNP_LOWV,CNP_LOWV)); // Simplify later processing 
  INTEGER2 ADDR1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDR1_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)); // Simplify later processing 
  INTEGER2 LOCALE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LOCALE_isnull := (h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND h0.ST  IN SET(s.nulls_ST,ST) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP)); // Simplify later processing 
  INTEGER2 ADDRES_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDRES_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) AND (h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND h0.ST  IN SET(s.nulls_ST,ST) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_SRC(layout_candidates le,Specificities(ih).SRC_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SRC_weight100 := MAP (le.SRC_isnull => 0, patch_default and ri.field_specificity=0 => s.SRC_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j32 := JOIN(h1,PULL(Specificities(ih).SRC_values_persisted),LEFT.SRC=RIGHT.SRC,add_SRC(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_TAXONOMY_CODE(layout_candidates le,Specificities(ih).TAXONOMY_CODE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TAXONOMY_CODE_weight100 := MAP (le.TAXONOMY_CODE_isnull => 0, patch_default and ri.field_specificity=0 => s.TAXONOMY_CODE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j31 := JOIN(j32,PULL(Specificities(ih).TAXONOMY_CODE_values_persisted),LEFT.TAXONOMY_CODE=RIGHT.TAXONOMY_CODE,add_TAXONOMY_CODE(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_CNP_BTYPE(layout_candidates le,Specificities(ih).CNP_BTYPE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  INTEGER2 CNP_BTYPE_weight100 := MAP (le.CNP_BTYPE_isnull => 0, patch_default and ri.field_specificity=0 => s.CNP_BTYPE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.CNP_BTYPE_weight100 := CNP_BTYPE_weight100;
  SELF.CNP_BTYPE_FAC_NAME_cnt := ri.FAC_NAME_cnt;
  SELF.CNP_BTYPE_FAC_NAME_weight100 := SALT29.Min0(CNP_BTYPE_weight100 + 100*log(ri.cnt/ri.FAC_NAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
j30 := JOIN(j31,PULL(Specificities(ih).CNP_BTYPE_values_persisted),LEFT.CNP_BTYPE=RIGHT.CNP_BTYPE,add_CNP_BTYPE(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_LIC_STATE(layout_candidates le,Specificities(ih).LIC_STATE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LIC_STATE_weight100 := MAP (le.LIC_STATE_isnull => 0, patch_default and ri.field_specificity=0 => s.LIC_STATE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(j30,PULL(Specificities(ih).LIC_STATE_values_persisted),LEFT.LIC_STATE=RIGHT.LIC_STATE,add_LIC_STATE(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j28 := JOIN(j29,PULL(Specificities(ih).ST_values_persisted),LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_CNP_LOWV(layout_candidates le,Specificities(ih).CNP_LOWV_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  INTEGER2 CNP_LOWV_weight100 := MAP (le.CNP_LOWV_isnull => 0, patch_default and ri.field_specificity=0 => s.CNP_LOWV_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.CNP_LOWV_weight100 := CNP_LOWV_weight100;
  SELF.CNP_LOWV_FAC_NAME_cnt := ri.FAC_NAME_cnt;
  SELF.CNP_LOWV_FAC_NAME_weight100 := SALT29.Min0(CNP_LOWV_weight100 + 100*log(ri.cnt/ri.FAC_NAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
j27 := JOIN(j28,PULL(Specificities(ih).CNP_LOWV_values_persisted),LEFT.CNP_LOWV=RIGHT.CNP_LOWV,add_CNP_LOWV(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_TAXONOMY(layout_candidates le,Specificities(ih).TAXONOMY_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TAXONOMY_weight100 := MAP (le.TAXONOMY_isnull => 0, patch_default and ri.field_specificity=0 => s.TAXONOMY_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).TAXONOMY_values_persisted),LEFT.TAXONOMY=RIGHT.TAXONOMY,add_TAXONOMY(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).SEC_RANGE_values_persisted),LEFT.SEC_RANGE=RIGHT.SEC_RANGE,add_SEC_RANGE(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_C_LIC_NBR(layout_candidates le,Specificities(ih).C_LIC_NBR_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.C_LIC_NBR_cnt := ri.cnt;
  SELF.C_LIC_NBR_e2_cnt := ri.e2_cnt;
  SELF.C_LIC_NBR_weight100 := MAP (le.C_LIC_NBR_isnull => 0, patch_default and ri.field_specificity=0 => s.C_LIC_NBR_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j25,s.nulls_C_LIC_NBR,Specificities(ih).C_LIC_NBR_values_persisted,C_LIC_NBR,C_LIC_NBR_weight100,add_C_LIC_NBR,j24);
layout_candidates add_V_CITY_NAME(layout_candidates le,Specificities(ih).V_CITY_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.V_CITY_NAME_cnt := ri.cnt;
  SELF.V_CITY_NAME_p_cnt := ri.p_cnt;
  SELF.V_CITY_NAME_e2_cnt := ri.e2_cnt;
  SELF.V_CITY_NAME_e2p_cnt := ri.e2p_cnt;
  SELF.V_CITY_NAME_weight100 := MAP (le.V_CITY_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.V_CITY_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j24,s.nulls_V_CITY_NAME,Specificities(ih).V_CITY_NAME_values_persisted,V_CITY_NAME,V_CITY_NAME_weight100,add_V_CITY_NAME,j23);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_RANGE_cnt := ri.cnt;
  SELF.PRIM_RANGE_e1_cnt := ri.e1_cnt;
  SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j23,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j22);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j22,s.nulls_LOCALE,Specificities(ih).LOCALE_values_persisted,LOCALE,LOCALE_weight100,add_LOCALE,j21);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j21,s.nulls_ZIP,Specificities(ih).ZIP_values_persisted,ZIP,ZIP_weight100,add_ZIP,j20);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_NAME_cnt := ri.cnt;
  SELF.PRIM_NAME_e1_cnt := ri.e1_cnt;
  SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j20,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j19);
layout_candidates add_CNP_NAME(layout_candidates le,Specificities(ih).CNP_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  INTEGER2 CNP_NAME_weight100 := MAP (le.CNP_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.CNP_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.CNP_NAME_weight100 := CNP_NAME_weight100;
  SELF.CNP_NAME_FAC_NAME_cnt := ri.FAC_NAME_cnt;
  SELF.CNP_NAME_FAC_NAME_weight100 := SALT29.Min0(CNP_NAME_weight100 + 100*log(ri.cnt/ri.FAC_NAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.CNP_NAME := IF( ri.field_specificity<>0 or ri.word<>'',SELF.CNP_NAME_weight100+' '+ri.word,SALT29.Fn_WordBag_AppendSpecs_Fake(le.CNP_NAME, s.CNP_NAME_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j19,s.nulls_CNP_NAME,Specificities(ih).CNP_NAME_values_persisted,CNP_NAME,CNP_NAME_weight100,add_CNP_NAME,j18);
layout_candidates add_FEIN(layout_candidates le,Specificities(ih).FEIN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FEIN_weight100 := MAP (le.FEIN_isnull => 0, patch_default and ri.field_specificity=0 => s.FEIN_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j18,s.nulls_FEIN,Specificities(ih).FEIN_values_persisted,FEIN,FEIN_weight100,add_FEIN,j17);
layout_candidates add_CNP_NUMBER(layout_candidates le,Specificities(ih).CNP_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  INTEGER2 CNP_NUMBER_weight100 := MAP (le.CNP_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.CNP_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.CNP_NUMBER_weight100 := CNP_NUMBER_weight100;
  SELF.CNP_NUMBER_FAC_NAME_cnt := ri.FAC_NAME_cnt;
  SELF.CNP_NUMBER_FAC_NAME_weight100 := SALT29.Min0(CNP_NUMBER_weight100 + 100*log(ri.cnt/ri.FAC_NAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j17,s.nulls_CNP_NUMBER,Specificities(ih).CNP_NUMBER_values_persisted,CNP_NUMBER,CNP_NUMBER_weight100,add_CNP_NUMBER,j16);
layout_candidates add_TAX_ID(layout_candidates le,Specificities(ih).TAX_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TAX_ID_weight100 := MAP (le.TAX_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.TAX_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j16,s.nulls_TAX_ID,Specificities(ih).TAX_ID_values_persisted,TAX_ID,TAX_ID_weight100,add_TAX_ID,j15);
layout_candidates add_ADDRES(layout_candidates le,Specificities(ih).ADDRES_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDRES_weight100 := MAP (le.ADDRES_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRES_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j15,s.nulls_ADDRES,Specificities(ih).ADDRES_values_persisted,ADDRES,ADDRES_weight100,add_ADDRES,j14);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDR1_weight100 := MAP (le.ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j14,s.nulls_ADDR1,Specificities(ih).ADDR1_values_persisted,ADDR1,ADDR1_weight100,add_ADDR1,j13);
layout_candidates add_FAC_NAME(layout_candidates le,Specificities(ih).FAC_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FAC_NAME_weight100 := MAP (le.FAC_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FAC_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j13,s.nulls_FAC_NAME,Specificities(ih).FAC_NAME_values_persisted,FAC_NAME,FAC_NAME_weight100,add_FAC_NAME,j12);
layout_candidates add_FAX(layout_candidates le,Specificities(ih).FAX_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FAX_cnt := ri.cnt;
  SELF.FAX_CleanPhone_cnt := ri.CleanPhone_cnt; // Copy in count of matching CleanPhone values for field FAX
  SELF.FAX_CleanPhone := ri.FAX_CleanPhone; // Copy CleanPhone value for field FAX
  SELF.FAX_weight100 := MAP (le.FAX_isnull => 0, patch_default and ri.field_specificity=0 => s.FAX_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j12,s.nulls_FAX,Specificities(ih).FAX_values_persisted,FAX,FAX_weight100,add_FAX,j11);
layout_candidates add_PHONE(layout_candidates le,Specificities(ih).PHONE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PHONE_cnt := ri.cnt;
  SELF.PHONE_CleanPhone_cnt := ri.CleanPhone_cnt; // Copy in count of matching CleanPhone values for field PHONE
  SELF.PHONE_CleanPhone := ri.PHONE_CleanPhone; // Copy CleanPhone value for field PHONE
  SELF.PHONE_weight100 := MAP (le.PHONE_isnull => 0, patch_default and ri.field_specificity=0 => s.PHONE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j11,s.nulls_PHONE,Specificities(ih).PHONE_values_persisted,PHONE,PHONE_weight100,add_PHONE,j10);
layout_candidates add_CNP_STORE_NUMBER(layout_candidates le,Specificities(ih).CNP_STORE_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  INTEGER2 CNP_STORE_NUMBER_weight100 := MAP (le.CNP_STORE_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.CNP_STORE_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.CNP_STORE_NUMBER_weight100 := CNP_STORE_NUMBER_weight100;
  SELF.CNP_STORE_NUMBER_FAC_NAME_cnt := ri.FAC_NAME_cnt;
  SELF.CNP_STORE_NUMBER_FAC_NAME_weight100 := SALT29.Min0(CNP_STORE_NUMBER_weight100 + 100*log(ri.cnt/ri.FAC_NAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j10,s.nulls_CNP_STORE_NUMBER,Specificities(ih).CNP_STORE_NUMBER_values_persisted,CNP_STORE_NUMBER,CNP_STORE_NUMBER_weight100,add_CNP_STORE_NUMBER,j9);
layout_candidates add_BDID(layout_candidates le,Specificities(ih).BDID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.BDID_weight100 := MAP (le.BDID_isnull => 0, patch_default and ri.field_specificity=0 => s.BDID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j9,s.nulls_BDID,Specificities(ih).BDID_values_persisted,BDID,BDID_weight100,add_BDID,j8);
layout_candidates add_DEA_NUMBER(layout_candidates le,Specificities(ih).DEA_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DEA_NUMBER_weight100 := MAP (le.DEA_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.DEA_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j8,s.nulls_DEA_NUMBER,Specificities(ih).DEA_NUMBER_values_persisted,DEA_NUMBER,DEA_NUMBER_weight100,add_DEA_NUMBER,j7);
layout_candidates add_SOURCE_RID(layout_candidates le,Specificities(ih).SOURCE_RID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SOURCE_RID_weight100 := MAP (le.SOURCE_RID_isnull => 0, patch_default and ri.field_specificity=0 => s.SOURCE_RID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j7,s.nulls_SOURCE_RID,Specificities(ih).SOURCE_RID_values_persisted,SOURCE_RID,SOURCE_RID_weight100,add_SOURCE_RID,j6);
layout_candidates add_NCPDP_NUMBER(layout_candidates le,Specificities(ih).NCPDP_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NCPDP_NUMBER_weight100 := MAP (le.NCPDP_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.NCPDP_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j6,s.nulls_NCPDP_NUMBER,Specificities(ih).NCPDP_NUMBER_values_persisted,NCPDP_NUMBER,NCPDP_NUMBER_weight100,add_NCPDP_NUMBER,j5);
layout_candidates add_MEDICAID_NUMBER(layout_candidates le,Specificities(ih).MEDICAID_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MEDICAID_NUMBER_weight100 := MAP (le.MEDICAID_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.MEDICAID_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j5,s.nulls_MEDICAID_NUMBER,Specificities(ih).MEDICAID_NUMBER_values_persisted,MEDICAID_NUMBER,MEDICAID_NUMBER_weight100,add_MEDICAID_NUMBER,j4);
layout_candidates add_MEDICARE_FACILITY_NUMBER(layout_candidates le,Specificities(ih).MEDICARE_FACILITY_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MEDICARE_FACILITY_NUMBER_weight100 := MAP (le.MEDICARE_FACILITY_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.MEDICARE_FACILITY_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j4,s.nulls_MEDICARE_FACILITY_NUMBER,Specificities(ih).MEDICARE_FACILITY_NUMBER_values_persisted,MEDICARE_FACILITY_NUMBER,MEDICARE_FACILITY_NUMBER_weight100,add_MEDICARE_FACILITY_NUMBER,j3);
layout_candidates add_CLIA_NUMBER(layout_candidates le,Specificities(ih).CLIA_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CLIA_NUMBER_weight100 := MAP (le.CLIA_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.CLIA_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j3,s.nulls_CLIA_NUMBER,Specificities(ih).CLIA_NUMBER_values_persisted,CLIA_NUMBER,CLIA_NUMBER_weight100,add_CLIA_NUMBER,j2);
layout_candidates add_NPI_NUMBER(layout_candidates le,Specificities(ih).NPI_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NPI_NUMBER_weight100 := MAP (le.NPI_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.NPI_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j2,s.nulls_NPI_NUMBER,Specificities(ih).NPI_NUMBER_values_persisted,NPI_NUMBER,NPI_NUMBER_weight100,add_NPI_NUMBER,j1);
layout_candidates add_VENDOR_ID(layout_candidates le,Specificities(ih).VENDOR_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.VENDOR_ID_weight100 := MAP (le.VENDOR_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.VENDOR_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j1,s.nulls_VENDOR_ID,Specificities(ih).VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_weight100,add_VENDOR_ID,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(LNPID)) : PERSIST('~temp::LNPID::Health_Facility_Services::mc',EXPIRE(30)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.VENDOR_ID_weight100 + Annotated.NPI_NUMBER_weight100 + Annotated.CLIA_NUMBER_weight100 + Annotated.MEDICARE_FACILITY_NUMBER_weight100 + Annotated.MEDICAID_NUMBER_weight100 + Annotated.NCPDP_NUMBER_weight100 + Annotated.SOURCE_RID_weight100 + Annotated.DEA_NUMBER_weight100 + Annotated.BDID_weight100 + Annotated.PHONE_weight100 + Annotated.FAX_weight100 + Annotated.FAC_NAME_weight100 + Annotated.ADDRES_weight100 + Annotated.TAX_ID_weight100 + Annotated.FEIN_weight100 + Annotated.C_LIC_NBR_weight100 + Annotated.TAXONOMY_weight100 + Annotated.LIC_STATE_weight100 + Annotated.TAXONOMY_CODE_weight100 + Annotated.SRC_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
