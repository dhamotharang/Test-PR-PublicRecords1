export proc_build_allsources_base(string filedate) := function

import LiensV2,	LiensV2_preprocess, Bankruptcyv2, ut, PromoteSupers;

liensv2.Layout_liens_main_module.layout_liens_main forkey(LiensV2.layout_liens_main_module_for_hogan.layout_liens_main l) :=
TRANSFORM
	//	Clear release_date for Hogan records with filing_type_desc=CORRECTED FEDERAL TAX LIEN
	SELF.release_date	:=	IF(
													l.filing_type_desc	=	LiensV2_preprocess.Code_lkps.HG_FileType('CF')	AND
													l.rmsid[1..3]	=	'HGR',
													'',l.release_date
												);
	SELF							:=	l;
END;

HOGAN_main := project(LiensV2.file_Hogan_main, forkey(left));

pre_file_liens_main := HOGAN_main(tmsid not in Liensv2.Suppress_TMSID())
                        + LiensV2.file_ILFDLN_main(tmsid not in Liensv2.Suppress_TMSID())
						+ LiensV2.file_NYC_main(tmsid not in Liensv2.Suppress_TMSID())
						+ LiensV2.file_NYFDLN_main(tmsid not in Liensv2.Suppress_TMSID())
						+ LiensV2.file_SA_main(tmsid not in Liensv2.Suppress_TMSID())
						+ LiensV2.file_chicago_law_main(tmsid not in Liensv2.Suppress_TMSID())
						+ LiensV2.file_CA_federal_main(tmsid not in Liensv2.Suppress_TMSID())
						+ LiensV2.file_Superior_main(tmsid not in Liensv2.Suppress_TMSID())
                        + LiensV2.file_MA_main(tmsid not in Liensv2.Suppress_TMSID());

main := project(pre_file_liens_main, 
						//transform(liensv2.Layout_liens_main_module.layout_liens_main, 
						transform(liensv2.layout_base_allsources_main.rec, 
						self.orig_filing_date := if(left.orig_filing_date <= stringlib.GetDateYYYYMMDD(),left.orig_filing_date, ''),
						self := left))(NOT regexfind('CAALAC1',tmsid));			

PromoteSupers.MAC_SF_BuildProcess(main,
											'~thor_data400::base::liensv2::main::all_sources',
											bld_all_main,
											2,
											false,
											true,
											filedate);
											
/*Bankruptcyv2.MAC_SF_BuildProcess(main,
                       '~thor_data400::base::liensv2::main::all_sources',filedate,bld_all_main, 2,false,true,true);*/


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//build "All Sources Combined" party
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags refHGPTY(LiensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags l) :=
TRANSFORM
	//	Clear Date_Last_Seen for Hogan records with filing_type_desc=CORRECTED FEDERAL TAX LIEN
	dHoganMain	:=	LiensV2.file_Hogan_main;
	dCFRecords	:=	dHoganMain(
										filing_type_desc	=	LiensV2_preprocess.Code_lkps.HG_FileType('CF')	AND
										rmsid[1..3]	=	'HGR'
									);
	Set_tmsid		:=	SET(dCFRecords,dCFRecords.tmsid);
	Set_rmsid		:=	SET(dCFRecords,dCFRecords.rmsid);
	
	SELF.Date_Last_Seen	:=	IF(
														l.tmsid	IN Set_tmsid	AND
														l.rmsid	IN Set_rmsid,
														'',l.Date_Last_Seen
													);
	SELF				:=	l;
END;

Hogan_party := project(LiensV2.file_Hogan_party, refHGPTY(left));


pre_file_liens_party := Hogan_party((cname <> ''or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
                        + LiensV2.file_ILFDLN_party((cname <> '' or lname <> '' or fname <> '' or mname <> '')and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_NYC_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_NYFDLN_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_SA_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_chicago_law_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_CA_federal_party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_Superior_Party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
						+ LiensV2.file_MA_Party((cname <> '' or lname <> '' or fname <> '' or mname <> '') and tmsid not in Liensv2.Suppress_TMSID() and NOT regexfind('CAALAC1',tmsid))
;

//Bugzilla #67215 - Populate 'Date_First_Seen'
mainFilter		:= main(orig_filing_date<>'');

pre_file_liens_party  findFilingDt(pre_file_liens_party l, mainFilter r) := transform
		self.Date_First_Seen := if(l.Date_First_Seen = '', r.orig_filing_date, l.Date_First_Seen);
		self := l;
end;

joinMainParty	:= join(pre_file_liens_party, mainFilter, 
						left.tmsid = right.tmsid and
						left.rmsid = right.rmsid,
						findFilingDt(left, right), left outer);

party 			:= project(joinMainParty, 
						transform(liensv2.layout_base_allsources_party, 
						self := left));
						
dedupParty		:= dedup(sort(distribute(party,hash(tmsid)), tmsid, rmsid, orig_name, cname,local), record,local);
// dedupParty		:= dedup(dedup(party,record,all,local),record,all);

PromoteSupers.MAC_SF_BuildProcess(dedupParty,
											'~thor_data400::base::liensv2::party::all_sources',
											bld_all_party,
											2,
											false,
											true,
											filedate);

/*Bankruptcyv2.MAC_SF_BuildProcess(dedupParty,
                       '~thor_data400::base::liensv2::party::all_sources',filedate,bld_all_party,2,false,true,true);*/

  			   
return					   
sequential(bld_all_main,bld_all_party);
end;



			
