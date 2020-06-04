import prte2;

EXPORT Constants := module
  
	export key_prefix		:= prte2.Constants.Prefix + 'key::firstdata::';
	export keyname 			:= key_prefix +'@version@::';
	export keyname_fcra	:= key_prefix+ 'fcra::@version@::';
	
end;	