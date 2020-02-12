IMPORT Business_Risk_BIP, Codes, MDR, STD;

// For the AllowedSourcesSet, only include the Dunn Bradstreet source if that source is explicitly
// allowed and drop any unallowed Marketing sources when Marketing Mode is turned on. Also, filter
// out Experian data for those Scoring products intended primarily for the purpose of commercial
// credit origination. E.g.:
//   o   Small Business Attributes
//   o   Small Business Attributes with SBFE Data
//   o   Small Business Credit Score with SBFE Data
//   o   Small Business Blended Credit Score with SBFE Data
//   o   Small Business Risk Score


// Per guidance from Keith Dues (1/21/2020) we're better off obtaining Marketing-allowed sources
// from a key designated for it, instead of the list that's in MDR.SourceTools.
// 
// PROBLEM: Codes.Key_Codes_V3 isn't updated on the 156 Dev Roxie, so it's not possible in the 
// near term to test using this key. Use MDR.sourceTools.set_Marketing_Sources instead.
ds_MarketingAllowedSources := 
	Codes.Key_Codes_V3(KEYED(file_name = 'VENDOR_SOURCES' AND field_name= 'DIRECTMARKETING' AND field_name2 = 'SCODE'));
	
EXPORT set_AllowedSources(Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := 
		SET(
			CHOOSEN(
				Business_Risk_BIP.Constants.AllowedSources(
						( // Restrict Dunn Bradstreet
							Source <> MDR.SourceTools.src_Dunn_Bradstreet OR
							STD.Str.Find(Options.AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1) > 0
						) AND
						( // Restrict Equifax Business Data, Infutor NARB, Databridge, and Cortera Tradeline by Business Shell version
							Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31 OR
							Source NOT IN Business_Risk_BIP.Constants.Set_NewV31Sources
						)  AND
						( // Allow only Marketing sources when Marketing Mode is turned on
							Options.MarketingMode = Business_Risk_BIP.Constants.Default_MarketingMode OR 
							// Source IN SET(ds_MarketingAllowedSources, code)
							Source IN MDR.sourceTools.set_Marketing_Sources
						) AND
						( // Restrict Experian data by business rule (see comment above)
							Options.OverrideExperianRestriction = True OR
							Source NOT IN SET(Business_Risk_BIP.Constants.ExperianRestrictedSources, Source)
						) AND
						( // Restrict Cortera data by Business Shell version
							Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 OR
							Source <> MDR.SourceTools.Src_Cortera
						)	 AND
						( // Restrict Cortera data by Data Restriction Mask bit
							Options.DataRestrictionMask[42] IN ['', '0'] OR
							Source <> MDR.SourceTools.Src_Cortera
						)
				),
				300
			),
			Source );
				
