IMPORT STD,FraudGovPlatform;
EXPORT Mod_stats := MODULE

	EXPORT ValidateDelimiter(string fname):= module

		infile:=dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,
				{string line},CSV(separator([]),quote([]),terminator(Mod_Sets.validTerminators)));

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
			self.FileState  :=stringlib.stringtouppercase(fname[1..2]);
			self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
			self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
			self.RecordsTotal :=mx;
			self:=l;
		end;

		withRC:=project(seqd,tr0(left));

		r tr1(withRC l, integer c):=transform
			self.err:= if(STD.Str.FindCount( l.line, '~|~' ) = 0,'F1','');
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
				self.ErrorCount			:= 	(sum(dDelimiter(err='F1'),err_cnt)); 
				self.WarningCount:=0;
				self:=l;

			end;

		EXPORT ValidationResults:=project(comb,tr5(left));


END;

	EXPORT ValidateNumberOfColumns(string fname):= module
			infile:=dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,
					{string line},CSV(separator([]),quote([]),terminator('~<EOL>~')));

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
				self.FileState  :=stringlib.stringtouppercase(fname[1..2]);
				self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
				self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
				self.RecordsTotal :=mx;
				self:=l;
			end;

			withRC:=project(seqd,tr0(left));

			numberOfColumns	:=	MAP (
												 STD.Str.Contains( fname, 'IdentityData',	true )	=> Mod_Sets.IdentityData_numberOfColumns
												,STD.Str.Contains( fname, 'KnownFraud'	,	true )	=> Mod_Sets.KnownFraud_numberOfColumns
												,0
									);
									

			r tr1(withRC l, integer c):=transform
				self.err:= if(
					STD.Str.FindCount( l.line, FraudGovPlatform_Validation.Mod_Sets.validDelimiter ) <> numberOfColumns 
					 and STD.Str.FindCount( l.line, FraudGovPlatform_Validation.Mod_Sets.validDelimiter ) 
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
					self.ErrorCount			:= 	(sum(dDelimiter(err='F2'),err_cnt)); 
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
				self.FileState  :=stringlib.stringtouppercase(fname[1..2]);
				self.FileDate   :=regexfind('([0-9])\\w+',fname, 0)[1..8];
				self.FileTime   :=regexfind('([0-9])\\w+',fname, 0)[10..15];
				self.RecordsTotal :=mx;
				self:=l;
			end;

			withRC:=project(seqd,tr0(left));

			r tr1(withRC l, integer c):=transform

				self.field:=choose(c
													,'Customer_Name'
													,'Customer_Account_Number'
													,'Customer_State'
													,'customer_county'
													,'customer_agency'
													,'Customer_Agency_Vertical_Type'
													,'Customer_Program'
													,'Customer_Job_ID'
													,'Batch_Record_ID'
													,'Reason_for_Transaction_Activity'
													,'Date_of_Transaction'
													,'customer_event_id'
													,'reported_date'
													,'reported_time'
													,'reported_by'
													,'lexid'
													,'First_name'
													,'Last_Name'
													,'SSN'
													,'phone_number'
													,'Cell_Phone'
													,'State'
													,'Zip'
													,'Mailing_State'
													,'Mailing_Zip'
													,'Address_Type'
													,'dob'
													,'Drivers_License_Number'
													,'Drivers_License_State'
													);

				self.value:=choose(c
													,l.Customer_Name
													,l.Customer_Account_Number
													,l.Customer_State
													,l.customer_county
													,l.customer_agency
													,l.Customer_Agency_Vertical_Type
													,l.Customer_Program
													,l.Customer_Job_ID
													,l.Batch_Record_ID
													,l.Reason_for_Transaction_Activity
													,l.Date_of_Transaction
													,l.customer_event_id
													,l.reported_date
													,l.reported_time
													,l.reported_by
													,l.lexid
													,l.First_name
													,l.Last_Name
													,l.SSN
													,l.phone_number
													,l.Cell_Phone
													,l.State
													,l.Zip
													,l.Mailing_State
													,l.Mailing_Zip
													,l.Address_Type
													,l.dob
													,l.Drivers_License_Number
													,l.Drivers_License_State
													);

				self.err:=choose(c
							,if(l.Customer_Name 									<>'','','E001')
							,if(l.Customer_Account_Number 				<>'','','E001')
							,if(STD.Str.ToUpperCase(l.Customer_State) 							 in Mod_Sets.States									,'','E003')
							,if(l.Customer_County 								<>'','','E001')
							,if(l.Customer_Agency 								<>'','','E001')
							,if(STD.Str.ToUpperCase(l.Customer_Agency_Vertical_Type) in Mod_Sets.Agency_Vertical_Type		,'','E004')
							,if(STD.Str.Contains( fname, 'IdentityData',	true )
								,if(STD.Str.ToUpperCase(l.Customer_Program) 					 in Mod_Sets.IES_Benefit_Type				,'','E005'),'')
							,if(STD.Str.Contains( fname, 'IdentityData',	true )	
								,if(l.Customer_Job_ID 								<>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'IdentityData',	true )	
								,if(l.Batch_Record_ID 								<>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'IdentityData',	true )		
								,if(l.Reason_for_Transaction_Activity <>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'IdentityData',	true )	
								,if(length(trim(l.Date_of_Transaction,left,right))=8,'','E002'),'')
							,if(STD.Str.Contains( fname, 'KnownFraud',	true )	
								,if(l.customer_event_id 							<>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'KnownFraud',	true )	
								,if(length(trim(l.reported_date,left,right))=8,'','E002'),'')								
							,if(STD.Str.Contains( fname, 'KnownFraud',	true )	
								,if(l.reported_time 									<>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'KnownFraud',	true )
								,if(l.reported_by 										<>'','','E001'),'')
							,'' //lexid
							,if(STD.Str.Contains( fname, 'IdentityData',	true )	
								,if(l.First_name											<>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'IdentityData',	true )
								,if(l.Last_Name												<>'','','E001'),'')
							,if(STD.Str.Contains( fname, 'KnownFraud',	true )
								,if(l.SSN 														<>'' OR
									l.lexid 													<>'' OR
									(l.Drivers_License_Number					<>'' AND
									 l.Drivers_License_State					<>''),'','E006'),'')
							,if(l.phone_number 	<> '' and length(trim(l.phone_number,left,right))	=10										,'','W002')
							,if(l.Cell_Phone 		<> '' and length(trim(l.Cell_Phone,left,right))		=10										,'','W002')
							,if(STD.Str.ToUpperCase(l.State) <> '' and l.State in Mod_Sets.States												,'','W005')
							,map(l.Zip[1..4]='0000' and l.Zip[5]<>'0'  																								=>'W004'
									,length(trim(l.Zip,left,right))not in [9,5] 																					=>'W004'
									,'')
							,if(STD.Str.ToUpperCase(l.Mailing_State) <> '' and l.State in Mod_Sets.States								,'','W005')		
							,map(l.Mailing_Zip[1..4]='0000' and l.Mailing_Zip[5]<>'0'  																=>'W004'
									,length(trim(l.Zip,left,right))not in [9,5] 																					=>'W004'
									,'')		
							,if(l.Address_Type 	<> '' and STD.Str.ToUpperCase(l.Address_Type) in Mod_Sets.Address_Type	,'','W006')
							,if(l.dob 					<> '' and length(trim(l.dob,left,right))=8															,'','W003')
							,'' //Drivers_License_Number
							,'' //Drivers_License_State
							);
				self:=l;
			end;

			Shared err1:=normalize(withRC,29,tr1(left,counter));

			output(err1);
			
			EXPORT ValidationResults := err1;

	END;

	
	EXPORT ValidateInputFields(string fname):= module


				SHARED DS_IdentityData		:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
																			{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.IdentityData},
																			CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')));


				SHARED DS_KnownFraud			:= dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname,
																			{string75 fn { virtual(logicalfilename)},FraudGovPlatform.Layouts.Sprayed.KnownFraud},
																			CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')));

				Validate_IdentityData := 	ValidateInputs(	fname, 
																	project(DS_IdentityData, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid; SELF := LEFT;SELF := []))).ValidationResults;
																			
				Validate_KnownFraud 	:= 	ValidateInputs(	fname, 
																	project(DS_KnownFraud, TRANSFORM(FraudGovPlatform.Layouts.Sprayed.validate_record,self.lexid := (string20)Left.lexid;SELF := LEFT;SELF := []))).ValidationResults;	

				SHARED ErrorsFound	:=	MAP (
												 STD.Str.Contains( fname, 'IdentityData',	true )	=> Validate_IdentityData
												,STD.Str.Contains( fname, 'KnownFraud'	,	true )	=> Validate_KnownFraud
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
END;