IMPORT doxie, Data_Services;

{STRING8 date_added, STRING30 product, STRING25 transaction_id, STRING20 company_id, STRING40 country}
																trInFIle(InstantID_Archiving.Layout_Base L) := TRANSFORM
																SELF.product := L.product;
																SELF.date_added := STRINGLIB.STRINGFILTER(L.date_added, '0123456789')[..8];
																SELF := L;
END;
																
InpFile := PROJECT(InstantID_Archiving.Files_Base.Delta + InstantID_Archiving.Files_Base_Batch.key_files, trInFIle(LEFT)); 

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, transaction_ID, product, date_added, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_DateAdded := INDEX(DdpFile, {company_id, product, date_added, country}, {DdpFile}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::dateadded', opt);
