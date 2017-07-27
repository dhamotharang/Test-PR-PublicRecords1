IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header;

EXPORT StandardizeInputFile := module
	
	EXPORT fPreADDR(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  

		CNLD_Practitioner.layouts.Addr	tNormalizeADDR(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum; 
				self.address_addrid	:=  choose(cnt	,l.address1_addrid
																						,l.address2_addrid
																						,l.address3_addrid
																						,l.address4_addrid
																						,l.address5_addrid
																						,l.address6_addrid
																			);           	
				self.address_line1	:=	choose(cnt	,l.address1_line1
																						,l.address2_line1
																						,l.address3_line1
																						,l.address4_line1
																						,l.address5_line1
																						,l.address6_line1
																			); 
				self.address_line2	:=	choose(cnt	,l.address1_line2
																						,l.address2_line2
																						,l.address3_line2
																						,l.address4_line2
																						,l.address5_line2
																						,l.address6_line2
																			); 
				self.address_city		:=	choose(cnt	,l.address1_city
																						,l.address2_city
																						,l.address3_city
																						,l.address4_city
																						,l.address5_city
																						,l.address6_city
																			); 		
				self.address_st			:=	choose(cnt	,l.address1_st
																						,l.address2_st
																						,l.address3_st
																						,l.address4_st
																						,l.address5_st
																						,l.address6_st
																			); 
				self.address_zip		:=	choose(cnt	,l.address1_zip
																						,l.address2_zip
																						,l.address3_zip
																						,l.address4_zip
																						,l.address5_zip
																						,l.address6_zip
																			); 
				self.address_zip4		:=	choose(cnt	,l.address1_zip4
																						,l.address2_zip4
																						,l.address3_zip4
																						,l.address4_zip4
																						,l.address5_zip4
																						,l.address6_zip4
																			); 		
				self.address_country:=	choose(cnt	,l.address1_country
																						,l.address2_country
																						,l.address3_country
																						,l.address4_country
																						,l.address5_country
																						,l.address6_country
																			); 	
				self.address_phone	:=	choose(cnt	,l.address1_phone
																						,l.address2_phone
																						,l.address3_phone
																						,l.address4_phone
																						,l.address5_phone
																						,l.address6_phone
																			); 		
				self.address_fax		:=	choose(cnt	,l.address1_fax
																						,l.address2_fax
																						,l.address3_fax
																						,l.address4_fax
																						,l.address5_fax
																						,l.address6_fax
																			); 		
				self.address_date		:=	choose(cnt	,l.address1_date
																						,l.address2_date
																						,l.address3_date
																						,l.address4_date
																						,l.address5_date
																						,l.address6_date
																			); 		
				self.address_status	:=	choose(cnt	,l.address1_status
																						,l.address2_status
																						,l.address3_status
																						,l.address4_status
																						,l.address5_status
																						,l.address6_status
																			);													
				self.address_source	:=	choose(cnt	,l.address1_source
																						,l.address2_source
																						,l.address3_source
																						,l.address4_source
																						,l.address5_source
																						,l.address6_source
																			); 		
				self.address_type		:=	choose(cnt	,l.address1_type
																						,l.address2_type
																						,l.address3_type
																						,l.address4_type
																						,l.address5_type
																						,l.address6_type
																			); 		
				self.address_rank		:=	choose(cnt	,l.address1_rank
																						,l.address2_rank
																						,l.address3_rank
																						,l.address4_rank
																						,l.address5_rank
																						,l.address6_rank
																			); 
				self								:=	l;
				self								:= 	[];
		END;

		dPreADDR		:=	distribute(normalize(pRawFileInput, 6, tNormalizeADDR(left,counter)),hash(gennum));
		
		RETURN dPreADDR;
	END;
	
	EXPORT fPreDEA(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.DEA	tNormalizeDEA(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum;   
				self.deanbr					:=  choose(cnt	,l.deanbr1
																						,l.deanbr2
																						,l.deanbr3
																						,l.deanbr4
																						,l.deanbr5
																						,l.deanbr6
																						,l.deanbr7
																						,l.deanbr8
																						,l.deanbr9
																						,l.deanbr10
																			);           	
				self.deanbr_exp			:=	choose(cnt	,l.deanbr_exp1
																						,l.deanbr_exp2
																						,l.deanbr_exp3
																						,l.deanbr_exp4
																						,l.deanbr_exp5
																						,l.deanbr_exp6
																						,l.deanbr_exp7
																						,l.deanbr_exp8
																						,l.deanbr_exp9
																						,l.deanbr_exp10
																			); 
				self.deanbr_sch			:=	choose(cnt	,l.deanbr_sch1
																						,l.deanbr_sch2
																						,l.deanbr_sch3
																						,l.deanbr_sch4
																						,l.deanbr_sch5
																						,l.deanbr_sch6
																						,l.deanbr_sch7
																						,l.deanbr_sch8
																						,l.deanbr_sch9
																						,l.deanbr_sch10
																			); 
				self.deanbr_code		:=	choose(cnt	,l.deanbr_code1
																						,l.deanbr_code2
																						,l.deanbr_code3
																						,l.deanbr_code4
																						,l.deanbr_code5
																						,l.deanbr_code6
																						,l.deanbr_code7
																						,l.deanbr_code8
																						,l.deanbr_code9
																						,l.deanbr_code10
																			); 
		END;

		dPreDEA		:=	distribute(normalize(pRawFileInput, 10, tNormalizeDEA(left,counter))(	deanbr			!= '' or             	
																																												deanbr_exp	!= '' or
																																												deanbr_sch	!= '' or
																																												deanbr_code	!= ''),hash(gennum));
		
		RETURN dPreDEA;
	END;
	
	EXPORT fPreTAX(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.TAX	tNormalizeTAX(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum; 
				self.Tax_ID					:=  choose(cnt	,l.Tax_ID_1
																						,l.Tax_ID_2
																						,l.Tax_ID_3
																			);           	
		END;

		dPreTAX		:=	distribute(normalize(pRawFileInput, 3, tNormalizeTAX(left,counter))(Tax_ID!=''),hash(gennum));
		
		RETURN dPreTAX;
	END;	
	
	EXPORT fPreLIC(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.LIC	tNormalizeLIC(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum;
				self.st_lic_in			:=  choose(cnt	,l.st_lic_in1
																						,l.st_lic_in2
																						,l.st_lic_in3
																						,l.st_lic_in4
																						,l.st_lic_in5
																						,l.st_lic_in6
																						,l.st_lic_in7
																						,l.st_lic_in8
																						,l.st_lic_in9
																						,l.st_lic_in10
																			);   
				self.st_lic_num			:=  choose(cnt	,l.st_lic_num1
																						,l.st_lic_num2
																						,l.st_lic_num3
																						,l.st_lic_num4
																						,l.st_lic_num5
																						,l.st_lic_num6
																						,l.st_lic_num7
																						,l.st_lic_num8
																						,l.st_lic_num9
																						,l.st_lic_num10
																			);   
				self.st_lic_num_exp	:=  choose(cnt	,l.st_lic_num_exp1
																						,l.st_lic_num_exp2
																						,l.st_lic_num_exp3
																						,l.st_lic_num_exp4
																						,l.st_lic_num_exp5
																						,l.st_lic_num_exp6
																						,l.st_lic_num_exp7
																						,l.st_lic_num_exp8
																						,l.st_lic_num_exp9
																						,l.st_lic_num_exp10
																			);   
				self.st_lic_stat		:=  choose(cnt	,l.st_lic_stat1
																						,l.st_lic_stat2
																						,l.st_lic_stat3
																						,l.st_lic_stat4
																						,l.st_lic_stat5
																						,l.st_lic_stat6
																						,l.st_lic_stat7
																						,l.st_lic_stat8
																						,l.st_lic_stat9
																						,l.st_lic_stat10
																			);   
				self.st_lic_type		:=  choose(cnt	,l.st_lic_type1
																						,l.st_lic_type2
																						,l.st_lic_type3
																						,l.st_lic_type4
																						,l.st_lic_type5
																						,l.st_lic_type6
																						,l.st_lic_type7
																						,l.st_lic_type8
																						,l.st_lic_type9
																						,l.st_lic_type10
																			);   
				self.st_lic_issue		:=  choose(cnt	,l.st_lic_issue1
																						,l.st_lic_issue2
																						,l.st_lic_issue3
																						,l.st_lic_issue4
																						,l.st_lic_issue5
																						,l.st_lic_issue6
																						,l.st_lic_issue7
																						,l.st_lic_issue8
																						,l.st_lic_issue9
																						,l.st_lic_issue10
																			);   
				self.st_lic_source	:=  choose(cnt	,l.st_lic_source1
																						,l.st_lic_source2
																						,l.st_lic_source3
																						,l.st_lic_source4
																						,l.st_lic_source5
																						,l.st_lic_source6
																						,l.st_lic_source7
																						,l.st_lic_source8
																						,l.st_lic_source9
																						,l.st_lic_source10
																			);
				self								:=	[];
		END;

		dPreLIC		:=	distribute(normalize(pRawFileInput, 10, tNormalizeLIC(left,counter))(	st_lic_in				!='' or
																																												st_lic_num			!='' or
																																												st_lic_num_exp	!='' or
																																												st_lic_stat			!='' or
																																												st_lic_type			!='' or
																																												st_lic_issue		!='' or
																																												st_lic_source		!=''),hash(gennum));
		
		RETURN dPreLIC;
	END;		
	
	EXPORT fPreSpec(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.Specialty tNormalizeSPEC(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum;
				self.specialty_code	:=  choose(cnt	,l.specialty_code1
																						,l.specialty_code2
																						,l.specialty_code3
																						,l.specialty_code4
																						,l.specialty_code5
																			);   
		END;

		dPreSPEC		:=	distribute(normalize(pRawFileInput, 5, tNormalizeSPEC(left,counter))(specialty_code!=''),hash(gennum));
		
		RETURN dPreSPEC;
	END;
	
	EXPORT fPreSanction(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.Sanction tNormalizeSanction(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum;
				self.sanction_date	:=  choose(cnt	,l.sanction_date1
																						,l.sanction_date2
																						,l.sanction_date3
																						,l.sanction_date4
																						,l.sanction_date5
																						,l.sanction_date6
																						,l.sanction_date7
																						,l.sanction_date8
																						,l.sanction_date9
																						,l.sanction_date10																						
																			);   
				self.sanction_state	:=  choose(cnt	,l.sanction_state1
																						,l.sanction_state2
																						,l.sanction_state3
																						,l.sanction_state4
																						,l.sanction_state5
																						,l.sanction_state6
																						,l.sanction_state7
																						,l.sanction_state8
																						,l.sanction_state9
																						,l.sanction_state10																						
																			);   																			
				self.sanction_case	:=  choose(cnt	,l.sanction_case1
																						,l.sanction_case2
																						,l.sanction_case3
																						,l.sanction_case4
																						,l.sanction_case5
																						,l.sanction_case6
																						,l.sanction_case7
																						,l.sanction_case8
																						,l.sanction_case9
																						,l.sanction_case10																						
																			);   
				self.sanction_id		:=  choose(cnt	,l.sanction_id1
																						,l.sanction_id2
																						,l.sanction_id3
																						,l.sanction_id4
																						,l.sanction_id5
																						,l.sanction_id6
																						,l.sanction_id7
																						,l.sanction_id8
																						,l.sanction_id9
																						,l.sanction_id10																						
																			);
				self.sanction_docid	:=  choose(cnt	,l.sanction_docid1
																						,l.sanction_docid2
																						,l.sanction_docid3
																						,l.sanction_docid4
																						,l.sanction_docid5
																						,l.sanction_docid6
																						,l.sanction_docid7
																						,l.sanction_docid8
																						,l.sanction_docid9
																						,l.sanction_docid10																						
																			);   
				self.sanction_source:=  choose(cnt	,l.sanction_source1
																						,l.sanction_source2
																						,l.sanction_source3
																						,l.sanction_source4
																						,l.sanction_source5
																						,l.sanction_source6
																						,l.sanction_source7
																						,l.sanction_source8
																						,l.sanction_source9
																						,l.sanction_source10																						
																			);   
				self.sanction_type	:=  choose(cnt	,l.sanction_type1
																						,l.sanction_type2
																						,l.sanction_type3
																						,l.sanction_type4
																						,l.sanction_type5
																						,l.sanction_type6
																						,l.sanction_type7
																						,l.sanction_type8
																						,l.sanction_type9
																						,l.sanction_type10																						
																			); 
		END;

		dPreSanction		:=	distribute(normalize(pRawFileInput, 10, tNormalizeSanction(left,counter))(sanction_date			!='' or
																																																	sanction_state		!='' or
																																																	sanction_case			!='' or
																																																	sanction_id				!='' or
																																																	sanction_docid		!='' or
																																																	sanction_source		!='' or
																																																	sanction_type			!='')	,hash(gennum));
		
		RETURN dPreSanction;
	END;	
	
	EXPORT fPreSchool(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.School tNormalizeSchool(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum;
				self.degree					:=  choose(cnt	,l.degree1
																						,l.degree2
																						,l.degree3																				
																			);   
				self.schoolCode			:=  choose(cnt	,l.schoolCode1
																						,l.schoolCode2
																						,l.schoolCode3																
																			);   
				self.schoolyear			:=  choose(cnt	,l.schoolyear1
																						,l.schoolyear2
																						,l.schoolyear3																			
																			);
		END;

		dPreSchool		:=	distribute(normalize(pRawFileInput, 3, tNormalizeSchool(left,counter))(	degree			!= '' or
																																															schoolCode	!= '' or
																																															schoolyear	!= ''),hash(gennum));
		
		RETURN dPreSchool;
	END;		
	
	EXPORT fPreTraining(DATASET(CNLD_Practitioner.layouts.Input) pRawFileInput) := FUNCTION  
  	
		CNLD_Practitioner.layouts.Training tNormalizeTraining(CNLD_Practitioner.layouts.Input l, unsigned4 cnt) := transform
				self.gennum					:=	l.gennum;
				self.train_category	:=  choose(cnt	,l.train_category1
																						,l.train_category2
																						,l.train_category3
																						,l.train_category4	
																						,l.train_category5																							
																			); 
				self.train_startdate:=  choose(cnt	,l.train_startdate1
																						,l.train_startdate2
																						,l.train_startdate3	
																						,l.train_startdate4	
																						,l.train_startdate5																							
																			);   
				self.train_enddate	:=  choose(cnt	,l.train_enddate1
																						,l.train_enddate2
																						,l.train_enddate3		
																						,l.train_enddate4	
																						,l.train_enddate5																							
																			);
				self.train_institute:=  choose(cnt	,l.train_institute1
																						,l.train_institute2
																						,l.train_institute3		
																						,l.train_institute4	
																						,l.train_institute5																							
																			);	
				self								:=	[];
		END;

		dPreTraining		:=	distribute(normalize(pRawFileInput, 5, tNormalizeTraining(left,counter))(	train_category	!='' or
																																																	train_startdate	!='' or
																																																	train_enddate		!='' or
																																																	train_institute	!=''),hash(gennum));
		
		RETURN dPreTraining;
	END;	

	EXPORT fAll( DATASET(CNLD_Practitioner.layouts.Input)  pRawFileInput) := FUNCTION
   	dPreDEA	 				:= fPreDEA 			(pRawFileInput);
		dPreAddr				:= fPreAddr			(pRawFileInput);
		dPreTAX					:= fPreTAX			(pRawFileInput);		
		dPreLicense			:= fPreLIC			(pRawFileInput);	
		dPreSpeciality	:= fPreSpec			(pRawFileInput);	
		dPreSanction		:= fPreSanction	(pRawFileInput);			
    dPreSchool			:= fPreSchool		(pRawFileInput);		 
    dPreTraining		:= fPreTraining	(pRawFileInput);	

		CNLD_Practitioner.layouts.temp1	join1(dPreADDR lInput, dPreDEA rInput)	:=	transform
			self.provStatDesc		:=	map(lInput.provStat = 'D' => 'DECEASED',
																	lInput.provStat = 'R' => 'RETIRED',
																	''
																  );
			self.profStatDesc		:=	map(lInput.profStat = 'A' => 'ACTIVE',
																	lInput.profStat = 'I' => 'INACTIVE',
																	''
																	);
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined1	:=	join(	dPreADDR,
											dPreDEA,
											left.gennum = right.gennum,
											join1(left,right),
											left outer,
											local
										 );
										 
		CNLD_Practitioner.layouts.temp2	join2(joined1 lInput, dPreTAX rInput)	:=	transform
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined2	:=	join(	joined1,
											dPreTAX,
											left.gennum = right.gennum,
											join2(left,right),
											left outer,
											local
										 );	
										 
		CNLD_Practitioner.layouts.temp3	join3(joined2 lInput, dPreLicense rInput)	:=	transform
			self.licStatDesc		:=	map(rInput.st_lic_stat = 'A' => 'ACTIVE',
																	''
																  );
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined3	:=	join(	joined2,
											dPreLicense,
											left.gennum = right.gennum,
											join3(left,right),
											left outer,
											local
										 );		
										 
		CNLD_Practitioner.layouts.temp4	join4(joined3 lInput, dPreSpeciality rInput)	:=	transform
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined4	:=	join(	joined3,
											dPreSpeciality,
											left.gennum = right.gennum,
											join4(left,right),
											left outer,
											local
										 );				
										 
		CNLD_Practitioner.layouts.temp5	join5(joined4 lInput, dPreSanction rInput)	:=	transform
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined5	:=	join(	joined4,
											dPreSanction,
											left.gennum = right.gennum,
											join5(left,right),
											left outer,
											local
										 );	
										 
		CNLD_Practitioner.layouts.temp6	join6(joined5 lInput, dPreSchool rInput)	:=	transform
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined6	:=	join(	joined5,
											dPreSchool,
											left.gennum = right.gennum,
											join6(left,right),
											left outer,
											local
										 );			
										 
		CNLD_Practitioner.layouts.temp7	join7(joined6 lInput, dPreTraining rInput)	:=	transform
			self.trainCatDesc		:=	map(rInput.train_category = 'I' => 'INTERN',
																	rInput.train_category = 'R' => 'RESIDENT',
																	rInput.train_category = 'F' => 'FELLOW',
																	''
																  );
			self	:=	lInput;
			self	:=	rInput;
		end;
		
		Joined7	:=	join(	joined6,
											dPreTraining,
											left.gennum = right.gennum,
											join7(left,right),
											left outer,
											local
										);	
										
		CNLD_Practitioner.layouts.temp	trfPreppedAID(Joined7 l)	:=	transform
			self.Append_AddrLine1			:=	StringLib.StringCleanSpaces(trim(l.address_line1,left,right) + ' '+
																																trim(l.address_line2,left,right)
																																);
			self.Append_AddrLineLast	:=	if (trim(l.address_city,left,right) != '',
																						 StringLib.StringCleanSpaces(trim(l.address_city,left,right) + ', ' +
																																				 trim(l.address_st,left,right) + ' ' + 
																																				 trim(l.address_zip,left,right)), 
																						 StringLib.StringCleanSpaces(trim(l.address_st,left,right) + ' ' + 
																																				 trim(l.address_zip,left,right))
																			  );
			self											:=	l;
		end;
		
		dPreprocess	:= dedup(sort(project(	Joined7, trfPreppedAID(left)),record,local),record,local);
		
		RETURN dPreprocess;
	END;
		
END;