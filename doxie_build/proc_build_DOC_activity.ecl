import ut,doxie_build,corrections;

df := corrections.AllActivities;

ut.MAC_SF_BuildProcess(df,'~thor_data400::base::corrections_activity_' + doxie_build.buildstate,a,2)

export proc_build_DOC_activity := a;
			