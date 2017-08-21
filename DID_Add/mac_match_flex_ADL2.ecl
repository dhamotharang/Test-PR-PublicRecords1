export Mac_match_flex_ADL2(infile, outfile) := macro

import PersonLinkingADL2V3;

//****** Call xADL2 macro
#uniquename(outfile_adl2_raw)	
																					
PersonLinkingADL2V3.MAC_MEOW_xADL2_Batch(
        infile, uniqueid, name_suffix, fname, mname, lname,
				prim_range, prim_name, sec_range, city, state, zip, zip4, ,
				ssn5, ssn4, dob, phone, , , , , , %outfile_adl2_raw%,false);

//****** Dedup the matches
#uniquename(outfile_adl2_grp)	
											 
%outfile_adl2_grp% := sort(distribute(%outfile_adl2_raw%, hash(reference)), reference, -score, did, local);
outfile := dedup(%outfile_adl2_grp%,reference, local);
					
endmacro;
