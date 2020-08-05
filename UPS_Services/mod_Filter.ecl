IMPORT iesp, nid, ut, STD;

EXPORT mod_Filter(
  DATASET(iesp.rightaddress.t_RightAddressSearchRecord) recs,
  iesp.share.t_NameAndCompany inName,
  iesp.share.t_Address inAddr,
  STRING10 inPhone,
  STRING50 powersearch,
  UNSIGNED1 EditDistanceAllowed0
) :=
MODULE

/*
if powersearch, just pass it through (for now)
we also need to turn off the scoring normalizer in this mode
*/

// CHECK EditDistanceAllowed FOR ALLOWED VALUES
UNSIGNED1 EditDistanceAllowed := //its unsigned, so we dont have to check for negative values
IF(
  EditDistanceAllowed0 > 3,
  3,
  EditDistanceAllowed0
);

// NAME WORK

highlightStartTag := '<em>'; //get these as exports from mod_highlight instead
highlightEndTag := '</em>';

clean(STRING s) := STD.STR.FilterOut(STD.STR.FilterOut(s, highlightStartTag), highlightEndTag);
pf(STRING s) := NID.PreferredFirstNew(clean(s)); //should reference NID instead
up(STRING s) := STD.STR.ToUpperCase(s);
// pf(string s) := s;

personnameOK(STRING f, STRING m, STRING l) :=
FUNCTION

  // if any name is input, it must match output within Edit Distance of EditDistanceAllowed
  // - allow for name flipping? yes
  ok(STRING i) :=
  i = ''
  OR STD.Str.EditDistance(pf(f), i) <= EditDistanceAllowed
  OR STD.Str.EditDistance(clean(f), i) <= EditDistanceAllowed
  OR STD.Str.EditDistance(pf(m), i) <= EditDistanceAllowed
  OR STD.Str.EditDistance(clean(m), i) <= EditDistanceAllowed
  OR STD.Str.EditDistance(pf(l), i) <= EditDistanceAllowed
  OR STD.Str.EditDistance(clean(l), i) <= EditDistanceAllowed;

  RETURN ok(pf(up(inName.First))) AND ok(pf(up(inName.Middle))) AND ok(pf(up(inName.Last)));
END;

cnameOK(STRING c) :=
FUNCTION

  //they want company name AKAs and DBAs (better use company name match for company records)
  RETURN inName.CompanyName = '' OR ut.CompanySimilar(clean(c), up(inName.CompanyName)) <= 4;
END;


nameOK(STRING f, STRING m, STRING l, STRING c) :=
FUNCTION

  isCrec := c <> '';

  RETURN IF(isCrec, cnameOK(c), personnameOK(f,m,l));
END;


// ADDRESS WORK

streetOK(STRING pr, STRING pn) :=
FUNCTION
  
  //They say they want street numbers corrected and they want street synonyms to match, like ?Rt 15? should return ?US Highway Route 15?, etc.
  //so i am not quite sure if this implementation satisfies that now

  ok(STRING i, STRING v) :=
  i = ''
  OR STD.Str.EditDistance(i, clean(v)) <= EditDistanceAllowed;

  RETURN ok(up(inAddr.StreetNumber), pr) AND ok(up(inAddr.StreetName), pn);

END;

localOK(STRING z, STRING c, STRING s) :=
FUNCTION

  inputs_used :=
  IF(inAddr.zip5 <> '', 1, 0)
  +IF(inAddr.city <> '', 1, 0)
  +IF(inAddr.state <> '', 1, 0);

  matches_needed := //this is by their specification
  CASE(
    inputs_used,
    0 => 0,
    1 => 1,
    2 => 1,
    3 => 2,
    0
  );

  matches_found :=
  IF(inAddr.zip5 <> '' AND inAddr.zip5 = clean(z), 1, 0)
  +IF(inAddr.city <> '' AND STD.Str.EditDistance(clean(c), up(inAddr.city)) <= EditDistanceAllowed , 1, 0)
  +IF(inAddr.state <> '' AND up(inAddr.state) = clean(s), 1, 0);

  RETURN matches_found >= matches_needed;

END;

addressOK(STRING pr, STRING pn, STRING z, STRING c, STRING s) :=
FUNCTION

RETURN streetOK(pr, pn) AND localOK(z, c, s);

END;


// PROJECT THRU THE FILTER
iesp.rightaddress.t_RightAddressSearchRecord traOK(iesp.rightaddress.t_RightAddressSearchRecord le) :=
TRANSFORM
    addrsMatched := le.addresses(addressOK(streetnumber, streetname, zip5, city, state));
    
    newestAddrMatched := SORT(addrsmatched, -datelastseen.year, -datelastseen.month)[1];
    
    newestAddrMatchedYear := newestAddrMatched.datelastseen.year;
    newestAddrMatchedMonth := newestAddrMatched.datelastseen.month;
    
    addrsNewerThanAddrsMatched :=
    le.addresses(
      newestAddrMatchedYear > 0 AND
      (datelastseen.year > newestAddrMatchedYear OR
       (datelastseen.year = newestAddrMatchedYear AND datelastseen.month > newestAddrMatchedMonth)
      )
    );
    UPS_Services.mac_SortAddresses(addrsNewerThanAddrsMatched + addrsmatched, addrssrtd);

    SELF.names := le.names(nameOK(first,middle,last,companyname)),
    SELF.addresses := addrssrtd;
      
    SELF := le
END;

recs_filtered :=
PROJECT(
  recs(powersearch = ''),
  traOK(LEFT)
)
+ recs(powersearch <> '');

EXPORT results := recs_filtered(EXISTS(names) AND EXISTS(addresses));

END;

