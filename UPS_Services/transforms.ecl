Import BIPV2, ut;
EXPORT transforms := module
	
	export BIPV2.IDfunctions.rec_SearchInput ConstructBipInput(UPS_Services.SearchParams si) := transform 
					self.company_name := si.NameQueryInputs.CompanyName;
					self.prim_range := si.AddrQueryInputs.StreetNumber;
					self.prim_name := si.AddrQueryInputs.StreetName;
					self.zip5 := si.AddrQueryInputs.Zip5;
					self.sec_range := si.AddrQueryInputs.UnitNumber;
					self.city := si.AddrQueryInputs.City;
					self.state := si.AddrQueryInputs.State;
					self.phone10 := si.PhoneQueryInput;
					self.contact_fname := si.NameQueryInputs.first;
					self.contact_mname := si.NameQueryInputs.middle;
					self.contact_lname := si.NameQueryInputs.last;
					self.acctno := '1';
					self.results_limit := 0;
					self.allow7digitmatch := false;
					self :=[];
				end;	
	

  export BIPV2.IDfunctions.rec_SearchInput adjustSearchInput(BIPV2.IDfunctions.rec_SearchInput l, boolean isAlternameSearch,string inName, string inphone) :=
			transform
					self.company_name := if(isAlternameSearch,ut.mod_AmpersandTools.createAlternativeName(inName) ,inName );
					self.phone10 := if(isAlternameSearch,l.phone10 ,inPhone );
					self.hsort := false;
					self := l;
			end;	

	
end;