export MAC_Patch_Id(infile,patch_Field,patchfile,left_field,right_field,outfile) := macro
#uniquename(MPI)
	%MPI% := 5; // Simply forces macro to behave as such
//****** Call MAC_Append_Id to clean the infile based on patchfile
//		 It replaces the old IDs with new IDs
	ut.MAC_Append_Id(infile,patch_field,patch_field,patchfile,left_field,right_field,outfile)
    endmacro;
