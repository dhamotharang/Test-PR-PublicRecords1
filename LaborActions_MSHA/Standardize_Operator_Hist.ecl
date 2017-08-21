import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Operator_Hist := module

	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Operator_Hist.Input) pRawFileInput) := function    
				
		LaborActions_MSHA.Layouts_Operator_Hist.Base	trf_Operator_Hist(pRawFileInput l)	:=	transform
				self.Mine_Id							:= StringLib.StringToUpperCase(l.Mine_Id);
			  self.Mine_Id_Cleaned			:= IF(StringLib.StringFilter(self.Mine_Id,alpha_string)<>'',self.Mine_Id,(string)(integer4)self.Mine_Id);
				self.Operator_Id					:= StringLib.StringToUpperCase(l.Operator_Id);
			  self.Operator_Id_Cleaned	:= IF(StringLib.StringFilter(self.Operator_Id,alpha_string)<>'',self.Operator_Id,(string)(integer4)self.Operator_Id);
				self.Operator_Start_Date  := LaborActions_MSHA.fFixDate(l.Operator_Start_Date);
				self.Operator_End_Date	  := LaborActions_MSHA.fFixDate(l.Operator_End_Date);
				self.Operator_Name				:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Operator_Name)));	
				self.Mine_Name						:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Mine_Name)));								
		 		self										  := l;
				self										  := [];
		end; //end trf_Operator_Hist transform

		dPreProcess		:=	project(pRawFileInput, trf_Operator_Hist(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Operator_Hist.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput): persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Standardize_Operator_Hist');
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Operator_Hist 
