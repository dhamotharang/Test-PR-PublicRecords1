import mdr;

export Source_Codes :=
module

	export Organizations						:= MDR.sourceTools.src_MartinDale_Hubbell;
	export Affiliated_Individuals 	:= Organizations;
	export Unaffiliated_Individuals := Organizations;

	export All :=
	[
		 Organizations
		,Affiliated_Individuals 	
		,Unaffiliated_Individuals
	];

end;