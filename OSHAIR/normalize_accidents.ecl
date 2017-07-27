#option('skipFileFormatCrcCheck', 1);
import OSHAIR,Business_Header,Lib_AddrClean,lib_stringlib;;

export normalize_accidents(string filedate) := FUNCTION

input_OSHAIR     := OSHAIR.File_in_OSHAIR;
accident_cleaned := OSHAIR.layout_OSHAIR_accident_clean;

/* Normalize the accident sub-records*/
accident_cleaned normalize_accident(input_OSHAIR L, OSHAIR.layout_OSHAIR_in_ASCII.OSHAIR_accident_Rec R) := TRANSFORM
   string73 temp_name := Lib_AddrClean.AddrCleanLib.CleanPersonFML73(R.Name);
   self.Activity_Number    := L.Activity_Number;
   self.Age                := (Unsigned1)R.Age;
   self.Victim.title       := temp_name[1..5];
   self.Victim.fname       := temp_name[6..25];
   self.Victim.mname       := temp_name[26..45];
   self.Victim.lname       := temp_name[46..65];
   self.Victim.name_suffix := temp_name[66..70];
   self.Victim.name_score  := temp_name[71..73];
   self.Deg_of_Injury_Desc := OSHAIR.Lookup_OSHAIR_Mini.Degree_of_Injury_lookup(R.Degree_of_Injury);
   self.Nat_of_Inj_Desc    := OSHAIR.Lookup_OSHAIR.nature_injury_lookup(R.Nature_of_Injury);
   self.Part_of_Body_Desc  := OSHAIR.Lookup_OSHAIR.body_part_lookup(R.Part_of_Body);
   self.Src_of_Inj_Desc    := OSHAIR.Lookup_OSHAIR.src_injury_lookup(R.Source_of_Injury);
   self.Event_Desc         := OSHAIR.Lookup_OSHAIR.event_type_lookup(R.Event_Type);
   self.Env_Factor_Desc    := OSHAIR.Lookup_OSHAIR.env_factor_lookup(R.Environmental_Factor);
   self.Human_Factor_Desc  := OSHAIR.Lookup_OSHAIR.human_factor_lookup(R.Human_Factor);
   self.Task_Assigned_Desc := OSHAIR.Lookup_OSHAIR_Mini.Task_Assigned_lookup(R.Task_Assigned);
   self.Hazardous_Sub_Desc := OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(R.Hazardous_Substance);
   self.Occupation_Desc    := OSHAIR.Lookup_OSHAIR.occupation_lookup(R.Occupation_Code);
   self := R;
end;

ds_Accidents := normalize(input_OSHAIR,Left.Accidents,normalize_accident(LEFT,RIGHT));

return output(distribute(ds_Accidents
                         ,hash32(ds_Accidents.Activity_Number))
			  ,
			  ,'~thor_data400::base::oshair::' + filedate + '::accident'
			  ,overwrite);
end;
