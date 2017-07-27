IMPORT AutokeyB2, Autokey_batch, BatchServices, FraudDefenseNetwork, FraudShared_Services;

EXPORT AutoKey_IDs(
  DATASET(FraudShared_Services.Layouts.batch_search_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_rec)
) := FUNCTION

  Autokey_batch.Layouts.rec_inBatchMaster xform(FraudShared_Services.Layouts.batch_search_rec L) := TRANSFORM
    SELF.acctno := (string)L.seq;
    SELF.p_city_name := L.v_city_name;
    SELF.z5 := L.zip5;
    SELF.ssn := L.ssn;
    SELF.homephone := L.Phone10;
    SELF := L;    
    SELF := [];
  END;
  
  ds_batch_in := PROJECT(ds_in, xform(LEFT));

  // Define values for obtaining autokeys and payloads.
  ak_keyname := FraudDefenseNetwork.Constants().ak_qa_keyname;
  ak_dataset := FraudDefenseNetwork.Constants().ak_dataset;
  ak_skipSet := FraudDefenseNetwork.Constants().AUTOKEY_SKIP_SET;
  ak_typestr := FraudDefenseNetwork.Constants().TYPE_STR;

  ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
    EXPORT boolean useAllLookups := TRUE;
  END;    

  /* ================ GET IDS VIA AUTOKEYS ================ */
    
  // 3. Get autokeys based on batch input.
  ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
                                    
  // 4. Get autokey payloads (the real DIDs/BDIDs, record ids, and other goodies).    
  AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, did, bdid, ak_typeStr )

  RETURN outpl;

END;