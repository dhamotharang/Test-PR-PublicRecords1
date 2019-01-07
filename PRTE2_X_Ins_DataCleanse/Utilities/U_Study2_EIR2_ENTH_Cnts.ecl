/* ******************************************************
Use ENTH and pull what we think is right then compare the 
numbers to make sure we have the right parameter in the ENTH
****************************************************** */

#workunit('name', 'EIR Study Counts');

// Bankruptcy  -- bankruptcies_v3_children
DSBK := BankruptcyV3.key_bankruptcyV3_did(true);
CTBK := COUNT(ENTH(DSBK,1,100000));
output(CTBK,NAMED('BKRUPCY'));

// Concealed Weapons -- concealed_weapon_licenses_children
DSCCW := doxie_files.key_ccw_did(true);
CTCCW := COUNT(ENTH(DSCCW,1,10000));
output(CTCCW,NAMED('CCW'));

// Hunting Fishing -- hunting_licenses_children
DSHF := doxie_files.key_hunters_did(true);
CTHF := COUNT(ENTH(DSHF,1,1000000));
output(CTHF,NAMED('HUNTERS'));

// Criminal Offenses  -- DOC2_children
// the heading you provided may refer to more sections, incl sexOffenders -- if so, we can dig deeper
DSCO := doxie_files.Key_Offenders(true);
CTCO := COUNT(ENTH(DSCO,1,1000000));
output(CTCO,NAMED('CRIMINAL'));

// Liens and Judgments -- liens_judgements_v2_children
DSLJ := liensv2.key_liens_did_fcra;
CTLJ := COUNT(ENTH(DSLJ,1,1000000));
output(CTLJ,NAMED('LIENS'));


// Professional Licenses -- professional_licenses_children
DSPF := prof_licenseV2.key_proflic_did(true);
CTPF := COUNT(ENTH(DSPF,1,1000000));
output(CTPF,NAMED('PROF_LIC'));

// UCC Filings -- uccv2_children
DSUCC := uccv2.key_did_w_Type(true);
CTUCC := COUNT(ENTH(DSUCC,1,1000000));
output(CTUCC,NAMED('UCC'));

// FAA Aircraft 
  // pilot_licenses_children 
	// pilot_certificates_children
	DSAIRMN := faa.key_airmen_did(true);
	CTAMN := COUNT(ENTH(DSAIRMN,1,100000));
	output(CTAMN,NAMED('AIRMEN'));

  // pilot_aircraft_children    
	DSAIRCR := faa.key_aircraft_did(true);
	CTACF := COUNT(ENTH(DSAIRCR,1,10000));
	output(CTACF,NAMED('AIRCRAFT'));

// Property -- propertyV2_children
DSPROP := LN_PropertyV2.key_ownership_did(true);
CTPROP := COUNT(ENTH(DSPROP,1,1000000));
output(CTPROP,NAMED('LNPROP'));

// Watercraft -- 
DSWATR := watercraft.key_watercraft_did(true);
CTWTR := COUNT(ENTH(DSWATR,1,100000));
Output(CTWTR,NAMED('WATER'));