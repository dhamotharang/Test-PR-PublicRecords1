import Data_Services;

export Constants := module
	// export thor_cluster            := Data_Services.Data_location.Prefix('american_student') + thor_cluster;
	export autokey_qa_keyname 							:= thor_cluster + 'key::american_student::autokey::qa::';
	export autokey_keyname									:= thor_cluster + 'key::american_student::autokey::@version@::';
	export autokey_logical(string filedate) := thor_cluster + 'key::american_student::' + filedate + '::autokey::';
	export autokey_typeStr  								:= '/AK/'; 
	export autokey_skipSet  								:= ['B','Q','F']; 
end;