export get_Scalar_Result(string wuid,string pNamedOutput,string pesp = _constants.LocalEsp) := 
    wk_ut_dev.get_WUInfo(wuid,pesp).WUInfo()[1].results(name = pNamedOutput)[1].Value;
