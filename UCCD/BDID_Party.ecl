import business_header_ss,business_header, ut, Census_data,did_add;

party_update_event := uccd.DID_Party;
prec := uccd.Layout_Updated_Party;

prec_source_match_layout := record

prec;

qstring34   vendor_id;

end;

prec_source_match_layout addvendorID(prec le) := TRANSFORM

           			
			self.vendor_id  := le.ucc_state_origin + Le.ucc_key[4..35];
			self := le;

END;

pre_party_update_event := project(party_update_event, addvendorID(left));

Business_Header.MAC_Source_Match(pre_party_update_event, party_Source_Match,
                        FALSE, bdid,
                        FALSE, 'U',
                        FALSE, corp_key,
                        name,
                        address1_prim_range, address1_prim_name,address1_sec_range, address1_zip,
                        TRUE, phone10,
                        TRUE, fein,
//						TRUE, corp_key)
                        TRUE, vendor_id);

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A','F','P'];

party_bdid_match := party_Source_Match(bdid <> 0);
party_bdid_nomatch := party_Source_Match(bdid = 0);

Business_Header_SS.MAC_match_Flex(party_bdid_nomatch,
                                  BDID_Matchset,
                                  name,
                                  address1_prim_range, address1_prim_name, address1_zip,
                                  address1_sec_range, address1_st,
                                  phone10, fein,
                                  bdid, prec_source_match_layout,
                                  FALSE, BDID_score_field,
                                  party_bdid_rematch)

party_bdid_all := party_bdid_match + party_bdid_rematch;

/* **************** get County Name from County Code ****************** */

//census_data.MAC_Fips2County(party_bdid_all,address1_st,address1_fips_county,address1_county_name,with_county)
prec getCountyName(party_bdid_all le, Census_data.File_Fips2County ri) := TRANSFORM
            SELF.address1_county_name := ri.county_name;
            SELF := le;
END;

with_county := JOIN(party_bdid_all, Census_data.File_Fips2County(county_fips <> '', state_code <> ''),
                    LEFT.address1_fips_county = RIGHT.county_fips AND LEFT.address1_st = RIGHT.state_code, 
                    getCountyName(LEFT, RIGHT), lookup, LEFT OUTER);

export BDID_Party := dedup(with_county, all);