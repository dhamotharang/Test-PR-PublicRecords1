// Begin code to produce match candidates
IMPORT SALT29,ut;
EXPORT match_candidates(DATASET(layout_BizHead) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rcid,parent_proxid,ultimate_proxid,has_lgid,empid,powid,source,source_record_id,cnp_number,cnp_btype,cnp_lowv,cnp_name,company_phone,company_fein,company_sic_code1,prim_range,prim_name,sec_range,p_city_name,st,zip,company_url,isContact,title,fname,mname,lname,name_suffix,contact_email,CONTACTNAME,STREETADDRESS,ultid,orgid,seleid,proxid}),HASH(proxid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 empid_pop := AVE(GROUP,IF(thin_table.empid IN SET(s.nulls_empid,empid),0,100));
  REAL8 powid_pop := AVE(GROUP,IF(thin_table.powid IN SET(s.nulls_powid,powid),0,100));
  REAL8 source_pop := AVE(GROUP,IF(thin_table.source IN SET(s.nulls_source,source),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF(thin_table.source_record_id IN SET(s.nulls_source_record_id,source_record_id),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(thin_table.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(thin_table.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype),0,100));
  REAL8 cnp_lowv_pop := AVE(GROUP,IF(thin_table.cnp_lowv IN SET(s.nulls_cnp_lowv,cnp_lowv),0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(thin_table.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_sic_code1_pop := AVE(GROUP,IF(thin_table.company_sic_code1 IN SET(s.nulls_company_sic_code1,company_sic_code1),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 p_city_name_pop := AVE(GROUP,IF(thin_table.p_city_name IN SET(s.nulls_p_city_name,p_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 company_url_pop := AVE(GROUP,IF(thin_table.company_url IN SET(s.nulls_company_url,company_url),0,100));
  REAL8 isContact_pop := AVE(GROUP,IF(thin_table.isContact IN SET(s.nulls_isContact,isContact),0,100));
  REAL8 title_pop := AVE(GROUP,IF(thin_table.title IN SET(s.nulls_title,title),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(thin_table.fname IN SET(s.nulls_fname,fname),0,100));
  REAL8 mname_pop := AVE(GROUP,IF(thin_table.mname IN SET(s.nulls_mname,mname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(thin_table.lname IN SET(s.nulls_lname,lname),0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF(thin_table.name_suffix IN SET(s.nulls_name_suffix,name_suffix),0,100));
  REAL8 contact_email_pop := AVE(GROUP,IF(thin_table.contact_email IN SET(s.nulls_contact_email,contact_email),0,100));
  REAL8 CONTACTNAME_pop := AVE(GROUP,IF(thin_table.CONTACTNAME IN SET(s.nulls_CONTACTNAME,CONTACTNAME),0,100));
  REAL8 STREETADDRESS_pop := AVE(GROUP,IF(thin_table.STREETADDRESS IN SET(s.nulls_STREETADDRESS,STREETADDRESS),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 company_fein_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT29.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,proxid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.proxid<>(TYPEOF(ri.proxid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.proxid<>(TYPEOF(ri.proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(with_props,company_fein_props,left.proxid=right.proxid,take_company_fein(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
pj12 do_computes(pj12 le) := TRANSFORM
  SELF.CONTACTNAME := IF (Fields.InValid_CONTACTNAME((SALT29.StrType)le.fname,(SALT29.StrType)le.mname,(SALT29.StrType)le.lname),0,HASH32((SALT29.StrType)le.fname,(SALT29.StrType)le.mname,(SALT29.StrType)le.lname)); // Combine child fields into 1 for specificity counting
  SELF.STREETADDRESS := IF (Fields.InValid_STREETADDRESS((SALT29.StrType)le.prim_range,(SALT29.StrType)le.prim_name,(SALT29.StrType)le.sec_range),0,HASH32((SALT29.StrType)le.prim_range,(SALT29.StrType)le.prim_name,(SALT29.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj12,do_computes(left)) : PERSIST('~temp::proxid::BIPV2_WAF::mc_props::BizHead',EXPIRE(30)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 empid_pop := AVE(GROUP,IF(propogated.empid IN SET(s.nulls_empid,empid),0,100));
  REAL8 powid_pop := AVE(GROUP,IF(propogated.powid IN SET(s.nulls_powid,powid),0,100));
  REAL8 source_pop := AVE(GROUP,IF(propogated.source IN SET(s.nulls_source,source),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF(propogated.source_record_id IN SET(s.nulls_source_record_id,source_record_id),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(propogated.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(propogated.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype),0,100));
  REAL8 cnp_lowv_pop := AVE(GROUP,IF(propogated.cnp_lowv IN SET(s.nulls_cnp_lowv,cnp_lowv),0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(propogated.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_sic_code1_pop := AVE(GROUP,IF(propogated.company_sic_code1 IN SET(s.nulls_company_sic_code1,company_sic_code1),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 p_city_name_pop := AVE(GROUP,IF(propogated.p_city_name IN SET(s.nulls_p_city_name,p_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 company_url_pop := AVE(GROUP,IF(propogated.company_url IN SET(s.nulls_company_url,company_url),0,100));
  REAL8 isContact_pop := AVE(GROUP,IF(propogated.isContact IN SET(s.nulls_isContact,isContact),0,100));
  REAL8 title_pop := AVE(GROUP,IF(propogated.title IN SET(s.nulls_title,title),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(propogated.fname IN SET(s.nulls_fname,fname),0,100));
  REAL8 mname_pop := AVE(GROUP,IF(propogated.mname IN SET(s.nulls_mname,mname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(propogated.lname IN SET(s.nulls_lname,lname),0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF(propogated.name_suffix IN SET(s.nulls_name_suffix,name_suffix),0,100));
  REAL8 contact_email_pop := AVE(GROUP,IF(propogated.contact_email IN SET(s.nulls_contact_email,contact_email),0,100));
  REAL8 CONTACTNAME_pop := AVE(GROUP,IF(propogated.CONTACTNAME IN SET(s.nulls_CONTACTNAME,CONTACTNAME),0,100));
  REAL8 STREETADDRESS_pop := AVE(GROUP,IF(propogated.STREETADDRESS IN SET(s.nulls_STREETADDRESS,STREETADDRESS),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(proxid)),  EXCEPT rcid, LOCAL ), EXCEPT rcid, LOCAL );// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT29.UIDType proxid1;
  SALT29.UIDType proxid2;
  SALT29.UIDType rcid1 := 0;
  SALT29.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [cnp_name,company_url]; // remove wordbag fields which need to be expanded
  INTEGER2 empid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN empid_isnull := h0.empid  IN SET(s.nulls_empid,empid); // Simplify later processing 
  INTEGER2 powid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN powid_isnull := h0.powid  IN SET(s.nulls_powid,powid); // Simplify later processing 
  INTEGER2 source_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_isnull := h0.source  IN SET(s.nulls_source,source); // Simplify later processing 
  INTEGER2 source_record_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_record_id_isnull := h0.source_record_id  IN SET(s.nulls_source_record_id,source_record_id); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype); // Simplify later processing 
  INTEGER2 cnp_lowv_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_lowv_isnull := h0.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv); // Simplify later processing 
  STRING240 cnp_name := h0.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name); // Simplify later processing 
  INTEGER2 company_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_isnull := h0.company_phone  IN SET(s.nulls_company_phone,company_phone); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_sic_code1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_sic_code1_isnull := h0.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  UNSIGNED prim_range_cnt := 0; // Number of instances with this particular field value
  UNSIGNED prim_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  UNSIGNED prim_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED prim_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  UNSIGNED sec_range_cnt := 0; // Number of instances with this particular field value
  UNSIGNED sec_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 p_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN p_city_name_isnull := h0.p_city_name  IN SET(s.nulls_p_city_name,p_city_name); // Simplify later processing 
  UNSIGNED p_city_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED p_city_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  STRING240 company_url := h0.company_url; // Expanded wordbag field
  INTEGER2 company_url_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_url_isnull := h0.company_url  IN SET(s.nulls_company_url,company_url); // Simplify later processing 
  INTEGER2 isContact_weight100 := 0; // Contains 100x the specificity
  BOOLEAN isContact_isnull := h0.isContact  IN SET(s.nulls_isContact,isContact); // Simplify later processing 
  INTEGER2 title_weight100 := 0; // Contains 100x the specificity
  BOOLEAN title_isnull := h0.title  IN SET(s.nulls_title,title); // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := h0.fname  IN SET(s.nulls_fname,fname); // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 fname_PreferredName := (STRING20)'';
  UNSIGNED fname_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := h0.mname  IN SET(s.nulls_mname,mname); // Simplify later processing 
  UNSIGNED mname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED mname_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := h0.lname  IN SET(s.nulls_lname,lname); // Simplify later processing 
  UNSIGNED lname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED lname_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := h0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix); // Simplify later processing 
  UNSIGNED name_suffix_cnt := 0; // Number of instances with this particular field value
  STRING5 name_suffix_NormSuffix := (STRING5)'';
  UNSIGNED name_suffix_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
  INTEGER2 contact_email_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_email_isnull := h0.contact_email  IN SET(s.nulls_contact_email,contact_email); // Simplify later processing 
  INTEGER2 CONTACTNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CONTACTNAME_isnull := (h0.fname  IN SET(s.nulls_fname,fname) AND h0.mname  IN SET(s.nulls_mname,mname) AND h0.lname  IN SET(s.nulls_lname,lname)); // Simplify later processing 
  INTEGER2 STREETADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN STREETADDRESS_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_contact_email(layout_candidates le,Specificities(ih).contact_email_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_email_weight100 := MAP (le.contact_email_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_email_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(h1,PULL(Specificities(ih).contact_email_values_persisted),LEFT.contact_email=RIGHT.contact_email,add_contact_email(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_lowv(layout_candidates le,Specificities(ih).cnp_lowv_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_lowv_weight100 := MAP (le.cnp_lowv_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_lowv_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j28 := JOIN(j29,PULL(Specificities(ih).cnp_lowv_values_persisted),LEFT.cnp_lowv=RIGHT.cnp_lowv,add_cnp_lowv(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j27 := JOIN(j28,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).cnp_number_values_persisted),LEFT.cnp_number=RIGHT.cnp_number,add_cnp_number(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_powid(layout_candidates le,Specificities(ih).powid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.powid_weight100 := MAP (le.powid_isnull => 0, patch_default and ri.field_specificity=0 => s.powid_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).powid_values_persisted),LEFT.powid=RIGHT.powid,add_powid(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_empid(layout_candidates le,Specificities(ih).empid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.empid_weight100 := MAP (le.empid_isnull => 0, patch_default and ri.field_specificity=0 => s.empid_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j24 := JOIN(j25,PULL(Specificities(ih).empid_values_persisted),LEFT.empid=RIGHT.empid,add_empid(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_title(layout_candidates le,Specificities(ih).title_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.title_weight100 := MAP (le.title_isnull => 0, patch_default and ri.field_specificity=0 => s.title_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j24,PULL(Specificities(ih).title_values_persisted),LEFT.title=RIGHT.title,add_title(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_isContact(layout_candidates le,Specificities(ih).isContact_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.isContact_weight100 := MAP (le.isContact_isnull => 0, patch_default and ri.field_specificity=0 => s.isContact_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(j20,PULL(Specificities(ih).isContact_values_persisted),LEFT.isContact=RIGHT.isContact,add_isContact(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_source(layout_candidates le,Specificities(ih).source_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_weight100 := MAP (le.source_isnull => 0, patch_default and ri.field_specificity=0 => s.source_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(j19,PULL(Specificities(ih).source_values_persisted),LEFT.source=RIGHT.source,add_source(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j18,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_cnt := ri.cnt;
  SELF.name_suffix_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field name_suffix
  SELF.name_suffix_NormSuffix := ri.name_suffix_NormSuffix; // Copy NormSuffix value for field name_suffix
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j17,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_name_suffix,j16);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field fname
  SELF.fname_PreferredName := ri.fname_PreferredName; // Copy PreferredName value for field fname
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j16,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j15);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_cnt := ri.cnt;
  SELF.mname_e2_cnt := ri.e2_cnt;
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j15,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j14);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_cnt := ri.cnt;
  SELF.lname_e2_cnt := ri.e2_cnt;
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j14,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j13);
layout_candidates add_company_sic_code1(layout_candidates le,Specificities(ih).company_sic_code1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_sic_code1_weight100 := MAP (le.company_sic_code1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_sic_code1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j13,s.nulls_company_sic_code1,Specificities(ih).company_sic_code1_values_persisted,company_sic_code1,company_sic_code1_weight100,add_company_sic_code1,j12);
layout_candidates add_p_city_name(layout_candidates le,Specificities(ih).p_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.p_city_name_cnt := ri.cnt;
  SELF.p_city_name_e1_cnt := ri.e1_cnt;
  SELF.p_city_name_weight100 := MAP (le.p_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.p_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j12,s.nulls_p_city_name,Specificities(ih).p_city_name_values_persisted,p_city_name,p_city_name_weight100,add_p_city_name,j11);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_cnt := ri.cnt;
  SELF.sec_range_e1_cnt := ri.e1_cnt;
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j11,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j10);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_cnt := ri.cnt;
  SELF.prim_range_e1_cnt := ri.e1_cnt;
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j10,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j9);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j9,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j8);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_cnt := ri.cnt;
  SELF.prim_name_e1_cnt := ri.e1_cnt;
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j8,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j7);
layout_candidates add_STREETADDRESS(layout_candidates le,Specificities(ih).STREETADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.STREETADDRESS_weight100 := MAP (le.STREETADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.STREETADDRESS_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j7,s.nulls_STREETADDRESS,Specificities(ih).STREETADDRESS_values_persisted,STREETADDRESS,STREETADDRESS_weight100,add_STREETADDRESS,j6);
layout_candidates add_CONTACTNAME(layout_candidates le,Specificities(ih).CONTACTNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CONTACTNAME_weight100 := MAP (le.CONTACTNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.CONTACTNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j6,s.nulls_CONTACTNAME,Specificities(ih).CONTACTNAME_values_persisted,CONTACTNAME,CONTACTNAME_weight100,add_CONTACTNAME,j5);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT29.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j5,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j4);
layout_candidates add_company_url(layout_candidates le,Specificities(ih).company_url_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_url_weight100 := MAP (le.company_url_isnull => 0, patch_default and ri.field_specificity=0 => s.company_url_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.company_url := IF( ri.field_specificity<>0 or ri.word<>'',SELF.company_url_weight100+' '+ri.word,SALT29.Fn_WordBag_AppendSpecs_Fake(le.company_url, s.company_url_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j4,s.nulls_company_url,Specificities(ih).company_url_values_persisted,company_url,company_url_weight100,add_company_url,j3);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j3,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j2);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j2,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j1);
layout_candidates add_source_record_id(layout_candidates le,Specificities(ih).source_record_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_record_id_weight100 := MAP (le.source_record_id_isnull => 0, patch_default and ri.field_specificity=0 => s.source_record_id_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j1,s.nulls_source_record_id,Specificities(ih).source_record_id_values_persisted,source_record_id,source_record_id_weight100,add_source_record_id,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(proxid)) : PERSIST('~temp::proxid::BIPV2_WAF::mc',EXPIRE(30)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.source_record_id_weight100 + Annotated.company_phone_weight100 + Annotated.company_fein_weight100 + Annotated.company_url_weight100 + Annotated.cnp_name_weight100 + Annotated.CONTACTNAME_weight100 + Annotated.STREETADDRESS_weight100 + Annotated.zip_weight100 + Annotated.p_city_name_weight100 + Annotated.company_sic_code1_weight100 + Annotated.name_suffix_weight100 + Annotated.st_weight100 + Annotated.source_weight100 + Annotated.isContact_weight100 + Annotated.title_weight100 + Annotated.empid_weight100 + Annotated.powid_weight100 + Annotated.cnp_number_weight100 + Annotated.cnp_btype_weight100 + Annotated.cnp_lowv_weight100 + Annotated.contact_email_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
