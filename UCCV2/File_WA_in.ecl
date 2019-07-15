import STD;

lines := record
	string line  {maxlength(115000)};
	end;
	
dsCSV := dataset('~thor_data400::in::uccv2::wa',lines,csv(separator('~^~^~'),terminator('</Document>'),quote(''),maxlength(115000)));

NonPrintable := '\000\001\002\003\004\005\006\007\010\011\012\013\014\015\016\017\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037'; 

dsChecked1 := project(dsCSV,transform({dsCSV},					
					line0 := STD.Str.FilterOut(left.line, NonPrintable);
					line1 := if(regexfind('[^\\s]*&(?!.*;)[^\\s]*',line0),
									stringlib.StringFindReplace(line0,regexfind('[^\\s]*&(?!.*;)[^\\s]*',line0,0),
									stringlib.stringfilterout(regexfind('[^\\s]*&(?!.*;)[^\\s]*',line0,0),'&')),
									line0);
					line2 := if(regexfind('[^\\s]*&(?!.*;)[^\\s]*',line1),
									stringlib.StringFindReplace(line1,regexfind('[^\\s]*&(?!.*;)[^\\s]*',line1,0),
									stringlib.stringfilterout(regexfind('[^\\s]*&(?!.*;)[^\\s]*',line1,0),'&')),
									line1);	
					line3 := regexreplace(x'0D0A',line2,'');
					line4 := regexreplace('<[?]xml version=\'1.0\'[[:space:]]+encoding=\'UTF-8\'[?]>', line3,'');
					line5 := regexreplace('</Documents>|<Documents>|<Version>.*</Version>', line4,'');
					line6 := regexreplace(x'0A',line5,' ');
					//Following is to omit a bad record that the xml parser does not like
					line7 := if(regexfind('<ContactNameAndPhone>Zolton-Amphenee:',line6,nocase),'',line6);
					self.line := if(regexfind('[^\\s]*&(?!.*;)[^\\s]*',line7),
									error('More than 2 unwanted ampersands found in a document. Modify code in ' +
									      'UCCV2.File_WA_in'),line7 + if(trim(line7)<>'','</Document>',''));
				    ));

dsChecked2 := dsChecked1(trim(line,left,right)<>'');
				 
sequential(
	 output(dsChecked2,,'~thor_data400::in::uccv2::cleaned_wa', csv(separator(','),terminator('\n'),quote('')), overwrite)	
	// ,output(dataset('~thor_data400::in::uccv2::cleaned_wa',UCCV2.Layout_File_WA_in.layout_XMLRec,xml('Document',NOROOT)))
	);

//Now that clean-up is finished, build the records from the xml documents.
dsInput:= distribute(dataset('~thor_data400::in::uccv2::cleaned_wa',UCCV2.Layout_File_WA_in.layout_XMLRec,xml('Document',NOROOT)),hash(originalFileNumber,FileNumber));

// need an amendment child dataset layout that has the 'key' of the record (file number) attached.
AmendChildRec := RECORD,maxlength(200000)
		string SubFileNumber;
		string amendType;
END;

// normalize transform...take the amendment child dataset & break into a flat file - attach the 'key' to the file.
AmendChildRec NewAmendChildren(UCCV2.Layout_File_WA_in.layout_XMLRec l, UCCV2.Layout_File_WA_in.layout_AmendmentType R) := TRANSFORM
		 self.subfilenumber := l.originalFileNumber;
		 SELF := R;
 END;

// call to normalize the amendment child dataset.  1st parameter is the parent record, second parameter is the amendment child record.
NewAmendChilds := NORMALIZE(dsInput,LEFT.AmendmentTypeLoop,NewAmendChildren(left,RIGHT),local);

// need a Debtor layout that has the 'key' of the record (file number) attached.
DebtorChildRec := RECORD,maxlength(200000)
		string SubFileNumber;
		string OrganizationName;
		string LName;
		string FName;
		string MName;
		string Suffix;
		string MailAddress;
		string City;
		string State;
		string PostalCode;
		string Country;
		string TaxID;
		string OrganizationalType;
		string OrganizationalJuris;
		string OrganizationalID;		
		string AltCapacity;
END;

// Normalize transform...take the Debtor child dataset & break into a flat file - attach the 'key' to the file.
DebtorChildRec NewDebtorChildren(UCCV2.Layout_File_WA_in.layout_XMLRec l, UCCV2.Layout_File_WA_in.layout_Debtors R) := TRANSFORM
		 self.subfilenumber := l.originalFileNumber;
		 SELF := R;
 END;

// call to normalize the Debtor child dataset.  1st parameter is the parent record, second parameter is the Debtor child record.
NewDebtorChilds := NORMALIZE(dsInput,LEFT.Debtors,NewDebtorChildren(left,RIGHT),local);

SecuredChildRec := RECORD,maxlength(200000)
		string SubFileNumber;
		string OrganizationName;
		string LName;
		string FName;
		string MName;
		string Suffix;
		string MailAddress;
		string City;
		string State;
		string PostalCode;
		string Country;
		string TaxID;
		string OrganizationalType;
		string OrganizationalJuris;
		string OrganizationalID;	
END;

// Normalize transform...take the Debtor child dataset & break into a flat file - attach the 'key' to the file.
SecuredChildRec NewSecuredChildren(UCCV2.Layout_File_WA_in.layout_XMLRec l, UCCV2.Layout_File_WA_in.layout_Secured R) := TRANSFORM
		 self.subfilenumber := l.originalFileNumber;
		 SELF := R;
 END;

// call to normalize the Debtor child dataset.  1st parameter is the parent record, second parameter is the Debtor child record.
NewSecuredChilds := NORMALIZE(dsInput,LEFT.Secured,NewSecuredChildren(left,RIGHT),local);

AssignorChildRec := RECORD,maxlength(200000)
		string SubFileNumber;
		string OrganizationName;
		string LName;
		string FName;
		string MName;
		string Suffix;
		string MailAddress;
		string City;
		string State;
		string PostalCode;
		string Country;
		string TaxID;
		string OrganizationalType;
		string OrganizationalJuris;
		string OrganizationalID;	
END;

// Normalize transform...take the Debtor child dataset & break into a flat file - attach the 'key' to the file.
AssignorChildRec NewAssignorChildren(UCCV2.Layout_File_WA_in.layout_XMLRec l, UCCV2.Layout_File_WA_in.layout_Assignor R) := TRANSFORM
		 self.subfilenumber := l.originalFileNumber;
		 SELF := R;
 END;

// call to normalize the Debtor child dataset.  1st parameter is the parent record, second parameter is the Debtor child record.
NewAssignorChilds := NORMALIZE(dsInput,LEFT.Assignor,NewAssignorChildren(left,RIGHT),local);

AuthSecChildRec := RECORD,maxlength(200000)
		string SubFileNumber;
		string OrganizationName;
		string LName;
		string FName;
		string MName;
		string Suffix;
END;

// Normalize transform...take the Debtor child dataset & break into a flat file - attach the 'key' to the file.
AuthSecChildRec NewAuthSecChildren(UCCV2.Layout_File_WA_in.layout_XMLRec l, UCCV2.Layout_File_WA_in.layout_AuthSecured R) := TRANSFORM
		 self.subfilenumber := l.originalFileNumber;
		 SELF := R;
 END;

// call to normalize the Debtor child dataset.  1st parameter is the parent record, second parameter is the Debtor child record.
NewAuthSecuredChilds := NORMALIZE(dsInput,LEFT.AuthSecured,NewAuthSecChildren(left,RIGHT),local);

AuthDebtorChildRec := RECORD,maxlength(200000)
		string SubFileNumber;
		string OrganizationName;
		string LName;
		string FName;
		string MName;
		string Suffix;
END;

// Normalize transform...take the Debtor child dataset & break into a flat file - attach the 'key' to the file.
AuthDebtorChildRec NewAuthDebtorChildren(UCCV2.Layout_File_WA_in.layout_XMLRec l, UCCV2.Layout_File_WA_in.layout_AuthDebtor R) := TRANSFORM
		 self.subfilenumber := l.originalFileNumber;
		 SELF := R;
 END;

// call to normalize the Debtor child dataset.  1st parameter is the parent record, second parameter is the Debtor child record.
NewAuthDebtorChilds := NORMALIZE(dsInput,LEFT.AuthDebtor,NewAuthDebtorChildren(left,RIGHT),local);


// Layout for the combined record - parent being joined with the normalized child dataset.
BasicAmendRec	:= record,maxlength(200000)
		string transType;
		string method;          
		string amendAction;
		string amendType;
		string originalFileNumber;
		string expiration;
		string FileNumber;
		string FileDate;
		string FileTime;
		string FilingOffice;		
		string AltNameDesignation;
		string AltFilingType;
		string Designation;
		string RealEstateDescription;
		string ColText;
		string ContactName;
		string ContactPhone;
		string ContactNameAndPhone;
		string BoxBLine1;
		string BoxBLine2;
		string BoxBLine3;
		string BoxBLine4; 
		string OptionalFilerReferenceData;
end;

BasicNameRec	:= record,maxlength(200000)
		BasicAmendRec;
		string NameType;
		string OrganizationName;
		string LName;
		string FName;
		string MName;
		string Suffix;
		string MailAddress;
		string City;
		string State;
		string PostalCode;
		string Country;
		string TaxID;
		string OrganizationalType;
		string OrganizationalJuris;
		string OrganizationalID;		
		string AltCapacity;
		string100	prep_addr_line1;
		string50	prep_addr_last_line; 
		unsigned8	RawAid	:= 0;
		unsigned8	ACEAID	:= 0;	 				
end;

BasicAmendRec	 trfJoinBasicAmend(UCCV2.Layout_File_WA_in.layout_XMLRec l, AmendChildRec r)	:= transform
			self		:= 	l;
			self		:= 	r;
			self		:=	[];
end;

// Join two files on 'key'
joinedBasicAmend	:=	join(
														dsInput,
														NewAmendChilds,
														left.originalFileNumber = right.SubFileNumber,
														trfJoinBasicAmend(left,right),
														left outer,
														local
													);

BasicNameRec	 trfJoinBasicDebtor(BasicAmendRec l, DebtorChildRec r)	:= transform,skip(trim(r.OrganizationName,left,right) = '' and
																																												trim(r.LName,left,right)='')
			self					:= 	l;
			self					:= 	r;
			self.NameType	:=	'D';
			self					:=	[];
end;

// Join two files on 'key'
JoinedBasicDebtor	:=	join(
														joinedBasicAmend,
														NewDebtorChilds,
														left.originalFileNumber = right.SubFileNumber,
														trfJoinBasicDebtor(left,right),
														left outer,
														local
													);
													
BasicNameRec	 trfJoinBasicSecured(BasicAmendRec l, SecuredChildRec r)	:= transform,skip(trim(r.OrganizationName,left,right) = '' and
																																													trim(r.LName,left,right)='')
			self					:= 	l;
			self					:= 	r;
			self.NameType	:=	'S';
			self					:= 	[];			
end;

// Join two files on 'key'
JoinedBasicSecured	:=	join(
															joinedBasicAmend,
															NewSecuredChilds,
															left.originalFileNumber = right.SubFileNumber,
															trfJoinBasicSecured(left,right),
															left outer,
															local
														);	
													
BasicNameRec	 trfJoinBasicAssignor(BasicAmendRec l, AssignorChildRec r)	:= transform,skip(trim(r.OrganizationName,left,right) = '' and
																																														trim(r.LName,left,right)='')
			self					:= 	l;
			self					:= 	r;
			self.NameType	:=	'A';			
			self					:= 	[];			
end;

// Join two files on 'key'
JoinedAssignorSecured	:=	join(
															joinedBasicAmend,
															NewAssignorChilds,
															left.originalFileNumber = right.SubFileNumber,
															trfJoinBasicAssignor(left,right),
															left outer,
															local
														);	

BasicNameRec	 trfJoinBasicAuthSec(BasicAmendRec l, AuthSecChildRec r)	:= transform,skip(trim(r.OrganizationName,left,right) = '' and
																																													trim(r.LName,left,right)='')
			self					:= l;
			self					:= r;
			self.NameType	:=	'S';  // was using 'AS'
			self					:= [];			
end;

// Join two files on 'key'
JoinedBasicAuthSec	:=	join(
															joinedBasicAmend,
															NewAuthSecuredChilds,
															left.originalFileNumber = right.SubFileNumber,
															trfJoinBasicAuthSec(left,right),
															left outer,
															local
														);																						
											
BasicNameRec	 trfJoinBasicAuthDebtor(BasicAmendRec l, AuthDebtorChildRec r)	:= transform,skip(trim(r.OrganizationName,left,right) = '' and
																																																trim(r.LName,left,right)='')
			self					:= l;
			self					:= r;
			self.NameType	:=	'D';  // was using 'AD'			
			self					:= [];				
end;

// Join two files on 'key'
JoinedBasicAuthDebtor	:=	join(
															joinedBasicAmend,
															NewAuthDebtorChilds,
															left.originalFileNumber = right.SubFileNumber,
															trfJoinBasicAuthDebtor(left,right),
															left outer,
															local
														);	

BasicNameRec	trfPrepAddresses(	BasicNameRec pInput)	:=	transform
		self.prep_addr_line1			:=	pInput.MailAddress;
		self.prep_addr_last_line	:=	if (	pInput.City!='',
																					StringLib.StringCleanSpaces(pInput.city + ', ' + pInput.state + ' ' + pInput.PostalCode[1..5]),
																					StringLib.StringCleanSpaces(pInput.state + ' ' + pInput.PostalCode[1..5])
																			);	
		self											:=	pInput;
end;
													
JoinedWA	:= 	JoinedBasicDebtor + JoinedBasicSecured + JoinedAssignorSecured + JoinedBasicAuthSec + JoinedBasicAuthDebtor;	

AllJoined	:=	project(JoinedWA, 	trfPrepAddresses(left));							
																						
export File_WA_in := dedup(sort(AllJoined,originalFileNumber),RECORD,all);
 