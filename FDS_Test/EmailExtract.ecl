import entiera;

dEntiera				:=	entiera.File_Entiera_Base(clean_address.zip in zipcodeset and orig_email != '');

dEntiera_dist		:=	distribute(dEntiera, hash(clean_name.fname,
																							clean_name.lname
																							)
															);

dEntiera_sort		:=	sort(	dEntiera_dist,
													clean_name.fname,
													clean_name.lname,
													clean_name.mname,
													orig_email,
													-date_last_seen,
													-date_vendor_last_reported,
													local
												);

dEntiera_dedup	:=	dedup(dEntiera_sort,
													clean_name.fname,
													clean_name.lname,
													clean_name.mname,
													orig_email,
													local
													);

rEntieraStats_layout	:=
record
	dEntiera_dedup.clean_address.zip;
	countGroup	:=	count(group);
end;

dEntiera_CountStats	:=	sort(table(dEntiera_dedup, rEntieraStats_layout, dEntiera.clean_address.zip, few), Zip);

layout_consumer.response.rFDSEmail_layout	tFDSEmailExtract(dEntiera_CountStats pInput, integer cnt)	:=
transform
	self.Record_ID			:=	(string)cnt;
	self.Count_Results	:=	(string)pInput.countGroup;
	self								:=	pInput;
end;

dFDSEmailExtract	:=	project(dEntiera_CountStats, tFDSEmailExtract(left, counter));

outEntieraExtractTest		:=	output(	sort(dEntiera_dedup,clean_address.zip),,
																			'~thor_data400::out::fds_test::consumer::email_extract_test',
																			overwrite
																		);

outEntieraExtractFixed	:=	output(	dFDSEmailExtract,,
																			'~thor_data400::out::fds_test::consumer::email_extract_fixed',
																			overwrite
																		);

outEntieraExtract				:=	output(	dFDSEmailExtract,,
																			'~thor_data400::out::fds_test::consumer::email_extract',
																			csv(heading(single),separator('|'),terminator('\n')),
																			overwrite
																		);

export EmailExtract := sequential(outEntieraExtractTest,outEntieraExtractFixed,outEntieraExtract);