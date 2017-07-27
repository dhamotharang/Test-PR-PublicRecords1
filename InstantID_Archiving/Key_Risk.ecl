IMPORT doxie;

{STRING25 product, InstantID_Archiving.Layouts.Risk}
																trInFIle(InstantID_Archiving.Layouts.Risk L, STRING product) := TRANSFORM
																SELF.product := product;
																SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
																SELF := L;
END;
																
InpFile1 := PROJECT(InstantID_Archiving.Files_Base.InstantID_Risk, trInFile(LEFT, 'INSTANTID')); 
InpFile2 := PROJECT(InstantID_Archiving.Files_Base.InstantIDi_Risk, trInFile(LEFT, 'INSTANTID INTERNATIONAL')); 
InpFile3 := PROJECT(InstantID_Archiving.Files_Base.FlexID_Risk, trInFile(LEFT, 'FLEXID')); 
InpFile4 := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Risk, trInFile(LEFT, 'INSTANTID')); 
InpFile5 := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Risk, trInFile(LEFT, 'FLEXID')); 

InpFile := InpFile1 + InpFile2 + InpFile3 + InpFile4 + InpFile5;

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, transaction_ID, product, date_added, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_Risk := INDEX(DdpFile, {transaction_id}, {DdpFile}, 
															'~thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::risk', opt);
