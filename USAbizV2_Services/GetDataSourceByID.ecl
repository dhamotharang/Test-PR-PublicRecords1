// ========================================================
// Returns USABIZ's info from the source file;
//   (in a view closest to original data -- no rollups, filling ups, etc.)
// ========================================================

IMPORT InfoUSA, ut, codes, census_data;

out_rec := UsabizV2_Services.layouts.DataOutput;
 
EXPORT out_rec GetDataSourceByID (GROUPED DATASET (UsabizV2_Services.layouts.id) in_ids) := FUNCTION

  out_rec GetCommonInfo (UsabizV2_Services.layouts.id L, InfoUSA.key_abius_abi_number R) := TRANSFORM
//    SELF.gender_exp := codes.GENERAL.gender (stringlib.stringtouppercase (R.GENDER_CD)[1]);
    SELF := R;
  END;
  
  fetched := JOIN (in_ids, InfoUSA.key_abius_abi_number,
                   keyed (Left.abi_number = Right.abi_number),
                   GetCommonInfo (Left, Right),
                   KEEP (ut.limits.USABIZ_PER_ABI));

//  census_data.MAC_Fips2County_Keyed (ds_pull_2, st, ace_fips_county, county_name, ds_cnty_1);

  RETURN fetched;
END;
