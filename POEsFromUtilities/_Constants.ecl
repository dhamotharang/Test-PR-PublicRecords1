import tools;
export _Constants(

	boolean	pUseOtherEnvironment	= false

) :=
module

	export autokey_buildskipset := [];

	shared lTemplate(string ptype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name + '::@version@::'	;

	export FileTemplate			:= lTemplate('base'	);
	export keyTemplate			:= lTemplate('key'	);
	export statsTemplate		:= lTemplate('stats');

	export IsTesting 				:= Tools._Constants.IsDataland	;

end;