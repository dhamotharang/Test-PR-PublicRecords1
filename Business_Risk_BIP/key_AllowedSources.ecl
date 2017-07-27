import Data_Services, doxie, Business_Risk_BIP, ut;

AllowedSources := Constants.AllowedSources;	
	
export key_AllowedSources := index(AllowedSources, {source}, {AllowedSources},
			     Data_Services.Data_location.Prefix('Business_Risk_BIP') + 'thor_data400::key::bip::business_risk::allowedsources_'+doxie.Version_SuperKey);	
			     // ut.foreign_prod + 'thor_data400::key::bip::business_risk::allowedsources_'+doxie.Version_SuperKey);	
