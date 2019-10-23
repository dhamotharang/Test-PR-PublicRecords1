import orbit,_Control,Orbit3Insurance;
export Proc_OrbitI_CreateBuild(string pdate,string envment = 'N|B|F') := function




create_build :=  Orbit3Insurance.Proc_Orbit3I_CreateBuild (Codes.OrbitIConstants.masterbuildname, pdate,envment,'Darren.Knowles@lexisnexisrisk.com' ) ;

return create_build;

end;