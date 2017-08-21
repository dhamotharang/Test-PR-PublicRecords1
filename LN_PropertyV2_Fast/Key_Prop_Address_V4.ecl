Import Data_Services, ut, doxie,LN_PropertyV2;

export Key_Prop_Address_V4(boolean isFCRA = false, boolean isFast=false) := FUNCTION

keyPrefix0	:= if (isFast,'property_fast','ln_propertyv2');

keyPrefix	:=	if (isFCRA, keyPrefix0+'::fcra',keyPrefix0);

rolled_props := LN_PropertyV2_Fast.Prop_Address_Prep_v4(isFCRA,false,isFast);

return
										index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
													 {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
													 {rolled_props},
													 Constants.keyServerPointer+'thor_data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey + '::addr.full_v4');
END;