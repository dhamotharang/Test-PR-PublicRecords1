export _Constants(

	boolean	pUseOtherEnvironment	= false

) :=
module

	export autokey_buildskipset := [];

	shared lTemplate(string ptype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name + '::@version@::'	;

	export FileTemplate			:= lTemplate('base'	);
	export keyTemplate			:= lTemplate('key'	);
	export autokeytemplate	:= keyTemplate + 'autokey::';
	export statsTemplate		:= lTemplate('stats');

end;