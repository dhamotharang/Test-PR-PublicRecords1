export QA_Records(

	 dataset(Layouts.Base.Main                ) pBaseMain          = Files().Base.Main         .QA
	
) :=
function
import ut;
	//get new records for QA
	SampleFileMain_GLB5                 := topn(pBaseMain(source= 'GLB5'  and Reported_Date between   ut.getDateOffset(-180) and ut.getDateOffset(-180)),50,-process_date);
	SampleFileMain_OIG_Individual       := topn(pBaseMain(source= 'OIG_INDIVIDUAL'),50,-process_date);
	SampleFileMain_OIG_Business         := topn(pBaseMain(source= 'OIG_BUSINESS'),50,-process_date);
	SampleFileMain_TextMinedCrim        := topn(pBaseMain(source= 'TEXTMINEDCRIM' and DID<>0  and Event_Date between  ut.getDateOffset(-3650) and ut.getdate),50,-process_date);
	SampleFileMain_AInspection          := topn(pBaseMain(source= 'ADDRESSINSPECTION'   and Reported_Date between  ut.getDateOffset(-1095) and ut.getdate),50,-process_date);
	SampleFileMain                      := SampleFileMain_GLB5 + SampleFileMain_OIG_Individual + SampleFileMain_OIG_Business + SampleFileMain_TextMinedCrim + SampleFileMain_AInspection;
	SampleRecs := parallel(
		 output(sort(SampleFileMain,-record_id)                ,named('SampleNewMainRecordsForQA'),all)
			);
										
	return SampleRecs;

end;