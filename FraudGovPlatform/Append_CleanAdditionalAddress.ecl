IMPORT FraudShared,address,tools;
EXPORT Append_CleanAdditionalAddress (
	  dataset(FraudShared.Layouts.Base.Main) FileBase
     ,dataset(FraudShared.Layouts.Base.Main) Previous_Build = FraudShared.Files().Base.Main.QA
) := FUNCTION

    new_inputs := JOIN(FileBase, 
         Previous_Build,
         left.record_id = right.record_id, LEFT ONLY);
         
    AddressCache := Files().Base.AddressCache.QA;

	slim_in := Project( new_inputs , TRANSFORM( FraudGovPlatform.Layouts.Temp.CleanAddressSlim , 
        SELF.record_id                      := LEFT.record_id;
        SELF.street_1                       := LEFT.additional_address.street_1;
        SELF.street_2                       := LEFT.additional_address.street_2;
        SELF.city                           := LEFT.additional_address.city;
        SELF.state                          := LEFT.additional_address.state;
        SELF.zip                            := LEFT.additional_address.zip;        
        SELF.address_1                      := LEFT.additional_address.address_1;
        SELF.address_2                      := LEFT.additional_address.address_2;
        SELF.Address_Type                   := LEFT.additional_address.Address_Type;
        SELF.clean_address.prim_range		:= LEFT.additional_address.clean_address.prim_range;
        SELF.clean_address.predir			:= LEFT.additional_address.clean_address.predir;
        SELF.clean_address.prim_name		:= LEFT.additional_address.clean_address.prim_name;
        SELF.clean_address.addr_suffix		:= LEFT.additional_address.clean_address.addr_suffix;
        SELF.clean_address.postdir			:= LEFT.additional_address.clean_address.postdir;
        SELF.clean_address.unit_desig		:= LEFT.additional_address.clean_address.unit_desig;
        SELF.clean_address.sec_range		:= LEFT.additional_address.clean_address.sec_range;
        SELF.clean_address.p_city_name	 	:= LEFT.additional_address.clean_address.p_city_name;
        SELF.clean_address.v_city_name		:= LEFT.additional_address.clean_address.v_city_name;
        SELF.clean_address.st				:= LEFT.additional_address.clean_address.st;
        SELF.clean_address.zip				:= LEFT.additional_address.clean_address.zip;
        SELF.clean_address.zip4				:= LEFT.additional_address.clean_address.zip4;
        SELF.clean_address.cart				:= LEFT.additional_address.clean_address.cart;
        SELF.clean_address.cr_sort_sz		:= LEFT.additional_address.clean_address.cr_sort_sz;
        SELF.clean_address.lot				:= LEFT.additional_address.clean_address.lot;
        SELF.clean_address.lot_order	    := LEFT.additional_address.clean_address.lot_order;
        SELF.clean_address.dbpc		        := LEFT.additional_address.clean_address.dbpc;
        SELF.clean_address.chk_digit	    := LEFT.additional_address.clean_address.chk_digit;
        SELF.clean_address.rec_type	        := LEFT.additional_address.clean_address.rec_type;
        SELF.clean_address.fips_state	    := LEFT.additional_address.clean_address.fips_state;
        SELF.clean_address.fips_county	    := LEFT.additional_address.clean_address.fips_county;
        SELF.clean_address.geo_lat		    := LEFT.additional_address.clean_address.geo_lat;
        SELF.clean_address.geo_long	        := LEFT.additional_address.clean_address.geo_long;
        SELF.clean_address.msa              := LEFT.additional_address.clean_address.msa;
        SELF.clean_address.geo_blk          := LEFT.additional_address.clean_address.geo_blk;
        SELF.clean_address.geo_match        := LEFT.additional_address.clean_address.geo_match;
        SELF.clean_address.err_stat         := LEFT.additional_address.clean_address.err_stat;
        SELF := LEFT
    ));
	
    CleneadAddresses :=  FraudGovPlatform.mac_Append_CleanAddresses( slim_in, AddressCache );

    appendedAddresses := JOIN( new_inputs , CleneadAddresses , 
        LEFT.RECORD_ID = RIGHT.RECORD_ID,
        TRANSFORM( FraudShared.Layouts.Base.Main , 
        SELF.additional_address.address_1                       := RIGHT.address_1;
        SELF.additional_address.address_2                       := RIGHT.address_2;
        SELF.additional_address.clean_address.prim_range		:= RIGHT.clean_address.prim_range;
        SELF.additional_address.clean_address.predir			:= RIGHT.clean_address.predir;
        SELF.additional_address.clean_address.prim_name		    := RIGHT.clean_address.prim_name;
        SELF.additional_address.clean_address.addr_suffix		:= RIGHT.clean_address.addr_suffix;
        SELF.additional_address.clean_address.postdir			:= RIGHT.clean_address.postdir;
        SELF.additional_address.clean_address.unit_desig		:= RIGHT.clean_address.unit_desig;
        SELF.additional_address.clean_address.sec_range		    := RIGHT.clean_address.sec_range;
        SELF.additional_address.clean_address.p_city_name	 	:= RIGHT.clean_address.p_city_name;
        SELF.additional_address.clean_address.v_city_name		:= RIGHT.clean_address.v_city_name;
        SELF.additional_address.clean_address.st				:= RIGHT.clean_address.st;
        SELF.additional_address.clean_address.zip				:= RIGHT.clean_address.zip;
        SELF.additional_address.clean_address.zip4				:= RIGHT.clean_address.zip4;
        SELF.additional_address.clean_address.cart				:= RIGHT.clean_address.cart;
        SELF.additional_address.clean_address.cr_sort_sz		:= RIGHT.clean_address.cr_sort_sz;
        SELF.additional_address.clean_address.lot				:= RIGHT.clean_address.lot;
        SELF.additional_address.clean_address.lot_order	        := RIGHT.clean_address.lot_order;
        SELF.additional_address.clean_address.dbpc		        := RIGHT.clean_address.dbpc;
        SELF.additional_address.clean_address.chk_digit	        := RIGHT.clean_address.chk_digit;
        SELF.additional_address.clean_address.rec_type	        := RIGHT.clean_address.rec_type;
        SELF.additional_address.clean_address.fips_state	    := RIGHT.clean_address.fips_state;
        SELF.additional_address.clean_address.fips_county       := RIGHT.clean_address.fips_county;
        SELF.additional_address.clean_address.geo_lat		    := RIGHT.clean_address.geo_lat;
        SELF.additional_address.clean_address.geo_long	        := RIGHT.clean_address.geo_long;
        SELF.additional_address.clean_address.msa               := RIGHT.clean_address.msa;
        SELF.additional_address.clean_address.geo_blk           := RIGHT.clean_address.geo_blk;
        SELF.additional_address.clean_address.geo_match         := RIGHT.clean_address.geo_match;
        SELF.additional_address.clean_address.err_stat          := RIGHT.clean_address.err_stat;
        SELF := LEFT)
    );

    return( appendedAddresses );
	

END;