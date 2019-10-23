import strata;

export Strata_Stats(

	 dataset(layouts.base							)	pBaseFile					= files().base.built
	,string															pfileversion			= 'using'
	,boolean														pUseOtherEnviron	= _Constants().isdataland
	,dataset(Layouts.Input.Sprayed		)	pSprayedFile			= Files(pfileversion,pUseOtherEnviron).Input.logical

) :=
module

	Strata.mac_Pops		(pSprayedFile   	,dInputNoGrouping				  					  		  	);
	Strata.mac_Uniques(pSprayedFile	    ,dUniqueInputNoGrouping										    );
	Strata.mac_Pops		(pBaseFile				,dNoGrouping																	);
	Strata.mac_Pops		(pBaseFile				,dCleanAddressState				,'st'	);
	Strata.mac_Uniques(pBaseFile				,dUniqueNoGrouping														);
	Strata.mac_Uniques(pBaseFile				,dUniqueCleanAddressState	,'st'	);

end;