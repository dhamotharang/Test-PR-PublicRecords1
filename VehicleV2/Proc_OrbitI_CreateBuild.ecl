import orbit,_Control,Orbit3Insurance;
export Proc_OrbitI_CreateBuild(string pdate,string envment = 'nonfcra') := function

string pEnv := if ( envment = 'nonfcra' , 'N','F' );



create_build :=  Orbit3Insurance.Proc_Orbit3I_CreateBuild (VehicleV2.orbitIConstants(envment).masterbuildname, pdate,pEnv,'Charles.Pettola@lexisnexisrisk.com' ) ;

return create_build;

end;