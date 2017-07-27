export fn_addr_suffix_corrections(dataset(recordof(header.Layout_Header)) in_hdr) := function

in_hdr_dist := distribute(in_hdr,hash(did,prim_range,prim_name,zip));

f := in_hdr_dist(suffix<>'');

cross :=
RECORD
	f.did;
	f.predir;
	f.postdir;
	f.prim_range;
	f.prim_name;
	f.suffix;
	f.zip;
	cnt := COUNT(GROUP);
END;
tab := TABLE(f,cross,did,predir,postdir,prim_range,prim_name,suffix,zip,LOCAL);

cross2 :=
RECORD
	tab.did;
	tab.predir;
	tab.postdir;
	tab.prim_range;
	tab.prim_name;
	// f.suffix;
	tab.zip;
	cnt := COUNT(GROUP);
END;
tab2 := TABLE(tab,cross2,did,predir,postdir,prim_range,prim_name,zip,LOCAL);

multi_suff := tab2(cnt=2);

// just work with those addresses that have more than 1 suffix
j := JOIN(tab,multi_suff, 
          LEFT.did=RIGHT.did               AND
		  LEFT.prim_range=RIGHT.prim_range AND
		  LEFT.prim_name=RIGHT.prim_name   AND
		  LEFT.zip=RIGHT.zip               AND
		  LEFT.predir=RIGHT.predir         AND 
		  LEFT.postdir=RIGHT.postdir, 
		  TRANSFORM(cross, SELF := LEFT), 
		  LOCAL
		 );

crossplus :=
RECORD
	cross;
	typeof(f.suffix) old_suffix;
END;	
	
crossplus j2_tra(cross le, cross ri) :=
TRANSFORM
	SELF.old_suffix := le.suffix;
	SELF.suffix := ri.suffix;
	SELF := le;
END;

j2 := JOIN(j,j, 
           LEFT.did=RIGHT.did               AND
		   LEFT.cnt=1 AND RIGHT.cnt>2       AND
		   LEFT.prim_range=RIGHT.prim_range AND
		   LEFT.prim_name=RIGHT.prim_name   AND
		   LEFT.zip=RIGHT.zip               AND
		   LEFT.suffix<>RIGHT.suffix        AND
		   LEFT.predir=RIGHT.predir         AND 
		   LEFT.postdir=RIGHT.postdir,		   
		   j2_tra(LEFT,RIGHT),
		   LOCAL
		  );
								
header.Layout_Header t_correct_suffixes(in_hdr_dist le, j2 ri) := transform
 self.suffix := if(ri.old_suffix<>'',ri.suffix,le.suffix);
 self        := le;
end;

correct_suffixes := join(in_hdr_dist,j2,
                         left.did=right.did               AND
						 left.prim_range=right.prim_range AND
						 left.prim_name=right.prim_name   AND
						 left.zip=right.zip               AND
						 left.suffix=right.old_suffix     AND
						 left.predir=right.predir         AND
						 left.postdir=right.postdir,
						 t_correct_suffixes(left,right),
						 LEFT OUTER, LOCAL
						);


return correct_suffixes;
								
end;