#workunit('name','Update Assessor File');
new_file := property.File_Fares_Assessor_In;

//this part is to clean the sale_date and recording_date fields of the new_file
NumSet := ['0','1','2','3','4','5','6','7','8','9'];

property.layout_fares_assessor new_file_date_tran(new_file L1) := Transform

   Self.sale_date := IF((L1.sale_date[1] In NumSet And
                         L1.sale_date[2] In NumSet And
				     L1.sale_date[3] In NumSet And
				     L1.sale_date[4] In NumSet And
				     L1.sale_date[5] In NumSet And
				     L1.sale_date[6] In NumSet And
				     L1.sale_date[7] In NumSet And
				     L1.sale_date[8] In NumSet And
                         ((Integer)(L1.sale_date[1..4]) >= 1900) And
                         ((Integer)(L1.sale_date[5..6]) Between 1 And 12) And            
                         ((Integer)(L1.sale_date[7..8]) Between 1 And 31)),
				     L1.sale_date, '');

   Self.recording_date := IF((L1.recording_date[1] In NumSet And
                              L1.recording_date[2] In NumSet And
				          L1.recording_date[3] In NumSet And
				          L1.recording_date[4] In NumSet And
				          L1.recording_date[5] In NumSet And
				          L1.recording_date[6] In NumSet And
				          L1.recording_date[7] In NumSet And
				          L1.recording_date[8] In NumSet And
                              ((Integer)(L1.recording_date[1..4]) >= 1900) And
                              ((Integer)(L1.recording_date[5..6]) Between 1 And 12) And            
                              ((Integer)(L1.recording_date[7..8]) Between 1 And 31)),
				          L1.recording_date, '');

   Self := L1;
END;

valid_date_new_file := Project(new_file, new_file_date_tran(LEFT));
//end of cleaning

one := output(valid_date_new_file,,'~thor_data400::base::fares_2580'+thorlib.wuid());
two := fileservices.addsuperfile('~thor_data400::base::fares_2580','~thor_data400::base::fares_2580'+thorlib.wuid());
three := fileservices.clearsuperfile('~thor_data400::in::fares_2580',true);
sequential(one,two,three,property.Fares_assessor_dedup);