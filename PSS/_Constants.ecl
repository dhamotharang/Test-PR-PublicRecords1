export _Constants(

	boolean	pUseOtherEnvironment	= false

) :=
module
	shared lTemplate(string ptype, string subtype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name +  subtype + '::@version@::'	;
	shared aTemplate(string ptype, string subtype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name +  subtype;
	export InRequestFileTemplate			:= lTemplate('in'	,'::request');
	export InResponseFileTemplate			:= lTemplate('in'		,'::response');
	export InRequestFixedFileTemplate			:= lTemplate('in'	,	'::request_fixed');
	export InResponseFixedFileTemplate			:= lTemplate('in','::response_fixed'	);
	
	export FileTemplate			:= lTemplate('base',''	);
	export keyTemplate			:= lTemplate('key',''	);
	export statsTemplate		:= lTemplate('stats','');
	
	export InRequestFileaTemplate := aTemplate('in'	,'::request');
	export InResponseFileaTemplate := aTemplate('in'	,'::response');
end;