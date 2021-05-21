import STD,ut,tools;

export Build_AgencyActivityDate_Base (
            string pversion
        , dataset(FraudGovPlatform.Layouts.Base.Main) pBaseFile = $.Files().Base.Main_Orig.Built 
        ) := 
module 

		PDelta	:= project(pBaseFile(Rin_Source in [4,5,6,7]),Transform(Layouts.Agencyactivitydate,self:=left));
		
		Base_Srt		:= choosen(sort(PDelta,-reported_date,-reported_time),1);
		
 tools.mac_WriteFile(FraudGovPlatform.Filenames(pversion).Base.AgencyActivityDate.New,Base_Srt,Build_Base_AgnencyActivityDate);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				  Build_Base_AgnencyActivityDate
				, Promote(pversion).buildfiles.New2Built
                )
		,output('No Valid version parameter passed, skipping Build_AgencyActivity atribute')
	);
end;
