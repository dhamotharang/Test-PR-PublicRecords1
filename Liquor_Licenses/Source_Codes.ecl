import mdr;
export Source_Codes :=
module

	export CA := MDR.sourceTools.src_CA_Liquor_Licenses;		// California
	export CT := MDR.sourceTools.src_CT_Liquor_Licenses;		// Conneticut
	export IN := MDR.sourceTools.src_IN_Liquor_Licenses;		// Indiana
	export LA := MDR.sourceTools.src_LA_Liquor_Licenses;		// Louisiana
	export OH := MDR.sourceTools.src_OH_Liquor_Licenses;		// Ohio
	export PA := MDR.sourceTools.src_PA_Liquor_Licenses;		// Pennsylvania -- PL is used by professional licenses
	export TX := MDR.sourceTools.src_TX_Liquor_Licenses;		// TX
                            
	export All :=
	[
		 CA
		,CT
		,IN
		,LA
		,OH
		,PA
		,TX
	];

end;