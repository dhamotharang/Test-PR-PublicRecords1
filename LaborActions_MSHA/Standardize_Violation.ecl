import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Violation := module
	
	export numeric_string := '0123456789';
	export alpha_string 	:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Violation.Input) pRawFileInput) := function    
		
		LaborActions_MSHA.Layouts_Violation.Base	trf_Violation(pRawFileInput l)	:=	transform
				self.Dart_Id											:= StringLib.StringToUpperCase(l.Dart_Id);
				self.Event_No											:= StringLib.StringToUpperCase(l.Event_No);
				self.Event_No_Cleaned							:= IF(StringLib.StringFilter(self.Event_No,alpha_string)<>'',self.Event_No,(string)(integer)self.Event_No);		
				self.Contractor_Id								:= StringLib.StringToUpperCase(l.Contractor_Id);
				self.Contractor_Id_Cleaned				:= IF(StringLib.StringFilter(self.Contractor_Id,alpha_string)<>''
																								,self.Contractor_Id,
																								IF ((integer4)self.Contractor_Id = 0
																										,''
																										,(string)(integer4)self.Contractor_Id
																										)
																								);
				self.Violation_No									:= StringLib.StringToUpperCase(l.Violation_No);
				self.Violation_No_Cleaned					:= IF (StringLib.StringFilter(self.Violation_No,alpha_string)<>'',self.Violation_No,(string)(integer)(self.Violation_No));
				self.Date_Issued									:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Date_Issued,numeric_string)),StringLib.StringFilter(l.Date_Issued,numeric_string),'');
				self.S_S_Designation							:= StringLib.StringToUpperCase(l.S_S_Designation);
				self.Part_Section									:= StringLib.StringCleanSpaces(l.Part_Section);
				self.Type_of_Issuance							:= StringLib.StringCleanSpaces(l.Type_of_Issuance);
				self.CFR_30												:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.CFR_30));
				self.Date_Terminated							:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Date_Terminated,numeric_string)),StringLib.StringFilter(l.Date_Terminated,numeric_string),'');				
				self.Violator_ID									:= StringLib.StringToUpperCase(l.Violator_ID);				
				self.Violator_ID_Cleaned					:= IF (StringLib.StringFilter(self.Violator_ID,alpha_string)<>'',self.Violator_ID,(string)(integer)(self.Violator_ID));
				self.Violator_Name								:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Violator_Name));
				self.Proposed_Penalty_Amount			:= IF (StringLib.StringFilter(l.Proposed_Penalty_Amount,alpha_string)>'','',(string)(integer)(l.Proposed_Penalty_Amount));
				self.Current_Assessment_Amount		:= IF (StringLib.StringFilter(l.Current_Assessment_Amount,alpha_string)>'','',(string)(integer)(l.Current_Assessment_Amount));
				self.Paid_Proposed_Penalty_Amount	:= IF (StringLib.StringFilter(l.Paid_Proposed_Penalty_Amount,alpha_string)>'','',(string)(integer)(l.Paid_Proposed_Penalty_Amount));
				self.Final_Order_Date							:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Final_Order_Date,numeric_string)),StringLib.StringFilter(l.Final_Order_Date,numeric_string),'');				
				self.Violator_Type								:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Violator_Type));
				self.Violation_Occur_Date					:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Violation_Occur_Date,numeric_string)),StringLib.StringFilter(l.Violation_Occur_Date,numeric_string),'');				
				self.Violation_Calendar_Year			:= IF (Length(StringLib.StringFilter(l.Violation_Calendar_Year,numeric_string))=4,StringLib.StringFilter(l.Violation_Calendar_Year,numeric_string),'');	 
				self.Violation_Calendar_Quarter		:= IF (l.Violation_Calendar_Quarter BETWEEN '1' AND '4',l.Violation_Calendar_Quarter,'');				 
				self.Violation_Fiscal_Year				:= IF (Length(StringLib.StringFilter(l.Violation_Fiscal_Year,numeric_string))=4,StringLib.StringFilter(l.Violation_Fiscal_Year,numeric_string),'');	
				self.Violation_Fiscal_Quarter			:= IF (l.Violation_Fiscal_Quarter BETWEEN '1' AND '4',l.Violation_Fiscal_Quarter,''); 
				self.Violation_Issue_Time					:= IF (Length(StringLib.StringFilter(l.Violation_Issue_Time,numeric_string))=4,StringLib.StringFilter(l.Violation_Issue_Time,numeric_string),'');
				self.Section_of_Act								:= StringLib.StringCleanSpaces(l.Section_of_Act);
				self.Section_Of_Act2							:= StringLib.StringCleanSpaces(l.Section_Of_Act2);
				self.Orig_Termination_Due_Date		:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Orig_Termination_Due_Date,numeric_string)),StringLib.StringFilter(l.Orig_Termination_Due_Date,numeric_string),'');	
				self.Orig_Termination_Due_Time		:= IF (Length(StringLib.StringFilter(l.Orig_Termination_Due_Time,numeric_string))=4,StringLib.StringFilter(l.Orig_Termination_Due_Time,numeric_string),'');
				self.Latest_Termination_Due_Date	:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Latest_Termination_Due_Date,numeric_string)),StringLib.StringFilter(l.Latest_Termination_Due_Date,numeric_string),'');	
				self.Latest_Termination_Due_Time	:= IF (Length(StringLib.StringFilter(l.Latest_Termination_Due_Time,numeric_string))=4,StringLib.StringFilter(l.Latest_Termination_Due_Time,numeric_string),'');
				self.Termination_Time							:= IF (Length(StringLib.StringFilter(l.Termination_Time,numeric_string))=4,StringLib.StringFilter(l.Termination_Time,numeric_string),'');
				self.Termination_Type							:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Termination_Type));
				self.Initial_Violation_No					:= StringLib.StringFilter(l.Initial_Violation_No,numeric_string);
				self.Replaced_Order_No						:= StringLib.StringFilter(l.Replaced_Order_No,numeric_string);
				self.Likelihood										:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Likelihood));
				self.Injury_Illness								:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Injury_Illness));
				self.No_Of_Person_Affected				:= StringLib.StringFilter(l.No_Of_Person_Affected,numeric_string);
				self.Negligence										:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Negligence));
				self.Written_Notice								:= StringLib.StringToUpperCase(l.Written_Notice);
				self.Enforcement_Area							:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Enforcement_Area));
				self.Special_Assess								:= StringLib.StringToUpperCase(l.Special_Assess);
				self.Primary_Or_Assoc_Mill				:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Primary_Or_Assoc_Mill));
				self.Right_To_Conference_Date			:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Right_To_Conference_Date,numeric_string)),StringLib.StringFilter(l.Right_To_Conference_Date,numeric_string),'');	
				self.Violator_Type_Indicator			:= StringLib.StringToUpperCase(l.Violator_Type_Indicator);
				self.Bill_Print_Date							:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Bill_Print_Date,numeric_string)),StringLib.StringFilter(l.Bill_Print_Date,numeric_string),'');	
				self.Last_Action_Code							:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Last_Action_Code));
				self.Last_Action_Date							:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Last_Action_Date,numeric_string)),StringLib.StringFilter(l.Last_Action_Date,numeric_string),'');					
				self.Docket_No										:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Docket_No));
				self.Docket_Status_Code						:= StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.Docket_Status_Code));
				self.Contested_Date								:= IF (_validate.date.fIsValid(StringLib.StringFilter(l.Contested_Date,numeric_string)),StringLib.StringFilter(l.Contested_Date,numeric_string),'');	
				self															:= l;
				self															:= [];
		end; //end trf_Violation transform

		dPreProcess		:=	project(pRawFileInput, trf_Violation(left));

		return dPreProcess;

	end; //end fPreProcess function
   
	export fAll( dataset(LaborActions_MSHA.Layouts_Violation.Input) pRawFileInput) := function
		dPreprocess	:= fPreProcess(pRawFileInput);
		return dPreprocess;
	end; //end fAll

end; //end Standardize_Violation
