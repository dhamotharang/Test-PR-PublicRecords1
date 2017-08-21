export mGetInputSuperfile(string pCorpType) :=
module

	export Sprayed := map(	pCorpType = 'CORP'	=> Filenames('').Input.Corp.Sprayed,
							pCorpType = 'CONT'	=> Filenames('').Input.Cont.Sprayed,
							pCorpType = 'EVENT'	=> Filenames('').Input.Events.Sprayed,
							pCorpType = 'STOCK'	=> Filenames('').Input.Stock.Sprayed, 
							pCorpType = 'AR'	=> Filenames('').Input.AR.Sprayed, 
	'');

	export Root    := map(	pCorpType = 'CORP'	=> Filenames('').Input.Corp.Root,
							pCorpType = 'CONT'	=> Filenames('').Input.Cont.Root,
							pCorpType = 'EVENT'	=> Filenames('').Input.Events.Root,
							pCorpType = 'STOCK'	=> Filenames('').Input.Stock.Root, 
							pCorpType = 'AR'	=> Filenames('').Input.AR.Root, 
	'');
end;