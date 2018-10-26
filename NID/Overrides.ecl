
layout_Override := RECORD
			string1					nametype;
			string75				name := '';
			string20				fname := '';
			string20				mname := '';
			string20				lname := '';
			string15				suffix := '';
			string5					cln_title := '';
			string20				cln_fname := '';
			string20				cln_mname := '';
			string20				cln_lname := '';
			string5					cln_suffix := '';
			string5					cln_title2 := '';
			string20				cln_fname2 := '';
			string20				cln_mname2 := '';
			string20				cln_lname2 := '';
			string5					cln_suffix2 := '';
END;

OverrideData := DATASET([
	{'P','LOIS-MARGARET DOMINIQUE, RN','','','','','MS','LOIS-MARGARET','','DOMINIQUE'},
	{'P','LOIS-MARGARET DOMINIQUE','','','','','MS','LOIS-MARGARET','','DOMINIQUE'},
	{'P','','LOIS-MARGARET','','DOMINIQUE','','MS','LOIS-MARGARET','','DOMINIQUE'},
	{'P','','CRYSTAL','','BALL','','MS','CRYSTAL','','BALL'},
	{'B','VIRGINIA EASLEY JOHNSON PA','','','','','','','',''},
	// from death master
   {'P','SU IN LEI', 'SU', 'IN', 'LEI', '', '', 'SU', 'IN', 'LEI'},
	 //
   {'B','Terra Firma'},
   {'B','TERRA FIRMA'},
   {'P','CEDILLOS, JOSE FELIX DEL CID', '', '', '', '', 'MR', 'JOSE', 'FELIX DEL CID', 'CEDILLOS'},
   {'P','ALEXANDER WILDERNESS, SR','', '', '', '', 'MR', 'ALEXANDER', '', 'WILDERNESS', 'SR'},
   {'P','ALEXANDER WILDERNESS','', '', '', '', 'MR', 'ALEXANDER', '', 'WILDERNESS', ''}
	], layout_Override);

EXPORT Overrides(boolean fullname=true) := DISTRIBUTE(PROJECT(OverrideData, TRANSFORM(Layout_Repository,
											SELF.nid := IF(fullname,
																		IF(left.name='', SKIP,
																			Common.fGetNid(left.name)),
																	IF(left.name='',
																			Common.fGetNIDParsed(left.fname,left.mname,left.lname,left.suffix),
																			Common.fGetNid(left.name)));
											self.name := IF(left.name<>'', left.name,
																	Nid.ReconstructName(left.fname,left.mname,left.lname, left.suffix));
											self := LEFT;
											self.derivation := 98;		// overridden name for sorting
											self := [])), nid) : GLOBAL(FEW);
