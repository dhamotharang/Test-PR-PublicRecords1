import ut;
AreaCodeSummary :=record
 string5   zip;
 string10  phone;
 string3   timezone:='';
end;

gong_zip_npanxx_tbl := table (Gong.File_Address_Current(phone10<>'' and z5 <> '00000'),
								{zip := z5, 
								 phone := phone10},
								 z5,
								 phone10,
								 few);

gong_zip_npanxx_t := project(gong_zip_npanxx_tbl, AreaCodeSummary);
ut.getTimeZone(gong_zip_npanxx_t,phone,timezone,gong_zip_npanxx_out);

npanxx_tbl := table(Gong.File_Address_Current(phone10<>''),
										{zip := z5,
										areacode := phone10 [..3],
										cnt := count(group)},
										z5,
										phone10 [..3],
										few);


AreaCodeFinal :=record
 string5 zip;
 string3 areacode;
 string3 timezone;
 integer occurs;
end;


AreaCodeRecords := join(dedup(sort(gong_zip_npanxx_out(timezone <> ''),zip, phone [..3],timezone), zip, phone [..3],timezone),
												 npanxx_tbl,
												 left.zip = right.zip and
												 left.phone [..3] = right.areacode,
												 transform(AreaCodeFinal,
																	 self.occurs := right.cnt,
																	 self.areacode := left.phone[..3],
																	 self := left));


export File_Npa_Zip := AreaCodeRecords;