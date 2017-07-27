// ========================================================
// Returns deadco's info from the source file;
// Result is: 
//   pulled by bdid, tmsid
// ========================================================

IMPORT InfoUSA, ut, doxie, codes, suppress, census_data;

out_rec := DeadcoV2_Services.layouts.DataOutput;
 
EXPORT out_rec GetDeadcoDataByID (GROUPED DATASET (DeadcoV2_Services.layouts.id) in_ids) := FUNCTION

  out_rec GetCommonInfo (DeadcoV2_Services.layouts.id L, InfoUSA.key_deadco_abi_number R) := TRANSFORM
    SELF := R;
    // SELF.addr.state := codes.general.state_long (R.addr.st);	
    // SELF.addr.county := ''; //this one is done below
    // SELF.gender_exp := codes.GENERAL.gender (stringlib.stringtouppercase (R.GENDER_CD)[1]);
    SELF := [];
  END;
  
  fetched := JOIN (in_ids, InfoUSA.key_deadco_abi_number,
                   keyed (Left.abi_number = Right.abi_number),
                   GetCommonInfo (Left, Right),
                   KEEP (1));

  //TODO: pull by bdid, abi_number?

//  census_data.MAC_Fips2County_Keyed (ds_pull_2, addr.st, addr.fips_county, addr.county, ds_cnty_1);

  res := fetched;
  RETURN res;
END;

