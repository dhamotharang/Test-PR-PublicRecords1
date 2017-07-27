import ut;
export MACF_Sequence_Records(infile,idfield) := 
functionmacro
  #uniquename(outfile)
  ut.MAC_Sequence_Records(infile,idfield,%outfile%);
  return %outfile%;
endmacro;
