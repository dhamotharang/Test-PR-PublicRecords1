import doxie;
rec := doxie.layout_references;

export fn_FetchLimitLimitSkipFail(
	dataset(rec) indxread,
	unsigned8 limit_inner,
	unsigned8 limit_outer,
	boolean doSkip /*else fail*/,
	unsigned4 errorCode,
	boolean doChoosen = false) :=
FUNCTION

doxie.mac_FetchLimitLimitSkipFail(
	indxread,
	limit_inner,
	limit_outer,
	doSkip,
	errorCode,
	doChoosen,
	false,						//this option not valid when layout_references is the layout...no room for message
	outfile)
	
return project(outfile, rec);

END;