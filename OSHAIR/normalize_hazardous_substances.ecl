import OSHAIR,Business_Header,Lib_AddrClean,lib_stringlib;;

export normalize_hazardous_substances(string filedate) := FUNCTION

input_OSHAIR := OSHAIR.File_in_OSHAIR;

hazardous_substance_cleaned := OSHAIR.layout_OSHAIR_hazardous_substance_clean;
/* Normalize the hazardous substance sub-records*/
hazardous_substance_cleaned normalize_hazardous_substance(input_OSHAIR L, OSHAIR.layout_OSHAIR_in_ASCII.OSHAIR_hazardous_substance_Rec R) := TRANSFORM
   self.Activity_Number      := L.Activity_Number;
   self.Hazardous_Sub_Desc_1 := OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(R.Hazardous_Substance_1);
   self.Hazardous_Sub_Desc_2 := OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(R.Hazardous_Substance_2);
   self.Hazardous_Sub_Desc_3 := OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(R.Hazardous_Substance_3);
   self.Hazardous_Sub_Desc_4 := OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(R.Hazardous_Substance_4);
   self.Hazardous_Sub_Desc_5 := OSHAIR.Lookup_OSHAIR.hazardous_substance_lookup(R.Hazardous_Substance_5);
   self := R;
end;

ds_Hazardous_Substances := normalize(input_OSHAIR,Left.Hazardous_Substances,normalize_hazardous_substance(LEFT,RIGHT));

return output(distribute(ds_Hazardous_Substances
                         ,hash32(ds_Hazardous_Substances.Activity_Number))
			  ,
			  ,'~thor_data400::base::oshair::' + filedate + '::hazardous_substance'
			  ,overwrite);
end;