//Export tax assessor base, and corresponding additional legal, additional names, and search files.

IMPORT ut,dops,lib_word,lib_StringLib,LN_PropertyV2_Fast,LN_PropertyV2,_control;

EXPORT proc_Extract_Property(string8 procdate, string8 maxdate='99999999', boolean isFast, string emailRecipients) := FUNCTION

	lastversion 		:= LN_PropertyV2_Fast.BuildExtractPropertyLogger.getlastversion(maxdate);
	assdprocdate		:= if(isfast,lastversion.assd_process_date,procdate[1..8]);
	deed_date 			:= if(trim(lastversion.version)<>'',lastversion.deed_process_date,procdate);
	assd_date 			:= if(isfast,'99999999',if(trim(lastversion.version)<>'',lastversion.assd_process_date,procdate));
	dops_history		:= dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')((integer)prodversion[1..8] > (integer)lastversion.version and
																																					(integer)prodversion[1..8] < (integer)maxdate and
																																					prodversion<>'NA');
	maxversion			:= set(sort(dops_history,-prodversion), prodversion[1..8])[1] : independent;

	
	Assessor2Export	:= LN_PropertyV2.File_Assessment(vendor_source_flag = 'O' and 
																									(unsigned)process_date > (unsigned)assd_date and
																									(unsigned)process_date < (unsigned)maxdate)+
										 LN_PropertyV2_fast.Files.base.Assessment(vendor_source_flag = 'O' and 
																									(unsigned)process_date > (unsigned)assd_date and
																									(unsigned)process_date < (unsigned)maxdate);

	Deeds2Export		:= LN_PropertyV2.File_Deed(vendor_source_flag = 'O' and 
																									(unsigned)process_date > (unsigned)deed_date and
																									(unsigned)process_date < (unsigned)maxdate)+
										 LN_PropertyV2_fast.Files.base.deed_mortg(vendor_source_flag = 'O' and 
																									(unsigned)process_date > (unsigned)deed_date and
																									(unsigned)process_date < (unsigned)maxdate);
	
	EXPORT_DATA			:= PARALLEL(if(not(isfast),output(Assessor2Export,,LN_PropertyV2_Fast.Filenames.exprt.assessment+'_'+procdate,
																										CSV(HEADING('',''), SEPARATOR('|'), TERMINATOR('\n'), QUOTE('"')),OVERWRITE,COMPRESSED),
															output('No assessor data, is fast')),
															output(Deeds2Export,,LN_PropertyV2_Fast.Filenames.exprt.deed_mortg+'_'+procdate,
																		 CSV(HEADING('',''), SEPARATOR('|'), TERMINATOR('\n'), QUOTE('"')),OVERWRITE,COMPRESSED));

	Rec2Export 			:= record
		string12 ln_fares_id;
	end;

	lnidsassd2xprt 	:= project(Assessor2Export,Rec2Export);
	lnidsdeed2xprt 	:= project(Deeds2Export,Rec2Export);

	AllRecs2Export 	:= sort(distribute(lnidsassd2xprt+lnidsdeed2xprt,hash(ln_fares_id)),ln_fares_id,local);

	add_names_file 	:= sort(distribute(ln_propertyv2.File_LN_deed_addlnames(ln_fares_id[1]='O'),hash(ln_fares_id))+
																		 ln_propertyv2_fast.Files.base.addl_names(ln_fares_id[1]='O'),
													hash(ln_fares_id),ln_fares_id,local);
																		

	AddNames2Export	:= join(AllRecs2Export,add_names_file,left.ln_fares_id=right.ln_fares_id,
												TRANSFORM(LN_PropertyV2_Fast.layout_export_addl_names,
																	self.ln_id:=right.ln_fares_id;
																	SELF:=RIGHT));
	EXPORT_ADDNAMES	:= output(AddNames2Export,,LN_PropertyV2_Fast.Filenames.exprt.addl_names+'_'+procdate,
														CSV(HEADING('',''), SEPARATOR('|'), TERMINATOR('\n'), QUOTE('"')),OVERWRITE,COMPRESSED);

	add_legal_file 	:= sort(distribute(ln_propertyv2.File_addl_legal(ln_fares_id[1]='O')+
																		 ln_propertyv2_fast.Files.base.addl_legal(ln_fares_id[1]='O'),
													hash(ln_fares_id)),ln_fares_id,local);

	Addlegal2Export	:= join(AllRecs2Export,add_legal_file,left.ln_fares_id=right.ln_fares_id,
												TRANSFORM(LN_PropertyV2_Fast.layout_export_addl_legal,
																	self.ln_id:=right.ln_fares_id;
																	SELF:=RIGHT));
	EXPORT_ADD_LEGAL:= output(Addlegal2Export,,LN_PropertyV2_Fast.Filenames.exprt.addl_legal+'_'+procdate,
														CSV(HEADING('',''), SEPARATOR('|'), TERMINATOR('\n'), QUOTE('"')),OVERWRITE,COMPRESSED);

	search_file 		:= sort(distribute(ln_propertyv2.file_search_did(vendor_source_flag='O')+
																		 ln_propertyv2_fast.Files.base.search_prp(vendor_source_flag='O'),
													hash(ln_fares_id)),ln_fares_id,local);

	Search2Export		:= join(search_file,AllRecs2Export,left.ln_fares_id=right.ln_fares_id,
												TRANSFORM(LN_PropertyV2_Fast.layout_export_property_search,
																	self.ln_id:=left.ln_fares_id;
																	SELF:=LEFT));
	EXPORT_SEARCH 	:= output(Search2Export,,LN_PropertyV2_Fast.Filenames.exprt.search_prp+'_'+procdate,
														CSV(HEADING('',''), SEPARATOR('|'), TERMINATOR('\n'), QUOTE('"')),OVERWRITE,COMPRESSED);

	flag_file				:= output(dataset([{procdate}],{string8 version_date}),,'~thor::property_okc_export_version',overwrite);

	DestinationIP 	:= _control.IPAddress.bctlpedata12;

	FLAG_FILE_DSPRY	:= fileservices.despray('~thor::property_okc_export_version', DestinationIP, '/data/hds_180/property/okc/extract/flag/'+'okc_export.txt',,,,TRUE); 	
	ASSESSOR_DSPRY	:= if(not(isfast),fileservices.despray(LN_PropertyV2_Fast.Filenames.exprt.assessment+'_'+procdate, DestinationIP, '/data/hds_180/property/okc/extract/'+'assessment'+'_'+procdate+'.csv',,,,TRUE)); 
	DEEDMORTG_DSPRY	:= fileservices.despray(LN_PropertyV2_Fast.Filenames.exprt.deed_mortg+'_'+procdate, DestinationIP, '/data/hds_180/property/okc/extract/'+'deed_mortg'+'_'+procdate+'.csv',,,,TRUE); 	
	ADDLNAMES_DSPRY	:= fileservices.despray(LN_PropertyV2_Fast.Filenames.exprt.addl_names+'_'+procdate, DestinationIP, '/data/hds_180/property/okc/extract/'+'addl_names'+'_'+procdate+'.csv',,,,TRUE); 	
	ADDLLEGAL_DSPRY	:= fileservices.despray(LN_PropertyV2_Fast.Filenames.exprt.addl_legal+'_'+procdate, DestinationIP, '/data/hds_180/property/okc/extract/'+'addl_legal'+'_'+procdate+'.csv',,,,TRUE); 	
	SEARCH_DSPRY		:= fileservices.despray(LN_PropertyV2_Fast.Filenames.exprt.search_prp+'_'+procdate, DestinationIP, '/data/hds_180/property/okc/extract/'+'search'+'_'+procdate+'.csv',,,,TRUE); 	
	
	run_all := SEQUENTIAL(
				EXPORT_DATA,
				EXPORT_ADDNAMES,
				EXPORT_ADD_LEGAL,
				EXPORT_SEARCH,
				output(count(Assessor2Export),named('Assessor_to_Export')),
				output(count(Deeds2Export),named('Deeds_to_Export')),
				output(count(AddNames2Export),named('Addl_Names_to_Export')),
				output(count(Addlegal2Export),named('Addl_Legal_to_Export')),
				output(count(Search2Export),named('Search_to_Export')),
				flag_file,
				PARALLEL(FLAG_FILE_DSPRY,
								 if(not(isfast),ASSESSOR_DSPRY),
								 DEEDMORTG_DSPRY,
								 ADDLNAMES_DSPRY,
								 ADDLLEGAL_DSPRY,
								 SEARCH_DSPRY),
				LN_PropertyV2_Fast.BuildExtractPropertyLogger.update(maxversion,'assd_process_date',assdprocdate),
				LN_PropertyV2_Fast.BuildExtractPropertyLogger.update(maxversion,'update_type',if(isFast,'DELTA','FULL')),
				LN_PropertyV2_Fast.BuildExtractPropertyLogger.update(maxversion,'deed_process_date',maxversion),
				);

	RETURN LN_PropertyV2_Fast.jobinfo.RunActionAndUpdateViaEmail(run_all,emailRecipients); 
END;