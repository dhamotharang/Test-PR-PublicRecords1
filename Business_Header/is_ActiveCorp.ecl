export boolean is_ActiveCorp(string record_type, string corp_status_cd, string corp_status_desc) := 
	record_type = 'C' and 
	(	(corp_status_cd IN ['A','U']) OR
		(stringlib.stringfind(corp_status_desc, 'ACTIVE', 1) > 0 AND 
			stringlib.stringfind(corp_status_desc, 'INACTIVE', 1) = 0) OR
		(corp_status_desc <> '' AND stringlib.stringfind(corp_status_desc, 'INACTIVE', 1) = 0 AND
			stringlib.stringfind(corp_status_desc, 'DISSOLVED', 1) = 0) OR
		(corp_status_cd = '' AND corp_status_desc = '')
	);