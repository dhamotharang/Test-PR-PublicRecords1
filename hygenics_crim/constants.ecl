import Criminal_Records;

export constants(string filedate) := module
  export ak_QAname	:= Criminal_Records.cluster.cluster_out + 'key::corrections::autokey::qa::';
	export ak_keyname	:= Criminal_Records.cluster.cluster_out + 'key::corrections::autokey::@version@::';
	export ak_logical	:= Criminal_Records.cluster.cluster_out + 'key::corrections::' + filedate + '::autokey::';
	// export ak_typestr := 'CRIM';
	export ak_typestr := 'AK';
	export ak_dataset := hygenics_crim.File_offenders_autokey;
  export skip_set		:= ['B','P'];
end;