IMPORT Corp2;
#workunit('name','Corp_basefile_details  ');
#workunit('priority','high');
#workunit('priority',11);
#option ('activitiesPerCpp', 50);

filterset := ['NM','ND','AZ','VT','MI'];

ds1a := dataset('~thor_data400::base::corp2::built::corp_xtnd',Corp2.Layout_Corporate_Direct_Corp_Base_Expanded, flat)(corp_state_origin in filterset);
srtds := SORT(ds1a,corp_state_origin,corp_process_date);
A := TABLE(srtds(corp_process_date > '20160630'),{corp_state_origin,corp_process_date,COUNT(GROUP)},corp_state_origin,corp_process_date);
output(A,,all); 
