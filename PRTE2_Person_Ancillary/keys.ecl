import ut,IDL_Header;
EXPORT keys := module

  //Drop dids that have more than 20 ssns, but keep only 10 of the remainder
	 	p1 := project(files.ds,transform(recordof(left),
                self.cluster := IF(count(left.subject)>20,'DROP',left.cluster),
								self.subject := choosen(left.subject,10),
								self := left))(cluster<>'DROP');		
	
  //Only keep 10 other dids for a given ssn 	
	n1 := normalize(p1,LEFT.subject,
                  transform(layouts.subject_rec,
                            self.did := left.did,				          
									          self._subject.other := choosen(right.other,10),
														self._subject       := right,
														self := []));
	
  //Create empty subject subject in prep of denormalize  
	p2 := project(p1,transform(recordof(left),
                self.subject := dataset([],layouts._subject_rec),
								self := left));	
	
  d1 := denormalize(p2,n1,
	                  left.did = right.did,
										TRANSFORM(recordof(left),
										          self.subject := left.subject + right._subject,
															self:=left), hash);

  	 export key_did       := INDEX(d1, {did}, {d1},	constants.key_name + '@version@');
  
  	export key_did_file  := INDEX(files.DS_Did, {did}, {files.DS_did},	constants.key_name_did + '@version@');
	
  export key_dln  := INDEX(files.DS_dln, {dl_nbr}, {files.DS_dln},	constants.key_name_dln + '@version@');
end;