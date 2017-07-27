EXPORT Constants := MODULE
  EXPORT Constant(String2 str):= function
		return case(str,
								 'VO' => 'Voters',
								 'UC' => 'UCC',
								 'PR' => 'Property',
								 'HF' => 'HuntingFishing',
								 'PL' => 'ProfLics',
								 'BK' => 'Bankruptcy',
								 'CH' => 'Criminal Hist',
								 'LI' => 'Liens',
								 'MD' => 'MarriageDivorce',
								 'DE' => 'Death',
								 'DL' => 'DriversLicense',
								 'CB' => 'CABusiness',
								 'TB' => 'TXBusiness',
								 'CO' => 'CorpData',
								 'FB' => 'FictBusName',
								 'WP' => 'WhitePages',//'TargusWhPgs'
								 'WC' => 'WaterCraft',
								 'VH' => 'Vehicles',
								 'EQ' => 'PersonLocator1',//'EquiFax'
								 'EN' => 'PersonLocator5',//'Experian' 
								 'TN' => 'PersonLocator6',//'TU Credit Header'
								 'CR' => 'Criminal',
         				 str);
				 
				 
				 
	END;
END;