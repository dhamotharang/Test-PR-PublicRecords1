import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Contractor := module

	export numeric_string := '0123456789';
	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Contractor.Input) pRawFileInput) := function
		
		LaborActions_MSHA.Layouts_Contractor.base	trf_Contractor(LaborActions_MSHA.Layouts_Contractor.Input l)	:=	transform
			  self.Mine_Id								:= StringLib.StringToUpperCase(l.Mine_Id);
				self.Mine_Id_Cleaned				:= IF(StringLib.StringFilter(self.Mine_Id,alpha_string)<>'',self.Mine_Id,(string)(integer4)self.Mine_Id);
				self.Contractor_Id					:= StringLib.StringToUpperCase(l.Contractor_Id);
				self.Contractor_Id_Cleaned	:= IF(StringLib.StringFilter(self.Contractor_Id,alpha_string)<>''
																					,self.Contractor_Id,
																					IF ((integer4)self.Contractor_Id = 0
																						,''
																						,(string)(integer4)self.Contractor_Id
																					)
																				);
				self.Contractor_Name 				:= StringLib.StringToUpperCase(l.Contractor_Name);						
				Temp_Contractor_Start_Date	:= StringLib.StringFilter(l.Contractor_Start_Date,numeric_string);
				self.Contractor_Start_Date	:= IF (Temp_Contractor_Start_Date <> ' ',fFixDate(Temp_Contractor_Start_Date),Temp_Contractor_Start_Date);
				Temp_Contractor_End_Date		:= StringLib.StringFilter(l.Contractor_End_Date,numeric_string);				
				self.Contractor_End_Date		:= IF (Temp_Contractor_End_Date <> ' ',fFixDate(Temp_Contractor_End_Date),Temp_Contractor_End_Date);				
		 		self												:= l;
				self												:= [];
		end; //end trf_Contractor transform

		dPreProcess		:=	project(pRawFileInput, trf_Contractor(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Contractor.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput);
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Contractor 