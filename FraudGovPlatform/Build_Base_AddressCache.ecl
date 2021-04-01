Import tools; 
EXPORT Build_Base_AddressCache (
   string pversion	
	,dataset(FraudGovPlatform.Layouts.Base.Main) FileBase = $.Files().Base.Main_Orig.Built
    ,dataset(FraudGovPlatform.Layouts.Base.Main) Previous_Build =  $.Files().Base.Main_Orig.QA
    ,dataset($.Layouts.Base.AddressCache) Previous_AddressCache = $.Files().Base.AddressCache.QA
) := 
module 

	dFileBase 			:= DISTRIBUTE(PULL(FileBase), HASH32(record_id));
	dPrevious_Build	:= DISTRIBUTE(PULL(Previous_Build), HASH32(record_id));
	
	New_Records := JOIN(
		dFileBase,
		dPrevious_Build,
		LEFT.record_id = RIGHT.record_id,
		LEFT ONLY,
		LOCAL );

    pSlimMainAddress := 
        PROJECT( New_Records, TRANSFORM($.Layouts.Base.AddressCache, 
            SELF.address_cleaned := LEFT.process_date,
            SELF := LEFT ),
        LOCAL );

    pSlimAdditionalAddress := 
        PROJECT( New_Records, TRANSFORM($.Layouts.Base.AddressCache, 
            SELF.street_1 := LEFT.additional_address.street_1,
            SELF.street_2 := LEFT.additional_address.street_2,
            SELF.city := LEFT.additional_address.city,
            SELF.state := LEFT.additional_address.state,
            SELF.zip := LEFT.additional_address.zip,
            SELF.clean_address := LEFT.additional_address.clean_address,
            SELF.address_cleaned := LEFT.process_date,
            SELF.address_1 := LEFT.additional_address.address_1,
            SELF.address_2 := LEFT.additional_address.address_2,
            SELF := LEFT ),
        LOCAL );

$.Layouts.Base.AddressCache get_best($.Layouts.Base.AddressCache L, $.Layouts.Base.AddressCache R) := transform 
    SELF := if( L.clean_address.err_stat[1] = 'S',  L, R);
end;
srt := sort(pSlimMainAddress + pSlimAdditionalAddress + Previous_AddressCache, Street_1, Street_2, City, State, Zip, -address_cleaned);
ddp := rollup (srt, get_best(LEFT,RIGHT),Street_1, Street_2, City, State, Zip) ;

valid_addresses := distribute(ddp(clean_address.err_stat[1] <> ''), hash32(Street_1, Street_2, City, State, Zip));
tools.mac_WriteFile(Filenames(pversion).Base.AddressCache.New,valid_addresses,Build_Base_File,pCompress:=true,pHeading:=false,pOverwrite:=true);

// Return
	export full_build :=
		 sequential(
			  Build_Base_File
			, Promote(pversion).buildfiles.New2Built
 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);
	
end;

