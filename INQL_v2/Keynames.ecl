import tools;

export Keynames(string pVersion = '', boolean pFCRA = false, boolean pDaily = true) := module
	
	shared fcra := if(pFCRA, '::fcra', '::nonfcra');
	shared hist	:= if(pDaily, '', 'history::');
	shared prefixKey := INQL_v2._Constants.prefix + 'key::' + INQL_v2._Constants.DatasetName + fcra;	
	
	INQL_lFileTemplate	:= prefixKey + '::inquiry_tracking::' + hist + '@version@::';
	INQL_lkey						:= INQL_lFileTemplate + 't';
	export INQL_key			:= tools.mod_FilenamesBuild(INQL_lkey	,pversion);
	
end;