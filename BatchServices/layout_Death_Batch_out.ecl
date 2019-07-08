import header, address;

export layout_Death_Batch_out := RECORD
			STRING30 acctno := '';
			STRING30 matchcode := '';
			BOOLEAN isdeepdive := FALSE;
			Address.Layout_Clean182.prim_range;
			Address.Layout_Clean182.predir;
			Address.Layout_Clean182.prim_name;
			Address.Layout_Clean182.addr_suffix;
			Address.Layout_Clean182.postdir;
			Address.Layout_Clean182.unit_desig;
			Address.Layout_Clean182.sec_range;
			Address.Layout_Clean182.p_city_name;
			Address.Layout_Clean182.v_city_name;
			Address.Layout_Clean182.st;
			Address.Layout_Clean182.zip;
			Address.Layout_Clean182.zip4;
			STRING18 county_name;
			header.layout_death_master_supplemental.address;
			header.layout_death_master_supplemental.COUNTY_RESIDENCE;
			header.layout_death_master_supplemental.COUNTY_DEATH;
			header.Layout_Did_Death_MasterV2 - [CRLF, global_sid, record_sid];
END;