import STD,doxie, ut,Data_Services,Suppress;

EXPORT Keys := module

// Note: so far "Linking_type" and "Document_Type" are mutually exclusive,
// and that's how it was implemented in Suppress/MAC_Suppress
// IMPORTANT: in case it is changed, please notify query group
	export New_Suppression(boolean isFCRA = false) :=  function

key := index(files.baseSuppress,{Product,Linking_type,Linking_ID,Document_Type,Document_ID},{Date_Added,User,Compliance_ID},
													Data_Services.Data_location.Prefix('NONAMEGIVEN')+ if(isFCRA,Constants.KEY_PREFIX_FCRA,Constants.KEY_PREFIX) +	doxie.Version_SuperKey+'::link_type_link_id');

return key;

end;

end;