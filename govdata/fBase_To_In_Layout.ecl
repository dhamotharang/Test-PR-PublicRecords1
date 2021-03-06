IMPORT govdata;

EXPORT fBase_To_In_Layout(DATASET(govdata.Layout_IA_SalesTax_Base) pBasefile) := FUNCTION

  govdata.Layout_IA_Sales_Tax_In RevertIASalesTx(govdata.Layout_IA_SalesTax_Base L) := TRANSFORM
    SELF.bdid                  := L.bdid;
    SELF.permit_nbr            := L.permit_nbr;
    SELF.owner_name            := L.owner_name;
    SELF.trade_name            := L.business_name;
    SELF.mailing_street_1      := L.mailing_address[1..24];
    SELF.mailing_street_2      := L.mailing_address[25..48];
    SELF.mailing_city          := L.city_mailing_address;
    SELF.mailing_state         := L.state_mailing_address;
    SELF.mailing_zip_code      := L.mailing_zip_code;
    SELF.mailing_zip_plus4     := '';
    SELF.location_street_1     := L.location_address[1..24];
    SELF.location_street_2     := L.location_address[25..48];
    SELF.location_city         := L.city_of_location;
    SELF.location_state        := L.state_of_location;
    SELF.location_zip_code     := L.location_zip_code;
    SELF.location_zip_plus4    := '';
    SELF.issue_date            := L.issue_date;
    SELF.owner_name_prefix     := L.ownerName.title;
    SELF.owner_name_first      := L.ownerName.fname;
    SELF.owner_name_middle     := L.ownerName.mname;
    SELF.owner_name_last       := L.ownerName.lname;
    SELF.owner_name_suffix     := L.ownerName.name_suffix;
    SELF.owner_name_score      := L.ownerName.name_score;
    SELF.company_name_1        := L.company_name_1;
    SELF.trade_name_prefix     := L.tradeName.title;
    SELF.trade_name_first      := L.tradeName.fname;
    SELF.trade_name_middle     := L.tradeName.mname;
    SELF.trade_name_last       := L.tradeName.lname;
    SELF.trade_name_suffix     := L.tradeName.name_suffix;
    SELF.trade_name_score      := L.tradeName.name_score;
    SELF.company_name_2        := L.company_name_2;
    SELF.mailing_prim_range    := L.mailingAddress.prim_range;
    SELF.mailing_predir        := L.mailingAddress.predir;
    SELF.mailing_prim_name     := L.mailingAddress.prim_name;
    SELF.mailing_addr_suffix   := L.mailingAddress.addr_suffix;
    SELF.mailing_postdir       := L.mailingAddress.postdir;
    SELF.mailing_unit_desig    := L.mailingAddress.unit_desig;
    SELF.mailing_sec_range     := L.mailingAddress.sec_range;
    SELF.mailing_p_city_name   := L.mailingAddress.p_city_name;
    SELF.mailing_v_city_name   := L.mailingAddress.v_city_name;
    SELF.mailing_st            := L.mailingAddress.st;
    SELF.mailing_zip           := L.mailingAddress.zip;
    SELF.mailing_zip4          := L.mailingAddress.zip4;
    SELF.mailing_cart          := L.mailingAddress.cart;
    SELF.mailing_cr_sort_sz    := L.mailingAddress.cr_sort_sz;
    SELF.mailing_lot           := L.mailingAddress.lot;
    SELF.mailing_lot_order     := L.mailingAddress.lot_order;
    SELF.mailing_dpbc          := L.mailingAddress.dbpc;
    SELF.mailing_chk_digit     := L.mailingAddress.chk_digit;
    SELF.mailing_record_type   := L.mailingAddress.rec_type;
    SELF.mailing_ace_fips_st   := L.mailingAddress.fips_state;
    SELF.mailing_fipscounty    := L.mailingAddress.fips_county;
    SELF.mailing_geo_lat       := L.mailingAddress.geo_lat;
    SELF.mailing_geo_long      := L.mailingAddress.geo_long;
    SELF.mailing_msa           := L.mailingAddress.msa;
    SELF.mailing_geo_blk       := L.mailingAddress.geo_blk;
    SELF.mailing_geo_match     := L.mailingAddress.geo_match;
    SELF.mailing_err_stat      := L.mailingAddress.err_stat;
    SELF.location_prim_range   := L.locationAddress.prim_range;
    SELF.location_predir       := L.locationAddress.predir;
    SELF.location_prim_name    := L.locationAddress.prim_name;
    SELF.location_addr_suffix  := L.locationAddress.addr_suffix;
    SELF.location_postdir      := L.locationAddress.postdir;
    SELF.location_unit_desig   := L.locationAddress.unit_desig;
    SELF.location_sec_range    := L.locationAddress.sec_range;
    SELF.location_p_city_name  := L.locationAddress.p_city_name;
    SELF.location_v_city_name  := L.locationAddress.v_city_name;
    SELF.location_st           := L.locationAddress.st;
    SELF.location_zip          := L.locationAddress.zip;
    SELF.location_zip4         := L.locationAddress.zip4;
    SELF.location_cart         := L.locationAddress.cart;
    SELF.location_cr_sort_sz   := L.locationAddress.cr_sort_sz;
    SELF.location_lot          := L.locationAddress.lot;
    SELF.location_lot_order    := L.locationAddress.lot_order;
    SELF.location_dpbc         := L.locationAddress.dbpc;
    SELF.location_chk_digit    := L.locationAddress.chk_digit;
    SELF.location_record_type  := L.locationAddress.rec_type;
    SELF.location_ace_fips_st  := L.locationAddress.fips_state;
    SELF.location_fipscounty   := L.locationAddress.fips_county;
    SELF.location_geo_lat      := L.locationAddress.geo_lat;
    SELF.location_geo_long     := L.locationAddress.geo_long;
    SELF.location_msa          := L.locationAddress.msa;
    SELF.location_geo_blk      := L.locationAddress.geo_blk;
    SELF.location_geo_match    := L.locationAddress.geo_match;
    SELF.location_err_stat     := L.locationAddress.err_stat;
	  SELF.DotID			           := L.DotID;
	  SELF.DotScore		           := L.DotScore;
	  SELF.DotWeight	           := L.DotWeight;
    SELF.EmpID			           := L.EmpID;
	  SELF.EmpScore		           := L.EmpScore;
	  SELF.EmpWeight	           := L.EmpWeight;
	  SELF.POWID			           := L.POWID;
	  SELF.POWScore		           := L.POWScore;
	  SELF.POWWeight	           := L.POWWeight;
	  SELF.ProxID			           := L.ProxID;
	  SELF.ProxScore	           := L.ProxScore;
	  SELF.ProxWeight	           := L.ProxWeight;
	  SELF.SELEID			           := L.SELEID;
	  SELF.SELEScore	           := L.SELEScore;
	  SELF.SELEWeight	           := L.SELEWeight;	
	  SELF.OrgID			           := L.OrgID;
	  SELF.OrgScore		           := L.OrgScore;
	  SELF.OrgWeight		         := L.OrgWeight;
	  SELF.UltID			           := L.UltID;
	  SELF.UltScore		           := L.UltScore;
	  SELF.UltWeight	           := L.UltWeight;	
    SELF								       := [];
  END;

  RETURN PROJECT(pBasefile, RevertIASalesTx(LEFT));
  
END;

