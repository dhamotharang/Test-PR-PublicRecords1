EXPORT Transforms := MODULE
	
	EXPORT _blank := '';

	EXPORT	MemberPoint.Layouts.reportservice_data_In  Trim_Input(MemberPoint.Layouts.reportservice_data_In  le) := TRANSFORM
		SELF.SSN_in := TRIM(le.SSN_in,left,right);
		SELF.Name_First := TRIM(le.Name_First,left,right);
		SELF.Name_Middle := TRIM(le.Name_Middle,left,right);
		SELF.Name_Last := TRIM(le.Name_Last,left,right);
		SELF.Name_Suffix := TRIM(le.Name_Suffix,left,right);
		SELF.DOB_in := TRIM(le.DOB_in,left,right);
		SELF.street_addr := TRIM(le.street_addr,left,right);
		SELF.p_City_name := TRIM(le.p_City_name,left,right);
		SELF.State_in := TRIM(le.State_in,left,right);
		SELF.Zip_in := TRIM(le.Zip_in,left,right);
		SELF := le;
	END;
    
  Export MemberPoint.Layouts.reportservice_data_Cln Clean(MemberPoint.Layouts.reportservice_data_in le, integer C) := TRANSFORM
		self.SSN_Cln := MemberPoint.Functions.SSNCleaner(le.SSN_in);
		self.ST_Cln := MemberPoint.Functions.StateCleaner(le.State_in);
		self.Z5_Cln := MemberPoint.Functions.ZIPCleaner(le.Zip_in);
		self.Name_First := MemberPoint.Functions.FirstAndLastNameValidator(le.Name_First);
		self.Name_Last := MemberPoint.Functions.FirstAndLastNameValidator(le.Name_Last);
		self := le;
		self:=[];
	END;
end;
