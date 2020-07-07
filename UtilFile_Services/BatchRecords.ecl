IMPORT BatchShare, UtilFile, Census_data, STD, Suppress;

EXPORT BatchRecords (DATASET(UtilFile_Services.Layouts.batch_work) ds_work_recs,
  BatchShare.IParam.BatchParams in_mod,
  BOOLEAN isFCRA=FALSE) := FUNCTION

  countyName(STRING2 st_in,STRING3 county_in) := FUNCTION
    RETURN Census_data.Key_Fips2County(KEYED(st_in=state_code AND county_in=county_fips))[1].county_name;
  END;

  ds_util_raw:=UtilFile_Services.Raw.byDIDs(ds_work_recs(did>0),in_mod,isFCRA);

  // work records put address in dataset
  ds_util_wrk:=PROJECT(ds_util_raw,TRANSFORM(UtilFile_Services.Layouts.util_work,
    SELF.name_first :=LEFT.fname,
    SELF.name_middle:=LEFT.mname,
    SELF.name_last  :=LEFT.lname,
    SELF.name_suffix:=LEFT.name_suffix,
    SELF.addresses:=PROJECT(LEFT,TRANSFORM(UtilFile_Services.Layouts.utilAddress,
      SELF.z5:=LEFT.zip,
      SELF.county_name:=countyName(LEFT.st,LEFT.county[3..5]),
      SELF:=LEFT)),
    SELF:=LEFT,
    SELF:=[]
    ));

  // roll records and set latest service and billing addresses
  UtilFile_Services.Layouts.util_work rollAddresses(UtilFile_Services.Layouts.util_work L,DATASET(UtilFile_Services.Layouts.util_work) R) := TRANSFORM
    sortAddrs:=SORT(R.addresses,-record_date);
    srvcAddr:=sortAddrs(addr_type=UtilFile_Services.Constants.SRVC)[1];
    billAddr:=sortAddrs(addr_type=UtilFile_Services.Constants.BILL)[1];
    SELF.addresses:=CHOOSEN(sortAddrs,UtilFile_Services.Constants.MAX_ADDR_RECS); // debug
    SELF.addr_type_1   := srvcAddr.addr_type;
    SELF.prim_range_1  := srvcAddr.prim_range;
    SELF.predir_1      := srvcAddr.predir;
    SELF.prim_name_1   := srvcAddr.prim_name;
    SELF.addr_suffix_1 := srvcAddr.addr_suffix;
    SELF.postdir_1     := srvcAddr.postdir;
    SELF.unit_desig_1  := srvcAddr.unit_desig;
    SELF.sec_range_1   := srvcAddr.sec_range;
    SELF.p_city_name_1 := srvcAddr.p_city_name;
    SELF.st_1          := srvcAddr.st;
    SELF.z5_1          := srvcAddr.z5;
    SELF.zip4_1        := srvcAddr.zip4;
    SELF.county_name_1 := srvcAddr.county_name;
    SELF.addr_type_2   := billAddr.addr_type;
    SELF.prim_range_2  := billAddr.prim_range;
    SELF.predir_2      := billAddr.predir;
    SELF.prim_name_2   := billAddr.prim_name;
    SELF.addr_suffix_2 := billAddr.addr_suffix;
    SELF.postdir_2     := billAddr.postdir;
    SELF.unit_desig_2  := billAddr.unit_desig;
    SELF.sec_range_2   := billAddr.sec_range;
    SELF.p_city_name_2 := billAddr.p_city_name;
    SELF.st_2          := billAddr.st;
    SELF.z5_2          := billAddr.z5;
    SELF.zip4_2        := billAddr.zip4;
    SELF.county_name_2 := billAddr.county_name;
    SELF:=L;
  END;

  ds_util_srt := SORT(ds_util_wrk,acctno,did,exchange_serial_number,util_type,-record_date);
  ds_util_grp := GROUP(ds_util_srt,acctno,did,exchange_serial_number,util_type);
  ds_util_roll := ROLLUP(ds_util_grp,GROUP,rollAddresses(LEFT,ROWS(LEFT)));

  // apply suppressions
  Suppress.MAC_Suppress(ds_util_roll,ds_util_dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(ds_util_dids_pulled,ds_util_ssns_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

  // apply masking and descriptions
  ds_util_recs:=PROJECT(ds_util_ssns_pulled,TRANSFORM(UtilFile_Services.Layouts.batch_out,
    DOB:=(UNSIGNED4)LEFT.DOB;
    MASKED_DOB:=Suppress.date_mask(DOB,in_mod.dob_mask);
    SELF.DOB:=IF(DOB!=0,MASKED_DOB.Year+MASKED_DOB.Month+MASKED_DOB.day,''),
    SELF.SSN:=Suppress.ssn_mask(LEFT.SSN,in_mod.ssn_mask),
    SELF.drivers_license:=IF(in_mod.dl_mask=1,Suppress.dl_mask(LEFT.drivers_license),LEFT.drivers_license),
    SELF.util_category:=UtilFile_Services.Constants.Util_Category_Desc(LEFT.util_type),
    utilType:=IF((UNSIGNED)LEFT.util_type>0,'',LEFT.util_type); // filter numeric types
    SELF.util_type_desc:=STD.Str.ToUpperCase(UtilFile.Util_Type_Desc(utilType)),
    SELF:=LEFT));

  // OUTPUT(SORT(ds_util_wrk,acctno,did,exchange_serial_number,util_type,-record_date),NAMED('ds_util_wrk'));
  // OUTPUT(SORT(ds_util_srt,record_date),NAMED('ds_util_srt'));
  // OUTPUT(SORT(ds_util_grp,record_date),NAMED('ds_util_grp'));
  // OUTPUT(SORT(ds_util_roll,acctno,record_date),NAMED('ds_util_roll'));

  RETURN ds_util_recs;

END;
