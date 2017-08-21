import drivers, doxie_build;
export proc_dl_build_all := sequential(drivers.proc_dl_build_base,drivers.proc_moxie_dl_keybuild,doxie_build.proc_build_dl_search(drivers.Version_Development));