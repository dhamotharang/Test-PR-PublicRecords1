export File_DL_OH_Update(string filedate) := function
	
	ds_oh_raw :=dataset(DriversV2.Constants.cluster+'in::dl2::'+ filedate +'::OH_Update_Raw',DriversV2.Layouts_DL_OH_In.Layout_OH_Raw 
											,csv(separator([['\t']]), quote('"'), terminator(['\n','\r\n','\n\r']), maxlength(1000),notrim)); 
	
	//Removing Special Chars from raw verdor data												
	fn_RemoveSpecialChars(string s, string replacement='') := function				
		stripInvalids := regexreplace('([ï»¿]+)',s,replacement);		
		return stripInvalids;
	end;

	DriversV2.Layouts_DL_OH_In.Layout_OH_Raw trfFixChars(DriversV2.Layouts_DL_OH_In.Layout_OH_Raw pInput)	:=	transform
		self.blob 	  :=	fn_RemoveSpecialChars(pInput.blob);
	end;
	
	RemoveBadChars	:= project(ds_oh_raw, trfFixChars(left));
																				
	ds_Oh_DMV 			:= project(RemoveBadChars,TRANSFORM(DriversV2.Layouts_DL_OH_In.Layout_OH_Update, 
																											self := transfer(left.blob,DriversV2.Layouts_DL_OH_In.Layout_OH_Update)
																						         )
											      );
	return	ds_Oh_DMV;		
											
end;
