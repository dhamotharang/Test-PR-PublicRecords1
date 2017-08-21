EXPORT Mod_stats := MODULE

EXPORT BenefitMonthCnt():=function

	RETURN sort(table(NAC_V2.Files().Base,{
																Case_Benefit_Month
																,AL:=sum(group,if(Case_State_Abbreviation='AL',1,0))
																,FL:=sum(group,if(Case_State_Abbreviation='FL',1,0))
																,GA:=sum(group,if(Case_State_Abbreviation='GA',1,0))
																,LA:=sum(group,if(Case_State_Abbreviation='LA',1,0))
																,MS:=sum(group,if(Case_State_Abbreviation='MS',1,0))
																}
																,Case_Benefit_Month
																,few)
																,Case_Benefit_Month)
																;
END;

EXPORT colPerState(exp1='true'):=functionmacro
	d:=NAC_V2.files().Collisions(#expand(exp1));
	t1:=table(d,{
							Priority:=pri
							,Match_Set:=matchset
							,Benefit_Month:=SearchBenefitMonth
							,State1:=BenefitState
							,State2:=CaseState
							,Same_State:=BenefitState=CaseState
							,Collisions_Per_Record:=count(group)
							}
							,matchset
							,SearchSequenceNumber
							,SearchBenefitMonth
							,BenefitState
							,CaseState
							,few
					);

	tPerState:=table(t1,{
							Priority
							,Match_Set
							,State1
							,Benefit_Month
							,State2
							,Same_State
							,Collisions_Per_Record
							,Collisions_Per_State:=count(group)
							}
							,Match_Set
							,State1
							,Benefit_Month
							,State2
							,Same_State
							,Collisions_Per_Record
							,few
					);

	tPerState2:=table(tPerState,{
							Priority
							,Match_Set
							,State1
							,Benefit_Month
							,State2
							,Same_State
							,Collisions_Per_Record
							,Collisions_Per_State
							,All_Combined:=(integer)(Collisions_Per_Record * Collisions_Per_State)
							}
					);

	col_per_state:=tPerState2;

	RETURN col_per_state;
ENDMACRO;

EXPORT ValidateInputFields(string fname):= module

//SHARED infile:=dataset('~nac::in::'+fname,{string75 fn { virtual(logicalfilename)},NAC_V2.Layouts.load},flat);
SHARED infile:=dataset(fname,{string75 fn { virtual(logicalfilename)},NAC_V2.Layouts.load},flat);

SHARED r:=record
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
	string50 field;
	string50 value;
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
	self.FileDate   :=fname[8..15];
	self.FileTime   :=fname[17..22];
	self.RecordsTotal :=mx;
	self:=l;
end;

SHARED withRC:=project(seqd,tr0(left));

r tr1(withRC l, integer c):=transform

	self.field:=choose(c
										,'Case_State_Abbreviation'
										,'Case_Benefit_Type'
										,'Case_Benefit_Month'
										,'Case_Identifier'
										,'Case_Last_Name'
										,'Case_First_Name'
										,'Case_Middle_Name'
										,'Case_Phone_1'
										,'Case_Phone_2'
										,'Case_Email'
										,'Case_Physical_Address_Street_1'
										,'Case_Physical_Address_Street_2'
										,'Case_Physical_Address_City'
										,'Case_Physical_Address_State'
										,'Case_Physical_Address_Zip'
										,'Case_Mailing_Address_Street_1'
										,'Case_Mailing_Address_Street_2'
										,'Case_Mailing_Address_City'
										,'Case_Mailing_Address_State'
										,'Case_Mailing_Address_Zip'
										,'Case_County_Parish_Code'
										,'Case_County_Parish_Name'
										,'Client_Identifier'
										,'Client_Last_Name'
										,'Client_First_Name'
										,'Client_Middle_Name'
										,'Client_Gender'
										,'Client_Race'
										,'Client_Ethnicity'
										,'Client_SSN'
										,'Client_SSN_Type_Indicator'
										,'Client_DOB'
										,'Client_DOB_Type_Indicator'
										,'Client_Eligible_Status_Indicator'
										,'Client_Eligible_Status_Date'
										,'Client_Phone'
										);

	self.value:=choose(c
										,l.Case_State_Abbreviation
										,l.Case_Benefit_Type
										,l.Case_Benefit_Month
										,l.Case_Identifier
										,l.Case_Last_Name
										,l.Case_First_Name
										,l.Case_Middle_Name
										,l.Case_Phone_1
										,l.Case_Phone_2
										,l.Case_Email
										,l.Case_Physical_Address_Street_1
										,l.Case_Physical_Address_Street_2
										,l.Case_Physical_Address_City
										,l.Case_Physical_Address_State
										,l.Case_Physical_Address_Zip
										,l.Case_Mailing_Address_Street_1
										,l.Case_Mailing_Address_Street_2
										,l.Case_Mailing_Address_City
										,l.Case_Mailing_Address_State
										,l.Case_Mailing_Address_Zip
										,l.Case_County_Parish_Code
										,l.Case_County_Parish_Name
										,l.Client_Identifier
										,l.Client_Last_Name
										,l.Client_First_Name
										,l.Client_Middle_Name
										,l.Client_Gender
										,l.Client_Race
										,l.Client_Ethnicity
										,l.Client_SSN
										,l.Client_SSN_Type_Indicator
										,l.Client_DOB
										,l.Client_DOB_Type_Indicator
										,l.Client_Eligible_Status_Indicator
										,l.Client_Eligible_Status_Date
										,l.Client_Phone
										);

	self.err:=choose(c
				// case_state_abbreviation
				,if(l.case_state_abbreviation in NAC_V2.Mod_Sets.Consortium,'','E006')
				// Case_Benefit_Type
				,if(l.Case_Benefit_Type in NAC_V2.Mod_Sets.Benefit_Type,'','E015')
				// Case_Benefit_Month
				,map((unsigned)l.Case_Benefit_Month=0  => 'E007'
					  ,(unsigned)l.Case_Benefit_Month>0 and length(trim(l.Case_Benefit_Month,left,right))<>6 => 'E014'
						,'')
				// Case_Identifier
				,if(l.Case_Identifier<>'','','E001')
				// Case_Last_Name
				,if(l.Case_Last_Name<>'','','E005')
				// Case_First_Name
				,if(l.Case_First_Name<>'','','E004')
				// Case_Middle_Name
				,''
				// Case_Phone_1
				,if(length(trim(l.Case_Phone_1,left,right))=10,'','W003')
				// Case_Phone_2
				,if(length(trim(l.Case_Phone_2,left,right))=10,'','W003')
				// Case_Email
				,''

				// Case_Physical_Address_Street_1
				,map(l.Case_Physical_Address_Street_1=''
							or trim(regexreplace(NAC_V2.Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(l.Case_Physical_Address_Street_1),'$2',nocase)) in NAC_V2.Mod_Sets.SetBadAddress
									=> 'W003'
							,l.Case_Physical_Address_Street_1[1]='0'
									=> 'W004'
							,'')
				// Case_Physical_Address_Street_2
				,''
				// Case_Physical_Address_City
				,if(l.Case_Physical_Address_City<>'','','W003')
				// Case_Physical_Address_State
				,if(l.Case_Physical_Address_State in NAC_V2.Mod_Sets.States,'','W003')
				// Case_Physical_Address_Zip
				,map(l.Case_Physical_Address_Zip[1..4]='0000' and l.Case_Physical_Address_Zip[5]<>'0'  => 'W003'
					  ,length(trim(l.Case_Physical_Address_Zip,left,right))<>9 => 'W003'
						,'')
				// Case_Mailing_Address_Street_1
				,map(l.Case_Mailing_Address_Street_1=''
							or trim(regexreplace(NAC_V2.Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(l.Case_Mailing_Address_Street_1),'$2',nocase)) in NAC_V2.Mod_Sets.SetBadAddress
									=> 'W003'
							,l.Case_Mailing_Address_Street_1[1]='0'
									=> 'W004'
							,'')
				// Case_Mailing_Address_Street_2
				,''
				// Case_Mailing_Address_City
				,if(l.Case_Mailing_Address_City<>'','','W003')
				// Case_Mailing_Address_State
				,if(l.Case_Mailing_Address_State in NAC_V2.Mod_Sets.States,'','W003')
				// Case_Mailing_Address_Zip
				,map(l.Case_Mailing_Address_Zip[1..4]='0000' and l.Case_Mailing_Address_Zip[5]<>'0'  => 'W003'
					  ,length(trim(l.Case_Mailing_Address_Zip,left,right))<>9 => 'W003'
						,'')
				// Case_County_Parish_Code
				,''
				// Case_County_Parish_Name
				,''

				// Client_Identifier
				,if(l.Client_Identifier<>'','','E002')
				// Client_Last_Name
				,if(l.Client_Last_Name<>'','','E005')
				// Client_First_Name
				,if(l.Client_First_Name<>'','','E004')
				// Client_Middle_Name
				,''
				// Client_Gender
				,if(l.Client_Gender in NAC_V2.Mod_Sets.Gender,'','W003')
				// Client_Race
				,if(l.Client_Race in NAC_V2.Mod_Sets.Race,'','W003')
				// Client_Ethnicity
				,if(l.Client_Ethnicity in NAC_V2.Mod_Sets.Ethnicity,'','W003')
				// Client_SSN
				,if(l.Client_SSN_Type_Indicator=NAC_V2.Mod_Sets.Actual_Type and length(regexreplace('[^0-9]',l.Client_SSN,''))<>9,'W003','')
				// Client_SSN_Type_Indicator
				,if(l.Client_SSN_Type_Indicator in NAC_V2.Mod_Sets.SSN_Type,'','W003')
				// Client_DOB
				,if(length(trim(l.Client_DOB,left,right))=8,'','W003')
				// Client_DOB_Type_Indicator
				,if(l.Client_DOB_Type_Indicator in NAC_V2.Mod_Sets.DOB_Type,'','W003')
				// Client_Eligible_Status_Indicator
				,if(l.Client_Eligible_Status_Indicator in NAC_V2.Mod_Sets.Eligible_Status,'','W003')
				// Client_Eligible_Status_Date
				,if((unsigned)l.Client_Eligible_Status_Date>0 and length(trim(l.Client_Eligible_Status_Date,left,right))=8,'','W003')
				// Client_Phone
				,if(length(trim(l.Client_Phone,left,right))=10,'','W003')
				);
	self:=l;
end;

SHARED err1:=normalize(withRC,36,tr1(left,counter));

r tr2(r l,integer c):=transform

	self.err:=choose(c
				// Address
				,map(//an address may be usable if:
					// a) street1 is not blank or poor
						(l.Case_Physical_Address_Street_1=''
						or trim(regexreplace(NAC_V2.Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(l.Case_Physical_Address_Street_1),'$2',nocase)) in NAC_V2.Mod_Sets.SetBadAddress
					 // b.1) we either have a city and state
						or	(  (l.Case_Physical_Address_City='' or l.Case_Physical_Address_State not in NAC_V2.Mod_Sets.States)
					 // b.2) or zip
								and ((unsigned)l.Case_Physical_Address_Zip=0
										or length(trim(l.Case_Physical_Address_Zip,left,right))<>9
										or (l.Case_Physical_Address_Zip[1..4]='0000' and l.Case_Physical_Address_Zip[5]<>'0'))
								)
						)
						and
					// a) street1 is not blank or poor
						(l.Case_Mailing_Address_Street_1=''
						or trim(regexreplace(NAC_V2.Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(l.Case_Mailing_Address_Street_1),'$2',nocase)) in NAC_V2.Mod_Sets.SetBadAddress
					 // b.1) we either have a city and state
						or	(  (l.Case_Mailing_Address_City='' or l.Case_Mailing_Address_State not in NAC_V2.Mod_Sets.States)
					 // b.2) or zip
								and ((unsigned)l.Case_Mailing_Address_Zip=0
										or length(trim(l.Case_Mailing_Address_Zip,left,right))<>9
										or (l.Case_Mailing_Address_Zip[1..4]='0000' and l.Case_Mailing_Address_Zip[5]<>'0'))
								)
						)
																													=> 'E003'
						,l.Case_Physical_Address_Street_1=''
						or trim(regexreplace(NAC_V2.Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(l.Case_Physical_Address_Street_1),'$2',nocase)) in NAC_V2.Mod_Sets.SetBadAddress
						or	(  (l.Case_Physical_Address_City='' or l.Case_Physical_Address_State not in NAC_V2.Mod_Sets.States)
								and ((unsigned)l.Case_Physical_Address_Zip=0
										or length(trim(l.Case_Physical_Address_Zip,left,right))<>9
										or (l.Case_Physical_Address_Zip[1..4]='0000' and l.Case_Physical_Address_Zip[5]<>'0'))
								)
																													 => 'W001'
						,l.Case_Mailing_Address_Street_1=''
						or trim(regexreplace(NAC_V2.Mod_Sets.RegexBadAddress,StringLib.StringCleanSpaces(l.Case_Mailing_Address_Street_1),'$2',nocase)) in NAC_V2.Mod_Sets.SetBadAddress
						or	(  (l.Case_Mailing_Address_City='' or l.Case_Mailing_Address_State not in NAC_V2.Mod_Sets.States)
								and ((unsigned)l.Case_Mailing_Address_Zip=0
										or length(trim(l.Case_Mailing_Address_Zip,left,right))<>9
										or (l.Case_Mailing_Address_Zip[1..4]='0000' and l.Case_Mailing_Address_Zip[5]<>'0'))
								)
																													 => 'W002'
						,'')

				// Client_SSN Client_SSN_Type_Indicator
				,map(l.Client_SSN_Type_Indicator = NAC_V2.Mod_Sets.Actual_Type
							and ((unsigned)l.Client_SSN=0 or length(trim(l.Client_SSN,left,right))<>9)
								=> 'E010'
						,l.Client_SSN_Type_Indicator not in NAC_V2.Mod_Sets.SSN_Type
							and (unsigned)l.Client_SSN>0 and length(trim(l.Client_SSN,left,right))=9
								=> 'E011'
						,'')

				// Client_DOB Client_DOB_Type_Indicator
				,map(l.Client_DOB_Type_Indicator = NAC_V2.Mod_Sets.Actual_Type
							and ((unsigned)l.Client_DOB=0 or length(trim(l.Client_DOB,left,right))<>8)
								=> 'E012'
						,l.Client_DOB_Type_Indicator not in NAC_V2.Mod_Sets.DOB_Type
							and (unsigned)l.Client_DOB>0 and length(trim(l.Client_DOB,left,right))=8
								=> 'E013'
						,'')

				// Client_Eligible_Status_Indicator Client_Eligible_Status_Date
				,map(l.Client_Eligible_Status_Indicator in NAC_V2.Mod_Sets.Eligible_Status
							and ((unsigned)l.Client_Eligible_Status_Date=0 or length(trim(l.Client_Eligible_Status_Date,left,right))<>8)
								=> 'W008'
						,l.Client_Eligible_Status_Indicator not in NAC_V2.Mod_Sets.Eligible_Status
							and (unsigned)l.Client_Eligible_Status_Date>0 and length(trim(l.Client_Eligible_Status_Date,left,right))=8
								=> 'W009'
						,'')
				);

	self.value:=choose(c
										,map(self.err='E003' => trim(l.Case_Physical_Address_Street_1[1..10])+'/'+trim(l.Case_Physical_Address_Zip[1..5])+'-'+
																						 trim(l.Case_Mailing_Address_Street_1[1..10])+'/'+trim(l.Case_Mailing_Address_Zip[1..5])
												,self.err='W001' => '-'+trim(l.Case_Physical_Address_Street_1[1..10])+'/'+trim(l.Case_Physical_Address_Zip[1..5])+'-'
												,self.err='W002' => '-'+trim(l.Case_Mailing_Address_Street_1[1..10])+'/'+trim(l.Case_Mailing_Address_Zip[1..5])+'-'
												,'')
										,'-'+trim(l.Client_SSN_Type_Indicator)+'/'+trim(l.Client_SSN)+'-'
										,'-'+trim(l.Client_DOB_Type_Indicator)+'/'+trim(l.Client_DOB)+'-'
										,'-'+trim(l.Client_Eligible_Status_Indicator)+'/'+trim(l.Client_Eligible_Status_Date)+'-'
										);

	self.field:=choose(c
										,map(self.err='E003' => 'PHY/Z-MAI/Z'
												,self.err='W001' => 'PHY/Z'
												,self.err='W002' => 'MAI/Z'
												,'')
										,'TYP/SSN'
										,'TYP/DOB'
										,'IND/DTE'
										);

	self:=l;
end;

SHARED err2:=normalize(withRC,4,tr2(left,counter));

comb:=
			sort(table(err1(err<>''),{
					string10 ReportName	:='field'
					,min_seq:=min(group,seq)
					,err_cnt:=count(group)
					,err1
					},filedate,filetime,field,value[1],err,few),filedate,filetime,-err_cnt)
			+
			sort(table(err2(err<>''),{
					string10 ReportName	:='record'
					,min_seq:=min(group,seq)
					,err_cnt:=count(group)
					,err2
					},filedate,filetime,field,value[1],err,few),filedate,filetime,-err_cnt)
			;


	comb tr5(comb l) := transform
		dField:=comb(ReportName='field');
		dRecord:=comb(ReportName='record');
		treshld_:=Mod_Sets.threshld;
		ExcessiveInvalidRecordsFound:=exists(   dField(err[1]='E',err_cnt/RecordsTotal>treshld_)
																					+ dRecord(err[1]='E',err_cnt/RecordsTotal>treshld_));

		self.Accepted:=if(ExcessiveInvalidRecordsFound,'N','Y');
		self.RecordsRejected:=0;
		self.ErrorCount:=(sum(dField(err[1]='E'),err_cnt)+sum(dRecord(err[1]='E'),err_cnt));
		self.WarningCount:=(sum(dField(err[1]='W'),err_cnt)+sum(dRecord(err[1]='W'),err_cnt));
		self:=l;

	end;

EXPORT ValidationResults:=project(comb,tr5(left));

SHARED stats:=if(exists(ValidationResults)
										,ValidationResults
										,project(WithRC
												,transform({ValidationResults}
													,self.ReportName:='field'
													,self.min_seq:=0
													,self.err_cnt:=0
													,self.Accepted:='Y'
													,self:=left
												)));

EXPORT FileName         := if(exists(stats),stats[1].FileName,fname);
EXPORT FileState        := if(exists(stats),stats[1].FileState,stringlib.stringtouppercase(fname[1..2]));
EXPORT FileDate         := if(exists(stats),stats[1].FileDate,fname[8..15]);
EXPORT FileTime         := if(exists(stats),stats[1].FileTime,fname[17..22]);
EXPORT Accepted         := if(exists(stats),stats[1].Accepted,'Y');
EXPORT RecordsTotal     := if(exists(stats),stats[1].RecordsTotal,0);

CriticalFieldError			:= [
														'Case_State_Abbreviation'
														,'Case_Benefit_Type'
														,'Case_Benefit_Month'
														,'Case_Identifier'
														,'Case_Last_Name'
														,'Case_First_Name'
														,'Client_Identifier'
														,'Client_Last_Name'
														,'Client_First_Name'
														];
EXPORT RecordsRejected  := if(exists(stats)
																		,count(
																				dedup(
																							sort(
																										(
																											err1(err[1]='E',field in CriticalFieldError)
																										+ err2(err[1]='E',field in CriticalFieldError)
																										)
																									,Seq)
																								,Seq)
																					)
																		,0);
EXPORT ErrorCount       := if(exists(stats),stats[1].ErrorCount,0);
EXPORT WarningCount     := if(exists(stats),stats[1].WarningCount,0);

END;


EXPORT Population(exp1='true'):=functionmacro
	d:=NAC_V2.files().base;//(#expand(exp1));
	tFieldPopulation
		:=table(d,{
				case_state_abbreviation
				,case_benefit_month
				,total:=count(group)
				,LexID_count:=sum(group,if(did>0,1,0))
				,FileName_nonblank_count:=sum(group,if(FileName<>'',1,0))
				,FileName_nonblank_percent:=sum(group,if(FileName<>'',1,0))/count(group)
				,case_id_nonblank_count:=sum(group,if(case_id>0,1,0))
				,case_id_nonblank_percent:=sum(group,if(case_id>0,1,0))/count(group)
				,case_state_abbreviation_nonblank_count:=sum(group,if(case_state_abbreviation<>'',1,0))
				,case_state_abbreviation_nonblank_percent:=sum(group,if(case_state_abbreviation<>'',1,0))/count(group)
				,case_benefit_type_nonblank_count:=sum(group,if(case_benefit_type<>'',1,0))
				,case_benefit_type_nonblank_percent:=sum(group,if(case_benefit_type<>'',1,0))/count(group)
				,case_benefit_month_nonblank_count:=sum(group,if(case_benefit_month<>'',1,0))
				,case_benefit_month_nonblank_percent:=sum(group,if(case_benefit_month<>'',1,0))/count(group)
				,case_identifier_nonblank_count:=sum(group,if(case_identifier<>'',1,0))
				,case_identifier_nonblank_percent:=sum(group,if(case_identifier<>'',1,0))/count(group)
				,case_last_name_nonblank_count:=sum(group,if(case_last_name<>'',1,0))
				,case_last_name_nonblank_percent:=sum(group,if(case_last_name<>'',1,0))/count(group)
				,case_first_name_nonblank_count:=sum(group,if(case_first_name<>'',1,0))
				,case_first_name_nonblank_percent:=sum(group,if(case_first_name<>'',1,0))/count(group)
				,case_middle_name_nonblank_count:=sum(group,if(case_middle_name<>'',1,0))
				,case_middle_name_nonblank_percent:=sum(group,if(case_middle_name<>'',1,0))/count(group)
				,case_phone_1_nonblank_count:=sum(group,if(case_phone_1<>'',1,0))
				,case_phone_1_nonblank_percent:=sum(group,if(case_phone_1<>'',1,0))/count(group)
				,case_phone_2_nonblank_count:=sum(group,if(case_phone_2<>'',1,0))
				,case_phone_2_nonblank_percent:=sum(group,if(case_phone_2<>'',1,0))/count(group)
				,case_email_nonblank_count:=sum(group,if(case_email<>'',1,0))
				,case_email_nonblank_percent:=sum(group,if(case_email<>'',1,0))/count(group)
				,case_physical_address_street_1_nonblank_count:=sum(group,if(case_physical_address_street_1<>'',1,0))
				,case_physical_address_street_1_nonblank_percent:=sum(group,if(case_physical_address_street_1<>'',1,0))/count(group)
				,case_physical_address_street_2_nonblank_count:=sum(group,if(case_physical_address_street_2<>'',1,0))
				,case_physical_address_street_2_nonblank_percent:=sum(group,if(case_physical_address_street_2<>'',1,0))/count(group)
				,case_physical_address_city_nonblank_count:=sum(group,if(case_physical_address_city<>'',1,0))
				,case_physical_address_city_nonblank_percent:=sum(group,if(case_physical_address_city<>'',1,0))/count(group)
				,case_physical_address_state_nonblank_count:=sum(group,if(case_physical_address_state<>'',1,0))
				,case_physical_address_state_nonblank_percent:=sum(group,if(case_physical_address_state<>'',1,0))/count(group)
				,case_physical_address_zip_nonblank_count:=sum(group,if(case_physical_address_zip<>'',1,0))
				,case_physical_address_zip_nonblank_percent:=sum(group,if(case_physical_address_zip<>'',1,0))/count(group)
				,case_mailing_address_street_1_nonblank_count:=sum(group,if(case_mailing_address_street_1<>'',1,0))
				,case_mailing_address_street_1_nonblank_percent:=sum(group,if(case_mailing_address_street_1<>'',1,0))/count(group)
				,case_mailing_address_street_2_nonblank_count:=sum(group,if(case_mailing_address_street_2<>'',1,0))
				,case_mailing_address_street_2_nonblank_percent:=sum(group,if(case_mailing_address_street_2<>'',1,0))/count(group)
				,case_mailing_address_city_nonblank_count:=sum(group,if(case_mailing_address_city<>'',1,0))
				,case_mailing_address_city_nonblank_percent:=sum(group,if(case_mailing_address_city<>'',1,0))/count(group)
				,case_mailing_address_state_nonblank_count:=sum(group,if(case_mailing_address_state<>'',1,0))
				,case_mailing_address_state_nonblank_percent:=sum(group,if(case_mailing_address_state<>'',1,0))/count(group)
				,case_mailing_address_zip_nonblank_count:=sum(group,if(case_mailing_address_zip<>'',1,0))
				,case_mailing_address_zip_nonblank_percent:=sum(group,if(case_mailing_address_zip<>'',1,0))/count(group)
				,case_county_parish_code_nonblank_count:=sum(group,if(case_county_parish_code<>'',1,0))
				,case_county_parish_code_nonblank_percent:=sum(group,if(case_county_parish_code<>'',1,0))/count(group)
				,case_county_parish_name_nonblank_count:=sum(group,if(case_county_parish_name<>'',1,0))
				,case_county_parish_name_nonblank_percent:=sum(group,if(case_county_parish_name<>'',1,0))/count(group)
				,client_identifier_nonblank_count:=sum(group,if(client_identifier<>'',1,0))
				,client_identifier_nonblank_percent:=sum(group,if(client_identifier<>'',1,0))/count(group)
				,client_last_name_nonblank_count:=sum(group,if(client_last_name<>'',1,0))
				,client_last_name_nonblank_percent:=sum(group,if(client_last_name<>'',1,0))/count(group)
				,client_first_name_nonblank_count:=sum(group,if(client_first_name<>'',1,0))
				,client_first_name_nonblank_percent:=sum(group,if(client_first_name<>'',1,0))/count(group)
				,client_middle_name_nonblank_count:=sum(group,if(client_middle_name<>'',1,0))
				,client_middle_name_nonblank_percent:=sum(group,if(client_middle_name<>'',1,0))/count(group)
				,client_gender_nonblank_count:=sum(group,if(client_gender<>'',1,0))
				,client_gender_nonblank_percent:=sum(group,if(client_gender<>'',1,0))/count(group)
				,client_race_nonblank_count:=sum(group,if(client_race<>'',1,0))
				,client_race_nonblank_percent:=sum(group,if(client_race<>'',1,0))/count(group)
				,client_ethnicity_nonblank_count:=sum(group,if(client_ethnicity<>'',1,0))
				,client_ethnicity_nonblank_percent:=sum(group,if(client_ethnicity<>'',1,0))/count(group)
				,client_ssn_nonblank_count:=sum(group,if(client_ssn<>'',1,0))
				,client_ssn_nonblank_percent:=sum(group,if(client_ssn<>'',1,0))/count(group)
				,client_ssn_type_indicator_nonblank_count:=sum(group,if(client_ssn_type_indicator<>'',1,0))
				,client_ssn_type_indicator_nonblank_percent:=sum(group,if(client_ssn_type_indicator<>'',1,0))/count(group)
				,client_dob_nonblank_count:=sum(group,if(client_dob<>'',1,0))
				,client_dob_nonblank_percent:=sum(group,if(client_dob<>'',1,0))/count(group)
				,client_dob_type_indicator_nonblank_count:=sum(group,if(client_dob_type_indicator<>'',1,0))
				,client_dob_type_indicator_nonblank_percent:=sum(group,if(client_dob_type_indicator<>'',1,0))/count(group)
				,client_eligible_status_indicator_nonblank_count:=sum(group,if(client_eligible_status_indicator<>'',1,0))
				,client_eligible_status_indicator_nonblank_percent:=sum(group,if(client_eligible_status_indicator<>'',1,0))/count(group)
				,client_eligible_status_date_nonblank_count:=sum(group,if(client_eligible_status_date<>'',1,0))
				,client_eligible_status_date_nonblank_percent:=sum(group,if(client_eligible_status_date<>'',1,0))/count(group)
				,client_phone_nonblank_count:=sum(group,if(client_phone<>'',1,0))
				,client_phone_nonblank_percent:=sum(group,if(client_phone<>'',1,0))/count(group)
				,client_email_nonblank_count:=sum(group,if(client_email<>'',1,0))
				,client_email_nonblank_percent:=sum(group,if(client_email<>'',1,0))/count(group)
				,state_contact_name_nonblank_count:=sum(group,if(state_contact_name<>'',1,0))
				,state_contact_name_nonblank_percent:=sum(group,if(state_contact_name<>'',1,0))/count(group)
				,state_contact_phone_nonblank_count:=sum(group,if(state_contact_phone<>'',1,0))
				,state_contact_phone_nonblank_percent:=sum(group,if(state_contact_phone<>'',1,0))/count(group)
				,state_contact_phone_extension_nonblank_count:=sum(group,if(state_contact_phone_extension<>'',1,0))
				,state_contact_phone_extension_nonblank_percent:=sum(group,if(state_contact_phone_extension<>'',1,0))/count(group)
				,state_contact_email_nonblank_count:=sum(group,if(state_contact_email<>'',1,0))
				,state_contact_email_nonblank_percent:=sum(group,if(state_contact_email<>'',1,0))/count(group)
				,prepped_name_nonblank_count:=sum(group,if(prepped_name<>'',1,0))
				,prepped_name_nonblank_percent:=sum(group,if(prepped_name<>'',1,0))/count(group)
				,prepped_addr1_nonblank_count:=sum(group,if(prepped_addr1<>'',1,0))
				,prepped_addr1_nonblank_percent:=sum(group,if(prepped_addr1<>'',1,0))/count(group)
				,prepped_addr2_nonblank_count:=sum(group,if(prepped_addr2<>'',1,0))
				,prepped_addr2_nonblank_percent:=sum(group,if(prepped_addr2<>'',1,0))/count(group)
				,did_nonblank_count:=sum(group,if(did>0,1,0))
				,did_nonblank_percent:=sum(group,if(did>0,1,0))/count(group)
				,did_score_nonblank_count:=sum(group,if(did_score>0,1,0))
				,did_score_nonblank_percent:=sum(group,if(did_score>0,1,0))/count(group)
				,processdate_nonblank_count:=sum(group,if(processdate>0,1,0))
				,processdate_nonblank_percent:=sum(group,if(processdate>0,1,0))/count(group)
				,ncf_filedate_nonblank_count:=sum(group,if(ncf_filedate>0,1,0))
				,ncf_filedate_nonblank_percent:=sum(group,if(ncf_filedate>0,1,0))/count(group)
				,preprecseq_nonblank_count:=sum(group,if(preprecseq>0,1,0))
				,preprecseq_nonblank_percent:=sum(group,if(preprecseq>0,1,0))/count(group)
				,clean_ssn_nonblank_count:=sum(group,if(clean_ssn<>'',1,0))
				,clean_ssn_nonblank_percent:=sum(group,if(clean_ssn<>'',1,0))/count(group)
				,best_ssn_nonblank_count:=sum(group,if(best_ssn<>'',1,0))
				,best_ssn_nonblank_percent:=sum(group,if(best_ssn<>'',1,0))/count(group)
				,clean_dob_nonblank_count:=sum(group,if(clean_dob>0,1,0))
				,clean_dob_nonblank_percent:=sum(group,if(clean_dob>0,1,0))/count(group)
				,age_nonblank_count:=sum(group,if(age>0,1,0))
				,age_nonblank_percent:=sum(group,if(age>0,1,0))/count(group)
				,best_dob_nonblank_count:=sum(group,if(best_dob>0,1,0))
				,best_dob_nonblank_percent:=sum(group,if(best_dob>0,1,0))/count(group)
				,title_nonblank_count:=sum(group,if(title<>'',1,0))
				,title_nonblank_percent:=sum(group,if(title<>'',1,0))/count(group)
				,fname_nonblank_count:=sum(group,if(fname<>'',1,0))
				,fname_nonblank_percent:=sum(group,if(fname<>'',1,0))/count(group)
				,mname_nonblank_count:=sum(group,if(mname<>'',1,0))
				,mname_nonblank_percent:=sum(group,if(mname<>'',1,0))/count(group)
				,lname_nonblank_count:=sum(group,if(lname<>'',1,0))
				,lname_nonblank_percent:=sum(group,if(lname<>'',1,0))/count(group)
				,name_suffix_nonblank_count:=sum(group,if(name_suffix<>'',1,0))
				,name_suffix_nonblank_percent:=sum(group,if(name_suffix<>'',1,0))/count(group)
				,prim_range_nonblank_count:=sum(group,if(prim_range<>'',1,0))
				,prim_range_nonblank_percent:=sum(group,if(prim_range<>'',1,0))/count(group)
				,predir_nonblank_count:=sum(group,if(predir<>'',1,0))
				,predir_nonblank_percent:=sum(group,if(predir<>'',1,0))/count(group)
				,prim_name_nonblank_count:=sum(group,if(prim_name<>'',1,0))
				,prim_name_nonblank_percent:=sum(group,if(prim_name<>'',1,0))/count(group)
				,addr_suffix_nonblank_count:=sum(group,if(addr_suffix<>'',1,0))
				,addr_suffix_nonblank_percent:=sum(group,if(addr_suffix<>'',1,0))/count(group)
				,postdir_nonblank_count:=sum(group,if(postdir<>'',1,0))
				,postdir_nonblank_percent:=sum(group,if(postdir<>'',1,0))/count(group)
				,unit_desig_nonblank_count:=sum(group,if(unit_desig<>'',1,0))
				,unit_desig_nonblank_percent:=sum(group,if(unit_desig<>'',1,0))/count(group)
				,sec_range_nonblank_count:=sum(group,if(sec_range<>'',1,0))
				,sec_range_nonblank_percent:=sum(group,if(sec_range<>'',1,0))/count(group)
				,p_city_name_nonblank_count:=sum(group,if(p_city_name<>'',1,0))
				,p_city_name_nonblank_percent:=sum(group,if(p_city_name<>'',1,0))/count(group)
				,v_city_name_nonblank_count:=sum(group,if(v_city_name<>'',1,0))
				,v_city_name_nonblank_percent:=sum(group,if(v_city_name<>'',1,0))/count(group)
				,st_nonblank_count:=sum(group,if(st<>'',1,0))
				,st_nonblank_percent:=sum(group,if(st<>'',1,0))/count(group)
				,zip_nonblank_count:=sum(group,if(zip<>'',1,0))
				,zip_nonblank_percent:=sum(group,if(zip<>'',1,0))/count(group)
				,zip4_nonblank_count:=sum(group,if(zip4<>'',1,0))
				,zip4_nonblank_percent:=sum(group,if(zip4<>'',1,0))/count(group)
				,cart_nonblank_count:=sum(group,if(cart<>'',1,0))
				,cart_nonblank_percent:=sum(group,if(cart<>'',1,0))/count(group)
				,cr_sort_sz_nonblank_count:=sum(group,if(cr_sort_sz<>'',1,0))
				,cr_sort_sz_nonblank_percent:=sum(group,if(cr_sort_sz<>'',1,0))/count(group)
				,lot_nonblank_count:=sum(group,if(lot<>'',1,0))
				,lot_nonblank_percent:=sum(group,if(lot<>'',1,0))/count(group)
				,lot_order_nonblank_count:=sum(group,if(lot_order<>'',1,0))
				,lot_order_nonblank_percent:=sum(group,if(lot_order<>'',1,0))/count(group)
				,dbpc_nonblank_count:=sum(group,if(dbpc<>'',1,0))
				,dbpc_nonblank_percent:=sum(group,if(dbpc<>'',1,0))/count(group)
				,chk_digit_nonblank_count:=sum(group,if(chk_digit<>'',1,0))
				,chk_digit_nonblank_percent:=sum(group,if(chk_digit<>'',1,0))/count(group)
				,rec_type_nonblank_count:=sum(group,if(rec_type<>'',1,0))
				,rec_type_nonblank_percent:=sum(group,if(rec_type<>'',1,0))/count(group)
				,fips_county_nonblank_count:=sum(group,if(fips_county<>'',1,0))
				,fips_county_nonblank_percent:=sum(group,if(fips_county<>'',1,0))/count(group)
				,county_nonblank_count:=sum(group,if(county<>'',1,0))
				,county_nonblank_percent:=sum(group,if(county<>'',1,0))/count(group)
				,geo_lat_nonblank_count:=sum(group,if(geo_lat<>'',1,0))
				,geo_lat_nonblank_percent:=sum(group,if(geo_lat<>'',1,0))/count(group)
				,geo_long_nonblank_count:=sum(group,if(geo_long<>'',1,0))
				,geo_long_nonblank_percent:=sum(group,if(geo_long<>'',1,0))/count(group)
				,msa_nonblank_count:=sum(group,if(msa<>'',1,0))
				,msa_nonblank_percent:=sum(group,if(msa<>'',1,0))/count(group)
				,geo_blk_nonblank_count:=sum(group,if(geo_blk<>'',1,0))
				,geo_blk_nonblank_percent:=sum(group,if(geo_blk<>'',1,0))/count(group)
				,geo_match_nonblank_count:=sum(group,if(geo_match<>'',1,0))
				,geo_match_nonblank_percent:=sum(group,if(geo_match<>'',1,0))/count(group)
				,err_stat_nonblank_count:=sum(group,if(err_stat<>'',1,0))
				,err_stat_nonblank_percent:=sum(group,if(err_stat<>'',1,0))/count(group)
				,err_S_count:=sum(group,if(err_stat[1]='S',1,0))
				,err_S_percent:=sum(group,if(err_stat[1]='S',1,0))/count(group)
				}
				,case_state_abbreviation
				,case_benefit_month
				,few
				);

	population_stat:=tFieldPopulation;

	RETURN population_stat;
ENDMACRO;

END;