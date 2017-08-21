import OIG;

export Constants(boolean	pUseOtherEnvironment	= false) :=	module
	export autokey_buildskipset 		:= ['F','P','Q'];   // B: Skip Biz Data
		                                                  // C: Skip Person Contact Data
																		  // F: Skip FEIN
																		  // P: Skip Personal Phones
																		  // Q: Skip Biz Phones
																		  // S: Skip SSN
	shared lTemplate(string ptype)	:= OIG._Dataset(pUseOtherEnvironment).thor_cluster_files+ ptype + '::'	+ _Dataset().name + '::@version@::'	;
	export FileTemplate							:= lTemplate( 'base'	);
	export keyTemplate							:= lTemplate( 'key'	);
	export autokeytemplate					:= keyTemplate + 'autokey::';
	export autokey_qa_root	 				:= OIG._Dataset(pUseOtherEnvironment).thor_cluster_files+'key::oig::qa::autokey::';
																						
end;