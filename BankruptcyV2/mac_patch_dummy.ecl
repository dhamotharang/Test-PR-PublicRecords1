export mac_patch_dummy(dataset(recordof(BankruptcyV2.layout_bankruptcy_search_v3_supp_bip)) infile) := function


#uniquename(trecs)
#uniquename(precs)

infile %trecs%(infile L) := transform
self.did := map(L.ssn='351762213' and 
				//L.dob='19750415' and
				L.lname = 'MARSUPIAL' and 
				L.fname='MARK' =>'999999001001',L.did);
self := L;
end;

%precs% := project(infile,%trecs%(left));

return
%precs%;

end;

