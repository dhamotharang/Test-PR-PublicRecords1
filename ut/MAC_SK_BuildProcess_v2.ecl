export MAC_SK_BuildProcess_v2(theindexprep, superkeyname, seq_name, one_node = 'false', diffing = 'false') := macro
import roxiekeybuild;
roxiekeybuild.Mac_SK_BuildProcess_v2(theindexprep, superkeyname, seq_name, one_node, diffing);
endmacro : deprecated('use roxiekeybuild.Mac_SK_BuildProcess_v2 instead');
