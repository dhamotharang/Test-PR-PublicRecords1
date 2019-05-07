rgxEmail := '^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';

EXPORT DistributionLists := MODULE


		lfn_internal := '~file::bctlpedata12.risk.regn.net::data::temp::ubernac::EmailInternalDistribution.csv';

		rInternal := RECORD
			string			list {MAXLENGTH(16)};
			string			email {MAXLENGTH(255)};
			string			comments {MAXLENGTH(255)};
		END;

		EXPORT dsInternal := dataset(lfn_internal, rInternal, CSV(						
																										SEPARATOR(',')
																									, TERMINATOR(['\n', '\r\n'])
																									, HEADING(1)
																									, MAXLENGTH(1024)
																									)
																						)(REGEXFIND(rgxEmail,email));
		lfn_external := '~file::bctlpedata12.risk.regn.net::data::temp::ubernac::EmailExternalDistribution.csv';
		rExternal := RECORD
			string1			program;
			string2			state;
			string2			groupid;
			string			email {MAXLENGTH(255)};
			string			comments {MAXLENGTH(255)};
		END;
		EXPORT dsExternal := dataset(lfn_external, rExternal, CSV(						
																										SEPARATOR(',')
																									, TERMINATOR(['\n', '\r\n'])
																									, HEADING(1)
																									, MAXLENGTH(1024)
																									)
																						)(REGEXFIND(rgxEmail,email));

		shared rEmail := RECORD
			string	email;
		END;
																			
		shared extractList(DATASET(rEmail) list) := FUNCTION
				rEmail xcat(list L, list R) := TRANSFORM
																	self.email := TRIM(L.email) + ',' + TRIM(R.email);
														END;
				dsList := ROLLUP(list, true, xcat(LEFT, RIGHT));
				return dsList[1].email;
		END;


	export ValidationList := extractList(PROJECT(dsInternal(list='Validation'),rEmail));
	export AlertList := extractList(PROJECT(dsInternal(list='Alert'),rEmail));
	export FailureList := extractList(PROJECT(dsInternal(list='Failure'),rEmail));
	export SuccessList := extractList(PROJECT(dsInternal(list='Success'),rEmail));

	export ProgramList(string1 theProgram, string2 theState, string2 theGroupid='') :=
	   extractList(PROJECT(dsExternal(Program=theProgram, state=theState, groupid=theGroupId),rEmail));
											
END;