export Layout_File_CA_Filing_Master_in 	:= record
						
						string8    process_date;
						string14   initial_filing_number;             //ucc1_num
						string14   ucc3_filing;                       //ucc3_num
						string29   ucc_filing_type_desc;              //action_type
						string29   filing_type_id;
						string8    filing_date;                       //filing_date_time
						string4    filing_time;                       //filing_date_time
						string8    lapse_date;                        //lapse_date
						string4    page_count;                        //page_count
						string1    filing_status;                     //derived based on lapse_date
end;