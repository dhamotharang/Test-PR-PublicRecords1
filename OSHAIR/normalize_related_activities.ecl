import OSHAIR,Business_Header,Lib_AddrClean,lib_stringlib;;

export normalize_related_activities(string filedate):= FUNCTION

input_OSHAIR             := OSHAIR.File_in_OSHAIR;
related_activity_cleaned := OSHAIR.layout_OSHAIR_related_activity_clean;

/* Normalize the related activity sub-records */
related_activity_cleaned normalize_related_activity(input_OSHAIR L, OSHAIR.layout_OSHAIR_in_ASCII.OSHAIR_related_activity_Rec R) := TRANSFORM
   self.Activity_Number    := L.Activity_Number;
   self.Rel_Activity_Desc  := OSHAIR.Lookup_OSHAIR_Mini.Related_Activity_lookup(R.Rel_Activity_Type);
   self := R;
end;

ds_Related_Activities := normalize(input_OSHAIR,Left.Related_Activties,normalize_related_activity(LEFT,RIGHT));


return output(distribute(ds_Related_Activities
                         ,hash32(ds_Related_Activities.Activity_Number))
	   ,
	   ,'~thor_data400::base::oshair::' + filedate + '::related_activity'
	   ,overwrite);

end;
