// WARNING: This is a fairly slow module, it does debug level analysis on ALL your matches
// Should be used sparingly to get the 'last n' of matches out of a system
//---------------------------------------------------------------------------------------------
// NOTE: Uncomment the following line only if the cleave related keys have not been built.
// EXPLAINATION: BWR_Underlinks has a dependency on Cleave. Generally a user would run the internal 
// linking process before analyzing Underlinks, thereby generating the Cleave related keys. If that is 
// not the case, then you need to uncomment the following line to build the Cleave keys.
// BIPV2_LGID3_dev.Cleave(BIPV2_LGID3_dev.In_LGID3).BuildAll;
//---------------------------------------------------------------------------------------------
  Und := BIPV2_LGID3_dev.Underlinks(BIPV2_LGID3_dev.In_LGID3); // Create underlink module
OUTPUT(Und.ForceFails,NAMED('ForceFails'));
