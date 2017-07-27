export MAC_Marshall_Results(infile,outfile,maxLengthIn = 4096) := macro

  #uniquename(incase)
  %incase% := 13;  //makes compiler happy	
  doxie.MAC_Marshall_Results_NoCount(infile,outfile,maxLengthIn, OC)

  OC;
	
endmacro;