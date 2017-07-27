#workunit('name','Update Deeds File');
new_file := property.File_Fares_Deeds_In;

//this part is to clean the sale_date_yyyymmdd and recording_date_yyyymmdd fields 
//of the new_file
NumSet := ['0','1','2','3','4','5','6','7','8','9'];

property.layout_fares_deeds new_file_date_tran(new_file L1) := Transform
   
   Self.sale_date_yyyymmdd := IF((L1.sale_date_yyyymmdd[1] In NumSet And
                                  L1.sale_date_yyyymmdd[2] In NumSet And
				              L1.sale_date_yyyymmdd[3] In NumSet And
				              L1.sale_date_yyyymmdd[4] In NumSet And
				              L1.sale_date_yyyymmdd[5] In NumSet And
				              L1.sale_date_yyyymmdd[6] In NumSet And
				              L1.sale_date_yyyymmdd[7] In NumSet And
				              L1.sale_date_yyyymmdd[8] In NumSet And
                                  ((Integer)(L1.sale_date_yyyymmdd[1..4]) >= 1900) And
                                  ((Integer)(L1.sale_date_yyyymmdd[5..6]) Between 1 And 12) And            
                                  ((Integer)(L1.sale_date_yyyymmdd[7..8]) Between 1 And 31)),
				              L1.sale_date_yyyymmdd, '');

   Self.recording_date_yyyymmdd := IF((L1.recording_date_yyyymmdd[1] In NumSet And
                                       L1.recording_date_yyyymmdd[2] In NumSet And
				                   L1.recording_date_yyyymmdd[3] In NumSet And
				                   L1.recording_date_yyyymmdd[4] In NumSet And
				                   L1.recording_date_yyyymmdd[5] In NumSet And
				                   L1.recording_date_yyyymmdd[6] In NumSet And
				                   L1.recording_date_yyyymmdd[7] In NumSet And
				                   L1.recording_date_yyyymmdd[8] In NumSet And
                                       ((Integer)(L1.recording_date_yyyymmdd[1..4]) >= 1900) And
                                       ((Integer)(L1.recording_date_yyyymmdd[5..6]) Between 1 And 12) And            
                                       ((Integer)(L1.recording_date_yyyymmdd[7..8]) Between 1 And 31)),
				                   L1.recording_date_yyyymmdd, '');

   Self := L1;
END;

valid_date_new_file := Project(new_file, new_file_date_tran(LEFT));
//end of cleaning

one := output(valid_date_new_file,,'~thor_data400::base::fares_1080'+thorlib.wuid());
two := fileservices.addsuperfile('~thor_data400::base::fares_1080','~thor_data400::base::fares_1080'+thorlib.wuid());
three := fileservices.clearsuperfile('~thor_data400::in::fares_1080',true);
sequential(one,two,three,property.Fares_Deeds_dedup,property.Fares_Search_dedup);