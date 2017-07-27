export constants(string filedate) := module
  export ak_QAname	:= cluster.cluster_out + 'key::corrections::autokey::qa::';
	export ak_keyname	:= cluster.cluster_out + 'key::corrections::autokey::@version@::';
	export ak_logical	:= cluster.cluster_out + 'key::corrections::' + filedate + '::autokey::';
	// export ak_typestr := 'CRIM';
	export ak_typestr := 'AK';
	export ak_dataset := Criminal_Records.File_offenders_autokey;
  export skip_set		:= ['B','P'];
end;