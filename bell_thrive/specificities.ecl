import ut,SALT20;
export specificities(dataset(layout_files().input.used) h) := MODULE
export input_layout := record // project out required fields
  SALT20.UIDType  := 0; // Fill in the value later
  h.id;
  h.fname;
  h.lname;
  h.dob;
  h.Own_Home;
  h.dlnum;
  h.State_Of_License;
  h.addr;
  h.city;
  h.st;
  h.zip;
  h.Phone_Home;
  h.Phone_Cell;
  h.Phone_Work;
  h.EMAIL;
  h.ip;
  h.dt;
  h.INCOME_MONTHLY;
  h.Weekly_BiWeekly;
  h.MONTHSEMPLOYED;
  h.MonthsAtBank;
  h.employer;
  h.Bank;
END;
r := input_layout;
tab := table(h,r);
ut.mac_sequence_records(tab,,h00);
h01 := distribute(h00,); // group for the specificity_local function
input_layout do_computes(h01 le) := transform
  self := le;
end;
shared h0 := project(h01,do_computes(left));
export input_file_np := h0; // No-persist version for remote_linking
export input_file := h0  : persist('temp::::bell_thrive::Specificities_Cache');
//We have  specified - so we can compute statistics on the cluster counts
  r0 := record
    input_file.;
    unsigned6 InCluster := count(group);
  end;
export ClusterSizes := table(input_file,r0,,local)  : persist('temp::::bell_thrive::Cluster_Sizes');
shared  id_deduped := SALT20.MAC_Field_By_UID(input_file,,id) : persist('temp::dedups::bell_thrive__id'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(id_deduped,id,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export id_values_persisted := specs_added : persist('temp::values::bell_thrive__id');
export id_nulls := dataset([{'',0,0}],Layout_Specificities.id_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(id_deduped,id,,id_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export id_switch := bf;
export id_max := MAX(id_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(id_values_persisted,id,id_nulls,ol) // Compute column level specificity
export id_specificity := ol;
shared  fname_deduped := SALT20.MAC_Field_By_UID(input_file,,fname) : persist('temp::dedups::bell_thrive__fname'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(fname_deduped,fname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export fname_values_persisted := specs_added : persist('temp::values::bell_thrive__fname');
export fname_nulls := dataset([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(fname_deduped,fname,,fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export fname_switch := bf;
export fname_max := MAX(fname_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
export fname_specificity := ol;
shared  lname_deduped := SALT20.MAC_Field_By_UID(input_file,,lname) : persist('temp::dedups::bell_thrive__lname'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(lname_deduped,lname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export lname_values_persisted := specs_added : persist('temp::values::bell_thrive__lname');
export lname_nulls := dataset([{'',0,0}],Layout_Specificities.lname_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(lname_deduped,lname,,lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export lname_switch := bf;
export lname_max := MAX(lname_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
export lname_specificity := ol;
shared  dob_deduped := SALT20.MAC_Field_By_UID(input_file,,dob) : persist('temp::dedups::bell_thrive__dob'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dob_deduped,dob,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dob_values_persisted := specs_added : persist('temp::values::bell_thrive__dob');
export dob_nulls := dataset([{'',0,0}],Layout_Specificities.dob_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dob_deduped,dob,,dob_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dob_switch := bf;
export dob_max := MAX(dob_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dob_values_persisted,dob,dob_nulls,ol) // Compute column level specificity
export dob_specificity := ol;
shared  Own_Home_deduped := SALT20.MAC_Field_By_UID(input_file,,Own_Home) : persist('temp::dedups::bell_thrive__Own_Home'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Own_Home_deduped,Own_Home,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Own_Home_values_persisted := specs_added : persist('temp::values::bell_thrive__Own_Home');
export Own_Home_nulls := dataset([{'',0,0}],Layout_Specificities.Own_Home_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Own_Home_deduped,Own_Home,,Own_Home_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Own_Home_switch := bf;
export Own_Home_max := MAX(Own_Home_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Own_Home_values_persisted,Own_Home,Own_Home_nulls,ol) // Compute column level specificity
export Own_Home_specificity := ol;
shared  dlnum_deduped := SALT20.MAC_Field_By_UID(input_file,,dlnum) : persist('temp::dedups::bell_thrive__dlnum'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dlnum_deduped,dlnum,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dlnum_values_persisted := specs_added : persist('temp::values::bell_thrive__dlnum');
export dlnum_nulls := dataset([{'',0,0}],Layout_Specificities.dlnum_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dlnum_deduped,dlnum,,dlnum_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dlnum_switch := bf;
export dlnum_max := MAX(dlnum_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dlnum_values_persisted,dlnum,dlnum_nulls,ol) // Compute column level specificity
export dlnum_specificity := ol;
shared  State_Of_License_deduped := SALT20.MAC_Field_By_UID(input_file,,State_Of_License) : persist('temp::dedups::bell_thrive__State_Of_License'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(State_Of_License_deduped,State_Of_License,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export State_Of_License_values_persisted := specs_added : persist('temp::values::bell_thrive__State_Of_License');
export State_Of_License_nulls := dataset([{'',0,0}],Layout_Specificities.State_Of_License_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(State_Of_License_deduped,State_Of_License,,State_Of_License_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export State_Of_License_switch := bf;
export State_Of_License_max := MAX(State_Of_License_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(State_Of_License_values_persisted,State_Of_License,State_Of_License_nulls,ol) // Compute column level specificity
export State_Of_License_specificity := ol;
shared  addr_deduped := SALT20.MAC_Field_By_UID(input_file,,addr) : persist('temp::dedups::bell_thrive__addr'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(addr_deduped,addr,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export addr_values_persisted := specs_added : persist('temp::values::bell_thrive__addr');
export addr_nulls := dataset([{'',0,0}],Layout_Specificities.addr_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(addr_deduped,addr,,addr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export addr_switch := bf;
export addr_max := MAX(addr_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(addr_values_persisted,addr,addr_nulls,ol) // Compute column level specificity
export addr_specificity := ol;
shared  city_deduped := SALT20.MAC_Field_By_UID(input_file,,city) : persist('temp::dedups::bell_thrive__city'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(city_deduped,city,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export city_values_persisted := specs_added : persist('temp::values::bell_thrive__city');
export city_nulls := dataset([{'',0,0}],Layout_Specificities.city_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(city_deduped,city,,city_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export city_switch := bf;
export city_max := MAX(city_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(city_values_persisted,city,city_nulls,ol) // Compute column level specificity
export city_specificity := ol;
shared  st_deduped := SALT20.MAC_Field_By_UID(input_file,,st) : persist('temp::dedups::bell_thrive__st'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(st_deduped,st,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export st_values_persisted := specs_added : persist('temp::values::bell_thrive__st');
export st_nulls := dataset([{'',0,0}],Layout_Specificities.st_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(st_deduped,st,,st_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export st_switch := bf;
export st_max := MAX(st_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(st_values_persisted,st,st_nulls,ol) // Compute column level specificity
export st_specificity := ol;
shared  zip_deduped := SALT20.MAC_Field_By_UID(input_file,,zip) : persist('temp::dedups::bell_thrive__zip'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(zip_deduped,zip,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip_values_persisted := specs_added : persist('temp::values::bell_thrive__zip');
export zip_nulls := dataset([{'',0,0}],Layout_Specificities.zip_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(zip_deduped,zip,,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip_switch := bf;
export zip_max := MAX(zip_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
export zip_specificity := ol;
shared  Phone_Home_deduped := SALT20.MAC_Field_By_UID(input_file,,Phone_Home) : persist('temp::dedups::bell_thrive__Phone_Home'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Phone_Home_deduped,Phone_Home,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Phone_Home_values_persisted := specs_added : persist('temp::values::bell_thrive__Phone_Home');
export Phone_Home_nulls := dataset([{'',0,0}],Layout_Specificities.Phone_Home_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Phone_Home_deduped,Phone_Home,,Phone_Home_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Phone_Home_switch := bf;
export Phone_Home_max := MAX(Phone_Home_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Phone_Home_values_persisted,Phone_Home,Phone_Home_nulls,ol) // Compute column level specificity
export Phone_Home_specificity := ol;
shared  Phone_Cell_deduped := SALT20.MAC_Field_By_UID(input_file,,Phone_Cell) : persist('temp::dedups::bell_thrive__Phone_Cell'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Phone_Cell_deduped,Phone_Cell,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Phone_Cell_values_persisted := specs_added : persist('temp::values::bell_thrive__Phone_Cell');
export Phone_Cell_nulls := dataset([{'',0,0}],Layout_Specificities.Phone_Cell_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Phone_Cell_deduped,Phone_Cell,,Phone_Cell_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Phone_Cell_switch := bf;
export Phone_Cell_max := MAX(Phone_Cell_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Phone_Cell_values_persisted,Phone_Cell,Phone_Cell_nulls,ol) // Compute column level specificity
export Phone_Cell_specificity := ol;
shared  Phone_Work_deduped := SALT20.MAC_Field_By_UID(input_file,,Phone_Work) : persist('temp::dedups::bell_thrive__Phone_Work'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Phone_Work_deduped,Phone_Work,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Phone_Work_values_persisted := specs_added : persist('temp::values::bell_thrive__Phone_Work');
export Phone_Work_nulls := dataset([{'',0,0}],Layout_Specificities.Phone_Work_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Phone_Work_deduped,Phone_Work,,Phone_Work_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Phone_Work_switch := bf;
export Phone_Work_max := MAX(Phone_Work_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Phone_Work_values_persisted,Phone_Work,Phone_Work_nulls,ol) // Compute column level specificity
export Phone_Work_specificity := ol;
shared  EMAIL_deduped := SALT20.MAC_Field_By_UID(input_file,,EMAIL) : persist('temp::dedups::bell_thrive__EMAIL'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(EMAIL_deduped,EMAIL,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export EMAIL_values_persisted := specs_added : persist('temp::values::bell_thrive__EMAIL');
export EMAIL_nulls := dataset([{'',0,0}],Layout_Specificities.EMAIL_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(EMAIL_deduped,EMAIL,,EMAIL_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export EMAIL_switch := bf;
export EMAIL_max := MAX(EMAIL_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(EMAIL_values_persisted,EMAIL,EMAIL_nulls,ol) // Compute column level specificity
export EMAIL_specificity := ol;
shared  ip_deduped := SALT20.MAC_Field_By_UID(input_file,,ip) : persist('temp::dedups::bell_thrive__ip'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(ip_deduped,ip,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export ip_values_persisted := specs_added : persist('temp::values::bell_thrive__ip');
export ip_nulls := dataset([{'',0,0}],Layout_Specificities.ip_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(ip_deduped,ip,,ip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export ip_switch := bf;
export ip_max := MAX(ip_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(ip_values_persisted,ip,ip_nulls,ol) // Compute column level specificity
export ip_specificity := ol;
shared  dt_deduped := SALT20.MAC_Field_By_UID(input_file,,dt) : persist('temp::dedups::bell_thrive__dt'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dt_deduped,dt,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_values_persisted := specs_added : persist('temp::values::bell_thrive__dt');
export dt_nulls := dataset([{'',0,0}],Layout_Specificities.dt_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dt_deduped,dt,,dt_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_switch := bf;
export dt_max := MAX(dt_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dt_values_persisted,dt,dt_nulls,ol) // Compute column level specificity
export dt_specificity := ol;
shared  INCOME_MONTHLY_deduped := SALT20.MAC_Field_By_UID(input_file,,INCOME_MONTHLY) : persist('temp::dedups::bell_thrive__INCOME_MONTHLY'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(INCOME_MONTHLY_deduped,INCOME_MONTHLY,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export INCOME_MONTHLY_values_persisted := specs_added : persist('temp::values::bell_thrive__INCOME_MONTHLY');
export INCOME_MONTHLY_nulls := dataset([{'',0,0}],Layout_Specificities.INCOME_MONTHLY_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(INCOME_MONTHLY_deduped,INCOME_MONTHLY,,INCOME_MONTHLY_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export INCOME_MONTHLY_switch := bf;
export INCOME_MONTHLY_max := MAX(INCOME_MONTHLY_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(INCOME_MONTHLY_values_persisted,INCOME_MONTHLY,INCOME_MONTHLY_nulls,ol) // Compute column level specificity
export INCOME_MONTHLY_specificity := ol;
shared  Weekly_BiWeekly_deduped := SALT20.MAC_Field_By_UID(input_file,,Weekly_BiWeekly) : persist('temp::dedups::bell_thrive__Weekly_BiWeekly'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Weekly_BiWeekly_deduped,Weekly_BiWeekly,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Weekly_BiWeekly_values_persisted := specs_added : persist('temp::values::bell_thrive__Weekly_BiWeekly');
export Weekly_BiWeekly_nulls := dataset([{'',0,0}],Layout_Specificities.Weekly_BiWeekly_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Weekly_BiWeekly_deduped,Weekly_BiWeekly,,Weekly_BiWeekly_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Weekly_BiWeekly_switch := bf;
export Weekly_BiWeekly_max := MAX(Weekly_BiWeekly_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Weekly_BiWeekly_values_persisted,Weekly_BiWeekly,Weekly_BiWeekly_nulls,ol) // Compute column level specificity
export Weekly_BiWeekly_specificity := ol;
shared  MONTHSEMPLOYED_deduped := SALT20.MAC_Field_By_UID(input_file,,MONTHSEMPLOYED) : persist('temp::dedups::bell_thrive__MONTHSEMPLOYED'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(MONTHSEMPLOYED_deduped,MONTHSEMPLOYED,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export MONTHSEMPLOYED_values_persisted := specs_added : persist('temp::values::bell_thrive__MONTHSEMPLOYED');
export MONTHSEMPLOYED_nulls := dataset([{'',0,0}],Layout_Specificities.MONTHSEMPLOYED_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(MONTHSEMPLOYED_deduped,MONTHSEMPLOYED,,MONTHSEMPLOYED_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export MONTHSEMPLOYED_switch := bf;
export MONTHSEMPLOYED_max := MAX(MONTHSEMPLOYED_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(MONTHSEMPLOYED_values_persisted,MONTHSEMPLOYED,MONTHSEMPLOYED_nulls,ol) // Compute column level specificity
export MONTHSEMPLOYED_specificity := ol;
shared  MonthsAtBank_deduped := SALT20.MAC_Field_By_UID(input_file,,MonthsAtBank) : persist('temp::dedups::bell_thrive__MonthsAtBank'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(MonthsAtBank_deduped,MonthsAtBank,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export MonthsAtBank_values_persisted := specs_added : persist('temp::values::bell_thrive__MonthsAtBank');
export MonthsAtBank_nulls := dataset([{'',0,0}],Layout_Specificities.MonthsAtBank_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(MonthsAtBank_deduped,MonthsAtBank,,MonthsAtBank_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export MonthsAtBank_switch := bf;
export MonthsAtBank_max := MAX(MonthsAtBank_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(MonthsAtBank_values_persisted,MonthsAtBank,MonthsAtBank_nulls,ol) // Compute column level specificity
export MonthsAtBank_specificity := ol;
shared  employer_deduped := SALT20.MAC_Field_By_UID(input_file,,employer) : persist('temp::dedups::bell_thrive__employer'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(employer_deduped,employer,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export employer_values_persisted := specs_added : persist('temp::values::bell_thrive__employer');
export employer_nulls := dataset([{'',0,0}],Layout_Specificities.employer_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(employer_deduped,employer,,employer_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export employer_switch := bf;
export employer_max := MAX(employer_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(employer_values_persisted,employer,employer_nulls,ol) // Compute column level specificity
export employer_specificity := ol;
shared  Bank_deduped := SALT20.MAC_Field_By_UID(input_file,,Bank) : persist('temp::dedups::bell_thrive__Bank'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Bank_deduped,Bank,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Bank_values_persisted := specs_added : persist('temp::values::bell_thrive__Bank');
export Bank_nulls := dataset([{'',0,0}],Layout_Specificities.Bank_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Bank_deduped,Bank,,Bank_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Bank_switch := bf;
export Bank_max := MAX(Bank_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Bank_values_persisted,Bank,Bank_nulls,ol) // Compute column level specificity
export Bank_specificity := ol;
iSpecificities := dataset([{0,id_specificity,id_switch,id_max,id_nulls,fname_specificity,fname_switch,fname_max,fname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,dob_specificity,dob_switch,dob_max,dob_nulls,Own_Home_specificity,Own_Home_switch,Own_Home_max,Own_Home_nulls,dlnum_specificity,dlnum_switch,dlnum_max,dlnum_nulls,State_Of_License_specificity,State_Of_License_switch,State_Of_License_max,State_Of_License_nulls,addr_specificity,addr_switch,addr_max,addr_nulls,city_specificity,city_switch,city_max,city_nulls,st_specificity,st_switch,st_max,st_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,Phone_Home_specificity,Phone_Home_switch,Phone_Home_max,Phone_Home_nulls,Phone_Cell_specificity,Phone_Cell_switch,Phone_Cell_max,Phone_Cell_nulls,Phone_Work_specificity,Phone_Work_switch,Phone_Work_max,Phone_Work_nulls,EMAIL_specificity,EMAIL_switch,EMAIL_max,EMAIL_nulls,ip_specificity,ip_switch,ip_max,ip_nulls,dt_specificity,dt_switch,dt_max,dt_nulls,INCOME_MONTHLY_specificity,INCOME_MONTHLY_switch,INCOME_MONTHLY_max,INCOME_MONTHLY_nulls,Weekly_BiWeekly_specificity,Weekly_BiWeekly_switch,Weekly_BiWeekly_max,Weekly_BiWeekly_nulls,MONTHSEMPLOYED_specificity,MONTHSEMPLOYED_switch,MONTHSEMPLOYED_max,MONTHSEMPLOYED_nulls,MonthsAtBank_specificity,MonthsAtBank_switch,MonthsAtBank_max,MonthsAtBank_nulls,employer_specificity,employer_switch,employer_max,employer_nulls,Bank_specificity,Bank_switch,Bank_max,Bank_nulls}],Layout_Specificities.R) : persist('bell_thrive::::Specificities');
export Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 id_shift0 := ROUND(Specificities[1].id_specificity - 0);
  integer2 id_switch_shift0 := ROUND(1000*Specificities[1].id_switch - 0);
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 0);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 0);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 0);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 0);
  integer1 dob_shift0 := ROUND(Specificities[1].dob_specificity - 0);
  integer2 dob_switch_shift0 := ROUND(1000*Specificities[1].dob_switch - 0);
  integer1 Own_Home_shift0 := ROUND(Specificities[1].Own_Home_specificity - 0);
  integer2 Own_Home_switch_shift0 := ROUND(1000*Specificities[1].Own_Home_switch - 0);
  integer1 dlnum_shift0 := ROUND(Specificities[1].dlnum_specificity - 0);
  integer2 dlnum_switch_shift0 := ROUND(1000*Specificities[1].dlnum_switch - 0);
  integer1 State_Of_License_shift0 := ROUND(Specificities[1].State_Of_License_specificity - 0);
  integer2 State_Of_License_switch_shift0 := ROUND(1000*Specificities[1].State_Of_License_switch - 0);
  integer1 addr_shift0 := ROUND(Specificities[1].addr_specificity - 0);
  integer2 addr_switch_shift0 := ROUND(1000*Specificities[1].addr_switch - 0);
  integer1 city_shift0 := ROUND(Specificities[1].city_specificity - 0);
  integer2 city_switch_shift0 := ROUND(1000*Specificities[1].city_switch - 0);
  integer1 st_shift0 := ROUND(Specificities[1].st_specificity - 0);
  integer2 st_switch_shift0 := ROUND(1000*Specificities[1].st_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 0);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 Phone_Home_shift0 := ROUND(Specificities[1].Phone_Home_specificity - 0);
  integer2 Phone_Home_switch_shift0 := ROUND(1000*Specificities[1].Phone_Home_switch - 0);
  integer1 Phone_Cell_shift0 := ROUND(Specificities[1].Phone_Cell_specificity - 0);
  integer2 Phone_Cell_switch_shift0 := ROUND(1000*Specificities[1].Phone_Cell_switch - 0);
  integer1 Phone_Work_shift0 := ROUND(Specificities[1].Phone_Work_specificity - 0);
  integer2 Phone_Work_switch_shift0 := ROUND(1000*Specificities[1].Phone_Work_switch - 0);
  integer1 EMAIL_shift0 := ROUND(Specificities[1].EMAIL_specificity - 0);
  integer2 EMAIL_switch_shift0 := ROUND(1000*Specificities[1].EMAIL_switch - 0);
  integer1 ip_shift0 := ROUND(Specificities[1].ip_specificity - 0);
  integer2 ip_switch_shift0 := ROUND(1000*Specificities[1].ip_switch - 0);
  integer1 dt_shift0 := ROUND(Specificities[1].dt_specificity - 0);
  integer2 dt_switch_shift0 := ROUND(1000*Specificities[1].dt_switch - 0);
  integer1 INCOME_MONTHLY_shift0 := ROUND(Specificities[1].INCOME_MONTHLY_specificity - 0);
  integer2 INCOME_MONTHLY_switch_shift0 := ROUND(1000*Specificities[1].INCOME_MONTHLY_switch - 0);
  integer1 Weekly_BiWeekly_shift0 := ROUND(Specificities[1].Weekly_BiWeekly_specificity - 0);
  integer2 Weekly_BiWeekly_switch_shift0 := ROUND(1000*Specificities[1].Weekly_BiWeekly_switch - 0);
  integer1 MONTHSEMPLOYED_shift0 := ROUND(Specificities[1].MONTHSEMPLOYED_specificity - 0);
  integer2 MONTHSEMPLOYED_switch_shift0 := ROUND(1000*Specificities[1].MONTHSEMPLOYED_switch - 0);
  integer1 MonthsAtBank_shift0 := ROUND(Specificities[1].MonthsAtBank_specificity - 0);
  integer2 MonthsAtBank_switch_shift0 := ROUND(1000*Specificities[1].MonthsAtBank_switch - 0);
  integer1 employer_shift0 := ROUND(Specificities[1].employer_specificity - 0);
  integer2 employer_switch_shift0 := ROUND(1000*Specificities[1].employer_switch - 0);
  integer1 Bank_shift0 := ROUND(Specificities[1].Bank_specificity - 0);
  integer2 Bank_switch_shift0 := ROUND(1000*Specificities[1].Bank_switch - 0);
  end;
export SpcShift := table(Specificities,SpcShiftR);
end;
