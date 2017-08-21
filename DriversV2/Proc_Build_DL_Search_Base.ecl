import doxie_build, Matrix_DL, ut, fieldstats, doxie_files, drivers, didville, did_add, fair_isaac, header_slimsort, watchdog, PromoteSupers, std;

st := distribute(DriversV2.File_DL_Extended,hash(dl_seq)) : persist('~thor_data400::persist::Dl2::Drvlic');


DriversV2.Layout_Drivers_Extended addM(st le) :=
TRANSFORM
	SELF.record_type := '';
	SELF := le;
END;
p := PROJECT(st, addM(LEFT));

fieldstats.mac_stat_file(p,stats,'DLs',50,5,false,
					orig_state,'string','F',
					dl_number,'string','M',
					lic_issue_date,'number','F',
					lname,'string','M',
					prim_name,'string','M')


DriversV2.MAC_MiniDriversBuild(p, paout, true, 'local');

ConvertToSearchLayout	:=	project(p, TRANSFORM(DriversV2.Layout_Drivers,SELF := LEFT;));

PromoteSupers.MAC_SF_BuildProcess(p,'~thor_data400::base::DL2::DLSearchPlus_'+doxie_build.buildstate,dofirst)

PromoteSupers.MAC_SF_BuildProcess(ConvertToSearchLayout,'~thor_data400::base::DL2::DLSearch_'+doxie_build.buildstate,dosecond)

email := fileservices.sendemail('giri.rajulapalli@lexisnexis',
						  'DL2 Stats Available',
						  'DL2 Build complete on ' + (STRING8)Std.Date.Today() + '\r\n' +
						  'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');


export Proc_Build_DL_Search_Base := sequential(dofirst,
																							 dosecond);