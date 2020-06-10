Import FraudShared,tools; 
EXPORT Build_Base_AddressCache (
   string pversion
	,dataset(FraudShared.Layouts.address_cleaner) BaseAddressCache = Files().Base.AddressCache.QA
	,dataset(FraudShared.Layouts.Base.Main) FileBase = FraudShared.Files().Base.Main.Built 
    ,dataset(FraudShared.Layouts.Base.Main) Previous_Build = FraudShared.Files().Base.Main.QA
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

	pSlimMainAddress := project ( New_Records, transform( FraudShared.Layouts.address_cleaner, self := left ) ); 
	pSlimAdditionalAddress := project ( New_Records, transform( FraudShared.Layouts.address_cleaner, 
		self.street_1 := left.additional_address.street_1;
		self.street_2 := left.additional_address.street_2;
		self.city := left.additional_address.city;
		self.state := left.additional_address.state;
		self.zip := left.additional_address.zip;
		self.address_type := left.additional_address.address_type;
		self.clean_address.prim_range := left.additional_address.clean_address.prim_range;
		self.clean_address.predir := left.additional_address.clean_address.predir;	
		self.clean_address.prim_name := left.additional_address.clean_address.prim_name;
		self.clean_address.addr_suffix := left.additional_address.clean_address.addr_suffix;
		self.clean_address.postdir := left.additional_address.clean_address.postdir;
		self.clean_address.unit_desig := left.additional_address.clean_address.unit_desig;
		self.clean_address.sec_range := left.additional_address.clean_address.sec_range;
		self.clean_address.p_city_name := left.additional_address.clean_address.p_city_name;
		self.clean_address.v_city_name := left.additional_address.clean_address.v_city_name;
		self.clean_address.st := left.additional_address.clean_address.st;
		self.clean_address.zip := left.additional_address.clean_address.zip;
		self.clean_address.zip4 := left.additional_address.clean_address.zip4;
		self.clean_address.cart := left.additional_address.clean_address.cart;
		self.clean_address.cr_sort_sz := left.additional_address.clean_address.cr_sort_sz;
		self.clean_address.lot := left.additional_address.clean_address.lot;
		self.clean_address.lot_order := left.additional_address.clean_address.lot_order;
		self.clean_address.dbpc := left.additional_address.clean_address.dbpc;
		self.clean_address.chk_digit := left.additional_address.clean_address.chk_digit;
		self.clean_address.rec_type := left.additional_address.clean_address.rec_type;
		self.clean_address.fips_state := left.additional_address.clean_address.fips_state;
		self.clean_address.fips_county := left.additional_address.clean_address.fips_county;
		self.clean_address.geo_lat := left.additional_address.clean_address.geo_lat;
		self.clean_address.geo_long := left.additional_address.clean_address.geo_long;
		self.clean_address.msa := left.additional_address.clean_address.msa;
		self.clean_address.geo_blk := left.additional_address.clean_address.geo_blk;
		self.clean_address.geo_match := left.additional_address.clean_address.geo_match;
		self.clean_address.err_stat := left.additional_address.clean_address.err_stat;
		self := left 
	
	) ); 

FraudShared.Layouts.address_cleaner get_best(FraudShared.Layouts.address_cleaner L, FraudShared.Layouts.address_cleaner R) := transform 
    SELF := if( L.clean_address.err_stat[1] = 'S',  L, R);
end;
srt := sort(pSlimMainAddress + pSlimAdditionalAddress + BaseAddressCache, State, City, Zip, Street_1, Street_2 );
ddp := rollup (srt, get_best(LEFT,RIGHT),State, City, Zip, Street_1, Street_2 , LOCAL ) ;
valid_addresses := ddp(clean_address.err_stat = 'S');
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
