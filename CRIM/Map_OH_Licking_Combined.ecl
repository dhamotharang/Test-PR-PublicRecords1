import Crim_Common, Address;

d1 		:= Crim.File_OH_Licking_Old(Defendant<>'Defendant');

Crim.Layout_OH_Licking_New tOHLayout1(d1 input) := Transform
self.DOB						:= '';
self.PreliminaryCaseNumber		:= '';
self.Jurisdiction				:= '';
self.Address					:= '';
self.City						:= '';
self.State						:= '';
self.Zip						:= '';
self.Attorney					:= '';
self.Degree						:= '';
self.OffenseDate				:= '';
self.ArrestDate					:= '';
self.Officer					:= '';
self.Complainant				:= '';
self.Prosecutor					:= '';
self.Judge						:= '';
self.Charge_Number				:= '';
self.Charge_PleaCode			:= '';
self.Charge_PleaCodeDate		:= '';
self.Charge_Decision			:= '';
self.Charge_DecisionDate		:= '';
self.Charge_DispositionDate		:= '';
self.Charge_DispositionCode		:= '';
self.Charge_TicketNumber		:= '';
self.Charge_ActionCode			:= '';
self.Charge_OffenseDescription	:= '';
self.Charge_Description			:= '';
self.Charge_DegreeOfOffense		:= '';
self.Charge_IndictCharge		:= '';
self.Charge_AMD_Charge			:= '';
self.Charge_AMD_Charge_DGOF		:= '';
self.Charge_ACNT_Change_Date	:= '';
self.Charge_Counts				:= '';
self.Charge_Misc_Track			:= '';
self							:= input;

end;

pOHLayout1 := project(d1, tOHLayout1(left));

d2 		:= Crim.File_OH_Licking_Old2(Defendant<>'Defendant');

Crim.Layout_OH_Licking_New tOHLayout2(d2 input) := Transform
self.Charge_Number				:= '';
self.Charge_PleaCode			:= '';
self.Charge_PleaCodeDate		:= '';
self.Charge_Decision			:= '';
self.Charge_DecisionDate		:= '';
self.Charge_DispositionDate		:= '';
self.Charge_DispositionCode		:= '';
self.Charge_TicketNumber		:= '';
self.Charge_ActionCode			:= regexreplace('[A-Z]+.|'+'[A-Z]+-',
									input.actioncode,
									'');
self.Charge_OffenseDescription	:= input.actioncode;
self.Charge_Description			:= '';
self.Charge_DegreeOfOffense		:= '';
self.Charge_IndictCharge		:= '';
self.Charge_AMD_Charge			:= '';
self.Charge_AMD_Charge_DGOF		:= '';
self.Charge_ACNT_Change_Date	:= '';
self.Charge_Counts				:= '';
self.Charge_Misc_Track			:= '';
self							:= input;

end;

pOHLayout2 := project(d2, tOHLayout2(left));


export Map_OH_Licking_Combined := pOHLayout1+pOHLayout2;