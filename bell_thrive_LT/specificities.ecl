import ut,SALT20;
export specificities(dataset(layout_files().input.used) h) := MODULE
export input_layout := record // project out required fields
  SALT20.UIDType  := 0; // Fill in the value later
  h.fname;
  h.lname;
  h.addr;
  h.city;
  h.state;
  h.zip;
  h.zip4;
  h.EMAIL;
  h.phone;
  h.LoanType;
  h.BESTTIME;
  h.MortRate;
  h.PROPERTYTYPE;
  h.RateType;
  h.LTV;
  h.YrsThere;
  h.employer;
  h.credit;
  h.Income;
  h.LoanAmt;
  h.dt;
  h.ip;
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
export input_file := h0  : persist('temp::::bell_thrive_LT::Specificities_Cache');
//We have  specified - so we can compute statistics on the cluster counts
  r0 := record
    input_file.;
    unsigned6 InCluster := count(group);
  end;
export ClusterSizes := table(input_file,r0,,local)  : persist('temp::::bell_thrive_LT::Cluster_Sizes');
shared  fname_deduped := SALT20.MAC_Field_By_UID(input_file,,fname) : persist('temp::dedups::bell_thrive_LT__fname'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(fname_deduped,fname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export fname_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__fname');
export fname_nulls := dataset([{'',0,0}],Layout_Specificities.fname_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(fname_deduped,fname,,fname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export fname_switch := bf;
export fname_max := MAX(fname_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(fname_values_persisted,fname,fname_nulls,ol) // Compute column level specificity
export fname_specificity := ol;
shared  lname_deduped := SALT20.MAC_Field_By_UID(input_file,,lname) : persist('temp::dedups::bell_thrive_LT__lname'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(lname_deduped,lname,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export lname_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__lname');
export lname_nulls := dataset([{'',0,0}],Layout_Specificities.lname_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(lname_deduped,lname,,lname_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export lname_switch := bf;
export lname_max := MAX(lname_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(lname_values_persisted,lname,lname_nulls,ol) // Compute column level specificity
export lname_specificity := ol;
shared  addr_deduped := SALT20.MAC_Field_By_UID(input_file,,addr) : persist('temp::dedups::bell_thrive_LT__addr'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(addr_deduped,addr,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export addr_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__addr');
export addr_nulls := dataset([{'',0,0}],Layout_Specificities.addr_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(addr_deduped,addr,,addr_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export addr_switch := bf;
export addr_max := MAX(addr_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(addr_values_persisted,addr,addr_nulls,ol) // Compute column level specificity
export addr_specificity := ol;
shared  city_deduped := SALT20.MAC_Field_By_UID(input_file,,city) : persist('temp::dedups::bell_thrive_LT__city'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(city_deduped,city,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export city_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__city');
export city_nulls := dataset([{'',0,0}],Layout_Specificities.city_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(city_deduped,city,,city_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export city_switch := bf;
export city_max := MAX(city_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(city_values_persisted,city,city_nulls,ol) // Compute column level specificity
export city_specificity := ol;
shared  state_deduped := SALT20.MAC_Field_By_UID(input_file,,state) : persist('temp::dedups::bell_thrive_LT__state'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(state_deduped,state,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export state_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__state');
export state_nulls := dataset([{'',0,0}],Layout_Specificities.state_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(state_deduped,state,,state_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export state_switch := bf;
export state_max := MAX(state_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(state_values_persisted,state,state_nulls,ol) // Compute column level specificity
export state_specificity := ol;
shared  zip_deduped := SALT20.MAC_Field_By_UID(input_file,,zip) : persist('temp::dedups::bell_thrive_LT__zip'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(zip_deduped,zip,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__zip');
export zip_nulls := dataset([{'',0,0}],Layout_Specificities.zip_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(zip_deduped,zip,,zip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip_switch := bf;
export zip_max := MAX(zip_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(zip_values_persisted,zip,zip_nulls,ol) // Compute column level specificity
export zip_specificity := ol;
shared  zip4_deduped := SALT20.MAC_Field_By_UID(input_file,,zip4) : persist('temp::dedups::bell_thrive_LT__zip4'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(zip4_deduped,zip4,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export zip4_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__zip4');
export zip4_nulls := dataset([{'',0,0}],Layout_Specificities.zip4_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(zip4_deduped,zip4,,zip4_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export zip4_switch := bf;
export zip4_max := MAX(zip4_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(zip4_values_persisted,zip4,zip4_nulls,ol) // Compute column level specificity
export zip4_specificity := ol;
shared  EMAIL_deduped := SALT20.MAC_Field_By_UID(input_file,,EMAIL) : persist('temp::dedups::bell_thrive_LT__EMAIL'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(EMAIL_deduped,EMAIL,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export EMAIL_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__EMAIL');
export EMAIL_nulls := dataset([{'',0,0}],Layout_Specificities.EMAIL_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(EMAIL_deduped,EMAIL,,EMAIL_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export EMAIL_switch := bf;
export EMAIL_max := MAX(EMAIL_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(EMAIL_values_persisted,EMAIL,EMAIL_nulls,ol) // Compute column level specificity
export EMAIL_specificity := ol;
shared  phone_deduped := SALT20.MAC_Field_By_UID(input_file,,phone) : persist('temp::dedups::bell_thrive_LT__phone'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(phone_deduped,phone,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export phone_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__phone');
export phone_nulls := dataset([{'',0,0}],Layout_Specificities.phone_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(phone_deduped,phone,,phone_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export phone_switch := bf;
export phone_max := MAX(phone_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(phone_values_persisted,phone,phone_nulls,ol) // Compute column level specificity
export phone_specificity := ol;
shared  LoanType_deduped := SALT20.MAC_Field_By_UID(input_file,,LoanType) : persist('temp::dedups::bell_thrive_LT__LoanType'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(LoanType_deduped,LoanType,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export LoanType_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__LoanType');
export LoanType_nulls := dataset([{'',0,0}],Layout_Specificities.LoanType_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(LoanType_deduped,LoanType,,LoanType_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export LoanType_switch := bf;
export LoanType_max := MAX(LoanType_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(LoanType_values_persisted,LoanType,LoanType_nulls,ol) // Compute column level specificity
export LoanType_specificity := ol;
shared  BESTTIME_deduped := SALT20.MAC_Field_By_UID(input_file,,BESTTIME) : persist('temp::dedups::bell_thrive_LT__BESTTIME'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(BESTTIME_deduped,BESTTIME,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export BESTTIME_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__BESTTIME');
export BESTTIME_nulls := dataset([{'',0,0}],Layout_Specificities.BESTTIME_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(BESTTIME_deduped,BESTTIME,,BESTTIME_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export BESTTIME_switch := bf;
export BESTTIME_max := MAX(BESTTIME_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(BESTTIME_values_persisted,BESTTIME,BESTTIME_nulls,ol) // Compute column level specificity
export BESTTIME_specificity := ol;
shared  MortRate_deduped := SALT20.MAC_Field_By_UID(input_file,,MortRate) : persist('temp::dedups::bell_thrive_LT__MortRate'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(MortRate_deduped,MortRate,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export MortRate_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__MortRate');
export MortRate_nulls := dataset([{'',0,0}],Layout_Specificities.MortRate_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(MortRate_deduped,MortRate,,MortRate_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export MortRate_switch := bf;
export MortRate_max := MAX(MortRate_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(MortRate_values_persisted,MortRate,MortRate_nulls,ol) // Compute column level specificity
export MortRate_specificity := ol;
shared  PROPERTYTYPE_deduped := SALT20.MAC_Field_By_UID(input_file,,PROPERTYTYPE) : persist('temp::dedups::bell_thrive_LT__PROPERTYTYPE'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(PROPERTYTYPE_deduped,PROPERTYTYPE,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export PROPERTYTYPE_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__PROPERTYTYPE');
export PROPERTYTYPE_nulls := dataset([{'',0,0}],Layout_Specificities.PROPERTYTYPE_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(PROPERTYTYPE_deduped,PROPERTYTYPE,,PROPERTYTYPE_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export PROPERTYTYPE_switch := bf;
export PROPERTYTYPE_max := MAX(PROPERTYTYPE_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(PROPERTYTYPE_values_persisted,PROPERTYTYPE,PROPERTYTYPE_nulls,ol) // Compute column level specificity
export PROPERTYTYPE_specificity := ol;
shared  RateType_deduped := SALT20.MAC_Field_By_UID(input_file,,RateType) : persist('temp::dedups::bell_thrive_LT__RateType'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(RateType_deduped,RateType,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export RateType_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__RateType');
export RateType_nulls := dataset([{'',0,0}],Layout_Specificities.RateType_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(RateType_deduped,RateType,,RateType_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export RateType_switch := bf;
export RateType_max := MAX(RateType_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(RateType_values_persisted,RateType,RateType_nulls,ol) // Compute column level specificity
export RateType_specificity := ol;
shared  LTV_deduped := SALT20.MAC_Field_By_UID(input_file,,LTV) : persist('temp::dedups::bell_thrive_LT__LTV'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(LTV_deduped,LTV,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export LTV_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__LTV');
export LTV_nulls := dataset([{'',0,0}],Layout_Specificities.LTV_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(LTV_deduped,LTV,,LTV_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export LTV_switch := bf;
export LTV_max := MAX(LTV_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(LTV_values_persisted,LTV,LTV_nulls,ol) // Compute column level specificity
export LTV_specificity := ol;
shared  YrsThere_deduped := SALT20.MAC_Field_By_UID(input_file,,YrsThere) : persist('temp::dedups::bell_thrive_LT__YrsThere'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(YrsThere_deduped,YrsThere,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export YrsThere_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__YrsThere');
export YrsThere_nulls := dataset([{'',0,0}],Layout_Specificities.YrsThere_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(YrsThere_deduped,YrsThere,,YrsThere_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export YrsThere_switch := bf;
export YrsThere_max := MAX(YrsThere_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(YrsThere_values_persisted,YrsThere,YrsThere_nulls,ol) // Compute column level specificity
export YrsThere_specificity := ol;
shared  employer_deduped := SALT20.MAC_Field_By_UID(input_file,,employer) : persist('temp::dedups::bell_thrive_LT__employer'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(employer_deduped,employer,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export employer_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__employer');
export employer_nulls := dataset([{'',0,0}],Layout_Specificities.employer_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(employer_deduped,employer,,employer_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export employer_switch := bf;
export employer_max := MAX(employer_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(employer_values_persisted,employer,employer_nulls,ol) // Compute column level specificity
export employer_specificity := ol;
shared  credit_deduped := SALT20.MAC_Field_By_UID(input_file,,credit) : persist('temp::dedups::bell_thrive_LT__credit'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(credit_deduped,credit,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export credit_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__credit');
export credit_nulls := dataset([{'',0,0}],Layout_Specificities.credit_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(credit_deduped,credit,,credit_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export credit_switch := bf;
export credit_max := MAX(credit_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(credit_values_persisted,credit,credit_nulls,ol) // Compute column level specificity
export credit_specificity := ol;
shared  Income_deduped := SALT20.MAC_Field_By_UID(input_file,,Income) : persist('temp::dedups::bell_thrive_LT__Income'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(Income_deduped,Income,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export Income_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__Income');
export Income_nulls := dataset([{'',0,0}],Layout_Specificities.Income_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(Income_deduped,Income,,Income_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export Income_switch := bf;
export Income_max := MAX(Income_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(Income_values_persisted,Income,Income_nulls,ol) // Compute column level specificity
export Income_specificity := ol;
shared  LoanAmt_deduped := SALT20.MAC_Field_By_UID(input_file,,LoanAmt) : persist('temp::dedups::bell_thrive_LT__LoanAmt'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(LoanAmt_deduped,LoanAmt,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export LoanAmt_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__LoanAmt');
export LoanAmt_nulls := dataset([{'',0,0}],Layout_Specificities.LoanAmt_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(LoanAmt_deduped,LoanAmt,,LoanAmt_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export LoanAmt_switch := bf;
export LoanAmt_max := MAX(LoanAmt_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(LoanAmt_values_persisted,LoanAmt,LoanAmt_nulls,ol) // Compute column level specificity
export LoanAmt_specificity := ol;
shared  dt_deduped := SALT20.MAC_Field_By_UID(input_file,,dt) : persist('temp::dedups::bell_thrive_LT__dt'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(dt_deduped,dt,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export dt_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__dt');
export dt_nulls := dataset([{'',0,0}],Layout_Specificities.dt_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(dt_deduped,dt,,dt_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export dt_switch := bf;
export dt_max := MAX(dt_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(dt_values_persisted,dt,dt_nulls,ol) // Compute column level specificity
export dt_specificity := ol;
shared  ip_deduped := SALT20.MAC_Field_By_UID(input_file,,ip) : persist('temp::dedups::bell_thrive_LT__ip'); // Reduce to field values by UID
  SALT20.Mac_Field_Count_UID(ip_deduped,ip,counted) // count the number of UIDs with each field value
  r1 := record
    counted;
    unsigned4 id := 0; // Used to identify value later
  end;
  with_id := table(counted,r1);
  ut.MAC_Sequence_Records(with_id,id,sequenced)
  SALT20.MAC_Field_Specificities(sequenced,specs_added) // Compute specificity for each value
export ip_values_persisted := specs_added : persist('temp::values::bell_thrive_LT__ip');
export ip_nulls := dataset([{'',0,0}],Layout_Specificities.ip_ChildRec); // Automated null spotting not applicable
SALT20.MAC_Field_Bfoul(ip_deduped,ip,,ip_nulls,ClusterSizes,false,false,bf) // Compute the chances of a field having 2 values for one entity
export ip_switch := bf;
export ip_max := MAX(ip_values_persisted,field_specificity);
SALT20.MAC_Field_Specificity(ip_values_persisted,ip,ip_nulls,ol) // Compute column level specificity
export ip_specificity := ol;
iSpecificities := dataset([{0,fname_specificity,fname_switch,fname_max,fname_nulls,lname_specificity,lname_switch,lname_max,lname_nulls,addr_specificity,addr_switch,addr_max,addr_nulls,city_specificity,city_switch,city_max,city_nulls,state_specificity,state_switch,state_max,state_nulls,zip_specificity,zip_switch,zip_max,zip_nulls,zip4_specificity,zip4_switch,zip4_max,zip4_nulls,EMAIL_specificity,EMAIL_switch,EMAIL_max,EMAIL_nulls,phone_specificity,phone_switch,phone_max,phone_nulls,LoanType_specificity,LoanType_switch,LoanType_max,LoanType_nulls,BESTTIME_specificity,BESTTIME_switch,BESTTIME_max,BESTTIME_nulls,MortRate_specificity,MortRate_switch,MortRate_max,MortRate_nulls,PROPERTYTYPE_specificity,PROPERTYTYPE_switch,PROPERTYTYPE_max,PROPERTYTYPE_nulls,RateType_specificity,RateType_switch,RateType_max,RateType_nulls,LTV_specificity,LTV_switch,LTV_max,LTV_nulls,YrsThere_specificity,YrsThere_switch,YrsThere_max,YrsThere_nulls,employer_specificity,employer_switch,employer_max,employer_nulls,credit_specificity,credit_switch,credit_max,credit_nulls,Income_specificity,Income_switch,Income_max,Income_nulls,LoanAmt_specificity,LoanAmt_switch,LoanAmt_max,LoanAmt_nulls,dt_specificity,dt_switch,dt_max,dt_nulls,ip_specificity,ip_switch,ip_max,ip_nulls}],Layout_Specificities.R) : persist('bell_thrive_LT::::Specificities');
export Specificities := iSpecificities;
// Let us see how accurate the SPC file is:-
SpcShiftR := RECORD
  integer1 fname_shift0 := ROUND(Specificities[1].fname_specificity - 0);
  integer2 fname_switch_shift0 := ROUND(1000*Specificities[1].fname_switch - 0);
  integer1 lname_shift0 := ROUND(Specificities[1].lname_specificity - 0);
  integer2 lname_switch_shift0 := ROUND(1000*Specificities[1].lname_switch - 0);
  integer1 addr_shift0 := ROUND(Specificities[1].addr_specificity - 0);
  integer2 addr_switch_shift0 := ROUND(1000*Specificities[1].addr_switch - 0);
  integer1 city_shift0 := ROUND(Specificities[1].city_specificity - 0);
  integer2 city_switch_shift0 := ROUND(1000*Specificities[1].city_switch - 0);
  integer1 state_shift0 := ROUND(Specificities[1].state_specificity - 0);
  integer2 state_switch_shift0 := ROUND(1000*Specificities[1].state_switch - 0);
  integer1 zip_shift0 := ROUND(Specificities[1].zip_specificity - 0);
  integer2 zip_switch_shift0 := ROUND(1000*Specificities[1].zip_switch - 0);
  integer1 zip4_shift0 := ROUND(Specificities[1].zip4_specificity - 0);
  integer2 zip4_switch_shift0 := ROUND(1000*Specificities[1].zip4_switch - 0);
  integer1 EMAIL_shift0 := ROUND(Specificities[1].EMAIL_specificity - 0);
  integer2 EMAIL_switch_shift0 := ROUND(1000*Specificities[1].EMAIL_switch - 0);
  integer1 phone_shift0 := ROUND(Specificities[1].phone_specificity - 0);
  integer2 phone_switch_shift0 := ROUND(1000*Specificities[1].phone_switch - 0);
  integer1 LoanType_shift0 := ROUND(Specificities[1].LoanType_specificity - 0);
  integer2 LoanType_switch_shift0 := ROUND(1000*Specificities[1].LoanType_switch - 0);
  integer1 BESTTIME_shift0 := ROUND(Specificities[1].BESTTIME_specificity - 0);
  integer2 BESTTIME_switch_shift0 := ROUND(1000*Specificities[1].BESTTIME_switch - 0);
  integer1 MortRate_shift0 := ROUND(Specificities[1].MortRate_specificity - 0);
  integer2 MortRate_switch_shift0 := ROUND(1000*Specificities[1].MortRate_switch - 0);
  integer1 PROPERTYTYPE_shift0 := ROUND(Specificities[1].PROPERTYTYPE_specificity - 0);
  integer2 PROPERTYTYPE_switch_shift0 := ROUND(1000*Specificities[1].PROPERTYTYPE_switch - 0);
  integer1 RateType_shift0 := ROUND(Specificities[1].RateType_specificity - 0);
  integer2 RateType_switch_shift0 := ROUND(1000*Specificities[1].RateType_switch - 0);
  integer1 LTV_shift0 := ROUND(Specificities[1].LTV_specificity - 0);
  integer2 LTV_switch_shift0 := ROUND(1000*Specificities[1].LTV_switch - 0);
  integer1 YrsThere_shift0 := ROUND(Specificities[1].YrsThere_specificity - 0);
  integer2 YrsThere_switch_shift0 := ROUND(1000*Specificities[1].YrsThere_switch - 0);
  integer1 employer_shift0 := ROUND(Specificities[1].employer_specificity - 0);
  integer2 employer_switch_shift0 := ROUND(1000*Specificities[1].employer_switch - 0);
  integer1 credit_shift0 := ROUND(Specificities[1].credit_specificity - 0);
  integer2 credit_switch_shift0 := ROUND(1000*Specificities[1].credit_switch - 0);
  integer1 Income_shift0 := ROUND(Specificities[1].Income_specificity - 0);
  integer2 Income_switch_shift0 := ROUND(1000*Specificities[1].Income_switch - 0);
  integer1 LoanAmt_shift0 := ROUND(Specificities[1].LoanAmt_specificity - 0);
  integer2 LoanAmt_switch_shift0 := ROUND(1000*Specificities[1].LoanAmt_switch - 0);
  integer1 dt_shift0 := ROUND(Specificities[1].dt_specificity - 0);
  integer2 dt_switch_shift0 := ROUND(1000*Specificities[1].dt_switch - 0);
  integer1 ip_shift0 := ROUND(Specificities[1].ip_specificity - 0);
  integer2 ip_switch_shift0 := ROUND(1000*Specificities[1].ip_switch - 0);
  end;
export SpcShift := table(Specificities,SpcShiftR);
end;
