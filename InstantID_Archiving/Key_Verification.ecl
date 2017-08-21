IMPORT doxie, Data_Services;


//  THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.

/*InpFile := PROJECT(InstantID_Archiving.Files_Base.InstantIDi_Verification, 
										TRANSFORM({STRING25 product := 'INSTANTID INTERNATIONAL', InstantID_Archiving.Layouts.Verification}, 
																SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
																SELF := LEFT));*/
																
InstantIDi_Verification_base := InstantID_Archiving.Files.InstantIDi_Verification_base;																
																
InpFile := PROJECT(InstantIDi_Verification_base, 
										TRANSFORM({STRING25 product := 'INSTANTID INTERNATIONAL', InstantID_Archiving.Layouts.Verification}, 
																SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
																SELF := LEFT));
																
DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, RECORD, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_Verification := INDEX(DdpFile, {transaction_id}, {DdpFile}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::verification', opt);