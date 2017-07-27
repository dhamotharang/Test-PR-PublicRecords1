export Constants(boolean	pUseOtherEnvironment	= false) :=	module
	export autokey_buildskipset 		:= ['C','F','P','Q','S'];   // B: Skip Biz Data
		                                                  // C: Skip Person Contact Data
																		  // F: Skip FEIN
																		  // P: Skip Personal Phones
																		  // Q: Skip Biz Phones
																		  // S: Skip SSN
	shared lTemplate(string ptype)	:= _Dataset(pUseOtherEnvironment).thor_cluster_files+ ptype + '::'	+ _Dataset().name + '::@version@::'	;
	
	export keyTemplate					:= lTemplate( 'key'	);
	export autokeytemplate				:= keyTemplate + 'autokey::';
	export autokey_qa_root	 			:= _Dataset(pUseOtherEnvironment).thor_cluster_files+'key::ecrulings::qa::autokey::';

end;