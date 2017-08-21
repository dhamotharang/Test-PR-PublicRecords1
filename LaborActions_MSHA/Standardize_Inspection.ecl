import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Inspection := module

	export numeric_string := '0123456789';
	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Inspection.Input) pRawFileInput) := function
	
		LaborActions_MSHA.Layouts_Inspection.Base	trf_Inspection(pRawFileInput l)	:=	transform
				self.Mine_Id															:= StringLib.StringToUpperCase(l.Mine_Id);
			  self.Mine_Id_Cleaned											:= IF(StringLib.StringFilter(self.Mine_Id,alpha_string)<>'',self.Mine_Id,(string)(integer)self.Mine_Id);
				self.Event_No															:= StringLib.StringToUpperCase(l.Event_No);
				self.Event_No_Cleaned											:= IF(StringLib.StringFilter(self.Event_No,alpha_string)<>'',self.Event_No,(string)(integer)self.Event_No);
				self.Inspection_Activity_Code 						:= StringLib.StringToUpperCase(l.Inspection_Activity_Code);
				self.Inspection_Activity_Code_Cleaned			:= IF(StringLib.StringFilter(self.Inspection_Activity_Code,alpha_string)<>'',self.Inspection_Activity_Code,(string)(integer)self.Inspection_Activity_Code);
			  self.Inspection_Activity_Code_Description := StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Inspection_Activity_Code_Description));
			  self.Inspection_Begin_Date 								:= IF(l.Inspection_Begin_Date <> ' ',fFixDate(StringLib.StringFilter(l.Inspection_Begin_Date,numeric_string)),l.Inspection_Begin_Date);
			  self.Inspection_End_Date 	  							:= IF(l.Inspection_End_Date <> ' ',fFixDate(StringLib.StringFilter(l.Inspection_End_Date,numeric_string)),l.Inspection_End_Date);
			  self.Inspector_Office_Code								:= StringLib.StringToUpperCase(l.Inspector_Office_Code);
			  self.Active_Sections											:= IF(l.Active_Sections BETWEEN '0' AND '99',l.Active_Sections,'');
			  self.Idle_Sections												:= IF(l.Idle_Sections BETWEEN '0' AND '99',l.Idle_Sections,'');
			  self.Number_Of_Shaft_Slope_Sinking				:= IF(l.Number_Of_Shaft_Slope_Sinking BETWEEN '0' AND '99',l.Number_Of_Shaft_Slope_Sinking,'');
			  self.Impoundment_Construction							:= IF(l.Impoundment_Construction BETWEEN '0' AND '99',l.Impoundment_Construction,'');
			  self.Building_Construction_Sites					:= IF(l.Building_Construction_Sites BETWEEN '0' AND '99',l.Building_Construction_Sites,'');
			  self.Drag_Lines														:= IF(l.Drag_Lines BETWEEN '0' AND '99',l.Drag_Lines,'');
			  self.Number_Of_Unclassified_Construction	:= IF(l.Number_Of_Unclassified_Construction BETWEEN '0' AND '99',l.Number_Of_Unclassified_Construction,'');
			  self.Company_Records											:= IF(l.Company_Records IN ['0','Y','N'],l.Company_Records,'');
			  self.Surface_Underground_Indicator				:= IF(l.Surface_Underground_Indicator IN ['Y','N'],l.Surface_Underground_Indicator,'');
			  self.Surf_Facility_Indicator							:= IF(l.Surf_Facility_Indicator IN ['Y','N'],l.Surf_Facility_Indicator,'');
			  self.Refuse_Pile_Indicator								:= IF(l.Refuse_Pile_Indicator IN ['Y','N'],l.Refuse_Pile_Indicator,'');
			  self.Explosive_Storage										:= IF(l.Explosive_Storage IN ['Y','N'],l.Explosive_Storage,'');
			  self.Out_By_Area_Indicator								:= IF(l.Out_By_Area_Indicator IN ['Y','N'],l.Out_By_Area_Indicator,'');
			  self.Major_Construction_Indicator					:= IF(l.Major_Construction_Indicator IN ['Y','N'],l.Major_Construction_Indicator,'');
			  self.Shaft_Slope_Indicator								:= IF(l.Shaft_Slope_Indicator IN ['Y','N'],l.Shaft_Slope_Indicator,'');
			  self.Impoundment_Indicator								:= IF(l.Impoundment_Indicator IN ['Y','N'],l.Impoundment_Indicator,'');
			  self.Miscellaneous_Area										:= IF(l.Miscellaneous_Area IN ['Y','N'],l.Miscellaneous_Area,'');
				self.Program_Area													:= StringLib.StringToUpperCase(l.Program_Area);
			  self.Number_Of_Air_Samples								:= IF(l.Number_Of_Air_Samples BETWEEN '0' AND '9999',l.Number_Of_Air_Samples,'');
			  self.Number_Of_Dust_Samples								:= IF(l.Number_Of_Dust_Samples BETWEEN '0' AND '9999',l.Number_Of_Dust_Samples,'');
			  self.Number_Of_Survey_Samples							:= IF(l.Number_Of_Survey_Samples BETWEEN '0' AND '9999',l.Number_Of_Survey_Samples,'');
			  self.Number_Of_Respiratory_Dust_Samples		:= IF(l.Number_Of_Respiratory_Dust_Samples BETWEEN '0' AND '9999',l.Number_Of_Respiratory_Dust_Samples,'');
			  self.Number_Of_Noise_Samples							:= IF(l.Number_Of_Noise_Samples BETWEEN '0' AND '9999',l.Number_Of_Noise_Samples,'');
			  self.Number_Of_Other_Samples							:= IF(l.Number_Of_Other_Samples BETWEEN '0' AND '9999',l.Number_Of_Other_Samples,'');
			  self.Number_Of_Inspectors									:= IF(l.Number_Of_Inspectors	BETWEEN '0' AND '9999',l.Number_Of_Inspectors,'');
			  self.Total_On_Site_Hours									:= IF(l.Total_On_Site_Hours BETWEEN '0' AND '9999',l.Total_On_Site_Hours,'');
			  self.Total_Inspection_Hours								:= IF(l.Total_Inspection_Hours BETWEEN '0' AND '9999',l.Total_Inspection_Hours,'');
			  self.Coal_Metal_Indicator									:= IF(StringLib.StringFilter(StringLib.StringToUpperCase(l.Coal_Metal_Indicator),'CM') IN ['C','M'],l.Coal_Metal_Indicator,'');				
		 		self																			:=	l;
				self																			:=	[];
		end; //end trf_Inspection transform

		dPreProcess		:=	project(pRawFileInput, trf_Inspection(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Inspection.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput);
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Inspection