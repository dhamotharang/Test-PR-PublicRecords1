import Prof_LicenseV2,address,ut,versioncontrol,watchdog;

layPL := Prof_LicenseV2.Layouts_ProfLic.Layout_Base;

export PLExtract(
					string				pversion
					,dataset(layPL)		pPLBase 		= Prof_LicenseV2.File_ProfLic_Base
					,set of string		pZipCodes		= FDS_Test.ZipcodeSet		
					,boolean			pOverwrite		= true
					,boolean			pCsvout			= true
					,string				pSeparator		= '|'	
					) := 
function

	dPL_filter0 := pPLBase(zip in pZipCodes);
	
	FDS_Test.Layouts.Prolic_Extract_Temp tConvert2Slim(dPL_filter0 l) 	:=	transform
		self.key						:=	if (l.company_name != '',
												hash(ut.CleanCompany(l.company_name) + l.license_number + l.source_st),
												if (l.lname!='',
													hash(l.lname + l.fname + l.license_number + l.source_st),
													hash(l.prim_range + l.prim_name + l.p_city_name + l.st + l.zip)
													)
												);
		self.first_Name					:= 	l.fname;
		self.middle_Name				:= 	l.mname;
		self.last_Name					:= 	l.lname;
		self.company_name				:=	l.company_name;
		self.Street_Address				:= 	trim(Address.Addr1FromComponents(
																 l.prim_range
																,l.predir
																,l.prim_name
																,l.suffix
																,l.postdir
																,'',''
															),left,right);
		self.Secondary_Address 			:= 	trim(Address.Addr1FromComponents(
																 l.unit_desig
																,l.sec_range
																,''
																,''
																,''
																,''
																,''
															),left,right);
		self.City						:= 	l.p_city_name;
		self.State						:= 	l.st;
		self.Zip_Code					:= 	l.zip;
		self.License_Number 			:=	l.license_number;
		self.phone						:= 	l.phone;
		self.License_Type				:=	l.license_type;
		self.License_state				:=	l.source_st;
		self.License_Profession			:=	l.profession_or_board;
		self.License_Status				:=	l.status;
		self.License_Issue_Date			:=	l.issue_date;
		self.License_Expiration_Date	:=	l.expiration_date;
		self.Last_Renewal_Date			:=	l.last_renewal_date;
		self							:=	l;
		self							:=	[];
	end;
	
	dPreProcess 			:= 	project(dPL_filter0, tConvert2Slim(left));
	
	dedupedSlim				:=	dedup(sort(dPreProcess, key, license_type, -date_last_seen),except date_last_seen);
	
	justFive				:= 	dedup(sort(dedupedSlim, key, -date_last_seen), key, keep 5);
	
	// dedupedSlim				:=	dedup(sort(dPreProcess, prolic_key, last_name, first_name, company_name, license_type, -date_last_seen),except date_last_seen);
	
	// withProlicKey			:=	dedupedSlim(prolic_key!='');
	// withOutProlicKey			:=	dedupedSlim(prolic_key='' and (last_name!='' or first_name!='' or company_name!=''));
	
	// drecords_WithKey			:= 	dedup(sort(withProlicKey,prolic_key, -date_last_seen), prolic_key,keep 5);
	// drecords_WithOutKey		:= 	dedup(sort(withOutProlicKey, last_name, first_name, company_name, license_type, -date_last_seen), last_name, first_name, company_name, license_type,keep 5);
	
	// allRecords				:=	sort((drecords_WithKey + drecords_WithOutKey),key,-date_last_seen);

	FDS_Test.Layouts.Prolic_Extract_Temp tConvert2Response(FDS_Test.Layouts.Prolic_Extract_Temp pLeft, FDS_Test.Layouts.Prolic_Extract_Temp pRight) := transform
		self.record_id		:=	if (pLeft.Record_ID='',
									'1',
									if (pLeft.key = pRight.key,
											pLeft.Record_id,
											(string)((integer)pLeft.Record_id + 1)
										)
									);
		self.SourceZip			:= 	pRight.zip_code;
		self					:=	pRight;
	end;

	dResponse	:=	sort(iterate(justFive, tConvert2Response(left,right)),key, -date_last_seen);
	
	reformatDate(string inDate) := function
		string8 newDate		:= inDate[5..6] + inDate[7..8] + inDate[1..4];	
		return newDate;	
	end;

	// reformat dates & output into the FDS extract layout
	FDS_Test.Layouts.Prolic_Extract trfFormatFDS(FDS_Test.Layouts.Prolic_Extract_Temp input)	:=	transform
		self.License_Issue_Date			:=	reformatDate(input.License_Issue_Date);
		self.License_Expiration_Date	:=	reformatDate(input.License_Expiration_Date);
		self.Last_Renewal_Date			:=	reformatDate(input.Last_Renewal_Date);
		self							:=	input;
	end;

	FDS_Format	:=	sort(project(dResponse, trfFormatFDS(left)),SourceZip,record_id,-License_Issue_Date);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.PL_Extract.new	,FDS_Format	,BuildResponseFile,,pCsvout,pOverwrite,pSeparator);

	return sequential(
						output('FDS Extract Results Follow'	,named('__'							))
						,output(justFive)
						,output(dresponse)
						,output(FDS_Format)
						,BuildResponseFile
					  );

end;