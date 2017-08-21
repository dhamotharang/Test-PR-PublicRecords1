import strata,Statistics;

export Strata_Stats(

	  dataset(layouts.base)	pInput			= files().base.built

) :=
module

	Strata.mac_Pops(pInput,dNoGrouping																										);
	Strata.mac_Pops(pInput,dDefendantaddressState						,'Clean_Defendant_address.st'	);
	Strata.mac_Pops(pInput,dAttorneyaddressState						,'Clean_attorney_address.st'	,pKeepGroupByField := true);

	Strata.mac_Uniques(pInput,dUniqueNoGrouping																						);
	Strata.mac_Uniques(pInput,dUniqueDefendantaddressState	,'Clean_Defendant_address.st'	);
	Strata.mac_Uniques(pInput,dUniqueAttorneyaddressState		,'Clean_attorney_address.st'	,pKeepGroupByField := true);

end;