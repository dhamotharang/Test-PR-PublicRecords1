import ut,doxie_build,corrections;

df := corrections.allpunishments;

ut.MAC_SF_BuildProcess(df,'~thor_data400::base::corrections_punishment_' + doxie_build.buildstate,aout,2)

export proc_build_DOC_punishment := aout;