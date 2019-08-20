// Begin code to produce match candidates
IMPORT SALT311,STD;
IMPORT Watchdog_Best; // Import modules for  attribute definitions
EXPORT match_candidates(DATASET(layout_Hdr) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Watchdog_best.BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rid,pflag1,pflag2,pflag3,src,dt_first_seen,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,dt_nonglb_last_seen,rec_type,phone,phone_len,ssn,dob,title,fname,fname_len,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,valid_ssn,jflag1,jflag2,jflag3,rawaid,dodgy_tracking,address_ind,name_ind,persistent_record_id,lastname,ssnum,address,did}),HASH(did));
SHARED BestM := MAC_CreateBest(ih, , );


  SHARED MAC_RollupCandidates(inCandidates, sortFields, groupFields, addBuddies) := FUNCTIONMACRO
    Grpd0 := GROUP(SORT(
      DISTRIBUTE(TABLE(inCandidates, {inCandidates #IF(addBuddies) , UNSIGNED2 Buddies := 0 #END}), HASH(did)),
      did, #EXPAND(sortFields), LOCAL),
      did, #EXPAND(groupFields), LOCAL);
    Grpd0 Tr0(Grpd0 le, Grpd0 ri) := TRANSFORM
      SELF.Buddies := le.Buddies + ri.Buddies + 1;
      SELF := le;
    END;
    RETURN UNGROUP(ROLLUP(Grpd0,TRUE,Tr0(LEFT,RIGHT)));// Only one copy of each record
  ENDMACRO;
  SHARED fieldList := 'pflag1,pflag2,pflag3,src,dt_first_seen,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,dt_nonglb_last_seen,rec_type,phone,ssn,dob,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,tnt,valid_ssn,jflag1,jflag2,jflag3,rawaid,dodgy_tracking,address_ind,name_ind,persistent_record_id';
  GrpdRoll := MAC_RollupCandidates(thin_table, fieldList, fieldList, TRUE);
SHARED h0 := GrpdRoll;// Only one copy of each record

EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT311.UIDType did1;
  SALT311.UIDType did2;
  SALT311.UIDType rid1 := 0;
  SALT311.UIDType rid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 pflag1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN pflag1_isnull := (h0.pflag1  IN SET(s.nulls_pflag1,pflag1) OR h0.pflag1 = (TYPEOF(h0.pflag1))''); // Simplify later processing 
  INTEGER2 pflag2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN pflag2_isnull := (h0.pflag2  IN SET(s.nulls_pflag2,pflag2) OR h0.pflag2 = (TYPEOF(h0.pflag2))''); // Simplify later processing 
  INTEGER2 pflag3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN pflag3_isnull := (h0.pflag3  IN SET(s.nulls_pflag3,pflag3) OR h0.pflag3 = (TYPEOF(h0.pflag3))''); // Simplify later processing 
  INTEGER2 src_weight100 := 0; // Contains 100x the specificity
  BOOLEAN src_isnull := (h0.src  IN SET(s.nulls_src,src) OR h0.src = (TYPEOF(h0.src))''); // Simplify later processing 
  INTEGER2 dt_first_seen_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_first_seen_isnull := (h0.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR h0.dt_first_seen = (TYPEOF(h0.dt_first_seen))''); // Simplify later processing 
  INTEGER2 dt_last_seen_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_last_seen_isnull := (h0.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR h0.dt_last_seen = (TYPEOF(h0.dt_last_seen))''); // Simplify later processing 
  INTEGER2 dt_vendor_last_reported_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_vendor_last_reported_isnull := (h0.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR h0.dt_vendor_last_reported = (TYPEOF(h0.dt_vendor_last_reported))''); // Simplify later processing 
  INTEGER2 dt_vendor_first_reported_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_vendor_first_reported_isnull := (h0.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR h0.dt_vendor_first_reported = (TYPEOF(h0.dt_vendor_first_reported))''); // Simplify later processing 
  INTEGER2 dt_nonglb_last_seen_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dt_nonglb_last_seen_isnull := (h0.dt_nonglb_last_seen  IN SET(s.nulls_dt_nonglb_last_seen,dt_nonglb_last_seen) OR h0.dt_nonglb_last_seen = (TYPEOF(h0.dt_nonglb_last_seen))''); // Simplify later processing 
  INTEGER2 rec_type_weight100 := 0; // Contains 100x the specificity
  BOOLEAN rec_type_isnull := (h0.rec_type  IN SET(s.nulls_rec_type,rec_type) OR h0.rec_type = (TYPEOF(h0.rec_type))''); // Simplify later processing 
  INTEGER2 phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN phone_isnull := (h0.phone  IN SET(s.nulls_phone,phone) OR h0.phone = (TYPEOF(h0.phone))''); // Simplify later processing 
  UNSIGNED phone_cnt := 0; // Number of instances with this particular field value
  UNSIGNED phone_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ssn_isnull := (h0.ssn  IN SET(s.nulls_ssn,ssn) OR h0.ssn = (TYPEOF(h0.ssn))''); // Simplify later processing 
  INTEGER2 dob_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dob_isnull := (h0.dob  IN SET(s.nulls_dob,dob) OR h0.dob = (TYPEOF(h0.dob))''); // Simplify later processing 
  INTEGER2 title_weight100 := 0; // Contains 100x the specificity
  BOOLEAN title_isnull := (h0.title  IN SET(s.nulls_title,title) OR h0.title = (TYPEOF(h0.title))''); // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 fname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := (h0.fname  IN SET(s.nulls_fname,fname) OR h0.fname = (TYPEOF(h0.fname))''); // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 mname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := (h0.mname  IN SET(s.nulls_mname,mname) OR h0.mname = (TYPEOF(h0.mname))''); // Simplify later processing 
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := (h0.lname  IN SET(s.nulls_lname,lname) OR h0.lname = (TYPEOF(h0.lname))''); // Simplify later processing 
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := (h0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR h0.name_suffix = (TYPEOF(h0.name_suffix))''); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))''); // Simplify later processing 
  INTEGER2 predir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN predir_isnull := (h0.predir  IN SET(s.nulls_predir,predir) OR h0.predir = (TYPEOF(h0.predir))''); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))''); // Simplify later processing 
  INTEGER2 suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN suffix_isnull := (h0.suffix  IN SET(s.nulls_suffix,suffix) OR h0.suffix = (TYPEOF(h0.suffix))''); // Simplify later processing 
  INTEGER2 postdir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN postdir_isnull := (h0.postdir  IN SET(s.nulls_postdir,postdir) OR h0.postdir = (TYPEOF(h0.postdir))''); // Simplify later processing 
  INTEGER2 unit_desig_weight100 := 0; // Contains 100x the specificity
  BOOLEAN unit_desig_isnull := (h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR h0.unit_desig = (TYPEOF(h0.unit_desig))''); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))''); // Simplify later processing 
  INTEGER2 city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN city_name_isnull := (h0.city_name  IN SET(s.nulls_city_name,city_name) OR h0.city_name = (TYPEOF(h0.city_name))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  INTEGER2 zip4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip4_isnull := (h0.zip4  IN SET(s.nulls_zip4,zip4) OR h0.zip4 = (TYPEOF(h0.zip4))''); // Simplify later processing 
  INTEGER2 tnt_weight100 := 0; // Contains 100x the specificity
  BOOLEAN tnt_isnull := (h0.tnt  IN SET(s.nulls_tnt,tnt) OR h0.tnt = (TYPEOF(h0.tnt))''); // Simplify later processing 
  INTEGER2 valid_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN valid_ssn_isnull := (h0.valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR h0.valid_ssn = (TYPEOF(h0.valid_ssn))''); // Simplify later processing 
  INTEGER2 jflag1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN jflag1_isnull := (h0.jflag1  IN SET(s.nulls_jflag1,jflag1) OR h0.jflag1 = (TYPEOF(h0.jflag1))''); // Simplify later processing 
  INTEGER2 jflag2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN jflag2_isnull := (h0.jflag2  IN SET(s.nulls_jflag2,jflag2) OR h0.jflag2 = (TYPEOF(h0.jflag2))''); // Simplify later processing 
  INTEGER2 jflag3_weight100 := 0; // Contains 100x the specificity
  BOOLEAN jflag3_isnull := (h0.jflag3  IN SET(s.nulls_jflag3,jflag3) OR h0.jflag3 = (TYPEOF(h0.jflag3))''); // Simplify later processing 
  INTEGER2 rawaid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN rawaid_isnull := (h0.rawaid  IN SET(s.nulls_rawaid,rawaid) OR h0.rawaid = (TYPEOF(h0.rawaid))''); // Simplify later processing 
  INTEGER2 dodgy_tracking_weight100 := 0; // Contains 100x the specificity
  BOOLEAN dodgy_tracking_isnull := (h0.dodgy_tracking  IN SET(s.nulls_dodgy_tracking,dodgy_tracking) OR h0.dodgy_tracking = (TYPEOF(h0.dodgy_tracking))''); // Simplify later processing 
  INTEGER2 address_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN address_ind_isnull := (h0.address_ind  IN SET(s.nulls_address_ind,address_ind) OR h0.address_ind = (TYPEOF(h0.address_ind))''); // Simplify later processing 
  INTEGER2 name_ind_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_ind_isnull := (h0.name_ind  IN SET(s.nulls_name_ind,name_ind) OR h0.name_ind = (TYPEOF(h0.name_ind))''); // Simplify later processing 
  INTEGER2 persistent_record_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN persistent_record_id_isnull := (h0.persistent_record_id  IN SET(s.nulls_persistent_record_id,persistent_record_id) OR h0.persistent_record_id = (TYPEOF(h0.persistent_record_id))''); // Simplify later processing 
  INTEGER2 lastname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lastname_isnull := ((h0.lname  IN SET(s.nulls_lname,lname) OR h0.lname = (TYPEOF(h0.lname))'') AND (h0.name_ind  IN SET(s.nulls_name_ind,name_ind) OR h0.name_ind = (TYPEOF(h0.name_ind))'')); // Simplify later processing 
  INTEGER2 ssnum_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ssnum_isnull := ((h0.ssn  IN SET(s.nulls_ssn,ssn) OR h0.ssn = (TYPEOF(h0.ssn))'') AND (h0.valid_ssn  IN SET(s.nulls_valid_ssn,valid_ssn) OR h0.valid_ssn = (TYPEOF(h0.valid_ssn))'')); // Simplify later processing 
  INTEGER2 address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN address_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))'') AND (h0.predir  IN SET(s.nulls_predir,predir) OR h0.predir = (TYPEOF(h0.predir))'') AND (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))'') AND (h0.suffix  IN SET(s.nulls_suffix,suffix) OR h0.suffix = (TYPEOF(h0.suffix))'') AND (h0.postdir  IN SET(s.nulls_postdir,postdir) OR h0.postdir = (TYPEOF(h0.postdir))'') AND (h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR h0.unit_desig = (TYPEOF(h0.unit_desig))'') AND (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))'') AND (h0.city_name  IN SET(s.nulls_city_name,city_name) OR h0.city_name = (TYPEOF(h0.city_name))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))'') AND (h0.zip4  IN SET(s.nulls_zip4,zip4) OR h0.zip4 = (TYPEOF(h0.zip4))'') AND (h0.tnt  IN SET(s.nulls_tnt,tnt) OR h0.tnt = (TYPEOF(h0.tnt))'') AND (h0.rawaid  IN SET(s.nulls_rawaid,rawaid) OR h0.rawaid = (TYPEOF(h0.rawaid))'') AND (h0.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen) OR h0.dt_first_seen = (TYPEOF(h0.dt_first_seen))'') AND (h0.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen) OR h0.dt_last_seen = (TYPEOF(h0.dt_last_seen))'') AND (h0.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported) OR h0.dt_vendor_first_reported = (TYPEOF(h0.dt_vendor_first_reported))'') AND (h0.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported) OR h0.dt_vendor_last_reported = (TYPEOF(h0.dt_vendor_last_reported))'')); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one

//Would also create auto-id fields here

layout_candidates add_lastname(layout_candidates le,Specificities(ih).lastname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lastname_weight100 := MAP (le.lastname_isnull => 0, patch_default and ri.field_specificity=0 => s.lastname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j41 := JOIN(h1,PULL(Specificities(ih).lastname_values_persisted),LEFT.lastname=RIGHT.lastname,add_lastname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_persistent_record_id(layout_candidates le,Specificities(ih).persistent_record_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.persistent_record_id_weight100 := MAP (le.persistent_record_id_isnull => 0, patch_default and ri.field_specificity=0 => s.persistent_record_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j40 := JOIN(j41,PULL(Specificities(ih).persistent_record_id_values_persisted),LEFT.persistent_record_id=RIGHT.persistent_record_id,add_persistent_record_id(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_name_ind(layout_candidates le,Specificities(ih).name_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_ind_weight100 := MAP (le.name_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.name_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j39 := JOIN(j40,PULL(Specificities(ih).name_ind_values_persisted),LEFT.name_ind=RIGHT.name_ind,add_name_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_address_ind(layout_candidates le,Specificities(ih).address_ind_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.address_ind_weight100 := MAP (le.address_ind_isnull => 0, patch_default and ri.field_specificity=0 => s.address_ind_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j38 := JOIN(j39,PULL(Specificities(ih).address_ind_values_persisted),LEFT.address_ind=RIGHT.address_ind,add_address_ind(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j37 := JOIN(j38,PULL(Specificities(ih).lname_values_persisted),LEFT.lname=RIGHT.lname,add_lname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.mname_initial_char_weight100 := MAP (le.mname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j36 := JOIN(j37,PULL(Specificities(ih).mname_values_persisted),LEFT.mname=RIGHT.mname,add_mname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.fname_initial_char_weight100 := MAP (le.fname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j35 := JOIN(j36,PULL(Specificities(ih).fname_values_persisted),LEFT.fname=RIGHT.fname,add_fname(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_title(layout_candidates le,Specificities(ih).title_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.title_weight100 := MAP (le.title_isnull => 0, patch_default and ri.field_specificity=0 => s.title_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j34 := JOIN(j35,PULL(Specificities(ih).title_values_persisted),LEFT.title=RIGHT.title,add_title(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_pflag3(layout_candidates le,Specificities(ih).pflag3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.pflag3_weight100 := MAP (le.pflag3_isnull => 0, patch_default and ri.field_specificity=0 => s.pflag3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j33 := JOIN(j34,PULL(Specificities(ih).pflag3_values_persisted),LEFT.pflag3=RIGHT.pflag3,add_pflag3(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_rec_type(layout_candidates le,Specificities(ih).rec_type_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.rec_type_weight100 := MAP (le.rec_type_isnull => 0, patch_default and ri.field_specificity=0 => s.rec_type_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j33,s.nulls_rec_type,Specificities(ih).rec_type_values_persisted,rec_type,rec_type_weight100,add_rec_type,j32);
layout_candidates add_dob(layout_candidates le,Specificities(ih).dob_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dob_weight100 := MAP (le.dob_isnull => 0, patch_default and ri.field_specificity=0 => s.dob_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j32,s.nulls_dob,Specificities(ih).dob_values_persisted,dob,dob_weight100,add_dob,j31);
layout_candidates add_ssn(layout_candidates le,Specificities(ih).ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ssn_weight100 := MAP (le.ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j31,s.nulls_ssn,Specificities(ih).ssn_values_persisted,ssn,ssn_weight100,add_ssn,j30);
layout_candidates add_phone(layout_candidates le,Specificities(ih).phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.phone_cnt := ri.cnt;
  SELF.phone_e1_cnt := ri.e1_cnt;
  SELF.phone_weight100 := MAP (le.phone_isnull => 0, patch_default and ri.field_specificity=0 => s.phone_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j30,s.nulls_phone,Specificities(ih).phone_values_persisted,phone,phone_weight100,add_phone,j29);
layout_candidates add_valid_ssn(layout_candidates le,Specificities(ih).valid_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.valid_ssn_weight100 := MAP (le.valid_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.valid_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j29,s.nulls_valid_ssn,Specificities(ih).valid_ssn_values_persisted,valid_ssn,valid_ssn_weight100,add_valid_ssn,j28);
layout_candidates add_jflag1(layout_candidates le,Specificities(ih).jflag1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.jflag1_weight100 := MAP (le.jflag1_isnull => 0, patch_default and ri.field_specificity=0 => s.jflag1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j28,s.nulls_jflag1,Specificities(ih).jflag1_values_persisted,jflag1,jflag1_weight100,add_jflag1,j27);
layout_candidates add_jflag3(layout_candidates le,Specificities(ih).jflag3_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.jflag3_weight100 := MAP (le.jflag3_isnull => 0, patch_default and ri.field_specificity=0 => s.jflag3_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j27,s.nulls_jflag3,Specificities(ih).jflag3_values_persisted,jflag3,jflag3_weight100,add_jflag3,j26);
layout_candidates add_unit_desig(layout_candidates le,Specificities(ih).unit_desig_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.unit_desig_weight100 := MAP (le.unit_desig_isnull => 0, patch_default and ri.field_specificity=0 => s.unit_desig_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j26,s.nulls_unit_desig,Specificities(ih).unit_desig_values_persisted,unit_desig,unit_desig_weight100,add_unit_desig,j25);
layout_candidates add_suffix(layout_candidates le,Specificities(ih).suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.suffix_weight100 := MAP (le.suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j25,s.nulls_suffix,Specificities(ih).suffix_values_persisted,suffix,suffix_weight100,add_suffix,j24);
layout_candidates add_jflag2(layout_candidates le,Specificities(ih).jflag2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.jflag2_weight100 := MAP (le.jflag2_isnull => 0, patch_default and ri.field_specificity=0 => s.jflag2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j24,s.nulls_jflag2,Specificities(ih).jflag2_values_persisted,jflag2,jflag2_weight100,add_jflag2,j23);
layout_candidates add_predir(layout_candidates le,Specificities(ih).predir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.predir_weight100 := MAP (le.predir_isnull => 0, patch_default and ri.field_specificity=0 => s.predir_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j23,s.nulls_predir,Specificities(ih).predir_values_persisted,predir,predir_weight100,add_predir,j22);
layout_candidates add_pflag2(layout_candidates le,Specificities(ih).pflag2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.pflag2_weight100 := MAP (le.pflag2_isnull => 0, patch_default and ri.field_specificity=0 => s.pflag2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j22,s.nulls_pflag2,Specificities(ih).pflag2_values_persisted,pflag2,pflag2_weight100,add_pflag2,j21);
layout_candidates add_pflag1(layout_candidates le,Specificities(ih).pflag1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.pflag1_weight100 := MAP (le.pflag1_isnull => 0, patch_default and ri.field_specificity=0 => s.pflag1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j21,s.nulls_pflag1,Specificities(ih).pflag1_values_persisted,pflag1,pflag1_weight100,add_pflag1,j20);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j20,s.nulls_st,Specificities(ih).st_values_persisted,st,st_weight100,add_st,j19);
layout_candidates add_dt_vendor_last_reported(layout_candidates le,Specificities(ih).dt_vendor_last_reported_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_last_reported_weight100 := MAP (le.dt_vendor_last_reported_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_last_reported_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j19,s.nulls_dt_vendor_last_reported,Specificities(ih).dt_vendor_last_reported_values_persisted,dt_vendor_last_reported,dt_vendor_last_reported_weight100,add_dt_vendor_last_reported,j18);
layout_candidates add_dt_vendor_first_reported(layout_candidates le,Specificities(ih).dt_vendor_first_reported_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_vendor_first_reported_weight100 := MAP (le.dt_vendor_first_reported_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_first_reported_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j18,s.nulls_dt_vendor_first_reported,Specificities(ih).dt_vendor_first_reported_values_persisted,dt_vendor_first_reported,dt_vendor_first_reported_weight100,add_dt_vendor_first_reported,j17);
layout_candidates add_dodgy_tracking(layout_candidates le,Specificities(ih).dodgy_tracking_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dodgy_tracking_weight100 := MAP (le.dodgy_tracking_isnull => 0, patch_default and ri.field_specificity=0 => s.dodgy_tracking_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j17,s.nulls_dodgy_tracking,Specificities(ih).dodgy_tracking_values_persisted,dodgy_tracking,dodgy_tracking_weight100,add_dodgy_tracking,j16);
layout_candidates add_ssnum(layout_candidates le,Specificities(ih).ssnum_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ssnum_weight100 := MAP (le.ssnum_isnull => 0, patch_default and ri.field_specificity=0 => s.ssnum_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j16,s.nulls_ssnum,Specificities(ih).ssnum_values_persisted,ssnum,ssnum_weight100,add_ssnum,j15);
layout_candidates add_dt_last_seen(layout_candidates le,Specificities(ih).dt_last_seen_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_last_seen_weight100 := MAP (le.dt_last_seen_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_last_seen_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j15,s.nulls_dt_last_seen,Specificities(ih).dt_last_seen_values_persisted,dt_last_seen,dt_last_seen_weight100,add_dt_last_seen,j14);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.postdir_weight100 := MAP (le.postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.postdir_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j14,s.nulls_postdir,Specificities(ih).postdir_values_persisted,postdir,postdir_weight100,add_postdir,j13);
layout_candidates add_dt_first_seen(layout_candidates le,Specificities(ih).dt_first_seen_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_first_seen_weight100 := MAP (le.dt_first_seen_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_first_seen_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j13,s.nulls_dt_first_seen,Specificities(ih).dt_first_seen_values_persisted,dt_first_seen,dt_first_seen_weight100,add_dt_first_seen,j12);
layout_candidates add_dt_nonglb_last_seen(layout_candidates le,Specificities(ih).dt_nonglb_last_seen_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.dt_nonglb_last_seen_weight100 := MAP (le.dt_nonglb_last_seen_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_nonglb_last_seen_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j12,s.nulls_dt_nonglb_last_seen,Specificities(ih).dt_nonglb_last_seen_values_persisted,dt_nonglb_last_seen,dt_nonglb_last_seen_weight100,add_dt_nonglb_last_seen,j11);
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j11,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_name_suffix,j10);
layout_candidates add_tnt(layout_candidates le,Specificities(ih).tnt_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.tnt_weight100 := MAP (le.tnt_isnull => 0, patch_default and ri.field_specificity=0 => s.tnt_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j10,s.nulls_tnt,Specificities(ih).tnt_values_persisted,tnt,tnt_weight100,add_tnt,j9);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j9,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j8);
layout_candidates add_city_name(layout_candidates le,Specificities(ih).city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.city_name_weight100 := MAP (le.city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j8,s.nulls_city_name,Specificities(ih).city_name_values_persisted,city_name,city_name_weight100,add_city_name,j7);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j7,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j6);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip4_weight100 := MAP (le.zip4_isnull => 0, patch_default and ri.field_specificity=0 => s.zip4_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j6,s.nulls_zip4,Specificities(ih).zip4_values_persisted,zip4,zip4_weight100,add_zip4,j5);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j5,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j4);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j4,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j3);
layout_candidates add_rawaid(layout_candidates le,Specificities(ih).rawaid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.rawaid_weight100 := MAP (le.rawaid_isnull => 0, patch_default and ri.field_specificity=0 => s.rawaid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j3,s.nulls_rawaid,Specificities(ih).rawaid_values_persisted,rawaid,rawaid_weight100,add_rawaid,j2);
layout_candidates add_address(layout_candidates le,Specificities(ih).address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.address_weight100 := MAP (le.address_isnull => 0, patch_default and ri.field_specificity=0 => s.address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j2,s.nulls_address,Specificities(ih).address_values_persisted,address,address_weight100,add_address,j1);
layout_candidates add_src(layout_candidates le,Specificities(ih).src_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.src_weight100 := MAP (le.src_isnull => 0, patch_default and ri.field_specificity=0 => s.src_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j1,s.nulls_src,Specificities(ih).src_values_persisted,src,src_weight100,add_src,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0, HASH(did)) : PERSIST('~temp::did::Watchdog_best::mc',EXPIRE(Watchdog_best.Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.src_weight100 + Annotated.address_weight100 + Annotated.name_suffix_weight100 + Annotated.dt_nonglb_last_seen_weight100 + Annotated.ssnum_weight100 + Annotated.dodgy_tracking_weight100 + Annotated.pflag1_weight100 + Annotated.pflag2_weight100 + Annotated.jflag2_weight100 + Annotated.jflag3_weight100 + Annotated.jflag1_weight100 + Annotated.phone_weight100 + Annotated.dob_weight100 + Annotated.rec_type_weight100 + Annotated.pflag3_weight100 + Annotated.title_weight100 + Annotated.fname_weight100 + Annotated.mname_weight100 + Annotated.address_ind_weight100 + Annotated.persistent_record_id_weight100 + Annotated.lastname_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
