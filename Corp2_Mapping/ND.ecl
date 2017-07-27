
import Corp2,ut,Corp2_Mapping, lib_stringlib, _validate, Address, _control, versioncontrol; 

 export ND:= MODULE; // __ ND module has seven vendor layouts
   export Layouts_Raw_Input := MODULE;
        export CORPORATIONREC1:= record
         string10 	CBSID;
         string4 	CBCTYP;
         string1 	CBCST;
         string1 	dummy1;
         string10 	CBCSTD;
         string10 	CBODF;
         string2 	CBSOO;
         string1200 NNAM;
         string30 	NADD1;
         string30 	NADD2;
         string20 	NCITY;
         string2 	NSTAT;
         string10 	NZIP;
         string39 	CRANM1;
         string37 	CRANM2;
         string30 	CRADR1;
         string30 	CRADR2;
         string20 	CRACTY;
         string2 	CRAST;
         string10 	CRAZIP;
         string6 	CSHCLS;
         string20 	CSHNO;
         string20 	CSHPV;
         string1 	CSHNP;
         string6 	CSHCLS01;
         string20 	CSHNO01;
         string20 	CSHPV01;
         string1 	CSHNP01;
         string6 	CSHCLS02;
         string20 	CSHNO02;
         string20 	CSHPV02;
         string1 	CSHNP02;
         string6 	CSHCLS03;
         string20 	CSHNO03;
         string20 	CSHPV03;
         string1 	CSHNP03;
         string6 	CSHCLS04;
         string20 	CSHNO04;
         string20 	CSHPV04;
         string1 	CSHNP04;
         string6 	CSHCLS05;
         string20 	CSHNO05;
         string19 	CSHPV05;
         string1 	CSHNP05;
		 string122 	CORP_CNNOB ;
		 
	   end;
	   
       export CORPORATIONREC2:= record
         string10 	CORP_CBSID;
         string4 	CORP_CBCTYP;
         string1 	CORP_CBCST;
         string1 	CORP_dummy1;
         string10 	CORP_CBCSTD;
         string10 	CORP_CBODF;
         string2 	CORP_CBSOO;
         string1200 CORP_NNAM;
         string30 	CORP_NADD1;
         string30 	CORP_NADD2;
         string20 	CORP_NCITY;
         string2 	CORP_NSTAT;
         string10 	CORP_NZIP;
         string39 	CORP_CRANM1;
         string37 	CORP_CRANM2;
         string30 	CORP_CRADR1;
         string30 	CORP_CRADR2;
         string20 	CORP_CRACTY;
         string2 	CORP_CRAST;
         string10 	CORP_CRAZIP;
         string6 	CORP_CSHCLS;
         string20 	CORP_CSHNO;
         string20 	CORP_CSHPV;
         string1 	CORP_CSHNP;
         string6 	CORP_CSHCLS01;
         string20 	CORP_CSHNO01;
         string20 	CORP_CSHPV01;
         string1 	CORP_CSHNP01;
         string6 	CORP_CSHCLS02;
         string20 	CORP_CSHNO02;
         string20 	CORP_CSHPV02;
         string1 	CORP_CSHNP02;
         string6 	CORP_CSHCLS03;
         string20 	CORP_CSHNO03;
         string20 	CORP_CSHPV03;
         string1 	CORP_CSHNP03;
         string6 	CORP_CSHCLS04;
         string20 	CORP_CSHNO04;
         string20 	CORP_CSHPV04;
         string1 	CORP_CSHNP04;
         string6 	CORP_CSHCLS05;
         string20 	CORP_CSHNO05;
         string19 	CORP_CSHPV05;
         string1 	CORP_CSHNP05;
		 string122	CORP1_CNNOB ;
        
	   end;	
	   
    
	   

       export FICTITIOUS_NAMES1:= record
         string10 	ESID;
         string1 	ECLST;
         string10 	ECSDT;
         string10 	EOLDT;
         string10 	ELRFD;
         string10 	ELAD;
         string1200 FICNNAM;
         string1200 FICNNAM01;
         string30 	FICNADD1;
         string30 	FICNADD2;
         string20	FICNCITY;
         string2 	FICNSTAT;
         string10 	FICNZIP;
         string58 	lf;

	   end;	
	   
	   
	 export FICTITIOUS_NAMES2:= record
         string10 	nESID;
         string1 	nECLST;
         string10 	nECSDT;
         string10 	nEOLDT;
         string10 	nELRFD;
         string10 	nELAD;
         string1200 nFICNNAM;
         string1200 nFICNNAM01;
         string30 	nFICNADD1;
         string30 	nFICNADD2;
         string20	nFICNCITY;
         string2 	nFICNSTAT;
         string10 	nFICNZIP;
         string58 	nlf;

	   end;	
	   
 
	   


       export PARTNERSHIPSREC1 := record
         string10 PAID;                
         string4 PATYPE;               
         string2 PASTAO;
         string1 PASTS;
         string1 dummy;                
         string10 PASTDT;
         string10 PADATE;
         string10 PALRFD;
         string10 PALAD;
         string10 PALRD;
         string351 PANAME;
         string30 PAADD1;              
         string30 PAADD2;              
         string20 PACITY;
         string2 PASTAT;
         string10 PAZIP;
         string39 PANAMER;
         string39 PANAMER2;
         string30 PAADDR1;
         string30 PAADDR2;
         string20 PACITYR;
         string2 PASTATR;
         string10 PAZIPR;
         string320  P01NAME;
		 string1200 lf1;
		 string1200 lf2;
		 string1200 lf3;
	     string1200 lf4;
		 string1200 lf5;
		 string1200 lf6;
		 string1200 lf7;
		 string1200 lf8;
		 string1200 lf9;
		 string1200 lf10;
		 string1200 lf11;
		 string800 lf12;


	   end;
       export TRADEMARKREC1:= record
	     string10 	RSID;
	     string2 	RSTAT;
	     string1	RCLST;
	     string10 	RCSDT;
	     string10 	ROLDT;
	     string10 	RLRFD;
	     string10 	RLAD;
	     string1200 TM_NNAM;
	     string1200 NNAM01;
	     string30 	OADD1;
	     string30 	OADD2;
	     string20 	OCITY;
	     string2 	OSTAT;
	     string10 	OZIP;
	     string4 	ICLASS;
	     string50 	RDSCL;
	     string2  	lf;

     
	   end;	
  export TRADEMARKREC2:= record
	     string10 	RSID;
	     string2 	RSTAT;
	     string1	RCLST;
	     string10 	RCSDT;
	     string10 	ROLDT;
	     string10 	RLRFD;
	     string10 	RLAD;
	     string1200 TM_NNAM;
	     string1200 NNAM01;
	     string30 	OADD1;
	     string30 	OADD2;
	     string20 	OCITY;
	     string2 	OSTAT;
	     string10 	OZIP;
	     string4 	ICLASS;
	     string50 	RDSCL;
	     string2  	lf;

     
	   end;	
	   
	   
       export TRADENAMEREC1:= record

         string10 	PSID;
         string1 	PCLST;
         string10 	PCSD8;
         string10 	POLD8;
         string10 	PLRD8;
         string10 	PLAD8;
         string1200 TN_NNAM;
         string1200 NNAM01;
         string30 	OADD1;
         string30 	OADD2;
         string20 	OCITY;
         string2 	OSTAT;
         string10 	OZIP;
         string108 	lf;

     
	   end;	
	   
	 export TRADENAMEREC2:= record

         string10 	PSID;
         string1 	PCLST;
         string10 	PCSD8;
         string10 	POLD8;
         string10 	PLRD8;
         string10 	PLAD8;
         string1200 TN_NNAM;
         string1200 NNAM01;
         string30 	OADD1;
         string30 	OADD2;
         string20 	OCITY;
         string2 	OSTAT;
         string10 	OZIP;
         string108 	lf;

     
	   end;	


	   
   end; // end of Layouts_Raw_Input module
   
   	export Files_Raw_Input := MODULE;
	
		export CORPORATIONREC1 (string fileDate)    := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Corpa_Vendor::nd',
														        layouts_Raw_Input.CORPORATIONREC1,flat);
																			 
		export CORPORATIONREC2(string fileDate)     := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Corpb_Vendor::nd',
														        layouts_Raw_Input.CORPORATIONREC2,flat);
															 
		export FICTITIOUS1_NAMES (string fileDate)  := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Fictitios1_Vendor::nd',
														        layouts_Raw_Input.FICTITIOUS_NAMES1,flat);
		export FICTITIOUS2_NAMES (string fileDate)  := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Fictitios2_Vendor::nd',
														        layouts_Raw_Input.FICTITIOUS_NAMES2,flat);														
													
		export PARTNERSHIPSREC1 (string fileDate)   := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Partnership_Vendor::nd',
		                                                        layouts_Raw_Input.PARTNERSHIPSREC1,flat);
		
		export TRADEMARKREC1 (string fileDate)       := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Trademarks1_Vendor::nd',
		                                                        layouts_Raw_Input.TRADEMARKREC1,flat);
		export TRADEMARKREC2 (string fileDate)       := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Trademarks2_Vendor::nd',
		                                                        layouts_Raw_Input.TRADEMARKREC2,flat);														
		export TRADENAMEREC1 (string fileDate)       := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Tradename1_Vendor::nd',
		                                                        layouts_Raw_Input.TRADENAMEREC1,flat);
       	export TRADENAMEREC2 (string fileDate)       := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::Tradename2_Vendor::nd',
		                                                        layouts_Raw_Input.TRADENAMEREC2,flat);												 
	
	end;	
 
  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
     //StateCountry type layout	
	    StateCountryLayout := record,MAXLENGTH(350)
			string code;
			string desc;
			
		end;							
		StateCountryTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::State_Country_Table::nd',StateCountryLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
   
        trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		corporation_names:=Files_Raw_Input.CORPORATIONREC1(fileDate) + Files_Raw_Input.CORPORATIONREC2(fileDate);
		ficticious_names := Files_Raw_Input.FICTITIOUS1_NAMES(fileDate) + Files_Raw_Input.FICTITIOUS2_NAMES(fileDate);
		trademark_names  := Files_Raw_Input.TRADEMARKREC1(fileDate) + Files_Raw_Input.TRADEMARKREC2(fileDate);
		tradename_files  := Files_Raw_Input.TRADENAMEREC1(fileDate) + Files_Raw_Input.TRADENAMEREC2(fileDate);
		
	    corp2_mapping.Layout_CorpPreClean nd_corp1Transform_Business(corporation_names  input):=transform,skip(trim(input.CBSID,left, right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='38-'+trim(input.CBSID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  := fileDate;  
			self.corp_src_type                    :='SOS';
     	    self.corp_orig_sos_charter_nbr        :=trim(input.CBSID, left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.NNAM,left,right) <> '','01','');
			self.corp_ln_name_type_desc           :=if(trim(input.NNAM,left,right) <> '','LEGAL','');
		    self.corp_legal_name                  :=if(trim(input.NNAM,left,right) <> '', trimUpper(input.NNAM),'');
			self.corp_orig_org_structure_cd       :=if(trim(input.CBCTYP,left,right)<>'',trimUpper(input.CBCTYP),'');
            self.corp_orig_org_structure_desc     :=map(trimUpper(input.CBCTYP)='AA'=>'AIRPORT AUTHORITIES',
                                                   trimUpper(input.CBCTYP)='BANK'  =>'STATE BANK',
                                                   trimUpper(input.CBCTYP)='BC'    =>'BUSINESS CORPORATION',
                                                   trimUpper(input.CBCTYP)='C'     =>'COOPERATIVE ASSOCIATION',
                                                   trimUpper(input.CBCTYP)='CH'    =>'INCORPORATED CHURCH',
                                                   trimUpper(input.CBCTYP)='CNPD'  =>'CERTIFIED NONPROFIT DEVELOPMENT CORPORATION',
                                                   trimUpper(input.CBCTYP)='CU'    =>'CREDIT UNION',
                                                   trimUpper(input.CBCTYP)='EC'    =>'ELECTRIC COOPERATIVE',
                                                   trimUpper(input.CBCTYP)='F'     =>'FOREIGN BUSINESS CORPORATION',
                                                   trimUpper(input.CBCTYP)='FARM'  =>'FARM CORPORATION',
                                                   trimUpper(input.CBCTYP)='FC'    =>'FOREIGN COOPERATIVE ASSOCIATION',
                                                   trimUpper(input.CBCTYP)='FLC'   =>'FOREIGN LIMITED LIABILITY COMPANY',
                                                   trimUpper(input.CBCTYP)='FMLC'  =>'FARM LIMITED LIABILITY COMPANY',
                                                   trimUpper(input.CBCTYP)='FNP'   =>'FOREIGN NONPROFIT CORPORATION',
                                                   trimUpper(input.CBCTYP)='FPC'   =>'FOREIGN PROFESSIONAL CORPORATION',
                                                   trimUpper(input.CBCTYP)='FPLC'  =>'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY',
                                                   trimUpper(input.CBCTYP)='GA'    =>'GRAZING ASSOCIATION',
                                                   trimUpper(input.CBCTYP)='IC'    =>'INSURANCE COMPANY',  		
                                                   trimUpper(input.CBCTYP)='ID'    =>'IRRIGATION DISTRICT',
                                                   trimUpper(input.CBCTYP)='LC'    =>'LIMITED LIABILITY COMPANY',
                                                   trimUpper(input.CBCTYP)='MAC'   =>'MUTUAL AID CORPORATION',
                                                   trimUpper(input.CBCTYP)='MP'    =>'MUNICIPAL POWER AGENCY',
                                                   trimUpper(input.CBCTYP)='NP'    =>'NONPROFIT CORPORATION',
                                                   trimUpper(input.CBCTYP)='PC'    =>'PROFESSIONAL CORPORATION',
                                                   trimUpper(input.CBCTYP)='PLC'   =>'PROFESSIONAL LIMITED LIABILITY COMPANY',
                                                   trimUpper(input.CBCTYP)='REIT'  =>'REAL ESTATE INVESTMENT TRUST',
                                                   trimUpper(input.CBCTYP)='SCD'   =>'SOIL CONSERVATION DISTRICT','');
			
         	self.corp_address1_type_cd            :=if(trim(input.NADD1,left,right) <> '' or trim(input.NADD2,left,right) <> '' or trim(input.NCITY,left,right) <> '' or trim(input.NZIP,left,right) <> ''or trim(input.NSTAT,left,right) <> '','M','');
			self.corp_address1_type_desc          :=if(trim(input.NADD1,left,right) <> '' or trim(input.NADD2,left,right) <> '' or trim(input.NCITY,left,right) <> '' or trim(input.NZIP,left,right) <> '' or trim(input.NSTAT,left,right) <> '','MAILING','');
			self.corp_address1_line1              :=if(trim(input.NADD1,left,right) <> '', trimUpper(input.NADD1),''); 
			self.corp_address1_line2              :=if(trim(input.NADD2,left,right) <> '', trimUpper(input.NADD2),''); 
			self.corp_address1_line3              :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.NCITY),'X',1) <>0 and trim(input.NCITY,left,right) <> '', trimUpper(input.	NCITY),'');  
			self.corp_address1_line4              :=if(trim(input.NSTAT,left,right) <> '', trimUpper(input.NSTAT),''); 
			ZipCode1                              :=if((string)((integer)trim(input.NZIP[1..5],left,right)) <> '0' and trim(input.NZIP[1..5],left,right)<>''and trimUpper(input.NZIP[1..5])<>'X',trim(input.NZIP[1..5],left,right),'');
			ZipExtension1                         :=if((string)((integer)trim(input.NZIP[6..10],left,right)) <> '0' and trim(input.NZIP[6..10],left,right)<>''and trimUpper(input.NZIP[6..10])<>'X',trim(input.NZIP[6..10],left,right),''); 
			self.corp_address1_line5              :=ZipCode1+ZipExtension1;

		    self.corp_status_cd                   :=if(trim(input.CBCST,left,right)<>'',trimUpper(input.CBCST),'');
            self.corp_status_desc                 := map(trimUpper(input.CBCST)='A'=>'ACTIVE AND IN GOOD STANDING',
                                                   trimUpper(input.CBCST)='C'=>'CONSOLIDATED WITH ANOTHER ORGANIZATION',
                                                   trimUpper(input.CBCST)='CV'=>'CONVERSION TO ALTERNATE CORP TYPE',
                                                   trimUpper(input.CBCST)='E'=>'EXPIRED',
                                                   trimUpper(input.CBCST)='I'=>'INVOLUNTARILY DISSOLVED OR TERMINATED',
                                                   trimUpper(input.CBCST)='M'=>'RETIRED BY MERGER',
                                                   trimUpper(input.CBCST)='N'=>'NOT IN GOOD STANDING',
                                                   trimUpper(input.CBCST)='R'=>'IN RECEIVERSHIP',
                                                   trimUpper(input.CBCST)='V '=>'VOLUNTARILY TERMINATED','');
												   
			self.corp_inc_date                    :=if(trim(input.CBODF ,left,right) <> ''and (string)((integer)trim(input.CBODF ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.CBODF ,left,right) ) and 
														_validate.date.fIsValid((trim(input.CBODF ,left,right) ),_validate.date.rules.DateInPast),
														trim(input.CBODF ,left,right),'');		
														
		    self.corp_status_date                 :=if(trim(input.CBCSTD,left,right) <> ''and (string)((integer)trim(input.CBCSTD,left,right)) <> '0' and _validate.date.fIsValid(trim(input.CBCSTD,left,right)) and 
														_validate.date.fIsValid((trim(input.CBCSTD,left,right)),_validate.date.rules.DateInPast),
														trim(input.CBCSTD,left,right),'');
			 string s1                            :=lib_stringlib.StringLib.StringFindReplace(lib_stringlib.StringLib.StringFindReplace(trim(input.CORP_CNNOB,left,right),'0',''),'.',''); 											
			self.corp_entity_desc				  :=if(trim(s1,left,right) <> '', trimUpper(s1),'');						
  		    self.corp_inc_state                   :=if(trim(input.CBSOO,left,right) = ''or trim( input.CBSOO,left,right) ='ND', 'ND','');
            self.corp_forgn_state_cd              :=if(trim(input.CBSOO,left,right) <>''or trim(trimUpper(input.CBSOO),left,right) <>'ND', trimUpper(input.CBSOO),'');
			 
			CORPCRANM1                           := if(not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'AGENT FOR',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'NONE',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'AGENT RESIGN',1) <> 0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'AGENT NOT',1)<>0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'AGENT RESIGNED',1) <> 0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'RESIGNED',1)<>0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'NONE APPOINTED',1)<> 0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM1),'AGENT RESIGNATION',1)<>0 ,
                                                      '' ,trimUpper(input.CRANM1));
													   
			CORPCRANM2                           := if(not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'AGENT FOR',2) <> 0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'NONE',2) <> 0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'AGENT RESIGN',2)<>0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'AGENT NOT',2) <> 0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'AGENT RESIGNED',2) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'RESIGNED',2) <> 0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'NONE APPOINTED',2)<>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.CRANM2),'AGENT RESIGNATION',2)<> 0 ,
                                                       '',trimUpper(input.CRANM2));
													   
													   
			raname1                               :=if(CORPCRANM1='' ,trimUpper(input.CRANM1),'');	
			raname2                               :=if(CORPCRANM2='' ,trimUpper(input.CRANM2),'');	
		    self.corp_ra_name                     :=raname1+raname2;
			self.corp_ra_addl_info                :=CORPCRANM1+CORPCRANM2; 
 
		    self.corp_ra_address_line1            :=if(trim(input.CRADR1,left,right) <> '', trimUpper(input.CRADR1),''); 
			self.corp_ra_address_line2            :=if(trim(input.CRADR2,left,right) <> '', trimUpper(input.CRADR2),''); 
			self.corp_ra_address_line3            :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.CRACTY),'X',1) <>0 and trim(input.CRACTY,left,right) <> '', trimUpper(input.CRACTY),'');  
			self.corp_ra_address_line4            :=if(trim(input.CRAST,left,right) <> '', trimUpper(input.CRAST),''); 
			ZipCode2                              :=if((string)((integer)trim(input.CRAZIP[1..5],left,right)) <> '0' and trim(input.CRAZIP[1..5],left,right)<>''and trimUpper(input.CRAZIP[1..5])<>'X',trim(input.CRAZIP[1..5],left,right),'');
			ZipExtension2                         :=if((string)((integer)trim(input.CRAZIP[6..10],left,right)) <> '0' and trim(input.CRAZIP[6..10],left,right)<>''and trimUpper(input.CRAZIP[6..10])<>'X',trim(input.CRAZIP[6..10],left,right),''); 
			self.corp_ra_address_line5            :=ZipCode2+ZipExtension2;
			self.corp_ra_address_type_desc        :=if(trim(input.CRADR1,left,right) <> '' or trim(input.CRADR2,left,right) <> ''or trim(input.CRACTY,left,right) <> ''or trim(input.CRAST,left,right) <> '' or trim(input.CRAZIP,left,right) <> '','REGISTERED OFFICE','');
			
		    self                                  := [];
		
        end; // end transform.
		
		
		
		    corp2_mapping.Layout_CorpPreClean nd_corp2Transform_Business(ficticious_names input):=transform,skip(trim(input.ESID,left, right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='38-'+trim(input.ESID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  := fileDate; 
			self.corp_src_type                    :='SOS';
     	    self.corp_orig_sos_charter_nbr        :=trim(input.ESID, left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.FICNNAM,left,right) <> '','F','');
			self.corp_ln_name_type_desc           :=if(trim(input.FICNNAM,left,right) <> '','FBN','');
		    self.corp_legal_name                  :=if(trim(input.FICNNAM,left,right) <> '', trimUpper(input.FICNNAM),'');
		    self.corp_status_cd                   :=if(trim(input.ECLST,left,right)<>'',trimUpper(input.ECLST),'');
            self.corp_status_desc                 := map(trimUpper(input.ECLST)='A'=>'ACTIVE',
                                                   trimUpper(input.ECLST)='E'=>'EXPIRED',
                                                   trimUpper(input.ECLST)='I'=>'INACTIVE',
                                                   trimUpper(input.ECLST)='V '=>'VOLUNTARILY TERMINATED','');
												   
		    self.corp_status_date                 :=if(trim(input.ECSDT,left,right) <> ''and (string)((integer)trim(input.ECSDT,left,right)) <> '0' and _validate.date.fIsValid(trim(input.ECSDT,left,right)) and 
														_validate.date.fIsValid((trim(input.ECSDT,left,right)),_validate.date.rules.DateInPast),
														trim(input.ECSDT,left,right),'');
														
            self.corp_filing_date                 :=if(trim(input.ELRFD ,left,right) <> ''and (string)((integer)trim(input.ELRFD ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.ELRFD ,left,right)) and 
														_validate.date.fIsValid((trim(input.ELRFD ,left,right) ),_validate.date.rules.DateInPast),trim(input.ELRFD ,left,right),if(trim(input.EOLDT ,left,right) <> ''and 
														 (string)((integer)trim(input.EOLDT ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.EOLDT ,left,right) ) and 
														_validate.date.fIsValid((trim(input.EOLDT ,left,right) ),_validate.date.rules.DateInPast),
														trim(input.EOLDT ,left,right),''));	
														
			self.corp_filing_desc                  :=if(trim(input.EOLDT ,left,right) <> ''and (string)((integer)trim(input.EOLDT ,left,right)) <> '0' and _validate.date.fIsValid(input.EOLDT ) and 
														_validate.date.fIsValid((input.EOLDT ),_validate.date.rules.DateInPast),
														'RENEWAL','');											
            self                                  := [];
		
        end; // end transform.
		
		    corp2_mapping.Layout_CorpPreClean nd_corp3Transform_Business(layouts_Raw_Input.PARTNERSHIPSREC1 input):=transform,skip(trim(input.PAID,left, right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='38-'+trim(input.PAID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  := fileDate;
			self.corp_src_type                    :='SOS';
     	    self.corp_orig_sos_charter_nbr        :=trim(input.PAID, left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.PANAME,left,right) <> '','01','');
			self.corp_ln_name_type_desc           :=if(trim(input.PANAME,left,right) <> '','LEGAL','');
		    self.corp_legal_name                  :=if(trim(input.PANAME,left,right) <> '', trimUpper(input.PANAME),'');
			self.corp_orig_org_structure_cd       :=if(trim(input.PATYPE,left,right)<>'',trimUpper(input.PATYPE),'');
            self.corp_orig_org_structure_desc     :=map(trimUpper(input.PATYPE)='G'=>'GENERAL PARTNERSHIP',
                                                   trimUpper(input.PATYPE)='L'=>'LIMITED PARTNERSHIP',
                                                   trimUpper(input.PATYPE)='LLLP'=>'LIMITED LIABILITY LIMITED PARTNERSHIP',
                                                   trimUpper(input.PATYPE)='LLP'=>'LIMITED LIABILITY PARTNERSHIP',
                                                   trimUpper(input.PATYPE)='LP'=>'LIMITED PARTNERSHIP',
                                                   trimUpper(input.PATYPE)='PLLP'=>'PROFESSIONAL LIMITED LIABILITY PARTNERSHIP','');
			self.corp_status_cd                   :=if(trim(input.PASTS,left,right)<>'',trimUpper(input.PASTS),'');
            self.corp_status_desc                 := map(trimUpper(input.PASTS)='A'=>'ACTIVE',
                                                   trimUpper(input.PASTS)='E'=>'EXPIRED',
                                                   trimUpper(input.PASTS)='I'=>'INACTIVE',
                                                   trimUpper(input.PASTS)='V '=>'VOLUNTARILY TERMINATED','');
												   
			self.corp_inc_date                    :=if(trim(input.PADATE ,left,right) <> ''and (string)((integer)trim(input.PADATE ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.PADATE ,left,right)) and 
														_validate.date.fIsValid((trim(input.PADATE ,left,right)),_validate.date.rules.DateInPast),
														trim(input.PADATE ,left,right),'');	
														
		    self.corp_status_date                 :=if(trim(input.PASTDT,left,right) <> ''and (string)((integer)trim(input.PASTDT	 ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.PASTDT,left,right)) and 
														_validate.date.fIsValid((trim(input.PASTDT,left,right)),_validate.date.rules.DateInPast),
														trim(input.PASTDT ,left,right),'');	

														
			self.corp_inc_state                   :=if(trim(input.PASTAO,left,right) = ''or trim( input.PASTAO,left,right) ='ND', 'ND','');
			
            self.corp_forgn_state_cd              :=if(trim(input.PASTAO,left,right) <>''or trim(trimUpper(input.PASTAO),left,right)<>'ND', trimUpper(input.PASTAO),'');
			
			self.corp_address1_type_cd            :=if(trim(input.PAADD1,left,right) <> '' or trim(input.PAADD2,left,right) <> '' or trim(input.PACITY,left,right) <> '' or trim(input.PAZIP,left,right) <> ''or trim(input.PASTAT,left,right) <> '','M','');
			self.corp_address1_type_desc          :=if(trim(input.PAADD1,left,right) <> '' or trim(input.PAADD2,left,right) <> '' or trim(input.PACITY,left,right) <> '' or trim(input.PAZIP,left,right) <> '' or trim(input.PASTAT,left,right) <> '','MAILING','');
			self.corp_address1_line1              :=if(trim(input.PAADD1,left,right) <> '', trimUpper(input.PAADD1),''); 
			self.corp_address1_line2              :=if(trim(input.PAADD2,left,right) <> '', trimUpper(input.PAADD2),''); 
			self.corp_address1_line3              :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.PACITY),'X',1) <>0 and trim(input.PACITY,left,right) <> '', trimUpper(input.PACITY),'');  
			self.corp_address1_line4              :=if(trim(input.PASTAT,left,right) <> '', trimUpper(input.PASTAT),''); 
			ZipCode1                              :=if((string)((integer)trim(input.PAZIP[1..5],left,right)) <> '0' and trim(input.PAZIP[1..5],left,right)<>''and trimUpper(input.PAZIP[1..5])<>'X',trim(input.PAZIP[1..5],left,right),'');
			ZipExtension1                         :=if((string)((integer)trim(input.PAZIP[6..10],left,right)) <> '0' and trim(input.PAZIP[6..10],left,right)<>''and trimUpper(input.PAZIP[6..10])<>'X',trim(input.PAZIP[6..10],left,right),''); 
			self.corp_address1_line5              :=ZipCode1+ZipExtension1;	
			
			corp_raname                           :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'AGENT FOR',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'NONE',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'AGENT RESIGN',1) <>0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'AGENT NOT',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'AGENT RESIGNED',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'RESIGNED',1) <>0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'NONE APPOINTED',1)<>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER),'AGENT RESIGNATION',1) <>0 ,
                                                      '', trimUpper(input.PANAMER));
													   
			corp_raname2                           :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'AGENT FOR',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'NONE',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'AGENT RESIGN',1) <>0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'AGENT NOT',1) <>0 and
                                                       not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'AGENT RESIGNED',1) <>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'RESIGNED',1) <>0 and
													   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'NONE APPOINTED',1)<>0 and
	                                                   not lib_stringlib.StringLib.StringFind(trimUpper(input.PANAMER2),'AGENT RESIGNATION',1) <>0 ,
                                                       '',trimUpper(input.PANAMER2));	
			ranm1                                 :=if(	corp_raname='',	trimUpper(input.PANAMER),'');
			ranm2                                 :=if(	corp_raname2='',trimUpper(input.PANAMER2),'');
			self.corp_ra_name                     :=ranm1 +ranm2; 
			self.corp_ra_addl_info                :=corp_raname+corp_raname2 ;
			self.corp_ra_address_line1            :=if(trim(input.PAADD1,left,right) <> '', trimUpper(input.PAADD1),''); 
			self.corp_ra_address_line2            :=if(trim(input.PAADD2,left,right) <> '', trimUpper(input.PAADD2),''); 
			self.corp_ra_address_line3            :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.PACITY),'X',1) <>0 and trim(input.PACITY,left,right) <> '', trimUpper(input.PACITY),'');  
			self.corp_ra_address_line4            :=if(trim(input.PASTAT,left,right) <> '', trimUpper(input.PASTAT),''); 
			ZipCode2                              :=if((string)((integer)trim(input.PAZIP[1..5],left,right)) <> '0' and trim(input.PAZIP[1..5],left,right)<>''and trimUpper(input.PAZIP[1..5])<>'X',trim(input.PAZIP[1..5],left,right),'');
			ZipExtension2                         :=if((string)((integer)trim(input.PAZIP[6..10],left,right)) <> '0' and trim(input.PAZIP[6..10],left,right)<>''and trimUpper(input.PAZIP[6..10])<>'X',trim(input.PAZIP[6..10],left,right),''); 
			self.corp_ra_address_line5            :=ZipCode2+ZipExtension2;
			self.corp_ra_address_type_desc        :=if(trim(input.PAADD1,left,right) <> '' or trim(input.PAADD2,left,right) <> ''or trim(input.PACITY,left,right) <> ''or trim(input.PASTAT,left,right) <> '' or trim(input.PAZIP,left,right) <> '','REGISTERED OFFICE','');
			
											
            self                                  := [];
		
        end; // end transform.	

		    corp2_mapping.Layout_CorpPreClean nd_corp4Transform_Business(trademark_names input):=transform,skip(trim(input.RSID,left, right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='38-'+trim(input. RSID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  := fileDate; 
			self.corp_src_type                    :='SOS';
     	    self.corp_orig_sos_charter_nbr        :=trim(input. RSID, left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.TM_NNAM,left,right) <> '','03','');
			self.corp_ln_name_type_desc           :=if(trim(input.TM_NNAM,left,right) <> '','TRADEMARK','');
		    self.corp_legal_name                  :=if(trim(input.TM_NNAM,left,right) <> '', trimUpper(input.TM_NNAM),'');
			self.corp_status_cd                   :=if(trim(input.RCLST,left,right)<>'',trimUpper(input.RCLST),'');
            self.corp_status_desc                 := map(trimUpper(input.RCLST)='A'=>'ACTIVE',
                                                   trimUpper(input.RCLST)='E'=>'EXPIRED',
                                                   trimUpper(input.RCLST)='I'=>'INACTIVE',
                                                   trimUpper(input.RCLST)='V '=>'VOLUNTARILY TERMINATED','');
												   
		    self.corp_status_date                 :=if(trim(input.RCSDT,left,right) <> ''and (string)((integer)trim(input.RCSDT,left,right)) <> '0' and _validate.date.fIsValid(trim(input.RCSDT,left,right)) and 
														_validate.date.fIsValid((trim(input.RCSDT,left,right)),_validate.date.rules.DateInPast),
														trim(input.RCSDT,left,right),'');
										
										
			self.corp_filing_date                 :=if(trim(input.RLRFD ,left,right) <> ''and (string)((integer)trim(input.RLRFD ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.RLRFD ,left,right)) and 
														_validate.date.fIsValid((trim(input.RLRFD ,left,right) ),_validate.date.rules.DateInPast),trim(input.RLRFD ,left,right),if(trim(input.ROLDT ,left,right) <> ''and (string)((integer)trim(input.ROLDT ,left,right)) <> '0' and 
														_validate.date.fIsValid(trim(input.ROLDT ,left,right) ) and 
														_validate.date.fIsValid((trim(input.ROLDT ,left,right)),_validate.date.rules.DateInPast),
														trim(input.ROLDT ,left,right),''));
														
			self.corp_filing_desc                  :=if(trim(input.ROLDT ,left,right) <> ''and (string)((integer)trim(input.ROLDT ,left,right)) <> '0' and _validate.date.fIsValid(input.ROLDT ) and 
														_validate.date.fIsValid((input.ROLDT ),_validate.date.rules.DateInPast),
														'RENEWAL','');
			self.corp_address1_type_cd            :=if(trim(input.OADD1,left,right) <> '' or trim(input.OADD2,left,right) <> '' or trim(input.OCITY,left,right) <> '' or trim(input.OZIP,left,right) <> ''or trim(input.OSTAT,left,right) <> '','M','');
			self.corp_address1_type_desc          :=if(trim(input.OADD1,left,right) <> '' or trim(input.OADD2,left,right) <> '' or trim(input.OCITY,left,right) <> '' or trim(input.OZIP,left,right) <> '' or trim(input.OSTAT,left,right) <> '','MAILING','');
			self.corp_address1_line1              :=if(trim(input.OADD1,left,right) <> '', trimUpper(input.OADD1),''); 
			self.corp_address1_line2              :=if(trim(input.OADD2,left,right) <> '', trimUpper(input.OADD2),''); 
			self.corp_address1_line3              :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.OCITY),'X',1) <>0 and trim(input.OCITY,left,right) <> '', trimUpper(input.OCITY),'');  
			self.corp_address1_line4              :=if(trim(input.OSTAT,left,right) <> '', trimUpper(input.OSTAT),''); 
			ZipCode2                              :=if((string)((integer)trim(input.OZIP[1..5],left,right)) <> '0' and trim(input.OZIP[1..5],left,right)<>''and trimUpper(input.OZIP[1..5])<>'X',trim(input.OZIP[1..5],left,right),'');
			ZipExtension2                         :=if((string)((integer)trim(input.OZIP[6..10],left,right)) <> '0' and trim(input.OZIP[6..10],left,right)<>''and trimUpper(input.OZIP[6..10])<>'X',trim(input.OZIP[6..10],left,right),''); 
			self.corp_address1_line5              :=ZipCode2+ZipExtension2;											
            self                                  := [];
		
        end; // end transform.


		    corp2_mapping.Layout_CorpPreClean nd_corp5Transform_Business(tradename_files input):=transform,skip(trim(input.PSID,left, right)='')
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='38-'+trim(input.PSID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  := fileDate; 
			self.corp_src_type                    :='SOS';
     	    self.corp_orig_sos_charter_nbr        :=trim(input.PSID, left, right);
			self.corp_ln_name_type_cd             :=if(trim(input.TN_NNAM,left,right) <> '','04','');
			self.corp_ln_name_type_desc           :=if(trim(input.TN_NNAM,left,right) <> '','TRADENAME','');
		    self.corp_legal_name                  :=if(trim(input.TN_NNAM,left,right) <> '', trimUpper(input.TN_NNAM),'');
			self.corp_status_cd                   :=if(trim(input.PCLST,left,right)<>'',trimUpper(input.PCLST),'');
            self.corp_status_desc                 := map(trimUpper(input.PCLST)='A'=>'ACTIVE',
                                                   trimUpper(input.PCLST)='E'=>'EXPIRED',
                                                   trimUpper(input.PCLST)='I'=>'INACTIVE',
                                                   trimUpper(input.PCLST)='V '=>'VOLUNTARILY TERMINATED','');
												   
		    self.corp_status_date                 :=if(trim(input.PCSD8,left,right) <> ''and (string)((integer)trim(input.PCSD8,left,right)) <> '0' and _validate.date.fIsValid(trim(input.PCSD8,left,right)) and 
														_validate.date.fIsValid((trim(input.PCSD8,left,right)),_validate.date.rules.DateInPast),
														trim(input.PCSD8,left,right),'');
														
			self.corp_filing_date                 :=if(trim(input.PLRD8 ,left,right) <> ''and (string)((integer)trim(input.PLRD8 ,left,right)) <> '0' and _validate.date.fIsValid(trim(input.PLRD8 ,left,right) ) and 
														_validate.date.fIsValid((trim(input.PLRD8 ,left,right)),_validate.date.rules.DateInPast),trim(input.PLRD8 ,left,right),if(trim(input.POLD8 ,left,right) <> ''and (string)((integer)trim(input.POLD8 ,left,right)) <> '0' and 
														_validate.date.fIsValid(trim(input.POLD8 ,left,right) ) and 
														_validate.date.fIsValid((trim(input.POLD8 ,left,right) ),_validate.date.rules.DateInPast),
														trim(input.POLD8 ,left,right),''));
														
			self.corp_filing_desc                  :=if(trim(input.POLD8 ,left,right) <> ''and (string)((integer)trim(input.POLD8 ,left,right)) <> '0' and _validate.date.fIsValid(input.POLD8 ) and 
														_validate.date.fIsValid((input.POLD8 ),_validate.date.rules.DateInPast),
														'RENEWAL','');	
			self.corp_address1_type_cd            :=if(trim(input.OADD1,left,right) <> '' or trim(input.OADD2,left,right) <> '' or trim(input.OCITY,left,right) <> '' or trim(input.OZIP,left,right) <> ''or trim(input.OSTAT,left,right) <> '','M','');
			self.corp_address1_type_desc          :=if(trim(input.OADD1,left,right) <> '' or trim(input.OADD2,left,right) <> '' or trim(input.OCITY,left,right) <> '' or trim(input.OZIP,left,right) <> ''or trim(input.OSTAT,left,right) <> '','MAILING','');
			self.corp_address1_line1              :=if(trim(input.OADD1,left,right) <> '', trimUpper(input.OADD1),''); 
			self.corp_address1_line2              :=if(trim(input.OADD2,left,right) <> '', trimUpper(input.OADD2),''); 
			self.corp_address1_line3              :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.OCITY),'X',1) <>0 and trim(input.OCITY,left,right) <> '', trimUpper(input.OCITY),'');  
			self.corp_address1_line4              :=if(trim(input.OSTAT,left,right) <> '', trimUpper(input.OSTAT),''); 
			ZipCode2                              :=if((string)((integer)trim(input.OZIP[1..5],left,right)) <> '0' and trim(input.OZIP[1..5],left,right)<>''and trimUpper(input.OZIP[1..5])<>'X',trim(input.OZIP[1..5],left,right),'');
			ZipExtension2                         :=if((string)((integer)trim(input.OZIP[6..10],left,right)) <> '0' and trim(input.OZIP[6..10],left,right)<>''and trimUpper(input.OZIP[6..10])<>'X',trim(input.OZIP[6..10],left,right),''); 
			self.corp_address1_line5              :=ZipCode2+ZipExtension2;												
            self                                  := [];
		
        end; // end transform.		
		

		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In nd_stockTransform(corporation_names input):=transform,skip(trim(input.CBSID,left, right)='')
			self.corp_key					      := '38-' +trim(input.CBSID, left, right);
			self.corp_vendor				      := '38';
			self.corp_state_origin			      := 'ND';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CBSID, left, right);
			self.stock_type                       :=if(trim(input.CSHCLS,left,right) <> '', trimUpper(input.CSHCLS),'');
			decimal20_6 stocksharesissued         :=if ((integer)trim(input.CSHNO,left, right)= 0 or trim(input.CSHNO, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHNO, left, right)/1000000);

			self.stock_shares_issued              :=if((string) stocksharesissued='0','',(string) stocksharesissued)  ;
					
            decimal20_6 parvalue                  := if ((integer)trim(input.CSHPV,left, right)= 0 or trim(input.CSHPV, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHPV, left, right)/1000000);
		   
			self.stock_par_value                  :=if((string)parvalue='0','',(string)parvalue);
			self.stock_addl_info                  :=if(trimUpper(input.CSHNP)='Y','NO PAR VALUE SHARES','');
        	self                                  := [];
			
			
		 end; // end of nd_Stock_transform 
		
		
		 		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In nd_stock1Transform(corporation_names input):=transform,skip(trim(input.CBSID,left, right)='')
			self.corp_key					      := '38-' +trim(input.CBSID, left, right);
			self.corp_vendor				      := '38';
			self.corp_state_origin			      := 'ND';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CBSID, left, right);
			self.stock_type                       :=if(trim(input.CSHCLS01,left,right) <> '', trimUpper(input.CSHCLS01),'');
			decimal20_6 stocksharesissued         :=if ((integer)trim(input.CSHNO01,left, right)= 0 or trim(input.CSHNO01, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHNO01, left, right)/1000000);

			self.stock_shares_issued              :=if((string) stocksharesissued='0','',(string) stocksharesissued)  ;
					
            decimal20_6 parvalue                   := if ((integer)trim(input.CSHPV01,left, right)= 0 or trim(input.CSHPV01, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHPV01, left, right)/1000000);
		   
			self.stock_par_value                  :=if((string)parvalue='0','',(string)parvalue);
			self.stock_addl_info                  :=if(trimUpper(input.CSHNP01)='Y','NO PAR VALUE SHARES','');
        	self                                  := [];
			
			
		 end; // end of nd_Stock_transform 

				 		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In nd_stock2Transform(corporation_names input):=transform,skip(trim(input.CBSID,left, right)='')
			self.corp_key					      := '38-' +trim(input.CBSID, left, right);
			self.corp_vendor				      := '38';
			self.corp_state_origin			      := 'ND';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CBSID, left, right);
		    self.stock_type                       :=if(trim(input.CSHCLS02,left,right) <> '', trimUpper(input.CSHCLS02),'');
			decimal20_6 stocksharesissued         :=if ((integer)trim(input.CSHNO02,left, right)= 0 or trim(input.CSHNO02, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHNO02, left, right)/1000000);

			self.stock_shares_issued              :=if((string) stocksharesissued='0','',(string) stocksharesissued)  ;
					
            decimal20_6 parvalue                   := if ((integer)trim(input.CSHPV02,left, right)= 0 or trim(input.CSHPV02, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHPV02, left, right)/1000000);
		   
			self.stock_par_value                  :=if((string)parvalue='0','',(string)parvalue);
			self.stock_addl_info                  :=if(trimUpper(input.CSHNP02)='Y','NO PAR VALUE SHARES','');
        	self                                  := [];
			
			
		 end; // end of nd_Stock_transform 
		 
		 
		 		 		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In nd_stock3Transform(corporation_names input):=transform,skip(trim(input.CBSID,left, right)='')
			self.corp_key					      := '38-' +trim(input.CBSID, left, right);
			self.corp_vendor				      := '38';
			self.corp_state_origin			      := 'ND';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CBSID, left, right);
		    self.stock_type                       :=if(trim(input.CSHCLS03,left,right) <> '', trimUpper(input.CSHCLS03),'');
			decimal20_6 stocksharesissued         :=if ((integer)trim(input.CSHNO03,left, right)= 0 or trim(input.CSHNO03, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHNO03, left, right)/1000000);

			self.stock_shares_issued              :=if((string) stocksharesissued='0','',(string) stocksharesissued)  ;
					
            decimal20_6 parvalue                   := if ((integer)trim(input.CSHPV03,left, right)= 0 or trim(input.CSHPV03, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHPV03, left, right)/1000000);
		   
			self.stock_par_value                  :=if((string)parvalue='0','',(string)parvalue);
			self.stock_addl_info                  :=if(trimUpper(input.CSHNP03)='Y','NO PAR VALUE SHARES','');
        	self                                  := [];
			
			
		 end; // end of nd_Stock_transform 
		 
		 
		 		 		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In nd_stock4Transform(corporation_names input):=transform,skip(trim(input.CBSID,left, right)='')
			self.corp_key					      := '38-' +trim(input.CBSID, left, right);
			self.corp_vendor				      := '38';
			self.corp_state_origin			      := 'ND';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CBSID, left, right);
			self.stock_type                       :=if(trim(input.CSHCLS04,left,right) <> '', trimUpper(input.CSHCLS04),'');
			decimal20_6 stocksharesissued         :=if ((integer)trim(input.CSHNO04,left, right)= 0 or trim(input.CSHNO04, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHNO04, left, right)/1000000);

			self.stock_shares_issued              :=if((string) stocksharesissued='0','',(string) stocksharesissued)  ;
					
            decimal20_6 parvalue                   := if ((integer)trim(input.CSHPV04,left, right)= 0 or trim(input.CSHPV04, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHPV04, left, right)/1000000);
		   
			self.stock_par_value                  :=if((string)parvalue='0','',(string)parvalue);
			self.stock_addl_info                  :=if(trimUpper(input.CSHNP04)='Y','NO PAR VALUE SHARES','');
        	self                                  := [];
			
			
		 end; // end of nd_Stock_transform 
		 
		 
		 		 		 // Stock_TRANSFORM 
	     Corp2.Layout_Corporate_Direct_Stock_In nd_stock5Transform(corporation_names input):=transform,skip(trim(input.CBSID,left, right)='')
			self.corp_key					      := '38-' +trim(input.CBSID, left, right);
			self.corp_vendor				      := '38';
			self.corp_state_origin			      := 'ND';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.CBSID, left, right);
		    self.stock_type                       :=if(trim(input.CSHCLS05,left,right) <> '', trimUpper(input.CSHCLS05),'');
			decimal20_6 stocksharesissued         :=if ((integer)trim(input.CSHNO05,left, right)= 0 or trim(input.CSHNO05, left, right) = '',0 , 
                                                            (unsigned6)trim(input.CSHNO05, left, right)/1000000);

			self.stock_shares_issued              :=if((string) stocksharesissued='0','',(string) stocksharesissued)  ;
					
            decimal20_6 parvalue                   := if ((integer)trim(input.CSHPV05,left, right)= 0 or trim(input.CSHPV05, left, right) = '', 0, 
                                                            (unsigned6)trim(input.CSHPV05, left, right)/1000000);
		   
			self.stock_par_value                  :=if((string)parvalue='0','',(string)parvalue);
			self.stock_addl_info                  :=if(trimUpper(input.CSHNP05)='Y','NO PAR VALUE SHARES','');
        	self                                  := [];
			
			
		 end; // end of nd_Stock_transform 
		 
		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean nd_partnerContactTransform(layouts_Raw_Input.PARTNERSHIPSREC1 input):=transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.corp_key					      :='38-'+trim(input.PAID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.PAID, left, right);
			self.corp_legal_name                  :=if(trim(input.PANAME,left,right) <> '', trimUpper(input.PANAME),'');
			self.cont_name                    	  :=if(trim(input.P01NAME,left,right) <> '', trimUpper(input.P01NAME),'');
            self.cont_title1_desc             	  :='GENERAL/MANAGING PARTNER';
			self.cont_address_type_cd         	  :=if(trim(input.PAADDR1,left,right) <> ''or trim(input.PAADDR2,left,right) <> '' or trim(input.PACITYR,left,right) <> '' or
			                                        trim(input.PASTATR,left,right) <> '' or trim(input.PAZIPR,left,right) <> '','T','');
			self.cont_address_type_desc       	  :=if(trim(input.PAADDR1,left,right) <> ''or trim(input.PAADDR2,left,right) <> '' or trim(input.PACITYR,left,right) <> '' or
			                                        trim(input.PASTATR,left,right) <> '' or trim(input.PAZIPR,left,right) <> '','CONTACT','');
			self.cont_address_line1           	  :=if(trim(input.PAADDR1,left,right) <> '', trimUpper(input.PAADDR1),''); 
			self.cont_address_line2           	  :=if(trim(input.PAADDR2,left,right) <> '', trimUpper(input.PAADDR2),''); 
			self.cont_address_line3           	  :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.PACITYR),'X',1) <>0 and trim(input.PACITYR,left,right) <> '', trimUpper(input.PACITYR),'');  
			self.cont_address_line4           	  :=if(trim(input.PASTATR,left,right) <> '', trimUpper(input.PASTATR),''); 
			ZipCode2                          	  :=if((string)((integer)trim(input.PAZIPR[1..5],left,right)) <> '0' and trim(input.PAZIPR[1..5],left,right)<>''and trimUpper(input.PAZIPR[1..5])<>'X',trim(input.PAZIPR[1..5],left,right),'');
			ZipExtension2                     	  :=if((string)((integer)trim(input.PAZIPR[6..10],left,right)) <> '0' and trim(input.PAZIPR[6..10],left,right)<>''and trimUpper(input.PAZIPR[6..10])<>'X',trim(input.PAZIPR[6..10],left,right),''); 
			self.cont_address_line5           	  :=ZipCode2+ZipExtension2;	
            self                              	  := [];
			
		 end; // end of nd_contact_transform  	
		
		
		 		 // contact_TRANSFORM
		 corp2_mapping.Layout_ContPreClean nd_FictitiousContactTransform(ficticious_names input):=transform
     	    self.dt_first_seen				  :=fileDate;
			self.dt_last_seen				  :=fileDate;
			self.corp_key					  :='38-'+trim(input.ESID,left, right);
			self.corp_vendor				  :='38';
		    self.corp_state_origin            :='ND';
			self.corp_process_date			  := fileDate;    
     	    self.corp_orig_sos_charter_nbr    :=trim(input.ESID, left, right);
			self.corp_legal_name              :=if(trim(input.FICNNAM,left,right) <> '', trimUpper(input.FICNNAM),'');
			self.cont_name                    :=if(trim(input.FICNNAM01,left,right) <> '', trimUpper(input.FICNNAM01),'');
         	self.cont_type_cd         	      :=if(self.cont_name<>'','O','');
			self.cont_type_desc       	      :=if(self.cont_name<>'','OWNER','');
			self.cont_address_line1           :=if(trim(input.FICNADD1,left,right) <> '', trimUpper(input.FICNADD1),''); 
			self.cont_address_line2           :=if(trim(input.FICNADD2,left,right) <> '', trimUpper(input.FICNADD2),''); 
			self.cont_address_line3           :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.FICNCITY),'X',1) <>0 and trim(input.FICNCITY,left,right) <> '', trimUpper(input.FICNCITY),'');  
			self.cont_address_line4           :=if(trim(input.FICNSTAT,left,right) <> '', trimUpper(input.FICNSTAT),''); 
			ZipCode2                          :=if((string)((integer)trim(input.FICNZIP[1..5],left,right)) <> '0' and trim(input.FICNZIP[1..5],left,right)<>''and trimUpper(input.FICNZIP[1..5])<>'X',trim(input.FICNZIP[1..5],left,right),'');
			ZipExtension2                     :=if((string)((integer)trim(input.FICNZIP[6..10],left,right)) <> '0' and trim(input.FICNZIP[6..10],left,right)<>''and trimUpper(input.FICNZIP[6..10])<>'X',trim(input.FICNZIP[6..10],left,right),''); 
			self.cont_address_line5           :=ZipCode2+ZipExtension2;	
            self                              := [];

			
		 end; // end of nd_contact_transform  
		 
		 	 

		 
	corp2_mapping.Layout_ContPreClean nd_TradMark_ContactTransform(trademark_names  input):=transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.corp_key					      :='38-'+trim(input.RSID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  :=fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.RSID, left, right);
			self.corp_legal_name                  :=if(trim(input.TM_NNAM,left,right) <> '', trimUpper(input.TM_NNAM),'');
			self.cont_name                    	  :=if(input.NNAM01<> '', trimUpper(input.NNAM01),'');
			self.cont_type_cd         	          :=if(self.cont_name<>'','O','');
			self.cont_type_desc       	          :=if(self.cont_name<>'','OWNER','');
			self.cont_address_line1              :=if(input.OADD1<> '', trimUpper(input.OADD1),''); 
   			self.cont_address_line2              :=if(input.OADD2 <> '', trimUpper(input.OADD2),''); 
   			self.cont_address_line3              :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.OCITY),'X',1) <>0 and trim(input.OCITY,left,right) <> '', trimUpper(input.OCITY),'');  
   			self.cont_address_line4              :=if(input.OSTAT<> '', trimUpper(input.OSTAT),''); 
   			ZipCode2                              :=if((string)((integer)trim(input.OZIP[1..5],left,right)) <> '0' and trim(input.OZIP[1..5],left,right)<>''and trimUpper(input.OZIP[1..5])<>'X',trim(input.OZIP[1..5],left,right),'');
   			ZipExtension2                         :=if((string)((integer)trim(input.OZIP[6..10],left,right)) <> '0' and trim(input.OZIP[6..10],left,right)<>''and trimUpper(input.OZIP[6..10])<>'X',trim(input.OZIP[6..10],left,right),''); 
   			self.cont_address_line5              :=ZipCode2+ZipExtension2;
			self.cont_address_type_cd         	  :=if(self.cont_address_line1<>'' or self.cont_address_line2<>'' or self.cont_address_line3<>'' or self.cont_address_line4<>'' or self.cont_address_line5<>'','T','');
			self.cont_address_type_desc       	  :=if(self.cont_address_line1<>'' or self.cont_address_line2<>'' or self.cont_address_line3<>'' or self.cont_address_line4<>'' or self.cont_address_line5<>'','CONTACT','');
            self                              	  := [];
			
		 end;
		 
 
		 
	corp2_mapping.Layout_ContPreClean nd_TradName_ContactTransform(tradename_files  input):=transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.corp_key					      :='38-'+trim(input.PSID,left, right);
			self.corp_vendor					  :='38';
		    self.corp_state_origin                :='ND';
			self.corp_process_date				  :=fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.PSID, left, right);
			self.corp_legal_name                  :=if(trim(input.TN_NNAM,left,right) <> '', trimUpper(input.TN_NNAM),'');
			self.cont_name                    	  :=if(input.NNAM01<> '', trimUpper(input.NNAM01),'');
			self.cont_type_cd         	          :=if(self.cont_name<>'','O','');
			self.cont_type_desc       	          :=if(self.cont_name<>'','OWNER','');
			self.cont_address_line1               :=if(input.OADD1<> '', trimUpper(input.OADD1),''); 
   			self.cont_address_line2               :=if(input.OADD2 <> '', trimUpper(input.OADD2),''); 
   			self.cont_address_line3               :=if(not lib_stringlib.StringLib.StringFind(trimUpper(input.OCITY),'X',1) <>0 and trim(input.OCITY,left,right) <> '', trimUpper(input.OCITY),'');  
   			self.cont_address_line4               :=if(input.OSTAT<> '', trimUpper(input.OSTAT),''); 
   			ZipCode2                              :=if((string)((integer)trim(input.OZIP[1..5],left,right)) <> '0' and trim(input.OZIP[1..5],left,right)<>''and trimUpper(input.OZIP[1..5])<>'X',trim(input.OZIP[1..5],left,right),'');
   			ZipExtension2                         :=if((string)((integer)trim(input.OZIP[6..10],left,right)) <> '0' and trim(input.OZIP[6..10],left,right)<>''and trimUpper(input.OZIP[6..10])<>'X',trim(input.OZIP[6..10],left,right),''); 
   			self.cont_address_line5               :=ZipCode2+ZipExtension2;
			self.cont_address_type_cd         	  :=if(self.cont_address_line1<>'' or self.cont_address_line2<>'' or self.cont_address_line3<>'' or self.cont_address_line4<>'' or self.cont_address_line5<>'','T','');
			self.cont_address_type_desc       	  :=if(self.cont_address_line1<>'' or self.cont_address_line2<>'' or self.cont_address_line3<>'' or self.cont_address_line4<>'' or self.cont_address_line5<>'','CONTACT','');
            self                              	  := [];
			
		 end;	 

		//---------------------------- Clean corp Name and Addresses ---------------------//

		
		corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 					:= if (input.corp_ra_name = '', '',Address.CleanPerson73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= ut.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
	

			
			string182 clean_address1 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' + 														                        
												trim(input.corp_address1_line2,left,right),left,right),														                   
												trim(trim(input.corp_address1_line3,left,right) + ', ' +
												trim(input.corp_address1_line4,left,right) + ' ' +
												trim(input.corp_address1_line5,left,right) +
												trim(input.corp_address1_line6,left,right),left,right));

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
			self.corp_addr1_lot 		      	:= clean_address1[131..134];
			self.corp_addr1_lot_order 	  		:= clean_address1[135];
			self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
			self.corp_addr1_chk_digit 	  		:= clean_address1[138];
			self.corp_addr1_rec_type		  	:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
			self.corp_addr1_county 	  			:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
			self.corp_addr1_msa 		      	:= clean_address1[167..170];
			self.corp_addr1_geo_blk				:= clean_address1[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address1[178];
			self.corp_addr1_err_stat 	    	:= clean_address1[179..182];
			
			
			
			
						
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right) +
												trim(input.corp_ra_address_line6,left,right),left,right));

			self.corp_ra_prim_range    			:= clean_address[1..10];
			self.corp_ra_predir 	      		:= clean_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_address[41..44];
			self.corp_ra_postdir 	    		:= clean_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_address[90..114];
			self.corp_ra_state 			      	:= clean_address[115..116];
			self.corp_ra_zip5 		      		:= clean_address[117..121];
			self.corp_ra_zip4 		      		:= clean_address[122..125];
			self.corp_ra_cart 		      		:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
			self.corp_ra_lot 		      		:= clean_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_address[135];
			self.corp_ra_dpbc 		      		:= clean_address[136..137];
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
		
		
		     //*********************cleaned corp routine ends********
			 
			 
			 
			//******************Cont Cleaning starts.****************
		Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform
			// cleaning name
			string73 tempname 				:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
			
			string182 clean_address 		:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
											trim(input.cont_address_line2,left,right),left,right),														                   
											trim(trim(input.cont_address_line3,left,right) + ', ' +
											trim(input.cont_address_line4,left,right) + ' ' +
											trim(input.cont_address_line5,left,right) +
											trim(input.cont_address_line6,left,right),left,right));

			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 			    := clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;
			self							:= [];
		end;
		//************************Cont cleaning ends************************************
		

	
							
		MapCorp1   := project(corporation_names, nd_corp1Transform_Business(left)) ;
		 MapCorp3  := project(Files_Raw_Input.PARTNERSHIPSREC1(fileDate) , nd_corp3Transform_Business(left)) ;
		 

		 
		//*********************ExplosionTable lookupjoin**********						
       
       	corp2_mapping.Layout_CorpPreClean findState(corp2_mapping.Layout_CorpPreClean input, StateCountryLayout r ) := transform
		    self.corp_forgn_state_cd    := r.code;
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		//StatusCode join
		
		joinStateType :=join(MapCorp1,StateCountryTable,
									if(trim(left.corp_forgn_state_cd,left,right)<>'ND',trim(left.corp_forgn_state_cd,left,right),'') =  trim(right.code,left,right) ,
									findState(left,right),
									left outer, lookup
								);
								
		corp2_mapping.Layout_CorpPreClean find_PartnerState(corp2_mapping.Layout_CorpPreClean input, StateCountryLayout r ) := transform
		    self.corp_forgn_state_cd    := r.code;
			self.corp_forgn_state_desc  := r.desc;
			self         			    := input;
			self                        := [];
		end; 
		
		// end transform
		
			
		//StatusCode join
		
		joinStateTypecode :=join(MapCorp3,StateCountryTable,
									if(trim(left.corp_forgn_state_cd,left,right)<>'ND',trim(left.corp_forgn_state_cd,left,right),'') =  trim(right.code,left,right),
									find_PartnerState(left,right),
									left outer, lookup
								);						
		 
		 MapCorp2   	 := project(ficticious_names , nd_corp2Transform_Business(left)) ;
		
		 MapCorp4   	 := project(trademark_names, nd_corp4Transform_Business(left)) ;
		 
		 MapCorp5   	 := project(tradename_files, nd_corp5Transform_Business(left)) ;
		 AllCorp    	 :=joinStateType+MapCorp2+joinStateTypecode+MapCorp4+MapCorp5;
		 MapCorp         := sort(AllCorp,corp_key);    
		 cleanCorps      := project(MapCorp,CleanCorpNameAddr(left));			
		
		 
		 MapCont1 		 := project(Files_Raw_Input.PARTNERSHIPSREC1(filedate), nd_partnerContactTransform(left));
		 MapCont2 		 := project(ficticious_names, nd_FictitiousContactTransform(left));
		 MapCont3 		 := project(trademark_names , nd_TradMark_ContactTransform(left));
		 MapCont4		 := project(tradename_files , nd_TradName_ContactTransform(left));
		 
		 AllCont 		 := MapCont1+MapCont2+MapCont3+MapCont4;
		 
		 
         cleanCont       := project(AllCont, CleanContNameAddr(left));      
			    
		  MapStock1 	 := project(corporation_names, nd_stockTransform(left));
		  MapStock2 	 := project(corporation_names, nd_stock1Transform(left));
		  MapStock3 	 := project(corporation_names, nd_stock2Transform(left));
		  MapStock4		 := project(corporation_names, nd_stock3Transform(left));
		  MapStock5		 := project(corporation_names, nd_stock4Transform(left));
		  MapStock6		 := project(corporation_names, nd_stock5Transform(left));
	
		 AllStock 		 :=  MapStock1+MapStock2+ MapStock3+ MapStock4+ MapStock5+ MapStock6;
		 
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_nd'	,dedup(sort(cleanCorps,record),record)	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_nd'	,dedup(sort(cleanCont,record),record)	,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_nd'	,dedup(sort(AllStock,record),record) 	,stock_out,,,pOverwrite);
                                                                                                                                                          
		 mappednd_Filing := parallel(
			 corp_out	                            
			,cont_out
			,stock_out
		);		 

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('nd',filedate,pOverwrite := pOverwrite))
			,mappednd_Filing
 			,parallel(
   				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_nd')		  
   				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_nd')						  
   				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_nd')
   			)

		);
				  
  return result;
   end;//Function end					 

   
 end;  // end of nd module	