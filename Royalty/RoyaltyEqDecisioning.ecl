IMPORT EquifaxDecisioning, Royalty;

EXPORT RoyaltyEqDecisioning := MODULE

	EXPORT GetOnlineRoyalties(DATASET(EquifaxDecisioning.Layouts.Eq_DecisioningAttr) attr_recs) := FUNCTION
  _royalty_cnt := COUNT(attr_recs(EQUIFAX_GATEWAY_USAGE > EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.GATEWAY_NOT_CALLED AND
                                  EQUIFAX_GATEWAY_USAGE < EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.NO_GATEWAY_ATTRIBUTES_RETURNED));
		RETURN IF(_royalty_cnt > 0, 
    DATASET([{Royalty.Constants.RoyaltyCode.EFX_ATTR, Royalty.Constants.RoyaltyType.EFX_ATTR,_royalty_cnt, 0}], Royalty.Layouts.Royalty),
    DATASET ([], Royalty.Layouts.Royalty));
	END;

END;