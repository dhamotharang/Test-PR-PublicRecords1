import Crim_Common;
Crim_Common.Layout_In_Court_Offender tDOC_Offender_To_Offender2(Crim_Common.Layout_In_DOC_Offender.previous pInput)
 :=
  transform
	self.state_origin := pInput.vendor;
	self.case_court := '';
	self.case_number:= '';
	self.case_name 	:= '';
	self.case_type_desc := 'Department of Corrections';
	self.case_type 	:= '';
	self.case_filing_dt := '';
	self.dl_num 	:= '';
	self.dl_state 	:= '';
	self.Height		:= if((integer2)pInput.Height = 0,'',pInput.Height);
	self.Weight		:= if((integer2)pInput.Weight = 0,'',pInput.Weight);
	self := pInput;
  end
 ;

export DOC_Offender_as_Offender2 := project(File_In_DOC_Offender,tDOC_Offender_To_Offender2(left));