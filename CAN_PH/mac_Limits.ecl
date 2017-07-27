export mac_Limits(indxread, outfile) := macro

outfile := doxie.fn_FetchLimitLimitSkipFail(indxread ,10000,ut.limits.FETCH_LEV2_UNKEYED, nofail, 203);						

endmacro;