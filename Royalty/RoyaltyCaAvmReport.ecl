IMPORT iesp, Gateway, Royalty;

EXPORT RoyaltyCaAvmReport := MODULE

  rt := Royalty.Constants.RoyaltyType;
  rc := Royalty.Constants.RoyaltyCode;

  EXPORT royalties := DICTIONARY([
    {'CA_VALUE_AVM' => rt.CA_VALUE_AVM, rc.CA_VALUE_AVM},
    {'CA_VALUE_AVM_PLUS' => rt.CA_VALUE_AVM_PLUS, rc.CA_VALUE_AVM_PLUS},
    {'CA_VALUE_AVM_INTERACTIVE' => rt.CA_VALUE_AVM_INTERACTIVE, rc.CA_VALUE_AVM_INTERACTIVE},
    {'CA_VALUE_AVM_INTERACTIVE_PLUS' => rt.CA_VALUE_AVM_INTERACTIVE_PLUS, rc.CA_VALUE_AVM_INTERACTIVE_PLUS},
    {'CA_VALUE_RANGE_AVM' => rt.CA_VALUE_RANGE_AVM, rc.CA_VALUE_RANGE_AVM},
    {'CA_VALUE_RANGE_AVM_PLUS' => rt.CA_VALUE_RANGE_AVM_PLUS, rc.CA_VALUE_RANGE_AVM_PLUS},
    {'CA_VALUE_RANGE_AVM_EXPRESS' => rt.CA_VALUE_RANGE_AVM_EXPRESS, rc.CA_VALUE_RANGE_AVM_EXPRESS},
    {'CA_VALUE_AVM_EXPRESS' => rt.CA_VALUE_AVM_EXPRESS, rc.CA_VALUE_AVM_EXPRESS},
    {'CA_VALUE_AVM_EXPRESS_PLUS' => rt.CA_VALUE_AVM_EXPRESS_PLUS, rc.CA_VALUE_AVM_EXPRESS_PLUS},
    {'CA_NEIGHBORHOOD_VALUE_RANGE' => rt.CA_NEIGHBORHOOD_VALUE_RANGE, rc.CA_NEIGHBORHOOD_VALUE_RANGE},
    {'CA_NEIGHBORHOOD_VALUE_RANGE_PLUS' => rt.CA_NEIGHBORHOOD_VALUE_RANGE_PLUS, rc.CA_NEIGHBORHOOD_VALUE_RANGE_PLUS},
    {'CA_COMPLEXITY_PROFILER' => rt.CA_COMPLEXITY_PROFILER, rc.CA_COMPLEXITY_PROFILER},
    {'CA_COMPLEXITY_PROFILER_PLUS' => rt.CA_COMPLEXITY_PROFILER_PLUS, rc.CA_COMPLEXITY_PROFILER_PLUS},
    {'CA_MARKET_CONDITION' => rt.CA_MARKET_CONDITION, rc.CA_MARKET_CONDITION},
    {'CA_RISK_PROFILER' => rt.CA_RISK_PROFILER, rc.CA_RISK_PROFILER}],
    {string ProductCode => Royalty.Layouts.Royalty.royalty_type, Royalty.Layouts.Royalty.royalty_type_code}
  );

  //Returns a dataset of royalties for the CaAvmReport gateway
  EXPORT GetRoyalties(
    iesp.gw_ca_Avm_request.t_CaAvmReportRequest gw_request,
    iesp.gw_ca_avm_response.t_CaAvmResponse gw_response
  ) := FUNCTION

    product_code := gw_request.options.CaProductCode;
    current_royalty := royalties[product_code];

    Royalty.Layouts.Royalty create_royalty_out() := TRANSFORM
      SELF.royalty_type_code := current_royalty.royalty_type_code;
      SELF.royalty_type := current_royalty.royalty_type;
      SELF.royalty_count := IF(gw_response.CaAvmResponse.ResponseHeader.Error.Code = '0', 1, 0);
      SELF.non_royalty_count := IF(gw_response.CaAvmResponse.ResponseHeader.Error.Code != '0', 1, 0);
    END;

    royalty_out := ROW(create_royalty_out());
    RETURN royalty_out;
  END;
END;
