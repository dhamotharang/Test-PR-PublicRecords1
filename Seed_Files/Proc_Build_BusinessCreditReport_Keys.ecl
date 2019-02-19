IMPORT RoxiekeyBuild;

EXPORT Proc_Build_BusinessCreditReport_Keys(STRING filedate) := MODULE

	SHARED mac_build_key(filedate, key, keyname) := FUNCTIONMACRO
	
		flfile := '~thor_data400::key::testseed::'+filedate+'::businesscreditreport::'+keyname;
		fsfile := '~thor_data400::key::testseed::@version@::businesscreditreport::'+keyname;
		// flfile := '~thor_data400::key::testseed::'+filedate+'::businesscreditreport_'+keyname;
		// fsfile := '~thor_data400::key::testseed::@version@::businesscreditreport_'+keyname;
		RoxiekeyBuild.Mac_SK_Buildprocess_V2_Local(Seed_Files.BusinessCreditReport_keys.#EXPAND(key),fsfile,flfile,a1);
 		RoxiekeyBuild.Mac_SK_Move_to_Built_v2(fsfile,flfile,a2);
		RoxiekeyBuild.MAC_SK_Move(fsfile,'Q',a3);
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.FileExists(fsfile),FileServices.CreateSuperFile(fsfile)),
							FileServices.FinishSuperFileTransaction(),
							a1,
							a2,
							a3);

	ENDMACRO;

	EXPORT allkeys := FUNCTION
		RETURN SEQUENTIAL(
			mac_build_key(filedate, 'InputEcho', 'InputEcho'),
			mac_build_key(filedate, 'BestInfo', 'BestInfo'),
			mac_build_key(filedate, 'Scoring', 'Scoring'),
			mac_build_key(filedate, 'Summary', 'Summary'),
			mac_build_key(filedate, 'OwnGuartor', 'OwnGuartor'),
			mac_build_key(filedate, 'TopBusBankr', 'Bankruptcy'),
			mac_build_key(filedate, 'TopBusLiens', 'TopBusLiens'),
			mac_build_key(filedate, 'TopBusUCC', 'TopBusUCC'),
			mac_build_key(filedate, 'TopBusProp', 'TopBusProp'),
			mac_build_key(filedate, 'TopBusMV', 'TopBusmvehicle'),
			mac_build_key(filedate, 'TopBusWCraft', 'TopBusWCraft'),
			mac_build_key(filedate, 'TopBusACraft', 'TopBusACraft'),
			mac_build_key(filedate, 'TopBusLic', 'TopBusLicense'),
			mac_build_key(filedate, 'TopBusIncorp', 'TopBusIncorp'),
			mac_build_key(filedate, 'TopBusOperSites', 'TopBusOper'),
			mac_build_key(filedate, 'TopBusParent', 'TopBusParent'),
			mac_build_key(filedate, 'TopBusConnected', 'TopBusConnect'),
			mac_build_key(filedate, 'TopBusContacts', 'TopBusContact'),
			mac_build_key(filedate, 'FinalSect', 'TopBusActivity'),
			mac_build_key(filedate, 'MatchInfo', 'MatchInfo')
			);
	END;

	SHARED mac_build_prte_key(filedate, keyname, section) := FUNCTIONMACRO

		flfile := '~prte::key::testseed::'+filedate+'::businesscreditreport::'+keyname;;
		seed := Seed_Files.BusinessCreditReports_files.#EXPAND(section);
		newrec := record
			data16 hashvalue := (data16) 0;
			seed;
		end;
		newtable := dataset([], newrec);
		k_prte_key := index(newtable,{dataset_name,hashvalue}, {newtable}, flfile);
		RETURN	BUILD(k_prte_key, update);
	ENDMACRO;
	
	EXPORT prtekeys := FUNCTION
		RETURN SEQUENTIAL(
			mac_build_prte_key(filedate, 'InputEcho', 'Section1'),
			mac_build_prte_key(filedate, 'BestInfo', 'Section2'),
			mac_build_prte_key(filedate, 'Scoring', 'Section3'),
			mac_build_prte_key(filedate, 'Summary', 'Section4'),
			mac_build_prte_key(filedate, 'OwnGuartor', 'Section5'),
			mac_build_prte_key(filedate, 'Bankruptcy', 'Section6'),
			mac_build_prte_key(filedate, 'TopBusLiens', 'Section7'),
			mac_build_prte_key(filedate, 'TopBusUCC', 'Section8'),
			mac_build_prte_key(filedate, 'TopBusProp', 'Section9'),
			mac_build_prte_key(filedate, 'TopBusmvehicle', 'Section10'),
			mac_build_prte_key(filedate, 'TopBusWCraft', 'Section11'),
			mac_build_prte_key(filedate, 'TopBusACraft', 'Section12'),
			mac_build_prte_key(filedate, 'TopBusLicense', 'Section13'),
			mac_build_prte_key(filedate, 'TopBusIncorp', 'Section14'),
			mac_build_prte_key(filedate, 'TopBusOper', 'Section15'),
			mac_build_prte_key(filedate, 'TopBusParent', 'Section16'),
			mac_build_prte_key(filedate, 'TopBusConnect', 'Section17'),
			mac_build_prte_key(filedate, 'TopBusContact', 'Section18'),
			mac_build_prte_key(filedate, 'TopBusActivity', 'Section19'),
			mac_build_prte_key(filedate, 'MatchInfo', 'Section20')  
			
			);
	END;

	// SHARED mac_compare(keyname, section) := FUNCTIONMACRO

		// seed := Seed_Files.BusinessCreditReports_files.#EXPAND(section);
		// newrec := record
			// data16 hashvalue;   
			// recordof(seed);
		// end;
		// d1 := dataset([],newrec);
		// laure :=index(d1,
									// {dataset_name,hashvalue},
									// {newrec-[dataset_name,hashvalue]}, 
									// '~lauref::key::businesscreditreport::'+keyname);
		// cathy := index(d1,
									// {dataset_name,hashvalue},
									// {newrec-[dataset_name,hashvalue]}, 
									// '~thor_data400::key::businesscreditreport_testseed::'+keyname+'_qa');
		// outrec := record
			// string200 diff1;
			// string100 diff2;
			// newrec;
		// end;
		// outrec tDiff(laure L, cathy R) := TRANSFORM
			// SELF.diff1	:=	ROWDIFF(L,R);
			// SELF.diff2	:=	ROWDIFF(L, R, COUNT);
			// SELF				:=	L;
		// END;

		// rowDiffResult	:=	JOIN(laure,cathy,left.hashvalue=right.hashvalue,tDiff(left,right)); 
		// RETURN output(rowDiffResult,,named(keyname));

	// ENDMACRO;	
END;