IMPORT progressive_phone, iesp, Gateway;

EXPORT Progressive_phone_common(DATASET(progressive_phone.layout_progressive_batch_in) rs_in_raw,
      progressive_phone.iParam.Batch inMod = progressive_phone.waterfall_phones_options,
      DATASET(iesp.share.t_StringArrayItem) rs_dedup_phones = DATASET([],iesp.share.t_StringArrayItem),
      DATASET(Gateway.Layouts.Config) Gateways_In = DATASET([], Gateway.Layouts.Config),
      BOOLEAN type_a_with_did = FALSE,
      BOOLEAN useNeustar = TRUE,
      BOOLEAN default_sx_match_limit = FALSE,
      BOOLEAN isPFR = FALSe,
      STRING25 scoreModel = '',
      UNSIGNED2 MaxNumAssociate = 0,
      UNSIGNED2 MaxNumAssociateOther = 0,
      UNSIGNED2 MaxNumFamilyOther = 0,
      UNSIGNED2 MaxNumFamilyClose = 0,
      UNSIGNED2 MaxNumParent = 0,
      UNSIGNED2 MaxNumSpouse = 0,
      UNSIGNED2 MaxNumSubject = 0,
      UNSIGNED2 MaxNumNeighbor = 0,
				BOOLEAN UsePremiumSource_A = FALSE,
			INTEGER PremiumSource_A_limit = 0, 
			BOOLEAN RunRelocation = FALSE) := FUNCTION
 
  rs_phone_in_hist := progressive_phone.functions.GetInputHistPhones(rs_in_raw, rs_dedup_phones);
	//get the running version of waterfall phones / Contact plus
	version := progressive_phone.HelperFunctions.FN_GetVersion(scoreModel, UsePremiumSource_A);
  v_enum  := progressive_phone.Constants.Running_Version;
	rs_unblanked_phone := IF (version = v_enum.WFP_V6 OR version = v_enum.CP_V1,
      progressive_phone.functions.getPhonesV1(//Waterfall Phones Version 6 / Contact Plus version 1
					rs_in_raw,
          inMod,
          rs_dedup_phones,
          Gateways_In,
          rs_phone_in_hist,
          type_a_with_did,
          useNeustar,
          default_sx_match_limit,
          isPFR),
      progressive_phone.functions.getPhonesV3(//Waterfall Phones Version 8 / Contact Plus version 3
					rs_in_raw,
          inMod,
          rs_dedup_phones,
          Gateways_In,
          rs_phone_in_hist,
          MaxNumAssociate,
          MaxNumAssociateOther,
          MaxNumFamilyOther,
          MaxNumFamilyClose,
          MaxNumParent,
          MaxNumSpouse,
          MaxNumSubject,
          MaxNumNeighbor,
					scoreModel,
					UsePremiumSource_A,
					PremiumSource_A_limit,
					version, 
					RunRelocation));

    rs_return := IF (inMod.BlankOutLineTypeCell
            OR inMod.BlankOutLineTypePotsLand
            OR inMod.BlankOutLineTypePager
            OR inMod.BlankOutLineTypeVOIP
            OR inMod.BlankOutLineTypeIsland
            OR inMod.BlankOutLineTypeTollFree
            OR inMod.BlankOutLineTypeUnknown,
        progressive_phone.functions.conditionallyBlankPhone10(rs_unblanked_phone, inMod),
        rs_unblanked_phone);

		RETURN rs_return;

END;