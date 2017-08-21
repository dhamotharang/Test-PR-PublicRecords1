IMPORT doxie, Data_Services;


{STRING25 product, InstantID_Archiving.Layouts.ModelIndex}
																trInFIle(InstantID_Archiving.Layouts.ModelIndex L, STRING product) := TRANSFORM
																SELF.product := product;
																SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
																SELF := L;
END;



//  THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.								
//InpFile := PROJECT(InstantID_Archiving.Files_Base.InstantID_ModelIndex + InstantID_Archiving.Files_Batch.InstantID_ModelIndex, trInFile(LEFT, 'INSTANTID')); 
InstantID_ModelIndex_base  := InstantID_Archiving.Files.InstantID_ModelIndex_base;
InpFile := PROJECT(InstantID_ModelIndex_base + InstantID_Archiving.Files_Batch.InstantID_ModelIndex, trInFile(LEFT, 'INSTANTID')); 

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, RECORD, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_RiskIndex := INDEX(DdpFile, {transaction_id, score_id}, {DdpFile}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::index', opt);