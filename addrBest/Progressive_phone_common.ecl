IMPORT progressive_phone, iesp, Gateway;

EXPORT Progressive_phone_common(DATASET(progressive_phone.layout_progressive_batch_in) rs_in_raw,
      progressive_phone.iParam.Batch inMod = progressive_phone.waterfall_phones_options,
      DATASET(iesp.share.t_StringArrayItem) rs_dedup_phones = DATASET([],iesp.share.t_StringArrayItem),
      DATASET(Gateway.Layouts.Config) Gateways_In = DATASET([], Gateway.Layouts.Config),
      BOOLEAN type_a_with_did = FALSE,
      BOOLEAN useNeustar = TRUE,
      BOOLEAN default_sx_match_limit = FALSE,
      BOOLEAN isPFR = FALSE,
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
 
 // As a temporary workaround we are getting a custom scoreModel value in from progressive_phone_batch_service
 // so that it can still run on Phone Shell V1 while everything else that comes through here will default to Phone Shell V2
 // The custom value from progressive_phone_batch_service is PSV1_ + the original scoreModel value
 // We need to retrieve the original scoreModel value for normal use here while still retaining the fact of whether
 // the call is coming from progressive_phone_batch_service or not.
 boolean isProgressiveBatch := scoreModel[1..5] = 'PSV1_'; // see if this is coming from progressive_phone_batch_service
 string25 scoreModelOrig := if(isProgressiveBatch, scoreModel[6..], scoreModel); // get the original scoreModel for regular use
 
  // get the running version of waterfall phones / Contact plus
  version := progressive_phone.HelperFunctions.FN_GetVersion(scoreModelOrig, UsePremiumSource_A);
  v_enum := progressive_phone.Constants.Running_Version;
  rs_unblanked_phone := IF (version = v_enum.WFP_V6 OR version = v_enum.CP_V1,
      progressive_phone.functions.getPhonesV1(//Waterfall Phones Version 6 / Contact Plus version 1 (old calcs, doesn't use Phone Shell)
          rs_in_raw,
          inMod,
          rs_dedup_phones,
          Gateways_In,
          rs_phone_in_hist,
          type_a_with_did,
          useNeustar,
          default_sx_match_limit,
          isPFR),
      progressive_phone.functions.getPhonesV3(//Waterfall Phones Version 8 / Contact Plus version 3 (new calcs, uses Phone Shell)
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
          scoreModel, // so we're passing on the PSV1_ scoreModel if this is coming from progressive_phone_batch_service
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
