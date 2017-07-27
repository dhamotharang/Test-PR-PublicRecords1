import OSHAIR,Business_Header,Lib_AddrClean,lib_stringlib;;

export normalize_optional_information(string filedate):= FUNCTION

input_OSHAIR := OSHAIR.File_in_OSHAIR;
optional_info_cleaned := OSHAIR.layout_OSHAIR_optional_info_clean;

/* Normalize the optional information sub-records*/
optional_info_cleaned normalize_optional_info(input_OSHAIR L, OSHAIR.layout_OSHAIR_in_ASCII.OSHAIR_optional_info_Rec R) := TRANSFORM
   self.Activity_Number := L.Activity_Number;
   self.Opt_Desc        := OSHAIR.Lookup_OSHAIR_Mini.Optional_Description_lookup(R.Opt_Type);
   self                 := R;
end;

ds_Optional_Information := normalize(input_OSHAIR,Left.Optional_Information,normalize_optional_info(LEFT,RIGHT));



return output(distribute(ds_Optional_Information
                         ,hash32(ds_Optional_Information.Activity_Number))
			  ,
			  ,'~thor_data400::base::oshair::' + filedate + '::optional_info'
			  ,overwrite);

end;
												