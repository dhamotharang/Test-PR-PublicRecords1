IMPORT BIPV2, Scrubs_BIPV2, MDR;

STRING8 sVersion := BIPV2.KeySuffix;
rIn_Layout := BIPV2.Layout_Business_Linking_Full;
dIngest_In := DATASET(BIPV2.Filenames(sVersion,TRUE).Source_Ingest.new, rIn_Layout, THOR);
// dIngest_In := ENTH(DATASET(BIPV2.Filenames(sVersion,TRUE).Source_Ingest.new, rIn_Layout, THOR), 1000); //For Testing Only

// tbl_layout := RECORD
   // string80		company_url;
   // boolean    is_valid := TRUE;
// END;

// dLookupTbl := DEDUP(PROJECT(dIngest_In, TRANSFORM(tbl_layout, SELF.company_url := LEFT.source, SELF := [])),ALL);

// tbl_layout tCreateLookup(rIn_Layout L) := TRANSFORM

Scrubs_BIPV2.Ingest_Layout_BIPV2 tFlatten(rIn_Layout l) := TRANSFORM
   SELF.source_expanded                   := MDR.sourceTools.TranslateSource(L.source);
   SELF.company_address_prim_range        := L.company_address.prim_range;
   SELF.company_address_predir            := L.company_address.predir;
   SELF.company_address_prim_name         := L.company_address.prim_name;
   SELF.company_address_addr_suffix       := L.company_address.addr_suffix;
   SELF.company_address_postdir           := L.company_address.postdir;
   SELF.company_address_unit_desig        := L.company_address.unit_desig;
   SELF.company_address_sec_range         := L.company_address.sec_range;
   SELF.company_address_p_city_name       := L.company_address.p_city_name;
   SELF.company_address_v_city_name       := L.company_address.v_city_name;
   SELF.company_address_st                := L.company_address.st;
   SELF.company_address_zip               := L.company_address.zip;
   SELF.company_address_zip4              := L.company_address.zip4;
   SELF.company_address_cart              := L.company_address.cart;
   SELF.company_address_cr_sort_sz        := L.company_address.cr_sort_sz;
   SELF.company_address_lot               := L.company_address.lot;
   SELF.company_address_lot_order         := L.company_address.lot_order;
   SELF.company_address_dbpc              := L.company_address.dbpc;
   SELF.company_address_chk_digit         := L.company_address.chk_digit;
   SELF.company_address_rec_type          := L.company_address.rec_type;
   SELF.company_address_fips_state        := L.company_address.fips_state;
   SELF.company_address_fips_county       := L.company_address.fips_county;
   SELF.company_address_geo_lat           := L.company_address.geo_lat;
   SELF.company_address_geo_long          := L.company_address.geo_long;
   SELF.company_address_msa               := L.company_address.msa;
   SELF.company_address_geo_blk           := L.company_address.geo_blk;
   SELF.company_address_geo_match         := L.company_address.geo_match;
   SELF.company_address_err_stat          := L.company_address.err_stat;
   SELF.company_url                       := L.company_url;
   SELF.contact_name_title                := L.contact_name.title;
   SELF.contact_name_fname                := L.contact_name.fname;
   SELF.contact_name_mname                := L.contact_name.mname;
   SELF.contact_name_lname                := L.contact_name.lname;
   SELF.contact_name_name_suffix          := L.contact_name.name_suffix;
   SELF.contact_name_name_score           := L.contact_name.name_score;
   SELF                                   := L;
END;

EXPORT Ingest_In_BIPV2 := PROJECT(dIngest_In, tFlatten(LEFT));
