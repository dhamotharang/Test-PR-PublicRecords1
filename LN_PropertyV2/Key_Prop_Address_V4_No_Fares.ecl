import ut, doxie;

isFCRA := false;
filter_fares := true;
rolled_props := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA, filter_fares);

export Key_Prop_Address_V4_No_Fares := 
										index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
													 {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
													 {rolled_props},
													 '~thor_data400::key::ln_propertyv2::' + doxie.Version_SuperKey + '::addr.full_v4_no_fares');
