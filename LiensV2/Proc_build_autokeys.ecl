export Proc_build_autokeys (string filedate) := function
	ds := LiensV2.file_liens_party_keybuild;

	Liensv2.layout_liens_party proj_rec(ds L) := transform
		self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
		self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
		self := L;
	end;

	file_party := project(ds,proj_rec(left));


// Build Autokeys



	autokeys := LiensV2.proc_autokeyBuild(filedate, file_party, Liensv2.file_liens_main);
	
	
	
	return sequential(autokeys,
										if(~fileservices.fileexists('~thor::dops::liensv2'),
								fileservices.createsuperfile('~thor::dops::liensv2')),
								fileservices.RemoveSuperFile('~thor::dops::liensv2','~thor::dops::liensv2::autokeys'),
								output(dataset([{filedate}],{string processdate}),,'~thor::dops::liensv2::autokeys',overwrite),
								fileservices.addsuperfile('~thor::dops::liensv2','~thor::dops::liensv2::autokeys')
								);
end;