import ut,SALT20;
export specificities(dataset(layout_PersonHeader) h) := MODULE
import PersonLinkingADL2; // Import modules for  attribute definitions
export input_layout := record // project out required fields
  SALT20.UIDType DID := h.DID; // using existing id field
  h.NAME_SUFFIX;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  typeof(h.CITY) CITY := if ( Fields.Invalid_CITY(h.CITY)=0,h.CITY,(typeof(h.CITY))'' ); // Blanks if invalid
  h.STATE;
  h.ZIP;
  h.ZIP4;
  h.COUNTY;
  h.SSN5;
  h.SSN4;
  unsigned2 DOB_year := ((unsigned)h.DOB) div 10000;
  unsigned1 DOB_month := (((unsigned)h.DOB) div 100 ) % 100;
  unsigned1 DOB_day := ((unsigned)h.DOB) % 100;
  h.PHONE;
  unsigned4 MAINNAME := 0; // Place holder filled in by project
  unsigned4 FULLNAME := 0; // Place holder filled in by project
  unsigned4 ADDR1 := 0; // Place holder filled in by project
  unsigned4 LOCALE := 0; // Place holder filled in by project
  unsigned4 ADDRS := 0; // Place holder filled in by project
END;
r := input_layout;
h01 := distribute(table(h,r),hash(DID)); // group for the specificity_local function
input_layout do_computes(h01 le) := transform
  self.MAINNAME := hash32((string)le.FNAME,(string)le.MNAME,(string)le.LNAME); // Combine child fields into 1 for specificity counting
  self.FULLNAME := hash32((string)self.MAINNAME,(string)le.NAME_SUFFIX); // Combine child fields into 1 for specificity counting
  self.ADDR1 := hash32((string)le.PRIM_RANGE,(string)le.PRIM_NAME,(string)le.SEC_RANGE,(string)le.ZIP4); // Combine child fields into 1 for specificity counting
  self.LOCALE := hash32((string)le.COUNTY,(string)le.CITY,(string)le.STATE,(string)le.ZIP); // Combine child fields into 1 for specificity counting
  self.ADDRS := hash32((string)self.ADDR1,(string)self.LOCALE); // Combine child fields into 1 for specificity counting
  self := le;
end;
shared h0 := project(h01,do_computes(left));
export input_file_np := h0; // No-persist version for remote_linking
export input_file := h0  : persist('temp::DID::PRTE_PersonLinkingADL2V3::Specificities_Cache');
//We have DID specified - so we can compute statistics on the cluster counts
  r0 := record
    input_file.DID;
    unsigned6 InCluster := count(group);
  end;
export ClusterSizes := table(input_file,r0,DID,local)  : persist('temp::DID::PRTE_PersonLinkingADL2V3::Cluster_Sizes');
shared  NAME_SUFFIX_deduped := SALT20.MAC_Field_By_UID(input_file,DID,NAME_SUFFIX) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_NAME_SUFFIX'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(NAME_SUFFIX_deduped,NAME_SUFFIX,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,NAME_SUFFIX,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
export NAME_SUFFIX_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_NAME_SUFFIX');
export NAME_SUFFIX_nulls := dataset([{'',0,0}],Layout_Specificities.NAME_SUFFIX_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(NAME_SUFFIX_deduped,NAME_SUFFIX,DID,NAME_SUFFIX_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export NAME_SUFFIX_switch := bf;
export NAME_SUFFIX_max := MAX(NAME_SUFFIX_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(NAME_SUFFIX_values_persisted,NAME_SUFFIX,NAME_SUFFIX_nulls,ol) // Compute column level specificity
export NAME_SUFFIX_specificity := ol;
shared  FNAME_deduped := SALT20.MAC_Field_By_UID(input_file,DID,FNAME) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_FNAME'); // Reduce to field values by UID
  SALT20.MAC_Field_Variants_Initials(FNAME_deduped,DID,FNAME,expanded) // expand out all variants of initial
  SALT20.Mac_Field_Count_UID(expanded,FNAME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
    STRING20 FNAME_PreferredName := PersonLinkingADL2.FNPreferName(counted.FNAME); // Compute PersonLinkingADL2.FNPreferName value for FNAME
  end;
  with_id := table(counted,r1);
  SALT20.MAC_Field_Accumulate_Counts(with_id,FNAME_PreferredName,PreferredName_cnt,fuzzies_counted0)
  ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,FNAME,cnt,2,true,distance_computed);//Computes specificities of fuzzy matches
export FNAME_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_FNAME');
export FNAME_nulls := dataset([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(FNAME_deduped,FNAME,DID,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
export FNAME_switch := bf;
export FNAME_max := MAX(FNAME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(FNAME_values_persisted,FNAME,FNAME_nulls,ol) // Compute column level specificity
export FNAME_specificity := ol;
shared  MNAME_deduped := SALT20.MAC_Field_By_UID(input_file,DID,MNAME) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_MNAME'); // Reduce to field values by UID
  SALT20.MAC_Field_Variants_Initials(MNAME_deduped,DID,MNAME,expanded) // expand out all variants of initial
  SALT20.Mac_Field_Count_UID(expanded,MNAME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,MNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
export MNAME_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_MNAME');
export MNAME_nulls := dataset([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(MNAME_deduped,MNAME,DID,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
export MNAME_switch := bf;
export MNAME_max := MAX(MNAME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(MNAME_values_persisted,MNAME,MNAME_nulls,ol) // Compute column level specificity
export MNAME_specificity := ol;
shared  LNAME_deduped := SALT20.MAC_Field_By_UID(input_file,DID,LNAME) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_LNAME'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(LNAME_deduped,LNAME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,LNAME,cnt,2,true,distance_computed);//Computes specificities of fuzzy matches
export LNAME_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_LNAME');
SALT20.MAC_Field_Nulls(LNAME_values_persisted,Layout_Specificities.LNAME_ChildRec,nv) // Use automated NULL spotting
export LNAME_nulls := nv;
SALT20.MAC_Field_Bfoul(LNAME_deduped,LNAME,DID,LNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export LNAME_switch := bf;
export LNAME_max := MAX(LNAME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(LNAME_values_persisted,LNAME,LNAME_nulls,ol) // Compute column level specificity
export LNAME_specificity := ol;
shared  PRIM_RANGE_deduped := SALT20.MAC_Field_By_UID(input_file,DID,PRIM_RANGE) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_PRIM_RANGE'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,PRIM_RANGE,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export PRIM_RANGE_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_PRIM_RANGE');
SALT20.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
export PRIM_RANGE_nulls := nv;
SALT20.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,DID,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export PRIM_RANGE_switch := bf;
export PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
export PRIM_RANGE_specificity := ol;
shared  PRIM_NAME_deduped := SALT20.MAC_Field_By_UID(input_file,DID,PRIM_NAME) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_PRIM_NAME'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,PRIM_NAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export PRIM_NAME_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_PRIM_NAME');
SALT20.MAC_Field_Nulls(PRIM_NAME_values_persisted,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
export PRIM_NAME_nulls := nv;
SALT20.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,DID,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export PRIM_NAME_switch := bf;
export PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
export PRIM_NAME_specificity := ol;
shared  SEC_RANGE_deduped := SALT20.MAC_Field_By_UID(input_file,DID,SEC_RANGE) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_SEC_RANGE'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(SEC_RANGE_deduped,SEC_RANGE,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export SEC_RANGE_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_SEC_RANGE');
SALT20.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
export SEC_RANGE_nulls := nv;
SALT20.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,DID,SEC_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export SEC_RANGE_switch := bf;
export SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
export SEC_RANGE_specificity := ol;
shared  CITY_deduped := SALT20.MAC_Field_By_UID(input_file,DID,CITY) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_CITY'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(CITY_deduped,CITY,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export CITY_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_CITY');
SALT20.MAC_Field_Nulls(CITY_values_persisted,Layout_Specificities.CITY_ChildRec,nv) // Use automated NULL spotting
export CITY_nulls := nv;
SALT20.MAC_Field_Bfoul(CITY_deduped,CITY,DID,CITY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export CITY_switch := bf;
export CITY_max := MAX(CITY_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(CITY_values_persisted,CITY,CITY_nulls,ol) // Compute column level specificity
export CITY_specificity := ol;
shared  STATE_deduped := SALT20.MAC_Field_By_UID(input_file,DID,STATE) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_STATE'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(STATE_deduped,STATE,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export STATE_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_STATE');
SALT20.MAC_Field_Nulls(STATE_values_persisted,Layout_Specificities.STATE_ChildRec,nv) // Use automated NULL spotting
export STATE_nulls := nv;
SALT20.MAC_Field_Bfoul(STATE_deduped,STATE,DID,STATE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export STATE_switch := bf;
export STATE_max := MAX(STATE_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(STATE_values_persisted,STATE,STATE_nulls,ol) // Compute column level specificity
export STATE_specificity := ol;
shared  ZIP_deduped := SALT20.MAC_Field_By_UID(input_file,DID,ZIP) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_ZIP'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(ZIP_deduped,ZIP,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export ZIP_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_ZIP');
SALT20.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
export ZIP_nulls := nv;
SALT20.MAC_Field_Bfoul(ZIP_deduped,ZIP,DID,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export ZIP_switch := bf;
export ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
export ZIP_specificity := ol;
shared  ZIP4_deduped := SALT20.MAC_Field_By_UID(input_file,DID,ZIP4) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_ZIP4'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(ZIP4_deduped,ZIP4,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export ZIP4_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_ZIP4');
SALT20.MAC_Field_Nulls(ZIP4_values_persisted,Layout_Specificities.ZIP4_ChildRec,nv) // Use automated NULL spotting
export ZIP4_nulls := nv;
SALT20.MAC_Field_Bfoul(ZIP4_deduped,ZIP4,DID,ZIP4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export ZIP4_switch := bf;
export ZIP4_max := MAX(ZIP4_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(ZIP4_values_persisted,ZIP4,ZIP4_nulls,ol) // Compute column level specificity
export ZIP4_specificity := ol;
shared  COUNTY_deduped := SALT20.MAC_Field_By_UID(input_file,DID,COUNTY) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_COUNTY'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(COUNTY_deduped,COUNTY,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export COUNTY_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_COUNTY');
SALT20.MAC_Field_Nulls(COUNTY_values_persisted,Layout_Specificities.COUNTY_ChildRec,nv) // Use automated NULL spotting
export COUNTY_nulls := nv;
SALT20.MAC_Field_Bfoul(COUNTY_deduped,COUNTY,DID,COUNTY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export COUNTY_switch := bf;
export COUNTY_max := MAX(COUNTY_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(COUNTY_values_persisted,COUNTY,COUNTY_nulls,ol) // Compute column level specificity
export COUNTY_specificity := ol;
shared  SSN5_deduped := SALT20.MAC_Field_By_UID(input_file,DID,SSN5) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_SSN5'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(SSN5_deduped,SSN5,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,SSN5,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export SSN5_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_SSN5');
SALT20.MAC_Field_Nulls(SSN5_values_persisted,Layout_Specificities.SSN5_ChildRec,nv) // Use automated NULL spotting
export SSN5_nulls := nv;
SALT20.MAC_Field_Bfoul(SSN5_deduped,SSN5,DID,SSN5_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export SSN5_switch := bf;
export SSN5_max := MAX(SSN5_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(SSN5_values_persisted,SSN5,SSN5_nulls,ol) // Compute column level specificity
export SSN5_specificity := ol;
shared  SSN4_deduped := SALT20.MAC_Field_By_UID(input_file,DID,SSN4) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_SSN4'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(SSN4_deduped,SSN4,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
  SALT20.mac_edit_distance_pairs(specs_added,SSN4,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
export SSN4_values_persisted := distance_computed : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_SSN4');
SALT20.MAC_Field_Nulls(SSN4_values_persisted,Layout_Specificities.SSN4_ChildRec,nv) // Use automated NULL spotting
export SSN4_nulls := nv;
SALT20.MAC_Field_Bfoul(SSN4_deduped,SSN4,DID,SSN4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export SSN4_switch := bf;
export SSN4_max := MAX(SSN4_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(SSN4_values_persisted,SSN4,SSN4_nulls,ol) // Compute column level specificity
export SSN4_specificity := ol;
shared  DOB_year_deduped := SALT20.MAC_Field_By_UID(input_file,DID,DOB_year) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_DOB_year'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export DOB_year_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_DOB_year');
SALT20.MAC_Field_Nulls(DOB_year_values_persisted,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
export DOB_year_nulls := nv;
SALT20.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,DID,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export DOB_year_switch := bf;
export DOB_year_max := MAX(DOB_year_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(DOB_year_values_persisted,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
export DOB_year_specificity := ol;
shared  DOB_month_deduped := SALT20.MAC_Field_By_UID(input_file,DID,DOB_month) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_DOB_month'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export DOB_month_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_DOB_month');
SALT20.MAC_Field_Nulls(DOB_month_values_persisted,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
export DOB_month_nulls := nv;
SALT20.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,DID,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export DOB_month_switch := bf;
export DOB_month_max := MAX(DOB_month_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(DOB_month_values_persisted,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
export DOB_month_specificity := ol;
shared  DOB_day_deduped := SALT20.MAC_Field_By_UID(input_file,DID,DOB_day) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_DOB_day'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export DOB_day_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_DOB_day');
SALT20.MAC_Field_Nulls(DOB_day_values_persisted,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
export DOB_day_nulls := nv;
SALT20.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,DID,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export DOB_day_switch := bf;
export DOB_day_max := MAX(DOB_day_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(DOB_day_values_persisted,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
export DOB_day_specificity := ol;
shared  PHONE_deduped := SALT20.MAC_Field_By_UID(input_file,DID,PHONE) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_PHONE'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(PHONE_deduped,PHONE,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export PHONE_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_PHONE');
SALT20.MAC_Field_Nulls(PHONE_values_persisted,Layout_Specificities.PHONE_ChildRec,nv) // Use automated NULL spotting
export PHONE_nulls := nv;
SALT20.MAC_Field_Bfoul(PHONE_deduped,PHONE,DID,PHONE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export PHONE_switch := bf;
export PHONE_max := MAX(PHONE_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(PHONE_values_persisted,PHONE,PHONE_nulls,ol) // Compute column level specificity
export PHONE_specificity := ol;
shared  MAINNAME_deduped := SALT20.MAC_Field_By_UID(input_file,DID,MAINNAME) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_MAINNAME'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export MAINNAME_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_MAINNAME');
SALT20.MAC_Field_Nulls(MAINNAME_values_persisted,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
export MAINNAME_nulls := nv;
SALT20.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,DID,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export MAINNAME_switch := bf;
export MAINNAME_max := MAX(MAINNAME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(MAINNAME_values_persisted,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
export MAINNAME_specificity := ol;
shared  FULLNAME_deduped := SALT20.MAC_Field_By_UID(input_file,DID,FULLNAME) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_FULLNAME'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export FULLNAME_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_FULLNAME');
SALT20.MAC_Field_Nulls(FULLNAME_values_persisted,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
export FULLNAME_nulls := nv;
SALT20.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,DID,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export FULLNAME_switch := bf;
export FULLNAME_max := MAX(FULLNAME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(FULLNAME_values_persisted,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
export FULLNAME_specificity := ol;
shared  ADDR1_deduped := SALT20.MAC_Field_By_UID(input_file,DID,ADDR1) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_ADDR1'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(ADDR1_deduped,ADDR1,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export ADDR1_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_ADDR1');
SALT20.MAC_Field_Nulls(ADDR1_values_persisted,Layout_Specificities.ADDR1_ChildRec,nv) // Use automated NULL spotting
export ADDR1_nulls := nv;
SALT20.MAC_Field_Bfoul(ADDR1_deduped,ADDR1,DID,ADDR1_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export ADDR1_switch := bf;
export ADDR1_max := MAX(ADDR1_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(ADDR1_values_persisted,ADDR1,ADDR1_nulls,ol) // Compute column level specificity
export ADDR1_specificity := ol;
shared  LOCALE_deduped := SALT20.MAC_Field_By_UID(input_file,DID,LOCALE) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_LOCALE'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export LOCALE_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_LOCALE');
SALT20.MAC_Field_Nulls(LOCALE_values_persisted,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
export LOCALE_nulls := nv;
SALT20.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,DID,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export LOCALE_switch := bf;
export LOCALE_max := MAX(LOCALE_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(LOCALE_values_persisted,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
export LOCALE_specificity := ol;
shared  ADDRS_deduped := SALT20.MAC_Field_By_UID(input_file,DID,ADDRS) : persist('temp::dedups::PRTE_PersonLinkingADL2V3_DID_ADDRS'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(ADDRS_deduped,ADDRS,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export ADDRS_values_persisted := specs_added : persist('temp::values::PRTE_PersonLinkingADL2V3_DID_ADDRS');
SALT20.MAC_Field_Nulls(ADDRS_values_persisted,Layout_Specificities.ADDRS_ChildRec,nv) // Use automated NULL spotting
export ADDRS_nulls := nv;
SALT20.MAC_Field_Bfoul(ADDRS_deduped,ADDRS,DID,ADDRS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export ADDRS_switch := bf;
export ADDRS_max := MAX(ADDRS_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(ADDRS_values_persisted,ADDRS,ADDRS_nulls,ol) // Compute column level specificity
export ADDRS_specificity := ol;
iSpecificities := dataset([{0,NAME_SUFFIX_specificity,NAME_SUFFIX_switch,NAME_SUFFIX_max,NAME_SUFFIX_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,CITY_specificity,CITY_switch,CITY_max,CITY_nulls,STATE_specificity,STATE_switch,STATE_max,STATE_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,ZIP4_specificity,ZIP4_switch,ZIP4_max,ZIP4_nulls,COUNTY_specificity,COUNTY_switch,COUNTY_max,COUNTY_nulls,SSN5_specificity,SSN5_switch,SSN5_max,choosen(SSN5_nulls,3),SSN4_specificity,SSN4_switch,SSN4_max,SSN4_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,PHONE_specificity,PHONE_switch,PHONE_max,PHONE_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_max,ADDR1_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRS_specificity,ADDRS_switch,ADDRS_max,ADDRS_nulls}],Layout_Specificities.R) : persist('PRTE_PersonLinkingADL2V3::DID::Specificities');
export Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 NAME_SUFFIX_shift0 := ROUND(Specificities[1].NAME_SUFFIX_specificity - 2);
  integer2 NAME_SUFFIX_switch_shift0 := ROUND(1000*Specificities[1].NAME_SUFFIX_switch - 0);
  integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 9);
  integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 0);
  integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 7);
  integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 0);
  integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 11);
  integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 0);
  integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 11);
  integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 0);
  integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 11);
  integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 0);
  integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 7);
  integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 0);
  integer1 CITY_shift0 := ROUND(Specificities[1].CITY_specificity - 10);
  integer2 CITY_switch_shift0 := ROUND(1000*Specificities[1].CITY_switch - 0);
  integer1 STATE_shift0 := ROUND(Specificities[1].STATE_specificity - 5);
  integer2 STATE_switch_shift0 := ROUND(1000*Specificities[1].STATE_switch - 0);
  integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 13);
  integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 0);
  integer1 ZIP4_shift0 := ROUND(Specificities[1].ZIP4_specificity - 12);
  integer2 ZIP4_switch_shift0 := ROUND(1000*Specificities[1].ZIP4_switch - 0);
  integer1 COUNTY_shift0 := ROUND(Specificities[1].COUNTY_specificity - 6);
  integer2 COUNTY_switch_shift0 := ROUND(1000*Specificities[1].COUNTY_switch - 0);
  integer1 SSN5_shift0 := ROUND(Specificities[1].SSN5_specificity - 15);
  integer2 SSN5_switch_shift0 := ROUND(1000*Specificities[1].SSN5_switch - 0);
  integer1 SSN4_shift0 := ROUND(Specificities[1].SSN4_specificity - 13);
  integer2 SSN4_switch_shift0 := ROUND(1000*Specificities[1].SSN4_switch - 0);
  integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 15);
// Not sure what to do amount a DATE switch yet - MAX of all? 
  integer1 PHONE_shift0 := ROUND(Specificities[1].PHONE_specificity - 27);
  integer2 PHONE_switch_shift0 := ROUND(1000*Specificities[1].PHONE_switch - 0);
  integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 22);
  integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 0);
  integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 22);
  integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 0);
  integer1 ADDR1_shift0 := ROUND(Specificities[1].ADDR1_specificity - 18);
  integer2 ADDR1_switch_shift0 := ROUND(1000*Specificities[1].ADDR1_switch - 0);
  integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 14);
  integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 0);
  integer1 ADDRS_shift0 := ROUND(Specificities[1].ADDRS_specificity - 23);
  integer2 ADDRS_switch_shift0 := ROUND(1000*Specificities[1].ADDRS_switch - 0);
  end;
export SpcShift := table(Specificities,SpcShiftR);
end;
