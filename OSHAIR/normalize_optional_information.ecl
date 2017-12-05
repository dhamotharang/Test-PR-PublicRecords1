import OSHAIR,Business_Header,Address,lib_stringlib,ut;

export normalize_optional_information(string filedate, string process_date):= FUNCTION

OptionalInfo 					:= oshair.files().input.OptionalInfo.using;
optional_info_cleaned := OSHAIR.layout_OSHAIR_optional_info_clean;

optional_info_cleaned normalize_optional_info(OptionalInfo L) := TRANSFORM
   self.dt_first_seen 						:=  (unsigned4)process_date;
	 self.dt_last_seen  						:=  (unsigned4)process_date;
	 self.dt_vendor_first_reported 	:=  (unsigned4)process_date;
	 self.dt_vendor_last_reported 	:=  (unsigned4)process_date; 
   self.Activity_Number						:=	(integer)l.activity_nr;
	 self.opt_id										:=	intformat((integer)l.opt_id,2,1);
   self.Opt_Desc        					:= 	OSHAIR.Lookup_OSHAIR_Mini.Optional_Description_lookup(l.Opt_Type);
   self                 					:= 	l;
	 self														:=	[];
end;

ds_Optional_Information := 	project(OptionalInfo,normalize_optional_info(LEFT));

dsAllOptInfo						:=	distribute((OSHAIR.Files().base.OptionalInfo.qa + ds_Optional_Information),hash32(Activity_Number));

OSHAIR.layout_OSHAIR_optional_info_clean RollupOptInfo(OSHAIR.layout_OSHAIR_optional_info_clean l, OSHAIR.layout_OSHAIR_optional_info_clean r) := transform
  self.dt_first_seen  				  := ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
	self.dt_last_seen 						:= MAX(l.dt_last_seen	 ,r.dt_last_seen	);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
  self.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
	self 													:= l;
end;

OptInfoRollup := rollup(sort(dsAllOptInfo,record, except dt_first_seen,dt_last_seen, 
														 dt_vendor_first_reported, dt_vendor_last_reported, local)
												, RollupOptInfo(left, right), record
												,except dt_first_seen, dt_last_seen, 
																dt_vendor_first_reported, dt_vendor_last_reported
												, local);

return output(OptInfoRollup,,'~thor_data400::base::oshair::' + filedate + '::optional_info',compressed,overwrite);

end;												