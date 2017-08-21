import Address, BIPV2;

export Layout_Append_FakeIDs := module
	
		export LinkIds := record
				unsigned8 	unique_id;
				string120 	company_name;
				string9	 		company_fein;
				Address.Layout_Clean182.prim_range;
				Address.Layout_Clean182.prim_name;
				Address.Layout_Clean182.sec_range;
				Address.Layout_Clean182.p_city_name;				
				Address.Layout_Clean182.v_city_name;
				Address.Layout_Clean182.st;
				Address.Layout_Clean182.zip;
				Address.Layout_Clean182.zip4;				
				string20		fname;
				string20		mname;
				string20		lname;
				BIPV2.IDlayouts.l_xlink_ids;
				unsigned6 	lgid3	:= 0;
		end;

end;