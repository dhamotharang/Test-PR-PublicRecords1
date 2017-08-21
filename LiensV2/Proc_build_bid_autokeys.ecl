export Proc_build_bid_autokeys (string filedate) := function
	ds_in := project(LiensV2.file_liens_party_keybuild_bid,transform(LiensV2.Layout_liens_party_ssn_bid,self.bdid:=(string12)left.bid,self:=left));

	LiensV2.layout_liens_party_bid proj_rec(recordof(ds_in) L) := transform
		self.ssn := if((unsigned6)L.ssn <> 0, if(L.ssn[1..5] = '00000', L.ssn[6..9], L.ssn), L.app_ssn);
		self.tax_id := if(L.tax_id <> '', if(L.tax_id[1..5] = '00000', L.tax_id[6..9], L.tax_id), L.app_tax_id);
		self := L;
	end;

	file_party := project(ds_in,proj_rec(left));


// Build Autokeys



	autokeys := LiensV2.proc_bid_autokeyBuild(filedate, file_party);
	
	
	return sequential(autokeys,
										if(~fileservices.fileexists('~thor::dops::liensv2'),
								fileservices.createsuperfile('~thor::dops::liensv2')),
								output(dataset([{filedate}],{string processdate}),,'~thor::dops::liensv2::autokeys::bid',overwrite),
								fileservices.addsuperfile('~thor::dops::liensv2','~thor::dops::liensv2::autokeys::bid')
								);
end;