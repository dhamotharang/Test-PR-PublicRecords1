export Constants(boolean	pUseOtherEnvironment	= false) :=	module
	
	export autokey_buildskipset 			:= ['S','F'];
	shared lTemplate(string ptype)		:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name + '::@version@::'	;
	export FileTemplate								:= lTemplate('base'	);
	export keyTemplate								:= lTemplate('key'	);
	export autokeytemplate						:= keyTemplate + 'autokey::';
	export statsTemplate							:= lTemplate('stats');
	export autokey_qa_name 						:= Cluster+'key::diversity_certification::qa::autokey::';
	EXPORT ak_typeStr       					:= 'AK';

end;