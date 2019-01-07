/* ******************************************************
Get full counts from each of the keys Kevin sent us to study
****************************************************** */
// Bankruptcy  -- bankruptcies_v3_children
DSBK := COUNT(BankruptcyV3.key_bankruptcyV3_did(true));
output(DSBK,NAMED('BKRUPCY'));

// Concealed Weapons -- concealed_weapon_licenses_children
DSCCW := COUNT(doxie_files.key_ccw_did(true));
output(DSCCW,NAMED('CCW'));

// Hunting Fishing -- hunting_licenses_children
DSHF := COUNT(doxie_files.key_hunters_did(true));
output(DSHF,NAMED('HUNTERS'));

// Criminal Offenses  -- DOC2_children
// the heading you provided may refer to more sections, incl sexOffenders -- if so, we can dig deeper
DSCO := COUNT(doxie_files.Key_Offenders(true));
output(DSCO,NAMED('CRIMINAL'));

// Liens and Judgments -- liens_judgements_v2_children
DSLJ := COUNT(liensv2.key_liens_did_fcra);
output(DSLJ,NAMED('LIENS'));


// Professional Licenses -- professional_licenses_children
DSPF := COUNT(prof_licenseV2.key_proflic_did(true));
output(DSPF,NAMED('PROF_LIC'));

// UCC Filings -- uccv2_children
DSUCC := COUNT(uccv2.key_did_w_Type(true));
output(DSUCC,NAMED('UCC'));

// FAA Aircraft 
  // pilot_licenses_children 
	// pilot_certificates_children
	DSAIRMN := COUNT(faa.key_airmen_did(true));
	output(DSAIRMN,NAMED('AIRMEN'));

  // pilot_aircraft_children    
	DSAIRCR := COUNT(faa.key_aircraft_did(true));
	output(DSAIRCR,NAMED('AIRCRAFT'));

// Property -- propertyV2_children
DSPROP := COUNT(LN_PropertyV2.key_ownership_did(true));
output(DSPROP,NAMED('LNPROP'));

// Watercraft -- 
DSWATR := COUNT(watercraft.key_watercraft_did(true));
Output(DSWATR,NAMED('WATER'));