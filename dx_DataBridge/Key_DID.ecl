IMPORT $;

inFile := $.Layout_Keybase;

EXPORT Key_DID := INDEX({infile.did}, {infile - did}, $.Names().DID.QA);
