import ut, _Control, dops;
EXPORT Constants := module

	export yogurt(string superfilename = '') := module
		//export startdate := '';
		export enddate := ut.getdate;// : independent;
		export l_time := ut.gettime();// : independent;
		//export startwu := 'W' + startdate + '-' + l_time;
		export endwu := 'W' + enddate + '-' + l_time;
		export startwudaysbehind := 'W' + ut.date_math(enddate,-20) + '-' + l_time;
		export serv := 'server=http://10.173.26.7:8010 ';
		export nsplit := ' nosplit=1 ';
		export dstcluster := 'dstcluster=thor40_25_yogurt ';
		export over := 'overwrite=1 ';
		export repl := 'replicate=1 ';
		export action := 'action=copy ';
		export wrap := 'wrap=1 ';
		export transferbuffersize := 'transferbuffersize=100000 ';
		export connect := 'connect=200 ';
		export filename := fileservices.GetSuperFileSubName(superfilename,1);
		export srcname := 'srcname=~'+filename + ' ';
		export dstname := 'dstname=~'+filename + ' ';
		export srcdali := 'srcdali=prod_dali.br.seisint.com '; // changing dali ip to dns
		export copyfilecmd := serv + over + repl + action + dstcluster + dstname + srcname + nsplit + wrap + srcdali + transferbuffersize;
		export emailerrors := 'bocaroxiepackageteam@lexisnexis.com';
		export senderemail := 'charlene.ros@lexisnexis.com';
		export no_of_files_to_keep := if ( superfilename <> '',thorbackup.SetDeleteFileCount(superfile = superfilename)[1].filecnt,2);
		export destip := 'databuilddev01.risk.regn.net';
		export destlocation := '/u/thor/filestodelete';
	end;
	
	export esp := module
		export bocaprodthor := 'prod_esp.br.seisint.com';
		export yogurtthorforboca := '10.173.26.7';
	end;
	// Set this value to get files older than n days
	export getthreshold(integer noofdays = 0) := module
		export integer ndays := if (noofdays > 0, noofdays, 10); 
	end;
	// number of files to pass through one soapcall
	export getnooffiles(integer nooffiles = 0) := module 
		export integer nfiles := if (nooffiles > 0, nooffiles, 500);
	end;
	
	export deletethresholdsize := 100000000000;

	export adminemailsfordeletion := 'joseph.lezcano@lexisnexis.com, valerie.minnis@lexisnexis.com, Anantha.Venkatachalam@lexisnexis.com, Charlene.Ros@lexisnexis.com';

	export allowedclusters(string environment) := module
		export clusterset := if (dops.constants.ThorEnvironment = 'prod'
														,map(
															environment = 'yogurt-thor' => ['thor40_31_yogurt'],
															environment = 'boca-prod-thor' => ['thor400_30','thor400_20','thor400_60','thor400_44','thor400_66','thor400_36'],
															['NA'])
														,map(
															environment = 'boca-dev-thor' => ['thor400_dev','thor400_sta','thor50_dev','thor50_dev02'],
															['NA'])
														);
														
	end;
	
	export FullList(string envname) := sort(Fileservices.LogicalFileSuperSubList()(~(regexfind('::$',supername))), subname);// : persist('~thor::backup::persist::'+envname);
	
end;