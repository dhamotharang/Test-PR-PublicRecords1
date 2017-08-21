import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Contractor_CY_Employment := module

	export numeric_string := '0123456789';
	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Contractor_CY_Employment.Input) pRawFileInput) := function

		LaborActions_MSHA.Layouts_Contractor_CY_Employment.Base	trf_Contractor_CY_Employment(pRawFileInput l)	:=	transform
				self.Contractor_Id						:= StringLib.StringToUpperCase(l.Contractor_Id);
				self.Contractor_Id_Cleaned		:= IF(StringLib.StringFilter(self.Contractor_Id,alpha_string)<>''
																						,self.Contractor_Id,
																						IF ((integer4)self.Contractor_Id = 0
																							,''
																							,(string)(integer4)self.Contractor_Id
																						)
																					);
				self.Sub_Unit									:= StringLib.StringToUpperCase(l.Sub_Unit);
				self.Sub_Unit_Cleaned					:= IF(StringLib.StringFilter(self.Sub_Unit,alpha_string)<>''
																							,self.Sub_Unit,
																							IF ((integer4)self.Sub_Unit = 0
																								,''
																								,(string)(integer4)self.Sub_Unit
																							)
																						);				
				self.Commodity_Type						:= StringLib.StringToUpperCase(l.Commodity_Type);
				self.Calendar_Year					  := IF(Length(StringLib.StringFilter(l.Calendar_Year,numeric_string))=4,l.Calendar_Year,'');	
				self.Hours_Reported_for_Year  := IF(StringLib.StringFilter(l.Hours_Reported_for_Year,alpha_string)<>'','0',(string)(integer)l.Hours_Reported_for_Year);
				self.Annual_Coal_Production   := IF(StringLib.StringFilter(l.Annual_Coal_Production,alpha_string)<>'','0',(string)(integer)l.Annual_Coal_Production);
				self.Avg_Annual_Employee_Ct	  := IF(StringLib.StringFilter(l.Avg_Annual_Employee_Ct,alpha_string)<>'','0',(string)(integer)l.Avg_Annual_Employee_Ct);							
		 		self												  := l;
				self											 	  := [];
		end; //end trf_Contractor_CY_Employment transform

		dPreProcess		:=	project(pRawFileInput, trf_Contractor_CY_Employment(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Contractor_CY_Employment.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput);
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Contractor_CY_Employment
