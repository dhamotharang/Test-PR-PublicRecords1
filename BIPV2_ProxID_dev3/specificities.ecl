IMPORT ut,SALT26;
IMPORT BIPV2,SALT26; // HACK
EXPORT specificities(DATASET(layout_DOT_Base) h) := MODULE
 
EXPORT input_layout := RECORD // project out required fields
  SALT26.UIDType Proxid := h.Proxid; // using existing id field
  h.rcid;//RIDfield 
  h.company_name;
  h.cnp_name;
  h.cnp_hasnumber;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.cnp_translated;
  h.cnp_classid;
  h.company_fein;
  h.company_foreign_domestic;
  h.company_bdid;
  h.company_phone;
  h.iscorp;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip;
  unsigned4 company_csz := 0; // Place holder filled in by project
  unsigned4 company_addr1 := 0; // Place holder filled in by project
  unsigned4 company_address := 0; // Place holder filled in by project
  h.dt_first_seen;
  h.dt_last_seen;
  h.active_duns_number;
  h.active_enterprise_number;
  h.hist_enterprise_number;
  h.hist_duns_number;
  h.ebr_file_number;
  h.domestic_corp_key;
  h.AK_foreign_corp_key;
  h.AL_foreign_corp_key;
  h.AR_foreign_corp_key;
  h.AZ_foreign_corp_key;
  h.CA_foreign_corp_key;
  h.CO_foreign_corp_key;
  h.CT_foreign_corp_key;
  h.DC_foreign_corp_key;
  h.DE_foreign_corp_key;
  h.FL_foreign_corp_key;
  h.GA_foreign_corp_key;
  h.HI_foreign_corp_key;
  h.IA_foreign_corp_key;
  h.ID_foreign_corp_key;
  h.IL_foreign_corp_key;
  h.IN_foreign_corp_key;
  h.KS_foreign_corp_key;
  h.KY_foreign_corp_key;
  h.LA_foreign_corp_key;
  h.MA_foreign_corp_key;
  h.MD_foreign_corp_key;
  h.ME_foreign_corp_key;
  h.MI_foreign_corp_key;
  h.MN_foreign_corp_key;
  h.MO_foreign_corp_key;
  h.MS_foreign_corp_key;
  h.MT_foreign_corp_key;
  h.NC_foreign_corp_key;
  h.ND_foreign_corp_key;
  h.NE_foreign_corp_key;
  h.NH_foreign_corp_key;
  h.NJ_foreign_corp_key;
  h.NM_foreign_corp_key;
  h.NV_foreign_corp_key;
  h.NY_foreign_corp_key;
  h.OH_foreign_corp_key;
  h.OK_foreign_corp_key;
  h.OR_foreign_corp_key;
  h.PA_foreign_corp_key;
  h.PR_foreign_corp_key;
  h.RI_foreign_corp_key;
  h.SC_foreign_corp_key;
  h.SD_foreign_corp_key;
  h.TN_foreign_corp_key;
  h.TX_foreign_corp_key;
  h.UT_foreign_corp_key;
  h.VA_foreign_corp_key;
  h.VI_foreign_corp_key;
  h.VT_foreign_corp_key;
  h.WA_foreign_corp_key;
  h.WI_foreign_corp_key;
  h.WV_foreign_corp_key;
  h.WY_foreign_corp_key;
// HACK - added next line
  STRING2 SALT_Partition := BIPV2.Mod_Sources.src2partition(h.source); // Computed & Carry partition information
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h,r),HASH(Proxid)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF.company_csz := HASH32((SALT26.StrType)le.v_city_name,(SALT26.StrType)le.st,(SALT26.StrType)le.zip); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := HASH32((SALT26.StrType)le.prim_range,(SALT26.StrType)le.prim_name,(SALT26.StrType)le.sec_range); // Combine child fields into 1 for specificity counting
  SELF.company_address := HASH32((SALT26.StrType)SELF.company_addr1,(SALT26.StrType)SELF.company_csz); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
// SHARED h0 := PROJECT(h01,do_computes(LEFT));
// HACK - commented previous line, added next three lines
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 := SALT26.MAC_Partition_Stars(h02,SALT_Partition,proxid); // Note b-list inside a-list clusters
EXPORT PartitionCounts := TABLE(h0,{SALT_Partition,Cnt := COUNT(GROUP)},SALT_Partition,FEW);
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0  : PERSIST('temp::Proxid::BIPV2_ProxID_dev3::Specificities_Cache');
//We have Proxid specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.Proxid;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,Proxid,LOCAL)  : PERSIST('temp::Proxid::BIPV2_ProxID_dev3::Cluster_Sizes');
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT cnp_nameValuesKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::cnp_name';
 
SHARED  cnp_name_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,cnp_name) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_cnp_name'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(cnp_name_deduped,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT26.mac_edit_distance_pairs(specs_added,cnp_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
SHARED cnp_name_sa := distance_computed; // Hope over shared/export below
// This field is a word bag; so create specifcities for the words too
  SALT26.MAC_Field_Variants_WordBag(cnp_name_deduped,Proxid,cnp_name,expanded)// expand out all variants of wordbag
  SALT26.Mac_Field_Count_UID(expanded,cnp_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  SALT26.MAC_Field_Specificities(counted,wb_specs_added) // Compute specificity for each value
SHARED cnp_name_ad := wb_specs_added; // Hop over export
 
EXPORT cnp_name_values_key := INDEX(cnp_name_ad,{cnp_name},{cnp_name_ad},cnp_nameValuesKeyName);
  SALT26.mac_wordbag_addweights(cnp_name_sa,cnp_name,cnp_name_ad,p);
 
EXPORT cnp_name_values_index := INDEX(p,{cnp_name},{p},cnp_nameValuesKeyName);
EXPORT cnp_name_values_persisted := cnp_name_values_index;
EXPORT cnp_name_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_name_ChildRec); // Automated null spotting not applicable
SALT26.MAC_Field_Bfoul(cnp_name_deduped,cnp_name,Proxid,cnp_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_name_switch := bf;
EXPORT cnp_name_max := MAX(cnp_name_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(cnp_name_values_persisted,cnp_name,cnp_name_nulls,ol) // Compute column level specificity
EXPORT cnp_name_specificity := ol;
 
EXPORT cnp_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::cnp_number';
 
SHARED  cnp_number_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,cnp_number) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_cnp_number'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(cnp_number_deduped,cnp_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT cnp_number_values_index := INDEX(specs_added,{cnp_number},{specs_added},cnp_numberValuesIndexKeyName);
EXPORT cnp_number_values_persisted := cnp_number_values_index;
SALT26.MAC_Field_Nulls(cnp_number_values_persisted,Layout_Specificities.cnp_number_ChildRec,nv) // Use automated NULL spotting
EXPORT cnp_number_nulls := nv;
SALT26.MAC_Field_Bfoul(cnp_number_deduped,cnp_number,Proxid,cnp_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_number_switch := bf;
EXPORT cnp_number_max := MAX(cnp_number_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(cnp_number_values_persisted,cnp_number,cnp_number_nulls,ol) // Compute column level specificity
EXPORT cnp_number_specificity := ol;
 
EXPORT cnp_btypeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::cnp_btype';
 
SHARED  cnp_btype_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,cnp_btype) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_cnp_btype'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(cnp_btype_deduped,cnp_btype,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT cnp_btype_values_index := INDEX(specs_added,{cnp_btype},{specs_added},cnp_btypeValuesIndexKeyName);
EXPORT cnp_btype_values_persisted := cnp_btype_values_index;
EXPORT cnp_btype_nulls := DATASET([{'',0,0}],Layout_Specificities.cnp_btype_ChildRec); // Automated null spotting not applicable
SALT26.MAC_Field_Bfoul(cnp_btype_deduped,cnp_btype,Proxid,cnp_btype_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cnp_btype_switch := bf;
EXPORT cnp_btype_max := MAX(cnp_btype_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(cnp_btype_values_persisted,cnp_btype,cnp_btype_nulls,ol) // Compute column level specificity
EXPORT cnp_btype_specificity := ol;
 
EXPORT company_feinValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::company_fein';
 
SHARED  company_fein_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,company_fein) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_company_fein'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(company_fein_deduped,company_fein,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT26.mac_edit_distance_pairs(specs_added,company_fein,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
 
EXPORT company_fein_values_index := INDEX(distance_computed,{company_fein},{distance_computed},company_feinValuesIndexKeyName);
EXPORT company_fein_values_persisted := company_fein_values_index;
SALT26.MAC_Field_Nulls(company_fein_values_persisted,Layout_Specificities.company_fein_ChildRec,nv) // Use automated NULL spotting
EXPORT company_fein_nulls := nv;
SALT26.MAC_Field_Bfoul(company_fein_deduped,company_fein,Proxid,company_fein_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_fein_switch := bf;
EXPORT company_fein_max := MAX(company_fein_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(company_fein_values_persisted,company_fein,company_fein_nulls,ol) // Compute column level specificity
EXPORT company_fein_specificity := ol;
 
EXPORT company_phoneValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::company_phone';
 
SHARED  company_phone_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,company_phone) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_company_phone'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(company_phone_deduped,company_phone,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_phone_values_index := INDEX(specs_added,{company_phone},{specs_added},company_phoneValuesIndexKeyName);
EXPORT company_phone_values_persisted := company_phone_values_index;
SALT26.MAC_Field_Nulls(company_phone_values_persisted,Layout_Specificities.company_phone_ChildRec,nv) // Use automated NULL spotting
EXPORT company_phone_nulls := nv;
SALT26.MAC_Field_Bfoul(company_phone_deduped,company_phone,Proxid,company_phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_phone_switch := bf;
EXPORT company_phone_max := MAX(company_phone_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(company_phone_values_persisted,company_phone,company_phone_nulls,ol) // Compute column level specificity
EXPORT company_phone_specificity := ol;
 
EXPORT iscorpValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::iscorp';
 
SHARED  iscorp_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,iscorp) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_iscorp'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(iscorp_deduped,iscorp,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT iscorp_values_index := INDEX(specs_added,{iscorp},{specs_added},iscorpValuesIndexKeyName);
EXPORT iscorp_values_persisted := iscorp_values_index;
EXPORT iscorp_nulls := DATASET([{'',0,0}],Layout_Specificities.iscorp_ChildRec); // Automated null spotting not applicable
SALT26.MAC_Field_Bfoul(iscorp_deduped,iscorp,Proxid,iscorp_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT iscorp_switch := bf;
EXPORT iscorp_max := MAX(iscorp_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(iscorp_values_persisted,iscorp,iscorp_nulls,ol) // Compute column level specificity
EXPORT iscorp_specificity := ol;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::prim_range';
 
SHARED  prim_range_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,prim_range) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_prim_range'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(prim_range_deduped,prim_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT prim_range_values_index := INDEX(specs_added,{prim_range},{specs_added},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT26.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT26.MAC_Field_Bfoul(prim_range_deduped,prim_range,Proxid,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::prim_name';
 
SHARED  prim_name_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,prim_name) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_prim_name'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(prim_name_deduped,prim_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT prim_name_values_index := INDEX(specs_added,{prim_name},{specs_added},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT26.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT26.MAC_Field_Bfoul(prim_name_deduped,prim_name,Proxid,prim_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::sec_range';
 
SHARED  sec_range_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,sec_range) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_sec_range'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(sec_range_deduped,sec_range,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT sec_range_values_index := INDEX(specs_added,{sec_range},{specs_added},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT26.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT26.MAC_Field_Bfoul(sec_range_deduped,sec_range,Proxid,sec_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::v_city_name';
 
SHARED  v_city_name_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,v_city_name) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_v_city_name'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT v_city_name_values_index := INDEX(specs_added,{v_city_name},{specs_added},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT26.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT26.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,Proxid,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::st';
 
SHARED  st_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,st) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_st'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(st_deduped,st,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT st_values_index := INDEX(specs_added,{st},{specs_added},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
SALT26.MAC_Field_Nulls(st_values_persisted,Layout_Specificities.st_ChildRec,nv) // Use automated NULL spotting
EXPORT st_nulls := nv;
SALT26.MAC_Field_Bfoul(st_deduped,st,Proxid,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zipValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::zip';
 
SHARED  zip_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,zip) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_zip'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(zip_deduped,zip,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT zip_values_index := INDEX(specs_added,{zip},{specs_added},zipValuesIndexKeyName);
EXPORT zip_values_persisted := zip_values_index;
SALT26.MAC_Field_Nulls(zip_values_persisted,Layout_Specificities.zip_ChildRec,nv) // Use automated NULL spotting
EXPORT zip_nulls := nv;
SALT26.MAC_Field_Bfoul(zip_deduped,zip,Proxid,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip_switch := bf;
EXPORT zip_max := MAX(zip_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
EXPORT zip_specificity := ol;
 
EXPORT company_cszValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::company_csz';
 
SHARED  company_csz_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,company_csz) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_company_csz'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(company_csz_deduped,company_csz,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_csz_values_index := INDEX(specs_added,{company_csz},{specs_added},company_cszValuesIndexKeyName);
EXPORT company_csz_values_persisted := company_csz_values_index;
SALT26.MAC_Field_Nulls(company_csz_values_persisted,Layout_Specificities.company_csz_ChildRec,nv) // Use automated NULL spotting
EXPORT company_csz_nulls := nv;
SALT26.MAC_Field_Bfoul(company_csz_deduped,company_csz,Proxid,company_csz_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_csz_switch := bf;
EXPORT company_csz_max := MAX(company_csz_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(company_csz_values_persisted,company_csz,company_csz_nulls,ol) // Compute column level specificity
EXPORT company_csz_specificity := ol;
 
EXPORT company_addr1ValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::company_addr1';
 
SHARED  company_addr1_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,company_addr1) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_company_addr1'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(company_addr1_deduped,company_addr1,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_addr1_values_index := INDEX(specs_added,{company_addr1},{specs_added},company_addr1ValuesIndexKeyName);
EXPORT company_addr1_values_persisted := company_addr1_values_index;
SALT26.MAC_Field_Nulls(company_addr1_values_persisted,Layout_Specificities.company_addr1_ChildRec,nv) // Use automated NULL spotting
EXPORT company_addr1_nulls := nv;
SALT26.MAC_Field_Bfoul(company_addr1_deduped,company_addr1,Proxid,company_addr1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_addr1_switch := bf;
EXPORT company_addr1_max := MAX(company_addr1_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(company_addr1_values_persisted,company_addr1,company_addr1_nulls,ol) // Compute column level specificity
EXPORT company_addr1_specificity := ol;
 
EXPORT company_addressValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::company_address';
 
SHARED  company_address_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,company_address) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_company_address'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(company_address_deduped,company_address,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT company_address_values_index := INDEX(specs_added,{company_address},{specs_added},company_addressValuesIndexKeyName);
EXPORT company_address_values_persisted := company_address_values_index;
SALT26.MAC_Field_Nulls(company_address_values_persisted,Layout_Specificities.company_address_ChildRec,nv) // Use automated NULL spotting
EXPORT company_address_nulls := nv;
SALT26.MAC_Field_Bfoul(company_address_deduped,company_address,Proxid,company_address_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT company_address_switch := bf;
EXPORT company_address_max := MAX(company_address_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(company_address_values_persisted,company_address,company_address_nulls,ol) // Compute column level specificity
EXPORT company_address_specificity := ol;
 
EXPORT active_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::active_duns_number';
 
SHARED  active_duns_number_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,active_duns_number) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_active_duns_number'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(active_duns_number_deduped,active_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT active_duns_number_values_index := INDEX(specs_added,{active_duns_number},{specs_added},active_duns_numberValuesIndexKeyName);
EXPORT active_duns_number_values_persisted := active_duns_number_values_index;
SALT26.MAC_Field_Nulls(active_duns_number_values_persisted,Layout_Specificities.active_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_duns_number_nulls := nv;
SALT26.MAC_Field_Bfoul(active_duns_number_deduped,active_duns_number,Proxid,active_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_duns_number_switch := bf;
EXPORT active_duns_number_max := MAX(active_duns_number_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(active_duns_number_values_persisted,active_duns_number,active_duns_number_nulls,ol) // Compute column level specificity
EXPORT active_duns_number_specificity := ol;
 
EXPORT active_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::active_enterprise_number';
 
SHARED  active_enterprise_number_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,active_enterprise_number) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_active_enterprise_number'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(active_enterprise_number_deduped,active_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT active_enterprise_number_values_index := INDEX(specs_added,{active_enterprise_number},{specs_added},active_enterprise_numberValuesIndexKeyName);
EXPORT active_enterprise_number_values_persisted := active_enterprise_number_values_index;
SALT26.MAC_Field_Nulls(active_enterprise_number_values_persisted,Layout_Specificities.active_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT active_enterprise_number_nulls := nv;
SALT26.MAC_Field_Bfoul(active_enterprise_number_deduped,active_enterprise_number,Proxid,active_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT active_enterprise_number_switch := bf;
EXPORT active_enterprise_number_max := MAX(active_enterprise_number_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT active_enterprise_number_specificity := ol;
 
EXPORT hist_enterprise_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::hist_enterprise_number';
 
SHARED  hist_enterprise_number_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,hist_enterprise_number) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_hist_enterprise_number'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT hist_enterprise_number_values_index := INDEX(specs_added,{hist_enterprise_number},{specs_added},hist_enterprise_numberValuesIndexKeyName);
EXPORT hist_enterprise_number_values_persisted := hist_enterprise_number_values_index;
SALT26.MAC_Field_Nulls(hist_enterprise_number_values_persisted,Layout_Specificities.hist_enterprise_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_enterprise_number_nulls := nv;
SALT26.MAC_Field_Bfoul(hist_enterprise_number_deduped,hist_enterprise_number,Proxid,hist_enterprise_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_enterprise_number_switch := bf;
EXPORT hist_enterprise_number_max := MAX(hist_enterprise_number_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(hist_enterprise_number_values_persisted,hist_enterprise_number,hist_enterprise_number_nulls,ol) // Compute column level specificity
EXPORT hist_enterprise_number_specificity := ol;
 
EXPORT hist_duns_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::hist_duns_number';
 
SHARED  hist_duns_number_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,hist_duns_number) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_hist_duns_number'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(hist_duns_number_deduped,hist_duns_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT hist_duns_number_values_index := INDEX(specs_added,{hist_duns_number},{specs_added},hist_duns_numberValuesIndexKeyName);
EXPORT hist_duns_number_values_persisted := hist_duns_number_values_index;
SALT26.MAC_Field_Nulls(hist_duns_number_values_persisted,Layout_Specificities.hist_duns_number_ChildRec,nv) // Use automated NULL spotting
EXPORT hist_duns_number_nulls := nv;
SALT26.MAC_Field_Bfoul(hist_duns_number_deduped,hist_duns_number,Proxid,hist_duns_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT hist_duns_number_switch := bf;
EXPORT hist_duns_number_max := MAX(hist_duns_number_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(hist_duns_number_values_persisted,hist_duns_number,hist_duns_number_nulls,ol) // Compute column level specificity
EXPORT hist_duns_number_specificity := ol;
 
EXPORT ebr_file_numberValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::ebr_file_number';
 
SHARED  ebr_file_number_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,ebr_file_number) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_ebr_file_number'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(ebr_file_number_deduped,ebr_file_number,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT ebr_file_number_values_index := INDEX(specs_added,{ebr_file_number},{specs_added},ebr_file_numberValuesIndexKeyName);
EXPORT ebr_file_number_values_persisted := ebr_file_number_values_index;
SALT26.MAC_Field_Nulls(ebr_file_number_values_persisted,Layout_Specificities.ebr_file_number_ChildRec,nv) // Use automated NULL spotting
EXPORT ebr_file_number_nulls := nv;
SALT26.MAC_Field_Bfoul(ebr_file_number_deduped,ebr_file_number,Proxid,ebr_file_number_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ebr_file_number_switch := bf;
EXPORT ebr_file_number_max := MAX(ebr_file_number_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(ebr_file_number_values_persisted,ebr_file_number,ebr_file_number_nulls,ol) // Compute column level specificity
EXPORT ebr_file_number_specificity := ol;
 
EXPORT domestic_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::domestic_corp_key';
 
SHARED  domestic_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,domestic_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_domestic_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(domestic_corp_key_deduped,domestic_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT domestic_corp_key_values_index := INDEX(specs_added,{domestic_corp_key},{specs_added},domestic_corp_keyValuesIndexKeyName);
EXPORT domestic_corp_key_values_persisted := domestic_corp_key_values_index;
SALT26.MAC_Field_Nulls(domestic_corp_key_values_persisted,Layout_Specificities.domestic_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT domestic_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(domestic_corp_key_deduped,domestic_corp_key,Proxid,domestic_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT domestic_corp_key_switch := bf;
EXPORT domestic_corp_key_max := MAX(domestic_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(domestic_corp_key_values_persisted,domestic_corp_key,domestic_corp_key_nulls,ol) // Compute column level specificity
EXPORT domestic_corp_key_specificity := ol;
 
EXPORT AK_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::AK_foreign_corp_key';
 
SHARED  AK_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,AK_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_AK_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(AK_foreign_corp_key_deduped,AK_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT AK_foreign_corp_key_values_index := INDEX(specs_added,{AK_foreign_corp_key},{specs_added},AK_foreign_corp_keyValuesIndexKeyName);
EXPORT AK_foreign_corp_key_values_persisted := AK_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(AK_foreign_corp_key_values_persisted,Layout_Specificities.AK_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT AK_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(AK_foreign_corp_key_deduped,AK_foreign_corp_key,Proxid,AK_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT AK_foreign_corp_key_switch := bf;
EXPORT AK_foreign_corp_key_max := MAX(AK_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(AK_foreign_corp_key_values_persisted,AK_foreign_corp_key,AK_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT AK_foreign_corp_key_specificity := ol;
 
EXPORT AL_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::AL_foreign_corp_key';
 
SHARED  AL_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,AL_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_AL_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(AL_foreign_corp_key_deduped,AL_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT AL_foreign_corp_key_values_index := INDEX(specs_added,{AL_foreign_corp_key},{specs_added},AL_foreign_corp_keyValuesIndexKeyName);
EXPORT AL_foreign_corp_key_values_persisted := AL_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(AL_foreign_corp_key_values_persisted,Layout_Specificities.AL_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT AL_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(AL_foreign_corp_key_deduped,AL_foreign_corp_key,Proxid,AL_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT AL_foreign_corp_key_switch := bf;
EXPORT AL_foreign_corp_key_max := MAX(AL_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(AL_foreign_corp_key_values_persisted,AL_foreign_corp_key,AL_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT AL_foreign_corp_key_specificity := ol;
 
EXPORT AR_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::AR_foreign_corp_key';
 
SHARED  AR_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,AR_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_AR_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(AR_foreign_corp_key_deduped,AR_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT AR_foreign_corp_key_values_index := INDEX(specs_added,{AR_foreign_corp_key},{specs_added},AR_foreign_corp_keyValuesIndexKeyName);
EXPORT AR_foreign_corp_key_values_persisted := AR_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(AR_foreign_corp_key_values_persisted,Layout_Specificities.AR_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT AR_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(AR_foreign_corp_key_deduped,AR_foreign_corp_key,Proxid,AR_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT AR_foreign_corp_key_switch := bf;
EXPORT AR_foreign_corp_key_max := MAX(AR_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(AR_foreign_corp_key_values_persisted,AR_foreign_corp_key,AR_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT AR_foreign_corp_key_specificity := ol;
 
EXPORT AZ_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::AZ_foreign_corp_key';
 
SHARED  AZ_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,AZ_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_AZ_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(AZ_foreign_corp_key_deduped,AZ_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT AZ_foreign_corp_key_values_index := INDEX(specs_added,{AZ_foreign_corp_key},{specs_added},AZ_foreign_corp_keyValuesIndexKeyName);
EXPORT AZ_foreign_corp_key_values_persisted := AZ_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(AZ_foreign_corp_key_values_persisted,Layout_Specificities.AZ_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT AZ_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(AZ_foreign_corp_key_deduped,AZ_foreign_corp_key,Proxid,AZ_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT AZ_foreign_corp_key_switch := bf;
EXPORT AZ_foreign_corp_key_max := MAX(AZ_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(AZ_foreign_corp_key_values_persisted,AZ_foreign_corp_key,AZ_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT AZ_foreign_corp_key_specificity := ol;
 
EXPORT CA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::CA_foreign_corp_key';
 
SHARED  CA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,CA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_CA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(CA_foreign_corp_key_deduped,CA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT CA_foreign_corp_key_values_index := INDEX(specs_added,{CA_foreign_corp_key},{specs_added},CA_foreign_corp_keyValuesIndexKeyName);
EXPORT CA_foreign_corp_key_values_persisted := CA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(CA_foreign_corp_key_values_persisted,Layout_Specificities.CA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT CA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(CA_foreign_corp_key_deduped,CA_foreign_corp_key,Proxid,CA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CA_foreign_corp_key_switch := bf;
EXPORT CA_foreign_corp_key_max := MAX(CA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(CA_foreign_corp_key_values_persisted,CA_foreign_corp_key,CA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT CA_foreign_corp_key_specificity := ol;
 
EXPORT CO_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::CO_foreign_corp_key';
 
SHARED  CO_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,CO_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_CO_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(CO_foreign_corp_key_deduped,CO_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT CO_foreign_corp_key_values_index := INDEX(specs_added,{CO_foreign_corp_key},{specs_added},CO_foreign_corp_keyValuesIndexKeyName);
EXPORT CO_foreign_corp_key_values_persisted := CO_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(CO_foreign_corp_key_values_persisted,Layout_Specificities.CO_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT CO_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(CO_foreign_corp_key_deduped,CO_foreign_corp_key,Proxid,CO_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CO_foreign_corp_key_switch := bf;
EXPORT CO_foreign_corp_key_max := MAX(CO_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(CO_foreign_corp_key_values_persisted,CO_foreign_corp_key,CO_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT CO_foreign_corp_key_specificity := ol;
 
EXPORT CT_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::CT_foreign_corp_key';
 
SHARED  CT_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,CT_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_CT_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(CT_foreign_corp_key_deduped,CT_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT CT_foreign_corp_key_values_index := INDEX(specs_added,{CT_foreign_corp_key},{specs_added},CT_foreign_corp_keyValuesIndexKeyName);
EXPORT CT_foreign_corp_key_values_persisted := CT_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(CT_foreign_corp_key_values_persisted,Layout_Specificities.CT_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT CT_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(CT_foreign_corp_key_deduped,CT_foreign_corp_key,Proxid,CT_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT CT_foreign_corp_key_switch := bf;
EXPORT CT_foreign_corp_key_max := MAX(CT_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(CT_foreign_corp_key_values_persisted,CT_foreign_corp_key,CT_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT CT_foreign_corp_key_specificity := ol;
 
EXPORT DC_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::DC_foreign_corp_key';
 
SHARED  DC_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,DC_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_DC_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(DC_foreign_corp_key_deduped,DC_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT DC_foreign_corp_key_values_index := INDEX(specs_added,{DC_foreign_corp_key},{specs_added},DC_foreign_corp_keyValuesIndexKeyName);
EXPORT DC_foreign_corp_key_values_persisted := DC_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(DC_foreign_corp_key_values_persisted,Layout_Specificities.DC_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT DC_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(DC_foreign_corp_key_deduped,DC_foreign_corp_key,Proxid,DC_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DC_foreign_corp_key_switch := bf;
EXPORT DC_foreign_corp_key_max := MAX(DC_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(DC_foreign_corp_key_values_persisted,DC_foreign_corp_key,DC_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT DC_foreign_corp_key_specificity := ol;
 
EXPORT DE_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::DE_foreign_corp_key';
 
SHARED  DE_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,DE_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_DE_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(DE_foreign_corp_key_deduped,DE_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT DE_foreign_corp_key_values_index := INDEX(specs_added,{DE_foreign_corp_key},{specs_added},DE_foreign_corp_keyValuesIndexKeyName);
EXPORT DE_foreign_corp_key_values_persisted := DE_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(DE_foreign_corp_key_values_persisted,Layout_Specificities.DE_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT DE_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(DE_foreign_corp_key_deduped,DE_foreign_corp_key,Proxid,DE_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DE_foreign_corp_key_switch := bf;
EXPORT DE_foreign_corp_key_max := MAX(DE_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(DE_foreign_corp_key_values_persisted,DE_foreign_corp_key,DE_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT DE_foreign_corp_key_specificity := ol;
 
EXPORT FL_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::FL_foreign_corp_key';
 
SHARED  FL_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,FL_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_FL_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(FL_foreign_corp_key_deduped,FL_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT FL_foreign_corp_key_values_index := INDEX(specs_added,{FL_foreign_corp_key},{specs_added},FL_foreign_corp_keyValuesIndexKeyName);
EXPORT FL_foreign_corp_key_values_persisted := FL_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(FL_foreign_corp_key_values_persisted,Layout_Specificities.FL_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT FL_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(FL_foreign_corp_key_deduped,FL_foreign_corp_key,Proxid,FL_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FL_foreign_corp_key_switch := bf;
EXPORT FL_foreign_corp_key_max := MAX(FL_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(FL_foreign_corp_key_values_persisted,FL_foreign_corp_key,FL_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT FL_foreign_corp_key_specificity := ol;
 
EXPORT GA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::GA_foreign_corp_key';
 
SHARED  GA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,GA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_GA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(GA_foreign_corp_key_deduped,GA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT GA_foreign_corp_key_values_index := INDEX(specs_added,{GA_foreign_corp_key},{specs_added},GA_foreign_corp_keyValuesIndexKeyName);
EXPORT GA_foreign_corp_key_values_persisted := GA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(GA_foreign_corp_key_values_persisted,Layout_Specificities.GA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT GA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(GA_foreign_corp_key_deduped,GA_foreign_corp_key,Proxid,GA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT GA_foreign_corp_key_switch := bf;
EXPORT GA_foreign_corp_key_max := MAX(GA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(GA_foreign_corp_key_values_persisted,GA_foreign_corp_key,GA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT GA_foreign_corp_key_specificity := ol;
 
EXPORT HI_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::HI_foreign_corp_key';
 
SHARED  HI_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,HI_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_HI_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(HI_foreign_corp_key_deduped,HI_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT HI_foreign_corp_key_values_index := INDEX(specs_added,{HI_foreign_corp_key},{specs_added},HI_foreign_corp_keyValuesIndexKeyName);
EXPORT HI_foreign_corp_key_values_persisted := HI_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(HI_foreign_corp_key_values_persisted,Layout_Specificities.HI_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT HI_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(HI_foreign_corp_key_deduped,HI_foreign_corp_key,Proxid,HI_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT HI_foreign_corp_key_switch := bf;
EXPORT HI_foreign_corp_key_max := MAX(HI_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(HI_foreign_corp_key_values_persisted,HI_foreign_corp_key,HI_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT HI_foreign_corp_key_specificity := ol;
 
EXPORT IA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::IA_foreign_corp_key';
 
SHARED  IA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,IA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_IA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(IA_foreign_corp_key_deduped,IA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT IA_foreign_corp_key_values_index := INDEX(specs_added,{IA_foreign_corp_key},{specs_added},IA_foreign_corp_keyValuesIndexKeyName);
EXPORT IA_foreign_corp_key_values_persisted := IA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(IA_foreign_corp_key_values_persisted,Layout_Specificities.IA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT IA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(IA_foreign_corp_key_deduped,IA_foreign_corp_key,Proxid,IA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT IA_foreign_corp_key_switch := bf;
EXPORT IA_foreign_corp_key_max := MAX(IA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(IA_foreign_corp_key_values_persisted,IA_foreign_corp_key,IA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT IA_foreign_corp_key_specificity := ol;
 
EXPORT ID_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::ID_foreign_corp_key';
 
SHARED  ID_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,ID_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_ID_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(ID_foreign_corp_key_deduped,ID_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT ID_foreign_corp_key_values_index := INDEX(specs_added,{ID_foreign_corp_key},{specs_added},ID_foreign_corp_keyValuesIndexKeyName);
EXPORT ID_foreign_corp_key_values_persisted := ID_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(ID_foreign_corp_key_values_persisted,Layout_Specificities.ID_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT ID_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(ID_foreign_corp_key_deduped,ID_foreign_corp_key,Proxid,ID_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ID_foreign_corp_key_switch := bf;
EXPORT ID_foreign_corp_key_max := MAX(ID_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(ID_foreign_corp_key_values_persisted,ID_foreign_corp_key,ID_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT ID_foreign_corp_key_specificity := ol;
 
EXPORT IL_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::IL_foreign_corp_key';
 
SHARED  IL_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,IL_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_IL_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(IL_foreign_corp_key_deduped,IL_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT IL_foreign_corp_key_values_index := INDEX(specs_added,{IL_foreign_corp_key},{specs_added},IL_foreign_corp_keyValuesIndexKeyName);
EXPORT IL_foreign_corp_key_values_persisted := IL_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(IL_foreign_corp_key_values_persisted,Layout_Specificities.IL_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT IL_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(IL_foreign_corp_key_deduped,IL_foreign_corp_key,Proxid,IL_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT IL_foreign_corp_key_switch := bf;
EXPORT IL_foreign_corp_key_max := MAX(IL_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(IL_foreign_corp_key_values_persisted,IL_foreign_corp_key,IL_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT IL_foreign_corp_key_specificity := ol;
 
EXPORT IN_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::IN_foreign_corp_key';
 
SHARED  IN_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,IN_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_IN_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(IN_foreign_corp_key_deduped,IN_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT IN_foreign_corp_key_values_index := INDEX(specs_added,{IN_foreign_corp_key},{specs_added},IN_foreign_corp_keyValuesIndexKeyName);
EXPORT IN_foreign_corp_key_values_persisted := IN_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(IN_foreign_corp_key_values_persisted,Layout_Specificities.IN_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT IN_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(IN_foreign_corp_key_deduped,IN_foreign_corp_key,Proxid,IN_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT IN_foreign_corp_key_switch := bf;
EXPORT IN_foreign_corp_key_max := MAX(IN_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(IN_foreign_corp_key_values_persisted,IN_foreign_corp_key,IN_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT IN_foreign_corp_key_specificity := ol;
 
EXPORT KS_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::KS_foreign_corp_key';
 
SHARED  KS_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,KS_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_KS_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(KS_foreign_corp_key_deduped,KS_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT KS_foreign_corp_key_values_index := INDEX(specs_added,{KS_foreign_corp_key},{specs_added},KS_foreign_corp_keyValuesIndexKeyName);
EXPORT KS_foreign_corp_key_values_persisted := KS_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(KS_foreign_corp_key_values_persisted,Layout_Specificities.KS_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT KS_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(KS_foreign_corp_key_deduped,KS_foreign_corp_key,Proxid,KS_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT KS_foreign_corp_key_switch := bf;
EXPORT KS_foreign_corp_key_max := MAX(KS_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(KS_foreign_corp_key_values_persisted,KS_foreign_corp_key,KS_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT KS_foreign_corp_key_specificity := ol;
 
EXPORT KY_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::KY_foreign_corp_key';
 
SHARED  KY_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,KY_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_KY_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(KY_foreign_corp_key_deduped,KY_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT KY_foreign_corp_key_values_index := INDEX(specs_added,{KY_foreign_corp_key},{specs_added},KY_foreign_corp_keyValuesIndexKeyName);
EXPORT KY_foreign_corp_key_values_persisted := KY_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(KY_foreign_corp_key_values_persisted,Layout_Specificities.KY_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT KY_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(KY_foreign_corp_key_deduped,KY_foreign_corp_key,Proxid,KY_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT KY_foreign_corp_key_switch := bf;
EXPORT KY_foreign_corp_key_max := MAX(KY_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(KY_foreign_corp_key_values_persisted,KY_foreign_corp_key,KY_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT KY_foreign_corp_key_specificity := ol;
 
EXPORT LA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::LA_foreign_corp_key';
 
SHARED  LA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,LA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_LA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(LA_foreign_corp_key_deduped,LA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT LA_foreign_corp_key_values_index := INDEX(specs_added,{LA_foreign_corp_key},{specs_added},LA_foreign_corp_keyValuesIndexKeyName);
EXPORT LA_foreign_corp_key_values_persisted := LA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(LA_foreign_corp_key_values_persisted,Layout_Specificities.LA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT LA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(LA_foreign_corp_key_deduped,LA_foreign_corp_key,Proxid,LA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LA_foreign_corp_key_switch := bf;
EXPORT LA_foreign_corp_key_max := MAX(LA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(LA_foreign_corp_key_values_persisted,LA_foreign_corp_key,LA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT LA_foreign_corp_key_specificity := ol;
 
EXPORT MA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MA_foreign_corp_key';
 
SHARED  MA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MA_foreign_corp_key_deduped,MA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MA_foreign_corp_key_values_index := INDEX(specs_added,{MA_foreign_corp_key},{specs_added},MA_foreign_corp_keyValuesIndexKeyName);
EXPORT MA_foreign_corp_key_values_persisted := MA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MA_foreign_corp_key_values_persisted,Layout_Specificities.MA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MA_foreign_corp_key_deduped,MA_foreign_corp_key,Proxid,MA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MA_foreign_corp_key_switch := bf;
EXPORT MA_foreign_corp_key_max := MAX(MA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MA_foreign_corp_key_values_persisted,MA_foreign_corp_key,MA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MA_foreign_corp_key_specificity := ol;
 
EXPORT MD_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MD_foreign_corp_key';
 
SHARED  MD_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MD_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MD_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MD_foreign_corp_key_deduped,MD_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MD_foreign_corp_key_values_index := INDEX(specs_added,{MD_foreign_corp_key},{specs_added},MD_foreign_corp_keyValuesIndexKeyName);
EXPORT MD_foreign_corp_key_values_persisted := MD_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MD_foreign_corp_key_values_persisted,Layout_Specificities.MD_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MD_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MD_foreign_corp_key_deduped,MD_foreign_corp_key,Proxid,MD_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MD_foreign_corp_key_switch := bf;
EXPORT MD_foreign_corp_key_max := MAX(MD_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MD_foreign_corp_key_values_persisted,MD_foreign_corp_key,MD_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MD_foreign_corp_key_specificity := ol;
 
EXPORT ME_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::ME_foreign_corp_key';
 
SHARED  ME_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,ME_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_ME_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(ME_foreign_corp_key_deduped,ME_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT ME_foreign_corp_key_values_index := INDEX(specs_added,{ME_foreign_corp_key},{specs_added},ME_foreign_corp_keyValuesIndexKeyName);
EXPORT ME_foreign_corp_key_values_persisted := ME_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(ME_foreign_corp_key_values_persisted,Layout_Specificities.ME_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT ME_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(ME_foreign_corp_key_deduped,ME_foreign_corp_key,Proxid,ME_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ME_foreign_corp_key_switch := bf;
EXPORT ME_foreign_corp_key_max := MAX(ME_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(ME_foreign_corp_key_values_persisted,ME_foreign_corp_key,ME_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT ME_foreign_corp_key_specificity := ol;
 
EXPORT MI_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MI_foreign_corp_key';
 
SHARED  MI_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MI_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MI_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MI_foreign_corp_key_deduped,MI_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MI_foreign_corp_key_values_index := INDEX(specs_added,{MI_foreign_corp_key},{specs_added},MI_foreign_corp_keyValuesIndexKeyName);
EXPORT MI_foreign_corp_key_values_persisted := MI_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MI_foreign_corp_key_values_persisted,Layout_Specificities.MI_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MI_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MI_foreign_corp_key_deduped,MI_foreign_corp_key,Proxid,MI_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MI_foreign_corp_key_switch := bf;
EXPORT MI_foreign_corp_key_max := MAX(MI_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MI_foreign_corp_key_values_persisted,MI_foreign_corp_key,MI_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MI_foreign_corp_key_specificity := ol;
 
EXPORT MN_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MN_foreign_corp_key';
 
SHARED  MN_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MN_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MN_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MN_foreign_corp_key_deduped,MN_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MN_foreign_corp_key_values_index := INDEX(specs_added,{MN_foreign_corp_key},{specs_added},MN_foreign_corp_keyValuesIndexKeyName);
EXPORT MN_foreign_corp_key_values_persisted := MN_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MN_foreign_corp_key_values_persisted,Layout_Specificities.MN_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MN_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MN_foreign_corp_key_deduped,MN_foreign_corp_key,Proxid,MN_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MN_foreign_corp_key_switch := bf;
EXPORT MN_foreign_corp_key_max := MAX(MN_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MN_foreign_corp_key_values_persisted,MN_foreign_corp_key,MN_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MN_foreign_corp_key_specificity := ol;
 
EXPORT MO_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MO_foreign_corp_key';
 
SHARED  MO_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MO_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MO_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MO_foreign_corp_key_deduped,MO_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MO_foreign_corp_key_values_index := INDEX(specs_added,{MO_foreign_corp_key},{specs_added},MO_foreign_corp_keyValuesIndexKeyName);
EXPORT MO_foreign_corp_key_values_persisted := MO_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MO_foreign_corp_key_values_persisted,Layout_Specificities.MO_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MO_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MO_foreign_corp_key_deduped,MO_foreign_corp_key,Proxid,MO_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MO_foreign_corp_key_switch := bf;
EXPORT MO_foreign_corp_key_max := MAX(MO_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MO_foreign_corp_key_values_persisted,MO_foreign_corp_key,MO_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MO_foreign_corp_key_specificity := ol;
 
EXPORT MS_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MS_foreign_corp_key';
 
SHARED  MS_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MS_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MS_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MS_foreign_corp_key_deduped,MS_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MS_foreign_corp_key_values_index := INDEX(specs_added,{MS_foreign_corp_key},{specs_added},MS_foreign_corp_keyValuesIndexKeyName);
EXPORT MS_foreign_corp_key_values_persisted := MS_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MS_foreign_corp_key_values_persisted,Layout_Specificities.MS_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MS_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MS_foreign_corp_key_deduped,MS_foreign_corp_key,Proxid,MS_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MS_foreign_corp_key_switch := bf;
EXPORT MS_foreign_corp_key_max := MAX(MS_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MS_foreign_corp_key_values_persisted,MS_foreign_corp_key,MS_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MS_foreign_corp_key_specificity := ol;
 
EXPORT MT_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::MT_foreign_corp_key';
 
SHARED  MT_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,MT_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_MT_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(MT_foreign_corp_key_deduped,MT_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT MT_foreign_corp_key_values_index := INDEX(specs_added,{MT_foreign_corp_key},{specs_added},MT_foreign_corp_keyValuesIndexKeyName);
EXPORT MT_foreign_corp_key_values_persisted := MT_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(MT_foreign_corp_key_values_persisted,Layout_Specificities.MT_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT MT_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(MT_foreign_corp_key_deduped,MT_foreign_corp_key,Proxid,MT_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MT_foreign_corp_key_switch := bf;
EXPORT MT_foreign_corp_key_max := MAX(MT_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(MT_foreign_corp_key_values_persisted,MT_foreign_corp_key,MT_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT MT_foreign_corp_key_specificity := ol;
 
EXPORT NC_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NC_foreign_corp_key';
 
SHARED  NC_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NC_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NC_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NC_foreign_corp_key_deduped,NC_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NC_foreign_corp_key_values_index := INDEX(specs_added,{NC_foreign_corp_key},{specs_added},NC_foreign_corp_keyValuesIndexKeyName);
EXPORT NC_foreign_corp_key_values_persisted := NC_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NC_foreign_corp_key_values_persisted,Layout_Specificities.NC_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NC_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NC_foreign_corp_key_deduped,NC_foreign_corp_key,Proxid,NC_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NC_foreign_corp_key_switch := bf;
EXPORT NC_foreign_corp_key_max := MAX(NC_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NC_foreign_corp_key_values_persisted,NC_foreign_corp_key,NC_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NC_foreign_corp_key_specificity := ol;
 
EXPORT ND_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::ND_foreign_corp_key';
 
SHARED  ND_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,ND_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_ND_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(ND_foreign_corp_key_deduped,ND_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT ND_foreign_corp_key_values_index := INDEX(specs_added,{ND_foreign_corp_key},{specs_added},ND_foreign_corp_keyValuesIndexKeyName);
EXPORT ND_foreign_corp_key_values_persisted := ND_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(ND_foreign_corp_key_values_persisted,Layout_Specificities.ND_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT ND_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(ND_foreign_corp_key_deduped,ND_foreign_corp_key,Proxid,ND_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ND_foreign_corp_key_switch := bf;
EXPORT ND_foreign_corp_key_max := MAX(ND_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(ND_foreign_corp_key_values_persisted,ND_foreign_corp_key,ND_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT ND_foreign_corp_key_specificity := ol;
 
EXPORT NE_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NE_foreign_corp_key';
 
SHARED  NE_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NE_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NE_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NE_foreign_corp_key_deduped,NE_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NE_foreign_corp_key_values_index := INDEX(specs_added,{NE_foreign_corp_key},{specs_added},NE_foreign_corp_keyValuesIndexKeyName);
EXPORT NE_foreign_corp_key_values_persisted := NE_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NE_foreign_corp_key_values_persisted,Layout_Specificities.NE_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NE_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NE_foreign_corp_key_deduped,NE_foreign_corp_key,Proxid,NE_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NE_foreign_corp_key_switch := bf;
EXPORT NE_foreign_corp_key_max := MAX(NE_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NE_foreign_corp_key_values_persisted,NE_foreign_corp_key,NE_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NE_foreign_corp_key_specificity := ol;
 
EXPORT NH_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NH_foreign_corp_key';
 
SHARED  NH_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NH_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NH_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NH_foreign_corp_key_deduped,NH_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NH_foreign_corp_key_values_index := INDEX(specs_added,{NH_foreign_corp_key},{specs_added},NH_foreign_corp_keyValuesIndexKeyName);
EXPORT NH_foreign_corp_key_values_persisted := NH_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NH_foreign_corp_key_values_persisted,Layout_Specificities.NH_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NH_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NH_foreign_corp_key_deduped,NH_foreign_corp_key,Proxid,NH_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NH_foreign_corp_key_switch := bf;
EXPORT NH_foreign_corp_key_max := MAX(NH_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NH_foreign_corp_key_values_persisted,NH_foreign_corp_key,NH_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NH_foreign_corp_key_specificity := ol;
 
EXPORT NJ_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NJ_foreign_corp_key';
 
SHARED  NJ_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NJ_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NJ_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NJ_foreign_corp_key_deduped,NJ_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NJ_foreign_corp_key_values_index := INDEX(specs_added,{NJ_foreign_corp_key},{specs_added},NJ_foreign_corp_keyValuesIndexKeyName);
EXPORT NJ_foreign_corp_key_values_persisted := NJ_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NJ_foreign_corp_key_values_persisted,Layout_Specificities.NJ_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NJ_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NJ_foreign_corp_key_deduped,NJ_foreign_corp_key,Proxid,NJ_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NJ_foreign_corp_key_switch := bf;
EXPORT NJ_foreign_corp_key_max := MAX(NJ_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NJ_foreign_corp_key_values_persisted,NJ_foreign_corp_key,NJ_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NJ_foreign_corp_key_specificity := ol;
 
EXPORT NM_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NM_foreign_corp_key';
 
SHARED  NM_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NM_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NM_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NM_foreign_corp_key_deduped,NM_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NM_foreign_corp_key_values_index := INDEX(specs_added,{NM_foreign_corp_key},{specs_added},NM_foreign_corp_keyValuesIndexKeyName);
EXPORT NM_foreign_corp_key_values_persisted := NM_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NM_foreign_corp_key_values_persisted,Layout_Specificities.NM_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NM_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NM_foreign_corp_key_deduped,NM_foreign_corp_key,Proxid,NM_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NM_foreign_corp_key_switch := bf;
EXPORT NM_foreign_corp_key_max := MAX(NM_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NM_foreign_corp_key_values_persisted,NM_foreign_corp_key,NM_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NM_foreign_corp_key_specificity := ol;
 
EXPORT NV_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NV_foreign_corp_key';
 
SHARED  NV_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NV_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NV_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NV_foreign_corp_key_deduped,NV_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NV_foreign_corp_key_values_index := INDEX(specs_added,{NV_foreign_corp_key},{specs_added},NV_foreign_corp_keyValuesIndexKeyName);
EXPORT NV_foreign_corp_key_values_persisted := NV_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NV_foreign_corp_key_values_persisted,Layout_Specificities.NV_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NV_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NV_foreign_corp_key_deduped,NV_foreign_corp_key,Proxid,NV_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NV_foreign_corp_key_switch := bf;
EXPORT NV_foreign_corp_key_max := MAX(NV_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NV_foreign_corp_key_values_persisted,NV_foreign_corp_key,NV_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NV_foreign_corp_key_specificity := ol;
 
EXPORT NY_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::NY_foreign_corp_key';
 
SHARED  NY_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,NY_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_NY_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(NY_foreign_corp_key_deduped,NY_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT NY_foreign_corp_key_values_index := INDEX(specs_added,{NY_foreign_corp_key},{specs_added},NY_foreign_corp_keyValuesIndexKeyName);
EXPORT NY_foreign_corp_key_values_persisted := NY_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(NY_foreign_corp_key_values_persisted,Layout_Specificities.NY_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT NY_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(NY_foreign_corp_key_deduped,NY_foreign_corp_key,Proxid,NY_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NY_foreign_corp_key_switch := bf;
EXPORT NY_foreign_corp_key_max := MAX(NY_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(NY_foreign_corp_key_values_persisted,NY_foreign_corp_key,NY_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT NY_foreign_corp_key_specificity := ol;
 
EXPORT OH_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::OH_foreign_corp_key';
 
SHARED  OH_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,OH_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_OH_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(OH_foreign_corp_key_deduped,OH_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT OH_foreign_corp_key_values_index := INDEX(specs_added,{OH_foreign_corp_key},{specs_added},OH_foreign_corp_keyValuesIndexKeyName);
EXPORT OH_foreign_corp_key_values_persisted := OH_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(OH_foreign_corp_key_values_persisted,Layout_Specificities.OH_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT OH_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(OH_foreign_corp_key_deduped,OH_foreign_corp_key,Proxid,OH_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT OH_foreign_corp_key_switch := bf;
EXPORT OH_foreign_corp_key_max := MAX(OH_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(OH_foreign_corp_key_values_persisted,OH_foreign_corp_key,OH_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT OH_foreign_corp_key_specificity := ol;
 
EXPORT OK_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::OK_foreign_corp_key';
 
SHARED  OK_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,OK_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_OK_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(OK_foreign_corp_key_deduped,OK_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT OK_foreign_corp_key_values_index := INDEX(specs_added,{OK_foreign_corp_key},{specs_added},OK_foreign_corp_keyValuesIndexKeyName);
EXPORT OK_foreign_corp_key_values_persisted := OK_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(OK_foreign_corp_key_values_persisted,Layout_Specificities.OK_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT OK_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(OK_foreign_corp_key_deduped,OK_foreign_corp_key,Proxid,OK_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT OK_foreign_corp_key_switch := bf;
EXPORT OK_foreign_corp_key_max := MAX(OK_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(OK_foreign_corp_key_values_persisted,OK_foreign_corp_key,OK_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT OK_foreign_corp_key_specificity := ol;
 
EXPORT OR_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::OR_foreign_corp_key';
 
SHARED  OR_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,OR_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_OR_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(OR_foreign_corp_key_deduped,OR_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT OR_foreign_corp_key_values_index := INDEX(specs_added,{OR_foreign_corp_key},{specs_added},OR_foreign_corp_keyValuesIndexKeyName);
EXPORT OR_foreign_corp_key_values_persisted := OR_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(OR_foreign_corp_key_values_persisted,Layout_Specificities.OR_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT OR_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(OR_foreign_corp_key_deduped,OR_foreign_corp_key,Proxid,OR_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT OR_foreign_corp_key_switch := bf;
EXPORT OR_foreign_corp_key_max := MAX(OR_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(OR_foreign_corp_key_values_persisted,OR_foreign_corp_key,OR_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT OR_foreign_corp_key_specificity := ol;
 
EXPORT PA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::PA_foreign_corp_key';
 
SHARED  PA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,PA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_PA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(PA_foreign_corp_key_deduped,PA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT PA_foreign_corp_key_values_index := INDEX(specs_added,{PA_foreign_corp_key},{specs_added},PA_foreign_corp_keyValuesIndexKeyName);
EXPORT PA_foreign_corp_key_values_persisted := PA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(PA_foreign_corp_key_values_persisted,Layout_Specificities.PA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT PA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(PA_foreign_corp_key_deduped,PA_foreign_corp_key,Proxid,PA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PA_foreign_corp_key_switch := bf;
EXPORT PA_foreign_corp_key_max := MAX(PA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(PA_foreign_corp_key_values_persisted,PA_foreign_corp_key,PA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT PA_foreign_corp_key_specificity := ol;
 
EXPORT PR_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::PR_foreign_corp_key';
 
SHARED  PR_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,PR_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_PR_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(PR_foreign_corp_key_deduped,PR_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT PR_foreign_corp_key_values_index := INDEX(specs_added,{PR_foreign_corp_key},{specs_added},PR_foreign_corp_keyValuesIndexKeyName);
EXPORT PR_foreign_corp_key_values_persisted := PR_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(PR_foreign_corp_key_values_persisted,Layout_Specificities.PR_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT PR_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(PR_foreign_corp_key_deduped,PR_foreign_corp_key,Proxid,PR_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PR_foreign_corp_key_switch := bf;
EXPORT PR_foreign_corp_key_max := MAX(PR_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(PR_foreign_corp_key_values_persisted,PR_foreign_corp_key,PR_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT PR_foreign_corp_key_specificity := ol;
 
EXPORT RI_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::RI_foreign_corp_key';
 
SHARED  RI_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,RI_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_RI_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(RI_foreign_corp_key_deduped,RI_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT RI_foreign_corp_key_values_index := INDEX(specs_added,{RI_foreign_corp_key},{specs_added},RI_foreign_corp_keyValuesIndexKeyName);
EXPORT RI_foreign_corp_key_values_persisted := RI_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(RI_foreign_corp_key_values_persisted,Layout_Specificities.RI_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT RI_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(RI_foreign_corp_key_deduped,RI_foreign_corp_key,Proxid,RI_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT RI_foreign_corp_key_switch := bf;
EXPORT RI_foreign_corp_key_max := MAX(RI_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(RI_foreign_corp_key_values_persisted,RI_foreign_corp_key,RI_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT RI_foreign_corp_key_specificity := ol;
 
EXPORT SC_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::SC_foreign_corp_key';
 
SHARED  SC_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,SC_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_SC_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(SC_foreign_corp_key_deduped,SC_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT SC_foreign_corp_key_values_index := INDEX(specs_added,{SC_foreign_corp_key},{specs_added},SC_foreign_corp_keyValuesIndexKeyName);
EXPORT SC_foreign_corp_key_values_persisted := SC_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(SC_foreign_corp_key_values_persisted,Layout_Specificities.SC_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT SC_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(SC_foreign_corp_key_deduped,SC_foreign_corp_key,Proxid,SC_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SC_foreign_corp_key_switch := bf;
EXPORT SC_foreign_corp_key_max := MAX(SC_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(SC_foreign_corp_key_values_persisted,SC_foreign_corp_key,SC_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT SC_foreign_corp_key_specificity := ol;
 
EXPORT SD_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::SD_foreign_corp_key';
 
SHARED  SD_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,SD_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_SD_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(SD_foreign_corp_key_deduped,SD_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT SD_foreign_corp_key_values_index := INDEX(specs_added,{SD_foreign_corp_key},{specs_added},SD_foreign_corp_keyValuesIndexKeyName);
EXPORT SD_foreign_corp_key_values_persisted := SD_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(SD_foreign_corp_key_values_persisted,Layout_Specificities.SD_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT SD_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(SD_foreign_corp_key_deduped,SD_foreign_corp_key,Proxid,SD_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SD_foreign_corp_key_switch := bf;
EXPORT SD_foreign_corp_key_max := MAX(SD_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(SD_foreign_corp_key_values_persisted,SD_foreign_corp_key,SD_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT SD_foreign_corp_key_specificity := ol;
 
EXPORT TN_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::TN_foreign_corp_key';
 
SHARED  TN_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,TN_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_TN_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(TN_foreign_corp_key_deduped,TN_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT TN_foreign_corp_key_values_index := INDEX(specs_added,{TN_foreign_corp_key},{specs_added},TN_foreign_corp_keyValuesIndexKeyName);
EXPORT TN_foreign_corp_key_values_persisted := TN_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(TN_foreign_corp_key_values_persisted,Layout_Specificities.TN_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT TN_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(TN_foreign_corp_key_deduped,TN_foreign_corp_key,Proxid,TN_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TN_foreign_corp_key_switch := bf;
EXPORT TN_foreign_corp_key_max := MAX(TN_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(TN_foreign_corp_key_values_persisted,TN_foreign_corp_key,TN_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT TN_foreign_corp_key_specificity := ol;
 
EXPORT TX_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::TX_foreign_corp_key';
 
SHARED  TX_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,TX_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_TX_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(TX_foreign_corp_key_deduped,TX_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT TX_foreign_corp_key_values_index := INDEX(specs_added,{TX_foreign_corp_key},{specs_added},TX_foreign_corp_keyValuesIndexKeyName);
EXPORT TX_foreign_corp_key_values_persisted := TX_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(TX_foreign_corp_key_values_persisted,Layout_Specificities.TX_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT TX_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(TX_foreign_corp_key_deduped,TX_foreign_corp_key,Proxid,TX_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TX_foreign_corp_key_switch := bf;
EXPORT TX_foreign_corp_key_max := MAX(TX_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(TX_foreign_corp_key_values_persisted,TX_foreign_corp_key,TX_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT TX_foreign_corp_key_specificity := ol;
 
EXPORT UT_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::UT_foreign_corp_key';
 
SHARED  UT_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,UT_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_UT_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(UT_foreign_corp_key_deduped,UT_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT UT_foreign_corp_key_values_index := INDEX(specs_added,{UT_foreign_corp_key},{specs_added},UT_foreign_corp_keyValuesIndexKeyName);
EXPORT UT_foreign_corp_key_values_persisted := UT_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(UT_foreign_corp_key_values_persisted,Layout_Specificities.UT_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT UT_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(UT_foreign_corp_key_deduped,UT_foreign_corp_key,Proxid,UT_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT UT_foreign_corp_key_switch := bf;
EXPORT UT_foreign_corp_key_max := MAX(UT_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(UT_foreign_corp_key_values_persisted,UT_foreign_corp_key,UT_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT UT_foreign_corp_key_specificity := ol;
 
EXPORT VA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::VA_foreign_corp_key';
 
SHARED  VA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,VA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_VA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(VA_foreign_corp_key_deduped,VA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT VA_foreign_corp_key_values_index := INDEX(specs_added,{VA_foreign_corp_key},{specs_added},VA_foreign_corp_keyValuesIndexKeyName);
EXPORT VA_foreign_corp_key_values_persisted := VA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(VA_foreign_corp_key_values_persisted,Layout_Specificities.VA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT VA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(VA_foreign_corp_key_deduped,VA_foreign_corp_key,Proxid,VA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VA_foreign_corp_key_switch := bf;
EXPORT VA_foreign_corp_key_max := MAX(VA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(VA_foreign_corp_key_values_persisted,VA_foreign_corp_key,VA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT VA_foreign_corp_key_specificity := ol;
 
EXPORT VI_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::VI_foreign_corp_key';
 
SHARED  VI_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,VI_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_VI_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(VI_foreign_corp_key_deduped,VI_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT VI_foreign_corp_key_values_index := INDEX(specs_added,{VI_foreign_corp_key},{specs_added},VI_foreign_corp_keyValuesIndexKeyName);
EXPORT VI_foreign_corp_key_values_persisted := VI_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(VI_foreign_corp_key_values_persisted,Layout_Specificities.VI_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT VI_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(VI_foreign_corp_key_deduped,VI_foreign_corp_key,Proxid,VI_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VI_foreign_corp_key_switch := bf;
EXPORT VI_foreign_corp_key_max := MAX(VI_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(VI_foreign_corp_key_values_persisted,VI_foreign_corp_key,VI_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT VI_foreign_corp_key_specificity := ol;
 
EXPORT VT_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::VT_foreign_corp_key';
 
SHARED  VT_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,VT_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_VT_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(VT_foreign_corp_key_deduped,VT_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT VT_foreign_corp_key_values_index := INDEX(specs_added,{VT_foreign_corp_key},{specs_added},VT_foreign_corp_keyValuesIndexKeyName);
EXPORT VT_foreign_corp_key_values_persisted := VT_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(VT_foreign_corp_key_values_persisted,Layout_Specificities.VT_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT VT_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(VT_foreign_corp_key_deduped,VT_foreign_corp_key,Proxid,VT_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VT_foreign_corp_key_switch := bf;
EXPORT VT_foreign_corp_key_max := MAX(VT_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(VT_foreign_corp_key_values_persisted,VT_foreign_corp_key,VT_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT VT_foreign_corp_key_specificity := ol;
 
EXPORT WA_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::WA_foreign_corp_key';
 
SHARED  WA_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,WA_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_WA_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(WA_foreign_corp_key_deduped,WA_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT WA_foreign_corp_key_values_index := INDEX(specs_added,{WA_foreign_corp_key},{specs_added},WA_foreign_corp_keyValuesIndexKeyName);
EXPORT WA_foreign_corp_key_values_persisted := WA_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(WA_foreign_corp_key_values_persisted,Layout_Specificities.WA_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT WA_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(WA_foreign_corp_key_deduped,WA_foreign_corp_key,Proxid,WA_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT WA_foreign_corp_key_switch := bf;
EXPORT WA_foreign_corp_key_max := MAX(WA_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(WA_foreign_corp_key_values_persisted,WA_foreign_corp_key,WA_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT WA_foreign_corp_key_specificity := ol;
 
EXPORT WI_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::WI_foreign_corp_key';
 
SHARED  WI_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,WI_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_WI_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(WI_foreign_corp_key_deduped,WI_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT WI_foreign_corp_key_values_index := INDEX(specs_added,{WI_foreign_corp_key},{specs_added},WI_foreign_corp_keyValuesIndexKeyName);
EXPORT WI_foreign_corp_key_values_persisted := WI_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(WI_foreign_corp_key_values_persisted,Layout_Specificities.WI_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT WI_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(WI_foreign_corp_key_deduped,WI_foreign_corp_key,Proxid,WI_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT WI_foreign_corp_key_switch := bf;
EXPORT WI_foreign_corp_key_max := MAX(WI_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(WI_foreign_corp_key_values_persisted,WI_foreign_corp_key,WI_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT WI_foreign_corp_key_specificity := ol;
 
EXPORT WV_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::WV_foreign_corp_key';
 
SHARED  WV_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,WV_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_WV_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(WV_foreign_corp_key_deduped,WV_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT WV_foreign_corp_key_values_index := INDEX(specs_added,{WV_foreign_corp_key},{specs_added},WV_foreign_corp_keyValuesIndexKeyName);
EXPORT WV_foreign_corp_key_values_persisted := WV_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(WV_foreign_corp_key_values_persisted,Layout_Specificities.WV_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT WV_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(WV_foreign_corp_key_deduped,WV_foreign_corp_key,Proxid,WV_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT WV_foreign_corp_key_switch := bf;
EXPORT WV_foreign_corp_key_max := MAX(WV_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(WV_foreign_corp_key_values_persisted,WV_foreign_corp_key,WV_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT WV_foreign_corp_key_specificity := ol;
 
EXPORT WY_foreign_corp_keyValuesIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Word::WY_foreign_corp_key';
 
SHARED  WY_foreign_corp_key_deduped := SALT26.MAC_Field_By_UID(input_file,Proxid,WY_foreign_corp_key) : PERSIST('temp::dedups::BIPV2_ProxID_dev3_Proxid_WY_foreign_corp_key'); // Reduce to field values by UID
  SALT26.Mac_Field_Count_UID(WY_foreign_corp_key_deduped,WY_foreign_corp_key,Proxid,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT26.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
 
EXPORT WY_foreign_corp_key_values_index := INDEX(specs_added,{WY_foreign_corp_key},{specs_added},WY_foreign_corp_keyValuesIndexKeyName);
EXPORT WY_foreign_corp_key_values_persisted := WY_foreign_corp_key_values_index;
SALT26.MAC_Field_Nulls(WY_foreign_corp_key_values_persisted,Layout_Specificities.WY_foreign_corp_key_ChildRec,nv) // Use automated NULL spotting
EXPORT WY_foreign_corp_key_nulls := nv;
SALT26.MAC_Field_Bfoul(WY_foreign_corp_key_deduped,WY_foreign_corp_key,Proxid,WY_foreign_corp_key_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT WY_foreign_corp_key_switch := bf;
EXPORT WY_foreign_corp_key_max := MAX(WY_foreign_corp_key_values_persisted,field_specificity);
SALT26.MAC_Field_Specificity(WY_foreign_corp_key_values_persisted,WY_foreign_corp_key,WY_foreign_corp_key_nulls,ol) // Compute column level specificity
EXPORT WY_foreign_corp_key_specificity := ol;
 
EXPORT SpecIndexKeyName := '~'+'key::BIPV2_ProxID_dev3::Proxid::Specificities';
iSpecificities := DATASET([{0,cnp_name_specificity,cnp_name_switch,cnp_name_max,cnp_name_nulls,cnp_number_specificity,cnp_number_switch,cnp_number_max,cnp_number_nulls,cnp_btype_specificity,cnp_btype_switch,cnp_btype_max,cnp_btype_nulls,company_fein_specificity,company_fein_switch,company_fein_max,company_fein_nulls,company_phone_specificity,company_phone_switch,company_phone_max,company_phone_nulls,iscorp_specificity,iscorp_switch,iscorp_max,iscorp_nulls,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,company_csz_specificity,company_csz_switch,company_csz_max,company_csz_nulls,company_addr1_specificity,company_addr1_switch,company_addr1_max,company_addr1_nulls,company_address_specificity,company_address_switch,company_address_max,company_address_nulls,active_duns_number_specificity,active_duns_number_switch,active_duns_number_max,active_duns_number_nulls,active_enterprise_number_specificity,active_enterprise_number_switch,active_enterprise_number_max,active_enterprise_number_nulls,hist_enterprise_number_specificity,hist_enterprise_number_switch,hist_enterprise_number_max,hist_enterprise_number_nulls,hist_duns_number_specificity,hist_duns_number_switch,hist_duns_number_max,hist_duns_number_nulls,ebr_file_number_specificity,ebr_file_number_switch,ebr_file_number_max,ebr_file_number_nulls,domestic_corp_key_specificity,domestic_corp_key_switch,domestic_corp_key_max,domestic_corp_key_nulls,AK_foreign_corp_key_specificity,AK_foreign_corp_key_switch,AK_foreign_corp_key_max,AK_foreign_corp_key_nulls,AL_foreign_corp_key_specificity,AL_foreign_corp_key_switch,AL_foreign_corp_key_max,AL_foreign_corp_key_nulls,AR_foreign_corp_key_specificity,AR_foreign_corp_key_switch,AR_foreign_corp_key_max,AR_foreign_corp_key_nulls,AZ_foreign_corp_key_specificity,AZ_foreign_corp_key_switch,AZ_foreign_corp_key_max,AZ_foreign_corp_key_nulls,CA_foreign_corp_key_specificity,CA_foreign_corp_key_switch,CA_foreign_corp_key_max,CA_foreign_corp_key_nulls,CO_foreign_corp_key_specificity,CO_foreign_corp_key_switch,CO_foreign_corp_key_max,CO_foreign_corp_key_nulls,CT_foreign_corp_key_specificity,CT_foreign_corp_key_switch,CT_foreign_corp_key_max,CT_foreign_corp_key_nulls,DC_foreign_corp_key_specificity,DC_foreign_corp_key_switch,DC_foreign_corp_key_max,DC_foreign_corp_key_nulls,DE_foreign_corp_key_specificity,DE_foreign_corp_key_switch,DE_foreign_corp_key_max,DE_foreign_corp_key_nulls,FL_foreign_corp_key_specificity,FL_foreign_corp_key_switch,FL_foreign_corp_key_max,FL_foreign_corp_key_nulls,GA_foreign_corp_key_specificity,GA_foreign_corp_key_switch,GA_foreign_corp_key_max,GA_foreign_corp_key_nulls,HI_foreign_corp_key_specificity,HI_foreign_corp_key_switch,HI_foreign_corp_key_max,HI_foreign_corp_key_nulls,IA_foreign_corp_key_specificity,IA_foreign_corp_key_switch,IA_foreign_corp_key_max,IA_foreign_corp_key_nulls,ID_foreign_corp_key_specificity,ID_foreign_corp_key_switch,ID_foreign_corp_key_max,ID_foreign_corp_key_nulls,IL_foreign_corp_key_specificity,IL_foreign_corp_key_switch,IL_foreign_corp_key_max,IL_foreign_corp_key_nulls,IN_foreign_corp_key_specificity,IN_foreign_corp_key_switch,IN_foreign_corp_key_max,IN_foreign_corp_key_nulls,KS_foreign_corp_key_specificity,KS_foreign_corp_key_switch,KS_foreign_corp_key_max,KS_foreign_corp_key_nulls,KY_foreign_corp_key_specificity,KY_foreign_corp_key_switch,KY_foreign_corp_key_max,KY_foreign_corp_key_nulls,LA_foreign_corp_key_specificity,LA_foreign_corp_key_switch,LA_foreign_corp_key_max,LA_foreign_corp_key_nulls,MA_foreign_corp_key_specificity,MA_foreign_corp_key_switch,MA_foreign_corp_key_max,MA_foreign_corp_key_nulls,MD_foreign_corp_key_specificity,MD_foreign_corp_key_switch,MD_foreign_corp_key_max,MD_foreign_corp_key_nulls,ME_foreign_corp_key_specificity,ME_foreign_corp_key_switch,ME_foreign_corp_key_max,ME_foreign_corp_key_nulls,MI_foreign_corp_key_specificity,MI_foreign_corp_key_switch,MI_foreign_corp_key_max,MI_foreign_corp_key_nulls,MN_foreign_corp_key_specificity,MN_foreign_corp_key_switch,MN_foreign_corp_key_max,MN_foreign_corp_key_nulls,MO_foreign_corp_key_specificity,MO_foreign_corp_key_switch,MO_foreign_corp_key_max,MO_foreign_corp_key_nulls,MS_foreign_corp_key_specificity,MS_foreign_corp_key_switch,MS_foreign_corp_key_max,MS_foreign_corp_key_nulls,MT_foreign_corp_key_specificity,MT_foreign_corp_key_switch,MT_foreign_corp_key_max,MT_foreign_corp_key_nulls,NC_foreign_corp_key_specificity,NC_foreign_corp_key_switch,NC_foreign_corp_key_max,NC_foreign_corp_key_nulls,ND_foreign_corp_key_specificity,ND_foreign_corp_key_switch,ND_foreign_corp_key_max,ND_foreign_corp_key_nulls,NE_foreign_corp_key_specificity,NE_foreign_corp_key_switch,NE_foreign_corp_key_max,NE_foreign_corp_key_nulls,NH_foreign_corp_key_specificity,NH_foreign_corp_key_switch,NH_foreign_corp_key_max,NH_foreign_corp_key_nulls,NJ_foreign_corp_key_specificity,NJ_foreign_corp_key_switch,NJ_foreign_corp_key_max,NJ_foreign_corp_key_nulls,NM_foreign_corp_key_specificity,NM_foreign_corp_key_switch,NM_foreign_corp_key_max,NM_foreign_corp_key_nulls,NV_foreign_corp_key_specificity,NV_foreign_corp_key_switch,NV_foreign_corp_key_max,NV_foreign_corp_key_nulls,NY_foreign_corp_key_specificity,NY_foreign_corp_key_switch,NY_foreign_corp_key_max,NY_foreign_corp_key_nulls,OH_foreign_corp_key_specificity,OH_foreign_corp_key_switch,OH_foreign_corp_key_max,OH_foreign_corp_key_nulls,OK_foreign_corp_key_specificity,OK_foreign_corp_key_switch,OK_foreign_corp_key_max,OK_foreign_corp_key_nulls,OR_foreign_corp_key_specificity,OR_foreign_corp_key_switch,OR_foreign_corp_key_max,OR_foreign_corp_key_nulls,PA_foreign_corp_key_specificity,PA_foreign_corp_key_switch,PA_foreign_corp_key_max,PA_foreign_corp_key_nulls,PR_foreign_corp_key_specificity,PR_foreign_corp_key_switch,PR_foreign_corp_key_max,PR_foreign_corp_key_nulls,RI_foreign_corp_key_specificity,RI_foreign_corp_key_switch,RI_foreign_corp_key_max,RI_foreign_corp_key_nulls,SC_foreign_corp_key_specificity,SC_foreign_corp_key_switch,SC_foreign_corp_key_max,SC_foreign_corp_key_nulls,SD_foreign_corp_key_specificity,SD_foreign_corp_key_switch,SD_foreign_corp_key_max,SD_foreign_corp_key_nulls,TN_foreign_corp_key_specificity,TN_foreign_corp_key_switch,TN_foreign_corp_key_max,TN_foreign_corp_key_nulls,TX_foreign_corp_key_specificity,TX_foreign_corp_key_switch,TX_foreign_corp_key_max,TX_foreign_corp_key_nulls,UT_foreign_corp_key_specificity,UT_foreign_corp_key_switch,UT_foreign_corp_key_max,UT_foreign_corp_key_nulls,VA_foreign_corp_key_specificity,VA_foreign_corp_key_switch,VA_foreign_corp_key_max,VA_foreign_corp_key_nulls,VI_foreign_corp_key_specificity,VI_foreign_corp_key_switch,VI_foreign_corp_key_max,VI_foreign_corp_key_nulls,VT_foreign_corp_key_specificity,VT_foreign_corp_key_switch,VT_foreign_corp_key_max,VT_foreign_corp_key_nulls,WA_foreign_corp_key_specificity,WA_foreign_corp_key_switch,WA_foreign_corp_key_max,WA_foreign_corp_key_nulls,WI_foreign_corp_key_specificity,WI_foreign_corp_key_switch,WI_foreign_corp_key_max,WI_foreign_corp_key_nulls,WV_foreign_corp_key_specificity,WV_foreign_corp_key_switch,WV_foreign_corp_key_max,WV_foreign_corp_key_nulls,WY_foreign_corp_key_specificity,WY_foreign_corp_key_switch,WY_foreign_corp_key_max,WY_foreign_corp_key_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( PARALLEL(BUILDINDEX(cnp_name_values_index, OVERWRITE),BUILDINDEX(cnp_number_values_index, OVERWRITE),BUILDINDEX(cnp_btype_values_index, OVERWRITE),BUILDINDEX(company_fein_values_index, OVERWRITE),BUILDINDEX(company_phone_values_index, OVERWRITE),BUILDINDEX(iscorp_values_index, OVERWRITE),BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip_values_index, OVERWRITE),BUILDINDEX(company_csz_values_index, OVERWRITE),BUILDINDEX(company_addr1_values_index, OVERWRITE),BUILDINDEX(company_address_values_index, OVERWRITE),BUILDINDEX(active_duns_number_values_index, OVERWRITE),BUILDINDEX(active_enterprise_number_values_index, OVERWRITE),BUILDINDEX(hist_enterprise_number_values_index, OVERWRITE),BUILDINDEX(hist_duns_number_values_index, OVERWRITE),BUILDINDEX(ebr_file_number_values_index, OVERWRITE),BUILDINDEX(domestic_corp_key_values_index, OVERWRITE),BUILDINDEX(AK_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(AL_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(AR_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(AZ_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(CA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(CO_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(CT_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(DC_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(DE_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(FL_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(GA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(HI_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(IA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(ID_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(IL_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(IN_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(KS_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(KY_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(LA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MD_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(ME_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MI_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MN_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MO_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MS_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(MT_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NC_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(ND_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NE_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NH_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NJ_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NM_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NV_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(NY_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(OH_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(OK_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(OR_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(PA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(PR_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(RI_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(SC_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(SD_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(TN_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(TX_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(UT_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(VA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(VI_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(VT_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(WA_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(WI_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(WV_foreign_corp_key_values_index, OVERWRITE),BUILDINDEX(WY_foreign_corp_key_values_index, OVERWRITE)), BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 cnp_name_shift0 := ROUND(Specificities[1].cnp_name_specificity - 25);
  integer2 cnp_name_switch_shift0 := ROUND(1000*Specificities[1].cnp_name_switch - 67);
  integer1 cnp_number_shift0 := ROUND(Specificities[1].cnp_number_specificity - 12);
  integer2 cnp_number_switch_shift0 := ROUND(1000*Specificities[1].cnp_number_switch - 0);
  integer1 cnp_btype_shift0 := ROUND(Specificities[1].cnp_btype_specificity - 3);
  integer2 cnp_btype_switch_shift0 := ROUND(1000*Specificities[1].cnp_btype_switch - 24);
  integer1 company_fein_shift0 := ROUND(Specificities[1].company_fein_specificity - 25);
  integer2 company_fein_switch_shift0 := ROUND(1000*Specificities[1].company_fein_switch - 34);
  integer1 company_phone_shift0 := ROUND(Specificities[1].company_phone_specificity - 26);
  integer2 company_phone_switch_shift0 := ROUND(1000*Specificities[1].company_phone_switch - 254);
  integer1 iscorp_shift0 := ROUND(Specificities[1].iscorp_specificity - 1);
  integer2 iscorp_switch_shift0 := ROUND(1000*Specificities[1].iscorp_switch - 0);
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 15);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 12);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 90);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 11);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 6);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 5);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 14);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 6);
  integer1 company_csz_shift0 := ROUND(Specificities[1].company_csz_specificity - 14);
  integer2 company_csz_switch_shift0 := ROUND(1000*Specificities[1].company_csz_switch - 9);
  integer1 company_addr1_shift0 := ROUND(Specificities[1].company_addr1_specificity - 23);
  integer2 company_addr1_switch_shift0 := ROUND(1000*Specificities[1].company_addr1_switch - 106);
  integer1 company_address_shift0 := ROUND(Specificities[1].company_address_specificity - 25);
  integer2 company_address_switch_shift0 := ROUND(1000*Specificities[1].company_address_switch - 114);
  integer1 active_duns_number_shift0 := ROUND(Specificities[1].active_duns_number_specificity - 27);
  integer2 active_duns_number_switch_shift0 := ROUND(1000*Specificities[1].active_duns_number_switch - 0);
  integer1 active_enterprise_number_shift0 := ROUND(Specificities[1].active_enterprise_number_specificity - 28);
  integer2 active_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].active_enterprise_number_switch - 0);
  integer1 hist_enterprise_number_shift0 := ROUND(Specificities[1].hist_enterprise_number_specificity - 27);
  integer2 hist_enterprise_number_switch_shift0 := ROUND(1000*Specificities[1].hist_enterprise_number_switch - 10);
  integer1 hist_duns_number_shift0 := ROUND(Specificities[1].hist_duns_number_specificity - 27);
  integer2 hist_duns_number_switch_shift0 := ROUND(1000*Specificities[1].hist_duns_number_switch - 20);
  integer1 ebr_file_number_shift0 := ROUND(Specificities[1].ebr_file_number_specificity - 27);
  integer2 ebr_file_number_switch_shift0 := ROUND(1000*Specificities[1].ebr_file_number_switch - 251);
  integer1 domestic_corp_key_shift0 := ROUND(Specificities[1].domestic_corp_key_specificity - 26);
  integer2 domestic_corp_key_switch_shift0 := ROUND(1000*Specificities[1].domestic_corp_key_switch - 1);
  integer1 AK_foreign_corp_key_shift0 := ROUND(Specificities[1].AK_foreign_corp_key_specificity - 25);
  integer2 AK_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].AK_foreign_corp_key_switch - 1);
  integer1 AL_foreign_corp_key_shift0 := ROUND(Specificities[1].AL_foreign_corp_key_specificity - 26);
  integer2 AL_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].AL_foreign_corp_key_switch - 1);
  integer1 AR_foreign_corp_key_shift0 := ROUND(Specificities[1].AR_foreign_corp_key_specificity - 27);
  integer2 AR_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].AR_foreign_corp_key_switch - 0);
  integer1 AZ_foreign_corp_key_shift0 := ROUND(Specificities[1].AZ_foreign_corp_key_specificity - 24);
  integer2 AZ_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].AZ_foreign_corp_key_switch - 2);
  integer1 CA_foreign_corp_key_shift0 := ROUND(Specificities[1].CA_foreign_corp_key_specificity - 27);
  integer2 CA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].CA_foreign_corp_key_switch - 0);
  integer1 CO_foreign_corp_key_shift0 := ROUND(Specificities[1].CO_foreign_corp_key_specificity - 27);
  integer2 CO_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].CO_foreign_corp_key_switch - 0);
  integer1 CT_foreign_corp_key_shift0 := ROUND(Specificities[1].CT_foreign_corp_key_specificity - 25);
  integer2 CT_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].CT_foreign_corp_key_switch - 2);
  integer1 DC_foreign_corp_key_shift0 := ROUND(Specificities[1].DC_foreign_corp_key_specificity - 27);
  integer2 DC_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].DC_foreign_corp_key_switch - 0);
  integer1 DE_foreign_corp_key_shift0 := ROUND(Specificities[1].DE_foreign_corp_key_specificity - 0);
  integer2 DE_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].DE_foreign_corp_key_switch - 0);
  integer1 FL_foreign_corp_key_shift0 := ROUND(Specificities[1].FL_foreign_corp_key_specificity - 26);
  integer2 FL_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].FL_foreign_corp_key_switch - 1);
  integer1 GA_foreign_corp_key_shift0 := ROUND(Specificities[1].GA_foreign_corp_key_specificity - 26);
  integer2 GA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].GA_foreign_corp_key_switch - 1);
  integer1 HI_foreign_corp_key_shift0 := ROUND(Specificities[1].HI_foreign_corp_key_specificity - 25);
  integer2 HI_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].HI_foreign_corp_key_switch - 0);
  integer1 IA_foreign_corp_key_shift0 := ROUND(Specificities[1].IA_foreign_corp_key_specificity - 25);
  integer2 IA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].IA_foreign_corp_key_switch - 3);
  integer1 ID_foreign_corp_key_shift0 := ROUND(Specificities[1].ID_foreign_corp_key_specificity - 0);
  integer2 ID_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].ID_foreign_corp_key_switch - 0);
  integer1 IL_foreign_corp_key_shift0 := ROUND(Specificities[1].IL_foreign_corp_key_specificity - 26);
  integer2 IL_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].IL_foreign_corp_key_switch - 0);
  integer1 IN_foreign_corp_key_shift0 := ROUND(Specificities[1].IN_foreign_corp_key_specificity - 26);
  integer2 IN_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].IN_foreign_corp_key_switch - 0);
  integer1 KS_foreign_corp_key_shift0 := ROUND(Specificities[1].KS_foreign_corp_key_specificity - 27);
  integer2 KS_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].KS_foreign_corp_key_switch - 0);
  integer1 KY_foreign_corp_key_shift0 := ROUND(Specificities[1].KY_foreign_corp_key_specificity - 27);
  integer2 KY_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].KY_foreign_corp_key_switch - 0);
  integer1 LA_foreign_corp_key_shift0 := ROUND(Specificities[1].LA_foreign_corp_key_specificity - 25);
  integer2 LA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].LA_foreign_corp_key_switch - 1);
  integer1 MA_foreign_corp_key_shift0 := ROUND(Specificities[1].MA_foreign_corp_key_specificity - 27);
  integer2 MA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MA_foreign_corp_key_switch - 1);
  integer1 MD_foreign_corp_key_shift0 := ROUND(Specificities[1].MD_foreign_corp_key_specificity - 27);
  integer2 MD_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MD_foreign_corp_key_switch - 0);
  integer1 ME_foreign_corp_key_shift0 := ROUND(Specificities[1].ME_foreign_corp_key_specificity - 27);
  integer2 ME_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].ME_foreign_corp_key_switch - 0);
  integer1 MI_foreign_corp_key_shift0 := ROUND(Specificities[1].MI_foreign_corp_key_specificity - 27);
  integer2 MI_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MI_foreign_corp_key_switch - 1);
  integer1 MN_foreign_corp_key_shift0 := ROUND(Specificities[1].MN_foreign_corp_key_specificity - 28);
  integer2 MN_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MN_foreign_corp_key_switch - 1);
  integer1 MO_foreign_corp_key_shift0 := ROUND(Specificities[1].MO_foreign_corp_key_specificity - 27);
  integer2 MO_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MO_foreign_corp_key_switch - 0);
  integer1 MS_foreign_corp_key_shift0 := ROUND(Specificities[1].MS_foreign_corp_key_specificity - 26);
  integer2 MS_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MS_foreign_corp_key_switch - 1);
  integer1 MT_foreign_corp_key_shift0 := ROUND(Specificities[1].MT_foreign_corp_key_specificity - 25);
  integer2 MT_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].MT_foreign_corp_key_switch - 0);
  integer1 NC_foreign_corp_key_shift0 := ROUND(Specificities[1].NC_foreign_corp_key_specificity - 27);
  integer2 NC_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NC_foreign_corp_key_switch - 0);
  integer1 ND_foreign_corp_key_shift0 := ROUND(Specificities[1].ND_foreign_corp_key_specificity - 27);
  integer2 ND_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].ND_foreign_corp_key_switch - 0);
  integer1 NE_foreign_corp_key_shift0 := ROUND(Specificities[1].NE_foreign_corp_key_specificity - 25);
  integer2 NE_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NE_foreign_corp_key_switch - 0);
  integer1 NH_foreign_corp_key_shift0 := ROUND(Specificities[1].NH_foreign_corp_key_specificity - 26);
  integer2 NH_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NH_foreign_corp_key_switch - 1);
  integer1 NJ_foreign_corp_key_shift0 := ROUND(Specificities[1].NJ_foreign_corp_key_specificity - 28);
  integer2 NJ_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NJ_foreign_corp_key_switch - 0);
  integer1 NM_foreign_corp_key_shift0 := ROUND(Specificities[1].NM_foreign_corp_key_specificity - 27);
  integer2 NM_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NM_foreign_corp_key_switch - 0);
  integer1 NV_foreign_corp_key_shift0 := ROUND(Specificities[1].NV_foreign_corp_key_specificity - 26);
  integer2 NV_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NV_foreign_corp_key_switch - 0);
  integer1 NY_foreign_corp_key_shift0 := ROUND(Specificities[1].NY_foreign_corp_key_specificity - 26);
  integer2 NY_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].NY_foreign_corp_key_switch - 0);
  integer1 OH_foreign_corp_key_shift0 := ROUND(Specificities[1].OH_foreign_corp_key_specificity - 0);
  integer2 OH_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].OH_foreign_corp_key_switch - 0);
  integer1 OK_foreign_corp_key_shift0 := ROUND(Specificities[1].OK_foreign_corp_key_specificity - 27);
  integer2 OK_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].OK_foreign_corp_key_switch - 0);
  integer1 OR_foreign_corp_key_shift0 := ROUND(Specificities[1].OR_foreign_corp_key_specificity - 26);
  integer2 OR_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].OR_foreign_corp_key_switch - 1);
  integer1 PA_foreign_corp_key_shift0 := ROUND(Specificities[1].PA_foreign_corp_key_specificity - 27);
  integer2 PA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].PA_foreign_corp_key_switch - 0);
  integer1 PR_foreign_corp_key_shift0 := ROUND(Specificities[1].PR_foreign_corp_key_specificity - 0);
  integer2 PR_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].PR_foreign_corp_key_switch - 0);
  integer1 RI_foreign_corp_key_shift0 := ROUND(Specificities[1].RI_foreign_corp_key_specificity - 26);
  integer2 RI_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].RI_foreign_corp_key_switch - 0);
  integer1 SC_foreign_corp_key_shift0 := ROUND(Specificities[1].SC_foreign_corp_key_specificity - 27);
  integer2 SC_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].SC_foreign_corp_key_switch - 0);
  integer1 SD_foreign_corp_key_shift0 := ROUND(Specificities[1].SD_foreign_corp_key_specificity - 27);
  integer2 SD_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].SD_foreign_corp_key_switch - 0);
  integer1 TN_foreign_corp_key_shift0 := ROUND(Specificities[1].TN_foreign_corp_key_specificity - 27);
  integer2 TN_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].TN_foreign_corp_key_switch - 0);
  integer1 TX_foreign_corp_key_shift0 := ROUND(Specificities[1].TX_foreign_corp_key_specificity - 24);
  integer2 TX_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].TX_foreign_corp_key_switch - 1);
  integer1 UT_foreign_corp_key_shift0 := ROUND(Specificities[1].UT_foreign_corp_key_specificity - 26);
  integer2 UT_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].UT_foreign_corp_key_switch - 5);
  integer1 VA_foreign_corp_key_shift0 := ROUND(Specificities[1].VA_foreign_corp_key_specificity - 25);
  integer2 VA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].VA_foreign_corp_key_switch - 0);
  integer1 VI_foreign_corp_key_shift0 := ROUND(Specificities[1].VI_foreign_corp_key_specificity - 0);
  integer2 VI_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].VI_foreign_corp_key_switch - 0);
  integer1 VT_foreign_corp_key_shift0 := ROUND(Specificities[1].VT_foreign_corp_key_specificity - 27);
  integer2 VT_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].VT_foreign_corp_key_switch - 0);
  integer1 WA_foreign_corp_key_shift0 := ROUND(Specificities[1].WA_foreign_corp_key_specificity - 26);
  integer2 WA_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].WA_foreign_corp_key_switch - 28);
  integer1 WI_foreign_corp_key_shift0 := ROUND(Specificities[1].WI_foreign_corp_key_specificity - 28);
  integer2 WI_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].WI_foreign_corp_key_switch - 0);
  integer1 WV_foreign_corp_key_shift0 := ROUND(Specificities[1].WV_foreign_corp_key_specificity - 26);
  integer2 WV_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].WV_foreign_corp_key_switch - 4);
  integer1 WY_foreign_corp_key_shift0 := ROUND(Specificities[1].WY_foreign_corp_key_specificity - 26);
  integer2 WY_foreign_corp_key_switch_shift0 := ROUND(1000*Specificities[1].WY_foreign_corp_key_switch - 2);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT26.MAC_Specificity_Values(cnp_name_values_persisted,cnp_name,'cnp_name',cnp_name_specificity,cnp_name_specificity_profile);
  SALT26.MAC_Specificity_Values(cnp_number_values_persisted,cnp_number,'cnp_number',cnp_number_specificity,cnp_number_specificity_profile);
  SALT26.MAC_Specificity_Values(cnp_btype_values_persisted,cnp_btype,'cnp_btype',cnp_btype_specificity,cnp_btype_specificity_profile);
  SALT26.MAC_Specificity_Values(company_fein_values_persisted,company_fein,'company_fein',company_fein_specificity,company_fein_specificity_profile);
  SALT26.MAC_Specificity_Values(company_phone_values_persisted,company_phone,'company_phone',company_phone_specificity,company_phone_specificity_profile);
  SALT26.MAC_Specificity_Values(iscorp_values_persisted,iscorp,'iscorp',iscorp_specificity,iscorp_specificity_profile);
  SALT26.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT26.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT26.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT26.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT26.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT26.MAC_Specificity_Values(zip_values_persisted,zip,'zip',zip_specificity,zip_specificity_profile);
  SALT26.MAC_Specificity_Values(active_duns_number_values_persisted,active_duns_number,'active_duns_number',active_duns_number_specificity,active_duns_number_specificity_profile);
  SALT26.MAC_Specificity_Values(active_enterprise_number_values_persisted,active_enterprise_number,'active_enterprise_number',active_enterprise_number_specificity,active_enterprise_number_specificity_profile);
  SALT26.MAC_Specificity_Values(hist_enterprise_number_values_persisted,hist_enterprise_number,'hist_enterprise_number',hist_enterprise_number_specificity,hist_enterprise_number_specificity_profile);
  SALT26.MAC_Specificity_Values(hist_duns_number_values_persisted,hist_duns_number,'hist_duns_number',hist_duns_number_specificity,hist_duns_number_specificity_profile);
  SALT26.MAC_Specificity_Values(ebr_file_number_values_persisted,ebr_file_number,'ebr_file_number',ebr_file_number_specificity,ebr_file_number_specificity_profile);
  SALT26.MAC_Specificity_Values(domestic_corp_key_values_persisted,domestic_corp_key,'domestic_corp_key',domestic_corp_key_specificity,domestic_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(AK_foreign_corp_key_values_persisted,AK_foreign_corp_key,'AK_foreign_corp_key',AK_foreign_corp_key_specificity,AK_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(AL_foreign_corp_key_values_persisted,AL_foreign_corp_key,'AL_foreign_corp_key',AL_foreign_corp_key_specificity,AL_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(AR_foreign_corp_key_values_persisted,AR_foreign_corp_key,'AR_foreign_corp_key',AR_foreign_corp_key_specificity,AR_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(AZ_foreign_corp_key_values_persisted,AZ_foreign_corp_key,'AZ_foreign_corp_key',AZ_foreign_corp_key_specificity,AZ_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(CA_foreign_corp_key_values_persisted,CA_foreign_corp_key,'CA_foreign_corp_key',CA_foreign_corp_key_specificity,CA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(CO_foreign_corp_key_values_persisted,CO_foreign_corp_key,'CO_foreign_corp_key',CO_foreign_corp_key_specificity,CO_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(CT_foreign_corp_key_values_persisted,CT_foreign_corp_key,'CT_foreign_corp_key',CT_foreign_corp_key_specificity,CT_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(DC_foreign_corp_key_values_persisted,DC_foreign_corp_key,'DC_foreign_corp_key',DC_foreign_corp_key_specificity,DC_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(DE_foreign_corp_key_values_persisted,DE_foreign_corp_key,'DE_foreign_corp_key',DE_foreign_corp_key_specificity,DE_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(FL_foreign_corp_key_values_persisted,FL_foreign_corp_key,'FL_foreign_corp_key',FL_foreign_corp_key_specificity,FL_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(GA_foreign_corp_key_values_persisted,GA_foreign_corp_key,'GA_foreign_corp_key',GA_foreign_corp_key_specificity,GA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(HI_foreign_corp_key_values_persisted,HI_foreign_corp_key,'HI_foreign_corp_key',HI_foreign_corp_key_specificity,HI_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(IA_foreign_corp_key_values_persisted,IA_foreign_corp_key,'IA_foreign_corp_key',IA_foreign_corp_key_specificity,IA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(ID_foreign_corp_key_values_persisted,ID_foreign_corp_key,'ID_foreign_corp_key',ID_foreign_corp_key_specificity,ID_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(IL_foreign_corp_key_values_persisted,IL_foreign_corp_key,'IL_foreign_corp_key',IL_foreign_corp_key_specificity,IL_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(IN_foreign_corp_key_values_persisted,IN_foreign_corp_key,'IN_foreign_corp_key',IN_foreign_corp_key_specificity,IN_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(KS_foreign_corp_key_values_persisted,KS_foreign_corp_key,'KS_foreign_corp_key',KS_foreign_corp_key_specificity,KS_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(KY_foreign_corp_key_values_persisted,KY_foreign_corp_key,'KY_foreign_corp_key',KY_foreign_corp_key_specificity,KY_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(LA_foreign_corp_key_values_persisted,LA_foreign_corp_key,'LA_foreign_corp_key',LA_foreign_corp_key_specificity,LA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MA_foreign_corp_key_values_persisted,MA_foreign_corp_key,'MA_foreign_corp_key',MA_foreign_corp_key_specificity,MA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MD_foreign_corp_key_values_persisted,MD_foreign_corp_key,'MD_foreign_corp_key',MD_foreign_corp_key_specificity,MD_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(ME_foreign_corp_key_values_persisted,ME_foreign_corp_key,'ME_foreign_corp_key',ME_foreign_corp_key_specificity,ME_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MI_foreign_corp_key_values_persisted,MI_foreign_corp_key,'MI_foreign_corp_key',MI_foreign_corp_key_specificity,MI_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MN_foreign_corp_key_values_persisted,MN_foreign_corp_key,'MN_foreign_corp_key',MN_foreign_corp_key_specificity,MN_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MO_foreign_corp_key_values_persisted,MO_foreign_corp_key,'MO_foreign_corp_key',MO_foreign_corp_key_specificity,MO_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MS_foreign_corp_key_values_persisted,MS_foreign_corp_key,'MS_foreign_corp_key',MS_foreign_corp_key_specificity,MS_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(MT_foreign_corp_key_values_persisted,MT_foreign_corp_key,'MT_foreign_corp_key',MT_foreign_corp_key_specificity,MT_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NC_foreign_corp_key_values_persisted,NC_foreign_corp_key,'NC_foreign_corp_key',NC_foreign_corp_key_specificity,NC_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(ND_foreign_corp_key_values_persisted,ND_foreign_corp_key,'ND_foreign_corp_key',ND_foreign_corp_key_specificity,ND_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NE_foreign_corp_key_values_persisted,NE_foreign_corp_key,'NE_foreign_corp_key',NE_foreign_corp_key_specificity,NE_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NH_foreign_corp_key_values_persisted,NH_foreign_corp_key,'NH_foreign_corp_key',NH_foreign_corp_key_specificity,NH_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NJ_foreign_corp_key_values_persisted,NJ_foreign_corp_key,'NJ_foreign_corp_key',NJ_foreign_corp_key_specificity,NJ_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NM_foreign_corp_key_values_persisted,NM_foreign_corp_key,'NM_foreign_corp_key',NM_foreign_corp_key_specificity,NM_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NV_foreign_corp_key_values_persisted,NV_foreign_corp_key,'NV_foreign_corp_key',NV_foreign_corp_key_specificity,NV_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(NY_foreign_corp_key_values_persisted,NY_foreign_corp_key,'NY_foreign_corp_key',NY_foreign_corp_key_specificity,NY_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(OH_foreign_corp_key_values_persisted,OH_foreign_corp_key,'OH_foreign_corp_key',OH_foreign_corp_key_specificity,OH_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(OK_foreign_corp_key_values_persisted,OK_foreign_corp_key,'OK_foreign_corp_key',OK_foreign_corp_key_specificity,OK_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(OR_foreign_corp_key_values_persisted,OR_foreign_corp_key,'OR_foreign_corp_key',OR_foreign_corp_key_specificity,OR_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(PA_foreign_corp_key_values_persisted,PA_foreign_corp_key,'PA_foreign_corp_key',PA_foreign_corp_key_specificity,PA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(PR_foreign_corp_key_values_persisted,PR_foreign_corp_key,'PR_foreign_corp_key',PR_foreign_corp_key_specificity,PR_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(RI_foreign_corp_key_values_persisted,RI_foreign_corp_key,'RI_foreign_corp_key',RI_foreign_corp_key_specificity,RI_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(SC_foreign_corp_key_values_persisted,SC_foreign_corp_key,'SC_foreign_corp_key',SC_foreign_corp_key_specificity,SC_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(SD_foreign_corp_key_values_persisted,SD_foreign_corp_key,'SD_foreign_corp_key',SD_foreign_corp_key_specificity,SD_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(TN_foreign_corp_key_values_persisted,TN_foreign_corp_key,'TN_foreign_corp_key',TN_foreign_corp_key_specificity,TN_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(TX_foreign_corp_key_values_persisted,TX_foreign_corp_key,'TX_foreign_corp_key',TX_foreign_corp_key_specificity,TX_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(UT_foreign_corp_key_values_persisted,UT_foreign_corp_key,'UT_foreign_corp_key',UT_foreign_corp_key_specificity,UT_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(VA_foreign_corp_key_values_persisted,VA_foreign_corp_key,'VA_foreign_corp_key',VA_foreign_corp_key_specificity,VA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(VI_foreign_corp_key_values_persisted,VI_foreign_corp_key,'VI_foreign_corp_key',VI_foreign_corp_key_specificity,VI_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(VT_foreign_corp_key_values_persisted,VT_foreign_corp_key,'VT_foreign_corp_key',VT_foreign_corp_key_specificity,VT_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(WA_foreign_corp_key_values_persisted,WA_foreign_corp_key,'WA_foreign_corp_key',WA_foreign_corp_key_specificity,WA_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(WI_foreign_corp_key_values_persisted,WI_foreign_corp_key,'WI_foreign_corp_key',WI_foreign_corp_key_specificity,WI_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(WV_foreign_corp_key_values_persisted,WV_foreign_corp_key,'WV_foreign_corp_key',WV_foreign_corp_key_specificity,WV_foreign_corp_key_specificity_profile);
  SALT26.MAC_Specificity_Values(WY_foreign_corp_key_values_persisted,WY_foreign_corp_key,'WY_foreign_corp_key',WY_foreign_corp_key_specificity,WY_foreign_corp_key_specificity_profile);
EXPORT AllProfiles := cnp_name_specificity_profile + cnp_number_specificity_profile + cnp_btype_specificity_profile + company_fein_specificity_profile + company_phone_specificity_profile + iscorp_specificity_profile + prim_range_specificity_profile + prim_name_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip_specificity_profile + active_duns_number_specificity_profile + active_enterprise_number_specificity_profile + hist_enterprise_number_specificity_profile + hist_duns_number_specificity_profile + ebr_file_number_specificity_profile + domestic_corp_key_specificity_profile + AK_foreign_corp_key_specificity_profile + AL_foreign_corp_key_specificity_profile + AR_foreign_corp_key_specificity_profile + AZ_foreign_corp_key_specificity_profile + CA_foreign_corp_key_specificity_profile + CO_foreign_corp_key_specificity_profile + CT_foreign_corp_key_specificity_profile + DC_foreign_corp_key_specificity_profile + DE_foreign_corp_key_specificity_profile + FL_foreign_corp_key_specificity_profile + GA_foreign_corp_key_specificity_profile + HI_foreign_corp_key_specificity_profile + IA_foreign_corp_key_specificity_profile + ID_foreign_corp_key_specificity_profile + IL_foreign_corp_key_specificity_profile + IN_foreign_corp_key_specificity_profile + KS_foreign_corp_key_specificity_profile + KY_foreign_corp_key_specificity_profile + LA_foreign_corp_key_specificity_profile + MA_foreign_corp_key_specificity_profile + MD_foreign_corp_key_specificity_profile + ME_foreign_corp_key_specificity_profile + MI_foreign_corp_key_specificity_profile + MN_foreign_corp_key_specificity_profile + MO_foreign_corp_key_specificity_profile + MS_foreign_corp_key_specificity_profile + MT_foreign_corp_key_specificity_profile + NC_foreign_corp_key_specificity_profile + ND_foreign_corp_key_specificity_profile + NE_foreign_corp_key_specificity_profile + NH_foreign_corp_key_specificity_profile + NJ_foreign_corp_key_specificity_profile + NM_foreign_corp_key_specificity_profile + NV_foreign_corp_key_specificity_profile + NY_foreign_corp_key_specificity_profile + OH_foreign_corp_key_specificity_profile + OK_foreign_corp_key_specificity_profile + OR_foreign_corp_key_specificity_profile + PA_foreign_corp_key_specificity_profile + PR_foreign_corp_key_specificity_profile + RI_foreign_corp_key_specificity_profile + SC_foreign_corp_key_specificity_profile + SD_foreign_corp_key_specificity_profile + TN_foreign_corp_key_specificity_profile + TX_foreign_corp_key_specificity_profile + UT_foreign_corp_key_specificity_profile + VA_foreign_corp_key_specificity_profile + VI_foreign_corp_key_specificity_profile + VT_foreign_corp_key_specificity_profile + WA_foreign_corp_key_specificity_profile + WI_foreign_corp_key_specificity_profile + WV_foreign_corp_key_specificity_profile + WY_foreign_corp_key_specificity_profile;
END;
 
