export MAC_SK_BuildProcess_v2_local(theindexprep, superkeyname, lkeyname, seq_name, one_node = 'false', diffing = 'false') := macro
/*
theindexprep is the index to be written to disk
SuperKeyname is 'key::xxxx' (superfile name)
seq_name is the sequential output name
numgenerations is currently to be just 2, 3 or 4
*/

#uniquename(todelete)
%todelete% := superkeyname + '_Built';

#uniquename(superdiffname)
%superdiffname% := superkeyname+'_diff';


seq_name := 
	    #if (one_node)
			buildindex(theindexprep,lkeyname,overwrite,few)
		#else 
			#if(~diffing)
				buildindex(theindexprep,lkeyname,overwrite)
			#else
				buildindex(theindexprep,lkeyname,DISTRIBUTE(index(theindexprep,superkeyname+'_Prod')),overwrite)
			#end
		#end			
endmacro;