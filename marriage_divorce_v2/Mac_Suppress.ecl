export Mac_Suppress(inFile, outFile) := macro

#uniquename(concat)
 %concat% := inFile(~( trim(state_origin) in File_mdv2_lookup.fState and trim(marriage_filing_number) in File_mdv2_lookup.mfilingnbr 
                       and trim(party1_name) in File_mdv2_lookup.fparty));
												
outFile := %concat%	
												
endmacro;												
