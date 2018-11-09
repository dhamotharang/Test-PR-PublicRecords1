IMPORT SALT37;
EXPORT specificities(DATASET(layout_LocationId) ih) := MODULE
 
EXPORT ih_init := SALT37.initNullIDs.baseLevel(ih,rid,LocId);
 
SHARED h := ih_init;
 
EXPORT input_layout := RECORD // project out required fields
  SALT37.UIDType LocId := h.LocId; // using existing id field
  h.rid;//RIDfield 
  h.aid;
  h.prim_range;
  h.predir;
  h.prim_name;
  UNSIGNED1 prim_name_len := LENGTH(TRIM((SALT37.StrType)h.prim_name));
  h.addr_suffix;
  h.postdir;
  h.unit_desig;
  h.sec_range;
  h.v_city_name;
  h.st;
  h.zip5;
  h.rec_type;
  h.err_stat;
  h.cntprimname;
END;
r := input_layout;
 
h01 := DISTRIBUTE(TABLE(h(LocId<>0),r),HASH(LocId)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
  SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;
 
EXPORT input_file_np := h0; // No-persist version for remote_linking
 
EXPORT input_file := h0;
//We have LocId specified - so we can compute statistics on the cluster counts
  r0 := RECORD
    input_file.LocId;
    UNSIGNED6 InCluster := COUNT(GROUP);
  end;
EXPORT ClusterSizes := TABLE(input_file,r0,LocId,LOCAL);
EXPORT TotalClusters := COUNT(ClusterSizes);
 
EXPORT  prim_range_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,prim_range); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(prim_range_deduped,prim_range,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT prim_range_values_persisted_temp := specs_added;
 
EXPORT  predir_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,predir); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(predir_deduped,predir,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT predir_values_persisted_temp := specs_added;
 
EXPORT  prim_name_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,prim_name); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(prim_name_deduped,LocId,prim_name,1); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,prim_name,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  fuzzies_counted0 := with_id; // Place holder for fuzzy counting logic
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT37.mac_edit_distance_pairs(specs_added,prim_name,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT prim_name_values_persisted_temp := distance_computed;
 
EXPORT  addr_suffix_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,addr_suffix); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(addr_suffix_deduped,addr_suffix,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT addr_suffix_values_persisted_temp := specs_added;
 
EXPORT  postdir_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,postdir); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(postdir_deduped,postdir,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT postdir_values_persisted_temp := specs_added;
 
EXPORT  sec_range_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,sec_range); // Reduce to field values by UID
  expanded := SALT37.MAC_Field_Variants_Hyphen(sec_range_deduped,LocId,sec_range,1); // expand out all variants when hyphenated
  SALT37.Mac_Field_Count_UID(expanded,sec_range,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT sec_range_values_persisted_temp := specs_added;
 
EXPORT  v_city_name_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,v_city_name); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(v_city_name_deduped,v_city_name,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT v_city_name_values_persisted_temp := specs_added;
 
EXPORT  st_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,st); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(st_deduped,st,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT st_values_persisted_temp := specs_added;
 
EXPORT  zip5_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,zip5); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(zip5_deduped,zip5,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  SALT37.utMAC_Sequence_Records(with_id,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT zip5_values_persisted_temp := specs_added;
 
EXPORT  err_stat_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,err_stat); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(err_stat_deduped,err_stat,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  fuzzies_counted0 := with_id; // Place holder for fuzzy counting logic
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT err_stat_values_persisted_temp := specs_added;
 
EXPORT  cntprimname_deduped := SALT37.MAC_Field_By_UID(input_file,LocId,cntprimname); // Reduce to field values by UID
  SALT37.Mac_Field_Count_UID(cntprimname_deduped,cntprimname,LocId,counted,counted_clusters) // count the number of UIDs with each field value
  r1 := RECORD
    counted;
    UNSIGNED4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  fuzzies_counted0 := with_id; // Place holder for fuzzy counting logic
  SALT37.utMAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT37.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT cntprimname_values_persisted_temp := specs_added;
 
EXPORT prim_rangeValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::prim_range';
 
EXPORT prim_range_values_index := INDEX(prim_range_values_persisted_temp,{prim_range},{prim_range_values_persisted_temp},prim_rangeValuesIndexKeyName);
EXPORT prim_range_values_persisted := prim_range_values_index;
SALT37.MAC_Field_Nulls(prim_range_values_persisted,Layout_Specificities.prim_range_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_range_nulls := nv;
SALT37.MAC_Field_Bfoul(prim_range_deduped,prim_range,LocId,prim_range_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_range_switch := bf;
EXPORT prim_range_max := MAX(prim_range_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(prim_range_values_persisted,prim_range,prim_range_nulls,ol) // Compute column level specificity
EXPORT prim_range_specificity := ol;
 
EXPORT predirValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::predir';
 
EXPORT predir_values_index := INDEX(predir_values_persisted_temp,{predir},{predir_values_persisted_temp},predirValuesIndexKeyName);
EXPORT predir_values_persisted := predir_values_index;
SALT37.MAC_Field_Nulls(predir_values_persisted,Layout_Specificities.predir_ChildRec,nv) // Use automated NULL spotting
EXPORT predir_nulls := nv;
SALT37.MAC_Field_Bfoul(predir_deduped,predir,LocId,predir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT predir_switch := bf;
EXPORT predir_max := MAX(predir_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(predir_values_persisted,predir,predir_nulls,ol) // Compute column level specificity
EXPORT predir_specificity := ol;
 
EXPORT prim_nameValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::prim_name';
 
EXPORT prim_name_values_index := INDEX(prim_name_values_persisted_temp,{prim_name},{prim_name_values_persisted_temp},prim_nameValuesIndexKeyName);
EXPORT prim_name_values_persisted := prim_name_values_index;
SALT37.MAC_Field_Nulls(prim_name_values_persisted,Layout_Specificities.prim_name_ChildRec,nv) // Use automated NULL spotting
EXPORT prim_name_nulls := nv;
SALT37.MAC_Field_Bfoul(prim_name_deduped,prim_name,LocId,prim_name_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT prim_name_switch := bf;
EXPORT prim_name_max := MAX(prim_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(prim_name_values_persisted,prim_name,prim_name_nulls,ol) // Compute column level specificity
EXPORT prim_name_specificity := ol;
 
EXPORT addr_suffixValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::addr_suffix';
 
EXPORT addr_suffix_values_index := INDEX(addr_suffix_values_persisted_temp,{addr_suffix},{addr_suffix_values_persisted_temp},addr_suffixValuesIndexKeyName);
EXPORT addr_suffix_values_persisted := addr_suffix_values_index;
SALT37.MAC_Field_Nulls(addr_suffix_values_persisted,Layout_Specificities.addr_suffix_ChildRec,nv) // Use automated NULL spotting
EXPORT addr_suffix_nulls := nv;
SALT37.MAC_Field_Bfoul(addr_suffix_deduped,addr_suffix,LocId,addr_suffix_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT addr_suffix_switch := bf;
EXPORT addr_suffix_max := MAX(addr_suffix_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(addr_suffix_values_persisted,addr_suffix,addr_suffix_nulls,ol) // Compute column level specificity
EXPORT addr_suffix_specificity := ol;
 
EXPORT postdirValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::postdir';
 
EXPORT postdir_values_index := INDEX(postdir_values_persisted_temp,{postdir},{postdir_values_persisted_temp},postdirValuesIndexKeyName);
EXPORT postdir_values_persisted := postdir_values_index;
SALT37.MAC_Field_Nulls(postdir_values_persisted,Layout_Specificities.postdir_ChildRec,nv) // Use automated NULL spotting
EXPORT postdir_nulls := nv;
SALT37.MAC_Field_Bfoul(postdir_deduped,postdir,LocId,postdir_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT postdir_switch := bf;
EXPORT postdir_max := MAX(postdir_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(postdir_values_persisted,postdir,postdir_nulls,ol) // Compute column level specificity
EXPORT postdir_specificity := ol;
 
EXPORT sec_rangeValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::sec_range';
 
EXPORT sec_range_values_index := INDEX(sec_range_values_persisted_temp,{sec_range},{sec_range_values_persisted_temp},sec_rangeValuesIndexKeyName);
EXPORT sec_range_values_persisted := sec_range_values_index;
SALT37.MAC_Field_Nulls(sec_range_values_persisted,Layout_Specificities.sec_range_ChildRec,nv) // Use automated NULL spotting
EXPORT sec_range_nulls := nv;
SALT37.MAC_Field_Bfoul(sec_range_deduped,sec_range,LocId,sec_range_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT sec_range_switch := bf;
EXPORT sec_range_max := MAX(sec_range_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(sec_range_values_persisted,sec_range,sec_range_nulls,ol) // Compute column level specificity
EXPORT sec_range_specificity := ol;
 
EXPORT v_city_nameValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::v_city_name';
 
EXPORT v_city_name_values_index := INDEX(v_city_name_values_persisted_temp,{v_city_name},{v_city_name_values_persisted_temp},v_city_nameValuesIndexKeyName);
EXPORT v_city_name_values_persisted := v_city_name_values_index;
SALT37.MAC_Field_Nulls(v_city_name_values_persisted,Layout_Specificities.v_city_name_ChildRec,nv) // Use automated NULL spotting
EXPORT v_city_name_nulls := nv;
SALT37.MAC_Field_Bfoul(v_city_name_deduped,v_city_name,LocId,v_city_name_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT v_city_name_switch := bf;
EXPORT v_city_name_max := MAX(v_city_name_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(v_city_name_values_persisted,v_city_name,v_city_name_nulls,ol) // Compute column level specificity
EXPORT v_city_name_specificity := ol;
 
EXPORT stValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::st';
 
EXPORT st_values_index := INDEX(st_values_persisted_temp,{st},{st_values_persisted_temp},stValuesIndexKeyName);
EXPORT st_values_persisted := st_values_index;
EXPORT st_nulls := DATASET([{'',0,0}],Layout_Specificities.st_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(st_deduped,st,LocId,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT st_switch := bf;
EXPORT st_max := MAX(st_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
EXPORT st_specificity := ol;
 
EXPORT zip5ValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::zip5';
 
EXPORT zip5_values_index := INDEX(zip5_values_persisted_temp,{zip5},{zip5_values_persisted_temp},zip5ValuesIndexKeyName);
EXPORT zip5_values_persisted := zip5_values_index;
SALT37.MAC_Field_Nulls(zip5_values_persisted,Layout_Specificities.zip5_ChildRec,nv) // Use automated NULL spotting
EXPORT zip5_nulls := nv;
SALT37.MAC_Field_Bfoul(zip5_deduped,zip5,LocId,zip5_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT zip5_switch := bf;
EXPORT zip5_max := MAX(zip5_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(zip5_values_persisted,zip5,zip5_nulls,ol) // Compute column level specificity
EXPORT zip5_specificity := ol;
 
EXPORT err_statValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::err_stat';
 
EXPORT err_stat_values_index := INDEX(err_stat_values_persisted_temp,{err_stat},{err_stat_values_persisted_temp},err_statValuesIndexKeyName);
EXPORT err_stat_values_persisted := err_stat_values_index;
EXPORT err_stat_nulls := DATASET([{'',0,0}],Layout_Specificities.err_stat_ChildRec); // Automated null spotting not applicable
SALT37.MAC_Field_Bfoul(err_stat_deduped,err_stat,LocId,err_stat_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT err_stat_switch := bf;
EXPORT err_stat_max := MAX(err_stat_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(err_stat_values_persisted,err_stat,err_stat_nulls,ol) // Compute column level specificity
EXPORT err_stat_specificity := ol;
 
EXPORT cntprimnameValuesIndexKeyName := '~'+'key::LocationId_iLink::LocId::Word::cntprimname';
 
EXPORT cntprimname_values_index := INDEX(cntprimname_values_persisted_temp,{cntprimname},{cntprimname_values_persisted_temp},cntprimnameValuesIndexKeyName);
EXPORT cntprimname_values_persisted := cntprimname_values_index;
SALT37.MAC_Field_Nulls(cntprimname_values_persisted,Layout_Specificities.cntprimname_ChildRec,nv) // Use automated NULL spotting
EXPORT cntprimname_nulls := nv;
SALT37.MAC_Field_Bfoul(cntprimname_deduped,cntprimname,LocId,cntprimname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT cntprimname_switch := bf;
EXPORT cntprimname_max := MAX(cntprimname_values_persisted,field_specificity);
SALT37.MAC_Field_Specificity(cntprimname_values_persisted,cntprimname,cntprimname_nulls,ol) // Compute column level specificity
EXPORT cntprimname_specificity := ol;
 
EXPORT BuildFields := PARALLEL(BUILDINDEX(prim_range_values_index, OVERWRITE),BUILDINDEX(predir_values_index, OVERWRITE),BUILDINDEX(prim_name_values_index, OVERWRITE),BUILDINDEX(addr_suffix_values_index, OVERWRITE),BUILDINDEX(postdir_values_index, OVERWRITE),BUILDINDEX(sec_range_values_index, OVERWRITE),BUILDINDEX(v_city_name_values_index, OVERWRITE),BUILDINDEX(st_values_index, OVERWRITE),BUILDINDEX(zip5_values_index, OVERWRITE),BUILDINDEX(err_stat_values_index, OVERWRITE),BUILDINDEX(cntprimname_values_index, OVERWRITE));
EXPORT BuildAll := BuildFields;
 
EXPORT SpecIndexKeyName := '~'+'key::LocationId_iLink::LocId::Specificities';
iSpecificities := DATASET([{0,prim_range_specificity,prim_range_switch,prim_range_max,prim_range_nulls,predir_specificity,predir_switch,predir_max,predir_nulls,prim_name_specificity,prim_name_switch,prim_name_max,prim_name_nulls,addr_suffix_specificity,addr_suffix_switch,addr_suffix_max,addr_suffix_nulls,postdir_specificity,postdir_switch,postdir_max,postdir_nulls,sec_range_specificity,sec_range_switch,sec_range_max,sec_range_nulls,v_city_name_specificity,v_city_name_switch,v_city_name_max,v_city_name_nulls,st_specificity,st_switch,st_max,st_nulls,zip5_specificity,zip5_switch,zip5_max,zip5_nulls,err_stat_specificity,err_stat_switch,err_stat_max,err_stat_nulls,cntprimname_specificity,cntprimname_switch,cntprimname_max,cntprimname_nulls}],Layout_Specificities.R);
 
EXPORT Specificities_Index := INDEX(iSpecificities,{1},{iSpecificities},SpecIndexKeyName);
EXPORT Build := SEQUENTIAL ( BuildAll, BUILDINDEX(Specificities_Index, OVERWRITE, FEW) );
Layout_Specificities.R Into(Specificities_Index i) := TRANSFORM
  SELF := i;
END;
EXPORT Specificities := PROJECT(Specificities_Index,Into(LEFT));
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 prim_range_shift0 := ROUND(Specificities[1].prim_range_specificity - 13);
  integer2 prim_range_switch_shift0 := ROUND(1000*Specificities[1].prim_range_switch - 0);
  integer1 predir_shift0 := ROUND(Specificities[1].predir_specificity - 7);
  integer2 predir_switch_shift0 := ROUND(1000*Specificities[1].predir_switch - 0);
  integer1 prim_name_shift0 := ROUND(Specificities[1].prim_name_specificity - 14);
  integer2 prim_name_switch_shift0 := ROUND(1000*Specificities[1].prim_name_switch - 0);
  integer1 addr_suffix_shift0 := ROUND(Specificities[1].addr_suffix_specificity - 4);
  integer2 addr_suffix_switch_shift0 := ROUND(1000*Specificities[1].addr_suffix_switch - 0);
  integer1 postdir_shift0 := ROUND(Specificities[1].postdir_specificity - 6);
  integer2 postdir_switch_shift0 := ROUND(1000*Specificities[1].postdir_switch - 0);
  integer1 sec_range_shift0 := ROUND(Specificities[1].sec_range_specificity - 14);
  integer2 sec_range_switch_shift0 := ROUND(1000*Specificities[1].sec_range_switch - 0);
  integer1 v_city_name_shift0 := ROUND(Specificities[1].v_city_name_specificity - 7);
  integer2 v_city_name_switch_shift0 := ROUND(1000*Specificities[1].v_city_name_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 1);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip5_shift0 := ROUND(Specificities[1].zip5_specificity - 9);
  integer2 zip5_switch_shift0 := ROUND(1000*Specificities[1].zip5_switch - 0);
  integer1 err_stat_shift0 := ROUND(Specificities[1].err_stat_specificity - 3);
  integer2 err_stat_switch_shift0 := ROUND(1000*Specificities[1].err_stat_switch - 0);
  integer1 cntprimname_shift0 := ROUND(Specificities[1].cntprimname_specificity - 10);
  integer2 cntprimname_switch_shift0 := ROUND(1000*Specificities[1].cntprimname_switch - 0);
  END;
 
EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
  SALT37.MAC_Specificity_Values(prim_range_values_persisted,prim_range,'prim_range',prim_range_specificity,prim_range_specificity_profile);
  SALT37.MAC_Specificity_Values(predir_values_persisted,predir,'predir',predir_specificity,predir_specificity_profile);
  SALT37.MAC_Specificity_Values(prim_name_values_persisted,prim_name,'prim_name',prim_name_specificity,prim_name_specificity_profile);
  SALT37.MAC_Specificity_Values(addr_suffix_values_persisted,addr_suffix,'addr_suffix',addr_suffix_specificity,addr_suffix_specificity_profile);
  SALT37.MAC_Specificity_Values(postdir_values_persisted,postdir,'postdir',postdir_specificity,postdir_specificity_profile);
  SALT37.MAC_Specificity_Values(sec_range_values_persisted,sec_range,'sec_range',sec_range_specificity,sec_range_specificity_profile);
  SALT37.MAC_Specificity_Values(v_city_name_values_persisted,v_city_name,'v_city_name',v_city_name_specificity,v_city_name_specificity_profile);
  SALT37.MAC_Specificity_Values(st_values_persisted,st,'st',st_specificity,st_specificity_profile);
  SALT37.MAC_Specificity_Values(zip5_values_persisted,zip5,'zip5',zip5_specificity,zip5_specificity_profile);
  SALT37.MAC_Specificity_Values(err_stat_values_persisted,err_stat,'err_stat',err_stat_specificity,err_stat_specificity_profile);
  SALT37.MAC_Specificity_Values(cntprimname_values_persisted,cntprimname,'cntprimname',cntprimname_specificity,cntprimname_specificity_profile);
EXPORT AllProfiles := prim_range_specificity_profile + predir_specificity_profile + prim_name_specificity_profile + addr_suffix_specificity_profile + postdir_specificity_profile + sec_range_specificity_profile + v_city_name_specificity_profile + st_specificity_profile + zip5_specificity_profile + err_stat_specificity_profile + cntprimname_specificity_profile;
END;
 
