import header_services;

export Supplemental_Data := module

  export file(string fname) := module
		export fullName := '~file::' + header_services.ProductionLZ.IP_Loc + '::' + header_services.ProductionLZ.Directory_Loc + fname;
		export loc := nothor(
			FileServices.RemoteDirectory(
				header_services.ProductionLZ.IP_Loc,
				header_services.ProductionLZ.Directory_Loc
			)(name = fname));
		export size := loc[1].size;
		export name := loc[1].name;
	end; // file
	
	shared emailAddr										:= header_services.ProductionLZ.notification_email;
	shared emailInfo := '\r\n Job Name: ' + thorlib.jobname() + ' \r\n User Name: ' + thorlib.jobowner() + ' \r\n Cluster: ' + thorlib.cluster();
	export emailMsg(string msg)					:= FileServices.sendemail(emailAddr, 'Upload from Drop Zone Status ' + Thorlib.WUID(), msg + emailInfo);

	export full_file_name(string fname)	:= '~file::' + header_services.ProductionLZ.IP_Loc + '::'+header_services.ProductionLZ.Directory_Loc + fname;
	export file_name_loc(string fname)	:= nothor(
		FileServices.RemoteDirectory(
			header_services.ProductionLZ.IP_Loc,
			header_services.ProductionLZ.Directory_Loc
		)(name = fname));
	export file_size(string fname) := file_name_loc(fname)[1].size;
	export file_name(string fname) := file_name_loc(fname)[1].name;

	export should_fail := true : stored('fail_switch');

	export check_found(string fname) := function
		file_exists					:= file_name(fname) <> '';
		file_not_found_msg	:= 'supplemental data file ' + full_file_name(fname) + ' not found';
		file_not_found := if(
			should_fail,
			sequential(emailMsg(file_not_found_msg), fail(file_not_found_msg)),
			emailMsg(file_not_found_msg)
		);

		if(not file_exists, file_not_found);
		return file_exists;
	end;
	
	export check_size(string fname, unsigned record_length) := function
			file_size_good		:= ((file_size(fname) % record_length) = 0) and (file_size(fname) <> 0);
			size_failure_msg	:= 'unexpected supplemental data file size/record length: ' + file_size(fname) + ', expected record length: ' +  record_length + ' for '+ full_file_name(fname);
			size_failure			:= if(
				should_fail,
				sequential(emailMsg(size_failure_msg), fail(size_failure_msg)),
				emailMsg(size_failure_msg)
			);
			if(not file_size_good, size_failure);
			return file_size_good;
	end;
	
	export clusterSet := [ 'thor_data50',
	                       '400way'
	                     ];

	export mac_verify(file,layout,attr) := macro
		#uniquename(SD)
		%SD% := header_services.Supplemental_Data;

		dataset(layout) attr() := function
		  isFound           := %SD%.check_found(File);
			
		  full_file_path    := %SD%.full_file_name(File);
			record_length			:= sizeof(Layout);

			isSizeGood        := %SD%.check_size(File,record_length);

			success_msg       := 'successfully read supplemental data file ' + full_file_path;
			success_email     := %SD%.emailMsg(success_msg);
			
			goodCluster := (not Thorlib.Cluster() in %SD%.clusterSet);

			if(isFound, if(isSizeGood /*and goodCluster*/, success_email));
			
			return if( isFound and isSizeGood /*and goodCluster*/, dataset(full_file_path,layout,flat,opt), dataset([],layout) );
		end;
	endmacro;

	export layout_in := record
		string32 hval_s;
		string2  nl;
	end;

	export layout_out := record
		data16 hval;
	end;

	export layout_out in_to_out(layout_in l) := transform
		self.hval := stringlib.string2data(l.hval_s);
	end; 

	//your_supp_ds := project(in_ds, in_to_out(left));


end; //module
