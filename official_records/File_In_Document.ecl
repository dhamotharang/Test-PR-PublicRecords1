Official_Records.Macro_Input_File_List('_document',Official_Records.Layout_In_Document,dTempDataset)

dFilterDataset := dTempDataset(
									// Requested February 23, 2005
									TRIM(official_record_key) <>'11200203505296571810',
									TRIM(official_record_key) <>'1120020071770645446',
									// Requested March 23, 2005									
									TRIM(official_record_key) <>'112002013563464814403',
									TRIM(official_record_key) <>'112002013563564814405',
									TRIM(official_record_key) <>'112000039404260892356',
									TRIM(official_record_key) <>'11200004707096124870',
									TRIM(official_record_key) <>'11199802017655489286',
									TRIM(official_record_key) <>'111997022404752781318',
									TRIM(official_record_key) <>'111997009919252212646',
									TRIM(official_record_key) <>'112002046452966227154',
									TRIM(official_record_key) <>'110000539898049631525',
									TRIM(official_record_key) <>'110000533288749352528',
									TRIM(official_record_key) <>'110000533289249352536',
									TRIM(official_record_key) <>'112004067035176622826'
									);
									
export File_In_Document := dFilterDataset();