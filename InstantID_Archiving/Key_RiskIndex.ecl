IMPORT doxie;

{STRING25 product, InstantID_Archiving.Layouts.ModelIndex}
																trInFIle(InstantID_Archiving.Layouts.ModelIndex L, STRING product) := TRANSFORM
																SELF.product := product;
																SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
																SELF := L;
END;
																
InpFile := PROJECT(InstantID_Archiving.Files_Base.InstantID_ModelIndex + InstantID_Archiving.Files_Batch.InstantID_ModelIndex, trInFile(LEFT, 'INSTANTID')); 

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, transaction_ID, product, date_added, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_RiskIndex := INDEX(DdpFile, {transaction_id, score_id}, {DdpFile}, 
															'~thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::index', opt);