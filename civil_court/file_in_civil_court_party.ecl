import ut;

aidfile := dataset('~thor_200::base::civil_party_aid_' + civil_court.Version_Development,
				      civil_court.aid_layouts,flat);

//temporarily removing AID until its ok to add to the keys.	
Civil_Court.Layout_Roxie_Party trecs(aidfile L) := transform
self := L;
end;

precs := project(aidfile,trecs(left));
				  
export file_in_civil_court_party := precs;				  
					  
					  
					  