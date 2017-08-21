Import Data_Services, ut, doxie,LN_PropertyV2;

export Key_Prop_Address_V4_No_Fares(boolean isFast=false) := FUNCTION

keyPrefix	:=	if (isFast,'property_fast','ln_propertyv2');

isFCRA := false;
filter_fares := true;
rolled_props := LN_PropertyV2_Fast.Prop_Address_Prep_V4(isFCRA, filter_fares,isFast);

return
										index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
													 {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
													 {rolled_props},
													 Constants.keyServerPointer+'thor_data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey + '::addr.full_v4_no_fares');
END;