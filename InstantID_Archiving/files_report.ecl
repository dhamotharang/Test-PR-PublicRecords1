EXPORT files_report := module

IMPORT doxie, Data_Services;

{STRING30 product, InstantID_Archiving.Layouts.Report}
																trInFIle(InstantID_Archiving.Layouts.Report L, STRING product) := TRANSFORM
																SELF.date_added := STRINGLIB.STRINGFILTER(L.date_added, ' 0123456789');
																SELF.product := product;
																SELF.request_data := L.request_data;
																SELF.response_data := L.response_data;
																SELF := L;
END;


		
//  THE KEY IS NOW BUILT DIRECTLY FROM A BASE FILE, INSTEAD OF FROM THE INPUT FILE.		

/*InpFile1 := PROJECT(InstantID_Archiving.Files_Base.InstantID_Report, trInFile(LEFT, 'INSTANTID')); 
InpFile2 := PROJECT(InstantID_Archiving.Files_Base.InstantIDi_Report, trInFile(LEFT, 'INSTANTID INTERNATIONAL')); 
InpFile3 := PROJECT(InstantID_Archiving.Files_Base.FlexID_Report, trInFile(LEFT, 'FLEXID'));*/
InstantID_Report_base   := InstantID_Archiving.Files.InstantID_Report_base;
InstantIDi_Report_base  := InstantID_Archiving.Files.InstantIDi_Report_base;
FlexID_Report_base		  := InstantID_Archiving.Files.FlexID_Report_base;
InpFile1 := PROJECT(InstantID_Report_base, trInFile(LEFT, 'INSTANTID')); 
InpFile2 := PROJECT(InstantIDi_Report_base, trInFile(LEFT, 'INSTANTID INTERNATIONAL')); 
InpFile3 := PROJECT(FlexID_Report_base, trInFile(LEFT, 'FLEXID'));
InpFile4 := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Report, trInFile(LEFT, 'INSTANTID')); 
InpFile5 := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Report, trInFile(LEFT, 'FLEXID')); 


InpFile := InpFile1 + InpFile2 + InpFile3 + InpFile4 + InpFile5;


DstFile := DISTRIBUTE(InpFile, HASH(transaction_ID, product, date_added));

SrtFile := SORT(DstFile, RECORD, LOCAL);

shared DdpFile := DEDUP(SrtFile, RECORD, LOCAL);



InstantID_Archiving.Layouts.Reportk
																trInFIle1(DdpFile L) := TRANSFORM
																SELF.request_data := L.request_data[..5200];
																SELF.response_data := L.response_data[..22500];
																SELF := L;
end;

export reportFile := project(DdpFile, trInFIle1(left));

InstantID_Archiving.Layouts.Reportk
																trInFIle2(DdpFile L) := TRANSFORM					
																SELF.request_data := L.request_data[5201..10400];
																SELF.response_data := L.response_data[22501..45000];
																SELF := L;

END;


export reportFile1 := project(DdpFile, trInFIle2(left));


InstantID_Archiving.Layouts.Reportk
																trInFIle3(DdpFile L) := TRANSFORM					
																SELF.request_data := L.request_data[10401..15600];
																SELF.response_data := L.response_data[45001..67500];
																SELF := L;

END;

export reportFile2 := project(DdpFile, trInFIle3(left)); 

InstantID_Archiving.Layouts.Reportk
																trInFIle4(DdpFile L) := TRANSFORM					
																SELF.request_data := L.request_data[15601..20800];
																SELF.response_data := L.response_data[67501..90000];
																SELF := L;

END;

export reportFile3 := project(DdpFile, trInFIle4(left)); 

InstantID_Archiving.Layouts.Reportk
																trInFIle5(DdpFile L) := TRANSFORM					
																SELF.request_data := L.request_data[20801..26000];
																SELF.response_data := L.response_data[90001..112500];
																SELF := L;

END;

export reportFile4 := project(DdpFile, trInFIle5(left)); 

InstantID_Archiving.Layouts.Reportk
																trInFIle6(DdpFile L) := TRANSFORM					
																SELF.request_data := L.request_data[26001..31200];
																SELF.response_data := L.response_data[112501..135000];
																SELF := L;

END;

export reportFile5 := project(DdpFile, trInFIle6(left)); 

InstantID_Archiving.Layouts.Reportk
																trInFIle7(DdpFile L) := TRANSFORM					
																SELF.request_data := L.request_data[31201..36400];
																SELF.response_data := L.response_data[135001..157500];
																SELF := L;

END;

export reportFile6 := project(DdpFile, trInFIle7(left)); 

end;