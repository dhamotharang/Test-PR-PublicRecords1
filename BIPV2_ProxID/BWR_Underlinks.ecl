// WARNING: This is a fairly slow module, it does debug level analysis on ALL your matches
// Should be used sparingly to get the 'last n' of matches out of a system
  Und := BIPV2_ProxID.Underlinks(BIPV2_ProxID.In_DOT_Base); // Create underlink module
OUTPUT(Und.ForceFails,NAMED('ForceFails'));
