import doxie, risk_indicators, iesp;


export getOccupant(dataset(identifier2.layout_Identifier2) indata, boolean includeCurrent, boolean includeEver) := function 

	identifier2.layout_Identifier2 addHRI( identifier2.layout_Identifier2 le ) := TRANSFORM
		isEver    := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.EverOccupant, le.iid_flags );
		isCurrent := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.CurrentOccupant, le.iid_flags );
	
		// even though IID gets occupancy and ID2 gets it for free, don't output the RCs unless they're requested
		self.InputAddressEverOccupant.WasEverOccupant := includeEver and isEver;
		self.InputAddressEverOccupant.RiskIndicators   := IF( includeEver and not isEver, dataset([iesp.ECL2ESP.setStatusIndicator('ON',Identifier2.getRiskStatusDesc('ON'))], iesp.share.t_RiskIndicator));
		self.InputAddressEverOccupant.StatusIndicators := IF( includeEver and isEver,     dataset([iesp.ECL2ESP.setStatusIndicator('OY',Identifier2.getRiskStatusDesc('OY'))], iesp.share.t_RiskIndicator));

		self.InputAddressCurrentOccupant.IsCurrentOccupant := includeCurrent and isCurrent;
		self.InputAddressCurrentOccupant.RiskIndicators    := IF( includeCurrent and not isCurrent, dataset([iesp.ECL2ESP.setStatusIndicator('CX',Identifier2.getRiskStatusDesc('CX'))], iesp.share.t_RiskIndicator));
		self.InputAddressCurrentOccupant.StatusIndicators  := IF( includeCurrent and isCurrent,     dataset([iesp.ECL2ESP.setStatusIndicator('CY',Identifier2.getRiskStatusDesc('CY'))], iesp.share.t_RiskIndicator));

		self := le;
	END;
	withHRI := project( indata, addHRI(left) );

	return if( includeCurrent or includeEver, withHRI, indata );
	
end;