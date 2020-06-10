IMPORT FraudShared,address,tools;
EXPORT Append_CleanAddress (
	 dataset(FraudShared.Layouts.Base.Main) FileBase
) := FUNCTION

    AddressCache := Files().Base.AddressCache.QA;

	slim_in := Project( FileBase , TRANSFORM( FraudGovPlatform.Layouts.Temp.CleanAddressSlim , 
    SELF.record_id                      := LEFT.record_id;
    SELF.street_1                       := LEFT.street_1;
    SELF.street_2                       := LEFT.street_2;
    SELF.city                           := LEFT.city;
    SELF.state                          := LEFT.state;
    SELF.zip                            := LEFT.zip;        
    SELF.address_1                      := LEFT.address_1;
    SELF.address_2                      := LEFT.address_2;
    SELF.Address_Type                   := LEFT.Address_Type;
    SELF.clean_address.prim_range		:= LEFT.clean_address.prim_range;
    SELF.clean_address.predir			:= LEFT.clean_address.predir;
    SELF.clean_address.prim_name		:= LEFT.clean_address.prim_name;
    SELF.clean_address.addr_suffix		:= LEFT.clean_address.addr_suffix;
    SELF.clean_address.postdir			:= LEFT.clean_address.postdir;
    SELF.clean_address.unit_desig		:= LEFT.clean_address.unit_desig;
    SELF.clean_address.sec_range		:= LEFT.clean_address.sec_range;
    SELF.clean_address.p_city_name	 	:= LEFT.clean_address.p_city_name;
    SELF.clean_address.v_city_name		:= LEFT.clean_address.v_city_name;
    SELF.clean_address.st				:= LEFT.clean_address.st;
    SELF.clean_address.zip				:= LEFT.clean_address.zip;
    SELF.clean_address.zip4				:= LEFT.clean_address.zip4;
    SELF.clean_address.cart				:= LEFT.clean_address.cart;
    SELF.clean_address.cr_sort_sz		:= LEFT.clean_address.cr_sort_sz;
    SELF.clean_address.lot				:= LEFT.clean_address.lot;
    SELF.clean_address.lot_order	    := LEFT.clean_address.lot_order;
    SELF.clean_address.dbpc		        := LEFT.clean_address.dbpc;
    SELF.clean_address.chk_digit	    := LEFT.clean_address.chk_digit;
    SELF.clean_address.rec_type	        := LEFT.clean_address.rec_type;
    SELF.clean_address.fips_state	    := LEFT.clean_address.fips_state;
    SELF.clean_address.fips_county	    := LEFT.clean_address.fips_county;
    SELF.clean_address.geo_lat		    := LEFT.clean_address.geo_lat;
    SELF.clean_address.geo_long	        := LEFT.clean_address.geo_long;
    SELF.clean_address.msa              := LEFT.clean_address.msa;
    SELF.clean_address.geo_blk          := LEFT.clean_address.geo_blk;
    SELF.clean_address.geo_match        := LEFT.clean_address.geo_match;
    SELF.clean_address.err_stat         := LEFT.clean_address.err_stat;
    SELF := LEFT ));
	
    CleneadAddresses :=  FraudGovPlatform.mac_Append_CleanAddresses(slim_in, AddressCache );

    appendedAddresses := JOIN( FileBase , CleneadAddresses , 
        LEFT.RECORD_ID = RIGHT.RECORD_ID,
        TRANSFORM( FraudShared.Layouts.Base.Main , 
        SELF.street_1                       := RIGHT.street_1;
        SELF.street_2                       := RIGHT.street_2;
        SELF.city                           := RIGHT.city;
        SELF.state                          := RIGHT.state;
        SELF.zip                            := RIGHT.zip;        
        SELF.address_1                      := RIGHT.address_1;
        SELF.address_2                      := RIGHT.address_2;
        SELF.Address_Type                   := RIGHT.Address_Type;
        SELF.clean_address.prim_range		:= RIGHT.clean_address.prim_range;
        SELF.clean_address.predir			:= RIGHT.clean_address.predir;
        SELF.clean_address.prim_name		:= RIGHT.clean_address.prim_name;
        SELF.clean_address.addr_suffix		:= RIGHT.clean_address.addr_suffix;
        SELF.clean_address.postdir			:= RIGHT.clean_address.postdir;
        SELF.clean_address.unit_desig		:= RIGHT.clean_address.unit_desig;
        SELF.clean_address.sec_range		:= RIGHT.clean_address.sec_range;
        SELF.clean_address.p_city_name	 	:= RIGHT.clean_address.p_city_name;
        SELF.clean_address.v_city_name		:= RIGHT.clean_address.v_city_name;
        SELF.clean_address.st				:= RIGHT.clean_address.st;
        SELF.clean_address.zip				:= RIGHT.clean_address.zip;
        SELF.clean_address.zip4				:= RIGHT.clean_address.zip4;
        SELF.clean_address.cart				:= RIGHT.clean_address.cart;
        SELF.clean_address.cr_sort_sz		:= RIGHT.clean_address.cr_sort_sz;
        SELF.clean_address.lot				:= RIGHT.clean_address.lot;
        SELF.clean_address.lot_order	    := RIGHT.clean_address.lot_order;
        SELF.clean_address.dbpc		        := RIGHT.clean_address.dbpc;
        SELF.clean_address.chk_digit	    := RIGHT.clean_address.chk_digit;
        SELF.clean_address.rec_type	        := RIGHT.clean_address.rec_type;
        SELF.clean_address.fips_state	    := RIGHT.clean_address.fips_state;
        SELF.clean_address.fips_county	    := RIGHT.clean_address.fips_county;
        SELF.clean_address.geo_lat		    := RIGHT.clean_address.geo_lat;
        SELF.clean_address.geo_long	        := RIGHT.clean_address.geo_long;
        SELF.clean_address.msa              := RIGHT.clean_address.msa;
        SELF.clean_address.geo_blk          := RIGHT.clean_address.geo_blk;
        SELF.clean_address.geo_match        := RIGHT.clean_address.geo_match;
        SELF.clean_address.err_stat         := RIGHT.clean_address.err_stat;
        SELF := LEFT)
    );

	return( appendedAddresses );

END;