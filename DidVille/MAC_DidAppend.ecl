export MAC_DidAppend(infile,outfile,deduped,do_fuzzy,all_scores = 'false',LMaxScores = 'didville.MaxScores.MMax',soap_xadl_version_value='0',verify_value='\'\'',inLimit = 1) := macro

#uniquename(outxLink)
didville.MAC_DidAppend_xLink(infile,%outxLink%,deduped,do_fuzzy,all_scores,LMaxScores,verify_value,inLimit)
outfile := %outxLink%;

endmacro;


