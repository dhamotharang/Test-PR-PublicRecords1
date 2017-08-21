export Mac_SK_Clear(basename, seq_name, numgenerations = '3', clearflag = 'false') := macro
import roxiekeybuild;
roxiekeybuild.Mac_SK_Clear(basename, seq_name, numgenerations, clearflag);
endmacro : deprecated('use roxiekeybuild.Mac_SK_clear instead');