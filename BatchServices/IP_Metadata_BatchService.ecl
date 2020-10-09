/*--SOAP--
<message name="IP_Metadata_BatchService">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="30"/>
</message>
*/
/*
	batch_in fields:
	======================
	STRING20 acctno
	STRING45 IP_address1
	STRING45 IP_address2
	STRING45 IP_address3
*/

IMPORT BatchServices,BatchShare,Royalty,Std;

EXPORT IP_Metadata_BatchService() := MACRO

	ds_batch_in_raw := DATASET([],BatchServices.IP_Metadata_Layouts.batch_in_raw) : STORED('batch_in',FEW);

	BatchShare.MAC_SequenceInput(ds_batch_in_raw,ds_batch_in_seq);
	BatchServices.IP_Metadata_Layouts.batch_in normBatchRecs(ds_batch_in_seq L,INTEGER C) := TRANSFORM
		STRING IP_address:=CHOOSE(C,L.IP_address1,L.IP_address2,L.IP_address3);
		SELF.IP_address:=IF(IP_address!='',Std.Str.ToUpperCase(IP_address),SKIP);
		SELF:=L;
	END;
	ds_batch_in_normalized := NORMALIZE(ds_batch_in_seq,3,normBatchRecs(LEFT,COUNTER));

	ds_child_recs := BatchServices.IP_Metadata_Records(ds_batch_in_normalized/*,batch_params*/);
	ds_parent_recs := PROJECT(DEDUP(SORT(ds_batch_in_normalized,acctno),acctno),
		TRANSFORM(BatchServices.IP_Metadata_Layouts.batch_out_flat_acctno,SELF:=LEFT,SELF:=[]));

	ds_batch_out_denormalized := BatchShare.MAC_ExpandLayout.Denorm(ds_parent_recs,ds_child_recs,BatchServices.IP_Metadata_Layouts.batch_out_raw,'');
	BatchShare.MAC_RestoreAcctno(ds_batch_in_seq,ds_batch_out_denormalized,ds_batch_out_acctno,,FALSE);
	Results := PROJECT(ds_batch_out_acctno,BatchServices.IP_Metadata_Layouts.batch_out_flat);

  // Determine the Digital Envoy NetAcuity ip_metadata royalties for each acctno/ip_address
  ds_royalties_ip := Royalty.RoyaltyNetAcuityIpMetadata.GetBatchRoyaltiesByAcctno(ds_child_recs);
  ds_royalty_set  := Royalty.GetBatchRoyalties(ds_royalties_ip,FALSE); //FALSE=do not ReturnDetailedRoyalties

 	OUTPUT(Results,NAMED('Results'));
  OUTPUT(ds_royalty_set, NAMED('RoyaltySet'));

ENDMACRO;
