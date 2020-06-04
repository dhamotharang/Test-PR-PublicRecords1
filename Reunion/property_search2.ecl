//idea is to propagate the DID from the main file
//when the BEST name+address for that DID has a
//matching name+address BUT NO DID in the search file

//for records that don't have a DID
//propagate it from the main file
//when the name+address from the main file
//equal a name+address found in the search file

EXPORT property_search2(unsigned1 mode, STRING sVersion) := FUNCTION

    candidate := reunion.property_search1(did=0);
not_candidate := reunion.property_search1(did>0);

candidate_dist := distribute(candidate,              hash(fname,mname,lname,name_suffix,pro_prim_range,pro_prim_name,pro_sec_range,pro_zip));
appends_dist   := distribute(reunion.various_appends(mode, sVersion).all,hash(fname,mname,lname,name_suffix,    prim_range,    prim_name,    sec_range,    zip));

recordof(candidate_dist) t1(candidate_dist le, appends_dist ri) := transform
 self.did := ri.did;
 self     := le;
end;

//if no join here then cut that search record loose
j1 := join(candidate_dist,appends_dist,
           left.fname          =right.fname       and
		   left.mname[1]       =right.mname[1]    and
		   left.lname          =right.lname       and
		   left.name_suffix    =right.name_suffix and
		   left.pro_prim_range =right.prim_range  and
		   left.pro_prim_name  =right.prim_name   and
		   left.pro_sec_range  =right.sec_range   and
		   left.pro_zip        =right.zip,
		   t1(left,right),
		   keep(1),
		   local
		  );

concat := not_candidate+j1;

return concat;

END;
