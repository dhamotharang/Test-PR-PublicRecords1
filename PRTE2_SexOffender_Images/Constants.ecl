EXPORT Constants := module

		EXPORT prefix													:= '~prte::images::';
		EXPORT in_prefix_name					:= prefix+'in::sexoffender::';
		EXPORT base_prefix_name			:= prefix+'base::sexoffender::';
		
		EXPORT prefix_v2											:= '~prte::images_v2::';
		EXPORT base_prefix_name_v2	:= prefix_v2+'base::sexoffender::';
		
		EXPORT keyname 											:= '~prte::images::key::sexoffender::';
		EXPORT keyname_v2 								:= '~prte::images_v2::key::sexoffender::';
		
		EXPORT SuperKeyName 						:= keyname+'@version@::';
		EXPORT SuperKeyName_v2 			:= keyname_v2+'@version@::';		
		
		end;