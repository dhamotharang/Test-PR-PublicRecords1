import Corp2,  Address,corp2_mapping, _Control, versioncontrol;

export KY(string8 fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) 
:=FUNCTION
//**************************************************************************
// 									vendor data format
//**************************************************************************

dleag :=['05','06','08','09','10','15','16','17','18'];

Layout_Company 
:= RECORD, maxlength(4096)
	STRING ID;
	STRING comptype;
	STRING compseq;
	STRING Name;
	STRING Standing;
	STRING Status;
	STRING Country;
	STRING State;
	STRING Type1;
	STRING raname;
	STRING raaddr1;
	STRING raaddr2;
	STRING raaddr3;
	STRING raaddr4;
	STRING racity;
	STRING rastate;
	STRING razip;
	STRING poaddr1;
	STRING poaddr2;
	STRING poaddr3;
	STRING poaddr4;
	STRING pocity;
	STRING postate;
	STRING pozip;
	STRING filedate;
	STRING orgdate;
	STRING authdate;
	STRING RECORDdate;
	STRING raresdte;
	STRING expdte;
	STRING rENDte;
	STRING numofcr;
	STRING numofshr;
	STRING mangnum;
	STRING applname;
	STRING appltitl;
	STRING parpre;
	STRING parcomno;
	STRING parcom;
	STRING parpreno;
	STRING profit; 
	STRING RECORDnumber;
END;

Layout_Officer 
:= RECORD, maxlength(4096)
	STRING ID;
	STRING comptype;
	STRING compseq;
	STRING Type1;
	STRING fname;
	STRING mname;
	STRING lname;
	STRING chgdate;
	STRING RECORDnumber;
END; 
//**************************************************************************
// 									Mapping corp, stock, cont
//**************************************************************************

Corp2.Layout_Corporate_Direct_Cont_in  Trans_addCorp(Layout_Officer pleft,corp2.layout_Corporate_Direct_Corp_in pRight )
:=TRANSFORM 
    
	SELF.cont_type_cd				:= 'F';
	SELF.cont_type_desc				:= 'OFFICER'; 	
	SELF.cont_name				    := StringLib.StringToUpperCase(REGEXREPLACE('[ ]+',pleft.FNAME+' '+pleft.MNAME+' '+pleft.LNAME,' '));
	SELF.CONT_TITLE1_DESC           := corp2_mapping.functions.decode_titleType(pLeft.Type1);
	
	SELF							:= pRight;
	SELF                            := [];
END;

Corp2.Layout_Corporate_Direct_Cont_in  Trans_Join(Layout_company pleft,corp2.layout_Corporate_Direct_Corp_in pRight )
:=TRANSFORM 
    
	title                        	:= corp2_mapping.functions.Decode_apptitle(pLeft.appltitl);	
		
	SELF.cont_type_cd				:= 'F';
	SELF.cont_type_desc				:= 'OFFICER'; 	
	SELF.cont_name				    :=  pLeft.APPLNAME;
	SELF.CONT_TITLE1_DESC           :=  title;
	SELF							:=  pRight;
	SELF                            :=  [];
END; 
corp2.layout_Corporate_Direct_Corp_in Trans_Corp(Layout_Company pInput, UNSIGNED2 c)
:=TRANSFORM 

    STRING1 cleanStatus				:= corp2_mapping.functions.TRIMUpper(pInput.status);
	STRING  state                   := IF(corp2_mapping.functions.TRIMUpper(pInput.state+pInput.country)='','KY',
										 IF(pInput.state<>'',corp2_mapping.functions.TRIMUpper(pInput.state),corp2_mapping.functions.TRIMUpper(pInput.country)));
	STRING  nameTypeCD				:= MAP(pInput.CompType='11'=>'I',pInput.CompType='02'=>'07',
			                               pInput.Comptype='01'=>'09',pInput.CompType='07'=>'06',
										REGEXFIND('3|4|2',pInput.CompType)=>'06','01');
												   
	SELF.dt_first_seen				:= version;
	SELF.dt_last_seen				:= version;
	SELF.dt_vENDor_first_reported	:= version;
	SELF.dt_vENDor_last_reported	:= version;
	SELF.corp_ra_dt_first_seen		:= corp2_mapping.functions.reformatDate2(pInput.ORGDATE);
	SELF.corp_ra_dt_last_seen		:= corp2_mapping.functions.reformatDate2(pInput.ORGDATE);			
	SELF.corp_key					:= '21-' + corp2_mapping.functions.TRIMUpper(pInput.ID);
	SELF.corp_vENDor				:= '21';
	SELF.corp_state_origin			:= 'KY';
	SELF.corp_process_date			:= version;
	SELF.corp_src_type				:= 'SOS';						
	SELF.corp_orig_sos_charter_nbr	:= pInput.id;
	SELF.corp_filing_date           := corp2_mapping.functions.reformatDate2(pInput.filedate);
    SELF.corp_inc_state				:= IF(state<> 'KY','',State);
	SELF.corp_forgn_state_cd        := IF(state = 'KY','',State);												   
	SELF.corp_forgn_state_desc      := IF(state = 'KY','',
										IF(corp2_mapping.functions.decode_state(State)='',
										   corp2_mapping.functions.decode_country(State),corp2_mapping.functions.decode_state(State)));												   
	SELF.corp_status_cd				:= IF(cleanStatus <>'D',cleanStatus,'');													   
	SELF.corp_status_desc			:= CASE(cleanStatus,'A'=>'ACTIVE','C'=>'CROSS REFERENCE',
										 'I'=>'INACTIVE','X'=>'PENDING DISSOLUTION','');
    SELF.corp_legal_name			:= corp2_mapping.functions.TRIMUpper(pInput.name); 
	SELF.CORP_LN_NAME_TYPE_CD       := IF(nameTypeCD='01' and C>1,'P',nameTypeCD);
	SELF.CORP_LN_NAME_TYPE_DESC     := CASE(SELF.CORP_LN_NAME_TYPE_CD ,'01'=>'LEGAL','P'=>'PRIOR','06'=>'ASSUMED','07'=>'RESERVED',
			                                '09'=>'REGISTRATION','I'=>'OTHER','');
	SELF.corp_address1_line1 		:= corp2_mapping.functions.TRIMUpper(pInput.poADDR1);
	SELF.corp_address1_line2		:= corp2_mapping.functions.TRIMUpper(pInput.poADDR2);
	SELF.corp_address1_line3		:= corp2_mapping.functions.TRIMUpper(pInput.poADDR3);
	SELF.corp_address1_line4		:= corp2_mapping.functions.TRIMUpper(pInput.poADDR4);
	SELF.corp_address1_line5		:= corp2_mapping.functions.TRIMUpper(pInput.pocity+' '+pinput.postate+' '+pInput.pozip);
	SELF.corp_address1_type_cd		:= IF(TRIM(pInput.poADDR1+pInput.poADDR2+pInput.poADDR3+pInput.poADDR4+
										    pInput.pocity+pinput.postate+pInput.pozip,ALL) <> '' ,'B','' );
	SELF.corp_address1_type_desc	:= IF(SELF.corp_address1_type_cd<>'','BUSINESS','');
	SELF.corp_ra_name				:= corp2_mapping.functions.TRIMUpper(pInput.raname) ;
	SELF.corp_ra_address_line1 		:= corp2_mapping.functions.TRIMUpper(pInput.raADDR1);
	SELF.corp_ra_address_line2		:= corp2_mapping.functions.TRIMUpper(pInput.raADDR2);
	SELF.corp_ra_address_line3		:= corp2_mapping.functions.TRIMUpper(pInput.raADDR3);
	SELF.corp_ra_address_line4		:= corp2_mapping.functions.TRIMUpper(pInput.raADDR4);
	SELF.corp_ra_address_line5		:= corp2_mapping.functions.TRIMUpper(pInput.racity+' '+pinput.rastate+' '+pInput.razip);
	SELF.corp_ra_address_type_cd    := IF(TRIM(pInput.raADDR1+pInput.raADDR2+pInput.raADDR3+pInput.raADDR4+
											pInput.racity+pinput.rastate+pInput.razip,ALL)<>'','G','');
	SELF.corp_ra_address_type_desc	:= IF(SELF.corp_ra_address_type_cd<>'','REGISTERED OFFICE','');		
	SELF.CORP_RA_RESIGN_DATE        := corp2_mapping.functions.reformatDate2(pInput.raresdte);
	SELF.corp_inc_date              := IF(state='KY',corp2_mapping.functions.reformatDate2(pInput.ORGDATE),'');
	SELF.corp_forgn_date 			:= IF(state='KY','',corp2_mapping.functions.reformatDate2(pInput.ORGDATE));
	SELF.CORP_TERM_EXIST_EXP        := IF(state='KY',corp2_mapping.functions.reformatDate2(pInput.EXPDTE),'');
	SELF.CORP_TERM_EXIST_CD         := IF(pInput.EXPDTE<>'' and state='KY','D','');
	SELF.CORP_TERM_EXIST_DESC       := IF(pInput.EXPDTE<>'' and state='KY','EXPIRATION DATE','');
	SELF.CORP_forgn_TERM_EXIST_EXP  := IF(state<>'KY',corp2_mapping.functions.reformatDate2(pInput.EXPDTE),'');
	SELF.CORP_forgn_TERM_EXIST_CD   := IF(pInput.EXPDTE<>'' and state<>'KY','D','');
	SELF.CORP_forgn_TERM_EXIST_DESC := IF(pInput.EXPDTE<>'' and state<>'KY','EXPIRATION DATE','');
	SELF.CORP_STANDING              := CASE(pInput.STANDING,'G'=>'Y','B'=>'N','');
	SELF.CORP_FOR_PROFIT_IND        := IF(pInput.PROFIT='P','Y',pInput.PROFIT);
	SELF.CORP_ADDL_INFO				:= IF(pInput.AUTHDATE<>'','AUTHORITY DATE:'+pInput.AUTHDATE+
			                              CASE(pInput.MANGNUM,'1'=>'MANAGED BY:MEMBERS','2'=>'MANAGED BY:MANAGERs',''),'');
	SELF.corp_orig_org_structure_cd := pInput.type1;
	SELF.corp_orig_org_structure_desc:= corp2_mapping.functions.Decode_Corp_STRUCTURE(pInput.type1);														   			
	SELF := [];
END;

corp2.layout_Corporate_Direct_stock_in Trans_stock(Layout_Company pInput, UNSIGNED1 c )
:=TRANSFORM 
	
    STRING  nameTypeCD				:= MAP(pInput.CompType='11'=>'I',pInput.CompType='02'=>'07',
			                               pInput.Comptype='01'=>'09',pInput.CompType='07'=>'06',
										REGEXFIND('3|4|2',pInput.CompType)=>'06','01');
	STRING  AUTHORIZED_NBR     		:= REGEXREPLACE('^0+',pInput.NUMOFSHR,'');
	SELF.corp_key					:= '21-' + corp2_mapping.functions.TRIMUpper(pInput.ID);
	SELF.corp_vENDor				:= '21';
	SELF.corp_state_origin			:= 'KY';
	SELF.corp_process_date			:= version;
	SELF.corp_sos_charter_nbr	 	:= pInput.ID;
	SELF.STOCK_AUTHORIZED_NBR		:= IF(REGEXREPLACE('^0+',pInput.NUMOFSHR,'')<>'',REGEXREPLACE('^0+',pInput.NUMOFSHR,''),
										CHOOSE(C,REGEXREPLACE('^0+',pInput.PARCOMNO,''),REGEXREPLACE('^0+',pInput.PARPRENO,'')));
	SELF.STOCK_PAR_VALUE			:= IF(REGEXREPLACE('^0+',pInput.PARPRE,'')='','',REGEXREPLACE('^0+',pInput.PARPRE,''));
	SELF.STOCK_SHARES_ISSUED		:= CHOOSE(C,REGEXREPLACE('^0+',pInput.PARCOMNO,''),REGEXREPLACE('^0+',pInput.PARPRENO,''));
	SELF.STOCK_TYPE                 := CHOOSE(C,IF(REGEXREPLACE('^0+',pInput.parcomno+pInput.parcom,'')<>'','COMMON',''),
			                              IF(REGEXREPLACE('^0+',pInput.parpreno+pInput.parpre,'')<>'','PREFERRED',''),'');
    SELF 							:= [];
END;

dCompanyIn:=DATASET('~thor_data400::in::corp2::'+filedate+'::companies::ky',Layout_Company ,CSV(HEADING(0),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
dOfficerIn:=DATASET('~thor_data400::in::corp2::'+filedate+'::Officer::ky',Layout_Officer ,CSV(HEADING(0),SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n'])));
dGroup    :=GROUP(SORT(DISTRIBUTE(dCompanyIn,HASH(ID)),ID,IF(CompType in dleag,0,1),compseq,LOCAL),ID);
dCorp     :=Functions.CleanCorp(UNGROUP(PROJECT(dGroup ,Trans_Corp(LEFT, COUNTER))));
dDedup    :=DEDUP(dCorp,corp_key[4..10],corp_key[13..17]);
dStock	  :=NORMALIZE(dCompanyIn(REGEXREPLACE('^0+',NUMOFSHR+parcomno+parcom+parpreno+parpre,'')<>''),2,Trans_stock(left,counter));
dOfficer  :=JOIN(dOfficerIn,dDedup , LEFT.id=RIGHT.corp_orig_sos_charter_nbr ,Trans_addCorp(left,right));
dRa       :=JOIN(dCompanyIn(APPLNAME<>''),dCorp , '21-'+LEFT.id=RIGHT.corp_key,Trans_Join(left,right));
Dcont     :=dedup((dOfficer+dRa)(cont_name<>''),all)  ;
DCleanCont:=Corp2_Mapping.Functions.CleanCont(Dcont);
//**************************************************************************
// 									Output
//**************************************************************************
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::corp::KY'	,dedup(dCorp,ALL)																																						,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::cont::KY'	,dedup(DCleanCont,EXCEPT corp_key, ALL)																											,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+filedate+'::stock::KY'	,dedup(dStock(STOCK_AUTHORIZED_NBR+STOCK_PAR_VALUE+STOCK_TYPE +STOCK_SHARES_ISSUED<>''),all),stock_out,,,pOverwrite);
                                                                                   
dOut:= sequential(
	 corp_out	
	,cont_out	
	,stock_out
);
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ky',filedate,pOverwrite := pOverwrite))
			,dOut
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+fileDate+'::corp::KY')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+fileDate+'::cont::KY')
				,Fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+fileDate+'::stock::KY')
			)
		);
		return result;
				  
END;