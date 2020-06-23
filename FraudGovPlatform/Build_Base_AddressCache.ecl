Import FraudShared,tools; 
EXPORT Build_Base_AddressCache (
   string pversion
	,dataset(Layouts.Base.AddressCache)	BaseAddressCache		= Files().Base.AddressCache.QA
	,dataset(FraudShared.Layouts.Base.Main) FileBase = IF(_Flags.FileExists.Base.MainOrig, FraudGovPlatform.Files().Base.Main_Orig.Built, DATASET([], FraudShared.Layouts.Base.Main))
  ,dataset(FraudShared.Layouts.Base.Main) Previous_Build = IF(_Flags.FileExists.Base.MainOrigQA, FraudGovPlatform.Files().Base.Main_Orig.QA, DATASET([], FraudShared.Layouts.Base.Main))
) := 
module 

	dFileBase 			:= DISTRIBUTE(PULL(FileBase), HASH32(record_id));
	dPrevious_Build	:= DISTRIBUTE(PULL(Previous_Build), HASH32(record_id));
	
	New_Records := JOIN(
		dFileBase,
		dPrevious_Build,
		LEFT.record_id = RIGHT.record_id,
		LEFT ONLY,
		LOCAL
	);

	pSlimMainAddress := table(New_Records, {
		clean_address.prim_range,
		clean_address.predir,	
		clean_address.prim_name,
		clean_address.addr_suffix,
		clean_address.postdir,
		clean_address.unit_desig,
		clean_address.sec_range,
		clean_address.p_city_name,
		clean_address.v_city_name,
		clean_address.st,
		clean_address.zip,
		clean_address.zip4,
		clean_address.cart,
		clean_address.cr_sort_sz,
		clean_address.lot,
		clean_address.lot_order,
		clean_address.dbpc,
		clean_address.chk_digit,
		clean_address.rec_type,
		clean_address.fips_state,
		clean_address.fips_county,
		clean_address.geo_lat,
		clean_address.geo_long,
		clean_address.msa,
		clean_address.geo_blk,
		clean_address.geo_match,
		clean_address.err_stat
	});

	pSlimAdditionalAddress := table(New_Records, {
		additional_address.clean_address.prim_range,
		additional_address.clean_address.predir,	
		additional_address.clean_address.prim_name,
		additional_address.clean_address.addr_suffix,
		additional_address.clean_address.postdir,
		additional_address.clean_address.unit_desig,
		additional_address.clean_address.sec_range,
		additional_address.clean_address.p_city_name,
		additional_address.clean_address.v_city_name,
		additional_address.clean_address.st,
		additional_address.clean_address.zip,
		additional_address.clean_address.zip4,
		additional_address.clean_address.cart,
		additional_address.clean_address.cr_sort_sz,
		additional_address.clean_address.lot,
		additional_address.clean_address.lot_order,
		additional_address.clean_address.dbpc,
		additional_address.clean_address.chk_digit,
		additional_address.clean_address.rec_type,
		additional_address.clean_address.fips_state,
		additional_address.clean_address.fips_county,
		additional_address.clean_address.geo_lat,
		additional_address.clean_address.geo_long,
		additional_address.clean_address.msa,
		additional_address.clean_address.geo_blk,
		additional_address.clean_address.geo_match,
		additional_address.clean_address.err_stat
	});	
	
	pNewAddresses := project(pSlimMainAddress + pSlimAdditionalAddress,transform(Layouts.Base.AddressCache,
		self.address_cleaned := (unsigned4)pversion[1..8];
		self := left;
		self := [];
	));
	
	SortedSlim := sort(pNewAddresses + BaseAddressCache,prim_range,prim_name,sec_range,zip,st,-address_cleaned);
	dedupSlim := dedup(SortedSlim, prim_range,prim_name,sec_range,zip,st);

	tools.mac_WriteFile(Filenames(pversion).Base.AddressCache.New,dedupSlim(prim_range != '' 	or prim_name != ''	or sec_range != ''	or zip != '' or st != ''),Build_Base_File,pCompress:=true,pHeading:=false,pOverwrite:=true);

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
