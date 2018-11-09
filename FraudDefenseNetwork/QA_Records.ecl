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
	SampleFileMain_ErieWatchList        := topn(pBaseMain(source= 'ERIE_WATCHLIST' and DID<>0 and classification_Entity.Entity_type ='PERSON' ),50,-process_date);
	SampleFileMain_ErieNICBWatchList    := topn(pBaseMain(source= 'ERIE_NICB_WATCHLIST' and DID<>0 and classification_Entity.Entity_type ='PERSON'),50,-process_date);
	SampleFileMain                      := SampleFileMain_GLB5 + SampleFileMain_OIG_Individual + SampleFileMain_OIG_Business + SampleFileMain_TextMinedCrim + SampleFileMain_AInspection + SampleFileMain_Erie + SampleFileMain_ErieWatchList + SampleFileMain_ErieNICBWatchList;
	
	didrec := RECORD,maxlength(60000)
  unsigned6 did;
  unsigned2 entity_type_id;
  unsigned2 entity_sub_type_id;
  unsigned8 record_id;
  unsigned8 uid;
 END;

didkey_qa     := index(dataset([],didrec),{DID , Entity_type_id, Entity_sub_type_id},{record_id , UID}, '~thor_data400::key::fdn::qa::did');

didkey_father := index(dataset([],didrec),{DID , Entity_type_id, Entity_sub_type_id},{record_id , UID}, '~thor_data400::key::fdn::father::did');



didSample     :=  join (didkey_qa,didkey_father,left.did=right.did,transform(recordof(didkey_qa),self := left),left only);

distdid := distribute( didSample,hash( did));


newbase := FraudShared.Files().Base.Main         .QA;

distmain := distribute ( newbase ( did <> 0 ), hash( did));


finaljoinrec := record
newbase.clean_address.prim_name;
newbase.clean_address.prim_range;
newbase.cleaned_name.lname;
newbase.cleaned_name.fname;
newbase.clean_address.st;
newbase.clean_address.p_city_name;
newbase.clean_address.zip;
newbase.bdid;
newbase.did;
newbase.record_id;
newbase.uid;
newbase.ip_address;
newbase.ultid;
newbase.classification_Permissible_use_access.gc_id;
newbase.classification_Permissible_use_access.fdn_file_info_id;
newbase.ssn;
end;

finaljoinrec  getdata( distmain l , distdid r ) := transform
self.prim_name := l.clean_address.prim_name;
self.prim_range := l.clean_address.prim_range;
self.st := l.clean_address.st;
self.p_city_name := l.clean_address.p_city_name;
self.zip := l.clean_address.zip;
self.lname := l.cleaned_name.lname;
self.fname := l.cleaned_name.fname;
self.gc_id := l.classification_Permissible_use_access.gc_id;
self.fdn_file_info_id := l.classification_Permissible_use_access.fdn_file_info_id;
self := l;

end;

did_join_main := join ( distmain, distdid ,left.did = right.did ,getdata(left,right), local);



SampleRecs   :=  parallel(
		                     output(sort(SampleFileMain,-record_id), named('SampleNewMainRecordsForQA'),all),
		 		                 output(choosen(didSample,250), named('DidSampleNewMainRecordsForQA')),
											output(choosen(did_join_main,500),named('Validation_Sample'))
												 );
										
	return SampleRecs;

end;