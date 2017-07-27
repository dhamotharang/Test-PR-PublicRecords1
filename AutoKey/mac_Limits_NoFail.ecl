export mac_Limits_NoFail(indxread, outfile, doSkip = true) := macro
import ut;

doxie.mac_FetchLimitLimitSkipFail(
	indxread,
	10000,
	ut.limits.FETCH_LEV2_UNKEYED,
	doSkip,
	203,
	false,
	true,			//previously, this had the same behavior (via the fn) except that we are now seeing DoReturnMessage
	outfile)				

endmacro;