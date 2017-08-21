export MAC_SK_BuildProcess(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
import roxiekeybuild;
roxiekeybuild.Mac_SK_BuildProcess(theindexprep, keyname, superkeyname, seq_name, numgenerations, one_node);
endmacro : deprecated('use roxiekeybuild.Mac_SK_BuildProcess instead');