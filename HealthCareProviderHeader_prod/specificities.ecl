IMPORT ut,SALT27;
EXPORT specificities(DATASET(layout_HealthProvider) h) := MODULE

EXPORT input_layout := RECORD // project out required fields
SALT27.UIDType LNPID := h.LNPID; // using existing id field
h.RID;//RIDfield
UNSIGNED1 data_permits := fn_sources(h.SRC); // Pre-compute permissions for every field
UNSIGNED2 DOB_year := ((UNSIGNED)h.DOB) DIV 10000;
UNSIGNED1 DOB_month := (((UNSIGNED)h.DOB) DIV 100 ) % 100;
UNSIGNED1 DOB_day := ((UNSIGNED)h.DOB) % 100;
h.DOB_flag; // Flag to be filled in as part of Best processing
typeof(h.PHONE) PHONE := (typeof(h.PHONE))Fields.Make_PHONE((SALT27.StrType)h.PHONE ); // Cleans before using
h.PHONE_flag; // Flag to be filled in as part of Best processing
typeof(h.SNAME) SNAME := (typeof(h.SNAME))Fields.Make_SNAME((SALT27.StrType)h.SNAME ); // Cleans before using
typeof(h.FNAME) FNAME := (typeof(h.FNAME))Fields.Make_FNAME((SALT27.StrType)h.FNAME ); // Cleans before using
h.FNAME_flag; // Flag to be filled in as part of Best processing
typeof(h.MNAME) MNAME := (typeof(h.MNAME))Fields.Make_MNAME((SALT27.StrType)h.MNAME ); // Cleans before using
h.MNAME_flag; // Flag to be filled in as part of Best processing
typeof(h.LNAME) LNAME := (typeof(h.LNAME))Fields.Make_LNAME((SALT27.StrType)h.LNAME ); // Cleans before using
h.LNAME_flag; // Flag to be filled in as part of Best processing
typeof(h.GENDER) GENDER := if ( Fields.Invalid_GENDER(h.GENDER)=0,h.GENDER,(typeof(h.GENDER))'' ); // Blanks if invalid
typeof(h.LIC_STATE) LIC_STATE := (typeof(h.LIC_STATE))Fields.Make_LIC_STATE((SALT27.StrType)h.LIC_STATE ); // Cleans before using
typeof(h.LIC_NBR) LIC_NBR := (typeof(h.LIC_NBR))Fields.Make_LIC_NBR((SALT27.StrType)h.LIC_NBR ); // Cleans before using
h.LIC_NBR_flag; // Flag to be filled in as part of Best processing
typeof(h.PRIM_NAME) PRIM_NAME := (typeof(h.PRIM_NAME))Fields.Make_PRIM_NAME((SALT27.StrType)h.PRIM_NAME ); // Cleans before using
typeof(h.PRIM_RANGE) PRIM_RANGE := (typeof(h.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT27.StrType)h.PRIM_RANGE ); // Cleans before using
typeof(h.SEC_RANGE) SEC_RANGE := (typeof(h.SEC_RANGE))Fields.Make_SEC_RANGE((SALT27.StrType)h.SEC_RANGE ); // Cleans before using
typeof(h.V_CITY_NAME) V_CITY_NAME := (typeof(h.V_CITY_NAME))Fields.Make_V_CITY_NAME((SALT27.StrType)h.V_CITY_NAME ); // Cleans before using
typeof(h.ST) ST := (typeof(h.ST))Fields.Make_ST((SALT27.StrType)h.ST ); // Cleans before using
typeof(h.ZIP) ZIP := (typeof(h.ZIP))Fields.Make_ZIP((SALT27.StrType)h.ZIP ); // Cleans before using
h.ADDRESS_ID;
typeof(h.CNAME) CNAME := (typeof(h.CNAME))Fields.Make_CNAME((SALT27.StrType)h.CNAME ); // Cleans before using
typeof(h.NPI_NUMBER) NPI_NUMBER := (typeof(h.NPI_NUMBER))Fields.Make_NPI_NUMBER((SALT27.StrType)h.NPI_NUMBER ); // Cleans before using
h.NPI_NUMBER_flag; // Flag to be filled in as part of Best processing
typeof(h.DEA_NUMBER) DEA_NUMBER := (typeof(h.DEA_NUMBER))Fields.Make_DEA_NUMBER((SALT27.StrType)h.DEA_NUMBER ); // Cleans before using
h.DEA_NUMBER_flag; // Flag to be filled in as part of Best processing
typeof(h.VENDOR_ID) VENDOR_ID := (typeof(h.VENDOR_ID))Fields.Make_VENDOR_ID((SALT27.StrType)h.VENDOR_ID ); // Cleans before using
typeof(h.SRC) SRC := (typeof(h.SRC))Fields.Make_SRC((SALT27.StrType)h.SRC ); // Cleans before using
typeof(h.TAX_ID) TAX_ID := (typeof(h.TAX_ID))Fields.Make_TAX_ID((SALT27.StrType)h.TAX_ID ); // Cleans before using
h.TAX_ID_flag; // Flag to be filled in as part of Best processing
h.DID;
h.DID_flag; // Flag to be filled in as part of Best processing
typeof(h.UPIN) UPIN := (typeof(h.UPIN))Fields.Make_UPIN((SALT27.StrType)h.UPIN ); // Cleans before using
h.UPIN_flag; // Flag to be filled in as part of Best processing
UNSIGNED4 DT_FIRST_SEEN := (UNSIGNED4)Fields.Make_DT_FIRST_SEEN((SALT27.StrType)h.DT_FIRST_SEEN ); // Cleans before using
UNSIGNED4 DT_LAST_SEEN := (UNSIGNED4)Fields.Make_DT_LAST_SEEN((SALT27.StrType)h.DT_LAST_SEEN ); // Cleans before using
typeof(h.DT_LIC_EXPIRATION) DT_LIC_EXPIRATION := (typeof(h.DT_LIC_EXPIRATION))Fields.Make_DT_LIC_EXPIRATION((SALT27.StrType)h.DT_LIC_EXPIRATION ); // Cleans before using
typeof(h.DT_DEA_EXPIRATION) DT_DEA_EXPIRATION := (typeof(h.DT_DEA_EXPIRATION))Fields.Make_DT_DEA_EXPIRATION((SALT27.StrType)h.DT_DEA_EXPIRATION ); // Cleans before using
unsigned4 MAINNAME := 0; // Place holder filled in by project
unsigned4 FULLNAME := 0; // Place holder filled in by project
typeof(h.GEO_LAT) GEO_LAT := (typeof(h.GEO_LAT))Fields.Make_GEO_LAT((SALT27.StrType)h.GEO_LAT ); // Cleans before using
typeof(h.GEO_LONG) GEO_LONG := (typeof(h.GEO_LONG))Fields.Make_GEO_LONG((SALT27.StrType)h.GEO_LONG ); // Cleans before using
SALT27.Str30Type LAT_LONG := SALT27.Fn_Create_LL((SALT27.StrType)h.GEO_LAT,(SALT27.StrType)h.GEO_LONG,5); // Create single field to proxy for lat/long pair
unsigned4 ADDR := 0; // Place holder filled in by project
h.ADDR_flag; // Flag to be filled in as part of Best processing
unsigned4 LOCALE := 0; // Place holder filled in by project
unsigned4 ADDRESS := 0; // Place holder filled in by project
END;
r := input_layout;

h01 := DISTRIBUTE(TABLE(h(LNPID<>0),r),HASH(LNPID)); // group for the specificity_local function
input_layout do_computes(h01 le) := TRANSFORM
SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT27.StrType)le.FNAME,(SALT27.StrType)le.MNAME,(SALT27.StrType)le.LNAME),0,HASH32((SALT27.StrType)le.FNAME,(SALT27.StrType)le.MNAME,(SALT27.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT27.StrType)SELF.MAINNAME,(SALT27.StrType)le.SNAME),0,HASH32((SALT27.StrType)SELF.MAINNAME,(SALT27.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
SELF.ADDR := IF (Fields.InValid_ADDR((SALT27.StrType)le.PRIM_RANGE,(SALT27.StrType)le.SEC_RANGE,(SALT27.StrType)le.PRIM_NAME),0,HASH32((SALT27.StrType)le.PRIM_RANGE,(SALT27.StrType)le.SEC_RANGE,(SALT27.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT27.StrType)le.V_CITY_NAME,(SALT27.StrType)le.ST,(SALT27.StrType)le.ZIP),0,HASH32((SALT27.StrType)le.V_CITY_NAME,(SALT27.StrType)le.ST,(SALT27.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT27.StrType)SELF.ADDR,(SALT27.StrType)SELF.LOCALE),0,HASH32((SALT27.StrType)SELF.ADDR,(SALT27.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
SELF := le;
END;
h02 := PROJECT(h01,do_computes(LEFT));
SHARED h0 :=  h02;

EXPORT input_file_np := h0; // No-persist version for remote_linking

EXPORT input_file := h0  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::Specificities_Cache');
//We have LNPID specified - so we can compute statistics on the cluster counts
r0 := RECORD
input_file.LNPID;
UNSIGNED6 InCluster := COUNT(GROUP);
end;
EXPORT ClusterSizes := TABLE(input_file,r0,LNPID,LOCAL)  : PERSIST('~temp::LNPID::HealthCareProviderHeader_prod::Cluster_Sizes');
EXPORT TotalClusters := COUNT(ClusterSizes);

SHARED  DOB_year_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,DOB_year); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(DOB_year_deduped,DOB_year,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_year_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_DOB_year');
SALT27.MAC_Field_Nulls(DOB_year_values_persisted,Layout_Specificities.DOB_year_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_year_nulls := nv;
SALT27.MAC_Field_Bfoul(DOB_year_deduped,DOB_year,LNPID,DOB_year_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_year_switch := bf;
EXPORT DOB_year_max := MAX(DOB_year_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(DOB_year_values_persisted,DOB_year,DOB_year_nulls,ol) // Compute column level specificity
EXPORT DOB_year_specificity := ol;

SHARED  DOB_month_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,DOB_month); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(DOB_month_deduped,DOB_month,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_month_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_DOB_month');
SALT27.MAC_Field_Nulls(DOB_month_values_persisted,Layout_Specificities.DOB_month_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_month_nulls := nv;
SALT27.MAC_Field_Bfoul(DOB_month_deduped,DOB_month,LNPID,DOB_month_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_month_switch := bf;
EXPORT DOB_month_max := MAX(DOB_month_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(DOB_month_values_persisted,DOB_month,DOB_month_nulls,ol) // Compute column level specificity
EXPORT DOB_month_specificity := ol;

SHARED  DOB_day_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,DOB_day); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(DOB_day_deduped,DOB_day,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DOB_day_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_DOB_day');
SALT27.MAC_Field_Nulls(DOB_day_values_persisted,Layout_Specificities.DOB_day_ChildRec,nv) // Use automated NULL spotting
EXPORT DOB_day_nulls := nv;
SALT27.MAC_Field_Bfoul(DOB_day_deduped,DOB_day,LNPID,DOB_day_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DOB_day_switch := bf;
EXPORT DOB_day_max := MAX(DOB_day_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(DOB_day_values_persisted,DOB_day,DOB_day_nulls,ol) // Compute column level specificity
EXPORT DOB_day_specificity := ol;

SHARED  SNAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,SNAME); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(SNAME_deduped,SNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
STRING5 SNAME_NormSuffix := fn_NormSuffix(counted.SNAME); // Compute fn_NormSuffix value for SNAME
end;
with_id := table(counted,r1);
SALT27.MAC_Field_Accumulate_Counts(with_id,SNAME_NormSuffix,NormSuffix_cnt,fuzzies_counted0)
ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SNAME_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_SNAME');
SALT27.MAC_Field_Nulls(SNAME_values_persisted,Layout_Specificities.SNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT SNAME_nulls := nv;
SALT27.MAC_Field_Bfoul(SNAME_deduped,SNAME,LNPID,SNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SNAME_switch := bf;
EXPORT SNAME_max := MAX(SNAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(SNAME_values_persisted,SNAME,SNAME_nulls,ol) // Compute column level specificity
EXPORT SNAME_specificity := ol;

SHARED  FNAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,FNAME); // Reduce to field values by UID
SALT27.MAC_Field_Variants_Initials(FNAME_deduped,LNPID,FNAME,expanded) // expand out all variants of initial
SALT27.Mac_Field_Count_UID(expanded,FNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
STRING20 FNAME_PreferredName := fn_PreferredName(counted.FNAME); // Compute fn_PreferredName value for FNAME
end;
with_id := table(counted,r1);
SALT27.MAC_Field_Accumulate_Counts(with_id,FNAME_PreferredName,PreferredName_cnt,fuzzies_counted0)
ut.MAC_Sequence_Records(fuzzies_counted0,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SALT27.mac_edit_distance_pairs(specs_added,FNAME,cnt,1,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT FNAME_values_persisted := distance_computed : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_FNAME');
EXPORT FNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.FNAME_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(FNAME_deduped,FNAME,LNPID,FNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FNAME_switch := bf;
EXPORT FNAME_max := MAX(FNAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(FNAME_values_persisted,FNAME,FNAME_nulls,ol) // Compute column level specificity
EXPORT FNAME_specificity := ol;

SHARED  MNAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,MNAME); // Reduce to field values by UID
SALT27.MAC_Field_Variants_Initials(MNAME_deduped,LNPID,MNAME,expanded) // expand out all variants of initial
SALT27.Mac_Field_Count_UID(expanded,MNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SALT27.mac_edit_distance_pairs(specs_added,MNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT MNAME_values_persisted := distance_computed : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_MNAME');
EXPORT MNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.MNAME_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(MNAME_deduped,MNAME,LNPID,MNAME_nulls,ClusterSizes,true,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MNAME_switch := bf;
EXPORT MNAME_max := MAX(MNAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(MNAME_values_persisted,MNAME,MNAME_nulls,ol) // Compute column level specificity
EXPORT MNAME_specificity := ol;

SHARED  LNAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,LNAME); // Reduce to field values by UID
SALT27.MAC_Field_Variants_Hyphen(LNAME_deduped,LNPID,LNAME,expanded) // expand out all variants when hyphenated
SALT27.Mac_Field_Count_UID(expanded,LNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
SALT27.mac_edit_distance_pairs(specs_added,LNAME,cnt,2,false,distance_computed);//Computes specificities of fuzzy matches
EXPORT LNAME_values_persisted := distance_computed : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_LNAME');
EXPORT LNAME_nulls := DATASET([{'',0,0}],Layout_Specificities.LNAME_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(LNAME_deduped,LNAME,LNPID,LNAME_nulls,ClusterSizes,true,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LNAME_switch := bf;
EXPORT LNAME_max := MAX(LNAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(LNAME_values_persisted,LNAME,LNAME_nulls,ol) // Compute column level specificity
EXPORT LNAME_specificity := ol;

SHARED  GENDER_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,GENDER); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(GENDER_deduped,GENDER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT GENDER_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_GENDER');
EXPORT GENDER_nulls := DATASET([{'',0,0}],Layout_Specificities.GENDER_ChildRec); // Automated null spotting not applicable
SALT27.MAC_Field_Bfoul(GENDER_deduped,GENDER,LNPID,GENDER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT GENDER_switch := bf;
EXPORT GENDER_max := MAX(GENDER_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(GENDER_values_persisted,GENDER,GENDER_nulls,ol) // Compute column level specificity
EXPORT GENDER_specificity := ol;

SHARED  LIC_NBR_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,LIC_NBR); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(LIC_NBR_deduped,LIC_NBR,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
STRING25 LIC_NBR_CleanLic := fn_cleanlicense(counted.LIC_NBR); // Compute fn_cleanlicense value for LIC_NBR
STRING8 LIC_NBR_LicNumeric := fn_LicNumeric(counted.LIC_NBR); // Compute fn_LicNumeric value for LIC_NBR
end;
with_id := table(counted,r1);
SALT27.MAC_Field_Accumulate_Counts(with_id,LIC_NBR_CleanLic,CleanLic_cnt,fuzzies_counted0)
SALT27.MAC_Field_Accumulate_Counts(fuzzies_counted0,LIC_NBR_LicNumeric,LicNumeric_cnt,fuzzies_counted1)
ut.MAC_Sequence_Records(fuzzies_counted1,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LIC_NBR_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_LIC_NBR');
SALT27.MAC_Field_Nulls(LIC_NBR_values_persisted,Layout_Specificities.LIC_NBR_ChildRec,nv) // Use automated NULL spotting
EXPORT LIC_NBR_nulls := nv;
SALT27.MAC_Field_Bfoul(LIC_NBR_deduped,LIC_NBR,LNPID,LIC_NBR_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LIC_NBR_switch := bf;
EXPORT LIC_NBR_max := MAX(LIC_NBR_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(LIC_NBR_values_persisted,LIC_NBR,LIC_NBR_nulls,ol) // Compute column level specificity
EXPORT LIC_NBR_specificity := ol;

SHARED  PRIM_NAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,PRIM_NAME); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(PRIM_NAME_deduped,PRIM_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_NAME_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_PRIM_NAME');
SALT27.MAC_Field_Nulls(PRIM_NAME_values_persisted,Layout_Specificities.PRIM_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_NAME_nulls := nv;
SALT27.MAC_Field_Bfoul(PRIM_NAME_deduped,PRIM_NAME,LNPID,PRIM_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_NAME_switch := bf;
EXPORT PRIM_NAME_max := MAX(PRIM_NAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_nulls,ol) // Compute column level specificity
EXPORT PRIM_NAME_specificity := ol;

SHARED  PRIM_RANGE_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,PRIM_RANGE); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(PRIM_RANGE_deduped,PRIM_RANGE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT PRIM_RANGE_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_PRIM_RANGE');
SALT27.MAC_Field_Nulls(PRIM_RANGE_values_persisted,Layout_Specificities.PRIM_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT PRIM_RANGE_nulls := nv;
SALT27.MAC_Field_Bfoul(PRIM_RANGE_deduped,PRIM_RANGE,LNPID,PRIM_RANGE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT PRIM_RANGE_switch := bf;
EXPORT PRIM_RANGE_max := MAX(PRIM_RANGE_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_nulls,ol) // Compute column level specificity
EXPORT PRIM_RANGE_specificity := ol;

SHARED  SEC_RANGE_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,SEC_RANGE); // Reduce to field values by UID
SALT27.MAC_Field_Variants_Hyphen(SEC_RANGE_deduped,LNPID,SEC_RANGE,expanded) // expand out all variants when hyphenated
SALT27.Mac_Field_Count_UID(expanded,SEC_RANGE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT SEC_RANGE_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_SEC_RANGE');
SALT27.MAC_Field_Nulls(SEC_RANGE_values_persisted,Layout_Specificities.SEC_RANGE_ChildRec,nv) // Use automated NULL spotting
EXPORT SEC_RANGE_nulls := nv;
SALT27.MAC_Field_Bfoul(SEC_RANGE_deduped,SEC_RANGE,LNPID,SEC_RANGE_nulls,ClusterSizes,false,true,bf) // Compute the chances of a field having 2 values for one entity
EXPORT SEC_RANGE_switch := bf;
EXPORT SEC_RANGE_max := MAX(SEC_RANGE_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_nulls,ol) // Compute column level specificity
EXPORT SEC_RANGE_specificity := ol;

SHARED  V_CITY_NAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,V_CITY_NAME); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(V_CITY_NAME_deduped,V_CITY_NAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT V_CITY_NAME_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_V_CITY_NAME');
SALT27.MAC_Field_Nulls(V_CITY_NAME_values_persisted,Layout_Specificities.V_CITY_NAME_ChildRec,nv) // Use automated NULL spotting
EXPORT V_CITY_NAME_nulls := nv;
SALT27.MAC_Field_Bfoul(V_CITY_NAME_deduped,V_CITY_NAME,LNPID,V_CITY_NAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT V_CITY_NAME_switch := bf;
EXPORT V_CITY_NAME_max := MAX(V_CITY_NAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(V_CITY_NAME_values_persisted,V_CITY_NAME,V_CITY_NAME_nulls,ol) // Compute column level specificity
EXPORT V_CITY_NAME_specificity := ol;

SHARED  ST_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,ST); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(ST_deduped,ST,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ST_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_ST');
SALT27.MAC_Field_Nulls(ST_values_persisted,Layout_Specificities.ST_ChildRec,nv) // Use automated NULL spotting
EXPORT ST_nulls := nv;
SALT27.MAC_Field_Bfoul(ST_deduped,ST,LNPID,ST_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ST_switch := bf;
EXPORT ST_max := MAX(ST_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(ST_values_persisted,ST,ST_nulls,ol) // Compute column level specificity
EXPORT ST_specificity := ol;

SHARED  ZIP_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,ZIP); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(ZIP_deduped,ZIP,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ZIP_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_ZIP');
SALT27.MAC_Field_Nulls(ZIP_values_persisted,Layout_Specificities.ZIP_ChildRec,nv) // Use automated NULL spotting
EXPORT ZIP_nulls := nv;
SALT27.MAC_Field_Bfoul(ZIP_deduped,ZIP,LNPID,ZIP_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ZIP_switch := bf;
EXPORT ZIP_max := MAX(ZIP_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(ZIP_values_persisted,ZIP,ZIP_nulls,ol) // Compute column level specificity
EXPORT ZIP_specificity := ol;

SHARED  NPI_NUMBER_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,NPI_NUMBER); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(NPI_NUMBER_deduped,NPI_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT NPI_NUMBER_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_NPI_NUMBER');
SALT27.MAC_Field_Nulls(NPI_NUMBER_values_persisted,Layout_Specificities.NPI_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT NPI_NUMBER_nulls := nv;
SALT27.MAC_Field_Bfoul(NPI_NUMBER_deduped,NPI_NUMBER,LNPID,NPI_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT NPI_NUMBER_switch := bf;
EXPORT NPI_NUMBER_max := MAX(NPI_NUMBER_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(NPI_NUMBER_values_persisted,NPI_NUMBER,NPI_NUMBER_nulls,ol) // Compute column level specificity
EXPORT NPI_NUMBER_specificity := ol;

SHARED  DEA_NUMBER_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,DEA_NUMBER); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(DEA_NUMBER_deduped,DEA_NUMBER,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DEA_NUMBER_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_DEA_NUMBER');
SALT27.MAC_Field_Nulls(DEA_NUMBER_values_persisted,Layout_Specificities.DEA_NUMBER_ChildRec,nv) // Use automated NULL spotting
EXPORT DEA_NUMBER_nulls := nv;
SALT27.MAC_Field_Bfoul(DEA_NUMBER_deduped,DEA_NUMBER,LNPID,DEA_NUMBER_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DEA_NUMBER_switch := bf;
EXPORT DEA_NUMBER_max := MAX(DEA_NUMBER_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(DEA_NUMBER_values_persisted,DEA_NUMBER,DEA_NUMBER_nulls,ol) // Compute column level specificity
EXPORT DEA_NUMBER_specificity := ol;

SHARED  VENDOR_ID_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,VENDOR_ID); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(VENDOR_ID_deduped,VENDOR_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT VENDOR_ID_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_VENDOR_ID');
SALT27.MAC_Field_Nulls(VENDOR_ID_values_persisted,Layout_Specificities.VENDOR_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT VENDOR_ID_nulls := nv;
SALT27.MAC_Field_Bfoul(VENDOR_ID_deduped,VENDOR_ID,LNPID,VENDOR_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT VENDOR_ID_switch := bf;
EXPORT VENDOR_ID_max := MAX(VENDOR_ID_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_nulls,ol) // Compute column level specificity
EXPORT VENDOR_ID_specificity := ol;

SHARED  TAX_ID_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,TAX_ID); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(TAX_ID_deduped,TAX_ID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT TAX_ID_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_TAX_ID');
SALT27.MAC_Field_Nulls(TAX_ID_values_persisted,Layout_Specificities.TAX_ID_ChildRec,nv) // Use automated NULL spotting
EXPORT TAX_ID_nulls := nv;
SALT27.MAC_Field_Bfoul(TAX_ID_deduped,TAX_ID,LNPID,TAX_ID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT TAX_ID_switch := bf;
EXPORT TAX_ID_max := MAX(TAX_ID_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(TAX_ID_values_persisted,TAX_ID,TAX_ID_nulls,ol) // Compute column level specificity
EXPORT TAX_ID_specificity := ol;

SHARED  DID_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,DID); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(DID_deduped,DID,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT DID_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_DID');
SALT27.MAC_Field_Nulls(DID_values_persisted,Layout_Specificities.DID_ChildRec,nv) // Use automated NULL spotting
EXPORT DID_nulls := nv;
SALT27.MAC_Field_Bfoul(DID_deduped,DID,LNPID,DID_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT DID_switch := bf;
EXPORT DID_max := MAX(DID_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(DID_values_persisted,DID,DID_nulls,ol) // Compute column level specificity
EXPORT DID_specificity := ol;

SHARED  UPIN_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,UPIN); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(UPIN_deduped,UPIN,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT UPIN_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_UPIN');
SALT27.MAC_Field_Nulls(UPIN_values_persisted,Layout_Specificities.UPIN_ChildRec,nv) // Use automated NULL spotting
EXPORT UPIN_nulls := nv;
SALT27.MAC_Field_Bfoul(UPIN_deduped,UPIN,LNPID,UPIN_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT UPIN_switch := bf;
EXPORT UPIN_max := MAX(UPIN_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(UPIN_values_persisted,UPIN,UPIN_nulls,ol) // Compute column level specificity
EXPORT UPIN_specificity := ol;

SHARED  MAINNAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,MAINNAME); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(MAINNAME_deduped,MAINNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT MAINNAME_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_MAINNAME');
SALT27.MAC_Field_Nulls(MAINNAME_values_persisted,Layout_Specificities.MAINNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT MAINNAME_nulls := nv;
SALT27.MAC_Field_Bfoul(MAINNAME_deduped,MAINNAME,LNPID,MAINNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT MAINNAME_switch := bf;
EXPORT MAINNAME_max := MAX(MAINNAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(MAINNAME_values_persisted,MAINNAME,MAINNAME_nulls,ol) // Compute column level specificity
EXPORT MAINNAME_specificity := ol;

SHARED  FULLNAME_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,FULLNAME); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(FULLNAME_deduped,FULLNAME,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT FULLNAME_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_FULLNAME');
SALT27.MAC_Field_Nulls(FULLNAME_values_persisted,Layout_Specificities.FULLNAME_ChildRec,nv) // Use automated NULL spotting
EXPORT FULLNAME_nulls := nv;
SALT27.MAC_Field_Bfoul(FULLNAME_deduped,FULLNAME,LNPID,FULLNAME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT FULLNAME_switch := bf;
EXPORT FULLNAME_max := MAX(FULLNAME_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(FULLNAME_values_persisted,FULLNAME,FULLNAME_nulls,ol) // Compute column level specificity
EXPORT FULLNAME_specificity := ol;

SALT27.MAC_Specificity_Local(input_file,LAT_LONG,LNPID,LAT_LONG_nulls,Layout_Specificities.LAT_LONG_ChildRec,LAT_LONG_specificity,LAT_LONG_switch,LAT_LONG_values,false);
//Construct ranged values to allow for fuzzying (by distance) away from lat/long position
SALT27.MAC_Specificity_LL(LAT_LONG_values,LAT_LONG,cnt,1,LAT_LONG_ll_range);
EXPORT LAT_LONG_values_persisted := LAT_LONG_ll_range;
EXPORT LAT_LONG_max := MAX(LAT_LONG_values_persisted,field_specificity);

SHARED  ADDR_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,ADDR); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(ADDR_deduped,ADDR,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDR_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_ADDR');
SALT27.MAC_Field_Nulls(ADDR_values_persisted,Layout_Specificities.ADDR_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDR_nulls := nv;
SALT27.MAC_Field_Bfoul(ADDR_deduped,ADDR,LNPID,ADDR_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDR_switch := bf;
EXPORT ADDR_max := MAX(ADDR_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(ADDR_values_persisted,ADDR,ADDR_nulls,ol) // Compute column level specificity
EXPORT ADDR_specificity := ol;

SHARED  LOCALE_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,LOCALE); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(LOCALE_deduped,LOCALE,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT LOCALE_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_LOCALE');
SALT27.MAC_Field_Nulls(LOCALE_values_persisted,Layout_Specificities.LOCALE_ChildRec,nv) // Use automated NULL spotting
EXPORT LOCALE_nulls := nv;
SALT27.MAC_Field_Bfoul(LOCALE_deduped,LOCALE,LNPID,LOCALE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT LOCALE_switch := bf;
EXPORT LOCALE_max := MAX(LOCALE_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(LOCALE_values_persisted,LOCALE,LOCALE_nulls,ol) // Compute column level specificity
EXPORT LOCALE_specificity := ol;

SHARED  ADDRESS_deduped := SALT27.MAC_Field_By_UID(input_file,LNPID,ADDRESS); // Reduce to field values by UID
SALT27.Mac_Field_Count_UID(ADDRESS_deduped,ADDRESS,LNPID,counted,counted_clusters) // count the number of UIDs with each field value
r1 := RECORD
counted;
UNSIGNED4 id := 0; // Used to identify value later
end;
with_id := table(counted,r1);
ut.MAC_Sequence_Records(with_id,id,sequenced)
SALT27.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
EXPORT ADDRESS_values_persisted := specs_added : PERSIST('~temp::values::HealthCareProviderHeader_prod_LNPID_ADDRESS');
SALT27.MAC_Field_Nulls(ADDRESS_values_persisted,Layout_Specificities.ADDRESS_ChildRec,nv) // Use automated NULL spotting
EXPORT ADDRESS_nulls := nv;
SALT27.MAC_Field_Bfoul(ADDRESS_deduped,ADDRESS,LNPID,ADDRESS_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
EXPORT ADDRESS_switch := bf;
EXPORT ADDRESS_max := MAX(ADDRESS_values_persisted,field_specificity);
SALT27.MAC_Field_Specificity(ADDRESS_values_persisted,ADDRESS,ADDRESS_nulls,ol) // Compute column level specificity
EXPORT ADDRESS_specificity := ol;

iSpecificities := DATASET([{0,DOB_year_specificity,DOB_year_switch,DOB_year_max,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_max,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_max,DOB_day_nulls,SNAME_specificity,SNAME_switch,SNAME_max,SNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_max,FNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_max,MNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_max,LNAME_nulls,GENDER_specificity,GENDER_switch,GENDER_max,GENDER_nulls,LIC_NBR_specificity,LIC_NBR_switch,LIC_NBR_max,LIC_NBR_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_max,PRIM_NAME_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_max,PRIM_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_max,SEC_RANGE_nulls,V_CITY_NAME_specificity,V_CITY_NAME_switch,V_CITY_NAME_max,V_CITY_NAME_nulls,ST_specificity,ST_switch,ST_max,ST_nulls,ZIP_specificity,ZIP_switch,ZIP_max,ZIP_nulls,NPI_NUMBER_specificity,NPI_NUMBER_switch,NPI_NUMBER_max,NPI_NUMBER_nulls,DEA_NUMBER_specificity,DEA_NUMBER_switch,DEA_NUMBER_max,DEA_NUMBER_nulls,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_max,VENDOR_ID_nulls,TAX_ID_specificity,TAX_ID_switch,TAX_ID_max,TAX_ID_nulls,DID_specificity,DID_switch,DID_max,DID_nulls,UPIN_specificity,UPIN_switch,UPIN_max,UPIN_nulls,MAINNAME_specificity,MAINNAME_switch,MAINNAME_max,MAINNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_max,FULLNAME_nulls,LAT_LONG_specificity,LAT_LONG_switch,LAT_LONG_max,LAT_LONG_nulls,ADDR_specificity,ADDR_switch,ADDR_max,ADDR_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_max,LOCALE_nulls,ADDRESS_specificity,ADDRESS_switch,ADDRESS_max,ADDRESS_nulls}],Layout_Specificities.R) : PERSIST('~HealthCareProviderHeader_prod::LNPID::Specificities');
EXPORT Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
integer1 DOB_shift0 := ROUND(Specificities[1].DOB_year_specificity+Specificities[1].DOB_month_specificity+Specificities[1].DOB_day_specificity - 16);
// Not sure what to do amount a DATE switch yet - MAX of all?
integer1 SNAME_shift0 := ROUND(Specificities[1].SNAME_specificity - 6);
integer2 SNAME_switch_shift0 := ROUND(1000*Specificities[1].SNAME_switch - 23);
integer1 FNAME_shift0 := ROUND(Specificities[1].FNAME_specificity - 8);
integer2 FNAME_switch_shift0 := ROUND(1000*Specificities[1].FNAME_switch - 66);
integer1 MNAME_shift0 := ROUND(Specificities[1].MNAME_specificity - 9);
integer2 MNAME_switch_shift0 := ROUND(1000*Specificities[1].MNAME_switch - 96);
integer1 LNAME_shift0 := ROUND(Specificities[1].LNAME_specificity - 11);
integer2 LNAME_switch_shift0 := ROUND(1000*Specificities[1].LNAME_switch - 0);
integer1 GENDER_shift0 := ROUND(Specificities[1].GENDER_specificity - 2);
integer2 GENDER_switch_shift0 := ROUND(1000*Specificities[1].GENDER_switch - 1);
integer1 LIC_NBR_shift0 := ROUND(Specificities[1].LIC_NBR_specificity - 21);
integer2 LIC_NBR_switch_shift0 := ROUND(1000*Specificities[1].LIC_NBR_switch - 450);
integer1 PRIM_NAME_shift0 := ROUND(Specificities[1].PRIM_NAME_specificity - 13);
integer2 PRIM_NAME_switch_shift0 := ROUND(1000*Specificities[1].PRIM_NAME_switch - 477);
integer1 PRIM_RANGE_shift0 := ROUND(Specificities[1].PRIM_RANGE_specificity - 12);
integer2 PRIM_RANGE_switch_shift0 := ROUND(1000*Specificities[1].PRIM_RANGE_switch - 470);
integer1 SEC_RANGE_shift0 := ROUND(Specificities[1].SEC_RANGE_specificity - 7);
integer2 SEC_RANGE_switch_shift0 := ROUND(1000*Specificities[1].SEC_RANGE_switch - 320);
integer1 V_CITY_NAME_shift0 := ROUND(Specificities[1].V_CITY_NAME_specificity - 11);
integer2 V_CITY_NAME_switch_shift0 := ROUND(1000*Specificities[1].V_CITY_NAME_switch - 305);
integer1 ST_shift0 := ROUND(Specificities[1].ST_specificity - 5);
integer2 ST_switch_shift0 := ROUND(1000*Specificities[1].ST_switch - 50);
integer1 ZIP_shift0 := ROUND(Specificities[1].ZIP_specificity - 13);
integer2 ZIP_switch_shift0 := ROUND(1000*Specificities[1].ZIP_switch - 393);
integer1 NPI_NUMBER_shift0 := ROUND(Specificities[1].NPI_NUMBER_specificity - 22);
integer2 NPI_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].NPI_NUMBER_switch - 0);
integer1 DEA_NUMBER_shift0 := ROUND(Specificities[1].DEA_NUMBER_specificity - 22);
integer2 DEA_NUMBER_switch_shift0 := ROUND(1000*Specificities[1].DEA_NUMBER_switch - 13);
integer1 VENDOR_ID_shift0 := ROUND(Specificities[1].VENDOR_ID_specificity - 24);
integer2 VENDOR_ID_switch_shift0 := ROUND(1000*Specificities[1].VENDOR_ID_switch - 441);
integer1 TAX_ID_shift0 := ROUND(Specificities[1].TAX_ID_specificity - 18);
integer2 TAX_ID_switch_shift0 := ROUND(1000*Specificities[1].TAX_ID_switch - 262);
integer1 DID_shift0 := ROUND(Specificities[1].DID_specificity - 23);
integer2 DID_switch_shift0 := ROUND(1000*Specificities[1].DID_switch - 173);
integer1 UPIN_shift0 := ROUND(Specificities[1].UPIN_specificity - 20);
integer2 UPIN_switch_shift0 := ROUND(1000*Specificities[1].UPIN_switch - 20);
integer1 MAINNAME_shift0 := ROUND(Specificities[1].MAINNAME_specificity - 22);
integer2 MAINNAME_switch_shift0 := ROUND(1000*Specificities[1].MAINNAME_switch - 490);
integer1 FULLNAME_shift0 := ROUND(Specificities[1].FULLNAME_specificity - 22);
integer2 FULLNAME_switch_shift0 := ROUND(1000*Specificities[1].FULLNAME_switch - 494);
integer1 LAT_LONG_shift0 := ROUND(Specificities[1].LAT_LONG_specificity - 10);
integer2 LAT_LONG_switch_shift0 := ROUND(1000*Specificities[1].LAT_LONG_switch - 321);
integer1 ADDR_shift0 := ROUND(Specificities[1].ADDR_specificity - 20);
integer2 ADDR_switch_shift0 := ROUND(1000*Specificities[1].ADDR_switch - 555);
integer1 LOCALE_shift0 := ROUND(Specificities[1].LOCALE_specificity - 13);
integer2 LOCALE_switch_shift0 := ROUND(1000*Specificities[1].LOCALE_switch - 395);
integer1 ADDRESS_shift0 := ROUND(Specificities[1].ADDRESS_specificity - 20);
integer2 ADDRESS_switch_shift0 := ROUND(1000*Specificities[1].ADDRESS_switch - 558);
END;

EXPORT SpcShift := TABLE(Specificities,SpcShiftR);
// Service functions for specificity profiling
SALT27.MAC_Specificity_Values(SNAME_values_persisted,SNAME,'SNAME',SNAME_specificity,SNAME_specificity_profile);
SALT27.MAC_Specificity_Values(FNAME_values_persisted,FNAME,'FNAME',FNAME_specificity,FNAME_specificity_profile);
SALT27.MAC_Specificity_Values(MNAME_values_persisted,MNAME,'MNAME',MNAME_specificity,MNAME_specificity_profile);
SALT27.MAC_Specificity_Values(LNAME_values_persisted,LNAME,'LNAME',LNAME_specificity,LNAME_specificity_profile);
SALT27.MAC_Specificity_Values(GENDER_values_persisted,GENDER,'GENDER',GENDER_specificity,GENDER_specificity_profile);
SALT27.MAC_Specificity_Values(LIC_NBR_values_persisted,LIC_NBR,'LIC_NBR',LIC_NBR_specificity,LIC_NBR_specificity_profile);
SALT27.MAC_Specificity_Values(PRIM_NAME_values_persisted,PRIM_NAME,'PRIM_NAME',PRIM_NAME_specificity,PRIM_NAME_specificity_profile);
SALT27.MAC_Specificity_Values(PRIM_RANGE_values_persisted,PRIM_RANGE,'PRIM_RANGE',PRIM_RANGE_specificity,PRIM_RANGE_specificity_profile);
SALT27.MAC_Specificity_Values(SEC_RANGE_values_persisted,SEC_RANGE,'SEC_RANGE',SEC_RANGE_specificity,SEC_RANGE_specificity_profile);
SALT27.MAC_Specificity_Values(V_CITY_NAME_values_persisted,V_CITY_NAME,'V_CITY_NAME',V_CITY_NAME_specificity,V_CITY_NAME_specificity_profile);
SALT27.MAC_Specificity_Values(ST_values_persisted,ST,'ST',ST_specificity,ST_specificity_profile);
SALT27.MAC_Specificity_Values(ZIP_values_persisted,ZIP,'ZIP',ZIP_specificity,ZIP_specificity_profile);
SALT27.MAC_Specificity_Values(NPI_NUMBER_values_persisted,NPI_NUMBER,'NPI_NUMBER',NPI_NUMBER_specificity,NPI_NUMBER_specificity_profile);
SALT27.MAC_Specificity_Values(DEA_NUMBER_values_persisted,DEA_NUMBER,'DEA_NUMBER',DEA_NUMBER_specificity,DEA_NUMBER_specificity_profile);
SALT27.MAC_Specificity_Values(VENDOR_ID_values_persisted,VENDOR_ID,'VENDOR_ID',VENDOR_ID_specificity,VENDOR_ID_specificity_profile);
SALT27.MAC_Specificity_Values(TAX_ID_values_persisted,TAX_ID,'TAX_ID',TAX_ID_specificity,TAX_ID_specificity_profile);
SALT27.MAC_Specificity_Values(DID_values_persisted,DID,'DID',DID_specificity,DID_specificity_profile);
SALT27.MAC_Specificity_Values(UPIN_values_persisted,UPIN,'UPIN',UPIN_specificity,UPIN_specificity_profile);
SALT27.MAC_Specificity_Values(LAT_LONG_values_persisted,LAT_LONG,'LAT_LONG',LAT_LONG_specificity,LAT_LONG_specificity_profile);
EXPORT AllProfiles := SNAME_specificity_profile + FNAME_specificity_profile + MNAME_specificity_profile + LNAME_specificity_profile + GENDER_specificity_profile + LIC_NBR_specificity_profile + PRIM_NAME_specificity_profile + PRIM_RANGE_specificity_profile + SEC_RANGE_specificity_profile + V_CITY_NAME_specificity_profile + ST_specificity_profile + ZIP_specificity_profile + NPI_NUMBER_specificity_profile + DEA_NUMBER_specificity_profile + VENDOR_ID_specificity_profile + TAX_ID_specificity_profile + DID_specificity_profile + UPIN_specificity_profile + LAT_LONG_specificity_profile;
END;

