IMPORT AutoKeyI, AutoStandardI, AutoHeaderI;

EXPORT search_params := INTERFACE (
  AutoKeyI.AutoKeyStandardFetchBaseInterface, 
  AutoStandardI.LIBIN.PenaltyI_Indv.base,
  AutoStandardI.InterfaceTranslator.glb_purpose.params,
  AutoStandardI.InterfaceTranslator.dppa_purpose.params)

  export unsigned2 penalty_threshold;

  // this is to bypass autokey
  export string14 did;

  // not used in current V2 implementation
  // export boolean isdeepDive := false;
	// export unsigned2 MAX_DEEP_DIDS := 100;
	// export unsigned2 MAX_DEEP_BDIDS := 100;
end;