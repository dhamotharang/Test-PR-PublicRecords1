IMPORT Autokey_batch, AutokeyB2, BatchServices, FraudShared_Services, FraudShared;

EXPORT AutoKey_IDs(
  DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
  string fraud_platform
) := FUNCTION

  Autokey_batch.Layouts.rec_inBatchMaster xfm_AutoKey(FraudShared_Services.Layouts.BatchIn_rec L) := TRANSFORM
    SELF.homephone := L.phoneno;
    SELF.dl := L.dl_number;
    SELF.dlstate := L.dl_state;
    SELF := L;
    SELF := [];
// These fields are brought over automagically....
/*
    SELF.seq := L.seq;
    SELF.acctno := L.acctno;
    SELF.ssn := L.ssn;
    SELF.dob := L.dob;
    SELF.did := L.did;
    SELF.name_first := L.name_first;
    SELF.name_middle := L.name_middle;
    SELF.name_last := L.name_last;
    SELF.name_suffix := L.name_suffix;
    SELF.prim_range := L.prim_range;
    SELF.predir := L.predir;
    SELF.prim_name := L.prim_name;
    SELF.addr_suffix := L.addr_suffix;
    SELF.postdir := L.postdir;
    SELF.unit_desig := L.unit_desig;
    SELF.sec_range := L.sec_range;
    SELF.p_city_name := L.p_city_name;
    SELF.st := L.st;
    SELF.z5 := L.z5;
    SELF.zip4 := L.zip4;
*/
  END;

  ds_ak_batch_in := PROJECT(ds_batch_in, xfm_AutoKey(LEFT));

	// Define values for obtaining autokeys and payloads.
	ak_keyname := FraudShared.Constants(fraud_platform).ak_qa_keyname;
	ak_dataset := FraudShared.Constants(fraud_platform).ak_dataset;
	ak_skipSet := FraudShared.Constants(fraud_platform).AUTOKEY_SKIP_SET;
	ak_typestr := FraudShared.Constants(fraud_platform).TYPE_STR;

	ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
    export BOOLEAN useAllLookups := TRUE;
    export BOOLEAN workhard := TRUE;
	END;

	ds_fids := Autokey_batch.get_fids(ds_ak_batch_in, ak_keyname, ak_config_data);

	// Get autokey payloads (the real DIDs/BDIDs, record ids, and other goodies).		
	AutokeyB2.mac_get_payload(UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, did, bdid, ak_typeStr)

	return outpl;
end;