﻿IMPORT STD,FraudGovPlatform,FraudShared;
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
			self.FileState  :=trim(if(regexfind('Delta',fname,nocase),'NA',regexfind('^([0-9])+',fname, 0)));
			self.FileDate   :=trim(regexfind('([0-9])+_([0-9])\\w+',fname, 0)[1..8]);
			self.FileTime   :=trim(regexfind('([0-9])+_([0-9])\\w+',fname, 0)[10..15]);
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
					},filedate,filetime,seq,err,few),filedate,filetime,-err_cnt):ONWARNING(2168,ignore);


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
				string20 FileState;
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
				self.FileState  :=trim(if(regexfind('Delta',fname,nocase),'NA',regexfind('^([0-9])+',fname, 0)));
				self.FileDate   :=trim(regexfind('([0-9])+_([0-9])\\w+',fname, 0)[1..8]);
				self.FileTime   :=trim(regexfind('([0-9])+_([0-9])\\w+',fname, 0)[10..15]);
				self.RecordsTotal :=mx;
				self:=l;
			end;

			withRC:=project(seqd,tr0(left));

			numberOfColumns	:=	MAP (
										 STD.Str.Contains( fname, 'Identity'	,	true )	=> Mod_Sets.IdentityData_numberOfColumns
										,STD.Str.Contains( fname, 'KnownRisk'	,	true )	=> Mod_Sets.KnownFraud_numberOfColumns
										,STD.Str.Contains( fname, 'Safelist'	,	true )	=> Mod_Sets.SafeList_numberOfColumns
										,STD.Str.Contains( fname, 'Delta'	,	true )	=> Mod_Sets.Deltabase_numberOfColumns
										,0
									);
			
			validDelimiter := MAP (	STD.Str.Contains( fname, 'Delta'	,	true )	=> Mod_Sets.validDelimiterDeltabase,
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
								},filedate,filetime,seq,err,few),filedate,filetime,-err_cnt):ONWARNING(2168,ignore);


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
				string2		FileState;
				string75	FileName;
				string8		FileDate;
				string6		FileTime;
				string1		Accepted;
				unsigned4	RecordsTotal;
				unsigned4	RecordsRejected;
				unsigned4	ErrorCount;
				unsigned4	WarningCount;
				unsigned4	seq;
				string50	field;
				string50	value;
				string50	err;
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
				self.FileDate   :=trim(regexfind('([0-9])+_([0-9])\\w+',fname, 0)[1..8]);
				self.FileTime   :=trim(regexfind('([0-9])+_([0-9])\\w+',fname, 0)[10..15]);
				self.RecordsTotal :=mx;
				self:=l;
			end;

			withRC:=project(seqd,tr0(left));

			r tr1(withRC l, integer c):=transform

				self.field:=choose(c
					,'reported_date'
					,'lexid'
					,'raw_full_name'
					,'raw_First_name'
					,'raw_Last_Name'
					,'SSN'
					,'full_address'
					,'street_1'
					,'City'
					,'State'
					,'Zip'
					,'Drivers_License_Number'
					,'Drivers_License_State'
					);

				self.value:=choose(c
					,l.reported_date
					,l.lexid
					,l.raw_full_name
					,l.raw_First_name
					,l.raw_Last_Name
					,l.SSN
					,l.full_address
					,l.street_1
					,l.City
					,l.State
					,l.Zip
					,l.Drivers_License_Number
					,l.Drivers_License_State
					);

				err_IdentityData:=choose(c
					,if(length(trim(l.reported_date,left,right))=8,'','E002')
					,'' //lexid
					,''	//fullname
					,if(regexreplace('0',l.lexid,'') <>'' or (l.raw_First_name <>'' or l.raw_full_name <>''),'','E001')	
					,if(regexreplace('0',l.lexid,'') <>'' or (l.raw_Last_Name <>'' or l.raw_full_name <>''),'','E001')
					,if( (l.raw_full_name <> '' or (l.raw_First_name <>'' and l.raw_Last_Name <> '')) and 
								(l.SSN <>''	OR	regexreplace('0',l.lexid,'')	<>'' OR	
								(l.Drivers_License_Number<>'' AND	l.Drivers_License_State	<>'')),'','E006')
					,''	//full_address (Deltabase)
					,''	//physical_address (Deltabase)
					,''	//street_1
					,''	//City
					,if(l.street_1 <>'' and 
								if(l.city <>''
									,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) or
											length(trim(l.Zip,left,right)) in [9,5] )
									,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) and
											length(trim(l.Zip,left,right)) in [9,5] )),'','W002')
					,''	//zip
					,'' //Drivers_License_Number
					,'' //Drivers_License_State
					);

				err_KnownFraud:=choose(c
					,if(length(trim(l.reported_date,left,right))=8,'','E002')
					,''	//lexid
					,''	//fullname
					,if(regexreplace('0',l.lexid,'') <>'' or (l.raw_First_name <>'' or l.raw_full_name <>''),'','E001')	
					,if(regexreplace('0',l.lexid,'') <>'' or (l.raw_Last_Name <>'' or l.raw_full_name <>''),'','E001')
					,if( (l.raw_full_name <> '' or (l.raw_First_name <>'' and l.raw_Last_Name <> '')) and 
								(l.SSN <>''	OR	regexreplace('0',l.lexid,'')	<>'' OR	
								(l.Drivers_License_Number<>'' AND	l.Drivers_License_State	<>'')),'','E006')
					,''	//full_address (Deltabase)
					,''	//physical_address (Deltabase)
					,''	//street_1
					,''	//City
					,if(l.street_1 <>'' and 
								if(l.city <>''
									,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) or
											length(trim(l.Zip,left,right)) in [9,5] )
									,((STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States) and
											length(trim(l.Zip,left,right)) in [9,5] )),'','W002')
					,''	//zip
					,'' //Drivers_License_Number
					,'' //Drivers_License_State
					);			

				err_Safelist:=choose(c
					,if(length(trim(l.reported_date,left,right))=8,'','E002')
					,''	//lexid
					,''	//fullname
					,''	//raw_First_name	
					,''	//raw_Last_Name
					,''	//id
					,''	//full_address (Deltabase)
					,''	//physical_address (Deltabase)
					,''	//street_1
					,''	//City
					,''	//Address
					,''	//zip
					,''	//Drivers_License_Number
					,''	//Drivers_License_State
					);		

				err_Deltabase:=choose(c
					,if(length(trim(l.reported_date,left,right))>=8,'','E002')
					,''	//lexid
					,''	//fullname
					,''	//raw_First_name	
					,''	//raw_Last_Name
					,''	//id
					,''	//full_address (Deltabase)
					,''	//physical_address (Deltabase)
					,''	//street_1
					,''	//City
					,''	//Address
					,''	//zip
					,''	//Drivers_License_Number
					,''	//Drivers_License_State
					);											
										
				self.err :=	MAP (
					 STD.Str.Contains( fname, 'Identity'		,	true )	=> err_IdentityData
					,STD.Str.Contains( fname, 'KnownRisk'		,	true )	=> err_KnownFraud
					,STD.Str.Contains( fname, 'Safelist'		,	true )	=> err_Safelist
					,STD.Str.Contains( fname, 'Delta'			,	true )	=> err_Deltabase
					,''	);
									
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

				SHARED DS_KnownFraud		:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
												{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.KnownFraud},
												CSV(separator([pSeparator]),quote(''),terminator(pTerminator)));

				SHARED DS_SafeList			:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
												{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.SafeList},
												CSV(separator([pSeparator]),quote(''),terminator(pTerminator)));
																			
				SHARED DS_DeltaBase			:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
												{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.Deltabase},
												CSV(separator([pSeparator]),quote(''),terminator(pTerminator)));

				Validate_IdentityData := ValidateInputs(	fname, 
					project(DS_IdentityData, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.reported_date := left.Date_of_Transaction; self.lexid := (string20)Left.lexid; SELF := LEFT;SELF := []))).ValidationResults;
																			
				Validate_KnownFraud := ValidateInputs(	fname, 
					project(DS_KnownFraud, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid;SELF := LEFT;SELF := []))).ValidationResults;	

				Validate_SafeList := ValidateInputs(	fname, 
					project(DS_SafeList, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid;SELF := LEFT;SELF := []))).ValidationResults;	

				Validate_Deltabase 	:= 	ValidateInputs(	fname, 
					project(DS_DeltaBase, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid;SELF := LEFT;SELF := []))).ValidationResults;	

				SHARED ErrorsFound	
					:=	MAP (
							 STD.Str.Contains( fname, 'Identity'		,	true )	=> Validate_IdentityData
							,STD.Str.Contains( fname, 'KnownRisk'		,	true )	=> Validate_KnownFraud
							,STD.Str.Contains( fname, 'SafeList'		,	true )	=> Validate_SafeList
							,STD.Str.Contains( fname, 'Delta'		,	true )	=> Validate_Deltabase);
									
				comb:=
							sort(table(ErrorsFound(err<>''),{
									string10 ReportName	:='field'
									,min_seq:=min(group,seq)
									,err_cnt:=count(group)
									,ErrorsFound
									},filedate,filetime,field,value[1],err,few),filedate,filetime,-err_cnt):ONWARNING(2168,ignore);
							;

				comb tr5(comb l) := transform
						treshld_ :=	Mod_Sets.threshld;
						ExcessiveInvalidRecordsFound:=exists(comb(err[1]='E',err_cnt/RecordsTotal>treshld_));
						self.Accepted := if(ExcessiveInvalidRecordsFound,'N','Y');
						self.RecordsRejected :=	0;
						self.ErrorCount :=	sum(comb(err[1]='E'),err_cnt);
						self.WarningCount := sum(comb(err[1]='W'),err_cnt);
						self:=l;

					end;

				EXPORT ValidationResults:=project(comb,tr5(left));
				
				EXPORT RecordsRejected  := 	count(dedup(sort(ErrorsFound(err[1]='E'),Seq),Seq));												
									
	END;
	
	//InquiryLog MBS validation - ONLY DELTABASE!!!
	
	EXPORT ValidateInputWithMBS(string fname, string pSeparator, string pTerminator):= module
		shared infile:=dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,
			FraudGovPlatform.Layouts.Sprayed.Deltabase,CSV(separator([pSeparator]),quote([]),terminator(pTerminator)));
		
		infile_r := record
			infile;
			unsigned1 Deltabase := 1;
		end;
		
		p1 := project(infile, transform(infile_r, self := left;));

		MBS_Layout := Record
			FraudShared.Layouts.Input.MBS;
			unsigned1 Deltabase := 0;
		end;
		MBS	:= project(FraudShared.Files().Input.MBS.sprayed(status = 1), transform(MBS_Layout, self.Deltabase := If(regexfind('DELTA', left.fdn_file_code, nocase),1,0); self := left));
		
		shared DeltabaseMbs 
			:= join(	p1,
						MBS(Deltabase = 1),
						left.Customer_Account_Number =(string)right.gc_id
						and left.Deltabase = right.Deltabase
						,transform({string20 Customer_Account_Number,unsigned4 seq}
						,self.Customer_Account_Number:=left.Customer_Account_Number,
						,self.seq := counter
						,self:=left),left only);
	
		r:=record
			string75	FileName;
			string8		FileDate;
			string6		FileTime;
			string1		Accepted;
			unsigned4	RecordsTotal;
			unsigned4	RecordsRejected;
			unsigned4	ErrorCount;
			unsigned4	WarningCount;
			unsigned4	seq;
			string255	field;
			string255	value;
			string50	err;
			DeltabaseMbs;
		end;


		seqd:=project(DeltabaseMbs
			,transform(r
				,self.seq:=counter
				,self:=left
				,self:=[]));

		mx:=max(seqd,seq);

		r tr0(r l):=transform
			self.FileName :=trim(fname);
			self.FileDate :=regexfind('([0-9])\\w+',fname, 0)[1..8];
			self.FileTime :=regexfind('([0-9])\\w+',fname, 0)[10..15];
			self.RecordsTotal :=count(infile);
			self.ErrorCount :=mx;
			self.RecordsRejected :=mx;
			self.field :='Customer_Account_Number';
			self.value :=trim(l.Customer_Account_Number,left,right);
			self:=l;
		end;

		withRC:=project(seqd,tr0(left));

		comb:=
			sort(table(withRC,{
				string10 ReportName	:='field'
				,min_seq:=min(group,seq)
				,err_cnt:=count(group)
				,withRC
			},filedate,filetime,field,Customer_Account_Number,few),filedate,filetime,-err_cnt):ONWARNING(2168,ignore);

		comb tr5(comb l) := transform
			treshld_ :=	Mod_Sets.threshld;
			ExcessiveInvalidRecordsFound:=l.errorcount/l.RecordsTotal>treshld_;
			self.Accepted := if(ExcessiveInvalidRecordsFound,'N','Y');
			self.RecordsRejected :=	0;
			self.WarningCount := 0;
			self.err :=	'W001';
			self:=l;
			end;

		EXPORT ValidationResults:=project(comb,tr5(left));
		
	END;
END;