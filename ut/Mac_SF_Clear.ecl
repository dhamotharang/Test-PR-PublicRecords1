export Mac_SF_Clear(basename, seq_name, numgenerations = '3') := macro
import promotesupers;
promotesupers.Mac_SF_clear(basename, seq_name, numgenerations);
endmacro : deprecated('used promotesupers.Mac_SF_Clear instead');