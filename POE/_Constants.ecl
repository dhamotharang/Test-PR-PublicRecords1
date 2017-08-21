export _Constants(

	boolean	pUseOtherEnvironment	= false

) :=
module

	export autokey_buildskipset := [];
	/*
		'P' -- skip person phone key
		'S' -- skip ssn key
		'-' -- build zipPrlname key
		'Q' -- skip biz phone key
		'F' -- skip Fein key
		'C' -- skip person keys altogether
		'B' -- skip business keys altogether 
	*/

	shared lTemplate(string ptype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name + '::@version@::'	;

	export FileTemplate			:= lTemplate('base'	);
	export keyTemplate			:= lTemplate('key'	);
	export autokeytemplate	:= keyTemplate + 'autokey::';
	export statsTemplate		:= lTemplate('stats');

end;