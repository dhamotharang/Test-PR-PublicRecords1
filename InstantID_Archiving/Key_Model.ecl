IMPORT doxie, Data_Services;

{STRING25 product, InstantID_Archiving.Layouts.Model}
																trInFIle(InstantID_Archiving.Layouts.Model L, STRING product) := TRANSFORM
																SELF.product := product;
																SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
																SELF := L;
END;



//  THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.
//InpFile1 := PROJECT(InstantID_Archiving.Files_Base.InstantID_Model, trInFile(LEFT, 'INSTANTID')); 
//InpFile2 := PROJECT(InstantID_Archiving.Files_Base.FlexID_Model, trInFile(LEFT, 'FLEXID'));
InstantID_Model_base := InstantID_Archiving.Files.InstantID_Model_base;
FlexID_Model_base	   := InstantID_Archiving.Files.FlexID_Model_base;														
InpFile1 := PROJECT(InstantID_Model_base, trInFile(LEFT, 'INSTANTID')); 
InpFile2 := PROJECT(FlexID_Model_base, trInFile(LEFT, 'FLEXID')); 
InpFile3 := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Model, trInFile(LEFT, 'INSTANTID')); 
InpFile4 := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Model, trInFile(LEFT, 'FLEXID')); 

InpFile := InpFile1 + InpFile2 + InpFile3 + InpFile4;

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, RECORD, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_Model := INDEX(DdpFile, {transaction_id, score_id}, {DdpFile}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::Model',opt);