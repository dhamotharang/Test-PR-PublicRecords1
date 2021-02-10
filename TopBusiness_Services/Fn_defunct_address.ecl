Import TopBusiness_Services, BizlinkFull, STD, ut, BIPV2_Best, BIPV2;

/*
The determination of defunct companies at an address works as follows:
1)	Takes a dataset of addresses (each address records requires unique id)
2)	Finds potential companies at each given address by joining with BizlinkFull.Key_BizHead_L_Address3.Key by its key fields: prim_rage, prim_name, zip, st (this key does not contain addresses where any of the key fields are blank.
3)	Looks up Best information for each company to get full addresses information including dates and defunct status
4)	Tallies defunct companies and total companies at each given address that falls in the given date range.

Function Parameters:
1.	addresses – dataset of input address with layout defined by: BIPV2_Best. fn_defunct_address.input_layout
2.	address_match_mask = Bitmask of optional address field to define what constitutes an address match in addition to the mandatory prim_range, prim_name, state, & zip.  Defualts to using pre_dir, post_dir, & sec_range.
3.	USE_PROXID – Flag controlling whether or not proxid level best addresses are used
4.	USE_SELEID – Flag controlling whether or not seleid level best addresses are used
5.	USE_RANK_1_ONLY – Flag controlling whether only the #1 ranked Best address is used, or any address.  (Best sometimes contains lower ranked addresses when permissions can keep higher ranked address from being returned)
6.	CURRENT_DATE – Defaults to Today’s date
7.	REFERENCE_DATE – Earliest date considered for function.  Defaults to 12 months prior to CURRENT_DATE
8.	JOIN_LIMIT – Used to protect keyed joins from failing due to too many matches.  Defaults to 10000.
*/

EXPORT fn_defunct_address := module

    // Optional Match Fields
    UNSIGNED1 Match_Base        := 0b; // Non-optional: prim_range, priom_name, st, zip,
    UNSIGNED1 Match_Predir      := 1b;
    UNSIGNED1 Match_Addr_Suffix := 10b;
    UNSIGNED1 Match_Postdir     := 100b;
    UNSIGNED1 Match_Unit_Desig  := 1000b;
    UNSIGNED1 Match_Sec_Range   := 10000b;
    UNSIGNED1 Match_City        := 100000b;


    // I chose module over function to see intermediate results for debugging
    EXPORT defunctsAtAddress(DATASET(TopBusiness_Services.Layouts.busRiskDefunctAddressLayout) addresses,
                             unsigned1 address_match_mask = Match_Predir + Match_Postdir + Match_Sec_Range,
                             boolean USE_PROXID      = false,
                             boolean USE_SELEID      = true,
                             boolean USE_RANK_1_ONLY = false,
                             unsigned CURRENT_DATE    = Std.Date.Today(),
                             unsigned REFERENCE_DATE = (unsigned) ut.date_math((string)CURRENT_DATE, -365),
                             unsigned JOIN_LIMIT = 10000
                             ) := module

        // Find all businesses with the given address
        // This join generates many prox level duplicates of same business at same address
        businessAtAddress_raw := JOIN(addresses, BizlinkFull.Key_BizHead_L_Address3.Key,
             KEYED(LEFT.company_prim_name  = right.prim_name) and
             KEYED(LEFT.company_prim_range = right.prim_range) and
             KEYED(LEFT.company_zip5       = right.zip) and
             KEYED(LEFT.company_st         = right.st),
             transform({TopBusiness_Services.Layouts.busRiskDefunctAddressLayout,
                        right.ultid,
                        right.orgid,
                        right.seleid,
                        right.proxid},
                        self:=left;
                        self:=right;)
             ,keep(JOIN_LIMIT), LIMIT(JOIN_LIMIT, SKIP));

        // The above join with BizlinkFull.Key_BizHead_L_Address3.Key to get list of candidate addresses is broad becuase only keyed by prim_range/prim_name/sst/zip),
        businessAtAddressUnique     := dedup(sort(businessAtAddress_raw, uniqueid,company_prim_range, company_prim_name,company_zip5,company_st,seleid ,proxid),
                                                  uniqueid,company_prim_range, company_prim_name,company_zip5,company_st,seleid ,proxid);

        ds_in_unique_ids := project(businessAtAddressUnique, transform(BIPV2.IDlayouts.l_xlink_ids2, self := left, self := []));
        businessSeleFetch := BIPV2_Best.Key_LinkIds.kfetch2(ds_in_unique_ids, , , , ,JOIN_LIMIT,);

        best_layout      := {TopBusiness_Services.Layouts.busRiskDefunctAddressLayout, BIPV2_Best.Layouts.key.seleid, BIPV2_Best.Layouts.key.proxid, BIPV2_Best.Layouts.key.isDefunct, BIPV2_Best.Layouts.key.company_address};
        best_norm_layout := {BIPV2_Best.Layouts.key.seleid, BIPV2_Best.Layouts.key.proxid, BIPV2_Best.Layouts.key.isDefunct, recordof(BIPV2_Best.Layouts.key.company_address)};

        best_layout bestTrans(recordof(businessAtAddressUnique) l, recordof(businessSeleFetch) r, typeof(BIPV2_Best.Layouts.key.proxid) prox) := transform
               self.proxid := prox;
               self:=l;
               self:=r;
        end;

        businessBestSele := join(businessAtAddressUnique, businessSeleFetch, left.ultid=right.ultid and left.orgid=right.orgid and left.seleid=right.seleid, bestTrans(left, right, 0), limit(JOIN_LIMIT, skip));

        // Compare Best information to given address (We do not need to keep address unless for debugging)
        businessBestNorm := normalize(businessBestSele, left.company_address,
                                    transform(best_norm_layout,
                                              skip(USE_RANK_1_ONLY and COUNTER > 1 or
                                                   left.company_prim_range<>right.company_prim_range or
                                                   left.company_prim_name <>right.company_prim_name or
                                                   left.company_st        <>right.company_st or
                                                   left.company_zip5      <>right.company_zip5 or
                                                   (address_match_mask & Match_Predir>0      and  left.company_predir <> right.company_predir) or
                                                   (address_match_mask & Match_Addr_Suffix>0 and  left.company_addr_suffix <> right.company_addr_suffix) or
                                                   (address_match_mask & Match_postdir>0     and  left.company_postdir <> right.company_postdir) or
                                                   (address_match_mask & Match_Unit_Desig>0  and  left.company_unit_desig <> right.company_unit_desig) or
                                                   (address_match_mask & Match_Sec_Range>0   and  left.company_sec_range <> right.company_sec_range) or
                                                   (address_match_mask & Match_City>0        and  (left.company_p_city_name <> right.company_p_city_name or left.company_p_city_name <> right.address_v_city_name)));
                                              self:=right;
                                              self :=left)
                                              );

        // Limit to occurrences within date period
        businessBestNormWithinDate := businessBestNorm(address_dt_last_seen<=CURRENT_DATE, address_dt_last_seen>=REFERENCE_DATE);

        businessBestNormWithinDate_dedup  := dedup(sort( businessBestNormWithinDate, seleid), seleid);

    EXPORT  result := project(businessBestNormWithinDate_dedup, transform({TopBusiness_Services.Layouts.busRiskDefunctAddressLayout,
                                                                           unsigned4 total, unsigned4 defunct},
                                                        SELF.total := count(businessBestNormWithinDate);
                                                        SELF.defunct := count(businessBestNormWithinDate(isdefunct));
                                                        SELF := LEFT;
                                                        SELF := []));

    end;

end;