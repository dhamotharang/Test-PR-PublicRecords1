import ut, std, FraudShared;
export QA_Records(

	 dataset(FraudShared.Layouts.Base.Main                ) pBaseMain          = FraudShared.Files().Base.Main         .QA
	
) :=
function

	//get new records for QA
	SampleFileMain_GLB5                 := topn(pBaseMain(source= 'GLB5'  and Reported_Date between   ut.getDateOffset(-180) and ut.getDateOffset(-180)),50,-process_date);
	SampleFileMain_OIG_Individual       := topn(pBaseMain(source= 'OIG_INDIVIDUAL'),50,-process_date);
	SampleFileMain_OIG_Business         := topn(pBaseMain(source= 'OIG_BUSINESS'),50,-process_date);
	SampleFileMain_TextMinedCrim        := topn(pBaseMain(source= 'TEXTMINEDCRIM' and DID<>0  and Event_Date between  ut.getDateOffset(-3650) and (STRING8)Std.Date.Today()),50,-process_date);
	SampleFileMain_AInspection          := topn(pBaseMain(source= 'ADDRESSINSPECTION'   and Reported_Date between  ut.getDateOffset(-1095) and (STRING8)Std.Date.Today()),50,-process_date);
	SampleFileMain_Erie                 := topn(pBaseMain(source= 'ERIE' and DID<>0  and classification_Entity.Entity_sub_type ='' and Event_Date between  ut.getDateOffset(-1825) and (STRING8)Std.Date.Today()),50,-process_date);
	SampleFileMain                      := SampleFileMain_GLB5 + SampleFileMain_OIG_Individual + SampleFileMain_OIG_Business + SampleFileMain_TextMinedCrim + SampleFileMain_AInspection + SampleFileMain_Erie;
	
	didrec := RECORD,maxlength(60000)
  unsigned6 did;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;

didkey_qa     := index(dataset([],didrec),{DID , Entity_type_id, Entity_sub_type_id},{record_id , UID}, '~thor_data400::key::fdn::qa::did');

didkey_father := index(dataset([],didrec),{DID , Entity_type_id, Entity_sub_type_id},{record_id , UID}, '~thor_data400::key::fdn::father::did');

didSample     := join (didkey_qa,didkey_father,left.did=right.did,transform(recordof(didkey_qa),self := left),left only);

SampleRecs   :=  parallel(
		                     output(sort(SampleFileMain,-record_id), named('SampleNewMainRecordsForQA'),all),
		 		                 output(choosen(didSample,250), named('DidSampleNewMainRecordsForQA'))
												 );
										
	return SampleRecs;

end;