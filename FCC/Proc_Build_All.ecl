import Orbit_report,Roxiekeybuild, _Control;
export Proc_Build_All(string filedate) := function
orbit_report.FCC_Stats(runorbitreport);

evnts := sequential(
	fcc.Proc_Spray_FCC(filedate),
	fcc.proc_build_base(filedate),
	fcc.Proc_build_keys(filedate),
	fcc.Proc_Build_Autokey(filedate),
	FCC.Proc_Build_boolean_keys(filedate),
	RoxieKeybuild.updateversion('FCCKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B'),
	fcc.Out_Population_Stats.all,
	Output(choosen(sort(fcc.File_FCC_Base(licensee_bdid > 0),-FCC_seq),1000)),
	runorbitreport
): success(sequential(fcc.SendEmail(filedate).RoxieSuccess_email, fcc.SendEmail(filedate).Build_Success)), failure(fcc.SendEmail(filedate).Build_Failure);

return evnts;
end;