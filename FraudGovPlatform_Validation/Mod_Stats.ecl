IMPORT STD,FraudGovPlatform,FraudShared;
EXPORT Mod_stats := MODULE

	EXPORT ValidateDelimiter(string fname, string pSeparator, string pTerminator):= module

		infile:=dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,
				{string line},CSV(separator([]),quote([]),terminator(pTerminator)));

		r:=record
			string2 FileState;
			string75 FileName;
			string8 FileDate;
			string6 FileTime;
			string1 Accepted;
			unsigned4 RecordsTotal;
			unsigned4 RecordsRejected;
			unsigned4 ErrorCount;
			unsigned4 WarningCount;
			unsigned4 seq;
			string50 err;
			infile;
		end;


		seqd:=project(infile
						,transform(r
							,self.seq:=counter
							,self:=left
							,self:=[]));

		mx:=max(seqd,seq);

		r tr0(r l):=transform
			self.FileName   :=trim(fname);
			self.FileState  :=if(regexfind('Inquirylogs',fname,nocase),'NA',stringlib.stringtouppercase(fname[1..2]));
			self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
			self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
			self.RecordsTotal :=mx;
			self:=l;
		end;

		withRC:=project(seqd,tr0(left));

		r tr1(withRC l, integer c):=transform
			self.err:= if(STD.Str.FindCount( l.line, pSeparator ) = 0,'F1','');
			self:=l;
		end;

		err1:=project(withRC,tr1(left,counter));

		comb:=
					sort(table(err1(err='F1'),{
							string10 ReportName	:='delimiter'
							,min_seq:=min(group,seq)
							,err_cnt:=count(group)
							,err1
							},filedate,filetime,seq,err,few),filedate,filetime,-err_cnt);


			comb tr5(comb l) := transform
				dDelimiter:=comb(ReportName='delimiter');
				InvalidDelimiter :=exists(dDelimiter(err='F1')); 
				
				self.Accepted:=if(InvalidDelimiter,'N','Y');
				self.RecordsRejected:=	(sum(dDelimiter(err='F1'),err_cnt));
				self.ErrorCount := (sum(dDelimiter(err='F1'),err_cnt)); 
				self.WarningCount:=0;
				self:=l;

			end;

		EXPORT ValidationResults:=project(comb,tr5(left));


END;

	EXPORT ValidateNumberOfColumns(string fname, string pSeparator, string pTerminator):= module
			infile:=dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,
					{string line},CSV(separator([]),quote([]),terminator(pTerminator)));

			r:=record
				string2 FileState;
				string75 FileName;
				string8 FileDate;
				string6 FileTime;
				string1 Accepted;
				unsigned4 RecordsTotal;
				unsigned4 RecordsRejected;
				unsigned4 ErrorCount;
				unsigned4 WarningCount;
				unsigned4 seq;
				string50 err;
				infile;
			end;


			seqd:=project(infile
							,transform(r
								,self.seq:=counter
								,self:=left
								,self:=[]));

			mx:=max(seqd,seq);

			r tr0(r l):=transform
				self.FileName   :=trim(fname);
				self.FileState  :=if(regexfind('Inquirylogs',fname,nocase),'NA',stringlib.stringtouppercase(fname[1..2]));
				self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
				self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
				self.RecordsTotal :=mx;
				self:=l;
			end;

			withRC:=project(seqd,tr0(left));

			numberOfColumns	:=	MAP (
												 STD.Str.Contains( fname, 'IdentityData',	true )	=> Mod_Sets.IdentityData_numberOfColumns
												,STD.Str.Contains( fname, 'KnownFraud'	,	true )	=> Mod_Sets.KnownFraud_numberOfColumns
												,STD.Str.Contains( fname, 'InquiryLogs'	,	true )	=> Mod_Sets.InquiryLogs_numberOfColumns
												,0
									);
			
			validDelimiter := MAP (	STD.Str.Contains( fname, 'InquiryLogs'	,	true )	=> Mod_Sets.validDelimiterInqLog,
													FraudGovPlatform_Validation.Mod_Sets.validDelimiter	);
			
			
			r tr1(withRC l, integer c):=transform
				self.err:= if(
					STD.Str.FindCount( l.line, validDelimiter ) <> numberOfColumns 
					 and STD.Str.FindCount( l.line, validDelimiter ) 
						> 0,'F2','');
				self:=l;
			end;

			err1:=project(withRC,tr1(left,counter));

			comb:=
						sort(table(err1(err='F2'),{
								string10 ReportName	:='fields'
								,min_seq:=min(group,seq)
								,err_cnt:=count(group)
								,err1
								},filedate,filetime,seq,err,few),filedate,filetime,-err_cnt);


				comb tr5(comb l) := transform
					dDelimiter:=comb(ReportName='fields');
					InvalidColumnCount :=exists(dDelimiter(err='F2')); 
					
					self.Accepted:=if(InvalidColumnCount,'N','Y');
					self.RecordsRejected:=	(sum(dDelimiter(err='F2'),err_cnt));
					self.ErrorCount := (sum(dDelimiter(err='F2'),err_cnt)); 
					self.WarningCount:=0;
					self:=l;

				end;

			EXPORT ValidationResults:=project(comb,tr5(left));


	END;


	
	EXPORT ValidateInputs(string fname,dataset(FraudGovPlatform.Layouts.Sprayed.validate_record) infile):= module

			r:=record
				string2 	FileState;
				string75 	FileName;
				string8 	FileDate;
				string6 	FileTime;
				string1 	Accepted;
				unsigned4 RecordsTotal;
				unsigned4 RecordsRejected;
				unsigned4 ErrorCount;
				unsigned4 WarningCount;
				unsigned4 seq;
				string50 	field;
				string50 	value;
				string50 	err;
				infile;
			end;


			seqd:=project(infile
							,transform(r
								,self.seq:=counter
								,self:=left
								,self:=[]));

			mx:=max(seqd,seq);

			r tr0(r l):=transform
				self.FileName   :=trim(fname);
				self.FileState  :='NA';
				self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
				self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
				self.RecordsTotal :=mx;
				self:=l;
			end;

			withRC:=project(seqd,tr0(left));

			r tr1(withRC l, integer c):=transform

				self.field:=choose(c
													,'Client_ID'
													,'Customer_State'
													,'customer_county'
													,'Customer_Agency_Vertical_Type'
													,'Customer_Program'
													,'reported_date'
													,'lexid'
													,'full_name'
													,'First_name'
													,'Last_Name'
													,'SSN'
													,'full_address'
													,'physical_address'
													,'physical_address_1'
													,'Physical_Address_2'
													,'City'
													,'State'
													,'Zip'
													,'Drivers_License_Number'
													,'Drivers_License_State'
													);

				self.value:=choose(c
													,l.Client_ID
													,l.Customer_State
													,l.customer_county
													,l.Customer_Agency_Vertical_Type
													,l.Customer_Program
													,l.reported_date
													,l.lexid
													,l.full_name
													,l.First_name
													,l.Last_Name
													,l.SSN
													,l.full_address
													,l.physical_address
													,l.physical_address_1
													,l.City
													,l.State
													,l.Zip
													,l.Drivers_License_Number
													,l.Drivers_License_State
													);

				self.err:=choose(c
										,if(l.Client_ID <>'','','E001')
										,if(STD.Str.ToUpperCase(l.Customer_State)	in Mod_Sets.States,'','E003')
										,if(l.Customer_County <>'','','E001')
										,if(STD.Str.ToUpperCase(l.Customer_Agency_Vertical_Type) in Mod_Sets.Agency_Vertical_Type,'','E004')
										,if(STD.Str.ToUpperCase(l.Customer_Program) in Mod_Sets.IES_Benefit_Type ,'','E005')
										,if(STD.Str.Contains( fname, 'KnownFraud|InquiryLogs',	true )	
																		,if(length(trim(l.reported_date,left,right))=8,'','E002'),'')								
										,'' //lexid
										,''	//fullname
										,if(regexreplace('0',l.lexid,'')	<>'' or (l.First_name <>'' or l.full_name <>''),'','E001')	
										,if(regexreplace('0',l.lexid,'')	<>'' or (l.Last_Name <>'' or l.full_name <>''),'','E001')
										,if(l.SSN <>''	OR	regexreplace('0',l.lexid,'')	<>'' OR	
													(l.Drivers_License_Number<>'' AND	l.Drivers_License_State	<>''),'','E006')
										,''	//full_address (InquiryLogs)
										,''	//physical_address (InquiryLogs)
										,''	//physical_address_1
										,''	//City
										,if(STD.Str.Contains( fname, 'InquiryLogs',	true )
   												,if(l.full_address <>'' or 
																(l.physical_address <>'' and 
																		if(l.city <>''
																			,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) or
																				length(trim(l.Zip,left,right)) in [9,5] )
																			,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) and
																				length(trim(l.Zip,left,right)) in [9,5] )))																,'','W002')
   												,if(l.physical_address_1 <>'' and 
																	if(l.city <>''
																		,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) or
																				length(trim(l.Zip,left,right)) in [9,5] )
																		,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) and
																				length(trim(l.Zip,left,right)) in [9,5] ))																,'','W002')
   												)
										,''	//zip
										,'' //Drivers_License_Number
										,'' //Drivers_License_State
										);
				self:=l;
				end;

			Shared err1:=normalize(withRC,19,tr1(left,counter));

			//output(err1);
			
			EXPORT ValidationResults := err1;

	END;

	
	EXPORT ValidateInputFields(string fname, string pSeparator, string pTerminator):= module


				SHARED DS_IdentityData		:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
																			{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData},
																			CSV(separator([pSeparator]),quote(''),terminator(pTerminator)));


				SHARED DS_KnownFraud			:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
																			{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.KnownFraud},
																			CSV(separator([pSeparator]),quote(''),terminator(pTerminator)));
																			
				SHARED DS_InquiryLogs			:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
																			{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.InquiryLogs},
																			CSV(separator([pSeparator]),quote(''),terminator(pTerminator)));

				Validate_IdentityData := 	ValidateInputs(	fname, 
																	project(DS_IdentityData, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid; SELF := LEFT;SELF := []))).ValidationResults;
																			
				Validate_KnownFraud 	:= 	ValidateInputs(	fname, 
																	project(DS_KnownFraud, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid;SELF := LEFT;SELF := []))).ValidationResults;	


				Validate_InquiryLogs 	:= 	ValidateInputs(	fname, 
																	project(DS_InquiryLogs, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid;SELF := LEFT;SELF := []))).ValidationResults;	

				SHARED ErrorsFound	:=	MAP (
												 STD.Str.Contains( fname, 'IdentityData',	true )	=> Validate_IdentityData
												,STD.Str.Contains( fname, 'KnownFraud'	,	true )	=> Validate_KnownFraud
												,STD.Str.Contains( fname, 'InquiryLogs'	,	true )	=> Validate_InquiryLogs
									);
									
				comb:=
							sort(table(ErrorsFound(err<>''),{
									string10 ReportName	:='field'
									,min_seq:=min(group,seq)
									,err_cnt:=count(group)
									,ErrorsFound
									},filedate,filetime,field,value[1],err,few),filedate,filetime,-err_cnt);
							;

				comb tr5(comb l) := transform
						treshld_							:=	Mod_Sets.threshld;
						ExcessiveInvalidRecordsFound:=exists(comb(err[1]='E',err_cnt/RecordsTotal>treshld_));
						self.Accepted					:=	if(ExcessiveInvalidRecordsFound,'N','Y');
						self.RecordsRejected	:=	0;
						self.ErrorCount				:=	sum(comb(err[1]='E'),err_cnt);
						self.WarningCount			:=	sum(comb(err[1]='W'),err_cnt);
						self:=l;

					end;

				EXPORT ValidationResults:=project(comb,tr5(left));
				

				EXPORT RecordsRejected  := 	count(
																					dedup(
																								sort(
																											(
																												ErrorsFound(err[1]='E')
																											)
																										,Seq)
																									,Seq)
																					);												
									
	END;
	
	//InquiryLog MBS validation
	
	EXPORT ValidateInputWithMBS(string fname, string pSeparator, string pTerminator):= module
		shared infile:=dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,
									FraudGovPlatform.Layouts.Sprayed.InquiryLogs,CSV(separator([pSeparator]),quote([]),terminator(pTerminator)));
		
		shared InqMbs := join(infile,FraudShared.Files().Input.MBS.sprayed(status = 1)
										,left.client_id =(string)right.gc_id
										and left.Customer_State = right.customer_state
										and FraudGovPlatform.Functions.ind_type_fn(left.Customer_Program) = right.ind_type
										and FraudGovPlatform.Functions.file_type_fn('IDDT') = right.file_type
										and left.Customer_Agency_Vertical_Type = right.Customer_Vertical
										// and left.customer_county = right.customer_county 
										,transform({string20 client_id,string1		Customer_Program,string2		customer_state,string		customer_agency_vertical_type,unsigned4 seq}
										,self.Client_ID:=left.Client_id,
										,self.Customer_State:=left.customer_state
										,self.Customer_Agency_Vertical_Type:=left.Customer_Agency_Vertical_Type
										,self.Customer_Program:=left.customer_program
										,self.seq := counter
										,self:=left),left only);
	
		r:=record
			string75 	FileName;
			string8 	FileDate;
			string6 	FileTime;
			string1 	Accepted;
			unsigned4 RecordsTotal;
			unsigned4 RecordsRejected;
			unsigned4 ErrorCount;
			unsigned4 WarningCount;
			unsigned4 seq;
			string255 field;
			string255 value;
			string50 	err;
			InqMbs;
		end;


		seqd:=project(InqMbs
						,transform(r
							,self.seq:=counter
							,self:=left
							,self:=[]));

		mx:=max(seqd,seq);

		r tr0(r l):=transform
			self.FileName   :=trim(fname);
			self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
			self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
			self.RecordsTotal :=count(infile);
			self.ErrorCount		:=mx;
			self.RecordsRejected :=mx;
			self.field 			:='Client_id,Customer_state,customer_program,Customer_Agency_Vertical_Type';
			self.value 			:=trim(l.Client_id,left,right)+','+l.Customer_state+','+l.Customer_program+','+l.Customer_Agency_Vertical_Type;
			self:=l;
		end;

		withRC:=project(seqd,tr0(left));

			comb:=
						sort(table(withRC,{
								string10 ReportName	:='field'
								,min_seq:=min(group,seq)
								,err_cnt:=count(group)
								,withRC
      					},filedate,filetime,field,client_id,customer_state,customer_program,Customer_Agency_Vertical_Type,few),filedate,filetime,-err_cnt);

						;

			comb tr5(comb l) := transform
					treshld_							:=	Mod_Sets.threshld;
					ExcessiveInvalidRecordsFound:=l.errorcount/l.RecordsTotal>treshld_;
					self.Accepted					:=	if(ExcessiveInvalidRecordsFound,'N','Y');
					self.RecordsRejected	:=	0;
					self.WarningCount			:=	0;
					self.err							:=	'W001';
					self:=l;

				end;

			EXPORT ValidationResults:=project(comb,tr5(left));
		
	END;
END;