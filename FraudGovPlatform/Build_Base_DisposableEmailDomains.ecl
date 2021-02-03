Import FraudShared,tools; 
EXPORT Build_Base_DisposableEmailDomains (
   string pversion	
	,dataset(FraudGovPlatform.Layouts.Input.DisposableEmailDomains) FileInput = FraudGovPlatform.Files().Input.DisposableEmailDomains.Sprayed
    ,dataset(FraudGovPlatform.Layouts.Base.DisposableEmailDomains) Previous_Build =  FraudGovPlatform.Files().Base.DisposableEmailDomains.QA
) := 
module 

	dFileBase 			:= DISTRIBUTE(PULL(FileInput), HASH32(domain));
	dPrevious_Build	:= DISTRIBUTE(PULL(Previous_Build), HASH32(domain));
	
	New_Records := JOIN(
		dFileBase,
		dPrevious_Build,
		LEFT.domain = RIGHT.domain,
		LEFT ONLY,
		LOCAL );

    pSlimDisposableEmailDomains := 
        PROJECT( New_Records, TRANSFORM($.Layouts.Base.DisposableEmailDomains, 
            SELF := LEFT ),
        LOCAL );

srt := sort(pSlimDisposableEmailDomains + Previous_Build, domain);
ddp := dedup (srt, domain) ;

valid_domains := distribute( ddp(domain != '') , hash32(domain));
tools.mac_WriteFile(Filenames(pversion).Base.DisposableEmailDomains.New,valid_domains,Build_Base_File,pCompress:=true,pHeading:=false,pOverwrite:=true);

// Return
	export full_build :=
		 sequential(
			  Build_Base_File
			// , Promote(pversion).buildfiles.New2Built
 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);
	
end;

