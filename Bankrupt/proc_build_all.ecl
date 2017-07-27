a := bankrupt.BWR_DID_SearchFile;

b := bankrupt.proc_build_key;


export proc_build_all := sequential(a,b);