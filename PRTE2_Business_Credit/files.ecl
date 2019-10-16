import prte2_business_credit;

EXPORT files := module

export dsBusinessClassification  := dataset([ ], layouts.BIClassification);
export dsBusinessInfo						 := dataset([ ], layouts.BusinessInformation);
export dsBusinessOwner					 := dataset([ ], layouts.BusinessOwner);
export dsCollateral    					 := dataset([ ], layouts.Collateral);
export dsHistory								 := dataset([ ], layouts.HistorySlim);
export dsIndvOwner							 := dataset([ ], layouts.IndividualOwner);
export dsIOInformation					 := dataset([ ], layouts.IOInformation);
export dsMasterAccount					 := dataset([ ], layouts.MasterAccount);
export dsMemberSpecific					 := dataset([ ], layouts.MemberSpecific);
export dsReleaseDates						 := dataset([ ], layouts.ReleaseDates);
export dsTradeline							 := dataset([ ], layouts.Tradelines);
export dslinkids  							 := DATASET([ ],{layouts.LinkedBase, integer1 fp});
export dsBusinessOwnerInfo   		 := DATASET([ ], layouts.BOInformation);
export dsTradelineGuarantor	 		 := DATASET([ ], layouts.TradelineBase);
export dsScoring					   		 := DATASET([ ], layouts.ScoringIndex);
export dsKey_Best								 := DATASET([ ], layouts.BestKey);

end;
