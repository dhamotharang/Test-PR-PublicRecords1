
export Proc_QA_Samples(string filedate, string process_date) := function

 newBase := dataset(OSHAIR.cluster + 'base::OSHAIR::'+filedate+'::inspection'
									,layout_OSHAIR_inspection_clean_BIP,thor);

 InspectionQAsamples := newBase((string)dt_first_seen = process_date);

 return output(topn(InspectionQAsamples,100,dt_first_seen),,NAMED('InspectionQAsamples'));
						  
end;