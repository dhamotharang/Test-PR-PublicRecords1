import seed_files;

export seedSDBO(string4 tribcode, string9 socs, string30 account) := function

critter := map(tribcode = 'b2b2' => '002',
			tribcode = 'b2bc' => '013',
			tribcode = 'ex24' => '024',
			tribcode = 'ex41' => '041',
			tribcode = 'ex98' => '001',
			tribcode = 'b2bz' => '001',
			tribcode = 'b2b4' => '004',
			'002');

seed_files.mac_query_seedfiles(socs, 'sdbo', 'sd2i', critter, seed_output);
seed_files.mac_query_seedfiles(socs, 'sd5o', 'sd5i', critter, b2bz_seed_output);
seed_files.mac_query_seedfiles(socs, 'sdbo', 'sd4i', critter, ex98_seed_output);

riskwise.Layout_SDBO format_seed(seed_output le) := transform
	self.account := account;
	self := le;
end;

riskwise.Layout_SDBO format_seed2(b2bz_seed_output le) := transform
	self.account := account;
	self := le;
end;

riskwise.Layout_SDBO format_seed3(ex98_seed_output le) := transform
	self.account := account;
	self := le;
end;

seed := project(seed_output, format_seed(left));
b2bz_seed := project(b2bz_seed_output, format_seed2(left));
ex98_seed := project(ex98_seed_output, format_seed3(left));

final_seed := map(tribcode in ['b2bz', 'b2b4'] => b2bz_seed,
				tribcode='ex98' => ex98_seed,
				seed);
// just an extra precaution that we only return 1 seed record in case the file has duplicate socials
one_seed := rollup(final_seed, true, transform(riskwise.Layout_SDBO, self:=left)); 
				
return one_seed;

end;