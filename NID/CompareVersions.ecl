IMPORT STD;

divide(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
	decimal8_2 x := (dividend*1000)/divisor;
	x1 := ROUND(x);
	decimal6_1 v := x1/10;	
	return v;	
END;
// 
decimal6_1 get_pct(INTEGER	dividend ,INTEGER	divisor)
  :=		
			MAP(
				divisor=0 => -1,
				divide(dividend, divisor)
			);

r1 := RECORD
	unsigned8		nid;
	string1			type1;
	string2			type2;
	string64		name;
	string64		name1;
	string64		name2;
	string20		lname1;
	string20		lname2;
	string			delta;
END;



EXPORT CompareVersions(DATASET(nid.Layout_Repository) v1, DATASET(nid.Layout_Repository) v2) := FUNCTION

	j := join(v1, v2, left.nid=right.nid, transform(r1,
					self.delta := rowdiff(left, right);
					self.type1 := left.nametype;
					self.type2 := right.nametype;
					self.name1 := Std.Str.CleanSpaces(left.cln_fname+' '+left.cln_mname+' '+left.cln_lname+' '+left.cln_suffix);
					self.name2 := Std.Str.CleanSpaces(right.cln_fname+' '+right.cln_mname+' '+right.cln_lname+' '+right.cln_suffix);
					self.lname1 := left.cln_lname;
					self.lname2 := right.cln_lname;
					self := left;), inner, local);


	diff := j(type1<>type2 OR name1<>name2);
	ndiff := j(regexfind('\\b(cln_fname|cln_mname|cln_lname)\\b', delta), type1 in ['D','P'], type2 in ['D','P']);

	return PARALLEL(
		OUTPUT(SORT(TABLE(v1, {v1.nametype,cnt := COUNT(GROUP),pct := get_pct(COUNT(GROUP),COUNT(v1))}, 
											nametype, FEW),nametype),named('Types1'));
		OUTPUT(SORT(TABLE(v2, {v2.nametype,cnt := COUNT(GROUP),pct := get_pct(COUNT(GROUP),COUNT(v2))}, 
											nametype, FEW),nametype),named('Types2'));
		OUTPUT(COUNT(v1), named('n_v1'));
		OUTPUT(COUNT(v2), named('n_v2'));
		OUTPUT(diff, named('diffs'));
		OUTPUT(COUNT(diff), named('n_delta'));
		OUTPUT(COUNT(j), named('n_total'));
		OUTPUT(CHOOSEN(j(regexfind('nametype', delta),type2='T'),1000), named('nametypeT'));
		OUTPUT(COUNT(j(regexfind('nametype', delta),type2='T')), named('n_nametypeT'));
		OUTPUT(CHOOSEN(j(regexfind('nametype', delta),type2='P'),1000), named('nametypeP'));
		OUTPUT(COUNT(j(regexfind('nametype', delta),type2='P')), named('n_nametypeP'));
		OUTPUT(CHOOSEN(j(regexfind('nametype', delta),type2='B'),1000), named('nametypeB'));
		OUTPUT(COUNT(j(regexfind('nametype', delta),type2='B')), named('n_nametypeB'));
		OUTPUT(CHOOSEN(j(regexfind('nametype', delta),type2='D'),1000), named('nametypeD'));
		OUTPUT(COUNT(j(regexfind('nametype', delta),type2='D')), named('n_nametypeD'));
		OUTPUT(CHOOSEN(j(regexfind('nametype', delta),type2='I'),1000), named('nametypeI'));
		OUTPUT(COUNT(j(regexfind('nametype', delta),type2='I')), named('n_nametypeI'));
		OUTPUT(CHOOSEN(ndiff,1000), named('namechange'));
		OUTPUT(COUNT(ndiff), named('n_namechange'));

	);
END;