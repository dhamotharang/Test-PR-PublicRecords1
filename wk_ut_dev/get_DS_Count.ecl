export get_DS_Count(string pwuid,string pNamedOutput,string pesp = _constants.LocalEsp) := 
    if(wk_ut_dev.Is_Valid_Wuid(pWuid)  ,wk_ut_dev.get_WUInfo(pwuid,pesp).WUInfo()[1].results(name = pNamedOutput)[1].Total ,0);
