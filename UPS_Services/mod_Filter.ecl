import iesp, nid, ut;

export mod_Filter(
	dataset(iesp.rightaddress.t_RightAddressSearchRecord) recs,
	iesp.share.t_NameAndCompany inName,
	iesp.share.t_Address inAddr,
	string10 inPhone,
	string50 powersearch,
	unsigned1 EditDistanceAllowed0
) := 
MODULE

/*
if powersearch, just pass it through (for now)
we also need to turn off the scoring normalizer in this mode
*/

// CHECK EditDistanceAllowed FOR ALLOWED VALUES
unsigned1 EditDistanceAllowed := //its unsigned, so we dont have to check for negative values
if(
	EditDistanceAllowed0 > 3,
	3,
	EditDistanceAllowed0
);

// NAME WORK

highlightStartTag := '<em>'; //get these as exports from mod_highlight instead
highlightEndTag := '</em>';

clean(string s) := stringlib.stringfilterout(stringlib.stringfilterout(s, highlightStartTag), highlightEndTag);
pf(string s) := NID.PreferredFirstNew(clean(s)); //should reference NID instead
up(string s) := stringlib.stringtouppercase(s);
// pf(string s) := s;

personnameOK(string f, string m, string l) := 
FUNCTION

	// if any name is input, it must match output within Edit Distance of EditDistanceAllowed
	// - allow for name flipping?  yes
	ok(string i) := 
	i = '' 
	OR stringlib.EDITDISTANCE(pf(f), i) <= EditDistanceAllowed 
	OR stringlib.EDITDISTANCE(clean(f), i) <= EditDistanceAllowed 
	OR stringlib.EDITDISTANCE(pf(m), i) <= EditDistanceAllowed 
	OR stringlib.EDITDISTANCE(clean(m), i) <= EditDistanceAllowed 
	OR stringlib.EDITDISTANCE(pf(l), i) <= EditDistanceAllowed
	OR stringlib.EDITDISTANCE(clean(l), i) <= EditDistanceAllowed; 

	return ok(pf(up(inName.First))) AND ok(pf(up(inName.Middle))) and ok(pf(up(inName.Last)));
END;

cnameOK(string c) := 
FUNCTION

	//they want company name AKAs and DBAs (better use company name match for company records)
	return inName.CompanyName = '' or ut.CompanySimilar(clean(c), up(inName.CompanyName)) <= 4;
END;


nameOK(string f, string m, string l, string c) := 
FUNCTION

	isCrec := c <> '';

	return if(isCrec, cnameOK(c), personnameOK(f,m,l));
END;


// ADDRESS WORK

streetOK(string pr, string pn) :=
FUNCTION
	
	//They say they want street numbers corrected and they want street synonyms to match, like ?Rt 15? should return ?US Highway Route 15?, etc.
	//so i am not quite sure if this implementation satisfies that now

	ok(string i, string v) := 
	i = '' 
	OR stringlib.EDITDISTANCE(i, clean(v)) <= EditDistanceAllowed;

	return ok(up(inAddr.StreetNumber), pr) AND ok(up(inAddr.StreetName), pn);

END;

localOK(string z, string c, string s) :=
FUNCTION

	inputs_used := 
	if(inAddr.zip5 <> '', 1, 0)
	+if(inAddr.city <> '', 1, 0)
	+if(inAddr.state <> '', 1, 0);

	matches_needed :=   //this is by their specification
	case(
		inputs_used,
		0 => 0,
		1 => 1,
		2 => 1,
		3 => 2,
		0
	);

	matches_found :=
	if(inAddr.zip5 <> '' and inAddr.zip5 = clean(z), 1, 0)
	+if(inAddr.city <> '' and stringlib.EDITDISTANCE(clean(c), up(inAddr.city)) <= EditDistanceAllowed , 1, 0)
	+if(inAddr.state <> '' and up(inAddr.state) = clean(s), 1, 0);

	return matches_found >= matches_needed;

END;

addressOK(string pr, string pn, string z, string c, string s) :=
FUNCTION

return streetOK(pr, pn) and localOK(z, c, s);

END;


// PROJECT THRU THE FILTER
iesp.rightaddress.t_RightAddressSearchRecord traOK(iesp.rightaddress.t_RightAddressSearchRecord le) :=	
transform
		addrsMatched := le.addresses(addressOK(streetnumber, streetname, zip5, city, state));
		
		newestAddrMatched := sort(addrsmatched, -datelastseen.year, -datelastseen.month)[1];
		
		newestAddrMatchedYear := newestAddrMatched.datelastseen.year;
		newestAddrMatchedMonth := newestAddrMatched.datelastseen.month;
		
		addrsNewerThanAddrsMatched :=
		le.addresses(
			newestAddrMatchedYear > 0 and
			(datelastseen.year > newestAddrMatchedYear or 
			 (datelastseen.year = newestAddrMatchedYear and datelastseen.month > newestAddrMatchedMonth)
			)
		);		
		UPS_Services.mac_SortAddresses(addrsNewerThanAddrsMatched + addrsmatched, addrssrtd);

		self.names := le.names(nameOK(first,middle,last,companyname)),
		self.addresses :=  addrssrtd;
			
		self := le
end;

recs_filtered := 
project(
	recs(powersearch = ''),
	traOK(left)
)
+ recs(powersearch <> '');

export results := recs_filtered(exists(names) and exists(addresses));

END;

