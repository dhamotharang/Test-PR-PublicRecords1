

 import Fed_Bureau_Prisons;

  dedup_def := dedup(sort(Fed_Bureau_Prisons.file_in_defendant_federal_raw,record),record);
	dedup_off := dedup(sort(Fed_Bureau_Prisons.file_in_offense_federal_raw,record),record);
	dedup_sent := dedup(sort(Fed_Bureau_Prisons.file_in_sentence_federal_raw,record),record); 

  join_def_off := join(dedup_def,dedup_off,
                       left.recordid = right.recordid, left outer);
						
  join_def_off_sent := join(join_def_off,dedup_sent,
                      left.recordid = right.recordid, left outer);
											
											
	EXPORT raw_in_Fed_Bureau_Prisons := join_def_off_sent;										

