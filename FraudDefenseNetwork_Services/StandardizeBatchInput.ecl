IMPORT FraudShared_Services;

EXPORT StandardizeBatchInput(
  DATASET(FraudDefenseNetwork_Services.Layouts.batch_search_rec) ds_in
) := FUNCTION

  // Because of the layout of the batch_search_rec,  SEQ needs to be already valued prior 
  // to calling this function in order to be able to reach back into the record correctly.

  FraudShared_Services.Layouts.BatchIn_rec xfm_ToBatchInRec(FraudDefenseNetwork_Services.Layouts.batch_search_rec L) := TRANSFORM
    SELF.acctno := (string)L.seq;
    SELF.p_city_name := L.v_city_name;
    SELF.z5 := L.zip5;
    SELF.phoneno := L.phone10;
    SELF.email_address := L.emailaddress;
    SELF.ip_address := L.ipaddress;
    SELF.device_id := L.deviceid;
    SELF := L;
    SELF := [];

/* automagically.....
    SELF.seq := L.seq;
    SELF.ssn := L.ssn;
    SELF.did := L.did;
    SELF.prim_range := L.prim_range;
    SELF.predir := L.predir;
    SELF.prim_name := L.prim_name;
    SELF.addr_suffix := L.addr_suffix;
    SELF.postdir := L.postdir;
    SELF.unit_desig := L.unit_desig;
    SELF.sec_range := L.sec_range;
    SELF.st := L.st;
    SELF.zip4 := L.zip4;
    SELF.ultid := L.ultid;
    SELF.orgid := L.orgid;
    SELF.seleid := L.seleid;
    SELF.tin := L.tin;
    SELF.appendedproviderid := L.appendedproviderid;
    SELF.lnpid := L.lnpid;
    SELF.npi := L.npi;
    SELF.professionalid := L.professionalid;
*/
  END;

  ds_converted := PROJECT(ds_in, xfm_ToBatchInRec(LEFT));
  
  RETURN ds_converted;
  
END;
