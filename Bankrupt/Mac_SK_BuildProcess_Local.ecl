export MAC_SK_BuildProcess_Local(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
/*
theindexprep is the index to be written to disk
Keyname is 'key::xxxx' (to be added to WUID for unique key name)
SuperKeyname is 'key::xxxx' (superfile name)
seq_name is the sequential output name
numgenerations is currently to be just 2, 3 or 4
*/
#uniquename(ng)
%ng% := (integer)numgenerations;


seq_name := if(%ng% not in [2,3,4], 
			fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3,4]'),
			#if (one_node)
				buildindex(theindexprep,keyname,overwrite,few)
			#else 
				buildindex(theindexprep,keyname,overwrite)
			#end
			);
endmacro;