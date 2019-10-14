/*--SOAP--
<message name="BatchService">
  <part name="ApplicationType" type="xsd:string"/>
  <part name="IndustryClass"   type="xsd:string"/>
  <part name="GLBPurpose"      type="xsd:byte"/>
  <part name="SSNMask"         type="xsd:string"/>
  <part name="DOBMask"         type="xsd:string"/>
  <part name="DLMask"           type="xsd:string"/>
  <part name="batch_in"        type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchShare, WSInput;

EXPORT BatchService() := MACRO

  WSInput.MAC_Utility_BatchService();

  in_mod:=BatchShare.IParam.getBatchParams();

  ds_batch_in:=DATASET([],UtilFile_Services.Layouts.batch_in) : STORED('batch_in',FEW);
  BatchShare.MAC_SequenceInput(ds_batch_in,ds_seq_recs);

  // validate input records
  ds_wrk_recs:=PROJECT(ds_seq_recs,TRANSFORM(UtilFile_Services.Layouts.batch_work,
    // currently only valid input is did
    SELF.error_code:=IF(LEFT.did>0,
      BatchShare.Constants.ValidInput,
      UtilFile_Services.Constants.INSUFFICIENT_INPUT),
    SELF:=LEFT));

  ds_util_recs:=UtilFile_Services.BatchRecords(ds_wrk_recs(error_code=0),in_mod);

  ds_util_errs:=JOIN(ds_wrk_recs,ds_util_recs,LEFT.acctno=RIGHT.acctno,
    TRANSFORM(UtilFile_Services.Layouts.batch_out,
      SELF.acctno:=LEFT.acctno,
      SELF.did:=LEFT.did,
      SELF.error_code:=IF(LEFT.error_code>0,LEFT.error_code,UtilFile_Services.Constants.NO_RECORDS),
      SELF:=[]),
    LEFT ONLY);

  ds_srt_recs:=SORT(ds_util_recs+ds_util_errs,acctno,record_date);
  BatchShare.MAC_RestoreAcctno(ds_wrk_recs,ds_srt_recs,ds_results,TRUE,FALSE);

  // OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
  // OUTPUT(ds_wrk_recs,NAMED('ds_wrk_recs'));
  // OUTPUT(ds_util_recs,NAMED('ds_util_recs'));
  // OUTPUT(ds_util_errs,NAMED('ds_util_errs'));

  OUTPUT(ds_results,NAMED('Results'));

ENDMACRO;
