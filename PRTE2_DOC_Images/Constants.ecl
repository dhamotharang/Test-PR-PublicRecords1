EXPORT Constants := Module

  EXPORT prefix													:= '~prte::criminal_images::';
		EXPORT in_prefix_name					:= prefix+'in::';
		EXPORT base_prefix_name			:= prefix+'base::criminal::';
		
		EXPORT prefix_v2											:= '~prte::criminal_images_v2::';
		EXPORT base_prefix_name_v2	:= prefix_v2+'base::criminal::';
		
		EXPORT keyname 											:= '~prte::criminal_images::key::criminal::';
		EXPORT keyname_v2 								:= '~prte::criminal_images_v2::key::criminal::';
		
		EXPORT SuperKeyName 						:= keyname+'@version@::';
		EXPORT SuperKeyName_v2 			:= keyname_v2+'@version@::';		
		
		end;