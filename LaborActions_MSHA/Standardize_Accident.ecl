import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Accident := module

	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Accident.Input) pRawFileInput) := function    
				
		LaborActions_MSHA.Layouts_Accident.Base	trf_Accident(pRawFileInput l)	:=	transform
				self.Mine_Id											:= StringLib.StringToUpperCase(l.Mine_Id);
			  self.Mine_Id_Cleaned							:= IF(StringLib.StringFilter(self.Mine_Id,alpha_string)<>'',self.Mine_Id,(string)(integer4)self.Mine_Id);
				self.Contractor_Id								:= StringLib.StringToUpperCase(l.Contractor_Id);
				self.Contractor_Id_Cleaned				:= IF(StringLib.StringFilter(self.Contractor_Id,alpha_string)<>''
																								,self.Contractor_Id,
																								IF ((integer4)self.Contractor_Id = 0
																									,''
																									,(string)(integer4)self.Contractor_Id
																								)
																							);
				self.Sub_Unit											:= StringLib.StringToUpperCase(l.Sub_Unit);
				self.Sub_Unit_Cleaned							:= IF(StringLib.StringFilter(self.Sub_Unit,alpha_string)<>''
																								,self.Sub_Unit,
																								IF ((integer4)self.Sub_Unit = 0
																									,''
																									,(string)(integer4)self.Sub_Unit
																								)
																							);
				self.Sub_Unit_Description					:= StringLib.StringToUpperCase(l.Sub_Unit_Description);						
				self.Accident_Date								:= IF (l.Accident_Date <> ' ',fFixDate(l.Accident_Date),l.Accident_Date);
				self.Degree_of_Injury							:= StringLib.StringToUpperCase(l.Degree_of_Injury);			
				self.Accident_Classification_Description := StringLib.StringToUpperCase(l.Accident_Classification_Description);						
				self.Occupation_Code_Description	:= StringLib.StringToUpperCase(l.Occupation_Code_Description);					
				self.Miner_Activity								:= StringLib.StringToUpperCase(l.Miner_Activity);
				self.Total_Experience							:= (udecimal4_2) l.Total_Experience;
				self.Mine_Experience							:= (udecimal4_2) l.Mine_Experience;
				self.Job_Experience								:= (udecimal4_2) l.Job_Experience;
				self.Accident_Narrative						:= StringLib.StringToUpperCase(l.Accident_Narrative);											
		 		self															:= l;
				self															:= [];
		end; //end trf_Accident transform

		dPreProcess		:=	project(pRawFileInput, trf_Accident(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Accident.Input) pRawFileInput) := function
		dPreprocess		:= fPreProcess(pRawFileInput);
		dAccidentBase	:= dPreprocess : persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Standardize_Accident');

		return dAccidentBase;
	end; //end fAll

end; //end Standardize_Accident