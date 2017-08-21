import Matrix_DL, fieldstats, doxie_files, drivers, ut, didville, did_add, fair_isaac, header_slimsort, watchdog;

st := Drivers.File_Dl;

doxie_files.Layout_Drivers addM(st le) :=
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


doxie_build.MAC_MiniDriversBuild(p, paout, true, 'local')

ut.MAC_SF_BuildProcess(p,'~thor_data400::base::DLSearch_'+doxie_build.buildstate,dofirst)

email := fileservices.sendemail('mluber@seisint.com',
						  'DL Stats Available',
						  'DL Build complete on ' + ut.GetDate + '\r\n' +
						  'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');


export Proc_Build_DL_Search_Base := sequential(dofirst);