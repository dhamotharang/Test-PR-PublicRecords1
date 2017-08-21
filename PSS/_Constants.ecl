export _Constants(

	boolean	pUseOtherEnvironment	= false

) :=
module
	shared lTemplate(string ptype, string subtype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name +  subtype + '::@version@::'	;
	shared aTemplate(string ptype, string subtype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name +  subtype;
	export InRequestFileTemplate			:= aTemplate('in'	,'::request');
	export InResponseFileTemplate			:= aTemplate('in'		,'::response');
	export InRequestFixedFileTemplate			:= aTemplate('in'	,	'::request_fixed');
	export InResponseFixedFileTemplate			:= aTemplate('in','::response_fixed'	);
	
	export FileTemplate			:= lTemplate('base',''	);
	export keyTemplate			:= lTemplate('key',''	);
	export statsTemplate		:= lTemplate('stats','');
end;