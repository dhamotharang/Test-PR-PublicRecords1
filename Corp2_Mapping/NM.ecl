import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export NM := MODULE;

	export Layouts_Raw_Input := MODULE
	
			
		// VENDOR DATA STARTS
		export CorpLayout	:= record				
			string7 Nmscc_no;	
			string3 corp_type;	
			string80 corp_name;	
			string2 corp_stat;	
			string2 typ_rpt;	
			string2 state_incorp;	
			string8 date_incorp;	
			string8 corp_ex_date;	
			string30 corp_pres;	
			string30 corp_vicepres;	
			string30 corp_sec;	
			string30 corp_tres;	
			string35 mail_addr_street;
			string15 mail_addr_city;	
			string2 mail_addr_st;	
			string2 mail_addr_country;	
			string10 mail_addr_zip;	
			string35 nm_p_street;	
			string15 nm_p_city;	
			string2 nm_p_state;	
			string2 nm_p_country;	
			string10 nm_p_zip;	
			string35 os_p_street;	
			string15 os_p_city;	
			string2 os_p_state;	
			string2 os_p_country;	
			string10 os_p_zip;	
			string35 for_street;	
			string15 for_city;	
			string2 for_state;	
			string2 for_country;	
			string10 for_zip;		
			string80 agent_name;	
			string35 ag_street;	
			string15 ag_city;	
			string2 ag_state;	
			string10 ag_zip;		
			string50 purpose;	
		end;
	
		export EventLayout	:= record

			string7 	Nmscc_no;	
			string8 	File_date;	
			string7 	Instrm_nbr;	
			string6 	Instrm_add_date;	
			string6 	Instrm_add_time;	
			string3 	Instrm_type;	
			string320   Instrm_text;

		end;

		export DirectorLayout	:= record

			string7 	Nmscc_no;	
			string20 	Last_nm;
			string20 	First_nm;
			string1		Mid_nm;	
   		end;
		
		

		export CorpDirectorLayout := record 
			string7 Nmscc_no;	
			string3 corp_type;	
			string80 corp_name;	
			string2 corp_stat;	
			string2 typ_rpt;	
			string2 state_incorp;	
			string8 date_incorp;	
			string8 corp_ex_date;	
			string30 corp_pres;	
			string30 corp_vicepres;	
			string30 corp_sec;	
			string30 corp_tres;	
			string35 mail_addr_street;
			string15 mail_addr_city;	
			string2 mail_addr_st;	
			string2 mail_addr_country;	
			string10 mail_addr_zip;	
			string35 nm_p_street;	
			string15 nm_p_city;	
			string2 nm_p_state;	
			string2 nm_p_country;	
			string10 nm_p_zip;	
			string35 os_p_street;	
			string15 os_p_city;	
			string2 os_p_state;	
			string2 os_p_country;	
			string10 os_p_zip;	
			string35 for_street;	
			string15 for_city;	
			string2 for_state;	
			string2 for_country;	
			string10 for_zip;		
			string80 agent_name;	
			string35 ag_street;	
			string15 ag_city;	
			string2 ag_state;	
			string10 ag_zip;		
			string50 purpose;	

			// director layout

			string20 	Last_nm;
			string20 	First_nm;
			string1	Mid_nm;

		end;
		
		
	
	end;// end of Layouts_Raw_Input module
	
	// update function
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
	trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;		  	
		  
		// corp data ebcdic routine
		CorprecIn :=RECORD
			EBCDIC STRING680 Corpstr;
		END;
	
		Corprecout := RECORD, MAXLENGTH(680)

			STRING Corpstr;
		END;
	
		CorprecOut  Corptrans ( CorprecIn L) := TRANSFORM

			SELF.Corpstr := L.Corpstr[1..length((>varstring679<)L.Corpstr)];
		END;

	




	Layouts_Raw_Input.CorpLayout CorpTransFixed( CorprecOut l) := TRANSFORM

		self.Nmscc_no 			:= l.Corpstr[1..7];
		self.corp_type  		:= l.Corpstr[8..10];
		self.corp_name 			:= l.Corpstr[11..90];
		self.corp_stat   		:= l.Corpstr[91..92];
		self.typ_rpt   		    := l.Corpstr[93..94];
		self.state_incorp    	:= l.Corpstr[95..96];
		self.date_incorp    	:= l.Corpstr[97..104];
		self.corp_ex_date   	:= l.Corpstr[105..112];
		self.corp_pres    		:= l.Corpstr[113..142];
		self.corp_vicepres   	:= l.Corpstr[143..172];
		self.corp_sec    		:= l.Corpstr[173..202];
		self.corp_tres    		:= l.Corpstr[203..232];
		self.mail_addr_street   := l.Corpstr[233..267];
		self.mail_addr_city   	:= l.Corpstr[268..282];
		self.mail_addr_st    	:= l.Corpstr[283..284];
		self.mail_addr_country  := l.Corpstr[285..286];
		self.mail_addr_zip    	:= l.Corpstr[287..296];
		self.nm_p_street    	:= l.Corpstr[297..331];
		self.nm_p_city  		:= l.Corpstr[332..346];
		self.nm_p_state   		:= l.Corpstr[347..348];
		self.nm_p_country   	:= l.Corpstr[349..350];
		self.nm_p_zip   		:= l.Corpstr[351..360];
		self.os_p_street   		:= l.Corpstr[361..395];
		self.os_p_city    		:= l.Corpstr[396..410];
		self.os_p_state    		:= l.Corpstr[411..412];
		self.os_p_country    	:= l.Corpstr[413..414];
		self.os_p_zip   		:= l.Corpstr[415..424];
		self.for_street   		:= l.Corpstr[425..459];
		self.for_city    		:= l.Corpstr[460..474];
		self.for_state    		:= l.Corpstr[475..476];
		self.for_country    	:= l.Corpstr[477..478];
		self.for_zip    		:= l.Corpstr[479..488];
		self.agent_name    		:= l.Corpstr[489..568];
		self.ag_street    		:= l.Corpstr[569..603];
		self.ag_city   			:= l.Corpstr[604..618];
		self.ag_state    		:= l.Corpstr[619..620];
		self.ag_zip    			:= l.Corpstr[621..630];
		self.purpose    		:= l.Corpstr[631..680];

		
		
		end;


  
		// creating corp file  

   		Corpin 	:= DATASET('~thor_data400::in::corp2::'+ filedate+'::Import_Master::nm', CorprecIn, flat);
   		Corpout	:= PROJECT( Corpin,  Corptrans(LEFT));  
   		CorpFile	:= PROJECT( Corpout, CorptransFixed(LEFT));

		// event file routine
	
		EventrecIn :=RECORD
			EBCDIC STRING357 Eventstr;
		END;
	
		Eventrecout := RECORD, MAXLENGTH(357)
			STRING Eventstr;
		END;	
	
		EventrecOut  Eventtrans ( EventrecIn L) := TRANSFORM
			SELF.Eventstr := L.Eventstr[1..length((>varstring356<)L.Eventstr)];
		END;

		Layouts_Raw_Input.EventLayout  EventTransFixed( EventrecOut l) := TRANSFORM

		

			self.Nmscc_no 			:= l.Eventstr [1..7];
			self.File_date  		:= l.Eventstr [8..15];
			self.Instrm_nbr 		:= l.Eventstr [16..22];
			self.Instrm_add_date   	:= l.Eventstr [23..28];
			self.Instrm_add_time    := l.Eventstr [29..34];
			self.Instrm_type    	:= l.Eventstr [35..37];
			self.Instrm_text    	:= l.Eventstr [38..357];

		
	 	end;
		
  		//creating event file
		
   		
		Eventin 	:= DATASET('~thor_data400::in::corp2::'+ filedate+'::Import1_History::nm', EventrecIn, flat);
   		Eventout	:= PROJECT( Eventin,  Eventtrans(LEFT));  

		EventFile	:= PROJECT( Eventout, EventtransFixed(LEFT));

		// creating directors file
   		DirrecIn := RECORD
			EBCDIC STRING48 Dirstr;
   		END;
	
   		Dirrecout := RECORD, MAXLENGTH(48)
			STRING Dirstr;
   		END;
	
		DirrecOut trans (DirrecIn L) := TRANSFORM

			SELF.Dirstr := L.Dirstr[1..length((>varstring47<)L.Dirstr)];
		END;

		Layouts_Raw_Input.DirectorLayout transDirector(DirrecOut l) := TRANSFORM
			self.Nmscc_no := l.Dirstr[1..7];
			self.Last_nm  := l.Dirstr[8..27];
			self.First_nm := l.Dirstr[28..47];
			self.Mid_nm   := l.Dirstr[48..48];

		end;
		
  		// creating directors file
  		inDir 	:= DATASET('~thor_data400::in::corp2::'+ filedate+'::Import2_directors::nm',DirrecIn, flat);
  		outDir	:= PROJECT(inDir, trans(LEFT));  
  		DirFile	:= PROJECT(outDir,transDirector(LEFT));

     // corp main transform

	corp2_mapping.Layout_CorpPreClean NM_corpMainTransform(layouts_raw_input.CorpLayout input):= transform

		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		
		self.corp_vendor					:= '35';
		
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;

		self.corp_orig_sos_charter_nbr		:=  input.Nmscc_no;

		self.corp_src_type				:= 'SOS';

		statusDesc						:= map(trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='AC'=>'ACTIVE CORPORATION',
			                          
  										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='AP'=>'PROCESS OF APPEAL',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='BK'=>'BANKRUPTCY-RECEIVERSHIP',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='BT'=>'BUSINESS TRANSACTED',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='CA'=>'CANCELLATION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='CO'=>'CONSOLIDATED',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='CR'=>'CANCELLATION OF REGISTRATION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='DH'=>'DISSOLUTION HEARING',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='DV'=>'VOLUNTARY DISSOLUTION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='EE'=>'EXISTENCE EXPIRED AUTOMATICALLY',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='EX'=>'EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='FF'=>'FORFEITED',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='IS'=>'INVOLUNTARILY STRICKEN',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='LF'=>'LATE-FILER',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='MG'=>'MERGED-OUT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='NC'=>'NEW CORPORATION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='NF'=>'NON-FILER',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='RI'=>'RE-INSTATEMENT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='RF'=>'REVOKED AND BEYOND APPEAL PERIOD',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='RR'=>'RETURNED REPORT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='RV'=>'REVOKED',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='SD'=>'STATEMENT OF INTENT TO DISSOLVE',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='SU'=>'SUSPENSION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='TC'=>'CORPORATION TAX CLEARANCE',
									
										trim(stringlib.StringtoUpperCase(input.Corp_STAT),left,right)='WD'=>'WITHDRAWN',	
													   '');
															



		self.corp_status_cd						:=  if ( trim(input.Corp_STAT,left, right) <> '',trim(stringlib.StringtoUpperCase(input.Corp_STAT),left, right),'');

		self.corp_status_desc					:= if ( trim(statusDesc,left,right)<>'',trim(stringlib.StringtoUpperCase(statusDesc),left, right),'');

		dateIncorporated						:= if ( trim( input.Date_Incorp,left,right) <> '',
															input.Date_Incorp[5..8] +
															input.Date_Incorp[1..2] +
															input.Date_Incorp[3..4],'');

		dateIncorporatedInc						:= if ( dateIncorporated <> '' and  (string)((integer)dateIncorporated) <> '0' and
													_validate.date.fIsValid(dateIncorporated) ,dateIncorporated,'');  



		self.corp_inc_date						:= if( trim(dateIncorporatedInc,left,right) <> '' and
												 trim(stringlib.StringtoUpperCase(input.state_incorp),left,right)='NM', dateIncorporatedInc,'');
		
		self.corp_forgn_date					:= if( trim(dateIncorporatedInc,left,right) <> '' and
												trim(stringlib.StringtoUpperCase(input.state_incorp),left,right)<>'NM', dateIncorporatedInc,'');
		

		self.corp_inc_state						:= if( trim(input.state_incorp,left,right) <> '' and
												trim(stringlib.StringtoUpperCase(input.state_incorp),left,right)='NM', 'NM','');


		self.corp_forgn_state_cd				:= if( trim(input.state_incorp,left,right) <> '' and
												trim(stringlib.StringtoUpperCase(input.state_incorp),left,right)<> 'NM',
												trim(stringlib.StringtoUpperCase(input.state_incorp),left,right),'');

		// lookup for forgn state desc
		//self.corp_forgn_state_desc

		
		corpexpdate						:= if ( trim( input.corp_ex_date,left,right) <> '',
															input.Corp_ex_Date[5..8] +
															input.Corp_ex_Date[1..2] +
															input.Corp_ex_Date[3..4],'');

		corpexpdateInc					:= if ( corpexpdate <> '' and 
													_validate.date.fIsValid(corpexpdate) ,corpexpdate,'');  

		


		self.corp_term_exist_cd				:= if( trim(input.corp_ex_date,left,right) <> '' and 
										(string)((integer)input.corp_ex_date) = '0',
										'P',if( trim(corpexpdateInc,left,right) <> '' and 
										(string)((integer)corpexpdateInc) <> '0','D',''));

		self.corp_term_exist_desc			:= if( trim(input.corp_ex_date,left,right) <> '' and 
										(string)((integer)input.corp_ex_date) = '0',
										'PERPETUAL',if( trim(corpexpdateInc,left,right) <> '' and 
										(string)((integer)corpexpdateInc) <> '0','EXPIRATION DATE',''));

		self.corp_term_exist_exp			:= if( trim(corpexpdateInc,left,right) <> '' and 
										(string)((integer)corpexpdateInc) <> '0',trim(corpexpdateInc,left,right),'');
		

		self.corp_orig_bus_type_cd			:= if ( trim(input.corp_type,left,right) <> '',trim(stringlib.StringtoUpperCase(input.Corp_type),left,right),'');

		busTypeDesc						:=  map(trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DCR'=>'DOMESTIC COOPERATIVE REPORTER',
			                                        
  										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DCX'=>'DOMESTIC COOPERATIVE EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DFX'=>'DOMESTIC FINANCIAL EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DLC'=>'DOMESTIC LIMITED LIABILITY COMPANY',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DNA'=>'DOMESTIC AGENCY CONNECTED',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DNP'=>'DOMESTIC NONPROFIT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DNX'=>'DOMESTIC NONPROFIT EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DPC'=>'DOMESTIC PROFESSIONAL CORPORATION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DPR'=>'DOMESTIC PROFIT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DPX'=>'DOMESTIC PROFIT EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='DRD'=>'DOMESTIC REDOMESTICATED',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FCR'=>'FOREIGN COOPERATIVE REPORTER',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FCX'=>'FOREIGN COOPERATIVE EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FFX'=>'FOREIGN FINANCIAL EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FLC'=>'FOREIGN LIMITED LIABILITY COMPANY',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FNP'=>'FOREIGN NONPROFIT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FNX'=>'FOREIGN NONPROF T EXEMPT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FPC'=>'FOREIGN PROFESSIONAL CORPORATION',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FPR'=>'FOREIGN PROFIT',
									
										trim(stringlib.StringtoUpperCase(input.Corp_type),left,right)='FPX'=>'FOREIGN PROFIT EXEMPT',
																							   '');




		self.corp_orig_bus_type_desc			:= if ( trim(input.purpose,left, right)<>'',trim(stringlib.StringtoUpperCase(input.purpose),left, right),'');

		self.corp_orig_org_structure_desc		:= if ( trim(busTypeDesc,left, right)<>'',trim(stringlib.StringtoUpperCase(busTypeDesc),left, right),'');





		self.corp_standing				:= if ( trim(input.typ_rpt,left, right) = '10' ,'Y','');
		
		addl_info_text            := map(trim(input.typ_rpt,left,right)='00'=>'NEW',			                                        
																		 trim(input.typ_rpt,left,right)='01'=>'FIRST',
																		 trim(input.typ_rpt,left,right)='02'=>'ANNUAL',
																		 trim(input.typ_rpt,left,right)='03'=>'MISC SUPPLEMENTAL',
																		 trim(input.typ_rpt,left,right)='04'=>'AMENDED',
																		 trim(input.typ_rpt,left,right)='05'=>'TAX CLEARANCE',
																		 trim(input.typ_rpt,left,right)='06'=>'FIRST REPORT/CLEARANCE',
																		 trim(input.typ_rpt,left,right)='07'=>'REGULAR REPORT/CLEARANCE',
																		 trim(input.typ_rpt,left,right)='08'=>'SUSPENSION',
																		 trim(input.typ_rpt,left,right)='09'=>'SUPPLEMENTAL AGENT ASSIGNMENT',
																		 trim(input.typ_rpt,left,right)='11'=>'SUPPLEMENTAL NAME CHANGE',
																		 trim(input.typ_rpt,left,right)='12'=>'SUPPLEMENTAL PURPOSE CHANGE',
																		 trim(input.typ_rpt,left,right)='13'=>'SUPPLEMENTAL AGENT REGISTRATION',
																		 '');

		self.corp_addl_info				:= if(addl_info_text<>'',
																		'REPORT TYPE: ' + addl_info_text,
																		'');

		self.corp_legal_name				:= if ( trim(input.corp_name,left,right) <>'',trim(stringlib.StringtoUpperCase(input.corp_name),left,right),'');

		self.corp_ln_name_type_cd			:= '01';

		self.corp_ln_name_type_desc			:= 'LEGAL';


		self.corp_address1_line1			:=	if ( trim(input.nm_p_street,left,right) <> '', 											
												trim(stringlib.StringtoUpperCase(input.nm_p_street),left,right),
												if ( trim(input.os_p_street,left,right) <> '',											
												trim(stringlib.StringtoUpperCase(input.os_p_street),left,right),
												if ( trim(input.for_street,left,right) <> '', 											
											trim(stringlib.StringtoUpperCase(input.for_street),left,right),'')));
		
		
										
		self.corp_address1_line2			:=	if ( trim(input.nm_p_city,left,right) <> '' 
												and trim(stringlib.StringtoUpperCase(input.nm_p_city),left,right)<>'NONE' 
												and trim(stringlib.StringtoUpperCase(input.nm_p_city),left,right)<>'NOT GIVEN', 
												trim(stringlib.StringtoUpperCase(input.nm_p_city),left,right),
												if ( trim(input.os_p_city,left,right) <> '',											
												trim(stringlib.StringtoUpperCase(input.os_p_city),left,right),
												if ( trim(input.for_city,left,right) <> '', 											
												trim(stringlib.StringtoUpperCase(input.for_city),left,right),'')));
			


		self.corp_address1_line3			:=	if ( trim(input.nm_p_state,left,right) <> '', 
											
												trim(stringlib.StringtoUpperCase(input.nm_p_state),left,right),
												if ( trim(input.os_p_state,left,right) <> '',
											
												trim(stringlib.StringtoUpperCase(input.os_p_state),left,right),
												if ( trim(input.for_state,left,right) <> '', 
											
												trim(stringlib.StringtoUpperCase(input.for_state),left,right),'')));
				

		self.corp_address1_line4			:=	if ( trim(input.nm_p_zip,left,right) <> '' 
												and (string)((integer)input.nm_p_zip) <> '0' ,													 
												trim(input.nm_p_zip,left,right),
												if ( trim(input.os_p_zip,left,right) <> '' 
												and (string)((integer)input.os_p_zip) <> '0' ,
												trim(input.os_p_zip,left,right),
												if ( trim(input.for_zip,left,right) <> '' 
												and (string)((integer)input.for_zip) <> '0', 
												trim(input.for_zip,left,right),'')));




										
	

		self.corp_address1_line5			:=	if (trim(input.nm_p_country,left,right) <> '', 
											
												trim(stringlib.StringtoUpperCase(input.nm_p_country),left,right),
												if ( trim(input.os_p_country,left,right) <> '',
											
												trim(stringlib.StringtoUpperCase(input.os_p_country),left,right),
												if ( trim(input.for_country,left,right) <> '', 
											
												trim(stringlib.StringtoUpperCase(input.for_country),left,right),'')));
										

		addrTypeNM							:= if (trim(input.nm_p_street,left,right) <> '' or
													trim(input.nm_p_city,left,right) <> '' or
													trim(input.nm_p_state,left,right) <> '' or
													trim(input.nm_p_zip,left,right) <> '' or 
													trim(input.nm_p_country,left,right) <> '' ,'B','');

		addrTypeOS							:= if ( trim(addrTypeNM,left,right) = '',if (trim(input.os_p_street,left,right) <> '' or
													trim(input.os_p_city,left,right) <> '' or
													trim(input.os_p_state,left,right) <> '' or
													trim(input.os_p_zip,left,right) <> '' or 
													trim(input.os_p_country,left,right) <> '' ,'B',''),'B');

		addrTypeFOR							:= if ( trim(addrTypeOS,left,right) = '',if (trim(input.for_street,left,right) <> '' or
													trim(input.for_city,left,right) <> '' or
													trim(input.for_state,left,right) <> '' or
													trim(input.for_zip,left,right) <> '' or 
													trim(input.for_country,left,right) <> '' ,'B',''),'B');



		self.corp_address1_type_cd			:=  if (trim(addrTypeNM,left,right) <> '' or
											trim(addrTypeOS,left,right) <> '' or
											trim(addrTypeFOR,left,right) <> '' ,'B','');



		self.corp_address1_type_desc		:=	if (trim(addrTypeNM,left,right) <> '' or
											trim(addrTypeOS,left,right) <> '' or
											trim(addrTypeFOR,left,right) <> '' ,'BUSINESS','');

		
		self.corp_address2_line1			:=	if (trim(input.Mail_addr_street,left,right) <> '',trim(stringlib.StringtoUpperCase(input.Mail_addr_street),left,right) ,'');

	

		self.corp_address2_line2			:=	if (trim(input.Mail_addr_city,left,right) <> ''
										and trim(stringlib.StringtoUpperCase(input.Mail_addr_city),left,right) <> 'NONE'
										and trim(stringlib.StringtoUpperCase(input.Mail_addr_city),left,right) <> 'NOT GIVEN' ,
										trim(stringlib.StringtoUpperCase(input.Mail_addr_city),left,right) ,'');




		self.corp_address2_line3			:=	if (trim(input.Mail_addr_st,left,right) <> '',trim(stringlib.StringtoUpperCase(input.Mail_addr_st),left,right) ,'');



		
	
		self.corp_address2_line4			:=	if (trim(input.Mail_addr_zip,left,right) <> '' 
											and (string)((integer)input.Mail_addr_zip) <> '0' 
											and trim(input.Mail_addr_zip,left,right)<>'-',
											trim(stringlib.StringtoUpperCase(input.Mail_addr_zip),left,right) ,'');





		

		self.corp_address2_line5			:=	if (trim(input.Mail_addr_country,left,right) <> '' and
												trim(stringlib.StringtoUpperCase(input.Mail_addr_country),left,right) <> 'US'
													,trim(stringlib.StringtoUpperCase(input.Mail_addr_country),left,right) ,'');

		self.corp_address2_type_cd			:=	if (trim(input.mail_addr_street,left,right) <> '' or
													trim(input.mail_addr_city,left,right) <> '' or
													trim(input.mail_addr_st,left,right) <> '' or
													trim(input.mail_addr_zip,left,right) <> '' or 
													trim(input.mail_addr_country,left,right) <> '' ,'M','');

		self.corp_address2_type_desc		:=	if (trim(input.mail_addr_street,left,right) <> '' or
													trim(input.mail_addr_city,left,right) <> '' or
													trim(input.mail_addr_st,left,right) <> '' or
													trim(input.mail_addr_zip,left,right) <> '' or 
													trim(input.mail_addr_country,left,right) <> '' ,'MAILING','');




		

		self.corp_ra_name					:= if ( trim(input.agent_name,left,right) <>'' and trim(stringlib.StringtoUpperCase(input.agent_name),left,right) <>'NONE'
 										,trim(stringlib.StringtoUpperCase(input.agent_name),left,right),'');
		
		
		

		self.corp_ra_address_line1			:= if ( trim(input.ag_street,left,right) <>'' 
										and trim(stringlib.StringtoUpperCase(input.ag_street),left,right) <> 'NONE'
										and trim(stringlib.StringtoUpperCase(input.ag_street),left,right) <> 'NOT GIVEN',
										trim(stringlib.StringtoUpperCase(input.ag_street),left,right),'');


		

		self.corp_ra_address_line2			:= if ( trim(input.ag_city,left,right) <>'' 
										and trim(stringlib.StringtoUpperCase(input.ag_city),left,right) <> 'NONE'
										and trim(stringlib.StringtoUpperCase(input.ag_city),left,right) <> 'NOT GIVEN',
										trim(stringlib.StringtoUpperCase(input.ag_city),left,right),'');

		

		

		self.corp_ra_address_line3			:= if ( trim(input.ag_state,left,right) <>''
										and trim(stringlib.StringtoUpperCase(input.ag_state),left,right) <> 'NONE'
										and trim(stringlib.StringtoUpperCase(input.ag_state),left,right) <> 'NOT GIVEN',
										trim(stringlib.StringtoUpperCase(input.ag_state),left,right),'');

	
		

		self.corp_ra_address_line4			:= if ( trim(input.ag_zip,left,right) <>'' 
										and trim(stringlib.StringtoUpperCase(input.ag_zip),left,right) <> 'NONE'
										and trim(stringlib.StringtoUpperCase(input.ag_zip),left,right) <> 'NOT GIVEN'
										and (string)((integer)input.ag_zip) <> '0' 
										and trim(input.ag_zip,left,right) <> '-',
										trim(input.ag_zip,left,right),'');
		


		self.corp_ra_address_type_desc		:= 'REGISTERED OFFICE';


		self								:= [];

	end;// main corp transform ends



	//***************************lookup*****CORP***


		//statecode type layout
		StateCodeLayout := record
			string StateCode;
			string StateDesc;
			
		end;						
		  
	
		
		StateCodeTable :=
 dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::countrystate_table::nm',StateCodeLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n',
 '\n'])));




	//cleaning routine starts
	
	corp2.layout_corporate_direct_corp_in  CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean input) := transform
		string73 tempname 					:= if (input.corp_ra_name = '', '',Address.CleanPersonFML73(input.corp_ra_name));
		pname 								:= Address.CleanNameFields(tempName);
		cname 								:= DataLib.companyclean(input.corp_ra_name);
		keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
		keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
		
		self.corp_ra_title1					:= if(keepPerson, pname.title, '');
		self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
		self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
		self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
		self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
		self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
	
		self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
		self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
	
		
		
		

		string182 clean_address1 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right),left,right), 
																		trim(input.corp_address1_line2,left,right) + ', ' +
																		trim(input.corp_address1_line3,left,right) + ' ' +
																		trim(input.corp_address1_line4,left,right)+ ', ' +
																		trim(input.corp_address1_line5,left,right));
										
		

		self.corp_addr1_prim_range    		:= clean_address1[1..10];
		self.corp_addr1_predir 	      		:= clean_address1[11..12];
		self.corp_addr1_prim_name 	  		:= clean_address1[13..40];
		self.corp_addr1_addr_suffix   		:= clean_address1[41..44];
		self.corp_addr1_postdir 	    	:= clean_address1[45..46];
		self.corp_addr1_unit_desig 	  		:= clean_address1[47..56];
		self.corp_addr1_sec_range 	  		:= clean_address1[57..64];
		self.corp_addr1_p_city_name	  		:= clean_address1[65..89];
		self.corp_addr1_v_city_name	  		:= clean_address1[90..114];
		self.corp_addr1_state 				:= clean_address1[115..116];
		self.corp_addr1_zip5 		    	:= clean_address1[117..121];
		self.corp_addr1_zip4 		    	:= clean_address1[122..125];
		self.corp_addr1_cart 		    	:= clean_address1[126..129];
		self.corp_addr1_cr_sort_sz 	 		:= clean_address1[130];
		self.corp_addr1_lot 		    	:= clean_address1[131..134];
		self.corp_addr1_lot_order 	  		:= clean_address1[135];
		self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
		self.corp_addr1_chk_digit 	  		:= clean_address1[138];
		self.corp_addr1_rec_type			:= clean_address1[139..140];
		self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
		self.corp_addr1_county 	  			:= clean_address1[143..145];
		self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
		self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
		self.corp_addr1_msa 		    	:= clean_address1[167..170];
		self.corp_addr1_geo_blk				:= clean_address1[171..177];
		self.corp_addr1_geo_match 	  		:= clean_address1[178];
		self.corp_addr1_err_stat 	    	:= clean_address1[179..182];

		string182 clean_address				:=  Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right),left,right), 
																		trim(input.corp_ra_address_line2,left,right) + ', ' +
																		trim(input.corp_ra_address_line3,left,right) + ' ' +
																		trim(input.corp_ra_address_line4,left,right)+ ', ' +
																		trim(input.corp_ra_address_line5,left,right));		
										
								
											
		self.corp_ra_prim_range    			:= clean_address[1..10];
		self.corp_ra_predir 	      		:= clean_address[11..12];
		self.corp_ra_prim_name 	  			:= clean_address[13..40];
		self.corp_ra_addr_suffix   			:= clean_address[41..44];
		self.corp_ra_postdir 	    		:= clean_address[45..46];
		self.corp_ra_unit_desig 	  		:= clean_address[47..56];
		self.corp_ra_sec_range 	  			:= clean_address[57..64];
		self.corp_ra_p_city_name	  		:= clean_address[65..89];
		self.corp_ra_v_city_name	  		:= clean_address[90..114];
		self.corp_ra_state 			    	:= clean_address[115..116];
		self.corp_ra_zip5 		      		:= clean_address[117..121];
		self.corp_ra_zip4 		      		:= clean_address[122..125];
		self.corp_ra_cart 		      		:= clean_address[126..129];
		self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
		self.corp_ra_lot 		      		:= clean_address[131..134];
		self.corp_ra_lot_order 	  			:= clean_address[135];
		self.corp_ra_dpbc  	      			:= clean_address[136..137];
		self.corp_ra_chk_digit 	  			:= clean_address[138];
		self.corp_ra_rec_type		  		:= clean_address[139..140];
		self.corp_ra_ace_fips_st	  		:= clean_address[141..142];
		self.corp_ra_county 	  			:= clean_address[143..145];
		self.corp_ra_geo_lat 	    		:= clean_address[146..155];
		self.corp_ra_geo_long 	    		:= clean_address[156..166];
		self.corp_ra_msa 		      		:= clean_address[167..170];
		self.corp_ra_geo_blk				:= clean_address[171..177];
		self.corp_ra_geo_match 	  			:= clean_address[178];
		self.corp_ra_err_stat 	    		:= clean_address[179..182];
		
		self								:= input;
		self								:= [];

	end; 



	// cleaning routine ends

//---------------------------------Event File Mapping-09/01/07------------------------------------------------------//

	Corp2.Layout_Corporate_Direct_Event_In NM_eventTransform(layouts_raw_input.EventLayout input):= transform,
								skip(trimUpper(input.Instrm_type) in ['COR','IS'])
	
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor					:= '35';
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;
		self.corp_sos_charter_nbr 			:= trim(input.Nmscc_no,left,right);
	
		self.event_filing_date				:= trim(input.file_date,left,right);

		self.event_filing_cd				:= trim(input.instrm_type,left,right);
		
		self.event_filing_desc				:= case(trimUpper(input.Instrm_type),
													'AB'=>'AMENDED/REVISED BYLAWS',									
													'ACA'=>'AMENDED CERTIFICATE OF AUTHORITY',								
													'ACR'=>'AMENDED CERTIFICATE OF REGISTRATION',									
													'AI'=>'ADDITIONAL INFORMATION',									
													'BK'=>'BANKRUPTCY RECEIVERSHIP',									
													'CAM'=>'CERTIFICATE OF AMENDMENT',									
													'CAR'=>'CANCELLATION OF CERTIFICATE OF REGISTRATION',									
													'CLI'=>'COOPERATIVE LICENSE',									
													'COA'=>'CERTIFICATE OF AUTHORITY',									
													'COC'=>'CERTIFICATE OF CONSOLIDATION',									
													'COD'=>'CERTIFICATE OF DISSOLUTION',									
													'COE'=>'CERTIFICATE OF EXCHANGE',									
													'COG'=>'CERTIFICATE OF ORGANIZATION',									
													'COI'=>'CERTIFICATE OF INCORPORATION',									
													'COM'=>'CERTIFICATE OF MERGER',									
													'COR'=>'CERTIFICATE OF REDUCTION OF STOCK',									
													'COW'=>'CERTIFICATE OF WITHDRAWAL',									
													'CRG'=>'CERTIFICATE OF REGISTRATION',									
													'CRV'=>'CERTIFICATE OF REVOCATION',									
													'EE'=>'EXISTENCE EXPIRED AUTOMATICALLY',									
													'FAM'=>'FOREIGN AMENDMENT',									
													'FF'=>'FORFEITED',									
													'FMG'=>'FOREIGN MERGER',									
													'IB'=>'INITIAL BYLAWS',									
													'IS'=>'INITIAL STOCK',									
													'IVS'=>'INVOLUNTRY STRICKEN',									
													'KC'=>'KEY CHANGE',									
													'OUO'=>'OFFICE USE ONLY',									
													'RB'=>'RESTATED BYLAWS',									
													'RCI'=>'RESTATED CERTIFICATE OF INCORPORATION',									
													'RCO'=>'RESTATED CERTIFICATE OF ORGANIZATION',									
													'RCR'=>'RESCIND CERTIFICATE OF REVOCATION',									
													'RI'=>'REINSTATEMENT',									
													'ROB'=>'RESUMPTION OF BUSINESS',									
													'RTC'=>'RESCIND TAX CLEARANCE',									
													'SID'=>'STATEMENT OF INTENT TO DISSOLVE',									
													'SRD'=>'STATEMENT OF REVOCATION OF VOLUNTARY DISSOLUTION',									
													'SU'=>'SUSPENSION OF BUSINESS',									
													'TC'=>'TAX CLEARANCE',									
													'CCN'=>'CERTIFICATE OF CONVERSION', 
													'');
		
		self.event_desc						:= trimUpper(input.Instrm_text); 

		self.event_filing_reference_nbr     := trimUpper(input.Instrm_Nbr); 	

		self								:=[];

	end;
	
 //-------------------------------------------------stock transform------------------------------------------------------// 

	Corp2.Layout_Corporate_Direct_Stock_In NM_stockTransform(layouts_raw_input.EventLayout input):= transform,
														skip(trimUpper(input.Instrm_type) not in ['COR','IS'])
														
		self.corp_key					:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor				:= '35';
		self.corp_state_origin			:= 'NM';
		self.corp_process_date			:= fileDate;
		self.corp_sos_charter_nbr 		:= trim(input.Nmscc_no,left,right);

		stockRef						:= if(trimUpper(input.instrm_nbr)<>'',
											 'REFERENCE NUMBER: ' + trimUpper(input.instrm_nbr),
											 ''); 
        temp                            := trim(input.file_date,left,right);
		
		fileStockDate					:= if(trimUpper(input.file_date)<>'',
															 'FILING DATE: ' + 
																temp[5..6] +
																'/' +
																temp[7..8] + 
																'/' +
																temp[1..4],
															 '');
		
		filingType					  	:= 'FILING TYPE: ' +									
											trim(map(trimUpper(input.Instrm_type)='COR'=>'CERTIFICATE OF REDUCTION OF STOCK',
												trimUpper(input.Instrm_type)='IS'=>'INITIAL STOCK',
												''),left,right);
																 
		stockDesc     					:= if(trimUpper(input.instrm_text)<>'',
											 'DESCRIPTION: ' + trimUpper(input.instrm_text),
											 '');																 
														 
		all_addl_info					:= stockRef 	   + ';' +
											 fileStockDate + ';' +
											 filingType    + ';' +
											 stockDesc;
								
		self.stock_addl_info			:= regexreplace('(;){1,}$',regexreplace('(;){2,}',all_addl_info,';'),'');
																																				
		self							:=[];
		end;




//---------------------------------Cont File Mapping-09/01/07-------------------------------------------------------//

	
	corp2_mapping.Layout_ContPreClean NM_contTransform1(layouts_raw_input.CorpLayout input):= transform, skip(trim(input.corp_pres,left,right) = '' or trim(stringlib.StringtoUpperCase(input.corp_pres),left,right) = 'NONE')	
		
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor					:= '35';
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.Nmscc_no,left,right);
		
		self.corp_legal_name				:= if(trim(input.corp_name,left,right)<>'',input.corp_name,'');
							
	
		
		self.cont_name						:= if(trim(input.corp_pres,left,right)<>'' and trim(stringlib.StringtoUpperCase(input.corp_pres),left,right)<>'NONE',trim(input.corp_pres,left,right),'');
		
		
										
		self.cont_title1_desc				:= if(trim(input.corp_pres,left,right)<>'','PRESIDENT','');
		self.cont_type_cd					:= if(trim(input.corp_pres,left,right)<>'','F','');
		self.cont_type_desc					:= if(trim(input.corp_pres,left,right)<>'','OFFICER','');

		self								:=[];

	end;// cont transform ends



	corp2_mapping.Layout_ContPreClean NM_contTransform2(layouts_raw_input.CorpLayout input):= transform, skip(trim(input.corp_vicepres,left,right) = '' or trim(stringlib.StringtoUpperCase(input.corp_vicepres),left,right) = 'NONE')	
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		
		
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor					:= '35';
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.Nmscc_no,left,right);
									
		self.corp_legal_name				:= if(trim(input.corp_name,left,right)<>'',input.corp_name,'');

		self.cont_name						:= if(trim(input.corp_vicepres,left,right)<>'' and trim(stringlib.StringtoUpperCase(input.corp_vicepres),left,right)<>'NONE',trim(input.corp_vicepres,left,right),'');

	
										
		self.cont_title1_desc				:= if(trim(input.corp_vicepres,left,right)<>'','VICE PRESIDENT','');
		self.cont_type_cd					:= if(trim(input.corp_vicepres,left,right)<>'','F','');
		self.cont_type_desc					:= if(trim(input.corp_vicepres,left,right)<>'','OFFICER','');

		self								:=[];

	end;// cont transform ends


corp2_mapping.Layout_ContPreClean NM_contTransform3(layouts_raw_input.CorpLayout input):= transform, skip(trim(input.corp_sec,left,right) = '' or trim(stringlib.StringtoUpperCase(input.corp_sec),left,right) = 'NONE')		
		
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor					:= '35';
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.Nmscc_no,left,right);

		self.corp_legal_name				:= if(trim(input.corp_name,left,right)<>'',input.corp_name,'');
		
										
			
		
										
		

		self.cont_name						:= if(trim(input.corp_sec,left,right)<>'' and trim(stringlib.StringtoUpperCase(input.corp_sec),left,right)<>'NONE',trim(input.corp_sec,left,right),'');

	
										
		self.cont_title1_desc				:= if(trim(input.corp_sec,left,right)<>'','SECRETARY','');
		self.cont_type_cd					:= if(trim(input.corp_sec,left,right)<>'','F','');
		self.cont_type_desc					:= if(trim(input.corp_sec,left,right)<>'','OFFICER','');

		self								:=[];

	end;// cont transform ends



	corp2_mapping.Layout_ContPreClean NM_contTransform4(layouts_raw_input.CorpLayout input):= transform, skip(trim(input.corp_tres,left,right) = '' or trim(stringlib.StringtoUpperCase(input.corp_tres),left,right) = 'NONE' )
		
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		
		
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor					:= '35';
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.Nmscc_no,left,right);
		
		self.corp_legal_name				:= if(trim(input.corp_name,left,right)<>'',input.corp_name,'');
										
		self.cont_name						:= if(trim(input.corp_tres,left,right)<>'' and trim(stringlib.StringtoUpperCase(input.corp_tres),left,right)<>'NONE',trim(input.corp_tres,left,right),'');

	
										
		self.cont_title1_desc				:= if(trim(input.corp_tres,left,right)<>'','TREASURER','');
		self.cont_type_cd					:= if(trim(input.corp_tres,left,right)<>'','F','');
		self.cont_type_desc					:= if(trim(input.corp_tres,left,right)<>'','OFFICER','');

		self								:=[];

	end;// cont transform ends


	
	corp2_mapping.Layout_ContPreClean NM_contTransform5(layouts_raw_input.CorpDirectorLayout input):= transform, skip((trim(input.last_nm,left,right) = '' and trim(input.first_nm,left,right)='' and trim(input.mid_nm,left,right)='') or 
																				(trim(stringlib.StringtoUpperCase(input.last_nm),left,right) = 'NONE' and trim(stringlib.StringtoUpperCase(input.first_nm),left,right)='NONE' and trim(stringlib.StringtoUpperCase(input.mid_nm),left,right)='NONE'))


		
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		
		self.corp_key						:= '35-' +trim(input.Nmscc_no, left, right);
		self.corp_vendor					:= '35';
		self.corp_state_origin				:= 'NM';
		self.corp_process_date				:= fileDate;
		self.corp_orig_sos_charter_nbr		:= trim(input.Nmscc_no,left,right);
		
	

		self.corp_legal_name				:= if(trim(input.corp_name,left,right)<>'',input.corp_name,'');

		

		
		directorname					:= if(trim(input.last_nm+','+input.first_nm+','+input.mid_nm,left,right)<>'',trim(input.last_nm+','+input.first_nm+','+input.mid_nm,left,right),'');								

		
						
		self.cont_name					:= if(trim(directorname,left,right)<>'' and trim(stringlib.StringtoUpperCase(directorname),left,right)<>'NONE',trim(directorname,left,right),'');

	
										
		self.cont_title1_desc				:= if(trim(directorname,left,right)<>'','DIRECTOR','');
		self.cont_type_cd					:= if(trim(directorname,left,right)<>'','F','');
		self.cont_type_desc				:= if(trim(directorname,left,right)<>'','OFFICER','');

		self								:=[];

	end;// cont transform ends


	//---------------------------- Clean CONT ---------------------//

		Corp2.Layout_Corporate_Direct_Cont_In CleanConts(corp2_mapping.Layout_ContPreClean input) := transform
			string73 tempname 				:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 						:= Address.CleanNameFields(tempName);
			cname 						:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1					:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score,'');	
				

			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
													trim(input.cont_address_line2,left,right),left,right),														                   
													trim(trim(input.cont_address_line3,left,right) + ', ' +
													trim(input.cont_address_line4,left,right) + ' ' +
													trim(input.cont_address_line5,left,right),left,right));
	
	
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      			:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   			:= clean_address[41..44];
			self.cont_postdir 	    			:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	  			:= clean_address[90..114];
			self.cont_state 					:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		      			:= clean_address[122..125];
			self.cont_cart 		      			:= clean_address[126..129];
			self.cont_cr_sort_sz 	 			:= clean_address[130];
			self.cont_lot 		      			:= clean_address[131..134];
			self.cont_lot_order 	  			:= clean_address[135];
			self.cont_dpbc 		      			:= clean_address[136..137];
			self.cont_chk_digit 	  			:= clean_address[138];
			self.cont_rec_type		  			:= clean_address[139..140];
			self.cont_ace_fips_st	  			:= clean_address[141..142];
			self.cont_county 	  				:= clean_address[143..145];
			self.cont_geo_lat 	    			:= clean_address[146..155];
			self.cont_geo_long 	    			:= clean_address[156..166];
			self.cont_msa 		      			:= clean_address[167..170];
			self.cont_geo_blk					:= clean_address[171..177];
			self.cont_geo_match 	  			:= clean_address[178];
			self.cont_err_stat 	    			:= clean_address[179..182];
			self								:= input;
			
			self								:= [];
		end;
 

	// cleaning routine ends

	
	mapCorp			:= project(CorpFile,NM_corpMainTransform(LEFT));
	
	
	corp2_mapping.Layout_CorpPreClean
 StateTypeCode(corp2_mapping.Layout_CorpPreClean input, StateCodeLayout r ) := transform

			

			self.corp_forgn_state_desc    := stringlib.StringtoUpperCase(r.StateDesc);

		

			self         		    := input;
			self                        := [];
	end; // end transform

	joinStateType := 	join(mapCorp,StateCodeTable,
						trim(left.corp_forgn_state_cd,left,right) = trim(right.StateCode,left,right),
							StateTypeCode(left,right),
								left outer, lookup
							);
							
	

	corp2_mapping.Layout_CorpPreClean
 CountryTypeCodeDesc(corp2_mapping.Layout_CorpPreClean input, StateCodeLayout r ) := transform
			

			self.corp_address1_line5    := stringlib.StringtoUpperCase(r.StateDesc);

			

			self         		    := input;
			self                        := [];
	end; // end transform
		

	
	//CountryCode join
	joinCountryType := 	join(	joinStateType ,StateCodeTable,
						trim(left.corp_address1_line5,left,right) = trim(right.StateCode,left,right),
									CountryTypeCodeDesc(left,right),
									left outer, lookup
								);


	// merging corplayout and directorlayout	

	Layouts_Raw_Input.CorpDirectorLayout MergeCorpWithDirector(Layouts_Raw_Input.CorpLayout l, Layouts_Raw_Input.DirectorLayout r ) := transform

		self 					:= l;
		self					:= r;
		self					:= [];
	end; // end merging

	joinCorpWithDirector 		:= join(Corpfile,DirFile,
										trim(left.Nmscc_no, left, right) = right.Nmscc_no,
										MergeCorpWithDirector(left,right),
										left outer, local);

	
	//cleaning corps 
	cleanedCorps		:= project(joinCountryType,CleanCorpNameAddr(left));


	mapevent			:= project(EventFile,NM_eventTransform(left));

		

	mapStock			:= project(EventFile,NM_stockTransform(left));

	

	

	mapcont				:= project(Corpfile,NM_contTransform1(left))+project(Corpfile,NM_contTransform2(left))+project(Corpfile,NM_contTransform3(left))+
							project(Corpfile,NM_contTransform4(left))+project(joinCorpWithDirector ,NM_contTransform5(left));

	CleanCont			:= project(mapcont,CleanConts(left));



	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_nm'	,cleanedCorps	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_nm'	,mapevent			,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_nm'	,mapstock			,stock_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_nm'	,CleanCont		,cont_out		,,,pOverwrite);
                                    
	mappedNM_Filing 				:= parallel(                                                                                                                        
		 corp_out																						
		,event_out
		,stock_out
		,cont_out					
	);										
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('nm',filedate,pOverwrite := pOverwrite))
			,mappedNM_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_nm')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_nm')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_nm')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_nm')
			)
		);

	return result;

  end;  // end of update function  

end;// end of NM 
