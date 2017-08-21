export MAC_SK_Diff(theindexprep, superkeyname, lkeyname, seq_name, one_node = 'false', diffing = 'false') := macro
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

#if(one_node)
	output('Nothing to diff');
#else	
	#if (diffing)
		seq_name := keydiff(index(theindexprep,superkeyname+'_Prod'),index(theindexprep,lkeyname),%superdiffname%+thorlib.WUID());
	#else
		seq_name := output('Prod superkey is empty, nothing to diff');
	#end
#end

endmacro;