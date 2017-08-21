IMPORT doxie, Data_Services;

{STRING25 product, InstantID_Archiving.Layouts.ModelRisk}
																trInFIle(InstantID_Archiving.Layouts.ModelRisk L, STRING product) := TRANSFORM
																SELF.product := product;
																SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
																SELF := L;
END;



//  THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.																
//InpFile1 := PROJECT(InstantID_Archiving.Files_Base.InstantID_ModelRisk, trInFile(LEFT, 'INSTANTID')); 
//InpFile2 := PROJECT(InstantID_Archiving.Files_Base.FlexID_ModelRisk, trInFile(LEFT, 'FLEXID')); 
InstantID_ModelRisk_base   := InstantID_Archiving.Files.InstantID_ModelRisk_base;
FlexID_ModelRisk_base	     := InstantID_Archiving.Files.FlexID_ModelRisk_base;
InpFile1 := PROJECT(InstantID_ModelRisk_base, trInFile(LEFT, 'INSTANTID')); 
InpFile2 := PROJECT(FlexID_ModelRisk_base, trInFile(LEFT, 'FLEXID')); 
InpFile3 := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Modelrisk, trInFile(LEFT, 'INSTANTID')); 
InpFile4 := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Modelrisk, trInFile(LEFT, 'FLEXID')); 

InpFile := InpFile1 + InpFile2 + InpFile3 + InpFile4;

DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, RECORD, LOCAL);

DdpFile := DEDUP(SrtFile, RECORD, LOCAL);

EXPORT Key_ModelRisk := INDEX(DdpFile, {transaction_id, score_id}, {DdpFile}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::ModelRisk',opt);
															