import Data_Services;

export Constants := module
	export autokey_qa_keyname 							:= thor_cluster + 'key::bank_routing::autokey::qa::';
	export autokey_keyname									:= thor_cluster + 'key::bank_routing::autokey::@version@::';
	export autokey_logical(string filedate) := thor_cluster + 'key::bank_routing::' + filedate + '::autokey::';
	export autokey_typeStr  								:= '\'AK\''; 
	export autokey_skipSet  								:= ['P','S']; 
end;