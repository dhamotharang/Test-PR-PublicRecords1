IMPORT BIPV2;

EXPORT ManualOverlinks(string theModule='LGID3') := function
	retModule :=if(theModule='LGID3', BIPV2_BlockLink.ManualOverlinksLGID3);
  return retModule;
	end;
