import OSHAIR,Business_Header,Lib_AddrClean,lib_stringlib;;

export normalize_violations(string filedate):= FUNCTION

input_OSHAIR := OSHAIR.File_in_OSHAIR;

violations_cleaned := OSHAIR.layout_OSHAIR_violations_clean;

/* Normalize the violations sub-records*/
violations_cleaned normalize_violation(input_OSHAIR L, OSHAIR.layout_OSHAIR_in_ASCII.OSHAIR_violations_Rec R) := TRANSFORM
   self.Activity_Number            := L.Activity_Number;
   self.Violation_Desc             := OSHAIR.Lookup_OSHAIR_Mini.Violation_lookup(R.Violation_Type);
   self.Related_Event_Desc         := OSHAIR.Lookup_OSHAIR_Mini.Related_Event_lookup(R.Related_Event_Code);
   self.Abatement_Comp_Desc        := OSHAIR.Lookup_OSHAIR_Mini.Abatement_Complete_lookup(R.Abatement_Complete);
   self.Disposition_Event_Desc     := OSHAIR.Lookup_OSHAIR_Mini.Disposition_Event_lookup(R.Disposition_Event);
   self.FTA_Disposition_Event_Desc := OSHAIR.Lookup_OSHAIR_Mini.FTA_Disposition_Event_lookup(R.FTA_Disposition_Event);
   self                            := R;
end;

ds_Violations := normalize(input_OSHAIR,Left.Violations,normalize_violation(LEFT,RIGHT));

return output(distribute(ds_Violations
                         ,hash32(ds_Violations.Activity_Number))
			  ,
			  ,'~thor_data400::base::oshair::' + filedate + '::violations'
			  ,overwrite);
end;
