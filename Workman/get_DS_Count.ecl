import WsWorkunits;
export get_DS_Count(string pwuid,string pNamedOutput,string pesp = _Config.LocalEsp) := 
    if(WorkMan.Is_Valid_Wuid(pWuid)  ,WsWorkunits.Get_Ds_Result_Count(pwuid,pNamedOutput,pesp) ,0);
