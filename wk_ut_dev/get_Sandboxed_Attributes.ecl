import std;
EXPORT get_Sandboxed_Attributes(string pWuid,string pesp = _constants.LocalEsp) :=
//project(STD.System.Workunit.WorkunitMessages(pWuid)(regexfind('Definition is sandboxed',message,nocase)),transform({string attribute},self.attribute := left.location));
sort(wk_ut_dev.get_WUInfo(pWuid,pesp).dnormECLException(regexfind('Definition is sandboxed',message,nocase)),FileName);
