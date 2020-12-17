import ut, header;

export constants(string filedate) := module

		export str_autokeyName := cluster.cluster_out + 'key::ebr_autokey::';
		export str_autokeyLogical := cluster.cluster_out + 'key::ebr::' + filedate + '::autokey::';
		export str_typeStr := 'BC';
		export ak_skipSet := ['C','F'];
end;
