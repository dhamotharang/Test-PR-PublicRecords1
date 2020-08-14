IMPORT Autokey_batch,address,didville,ut, VehicleV2_Services, STD;

today := (STRING8)Std.Date.Today();

EXPORT Functions_RTBatch_V2 := MODULE
  
  EXPORT clean(DATASET(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2) ds, VehicleV2_Services.IParam.RTBatch_V2_params in_mod) := FUNCTION
// BOOLEAN use_year, STRING yr_since,BOOLEAN checkdate = False

    BOOLEAN use_year := in_mod.select_years AND in_mod.years > 0;
    yr_today := (INTEGER) today[1..4];
    yr_since := (STRING) (yr_today - in_mod.years);
    BOOLEAN checkdate := in_mod.use_date;

    VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 clean(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2 le) := TRANSFORM
    // Converted name to uppercase as -Filter on first name-vixie ,Last Name-Inkhothavong was not working for VehicleV2_Services.RealTime_Batch_Service_V2_records.
      is_fullname := le.name_full <> '';
      cn := address.CleanNameFields(address.CleanPerson73(STD.STR.ToUpperCase(le.name_full)));
      SELF.name_first := IF(is_fullname, cn.fname, STD.STR.ToUpperCase(le.name_first));
      SELF.name_middle := IF(is_fullname, cn.mname, STD.STR.ToUpperCase(le.name_middle));
      SELF.name_last := IF(is_fullname, cn.lname, STD.STR.ToUpperCase(le.name_last));
      SELF.name_suffix := IF(is_fullname, cn.name_suffix, STD.STR.ToUpperCase(le.name_suffix));
      // address
      a1 := TRIM(le.addr1) + ' ' + le.addr2;
      a2 := le.p_city_name + ' ' + le.st + ' ' + le.z5;
      ca := address.GetCleanAddress(a1, a2, 0).results; // 0: USA, 1: Canada
      SELF.prim_range := ca.prim_range;
      SELF.predir := ca.predir;
      SELF.prim_name := ca.prim_name;
      SELF.addr_suffix := ca.suffix;
      SELF.postdir := ca.postdir;
      SELF.unit_desig := ca.unit_desig;
      SELF.sec_range := ca.sec_range;
      SELF.p_city_name := ca.p_city;
      SELF.st := IF(ca.state<>'',ca.state,le.st);
      SELF.z5 := ca.zip;
      SELF.zip4 := ca.zip4;
      SELF.date := MAP( use_year => yr_since
                      ,~checkdate => ''
                      , le.date);
      SELF.make := STD.STR.ToUpperCase(TRIM(le.make, LEFT, RIGHT));
      SELF.model := STD.STR.ToUpperCase(TRIM(le.model, LEFT, RIGHT));
      SELF.dob := IF(LENGTH(TRIM(le.dob))=8 AND le.dob<>'',TRIM(le.dob, LEFT, RIGHT),'');
      SELF.ssn := TRIM(le.ssn, LEFT, RIGHT);
      SELF.comp_name := STD.STR.ToUpperCase(TRIM(le.comp_name, LEFT, RIGHT));
      SELF := le;
    END;
    RETURN PROJECT(ds, clean(LEFT));
  END;

  EXPORT BOOLEAN ValidExpirationDate(STRING date_exp) := FUNCTION
    days_2yr := ut.DaysInNYears(2);
    days_apart := ut.DaysApart(today, date_exp);
    is_exp := (INTEGER) today - (INTEGER) date_exp >= 0;
    RETURN NOT(is_exp AND days_apart >= days_2yr);
  END;
  
  // returns the min of two dates (unless one is empty)
  EXPORT STRING min_date(STRING l, STRING r) :=
  FUNCTION
    RETURN IF(l<>'' AND r<>'', min(l, r), IF(l<>'', l, r));
  END;
  
  EXPORT VehicleV2_Services.Batch_Layout.LicPlate_InLayout to_licplate (VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 le) := TRANSFORM
    SELF.plateState := IF(le.plateState<>'',le.plateState,le.st);
    SELF.color := '';
    SELF := le;
  END;
  
  EXPORT VehicleV2_Services.Batch_Layout.Vin_BatchIn to_vin (VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 le) := TRANSFORM
    SELF.vin := le.vinin;
    SELF := le;
  END;

  EXPORT DidVille.Layout_Did_OutBatch to_reg1(VehicleV2_Services.Layouts_RTBatch_V2.rec_out le) := TRANSFORM
    SELF.seq := le.seq;
    SELF.fname := le.reg_1_fname;
    SELF.mname := le.reg_1_mname;
    SELF.lname := le.reg_1_lname;
    SELF.suffix := le.reg_1_name_suffix;
    a1 := le.reg_1_addr1 + ' ' + le.reg_1_addr2;
    a2 := le.reg_1_v_city_name + ' ' + le.reg_1_state + ' ' + le.reg_1_zip;
    ca := address.GetCleanAddress(a1, a2, 0).results;
    SELF.prim_range := ca.prim_range;
    SELF.predir := ca.predir;
    SELF.prim_name := ca.prim_name;
    SELF.addr_suffix := ca.suffix;
    SELF.postdir := ca.postdir;
    SELF.unit_desig := ca.unit_desig;
    SELF.sec_range := ca.sec_range;
    SELF.p_city_name := ca.p_city;
    SELF.st := ca.state;
    SELF.z5 := ca.zip;
    SELF.zip4 := ca.zip4;
    SELF := [];
  END;

  EXPORT DidVille.Layout_Did_OutBatch to_reg2(VehicleV2_Services.Layouts_RTBatch_V2.rec_out le) := TRANSFORM
    SELF.seq := le.seq;
    SELF.fname := le.reg_2_fname;
    SELF.mname := le.reg_2_mname;
    SELF.lname := le.reg_2_lname;
    SELF.suffix := le.reg_2_name_suffix;
    a1 := le.reg_2_addr1 + ' ' + le.reg_2_addr2;
    a2 := le.reg_2_v_city_name + ' ' + le.reg_2_state + ' ' + le.reg_2_zip;
    ca := address.GetCleanAddress(a1, a2, 0).results;
    SELF.prim_range := ca.prim_range;
    SELF.predir := ca.predir;
    SELF.prim_name := ca.prim_name;
    SELF.addr_suffix := ca.suffix;
    SELF.postdir := ca.postdir;
    SELF.unit_desig := ca.unit_desig;
    SELF.sec_range := ca.sec_range;
    SELF.p_city_name := ca.p_city;
    SELF.st := ca.state;
    SELF.z5 := ca.zip;
    SELF.zip4 := ca.zip4;
    SELF := [];
  END;

END;
