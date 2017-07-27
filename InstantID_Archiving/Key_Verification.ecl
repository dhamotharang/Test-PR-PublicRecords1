IMPORT doxie;

InpFile := PROJECT(InstantID_Archiving.Files_Base.InstantIDi_Verification, 
										TRANSFORM({STRING25 product := 'INSTANTID INTERNATIONAL', InstantID_Archiving.Layouts.Verification}, 
																SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
																SELF := LEFT));
																
DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, transaction_ID, product, date_added, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_Verification := INDEX(DdpFile, {transaction_id}, {DdpFile}, 
															'~thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::verification', opt);