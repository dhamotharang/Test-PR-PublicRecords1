import ut, Business_Header, Business_Header_SS, address, Header, Header_Slimsort, didville, ut, DID_Add,mdr, AID,idl_header,TopBusiness_External;

export Grab_Contacts(dataset(Layout_Corporate_Direct_Cont_In		) pContUsing				= files().input.Cont.using
										,dataset(Layout_Corporate_Direct_Cont_AID		) pContBase					= files().AID.Cont.QA
										) :=  function

NameOnlyLayout	:=	record
	string30  corp_key;
	string20  cont_fname;
	string20  cont_mname;
	string20  cont_lname;
end;

// Project Update to Temp Format
NameOnlyLayout InitUpdate(Layout_Corporate_Direct_Cont_In l, unsigned1 cnt) := transform
self.cont_fname := choose(cnt, l.cont_fname1,
                               l.cont_fname2,
															 l.cont_fname3,
                               l.cont_fname4,
                               l.cont_fname5,
															 '',
															 '');
self.cont_mname := choose(cnt, l.cont_mname1,
                               l.cont_mname2,
															 l.cont_mname3,
                               l.cont_mname4,
                               l.cont_mname5,
															 '',
															 '');
self.cont_lname := choose(cnt, l.cont_lname1,
                               l.cont_lname2,
															 l.cont_lname3,
                               l.cont_lname4,
                               l.cont_lname5,
															 '',
															 '');

self := l;
end;

cont_update_dist 	:= distribute(pContUsing, hash(corp_key));
cont_update_sort 	:= sort(cont_update_dist,record,local);
cont_update_dedup := dedup(cont_update_sort,record,local);

cont_update_norm 	:= normalize(cont_update_dedup, 7, InitUpdate(left, counter),local);

// Filter out blank contact names
cont_update_init 	:= cont_update_norm(cont_lname <> '' or corp_key<>'');

cont_update_init_dist 	:=	distribute(cont_update_init, hash(corp_key));
cont_update_init_dedup 	:= 	dedup(sort(cont_update_init_dist, corp_key,cont_lname,cont_fname,cont_mname,local),corp_key,cont_lname,cont_fname,cont_mname,local);
						   
// Initialize Current base file
NameOnlyLayout InitCurrentBase(Layout_Corporate_Direct_Cont_AID l) := transform
	self := l;
end;

cont_current_init := project(Filters.Base.Cont(pContBase), InitCurrentBase(left));

cont_current_init_dedup := dedup(sort(distribute(cont_current_init, hash(corp_key)), corp_key,cont_lname,cont_fname,cont_mname,local),corp_key,cont_lname,cont_fname,cont_mname,local);

// Combine current base with update
cont_update_combined := cont_current_init_dedup + cont_update_init_dedup;

// code added for CA issue bug # 136834						
setKeys	:=	['06-200803810290','06-201216610151']; 
			   
return cont_update_combined(corp_key not in setKeys or (corp_key in setKeys and cont_lname = 'KIMINECZ'));

end;