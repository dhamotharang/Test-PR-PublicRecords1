import mdr;
// -----------------------------------------------------------------------------------------
// -- Once the sources for People Header and Business Header are aligned
// -- This attribute and the FCRA.Restricted_Header_Src attribute should be the same
// -----------------------------------------------------------------------------------------
export Restricted_BusHeader_Src (string src, string vid) :=
			MDR.sourceTools.SourceIsCorpV2								(src)	// not Experian anymore, still FCRA?
	or	MDR.sourceTools.SourceIsFares_Deeds_from_Asrs	(src)	// Fares
	or	MDR.sourceTools.SourceIsFBNV2_Experian_Direct	(src)	// Experian FBN
	or	MDR.sourceTools.SourceIsFBNV2_INF							(src)	// Infousa FBN
	or	MDR.sourceTools.SourceIsInfousa								(src)	// All Infousa except FBN
	or	MDR.sourceTools.SourceIsLiens_and_Judgments		(src)	// Liens & Judgements
	or	MDR.sourceTools.SourceIsLiensV1								(src)	// LiensV1
	or	MDR.sourceTools.SourceIsLnPropV2_Fares_Asrs		(src)	// Fares
	or	MDR.sourceTools.SourceIsLnPropV2_Fares_Deeds	(src)	// Fares
	or	MDR.sourceTools.SourceIsUCCS									(src)	// not Experian anymore, still FCRA?
	or	MDR.sourceTools.SourceIsVehicle								(src)	// Vehicle Sources(Experian & Direct)
	or	MDR.sourceTools.SourceIsYellow_Pages					(src)	// not Experian anymore, still FCRA?
	or	MDR.sourceTools.SourceIsUtility								(src)	// Utility
	or	MDR.sourceTools.SourceIsTransUnion						(src)	// TransUnion
	or	MDR.sourceTools.SourceIsCertegy								(src)	// Certegy
	or	MDR.sourceTools.SourceIsExperian_Credit_Header(src)	// Experian Credit Header
	or	MDR.sourceTools.SourceIsDL										(src) // Drivers Licenses
	or (
				(		 MDR.sourceTools.SourceIsLnPropV2_Lexis_Deeds_Mtgs(src)	// Common Property Fares
					or MDR.sourceTools.SourceIsLnPropV2_Lexis_Asrs			(src)	// Common Property Fares
				) 
				and vid[1] = 'F'
		 )
	;