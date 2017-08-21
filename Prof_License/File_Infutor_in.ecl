import Prof_License , ut,lib_stringlib, lib_word, address, AID, idl_header,nid;
EXPORT File_Infutor_in(string pversion) := FUNCTION


ds:=Prof_License.File_Infutor_Raw(pversion).Infutor_Raw;


NID.Mac_CleanParsedNames(ds, cleanNames
														, firstname:=FNAME,middlename:=MI,lastname:=lname,namesuffix:=SUFFIX
														, includeInRepository:=true, normalizeDualNames:=false
													);	
names:=cleanNames;	
	

Prof_License.Layout_proLic_in		trans_to_common(names l):= Transform
SELF.prolic_key 		                   := IF(l.LICNBR <> '',(HASH32(Trim(l.state,left,right) + 'INFUTOR') + Trim(l.LICNBR,left,right)),'');
self.date_first_seen                   := pversion;
self.date_last_seen                    := pversion;
self.profession_or_board               := '';
self.license_type                      := l.LICTYPE;
self.status                            := map(trim(l.STATUS) = 'A' => 'ACTIVE',
                                              trim(l.STATUS) = 'I' => 'INACTIVE',
																							trim(l.STATUS) = 'S' => 'SUSPENDED',
																							trim(l.STATUS) = 'P' => 'PERPETUAL',
																							trim(l.STATUS) = 'E' => 'EXPIRED',
																							trim(l.STATUS) = 'R' => 'REVOKED',
																							trim(l.STATUS) = 'C' => 'CANCELED',
																							trim(l.STATUS) = 'Z' => 'OTHERS',
																							trim(l.STATUS) = 'D' => 'DECEASED','');
                                              
self.orig_license_number               := l.LICNBR;
self.license_number                    := l.LICNBR;
self.company_name                      := ut.CleanCompany(l.BUSNAME); 
self.orig_name                         := trim(l.FNAME)+' '+trim(l.MI)+' '+trim(l.LNAME)+' '+trim(l.SUFFIX);
self.name_order                        := 'FML';
self.orig_addr_1                       := l.Address;
self.orig_city                         := l.CITY;
self.orig_st                           := l.STATE;
self.orig_zip                          := l.ZIP;
self.county_str                        := l.CNTY;
self.phone                             := stringlib.stringfilter(L.Phone,'0123456789')[1..10];
self.sex                               := map(l.GENDER='M' => 'MALE',
                                              l.GENDER='F' => 'FEMALE',
																							'');
self.dob                               := l.DOB;
self.issue_date                        := l.ORIGDATE;
self.expiration_date                   := l.EXPDATE;
self.source_st                         := '';
self.vendor                            := 'INFUTOR';
self.title                             := l.cln_title;
self.fname                             := l.cln_fname;
self.mname                             := l.cln_mname;
self.lname                             := l.cln_lname;
self.name_suffix                       := l.cln_suffix;
self                                   := [];

end;			

File_Infutor_in := project(names,trans_to_common(left));

do_out:=output(File_Infutor_in,,'~thor_data400::in::prolic_infutor');

return do_out;

end;
