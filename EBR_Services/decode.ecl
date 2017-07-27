export decode := Module

	export string DPP(string pp) := case(pp,
	'F' => 'Pays sooner than 50%',
	'L' => 'Pays slower than 70%',
	'S' => 'Pays the same',
	'H' => 'Pays slower than 50%',
	'');
	
	export string DPT(string pt) := case(pt,
	'S' => 'Stable',
	'L' => 'Increasingly late',
	'B' => 'Increasingly late, but better than industry',
	'I' => 'Improving',
	'P' => 'Improving, but slower than industry',
	'N' => 'No trend identifiable',
	'');
	
end;