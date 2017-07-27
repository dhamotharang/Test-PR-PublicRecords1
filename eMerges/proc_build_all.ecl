#workunit ('name', 'Emerges build ' + emerges.version);
a := emerges.proc_build_base;
b := emerges.proc_build_key;

export proc_build_all := sequential(a,b);
