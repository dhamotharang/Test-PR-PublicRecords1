IMPORT doxie, Data_Services;


//  THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.
/*InpFile2 := PROJECT(InstantID_Archiving.Files_Base.InstantID_RedFlags + InstantID_Archiving.Files_Batch.InstantID_RedFlags, 
										TRANSFORM({STRING25 product := 'INSTANTID', InstantID_Archiving.Layouts.RedFlags}, 
																SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
																SELF := LEFT));*/
																
InstantID_RedFlags_base    := InstantID_Archiving.Files.InstantID_RedFlags_base;																
																
InpFile2 := PROJECT(InstantID_RedFlags_base + InstantID_Archiving.Files_Batch.InstantID_RedFlags, 
										TRANSFORM({STRING25 product := 'INSTANTID', InstantID_Archiving.Layouts.RedFlags}, 
																SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
																SELF := LEFT));
																
DstFile2 := DISTRIBUTE(InpFile2, HASH(transaction_ID, product, date_added));

SrtFile2 := SORT(DstFile2, RECORD, LOCAL);

DdpFile2 := DEDUP(SrtFile2, RECORD, LOCAL);

EXPORT Key_RedFlags := INDEX(DdpFile2, {transaction_id}, {DdpFile2}, 
														 Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::redflags', opt);
