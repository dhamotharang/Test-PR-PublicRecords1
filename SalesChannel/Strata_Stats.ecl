import strata;
export Strata_Stats(
	 dataset(layouts.base_new							)	pBaseFile					= files().base.built
) :=
module

	shared lbase4strata	:= project(pBaseFile	,transform(layouts.strata_base	,self.record_type := utilities.RTToText(left.record_type);self := left));

	Strata.mac_Pops		(lbase4strata				,dNoGrouping																	);
	Strata.mac_Pops		(lbase4strata				,dCleanAddressState				,'clean_address.st'	);
	Strata.mac_Pops		(lbase4strata				,dRecordType							,'record_type'			);
	Strata.mac_Uniques(lbase4strata				,dUniquesNoGrouping														);
end;
