import DriversV2, ut, doxie_build, lib_fileservices;

st := CompDL;

DriversV2.Layout_Drivers addM(st le) :=
TRANSFORM
	SELF.record_type := '';
	SELF := le;
END;
p := PROJECT(st, addM(LEFT));


/*fieldstats.mac_stat_file(p,stats,'DLs',50,5,false,
					orig_state,'string','F',
					dl_number,'string','M',
					lic_issue_date,'number','F',
					lname,'string','M',
					prim_name,'string','M')
*/

//DriversV2.MAC_MiniDriversBuild(p, paout, true, 'local')

//ut.MAC_SF_BuildProcess(p,'~thor400_92::base::compdl::DLSearch_'+doxie_build.buildstate, dofirst, 2)

/*email := fileservices.sendemail('giri.rajulapalli@lexisnexis',
						  'DL2 Stats Available',
						  'DL2 Build complete on ' + ut.GetDate + '\r\n' +
						  'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');
*/
//export Proc_Build_DL_Search_Base := sequential(dofirst);

basename := '~thor400_92::base::scankdl::' + filedate + '::DLSearch';
sfname := '~thor400_92::base::scankdl::qa::DLSearch';


export Proc_Build_DL_Search_Base := sequential(
				IF(FileServices.SuperFileExists(sfname),
					FileServices.ClearSuperFile(sfname),
					FileServices.CreateSuperFile(sfname)),
				OUTPUT(p,,basename, overwrite),
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperfile(sfname, basename),
				FileServices.FinishSuperFileTransaction()
			);
