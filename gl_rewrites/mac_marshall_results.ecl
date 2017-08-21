export MAC_Marshall_Results(in_parms,infile,outfile,maxLengthIn = 4096) := macro

  #uniquename(incase)
  %incase% := 13;  //makes compiler happy	
  gl_rewrites.MAC_Marshall_Results_NoCount(in_parms,infile,outfile,maxLengthIn, OC)

  OC;
	
endmacro;