import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Contractor_QT_Employment := module

	export numeric_string := '0123456789';
	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Contractor_QT_Employment.Input) pRawFileInput) := function

		LaborActions_MSHA.Layouts_Contractor_QT_Employment.Base	trf_Contractor_QT_Employment(pRawFileInput l)	:=	transform
				self.Contractor_Id				:= StringLib.StringToUpperCase(l.Contractor_Id);
				self.Contractor_Id_Cleaned:= IF(StringLib.StringFilter(self.Contractor_Id,alpha_string)<>''
																					,self.Contractor_Id,
																					IF ((integer4)self.Contractor_Id = 0
																						,''
																						,(string)(integer4)self.Contractor_Id
																					)
																				);
				self.Sub_Unit							:= StringLib.StringToUpperCase(l.Sub_Unit);
				self.Sub_Unit_Cleaned			:= IF(StringLib.StringFilter(self.Sub_Unit,alpha_string)<>''
																					,self.Sub_Unit,
																					IF ((integer4)self.Sub_Unit = 0
																						,''
																						,(string)(integer4)self.Sub_Unit
																					)
																				);
				self.Sub_Unit_Description	:= StringLib.StringToUpperCase(l.Sub_Unit_Description);	
				self.Production_Year			:= IF(Length(StringLib.StringFilter(l.Production_Year,numeric_string))=4,l.Production_Year,'');	
				self.Production_Quarter		:= IF(l.Production_Quarter BETWEEN '1' AND '4',l.Production_Quarter,'');				
				self.Fiscal_Year					:= IF(LENGTH(StringLib.StringFilter(l.Fiscal_Year,numeric_string))=4,l.Fiscal_Year,'');	
				self.Fiscal_Quarter				:= IF(l.Fiscal_Quarter BETWEEN '1' AND '4',l.Fiscal_Quarter,'');	
				self.Commodity_Type				:= StringLib.StringToUpperCase(l.Commodity_Type);
				self.Avg_Employee_Ct			:= IF(StringLib.StringFilter(l.Avg_Employee_Ct,alpha_string)<>'','0',(string)(integer)l.Avg_Employee_Ct);					
				self.Employee_Hours_Worked:= IF(StringLib.StringFilter(l.Employee_Hours_Worked,alpha_string)<>'','0',(string)(integer)l.Employee_Hours_Worked);
				self.Coal_Production			:= IF(StringLib.StringFilter(l.Coal_Production,alpha_string)<>'','0',(string)(integer)l.Coal_Production);	
		 		self											:= l;
				self											:= [];
		end; //end trf_Contractor_QT_Employment transform

		dPreProcess		:=	project(pRawFileInput, trf_Contractor_QT_Employment(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Contractor_QT_Employment.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput);
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Contractor_QT_Employment
