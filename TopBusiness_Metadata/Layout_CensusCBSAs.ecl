export Layout_CensusCBSAs := module

	export ByCountyFIPS := record
		string2 state;
		string3 fips_county;
		string5 csa_number;
		string5 msa_number;
	end;
	
	export ByCBSA := record
		string5 cbsa_number;
		string100 cbsa_name;
	end;

end;
