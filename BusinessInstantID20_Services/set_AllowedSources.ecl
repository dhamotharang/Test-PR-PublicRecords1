IMPORT Business_Risk_BIP, MDR;

EXPORT set_AllowedSources(Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := 
		SET(
			CHOOSEN(
				Business_Risk_BIP.Constants.AllowedSources( 
					(
						Source <> MDR.SourceTools.src_Dunn_Bradstreet OR 
						StringLib.StringFind(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0
					) 
					AND
					(
						Options.MarketingMode = Business_Risk_BIP.Constants.Default_MarketingMode OR 
						Source NOT IN SET(Business_Risk_BIP.Constants.MarketingRestrictedSources, Source)
					) 
					AND
					(
						Options.OverrideExperianRestriction = TRUE OR // means SBFE = FALSE
						Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
					)
				), 
				1000
			), 
			Source
		);
