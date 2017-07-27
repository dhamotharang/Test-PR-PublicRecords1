import seed_files, risk_indicators;

export seedNP2O(string4 tribcode, string9 socs, string30 account) := function

critter := map(
			tribcode = 'np90' => '090',
			tribcode = 'np91' => '091',
			tribcode = 'np92' => '092',
			tribcode = 'np80' => '080',
			tribcode = 'np81' => '081',
			tribcode = 'np21' => '001',
			tribcode = 'np22' => '002',
			tribcode = 'np29' => '029',
			tribcode = 'np70' => '070',
			tribcode = 'ex28' => '228',
			tribcode = 'ex29' => '229',
			tribcode = 'np31' => '331',
			tribcode = 'np32' => '332',
			tribcode = 'np25' => '005',
			tribcode = 'np52' => '052',
			tribcode = 'np82' => '082',
			tribcode = 'np33' => '333',
			tribcode = 'ex49' => '249',
			'');

seed_files.mac_query_seedfiles(socs, 'np2o', 'prii', critter, prii_seed_output);
seed_files.mac_query_seedfiles(socs, 'np2o', 'pr2i', critter, pr2i_seed_output);

riskwise.Layout_NP2O format_seed(prii_seed_output le) := transform
	self.account := account;
	self.Billing := [];//dataset([], risk_indicators.Layout_Billing);
	self := le;
end;

riskwise.Layout_NP2O format_seed2(pr2i_seed_output le) := transform
	self.account := account;
	self.Billing := [];//dataset([], risk_indicators.Layout_Billing);
	self := le;
end;

prii_seed := project(prii_seed_output, format_seed(left));
pr2i_seed := project(pr2i_seed_output, format_seed2(left));

final_seed := if(tribcode in ['np80','np81','np82','np90','np91','np92'], pr2i_seed, prii_seed);

// just an extra precaution that we only return 1 seed record in case the file has duplicate socials
one_seed := rollup(final_seed, true, transform(riskwise.Layout_NP2O, self:=left)); 
				
return one_seed;

end;