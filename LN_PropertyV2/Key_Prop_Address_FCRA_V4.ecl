import doxie,Data_Services, vault, _control;

isFCRA := true;
rolled_props := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_Prop_Address_FCRA_V4 := vault.LN_PropertyV2.Key_Prop_Address_FCRA_V4;

#ELSE
export Key_Prop_Address_FCRA_V4 := index (rolled_props(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID),
         {prim_range, prim_name, sec_range, zip, suffix, predir, postdir},
				 {rolled_props},
				 Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::addr.full_v4');


#END;

