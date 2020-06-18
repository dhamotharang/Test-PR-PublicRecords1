export File_DL_OH_Update(string filedate) := function
	
	ds_oh_raw :=dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::OH_Update_Raw',DriversV2.Layouts_DL_OH_In.Layout_OH_Raw 
											,csv(separator([['\t']]), quote('"'), terminator(['\n','\r\n','\n\r']), maxlength(1000),notrim)); 


	DriversV2.Layouts_DL_OH_In.Layout_OH_Raw trfFixChars(DriversV2.Layouts_DL_OH_In.Layout_OH_Raw pInput)	:=	transform
		self.blob 	  :=	DriversV2.functions.fn_RemoveRawDataSpecialChars(pInput.blob);
	end;
	
	RemoveBadChars	:= project(ds_oh_raw , trfFixChars(left));
																				
	ds_Oh_DMV 			:= project(RemoveBadChars,TRANSFORM(DriversV2.Layouts_DL_OH_In.Layout_OH_Update, 
																											self := transfer(left.blob,DriversV2.Layouts_DL_OH_In.Layout_OH_Update)
																						         )
											      );														
	// For legal reasons any record for Edward L Kimito needs to be suppressed from the OH DL files. See DF-24042 for more info.													
	return	ds_Oh_DMV(DriversV2.functions.TrimUpper(First_Name)<>'EDWARD' and 
	                  DriversV2.functions.TrimUpper(Middle_Name)<>'L' and  
										DriversV2.functions.TrimUpper(Last_Name)<>'KOMITO');		
											
end;
