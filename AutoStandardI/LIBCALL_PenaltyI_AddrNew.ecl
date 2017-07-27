// This module created to allow pentalization to occur for Judgements and Liens
// batch service.  This new LIB_PenaltyI_addrNew call get the input values
// directly from passed in arguments instead of using interface translator which
// was calling the address cleaner multiple times causing timeouts for input
// sets which returned large result sets.
// The boolean useinterfacetranslator set to false to bypass the address cleaner calls
// that were happening within the calls when calling interface translator
import AutoStandardI;
export LIBCALL_PenaltyI_AddrNew := module
	export val(AutoStandardI.LIBIN.PenaltyI_Addr.full in_mod) := function
		// return library('AutoStandardI.LIB_PenaltyI_Addr',LIBOUT.PenaltyI_Addr(in_mod)).val;
		return AutoStandardI.LIB_PenaltyI_AddrNew(in_mod).val;
	end;
end;