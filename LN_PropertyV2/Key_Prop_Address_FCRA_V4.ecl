import doxie,Data_Services;

isFCRA := true;
rolled_props := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);

export Key_Prop_Address_FCRA_V4 := 
  index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
         {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
				 {rolled_props},
				 Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::addr.full_v4');