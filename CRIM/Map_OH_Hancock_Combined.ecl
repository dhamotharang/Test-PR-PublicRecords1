import Crim_Common;

d := crim.File_OH_Hancock_old;

crim.Layout_OH_Hancock_New req_Out(d l) := TRANSFORM
SELF.Charge_Num				:= '';	
SELF.Charge_PleaCode		:= '';	
SELF.Charge_PleaCode_Dt		:= '';	
SELF.Charge_Decision		:= '';	
SELF.Charge_Decision_Dt		:= '';
SELF.Charge_Disp_Dt			:= '';
SELF.Charge_Disp_Code		:= '';	
SELF.Charge_Ticket_Num		:= '';	
SELF.Charge_Action_Code		:= '';	
SELF.Charge_Offense_Descr	:= '';	
SELF.Charge_Descr2			:= '';
SELF.Charge_DegreeOfOffense	:= '';
SELF.Charge_Indict_Charge	:= '';	
SELF.Charge_AMD_Charge		:= '';	
SELF.Charge_AMD_Charge_DGOF	:= '';	
SELF.Charge_ACNT_Change_Dt	:= '';	
SELF.Charge_Counts			:= '';
SELF.Charge_Misc_Track		:= '';
SELF := l;
END;

pOHCrim := project(d,req_out(left));

pOHComb := pOHCrim + crim.File_OH_Hancock_new;

export Map_OH_Hancock_Combined := pOHComb;