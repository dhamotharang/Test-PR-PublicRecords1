import WorldCheck,WorldCheckServices;

#OPTION('multiplePersistInstances',FALSE);

export Proc_Build_WC(string filedate) := function

dofirst  := proc_build_WC_Base(filedate);
dosecond := WorldCheckServices.WorldCheckBuild(filedate);
dothird  := proc_build_WorldCheck_Keys(filedate);

return sequential(dofirst
                  ,dosecond,dothird);

end;