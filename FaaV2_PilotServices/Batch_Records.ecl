IMPORT Autokey_batch, AutokeyB2, BatchServices, BatchShare, doxie, faa, FaaV2_PilotServices, Suppress;

EXPORT batch_records (DATASET(FaaV2_PilotServices.layouts.batch_work) ds_work_recs,
	BatchShare.IParam.BatchParams in_mod,
	BOOLEAN isFCRA=FALSE) := FUNCTION

	// define values for obtaining autokeys and payloads
	ak_keyname:=faa.faa_airmen_ak_constants().str_autokeyname;
	ak_dataset:=faa.faa_airmen_ak_constants().ak_dataset;
	ak_skipSet:=faa.faa_airmen_ak_constants().ak_skipSet;
	ak_typeStr:=faa.faa_airmen_ak_constants().ak_typeStr;

	// Configure the autokey search
	ak_mod := MODULE(BatchServices.Interfaces.i_AK_Config)
		EXPORT skip_set := ak_skipset;
		EXPORT useAllLookups := TRUE;
	END;

	// get airmen records by autokey
	ds_ak_in:=PROJECT(ds_work_recs(did=0),Autokey_batch.Layouts.rec_inBatchMaster);
	ds_fids:=Autokey_batch.get_fids(ds_ak_in,ak_keyname,ak_mod);
	AutokeyB2.mac_get_payload(UNGROUP(ds_fids),ak_keyname,ak_dataset,ds_auto,did_out6,zero,ak_typeStr);
	ds_auto_airmen:=PROJECT(UNGROUP(ds_auto),TRANSFORM(FaaV2_PilotServices.Layouts.batch_out,
		SELF.did:=LEFT.did_out6,
		SELF.pilot_rec_id:=LEFT.unique_id,
		SELF.med_date:=IF(LEFT.med_date!='',LEFT.med_date[3..]+LEFT.med_date[..2]+'00',''),
		SELF.med_exp_date:=IF(LEFT.med_exp_date!='',LEFT.med_exp_date[3..]+LEFT.med_exp_date[..2]+'00',''),
		SELF:=LEFT,
		SELF:=[]));

	// get airmen records by did
	dids:=PROJECT(ds_work_recs(did>0),TRANSFORM(doxie.layout_references,SELF:=LEFT));
	ds_dids:=FaaV2_PilotServices.Raw.byDIDs_raw(dids,isFCRA);
	ds_did_airmen:=JOIN(ds_work_recs,ds_dids,LEFT.did=RIGHT.did,TRANSFORM(FaaV2_PilotServices.Layouts.batch_out,
		SELF.acctno:=LEFT.acctno,
		SELF.pilot_rec_id:=RIGHT.unique_id,
		SELF.med_date:=IF(RIGHT.med_date!='',RIGHT.med_date[3..]+RIGHT.med_date[..2]+'00',''),
		SELF.med_exp_date:=IF(RIGHT.med_exp_date!='',RIGHT.med_exp_date[3..]+RIGHT.med_exp_date[..2]+'00',''),
		SELF:=RIGHT,
		SELF:=[]));

	// apply suppressions
	Suppress.MAC_Suppress(ds_auto_airmen+ds_did_airmen,ds_dids_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(ds_dids_pulled,ds_dids_ssns_pulled,in_mod.application_type,Suppress.Constants.LinkTypes.SSN,best_ssn);

	// apply masking and descriptions
	ds_airmen_out:=PROJECT(ds_dids_ssns_pulled,TRANSFORM(FaaV2_PilotServices.Layouts.batch_out,
		SELF.best_ssn:=Suppress.ssn_mask(LEFT.best_ssn,in_mod.ssn_mask),
		SELF.region_desc:=FaaV2_PilotServices.functions.decode_Region(LEFT.region),
		SELF.med_class_desc:=FaaV2_PilotServices.functions.getMedicalClassLabel(LEFT.med_class),
		SELF:=LEFT));

	// OUTPUT(ds_auto,NAMED('ds_auto'));
	// OUTPUT(ds_auto_airmen,NAMED('ds_auto_airmen'));
	// OUTPUT(ds_dids,NAMED('ds_dids'));
	// OUTPUT(ds_did_airmen,NAMED('ds_did_airmen'));

	RETURN ds_airmen_out;

END;
