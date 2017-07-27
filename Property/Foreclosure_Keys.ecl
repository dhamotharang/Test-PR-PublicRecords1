import Property, ut, roxiekeybuild,Orbit_report;

export Foreclosure_Keys(string filedate) :=
function
	#option ('newWorkflow', true)
	#workunit('name','Foreclosure Build - ' + filedate);
	
	ut.MAC_SF_BuildProcess(property.Foreclosure_Clean_AID,'~thor_data400::in::foreclosure',build_clean);
	ut.MAC_SF_BuildProcess(property.Foreclosure_DID,'~thor_data400::base::foreclosure',build_base);
	Orbit_report.Foreclosures_Stats(getretval);
	return sequential(build_clean,
										build_base,
										property.coverage_foreclosure,
										property.Out_Moxie_Foreclosure_Keys,
										Property.proc_build_forclosure_key(filedate),
										Property.proc_build_nod_key(filedate),
										RoxieKeyBuild.updateversion('ForeclosureKeys', filedate, 'gwitz@seisint.com;kgummadi@seisint.com'),
										/* Property.DKC_Foreclosure_Keys, ---Depricated */
										Property.Foreclosure_Stats_Metadata,
										property.Out_Base_Dev_Stats(filedate),
										getretval
										);
end;