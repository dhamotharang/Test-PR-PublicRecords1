export Layout_Append_Gong_Biz := module
	export Layout_In := record
		unsigned __seq;
		string10 phone;
		dataset({string120 company_name}) company_names {maxcount(1000)};
	end;
	export Layout_Out := record
		unsigned __seq;
		string10 phone;
		boolean verified;
	end;
end;