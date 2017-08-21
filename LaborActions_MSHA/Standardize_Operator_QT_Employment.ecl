import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Operator_QT_Employment := module

	export numeric_string := '0123456789';
	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Operator_QT_Employment.Input) pRawFileInput) := function    

		LaborActions_MSHA.Layouts_Operator_QT_Employment.Base	trf_Operator_QT_Employment(pRawFileInput l)	:=	transform
				self.Mine_Id									:= StringLib.StringToUpperCase(l.Mine_Id);
			  self.Mine_Id_Cleaned					:= IF(StringLib.StringFilter(self.Mine_Id,alpha_string)<>'',self.Mine_Id,(string)(integer4)self.Mine_Id);
				self.Sub_Unit									:= StringLib.StringToUpperCase(l.Sub_Unit);
				self.Sub_Unit_Cleaned					:= IF(StringLib.StringFilter(self.Sub_Unit,alpha_string)<>''
																						,self.Sub_Unit,
																						IF ((integer4)self.Sub_Unit = 0
																							,''
																							,(string)(integer4)self.Sub_Unit
																						)
																					);
				self.Sub_Unit_Description			:= IF(StringLib.StringFilter(l.Sub_Unit_Description,alpha_string)>'',StringLib.StringToUpperCase(l.Sub_Unit_Description),l.Sub_Unit_Description);
				self.Production_Year					:= IF(Length(StringLib.StringFilter(l.Production_Year,numeric_string))=4,l.Production_Year,'');	
				self.Production_Quarter				:= IF(l.Production_Quarter BETWEEN '1' AND '4',l.Production_Quarter,'');				
				self.QT_Fiscal_Year						:= IF(Length(StringLib.StringFilter(l.QT_Fiscal_Year,numeric_string))=4,l.QT_Fiscal_Year,'');	
				self.QT_Fiscal_Quarter				:= IF(l.QT_Fiscal_Quarter BETWEEN '1' AND '4',l.QT_Fiscal_Quarter,'');					
				self.Avg_Employee_Ct					:= IF(StringLib.StringFilter(l.Avg_Employee_Ct,alpha_string)<>'','0',(string)(integer)l.Avg_Employee_Ct); 
				self.Employee_Hours_Worked		:= IF(StringLib.StringFilter(l.Employee_Hours_Worked,alpha_string)<>'','0',(string)(integer)l.Employee_Hours_Worked);
				self.Coal_Production					:= IF(StringLib.StringFilter(l.Coal_Production,alpha_string)<>'','0',(string)(integer)l.Coal_Production);						
		 		self													:= l;
				self													:= [];
		end; //end trf_Operator_QT_Employment transform

		dPreProcess		:=	project(pRawFileInput, trf_Operator_QT_Employment(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Operator_QT_Employment.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput);
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Operator_QT_Employment
