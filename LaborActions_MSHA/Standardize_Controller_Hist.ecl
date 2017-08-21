import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Controller_Hist := module

		export numeric_string := '0123456789';
		export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		
		export fPreProcess(dataset(LaborActions_MSHA.Layouts_Controller_Hist.Input) pRawFileInput) := function

		LaborActions_MSHA.Layouts_Controller_Hist.Base	trf_Controller_Hist(pRawFileInput l)	:=	transform
				self.Controller_Id					:= StringLib.StringToUpperCase(l.Controller_Id);
				self.Controller_Id_Cleaned	:= IF (StringLib.StringFilter(self.Controller_Id,alpha_string)<>''
																					,self.Controller_Id
																					,IF ((integer4)self.Controller_Id = 0
																						,''
																						,(string)(integer4)self.Controller_Id
																					)
																				);																					
				self.Operator_Id						:= StringLib.StringToUpperCase(l.Operator_Id);
			  self.Operator_Id_Cleaned		:= IF (StringLib.StringFilter(self.Operator_Id,alpha_string)<>''
																					,self.Operator_Id
																					,IF ((integer4)self.Operator_Id = 0
																						,''
																						,(string)(integer4)self.Operator_Id
																					)
																				);					
				self.Controller_Start_Date	:= IF (l.Controller_Start_Date <> ' ',fFixDate(StringLib.StringFilter(l.Controller_Start_Date,numeric_string)),l.Controller_Start_Date);
				self.Controller_Name				:= StringLib.StringToUpperCase(l.Controller_Name);
				self.Controller_End_Date		:= IF (l.Controller_End_Date <> ' ',fFixDate(StringLib.StringFilter(l.Controller_End_Date,numeric_string)),l.Controller_End_Date);
				self.Operator_Name					:= StringLib.StringToUpperCase(l.Operator_Name);								
		 		self												:=	l;
				self												:=	[];
		end; //end trf_Controller_Hist transform

		dPreProcess		:=	project(pRawFileInput, trf_Controller_Hist(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Controller_Hist.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput): persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Standardize_Controller_Hist');
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Controller_Hist 
