#option('skipFileFormatCrcCheck', 1);

import ut, lib_stringlib, _validate, Address, corp2, _control,VersionControl;

export NY :=  MODULE;

 export Layouts_Raw_Input := MODULE
        
     //Corporation Master Record
   export master := RECORD              
        ebcdic string8    corp_id_no;
        ebcdic string12   microfilm_no;
        ebcdic string2    record_type;
				ebcdic string228	blob;				
   end;

   export merger := RECORD
        ebcdic string8    corp_id_no;
        ebcdic string12   microfilm_no;
        ebcdic string2    record_type;
        ebcdic string8    date_filed;
        ebcdic string6    doc_code;
        ebcdic string1    admin_name_flag;
        ebcdic string1    principal_office_flag;
        ebcdic string1    corp_name_flag;
        ebcdic string1    duration_date_flag;
        ebcdic string1    ficticious_name_flag;
        ebcdic string1    foreign_inc_flag;
        ebcdic string1    foreign_jurisdiction_flag; 
        ebcdic string1    not_for_profit_flag;
        ebcdic string1    process_info_flag;
        ebcdic string1    provision_flag;
        ebcdic string1    purpose_flag;
        ebcdic string1    registered_agent_flag;
        ebcdic string1    stock_flag;
        ebcdic string1    restated_certificate_flag;
        ebcdic string1    dead_file_flag;
        ebcdic string1    constituent_indicator;
        ebcdic string150  corp_name;
        ebcdic string2    county_office_code;
        ebcdic string8    doc_effective_date;												
        ebcdic string8    duration_date;
        ebcdic string8    dissolution_date;
        ebcdic string1    not_for_profit_type;
        ebcdic string8    foreign_inc_date;
        ebcdic string2    foreign_jurisdiction_code;
        ebcdic string2    constituent_type;
        ebcdic string1    amend_chairman_address;
        ebcdic string1    amend_location_address;
        ebcdic string1    admit_partner;
        ebcdic string1    withdraw_partner;
        ebcdic string5    filler;        
   end;
        
 end;// Input Vendor Raw files
 
    export Files_Raw_Input := module 
		    export masterSuperfile 													:= dataset('~thor_data400::in::corp2::ny::vendor_master',Layouts_Raw_Input.master, flat); 
  			export masterLatest(string filedate)            := dataset('~thor_data400::in::corp2::'+filedate+'::master::ny',Layouts_Raw_Input.master, flat);
								
				export mergerSuperFile                        	:= dataset('~thor_data400::in::corp2::ny::vendor_merger',Layouts_Raw_Input.merger, flat)(record_type='01');
				export mergerLatest(string filedate)           	:= dataset('~thor_data400::in::corp2::'+filedate+'::merger::ny',Layouts_Raw_Input.merger, flat)(record_type='01');				
    end;
    
    // Function to trim and upper case the given string
		trimUpper(string s) := function
        return trim(stringlib.StringToUppercase(s),left,right);
    end;
                                                                                                                                                                                                                                                                                                                                  
    // Function to clean the bad chars from a given string.
		cleanName(string s) := function
        string temp_name   := trim(StringLib.StringToUppercase(s),left,right);
        string temp_name1  := StringLib.StringFindReplace(temp_name,'*','');
        string temp_name2  := StringLib.StringFindReplace(temp_name1,'%','');
        string temp_name3  := StringLib.StringFindReplace(temp_name2,'#','');
        string temp_name4  := StringLib.StringFindReplace(temp_name3,'(','');
        string temp_name5  := StringLib.StringFindReplace(temp_name4,')','');
        string temp_name6  := StringLib.StringFindReplace(temp_name5,'ATTN:','');
        string temp_name7  := StringLib.StringFindReplace(temp_name6,'ATTN','');
        string temp_name8  := StringLib.StringFindReplace(temp_name7,'C/O','');
        string temp_name9  := StringLib.StringFindReplace(temp_name8,'N/A:','');
        string temp_name10 := StringLib.StringFindReplace(temp_name9,'N/A','');
        string temp_name11 := StringLib.StringFindReplace(temp_name10,'S/S:','');
        string temp_name12 := StringLib.StringFindReplace(temp_name11,'S/S','');
        string temp_name13 := StringLib.StringFindReplace(temp_name12,'1ST. DIR.','');
        return trim(temp_name13,left,right);
    end;        
        
    //************************ Update Process Starts ********************************************
    export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false, boolean pQuartlyReload = false) := function       
        
				// Joining to get the reload (quartly) records that match the current update Master records.
				Layouts_Raw_Input.master	join2GetUpdates(Layouts_Raw_Input.master l, Layouts_Raw_Input.master r)	:=	transform
						self	:= l;
				end;
				
				JoinMastUpdates	:=	join(Files_Raw_Input.masterSuperfile,
														     Files_Raw_Input.masterLatest(filedate),
														     left.corp_id_no=right.corp_id_no,
														     join2GetUpdates(left,right),
														     lookup
														    );					
				
				// If reload data then no need to do the join the records, just read the records from the masterSuperfile
				MasterUnload	:= if(pQuartlyReload = true,
				                    Files_Raw_Input.masterSuperfile,
				                    dedup(sort(distribute(JoinMastUpdates + Files_Raw_Input.masterLatest(filedate), hash(corp_id_no)),record, local), RECORD, local)
													 );
				
				//**** Master Recs (Type = 01) ****    
        masterLayout := Record 
           string8   corpidno;
           string12  microfilmno;
           string2   recordtype;
           string8   datefiled;
           string6   doccode;
           string1   adminnameflag;
           string1   principalofficeflag;
           string1   corpnameflag;
           string1   durationdateflag;
           string1   ficticiousnameflag;
           string1   foreignincflag;
           string1   foreignjurisdictionflag; 
           string1   notforprofitflag;
           string1   processinfoflag;
           string1   provisionflag;
           string1   purposeflag;
           string1   registeredagentflag;
           string1   stockflag;
           string1   restatedcertificateflag;
           string1   deadfileflag;
           string1   constituentindicator;
           string150 corpname;
           string2   countyofficecode;
           string8   doceffectivedate;
           string8   durationdate;
           string8   dissolutiondate;
           string1   notforprofittype;
           string8   foreignincdate;
           string2   foreignjurisdictioncode;
           string2   constituenttype;
           string1   amendchairmanaddress;
           string1   amendlocationaddress;
           string1   admitpartner;
           string1   withdrawpartner;
           string5   filler;        
        end;
        
				// Transform the master file from ebcdic form to ascii fixed layout form.
        masterLayout  masterToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.corpidno                := trim(l.corp_id_no,left,right);
           self.microfilmno             := trim(l.microfilm_no,left,right);
           self.recordtype              := trim(l.record_type,left,right);
           self.datefiled               := l.blob[1..8];
           self.doccode                 := l.blob[9..14];
           self.adminnameflag           := l.blob[15..15];
           self.principalofficeflag     := l.blob[16..16];
           self.corpnameflag            := l.blob[17..17];
           self.durationdateflag        := l.blob[18..18];
           self.ficticiousnameflag      := l.blob[19..19];
           self.foreignincflag          := l.blob[20..20];
           self.foreignjurisdictionflag := l.blob[21..21]; 
           self.notforprofitflag        := l.blob[22..22];
           self.processinfoflag         := l.blob[23..23];
           self.provisionflag           := l.blob[24..24];
           self.purposeflag             := l.blob[25..25];
           self.registeredagentflag     := l.blob[26..26];
           self.stockflag               := l.blob[27..27];
           self.restatedcertificateflag := l.blob[28..28];
           self.deadfileflag            := l.blob[29..29];
           self.constituentindicator    := l.blob[30..30];
           self.corpname                := l.blob[31..180];
           self.countyofficecode        := l.blob[181..182];
           self.doceffectivedate        := l.blob[183..190];
           self.durationdate            := l.blob[191..198];
           self.dissolutiondate         := l.blob[199..206];
           self.notforprofittype        := l.blob[207..207];
           self.foreignincdate          := l.blob[208..215];
           self.foreignjurisdictioncode := l.blob[216..217];
           self.constituenttype         := l.blob[218..219];
           self.amendchairmanaddress    := l.blob[220..220];
           self.amendlocationaddress    := l.blob[221..221];
           self.admitpartner            := l.blob[222..222];
           self.withdrawpartner         := l.blob[223..223];
           self.filler                  := l.blob[224..228];
        end;
       								
        masterFile    := PROJECT(MasterUnload(record_type = '01'), masterToFixed(LEFT));
        
  			//**** Process Address Recs (Type = 02) ****
				ProcessAddLayout := RECORD
           string8   Process_corpidno;
           string12  Process_microfilmno;
           string2   Process_recordtype;
           string60  Process_corpname;
           string30  Process_addr1;
           string30  Process_addr2;
           string23  Process_city;
           string3   Process_state;
           string9   Process_zip;
           string73  Process_blob;  
        end;
   
        ProcessAddLayout  ProcessAddToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.Process_corpidno       := trim(l.corp_id_no,left,right);
           self.Process_microfilmno    := trim(l.microfilm_no,left,right);
           self.Process_recordtype     := trim(l.record_type,left,right);
           self.Process_corpname       := l.blob[1..60];
           self.Process_addr1          := l.blob[61..90];
           self.Process_addr2          := l.blob[91..120];
           self.Process_city           := l.blob[121..143];
           self.Process_state          := l.blob[144..146];
           self.Process_zip            := l.blob[147..155];
           self.Process_blob           := l.blob[156..228];
        end;
        
        ProcessAddrFile    := PROJECT(MasterUnload(record_type = '02'), ProcessAddToFixed(LEFT));    
        
				//**** Register Agent Address Recs (Type = 03) ****
        RegAgentAddrLayout := Record     
           string8   register_corpidno;
           string12  register_microfilmno;
           string2   register_recordtype;
           string60  register_corpname;
           string30  register_addr1;
           string30  register_addr2;
           string23  register_city;
           string3   register_state;
           string9   register_zip;
           string73  register_blob;        
        end;
    
        RegAgentAddrLayout  RegAgentToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.register_corpidno       := trim(l.corp_id_no,left,right);
           self.register_microfilmno    := trim(l.microfilm_no,left,right);
           self.register_recordtype     := trim(l.record_type,left,right);
           self.register_corpname      	:= l.blob[1..60];
           self.register_addr1        	:= l.blob[61..90];
           self.register_addr2         	:= l.blob[91..120];
           self.register_city          	:= l.blob[121..143];
           self.register_state         	:= l.blob[144..146];
           self.register_zip           	:= l.blob[147..155];
           self.register_blob          	:= l.blob[156..228];      
        end;
        
        RegAgentAddrFile    := PROJECT(MasterUnload(record_type = '03'), RegAgentToFixed(LEFT));
				
				//**** Fictitious Name Recs (Type = 04) ****
				FictLayout := RECORD
           string8    corpidno;
           string12   microfilmno;
           string2    recordtype;
           string150  corpname;
           string78   blob4;    
        end; 
        
        FictLayout FictToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.corpidno       := trim(l.corp_id_no,left,right);
           self.microfilmno    := trim(l.microfilm_no,left,right);
           self.recordtype     := trim(l.record_type,left,right);
           self.corpname       := l.blob[1..150];
           self.blob4          := l.blob[151..228];
        end;
        
        FictFile := PROJECT(MasterUnload(record_type = '04'), FictToFixed(LEFT));

        //**** Stock Recs (Type = 05) ****
        stockLayout := Record
           string8   stock_corpidno;
           string12  stock_microfilmno;
           string2   stock_recordtype;
 
           string10 sharecount1;
           string3  stocktype1;
           string15 valuepershare1;
 
           string10 sharecount2;
           string3  stocktype2;
           string15 valuepershare2;
 
           string10 sharecount3;
           string3  stocktype3;
           string15 valuepershare3;
 
           string10 sharecount4;
           string3  stocktype4;
           string15 valuepershare4;
 
           string10 sharecount5;
           string3  stocktype5;
           string15 valuepershare5;
 
           string10 sharecount6;
           string3  stocktype6;
           string15 valuepershare6;
 
           string10 sharecount7;
           string3  stocktype7;
           string15 valuepershare7;
 
           string10 sharecount8;
           string3  stocktype8;
           string15 valuepershare8;
 
           string4 stock_blob5;        
        end;
        
        stockLayout  stockToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.stock_corpidno         := trim(l.corp_id_no,left,right);    
           self.stock_microfilmno      := trim(l.microfilm_no,left,right);    
           self.stock_recordtype       := trim(l.record_type,left,right);   
 
           self.sharecount1            := l.blob[1..10];   
           self.stocktype1             := l.blob[11..13];    
           self.valuepershare1         := l.blob[14..28];    
 
           self.sharecount2            := l.blob[29..38];    
           self.stocktype2             := l.blob[39..41];    
           self.valuepershare2         := l.blob[42..56];    
 
           self.sharecount3            := l.blob[57..66];    
           self.stocktype3             := l.blob[67..69];    
           self.valuepershare3         := l.blob[70..84];    
 
           self.sharecount4            := l.blob[85..94];    
           self.stocktype4             := l.blob[95..97];    
           self.valuepershare4         := l.blob[98..112];    
 
           self.sharecount5            := l.blob[113..122];    
           self.stocktype5             := l.blob[123..125];    
           self.valuepershare5         := l.blob[126..140];    
 
           self.sharecount6            := l.blob[141..150];    
           self.stocktype6             := l.blob[151..153];    
           self.valuepershare6         := l.blob[154..168];    
 
           self.sharecount7            := l.blob[169..178];    
           self.stocktype7             := l.blob[179..181];    
           self.valuepershare7         := l.blob[182..196];    
 
           self.sharecount8            := l.blob[197..206];    
           self.stocktype8             := l.blob[207..209];    
           self.valuepershare8         := l.blob[210..224];    
           self.stock_blob5            := l.blob[225..228];        
        end;
        
        StockFile    := PROJECT(MasterUnload(record_type = '05'), stockToFixed(LEFT));

        //**** Fictitious Name Recs (Type = 06)****
        ChairmanAddressLayout := RECORD
           string8  Chairmancorpidno;
           string12 Chairmanmicrofilmno;
           string2  Chairmanrecordtype;
           string60 Chairmancorpname;
           string30 Chairmanaddr1;
           string30 Chairmanaddr2;
           string23 Chairmancity;
           string3  Chairmanstate;
           string9  Chairmanzip;
           string73 Chairmanblob;    
        end;
				
        ChairmanAddressLayout  ChairmanAddToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.Chairmancorpidno         	:= trim(l.corp_id_no,left,right);
           self.Chairmanmicrofilmno      	:= trim(l.microfilm_no,left,right);
           self.Chairmanrecordtype       	:= trim(l.record_type,left,right);
           self.Chairmancorpname      		:= l.blob[1..60];
           self.Chairmanaddr1        			:= l.blob[61..90];
           self.Chairmanaddr2         		:= l.blob[91..120];
           self.Chairmancity          		:= l.blob[121..143];
           self.Chairmanstate         		:= l.blob[144..146];
           self.Chairmanzip           		:= l.blob[147..155];
           self.Chairmanblob          		:= l.blob[156..228];					 
        end;
        
        Chairman_AddressFile    := PROJECT(MasterUnload(record_type = '06'), ChairmanAddToFixed(LEFT));

				//**** Executive Office Address Recs (Type = 07)****
        ExecutiveOfficeLayout := RECORD
           string8   Executive_corpidno;
           string12  Executive_microfilmno;
           string2   Executive_recordtype;
           string60  Executive_corpname;
           string30  Executive_addr1;
           string30  Executive_addr2;
           string23  Executive_city;
           string3   Executive_state;
           string9   Executive_zip;
           string73  Executive_blob;    
        end;
  
        ExecutiveOfficeLayout  ExecutiveAddToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.Executive_corpidno       	:= trim(l.corp_id_no,left,right);
           self.Executive_microfilmno    	:= trim(l.microfilm_no,left,right);
           self.Executive_recordtype     	:= trim(l.record_type,left,right);
           self.Executive_corpname   			:= l.blob[1..60];
           self.Executive_addr1        		:= l.blob[61..90];
           self.Executive_addr2         	:= l.blob[91..120];
           self.Executive_city          	:= l.blob[121..143];
           self.Executive_state         	:= l.blob[144..146];
           self.Executive_zip           	:= l.blob[147..155];
           self.Executive_blob          	:= l.blob[156..228];						 
        end;
        
        ExecutiveOfficeFile := PROJECT(MasterUnload(record_type = '07'), ExecutiveAddToFixed(LEFT));
				
				//**** Original Partnership Recs (Type = 08)****
			  OriginalPartnership := RECORD
           string8   corpidno;
           string12  microfilmno;
           string2   recordtype;
           string150 corpname;
           string78  blob9;
        end; 
        
        OriginalPartnership  OriginalPartnerToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.corpidno        := trim(l.corp_id_no,left,right);
           self.microfilmno     := trim(l.microfilm_no,left,right);
           self.recordtype      := trim(l.record_type,left,right);
           self.corpname        := l.blob[1..150];
           self.blob9           := l.blob[151..228];
        end;
        
        OriginalPartnerFile    := PROJECT(MasterUnload(record_type = '08'), OriginalPartnerToFixed(LEFT));
   
				//**** Current Partnership Recs (Type = 09)****
			  CurrentPartnership := RECORD
           string8   corpidno;
           string12  microfilmno;
           string2   recordtype;
           string150 corpname;
           string78  blob9;
        end; 
        
        CurrentPartnership  CurrentPartnerToFixed(Layouts_Raw_Input.master l) := TRANSFORM
           self.corpidno        := trim(l.corp_id_no,left,right);
           self.microfilmno     := trim(l.microfilm_no,left,right);
           self.recordtype      := trim(l.record_type,left,right);
           self.corpname        := l.blob[1..150];
           self.blob9           := l.blob[151..228];
        end;
        
        CurrentPartnerFile    := PROJECT(MasterUnload(record_type = '09'), CurrentPartnerToFixed(LEFT));
				
				//********************* MERGER FILE ***************************************************************
				// Joining to get the reload (quartly) records that match the current update Merger records.
				Layouts_Raw_Input.merger	join2GetMergUpdates(Layouts_Raw_Input.merger l, Layouts_Raw_Input.merger r)	:=	transform
						self	:= l;
				end;
				
				JoinMergUpdates	:=	join(Files_Raw_Input.mergerSuperfile,
														     Files_Raw_Input.mergerLatest(filedate),
														     left.corp_id_no=right.corp_id_no,
														     join2GetMergUpdates(left,right),
														     lookup
														    );
					
				MergerUnload	:= if(pQuartlyReload = true,
				                    Files_Raw_Input.mergerSuperfile,
				                    dedup(sort(distribute(JoinMergUpdates + Files_Raw_Input.mergerLatest(filedate), hash(corp_id_no)),record, local), RECORD, local)
													 );
				
				//**** Merger file (Type = 01) ****
        mergerLayout := Record 
           string8   corpidno1;
           string12  microfilmno1;
           string2   recordtype1;
           string8   datefiled1;
           string6   doccode1;
           string1   adminnameflag1;
           string1   principalofficeflag1;
           string1   corpnameflag1;
           string1   durationdateflag1;
           string1   ficticiousnameflag1;
           string1   foreignincflag1;
           string1   foreignjurisdictionflag1; 
           string1   notforprofitflag1;
           string1   processinfoflag1;
           string1   provisionflag1;
           string1   purposeflag1;
           string1   registeredagentflag1;
           string1   stockflag1;
           string1   restatedcertificateflag1;
           string1   deadfileflag1;
           string1   constituentindicator1;
           string150 corpname1;
           string2   countyofficecode1;
           string8   doceffectivedate1;
           string8   durationdate1;
           string8   dissolutiondate1;
           string1   notforprofittype1;
           string8   foreignincdate1;
           string2   foreignjurisdictioncode1;
           string2   constituenttype1;
           string1   amendchairmanaddress1;
           string1   amendlocationaddress1;
           string1   admitpartner1;
           string1   withdrawpartner1;
           string5   filler1;        
        end;
        
        mergerLayout  mergerToFixed(Layouts_Raw_Input.merger l) := TRANSFORM
           self.corpidno1                     := trim(l.corp_id_no,left,right);
           self.microfilmno1                  := trim(l.microfilm_no,left,right);
           self.recordtype1                   := trim(l.record_type,left,right);
           self.datefiled1                    := trim(l.date_filed,left,right);
           self.doccode1                      := trim(l.doc_code,left,right);
           self.adminnameflag1                := trim(l.admin_name_flag,left,right);
           self.principalofficeflag1          := trim(l.principal_office_flag,left,right);
           self.corpnameflag1                 := trim(l.corp_name_flag,left,right);
           self.durationdateflag1             := trim(l.duration_date_flag,left,right);
           self.ficticiousnameflag1           := trim(l.ficticious_name_flag,left,right);
           self.foreignincflag1               := trim(l.foreign_inc_flag,left,right);
           self.foreignjurisdictionflag1      := trim(l.foreign_jurisdiction_flag,left,right);  
           self.notforprofitflag1             := trim(l.not_for_profit_flag,left,right);
           self.processinfoflag1              := trim(l.process_info_flag,left,right);
           self.provisionflag1                := trim(l.provision_flag,left,right);
           self.purposeflag1                  := trim(l.purpose_flag,left,right);
           self.registeredagentflag1          := trim(l.registered_agent_flag,left,right);
           self.stockflag1                    := trim(l.stock_flag,left,right);
           self.restatedcertificateflag1      := trim(l.restated_certificate_flag,left,right);
           self.deadfileflag1                 := trim(l.dead_file_flag,left,right);
           self.constituentindicator1         := trim(l.constituent_indicator,left,right);
           self.corpname1                     := trim(l.corp_name,left,right);
           self.countyofficecode1             := trim(l.county_office_code,left,right);
           self.doceffectivedate1             := trim(l.doc_effective_date,left,right);
           self.durationdate1                 := trim(l.duration_date,left,right);
           self.dissolutiondate1              := trim(l.dissolution_date,left,right);
           self.notforprofittype1             := trim(l.not_for_profit_type,left,right);
           self.foreignincdate1               := trim(l.foreign_inc_date,left,right);
           self.foreignjurisdictioncode1      := trim(l.foreign_jurisdiction_code,left,right);
           self.constituenttype1              := trim(l.constituent_type,left,right);
           self.amendchairmanaddress1         := trim(l.amend_chairman_address,left,right);
           self.amendlocationaddress1         := trim(l.amend_location_address,left,right);
           self.admitpartner1                 := trim(l.admit_partner,left,right);
           self.withdrawpartner1              := trim(l.withdraw_partner,left,right);
           self.filler1                       := trim(l.filler,left,right);
        end;
        
        mergerFile    := PROJECT(MergerUnload, mergerToFixed(LEFT));
        
				//********************************* Explosion Table files *****************************************************//
        // State province table
				ForgnStateDescLayout := record,MAXLENGTH(100)
           string code;
           string desc;
        end; 

        ForgnStateTable:= dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
      
			  // County Principal Table
        Country_PrincipalLayout := record,MAXLENGTH(100)
           string Code;
           string desc;   
        end;  
   
        Country_PrincipalTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::Country_Principal::ny', Country_PrincipalLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
       
        // Document Type Table
				Document_TypesLayout := record,MAXLENGTH(500)
           string Code;
           string desc;      
        end;  
      
        Document_TypesTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::Document_Types::ny', Document_TypesLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
        
				// Constituent Table
        ConstituentLayout := record,MAXLENGTH(100)
           string Contype;
           string Condesc;   
        end;
          
        ConstituentTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::Constituent::ny', ConstituentLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
				//********************************** end of explosion table defination *******************************************//
   
	 			// *************** Corps Joined files ******************* 
				jMasterProAddr_Lay := record
				    masterLayout;
						ProcessAddLayout;
						string8 IncDate	:= '';
				end;
				
				jMasterProAddr_Lay jMasterProAddrTrf(masterLayout l, ProcessAddLayout r) := transform
				    self.IncDate := l.datefiled;
						self := l;
						self := r;
						self := [];
				end;
				
				jMasterProAddr_Recs := join(masterFile, ProcessAddrFile, 
				                            trim(left.corpidno,left,right) = trim(right.Process_corpidno,left,right) and
																	  trim(left.microfilmno,left,right) = trim(right.Process_microfilmno),
																	  jMasterProAddrTrf(left,right),
																	  left outer																	 
				                           );
				
				jMasterProAddrRA_Lay := record
				   jMasterProAddr_Lay;
					 RegAgentAddrLayout;
				end;
				
				jMasterProAddrRA_Lay  jMastProAddrRATrf(jMasterProAddr_Lay l, RegAgentAddrLayout r) :=  transform
           self       := l;
           self       := r;
           self       := [];				   
				end;
				
				jMastProAddrRA_Recs := join(jMasterProAddr_Recs, RegAgentAddrFile,
				                            trim(left.corpidno,left,right) = trim(right.register_corpidno,left,right) and
																	  trim(left.microfilmno,left,right) = trim(right.register_microfilmno),
																	  jMastProAddrRATrf(left,right),
																	  left outer																	 
																	 );
				
				jMastProAddrRAExeOff_Lay := record
				   jMasterProAddrRA_Lay;
					 ExecutiveOfficeLayout;
				end;
				
				jMastProAddrRAExeOff_Lay  jMastProAddrRAExeOffTrf(jMasterProAddrRA_Lay l, ExecutiveOfficeLayout r) :=  transform
           self       := l;
           self       := r;
           self       := [];				   
				end;
				
				jMastProAddrRAExeOff_Recs := join(jMastProAddrRA_Recs, ExecutiveOfficeFile,
				                                  trim(left.corpidno,left,right) = trim(right.Executive_corpidno,left,right) and
																	        trim(left.microfilmno,left,right) = trim(right.Executive_microfilmno),
																	        jMastProAddrRAExeOffTrf(left,right),
																	        left outer																	 
																	       );
				//*** functions to check for blank address ***************************************************																	 
				PAddressBlank(jMastProAddrRAExeOff_Lay input) := function
							return if (	trim(input.Process_CorpName,left,right)='' and
													trim(input.Process_addr1,left,right)='' and
													trim(input.Process_addr2,left,right)='' and
													trim(input.Process_city,left,right)='' and
													trim(input.Process_state,left,right)='' and
													trim(input.Process_zip,left,right)='',
													true,
													false
												 );
							end;		
									
				RAAddrBlank(jMastProAddrRAExeOff_Lay input) := function
							return if (	trim(input.register_corpName,left,right)='' and
													trim(input.register_addr1,left,right)='' and
													trim(input.register_addr2,left,right)='' and
													trim(input.register_city,left,right)='' and
													trim(input.register_state,left,right)='' and
													trim(input.register_zip,left,right)='',
													true,
													false
												);
							end;

				ExeAddrBlank(jMastProAddrRAExeOff_Lay input) := function
							return if (	trim(input.Executive_corpname,left,right)='' and
													trim(input.Executive_addr1,left,right)='' and
													trim(input.Executive_addr2,left,right)='' and
													trim(input.Executive_city,left,right)='' and
													trim(input.Executive_state,left,right)='' and
													trim(input.Executive_zip,left,right)='',
													true,
													false
												);
							end;							

				jMastProAddrRAExeOff_Lay IterTrfrm1(jMastProAddrRAExeOff_Lay l, jMastProAddrRAExeOff_Lay r)	:= transform
						self.Process_CorpName		     := if (PAddressBlank(r),	l.Process_CorpName, r.Process_CorpName);
						self.Process_addr1			     :=	if (PAddressBlank(r),	l.Process_addr1, r.Process_addr1);	
						self.Process_addr2			     :=	if (PAddressBlank(r),	l.Process_addr2, r.Process_addr2);	
						self.Process_city				     :=	if (PAddressBlank(r),	l.Process_city, r.Process_city);	
						self.Process_state			     :=	if (PAddressBlank(r),	l.Process_state, r.Process_state);
						self.Process_zip				     :=	if (PAddressBlank(r),	l.Process_zip, r.Process_zip);
						self.register_CorpName		   := if (RAAddrBlank(r),	l.register_CorpName, r.register_CorpName);
						self.register_addr1				   :=	if (RAAddrBlank(r),	l.register_addr1, r.register_addr1);	
						self.register_addr2				   :=	if (RAAddrBlank(r),	l.register_addr2, r.register_addr2);	
						self.register_city				   :=	if (RAAddrBlank(r),	l.register_city, r.register_city);	
						self.register_state				   :=	if (RAAddrBlank(r),	l.register_state, r.register_state);
						self.register_zip					   :=	if (RAAddrBlank(r), l.register_zip, r.register_zip);
						self.Executive_corpname		   := if (ExeAddrBlank(r), l.Executive_corpname, r.Executive_corpname);
						self.Executive_addr1			   :=	if (ExeAddrBlank(r), l.Executive_addr1, r.Executive_addr1);	
						self.Executive_addr2			   :=	if (ExeAddrBlank(r), l.Executive_addr2, r.Executive_addr2);	
						self.Executive_city				   :=	if (ExeAddrBlank(r), l.Executive_city, r.Executive_city);	
						self.Executive_state			   :=	if (ExeAddrBlank(r), l.Executive_state, r.Executive_state);
						self.Executive_zip				   :=	if (ExeAddrBlank(r), l.Executive_zip, r.Executive_zip);
						self.countyofficecode        := if (trim(r.countyofficecode) = '', l.countyofficecode, r.countyofficecode);
						self.foreignincdate          := if (trim(r.foreignincdate) = '', l.foreignincdate, r.foreignincdate);
						self.foreignjurisdictioncode := if (trim(r.foreignjurisdictioncode) = '', l.foreignjurisdictioncode, r.foreignjurisdictioncode);
						self											   := r;
				end;		

				srtIterDs			:= sort(jMastProAddrRAExeOff_Recs, corpIdNo, corpname, datefiled);
		
				grpIterDs			:= group(srtIterDs, corpIdNo, corpname);

				NewIterDs			:= iterate(grpIterDs, IterTrfrm1(left,right));
				
				srtIterDs2		:= sort(NewIterDs, corpIdNo, datefiled);
				
				grpIterDs2		:= group(srtIterDs2, corpIdNo);
				
				jMastProAddrRAExeOff_Lay IterTrfrm2(jMastProAddrRAExeOff_Lay l, jMastProAddrRAExeOff_Lay r)	:= transform
				    self.IncDate						:= if ( trim(r.IncDate,left,right) < trim(l.IncDate,left,right), r.IncDate,
																            if (trim(l.IncDate,left,right) <> '', l.IncDate, r.IncDate)																	
														              );
						self										:= r;
				end;
				
				NewIterDs2		:= iterate(grpIterDs2, IterTrfrm2(left,right));

				srtNewIterDs	:= sort(NewIterDs2, corpIdNo, corpname, -datefiled);

				dedupSrtIter	:= dedup(srtNewIterDs, corpIdNo, corpname);	
				//****************************************************************************************************
	 
	      //******************************* Start Of CORP Mappings **********************************************
				corp2_mapping.Layout_CorpPreClean ny_corpTransformLegal(dedupSrtIter input) := transform,
				                                      skip(trim(input.corpidno) = '')
           self.dt_first_seen                 := fileDate;
           self.dt_last_seen                  := fileDate;
           self.dt_vendor_first_reported      := fileDate;
           self.dt_vendor_last_reported       := fileDate;
           self.corp_ra_dt_first_seen         := fileDate;
           self.corp_ra_dt_last_seen          := fileDate;
           self.corp_key                      := '36-'+trim(input.corpidno,left, right);
           self.corp_vendor                   := '36';
           self.corp_state_origin             :='NY';
           self.corp_process_date             := fileDate;    
           self.corp_orig_sos_charter_nbr     := trim(input.corpidno, left, right);
           self.corp_ln_name_type_cd          := '01';
           self.corp_ln_name_type_desc        := 'LEGAL';
           self.corp_src_type                 := 'SOS';
           self.corp_legal_name               := if(trim(input.corpname) <> '',cleanName(input.corpname),'');
           /* Duplicate of microfilm number in events
					 self.corp_microfilm_nbr            := if(trim(input.microfilmno) <> '',trim(input.microfilmno,left,right),'');
					 */           
           self.corp_filing_date              := if(_validate.date.fIsValid(trim(input.datefiled)) and 
                                                    _validate.date.fIsValid(trim(input.datefiled),_validate.date.rules.DateInPast),
																										trim(input.datefiled,left,right),'');

           /* Because it is a duplicate data either this is mapped to a annual report or an event record.    
					 self.corp_filing_desc              := if(_validate.date.fIsValid(trim(input.doceffectivedate)) and 
                                                    _validate.date.fIsValid(trim(input.doceffectivedate),_validate.date.rules.DateInPast) and
                                                    (integer)(input.doceffectivedate) <> 0,'EFFECTIVE DATE','');
           */
					 /* *** Commented as per the new requirement.
           self.corp_status_date              := if(_validate.date.fIsValid(trim(input.durationdate)) and 
                                                    _validate.date.fIsValid(trim(input.durationdate),_validate.date.rules.DateInPast) and
                                                    (integer)(input.durationdate) <> 0,trim(input.durationdate,left,right),'');
           */                          
                                      
           self.corp_status_desc              := If(input.doccode[1..2] in ['03','04','10','12','20','26','37','39'],'INACTIVE',
																										if((input.doccode[1..2] = '06' and trimUpper(input.doccode[3]) = 'U') OR 
                                                       trimUpper(input.constituentindicator) = 'C','INACTIVE',
                                                       if((input.doccode[1..2] = '07' and trimUpper(input.constituentindicator) = 'U') OR
                                                          trimUpper(input.constituentindicator) = 'C' or trimUpper(input.doccode[4]) = 'E','INACTIVE',
                                                          if(_validate.date.fIsValid(trim(input.durationdate)) and 
                                                             _validate.date.fIsValid(trim(input.durationdate),_validate.date.rules.DateInPast),
																														 'INACTIVE','ACTIVE')
                                                         ))
                                                       );
        
           /* *** Commented as per the new requirement
					 comment                            := if(_validate.date.fIsValid(input.durationdate) and 
                                                    _validate.date.fIsValid(input.durationdate,_validate.date.rules.DateInPast) and
                                                    (integer)input.durationdate <> 0,'DISSOLVED DATE','');
                                      
           self.corp_status_comment           := if(trim(comment) <> '','COMMENT: ','') +
					                                          'GOOD STANDING STATUS CAN ONLY BE DETERMINED BY PERFORMING A SEARCH IN THE RECORDS OF '+ 
                                                    'BOTH THE DEPARTMENT OF STATE CORPORATION RECORDS AND THE DEPARTMENT OF TAX AND FINANCE';        
           */
					 
					 self.corp_status_comment           := 'GOOD STANDING STATUS CAN ONLY BE DETERMINED BY PERFORMING A SEARCH IN THE RECORDS OF '+ 
                                                 'BOTH THE DEPARTMENT OF STATE CORPORATION RECORDS AND THE DEPARTMENT OF TAX AND FINANCE';        
					 
           self.corp_term_exist_cd            := if(trim(input.durationdate) = '' ,'P',
					                                          if((integer)input.durationdate <> 0 and _validate.date.fIsValid(trim(input.durationdate)),'D',''));
                                        
           self.corp_term_exist_exp           := if(_validate.date.fIsValid(trim(input.durationdate)),trim(input.durationdate),'');
                                        
           self.corp_term_exist_desc          := map(trim(self.corp_term_exist_cd) = 'P' => 'PERPETUAL',
					                                           trim(self.corp_term_exist_cd) = 'D' => 'EXPIRATION DATE',
																										 '');
                                        
           self.corp_inc_date                 := if(_validate.date.fIsValid(trim(input.IncDate)) and 
                                                    _validate.date.fIsValid(trim(input.IncDate),_validate.date.rules.DateInPast) and
                                                    (integer)input.IncDate <> 0,trim(input.IncDate,left,right),'') ;
                                      
           self.corp_forgn_date               := if(_validate.date.fIsValid(trim(input.foreignincdate)) and 
                                                    _validate.date.fIsValid(trim(input.foreignincdate),_validate.date.rules.DateInPast) and
                                                    (integer)input.foreignincdate <> 0,trim(input.foreignincdate,left,right),'');
                                     
           self.corp_inc_county               := if(trim(input.countyofficecode,left,right) <> ''   and 
					                                          trim(input.countyofficecode,left,right) <> '98' and 
																										trim(input.countyofficecode,left,right) <> '99',trim(input.countyofficecode,left,right),'');
                              
           self.corp_for_profit_ind           := if(trimUpper(input.notforprofitflag) = 'X' and 
					                                          (trimUpper(input.notforprofittype) = 'N' or trimUpper(input.notforprofittype) = 'A' or
                                                     trimUpper(input.notforprofittype) = 'B' or trimUpper(input.notforprofittype) = 'C' or
                                                     trimUpper(input.notforprofittype) = 'D'),'N','' );
        
           self.corp_orig_org_structure_cd    := if(trim(input.doccode) <> '',trim(input.doccode[3..4],left,right),'');
           self.corp_orig_org_structure_desc  := trim(map(trimUpper(input.doccode[3]) = 'D' => 'DOMESTIC' ,
                                                          trimUpper(input.doccode[3]) = 'F' => 'FOREIGN',
                                                          trimUpper(input.doccode[3]) = 'U' => 'UNAUTHORIZED',''))+' '+
                                                 trim(map(trimUpper(input.doccode[4]) = 'A' => 'LIMITED LIABILITY COMPANY',
                                                          trimUpper(input.doccode[4]) = 'B' => 'BUSINESS',
                                                          trimUpper(input.doccode[4]) = 'C' => 'COOPERATIVE',
                                                          trimUpper(input.doccode[4]) = 'D' => 'CONDOMINIUM',
                                                          trimUpper(input.doccode[4]) = 'E' => 'BOARD OF REGENTS',
                                                          trimUpper(input.doccode[4]) = 'G' => 'GOVERNMENTAL',
                                                          trimUpper(input.doccode[4]) = 'L' => 'LIMITED PARTNERSHIP',
                                                          trimUpper(input.doccode[4]) = 'N' => 'NOT FOR PROFIT',
                                                          trimUpper(input.doccode[4]) = 'P' => 'LIMITED LIABILITY PARTNERSHIP',
                                                          trimUpper(input.doccode[4]) = 'R' => 'RELIGIOUS',
                                                          trimUpper(input.doccode[4]) = 'S' => 'PROFESSIONAL SERVICE LIMITED LIABILITY COMPANY',
                                                          ''));
                                                                                    
           self.corp_inc_state                := if(trimUpper(input.foreignjurisdictioncode) <> '','','NY');
           self.corp_forgn_state_cd           := if(trim(input.foreignjurisdictioncode) <> '' and trimUpper(input.foreignjurisdictioncode) <> 'NY',
                                                    trimUpper(input.foreignjurisdictioncode),'');
					 self.corp_orig_bus_type_cd         := if(trim(input.constituenttype) <> '',trim(input.constituenttype,left,right),'');
					 self.corp_orig_bus_type_desc       := '';
            
           Title1                             := if(trimUpper(input.provisionflag) = 'X', 'PROVISIONS OF BUSINESS ENTITY AMENDED',''); 
           Title2                             := if(trimUpper(input.purposeflag) = 'X','PURPOSE OF BUSINESS ENTITY AMENDED' ,'');  
           Title3                             := if(trimUpper(input.restatedcertificateflag) = 'X','RESTATE CERTIFICATE AMENDED' ,'');       
           Title4                             := if(trimUpper(input.adminnameflag) = 'X','LIMITED PARTNERSHIP ADMIT AMENDED','');  
           Title5                             := if(trimUpper(input.withdrawpartner) = 'X','LIMITED PARTNERSHIP WITHDRAW AMENDED','');
           concatFields                       := trim(Title1,left,right) + ';' + 
                                                 trim(Title2,left,right) + ';' +  
                                                 trim(Title3,left,right) + ';' + 
                                                 trim(Title4,left,right) + ';' + 
																								 trim(Title5,left,right);
            
           tempExp                            := regexreplace('[;]*$',concatFields,'',NOCASE);
           tempExp2                           := regexreplace('^[;]*',tempExp,'',NOCASE);
        
           self.corp_addl_info                := regexreplace('[;]+',tempExp2,';',NOCASE);
					 
					 self.corp_address1_line1           := if(input.process_addr1 <> '',trimUpper(input.process_addr1),'');
           self.corp_address1_line2           := if(input.process_addr2 <> '',trimUpper(input.process_addr2),'');
           self.corp_address1_line3           := if(input.process_city <> '',trimUpper(input.process_city),'');
           self.corp_address1_line4           := if(input.process_state <> '',trimUpper(input.process_state),'');
           self.corp_address1_line5           := if((integer)trim(input.process_zip,left,right) <> 0 and trim(input.process_zip,left,right) <> '',trim(input.process_zip,left,right),'');
           self.corp_address1_type_cd         := if(trim(input.process_addr1,left,right) <> '' or trim(input.process_addr2,left,right) <> '' or trim(input.process_city,left,right) <> '' 
                                                    or trim(input.process_state,left,right) <> '' or trim(input.process_zip,left,right) <> '','P','');
           self.corp_address1_type_desc       := if(trim(input.process_addr1,left,right) <> '' or trim(input.process_addr2,left,right) <> '' or trim(input.process_city,left,right) <> '' 
                                                    or trim(input.process_state,left,right) <> '' or trim(input.process_zip,left,right) <> '','PROCESS ADDRESS','');
																										
           self.corp_address2_line1           := if(input.Executive_addr1 <> '',trimUpper(input.Executive_addr1),'');
           self.corp_address2_line2           := if(input.Executive_addr2 <> '',trimUpper(input.Executive_addr2),'');
           self.corp_address2_line3           := if(input.Executive_city <> '',trimUpper(input.Executive_city),'');
           self.corp_address2_line4           := if(input.Executive_state <> '',trimUpper(input.Executive_state),'');
           self.corp_address2_line5           := if((string)((integer)trim(input.Executive_zip,left,right)) <> '0' and trim(input.Executive_zip,left,right)<>'',trim(input.Executive_zip,left,right),'');
           self.corp_address2_type_cd         := if(trim(input.Executive_addr1,left,right) <> '' or trim(input.Executive_addr2,left,right) <> '' or trim(input.Executive_city,left,right) <> '' 
                                                    or trim(input.Executive_state,left,right) <> '' or trim(input.Executive_zip,left,right) <> '','B','');                               
           self.corp_address2_type_desc       := if(trim(input.Executive_addr1,left,right) <> '' or trim(input.Executive_addr2,left,right) <> '' or trim(input.Executive_city,left,right) <> '' 
                                                    or trim(input.Executive_state,left,right) <> '' or trim(input.Executive_zip,left,right) <> '','BUSINESS ADDRESS','');
																							
           self.corp_ra_name                  := if(trim(input.register_corpname) <> '' and trimUpper(input.register_corpname)<>'NO ADDRESS STATED',cleanName(input.register_corpname),'');
           self.corp_ra_title_desc            := if(trim(self.corp_ra_name) <> '','REGISTERED AGENT','');
           self.corp_ra_address_line1         := if(input.register_addr1 <> '',trimUpper(input.register_addr1),'');
           self.corp_ra_address_line2         := if(input.register_addr2 <> '',trimUpper(input.register_addr2),'');
           self.corp_ra_address_line3         := if(input.register_city <> '',trimUpper(input.register_city),'');
           self.corp_ra_address_line4         := if(input.register_state <> '',trimUpper(input.register_state),'');
           self.corp_ra_address_line5         := if((string)((integer)trim(input.register_zip,left,right)) <> '0' and 
                                                    input.register_zip <> '',trim(input.register_zip,left,right),'');
           self.corp_ra_address_type_desc     := if(input.register_addr1 <> ''or input.register_addr2<>'' or input.register_city<>'' or
                                                    input.register_state <> '' or  input.register_zip<>'','REGISTERED OFFICE ADDRESS','');
           self                               := input;
					 self                               := [];        
        end; // end transform.				
        
				// Mapping Corp legal records.
				MapCorp1          := project(dedupSrtIter, ny_corpTransformLegal(left));				
        
				// Joining the Fictitious file with the master to get the datefiled to Fictitious file.
				Fict_Layout_ext := record
				   fictLayout;
					 MasterLayout.datefiled;
				end;
				
				Fict_Layout_ext getDateFiledToFict(fictLayout l, masterLayout r) := transform
				    self.datefiled := r.datefiled;
						self := l;						
				end;
        
				FictFileExt := join(fictFile, masterFile,  
				                    trim(left.corpidno,left,right) = trim(right.corpidno,left,right) and
														trim(left.microfilmno,left,right) = trim(right.microfilmno),
														getDateFiledToFict(left,right),
														left outer																	 
				                   );
				
        // Transform2 to pre-corp layout for FICTITIOUS Name records.
        corp2_mapping.Layout_CorpPreClean ny_corpFictitious_Name(Fict_Layout_ext input) := transform,
				                                   skip(trim(input.corpidno) = '')
           self.dt_first_seen              := fileDate;
           self.dt_last_seen               := fileDate;
           self.dt_vendor_first_reported   := fileDate;
           self.dt_vendor_last_reported    := fileDate;
           self.corp_ra_dt_first_seen      := fileDate;
           self.corp_ra_dt_last_seen       := fileDate;
           self.corp_key                   := '36-' + trim(input.corpidno,left, right);
           self.corp_vendor                := '36';
           self.corp_state_origin          := 'NY';
           self.corp_process_date          := fileDate;    
           self.corp_orig_sos_charter_nbr  := trim(input.corpidno,left,right);
           self.corp_ln_name_type_cd       := '02';
           self.corp_ln_name_type_desc     := 'DBA';
           self.corp_src_type              := 'SOS';
           self.corp_legal_name            := if(trim(input.corpname) <> '',cleanName(input.corpname),'');
					 self.corp_filing_date           := if(_validate.date.fIsValid(trim(input.datefiled)) and 
                                                 _validate.date.fIsValid(trim(input.datefiled),_validate.date.rules.DateInPast),
																								 trim(input.datefiled,left,right),'');
					 // filing dates are being set to empty at later steps, as were used only to identify the DBA prior.
					 //self.corp_filing_desc           := if(_validate.date.fIsValid(trim(input.datefiled)) and 
           //                                      _validate.date.fIsValid(trim(input.datefiled),_validate.date.rules.DateInPast),
					 // 																		 'FILING DATE','');
					 self                            := input;
           self                            := [];        
        end; // end transform.
        
				// Mapping Corp Fictitious records.
				MapCorpFict           := project(FictFileExt, ny_corpFictitious_Name(left));
				
				CorpRecsForIter := MapCorp1 + MapCorpFict;
				
				//******** Setting legal names status to PRIOR based on the flags for Master records *************
				srtCorpRecs	:= sort(CorpRecsForIter, corp_key, corp_ln_name_type_cd, -corp_filing_date);

				grpCorpRecs	:= group(srtCorpRecs, corp_key, corp_ln_name_type_cd);

				corp2_mapping.Layout_CorpPreClean iterateTrfrm(corp2_mapping.Layout_CorpPreClean l, corp2_mapping.Layout_CorpPreClean r)	:= transform
					 self.corp_ln_name_type_cd		:= if(l.corp_legal_name <> r.corp_legal_name,
						  											          if(l.corp_legal_name <> '', 
																							   map (l.corp_ln_name_type_cd = '01' => 'P',
																								      l.corp_ln_name_type_cd = '02' => 'DP',
																									    l.corp_ln_name_type_cd)
																								 ,r.corp_ln_name_type_cd), l.corp_ln_name_type_cd);
					 self.corp_ln_name_type_desc	:= if(l.corp_legal_name <> r.corp_legal_name,
						  											          if(l.corp_legal_name <> '', 
																							   map (l.corp_ln_name_type_cd = '01' => 'PRIOR',
																								      l.corp_ln_name_type_cd = '02' => 'DBA PRIOR',
																									    l.corp_ln_name_type_desc)
																								 ,r.corp_ln_name_type_desc), l.corp_ln_name_type_desc);
					 
					 self.corp_filing_date	 := '';
					 self	 := r;
				end;	

				IterMastCorpDs		:= iterate(grpCorpRecs, iterateTrfrm(left,right));

				//*****************************************************************************************		
				
				// Transform3 to pre-corp layout for ORIGINAL PARTNERSHIP NAME records.
        corp2_mapping.Layout_CorpPreClean ny_corpOriginalPartnership(OriginalPartnership input) := transform,
				                                   skip(trim(input.corpidno) = '')
           self.dt_first_seen              := fileDate;
           self.dt_last_seen               := fileDate;
           self.dt_vendor_first_reported   := fileDate;
           self.dt_vendor_last_reported    := fileDate;
           self.corp_ra_dt_first_seen      := fileDate;
           self.corp_ra_dt_last_seen       := fileDate;
           self.corp_key                   := '36-'+trim(input.corpidno,left, right);
           self.corp_vendor                := '36';
           self.corp_state_origin          := 'NY';
           self.corp_process_date          := fileDate;    
           self.corp_orig_sos_charter_nbr  := trim(input.corpidno, left, right);
					 self.corp_ln_name_type_cd       := '10';
           self.corp_ln_name_type_desc     := 'ORIGINAL PARTNERSHIP NAME';
           self.corp_src_type              := 'SOS';
           self.corp_legal_name            := if(trim(input.corpname) <> '',cleanName(input.corpname),'');
					 self                            := input;
           self                            := [];        
        end; // end transform.
        
				// Mapping Corp Current Partner records.
				MapCorpOrigPartner  := project(OriginalPartnerFile, ny_corpOriginalPartnership(left));
				
        // Transform3 to pre-corp layout for CURRENT PARTNERSHIP NAME records.
        corp2_mapping.Layout_CorpPreClean ny_corpCurrentPartnership(CurrentPartnership input) := transform,
				                                   skip(trim(input.corpidno) = '')
           self.dt_first_seen              := fileDate;
           self.dt_last_seen               := fileDate;
           self.dt_vendor_first_reported   := fileDate;
           self.dt_vendor_last_reported    := fileDate;
           self.corp_ra_dt_first_seen      := fileDate;
           self.corp_ra_dt_last_seen       := fileDate;
           self.corp_key                   := '36-'+trim(input.corpidno,left, right);
           self.corp_vendor                := '36';
           self.corp_state_origin          := 'NY';
           self.corp_process_date          := fileDate;    
           self.corp_orig_sos_charter_nbr  := trim(input.corpidno, left, right);
					 self.corp_ln_name_type_cd       := '11';
           self.corp_ln_name_type_desc     := 'CURRENT PARTNERSHIP NAME';
           self.corp_src_type              := 'SOS';
           self.corp_legal_name            := if(trim(input.corpname) <> '',cleanName(input.corpname),'');
					 self                            := input;
           self                            := [];        
        end; // end transform.
        
				// Mapping Corp Current Partner records.
				MapCorpCurrentPartner  := project(CurrentPartnerFile, ny_corpCurrentPartnership(left));
				
				MastPreCorp_Recs := IterMastCorpDs + MapCorpOrigPartner + MapCorpCurrentPartner;
		
				// Transform4 to pre-corp layout for MERGER records.
				corp2_mapping.Layout_CorpPreClean ny_MergerCorpTrf(mergerLayout input) := transform,
																							skip((integer)input.corpidno1 = 0)
           self.dt_first_seen                 := fileDate;
           self.dt_last_seen                  := fileDate;
           self.dt_vendor_first_reported      := fileDate;
           self.dt_vendor_last_reported       := fileDate;
           self.corp_ra_dt_first_seen         := fileDate;
           self.corp_ra_dt_last_seen          := fileDate;
           self.corp_key                      := '36-'+trim(input.corpidno1,left, right);
           self.corp_vendor                   := '36';
           self.corp_state_origin             :='NY';
           self.corp_process_date             := fileDate;    
           self.corp_orig_sos_charter_nbr     := trim(input.corpidno1, left, right);
           self.corp_ln_name_type_cd          := 'NS';
           self.corp_ln_name_type_desc        := 'NON-SURVIVOR';
           self.corp_src_type                 := 'SOS';
           self.corp_legal_name               := if(trim(input.corpname1) <> '',cleanName(input.corpname1),'');
           /* Duplicate of microfilm number in events
					 self.corp_microfilm_nbr            := if(trim(input.microfilmno1) <> '',trim(input.microfilmno1,left,right),'');
					 */
				   /*
					 self.corp_filing_date              := if(_validate.date.fIsValid(trim(input.doceffectivedate1)) and 
																				            _validate.date.fIsValid(trim(input.doceffectivedate1),_validate.date.rules.DateInPast) and
																				            (integer)(input.doceffectivedate1) <> 0,trim(input.doceffectivedate1,left,right),'');
           self.corp_filing_desc              := if(trim(self.corp_filing_date) <> '','EFFECTIVE DATE','');
				   */
					 self.corp_inc_date                 := if(_validate.date.fIsValid(trim(input.datefiled1)) and 
																				            _validate.date.fIsValid(trim(input.datefiled1),_validate.date.rules.DateInPast) and
																				            (integer)input.datefiled1 <> 0,trim(input.datefiled1,left,right),'');           
				   self.corp_inc_county               := if(trim(input.countyofficecode1,left,right) <> ''   and 
					  													              trim(input.countyofficecode1,left,right) <> '98' and 
					  													              trim(input.countyofficecode1,left,right) <> '99',trim(input.countyofficecode1,left,right),'');
				   self.corp_orig_org_structure_cd    := if(trim(input.doccode1) <> '',trim(input.doccode1[3..4],left,right),'');
			     self.corp_orig_org_structure_desc  := trim(map(trimUpper(input.doccode1[3]) = 'D' => 'DOMESTIC' ,
																								          trimUpper(input.doccode1[3]) = 'F' => 'FOREIGN',
																								          trimUpper(input.doccode1[3]) = 'U' => 'UNAUTHORIZED',''),left,right) + ' ' +
																								 trim(map(trimUpper(input.doccode1[4]) = 'A' => 'LIMITED LIABILITY COMPANY',
																										      trimUpper(input.doccode1[4]) = 'B' => 'BUSINESS',
																										      trimUpper(input.doccode1[4]) = 'C' => 'COOPERATIVE',
																										      trimUpper(input.doccode1[4]) = 'D' => 'CONDOMINIUM',
																										      trimUpper(input.doccode1[4]) = 'E' => 'BOARD OF REGENTS',
																										      trimUpper(input.doccode1[4]) = 'G' => 'GOVERNMENTAL',
																										      trimUpper(input.doccode1[4]) = 'L' => 'LIMITED PARTNERSHIP',
																										      trimUpper(input.doccode1[4]) = 'N' => 'NOT FOR PROFIT',
																										      trimUpper(input.doccode1[4]) = 'P' => 'LIMITED LIABILITY PARTNERSHIP',
																										      trimUpper(input.doccode1[4]) = 'R' => 'RELIGIOUS',
																										      trimUpper(input.doccode1[4]) = 'S' => 'PROFESSIONAL SERVICE LIMITED LIABILITY COMPANY',
																										      ''),left,right);					 
					 self.corp_orig_bus_type_cd         := if(trim(input.constituenttype1) <> '',trim(input.constituenttype1,left,right),'');
					 self.corp_orig_bus_type_desc       := '';
					 self                               := input;
					 self                               := [];        
        end; // end transform.
				
				// Mapping Merger records to the pre-corp common layout.
				MapCorpMerger := project(mergerFile, ny_MergerCorpTrf(left));
				
				//******** Setting legal names status to PRIOR based on the flags for Merger records ***************
				srtMergCorpRecs	:= sort(MapCorpMerger, corp_key, corp_ln_name_type_cd, -corp_filing_date);

				grpMergCorpRecs	:= group(srtMergCorpRecs, corp_key, corp_ln_name_type_cd);

				corp2_mapping.Layout_CorpPreClean iterMergTrf(corp2_mapping.Layout_CorpPreClean l, corp2_mapping.Layout_CorpPreClean r)	:= transform
					 self.corp_ln_name_type_cd		:= if(l.corp_legal_name <> r.corp_legal_name,
						  											          if(l.corp_legal_name <> '', 'P', r.corp_ln_name_type_cd), l.corp_ln_name_type_cd);
					 self.corp_ln_name_type_desc	:= if(l.corp_legal_name <> r.corp_legal_name,
						  											          if(l.corp_legal_name <> '', 'PRIOR', r.corp_ln_name_type_desc), l.corp_ln_name_type_desc);
					 self	 := r;
				end;	

				IterMergCorpDs		:= iterate(grpMergCorpRecs, iterMergTrf(left,right));
				//*****************************************************************************************	
				
				All_Corp_Recs :=  MastPreCorp_Recs + IterMergCorpDs;
				
  			//********************* Explosion Table lookup joins **************************************
        //Transform to get the description for the given State Code.
				corp2_mapping.Layout_CorpPreClean getState(corp2_mapping.Layout_CorpPreClean input, ForgnStateDescLayout r ) := transform
           self.corp_forgn_state_desc  := trimUpper(r.desc);
           self                        := input;
           self                        := [];
        end; // end transform 
      
        //State Code join
        AllCorp_j1  := join(All_Corp_Recs, ForgnStateTable,
                            trim(left.corp_forgn_state_cd,left,right) = trim(right.code,left,right),
                            getState(left,right),
                            left outer, lookup
                           );    
        
        //Transform to get the description for the given County Code
				corp2_mapping.Layout_CorpPreClean getcounty(corp2_mapping.Layout_CorpPreClean input, Country_PrincipalLayout r) := transform
           self.corp_inc_county   := trimUpper(r.desc);
           self                   := input;
           self                   := [];    
        end; // end transform
       
				// Join to get the exploded value for County
        AllCorp_j2 := join(AllCorp_j1, Country_PrincipalTable,
                           trim(left.corp_inc_county,left,right) = trim(right.code,left,right),
                           getcounty(left,right),
                           left outer, lookup);
													 
				//Transform to get the description for the given County Code
				corp2_mapping.Layout_CorpPreClean getConstituent(corp2_mapping.Layout_CorpPreClean input, ConstituentLayout r) := transform
           self.corp_orig_bus_type_desc  := trimUpper(r.Condesc);
           self                          := input;
           self                          := [];
        end; // end transform
				
				// Constituent table join
        AllCorp_j3  := join(AllCorp_j2, ConstituentTable,
                            trim(left.corp_orig_bus_type_cd,left,right) = trim(right.Contype,left,right),
                            getConstituent(left,right),
                            left outer, lookup
                           ); 
				//*********************END of Explosion Table lookup joins ********************************
				
				//---------------------------- Clean corp Name and Addresses ---------------------//
        corp2.layout_corporate_direct_corp_in CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean  input) := transform

           string73 tempname            := if (trim(input.corp_ra_name) = '', '',Address.CleanPersonFML73(trim(input.corp_ra_name)));
					 
					 string182 clean_address      := if(trim(input.corp_address1_line1,left,right) <> '' or
					                                    trim(input.corp_address1_line2,left,right) <> '' or
																							trim(input.corp_address1_line3,left,right) <> '' or
															                trim(input.corp_address1_line4,left,right) <> '' or
	  	                                        trim(input.corp_address1_line5,left,right) <> '',
					                                    Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +
                                                                           trim(input.corp_address1_line2,left,right),left,right),
                                                                           trim(trim(input.corp_address1_line3,left,right) + ', ' +
                                                                                trim(input.corp_address1_line4,left,right) + ' ' +
                                                                                trim(input.corp_address1_line5,left,right),left,right)),'');
																																						 
					 string182 clean_address1     := if(trim(input.corp_ra_address_line1,left,right) <> '' or
					                                    trim(input.corp_ra_address_line2,left,right) <> '' or
																							trim(input.corp_ra_address_line3,left,right) <> '' or
															                trim(input.corp_ra_address_line4,left,right) <> '' or
	  	                                        trim(input.corp_ra_address_line5,left,right) <> '',
					                                    Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																																				trim(input.corp_ra_address_line2,left,right),left,right),
                                                                        trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																																						 trim(input.corp_ra_address_line4,left,right) + ' ' +
                                                                             trim(input.corp_ra_address_line5,left,right),left,right)),'');

					 string182 clean_address2     := if(trim(input.corp_address2_line1,left,right) <> '' or
					                                    trim(input.corp_address2_line2,left,right) <> '' or
																							trim(input.corp_address2_line3,left,right) <> '' or
															                trim(input.corp_address2_line4,left,right) <> '' or
	  	                                        trim(input.corp_address2_line5,left,right) <> '',
					                                    Address.CleanAddress182(trim(trim(input.corp_address2_line1,left,right) + ' ' +
                                                                           trim(input.corp_address2_line2,left,right),left,right),
                                                                           trim(trim(input.corp_address2_line3,left,right) + ', ' +
                                                                                trim(input.corp_address2_line4,left,right) + ' ' +
                                                                                trim(input.corp_address2_line5,left,right),left,right)),'');
																																						 
					 
           pname                        := Address.CleanNameFields(tempName);
           cname                        := DataLib.companyclean(trim(input.corp_ra_name));
           keepPerson                   := corp2.Rewrite_Common.IsPerson(trim(input.corp_ra_name));
           keepBusiness                 := corp2.Rewrite_Common.IsCompany(trim(input.corp_ra_name));
        
           self.corp_ra_title1          := if(keepPerson, pname.title, '');
           self.corp_ra_fname1          := if(keepPerson, pname.fname, '');
           self.corp_ra_mname1          := if(keepPerson, pname.mname, '');
           self.corp_ra_lname1          := if(keepPerson, pname.lname, '');
           self.corp_ra_name_suffix1    := if(keepPerson, pname.name_suffix,'');
           self.corp_ra_score1          := if(keepPerson, pname.name_score, '');
        
           self.corp_ra_cname1          := if(keepBusiness, cname[1..70],'');
           self.corp_ra_cname1_score    := if(keepBusiness, pname.name_score,'');    
    
           // Clean Corp addr1 fields
           self.corp_addr1_prim_range   := clean_address[1..10];
           self.corp_addr1_predir       := clean_address[11..12];
           self.corp_addr1_prim_name    := clean_address[13..40];
           self.corp_addr1_addr_suffix  := clean_address[41..44];
           self.corp_addr1_postdir      := clean_address[45..46];
           self.corp_addr1_unit_desig   := clean_address[47..56];
           self.corp_addr1_sec_range    := clean_address[57..64];
           self.corp_addr1_p_city_name  := clean_address[65..89];
           self.corp_addr1_v_city_name  := clean_address[90..114];
           self.corp_addr1_state        := clean_address[115..116];
           self.corp_addr1_zip5         := clean_address[117..121];
           self.corp_addr1_zip4         := clean_address[122..125];
           self.corp_addr1_cart         := clean_address[126..129];
           self.corp_addr1_cr_sort_sz   := clean_address[130];
           self.corp_addr1_lot          := clean_address[131..134];
           self.corp_addr1_lot_order    := clean_address[135];
           self.corp_addr1_dpbc         := clean_address[136..137];
           self.corp_addr1_chk_digit    := clean_address[138];
           self.corp_addr1_rec_type     := clean_address[139..140];
           self.corp_addr1_ace_fips_st  := clean_address[141..142];
           self.corp_addr1_county       := clean_address[143..145];
           self.corp_addr1_geo_lat      := clean_address[146..155];
           self.corp_addr1_geo_long     := clean_address[156..166];
           self.corp_addr1_msa          := clean_address[167..170];
           self.corp_addr1_geo_blk      := clean_address[171..177];
           self.corp_addr1_geo_match    := clean_address[178];
           self.corp_addr1_err_stat     := clean_address[179..182];
					 
           // Clean Ra Address fields
           self.corp_ra_prim_range      := clean_address1[1..10];
           self.corp_ra_predir          := clean_address1[11..12];
           self.corp_ra_prim_name       := clean_address1[13..40];
           self.corp_ra_addr_suffix     := clean_address1[41..44];
           self.corp_ra_postdir         := clean_address1[45..46];
           self.corp_ra_unit_desig      := clean_address1[47..56];
           self.corp_ra_sec_range       := clean_address1[57..64];
           self.corp_ra_p_city_name     := clean_address1[65..89];
           self.corp_ra_v_city_name     := clean_address1[90..114];
           self.corp_ra_state           := clean_address1[115..116];
           self.corp_ra_zip5            := clean_address1[117..121];
           self.corp_ra_zip4            := clean_address1[122..125];
           self.corp_ra_cart            := clean_address1[126..129];
           self.corp_ra_cr_sort_sz      := clean_address1[130];
           self.corp_ra_lot             := clean_address1[131..134];
           self.corp_ra_lot_order       := clean_address1[135];
           self.corp_ra_dpbc            := clean_address1[136..137];
           self.corp_ra_chk_digit       := clean_address1[138];
           self.corp_ra_rec_type        := clean_address1[139..140];
           self.corp_ra_ace_fips_st     := clean_address1[141..142];
           self.corp_ra_county          := clean_address1[143..145];
           self.corp_ra_geo_lat         := clean_address1[146..155];
           self.corp_ra_geo_long        := clean_address1[156..166];
           self.corp_ra_msa             := clean_address1[167..170];
           self.corp_ra_geo_blk         := clean_address1[171..177];
           self.corp_ra_geo_match       := clean_address1[178];
           self.corp_ra_err_stat        := clean_address1[179..182];

					 // Clean Corp (Executive officer) addr2 fields
           self.corp_addr2_prim_range   := clean_address2[1..10];
           self.corp_addr2_predir       := clean_address2[11..12];
           self.corp_addr2_prim_name    := clean_address2[13..40];
           self.corp_addr2_addr_suffix  := clean_address2[41..44];
           self.corp_addr2_postdir      := clean_address2[45..46];
           self.corp_addr2_unit_desig   := clean_address2[47..56];
           self.corp_addr2_sec_range    := clean_address2[57..64];
           self.corp_addr2_p_city_name  := clean_address2[65..89];
           self.corp_addr2_v_city_name  := clean_address2[90..114];
           self.corp_addr2_state        := clean_address2[115..116];
           self.corp_addr2_zip5         := clean_address2[117..121];
           self.corp_addr2_zip4         := clean_address2[122..125];
           self.corp_addr2_cart         := clean_address2[126..129];
           self.corp_addr2_cr_sort_sz   := clean_address2[130];
           self.corp_addr2_lot          := clean_address2[131..134];
           self.corp_addr2_lot_order    := clean_address2[135];
           self.corp_addr2_dpbc         := clean_address2[136..137];
           self.corp_addr2_chk_digit    := clean_address2[138];
           self.corp_addr2_rec_type     := clean_address2[139..140];
           self.corp_addr2_ace_fips_st  := clean_address2[141..142];
           self.corp_addr2_county       := clean_address2[143..145];
           self.corp_addr2_geo_lat      := clean_address2[146..155];
           self.corp_addr2_geo_long     := clean_address2[156..166];
           self.corp_addr2_msa          := clean_address2[167..170];
           self.corp_addr2_geo_blk      := clean_address2[171..177];
           self.corp_addr2_geo_match    := clean_address2[178];
           self.corp_addr2_err_stat     := clean_address2[179..182];
        
           self                         := input;
           self                         := [];
        end; //********************* cleaned corp routine ends ********				
								
				 cleanCorp         := project(AllCorp_j3, CleanCorpAddrName(left));
				//******************************* End Of CORP Mappings *********************************************
				
				//******************************* Start Of AR Mappings *********************************************
				// Transform to AR
        Corp2.Layout_Corporate_Direct_AR_In ny_arTransform(masterLayout input) := transform,
				                                     skip(trim(input.doccode[1..2]) not in ['17','32','48'] or  
																						      trim(input.corpidno) = '' )
           self.corp_key                     := '36-' + trim(input.corpidno,left,right);  
           self.corp_vendor                  := '36';
           self.corp_state_origin            := 'NY';
           self.corp_process_date            := fileDate;
           self.corp_sos_charter_nbr         := trim(input.corpidno,left,right);
           // Mapping the microfilm nbr to ar_comments because of the length that exceeds the character limit. 
					 //self.ar_microfilm_nbr             := if(trim(input.microfilmno) <> '',trim(input.microfilmno,left,right),'');
           Title1                            := 'MICROFILM NBR: ' + if(input.microfilmno<>'',trim(input.microfilmno,left,right),'');
           Title2                            := if(input.doccode[1..2] <> '' and trimUpper(input.processinfoflag) = 'X' ,
                                                   map(input.doccode[1..2] = '17' => 'ANNUAL REPORT WITH CHANGES' ,
                                                       input.doccode[1..2] = '32' => 'BIENNIAL REPORT WITH CHANGES',
                                                       input.doccode[1..2] = '48' => 'BIENNIAL STATEMENT AMENDMENT WITH CHANGES',''),
                                                       if(input.doccode[1..2] <> '' and trimUpper(input.processinfoflag) <> 'X' ,
                                                          map(input.doccode[1..2] = '17' => 'ANNUAL REPORT' ,
                                                              input.doccode[1..2] = '32' => 'BIENNIAL REPORT',
                                                              input.doccode[1..2] = '48' => 'BIENNIAL STATEMENT',''),'') 
                                                    );  
        
           concatFields                      := trim(Title1,left,right) + ';' + 
                                                trim(Title2,left,right);
            
           tempExp                           := regexreplace('[;]*$',concatFields,'',NOCASE);
           tempExp2                          := regexreplace('^[;]*',tempExp,'',NOCASE);
					 
					 effective_dt                      := if(_validate.date.fIsValid(input.doceffectivedate) and 
																				           _validate.date.fIsValid(input.doceffectivedate,_validate.date.rules.DateInPast),
																				           '; EFFECTIVE DATE: '+ 
																									 trim(input.doceffectivedate,left,right)[5..6] + '/' +
																				           trim(input.doceffectivedate,left,right)[7..8] + '/' +
																				           trim(input.doceffectivedate,left,right)[1..4],'');
        
           self.ar_comment                   := regexreplace('[;]+',tempExp2,';',NOCASE) + trim(effective_dt,left,right);
           self.ar_filed_dt                  := if(_validate.date.fIsValid(input.datefiled) and 
                                                   _validate.date.fIsValid(input.datefiled,_validate.date.rules.DateInPast),
                                                   trim(input.datefiled,left,right),'');
					 self                              := [];  
        end; // end 
				
				MapAR             := project(masterFile, ny_arTransform(left));
        //******************************* End Of AR Mappings ***********************************************
        
				//******************************* Start Of Event Mappings ******************************************				
				// Master records transform to Event layout
				Corp2.Layout_Corporate_Direct_Event_In ny_MasterEventTrf(masterLayout input) := transform,
				                                 skip(input.doccode[1..2] in ['17', '32','48'] or																				      
                                              trim(input.corpidno) = '')
                                                               
           self.corp_key                     := '36-'+trim(input.corpidno, left, right);  
           self.corp_vendor                  := '36';
           self.corp_state_origin            := 'NY';
           self.corp_process_date            := fileDate;
           self.corp_sos_charter_nbr         := trim(input.corpidno, left, right);
           self.event_filing_cd              := if(trim(input.doccode) <> '', trim(input.doccode,left,right),'');
				   //self.event_microfilm_nbr          := if(trim(input.microfilmno) <> '',trim(input.microfilmno,left,right),'');
					 // Microfilm number is mapped to even_desc field because of the length limitation in even_microfilm_nbr.
           self.event_desc                   := if(trim(input.microfilmno) <> '','MICROFILM NBR: '+trim(input.microfilmno,left,right),'');					
					 self.event_filing_date            := if(_validate.date.fIsValid(input.datefiled) and 
																			             _validate.date.fIsValid(input.datefiled,_validate.date.rules.DateInPast) and
																			             (integer)(input.datefiled) <> 0,
																			             trim(input.datefiled,left,right),'');
           self                              := [];
        end; // end 
    
        MapMasterEvent      := project(masterFile, ny_MasterEventTrf(left));
				
				// Merger records transform to Event layout
				Corp2.Layout_Corporate_Direct_Event_In ny_MergerEventTrf(mergerLayout input) := transform,
				                                 skip(input.doccode1[1..2] in ['17', '32','48'] or																				      
                                              trim(input.corpidno1) = '')
                                                               
           self.corp_key                     := '36-'+trim(input.corpidno1, left, right);  
           self.corp_vendor                  := '36';
           self.corp_state_origin            := 'NY';
           self.corp_process_date            := fileDate;
           self.corp_sos_charter_nbr         := trim(input.corpidno1, left, right);
           
           self.event_filing_date            := if(_validate.date.fIsValid(input.doceffectivedate1) and 
                                                   _validate.date.fIsValid(input.doceffectivedate1,_validate.date.rules.DateInPast) and
                                                   (integer)(input.doceffectivedate1) <> 0,trim(input.doceffectivedate1,left,right),'');
                                      
           self.event_date_type_desc         := if(_validate.date.fIsValid(input.doceffectivedate1) and 
                                                   _validate.date.fIsValid(input.doceffectivedate1,_validate.date.rules.DateInPast) and
                                                   (integer)(input.doceffectivedate1) <> 0,'MERGER','');
           /*
           self.event_desc                   := if(trim(input.constituenttype1) <> '',trim(input.constituenttype1,left,right),'');
		       */
					 // Microfilm number is mapped to even_desc field because of the length limitation in even_microfilm_nbr.
					 //self.event_microfilm_nbr          := if(trim(input.microfilmno1) <> '',trim(input.microfilmno1,left,right),'');
					 self.event_desc                   := if(trim(input.microfilmno1) <> '','MICROFILM NBR: '+trim(input.microfilmno1,left,right),'');
           self.event_filing_cd              := if(trim(input.doccode1) <> '', input.doccode1,'');					                  
           self                              := [];
        end; // end of nc_Event_transform
    
        MapMergerEvent      := project(mergerFile, ny_MergerEventTrf(left));
				
				AllEvents :=  MapMasterEvent +  MapMergerEvent;
				//************************** Explosion tables for Events **************************************
        Corp2.Layout_Corporate_Direct_Event_In getDocument_Types(Corp2.Layout_Corporate_Direct_Event_In input,  Document_TypesLayout r ) := transform
              self.event_filing_desc   := trimUpper(r.desc);
              self                     := input;
              self                     := [];
        end; // end transform
        
				// Document Type code table join
				AllEvent_j1   := join(AllEvents, Document_TypesTable,
                              trim(left.event_filing_cd,left,right) = trim(right.Code,left,right),
                              getDocument_Types(left,right),
                              left outer, lookup
                             ); 
		    //******************************* End Of Event Mappings ********************************************
				
				//******************************* Start Of CONT Mappings ********************************************
        master_Chairman_Address := Record    
           string8   Chairmancorpidno;
           string12  Chairmanmicrofilmno;
           string2   Chairmanrecordtype;
           string60  Chairmancorpname;
           string30  Chairmanaddr1;
           string30  Chairmanaddr2;
           string23  Chairmancity;
           string3   Chairmanstate;
           string9   Chairmanzip;
           string73  Chairmanblob;        
           string8   corpidno;
           string12  microfileno;
           string2   recordtype;
           string8   datefiled;
           string6   doccode;
           string1   adminnameflag;
           string1   principalofficeflag;
           string1   corpnameflag;
           string1   durationdateflag;
           string1   ficticiousnameflag;
           string1   foreignincflag;
           string1   foreignjurisdictionflag; 
           string1   notforprofitflag;
           string1   processinfoflag;
           string1   provisionflag;
           string1   purposeflag;
           string1   registeredagentflag;
           string1   stockflag;
           string1   restatedcertificateflag;
           string1   deadfileflag;
           string1   constituentindicator;
           string150 corpname;
           string2   countyofficecode;
           string8   doceffectivedate;
           string8   durationdate;
           string8   dissolutiondate;
           string1   notforprofittype;
           string8   foreignincdate;
           string2   foreignjurisdictioncode;
           string2   constituenttype;
           string1   amendchairmanaddress;
           string1   amendlocationaddress;
           string1   admitpartner;
           string1   withdrawpartner;
           string5   filler;        
        end;

       //---------------------------layouts join for cont-----------------------//
        master_Chairman_Address joined_master_Chairman(masterLayout l, ChairmanAddressLayout r) := transform
           self      := l;
           self      := r;
           self      := [];        
        end; // end transform 
        
        joined_master_Chairman_file := join(masterFile, Chairman_AddressFile, 
                                            trim(left.corpidno,left,right) = trim(right.Chairmancorpidno,left,right) and
																						trim(left.microfilmno,left,right) = trim(right.Chairmanmicrofilmno,left,right),
                                            joined_master_Chairman(left,right),
                                            right outer
                                           );
        
        // contact_TRANSFORM
        corp2_mapping.Layout_ContPreClean ny_contactTransform(master_Chairman_Address input) := transform,
				                                  skip(trim(input.Chairmancorpidno) = '')
           self.dt_first_seen             := fileDate;
           self.dt_last_seen              := fileDate;
           self.corp_key                  := '36-'+trim(input.Chairmancorpidno, left, right);
           self.corp_vendor               := '36';
           self.corp_state_origin         := 'NY';
           self.corp_process_date         := fileDate;
           self.corp_orig_sos_charter_nbr := trim(input.Chairmancorpidno, left, right);
					 self.corp_legal_name           := if(trim(input.corpname) <> '',cleanName(input.corpname),'');
           self.cont_name                 := if(trim(input.Chairmancorpname) <> '',cleanName(input.Chairmancorpname),'');
           self.cont_type_cd              := if(trim(input.Chairmancorpname) <> '','F','');
           self.cont_type_desc            := if(trim(input.Chairmancorpname) <> '','OFFICER','');
           self.cont_effective_date       := if(_validate.date.fIsValid(input.doceffectivedate) and 
                                                _validate.date.fIsValid(input.doceffectivedate,_validate.date.rules.DateInPast) and
                                                (integer)(input.doceffectivedate) <> 0, trim(input.doceffectivedate,left,right),'');

           self.cont_address_line1        := if(trim(input.Chairmanaddr1) <> '',trimUpper(input.Chairmanaddr1),'');
           self.cont_address_line2        := if(trim(input.Chairmanaddr2) <> '',trimUpper(input.Chairmanaddr2),'');
           self.cont_address_line3        := if(trim(input.Chairmancity) <> '',trimUpper(input.Chairmancity),'');
           self.cont_address_line4        := if(trim(input.Chairmanstate) <> '',trimUpper(input.Chairmanstate),'');
           self.cont_address_line5        := if((integer)input.Chairmanzip <> 0,trim(input.Chairmanzip,left,right),'');
           self.cont_address_type_cd      := if(trim(input.Chairmanaddr1) <> '' or trim(input.Chairmanaddr2) <> '' or trim(input.Chairmancity) <> '' or 
					                                      trim(input.Chairmanstate) <> '' or trim(input.Chairmanzip) <> '','T','');
           self.cont_address_type_desc    := if(trim(self.cont_address_type_cd) = 'T','CONTACT','');
           self                           := [];
        end; // end   
    
		    MapCont      := project(joined_master_Chairman_file, ny_contactTransform(left));
				
				//******************Cont Cleaning starts.****************
        Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform
           // cleaning name
           string73 tempname         := if (trim(input.cont_name) = '', '',Address.CleanPersonFML73(input.cont_name));
           pname                     := Address.CleanNameFields(tempName);
           cname                     := DataLib.companyclean(trim(input.cont_name));
           keepPerson                := Corp2.Rewrite_Common.IsPerson(trim(input.cont_name));
           keepBusiness              := Corp2.Rewrite_Common.IsCompany(trim(input.cont_name));
        
           self.cont_title1          := if(keepPerson, pname.title, '');
           self.cont_fname1          := if(keepPerson, pname.fname, '');
           self.cont_mname1          := if(keepPerson, pname.mname, '');
           self.cont_lname1          := if(keepPerson, pname.lname, '');
           self.cont_name_suffix1    := if(keepPerson, pname.name_suffix,'');
           self.cont_score1          := if(keepPerson, pname.name_score, '');
        
           self.cont_cname1          := if(keepBusiness, cname[1..70],'');
           self.cont_cname1_score    := if(keepBusiness, pname.name_score,'');    
        
           string182 clean_address   := Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +                                                                
                                                                     trim(input.cont_address_line2,left,right),left,right),                                                          
                                                                     trim(trim(input.cont_address_line3,left,right) + ', ' +
                                                                          trim(input.cont_address_line4,left,right) + ' ' +
                                                                          trim(input.cont_address_line5,left,right),left,right));

           self.cont_prim_range      := clean_address[1..10];
           self.cont_predir          := clean_address[11..12];
           self.cont_prim_name       := clean_address[13..40];
           self.cont_addr_suffix     := clean_address[41..44];
           self.cont_postdir         := clean_address[45..46];
           self.cont_unit_desig      := clean_address[47..56];
           self.cont_sec_range       := clean_address[57..64];
           self.cont_p_city_name     := clean_address[65..89];
           self.cont_v_city_name     := clean_address[90..114];
           self.cont_state           := clean_address[115..116];
           self.cont_zip5            := clean_address[117..121];
           self.cont_zip4            := clean_address[122..125];
           self.cont_cart            := clean_address[126..129];
           self.cont_cr_sort_sz      := clean_address[130];
           self.cont_lot             := clean_address[131..134];
           self.cont_lot_order       := clean_address[135];
           self.cont_dpbc            := clean_address[136..137];
           self.cont_chk_digit       := clean_address[138];
           self.cont_rec_type        := clean_address[139..140];
           self.cont_ace_fips_st     := clean_address[141..142];
           self.cont_county          := clean_address[143..145];
           self.cont_geo_lat         := clean_address[146..155];
           self.cont_geo_long        := clean_address[156..166];
           self.cont_msa             := clean_address[167..170];
           self.cont_geo_blk         := clean_address[171..177];
           self.cont_geo_match       := clean_address[178];
           self.cont_err_stat        := clean_address[179..182];
           self                      := input;
           self                      := [];
        end;
        
				cleanCont         := project(MapCont ,CleanContNameAddr(left));
				//************************Cont cleaning ends**********************************************************    
        //******************************* End Of CONT Mappings ***********************************************
				
				//******************************* Start Of STOCK Mappings ********************************************    
        masterLayout_stockLayout := Record 
           masterLayout;
           stockLayout;
        end;
				
				//---------------------------layouts join for stock -----------------------//
        masterLayout_stockLayout JoinMaster_Stock(masterLayout l, stockLayout r) := transform
           self       := l;
           self       := r;
           self       := [];        
        end; // end transform 
        
        joinedMaster_Stock_file := join(masterFile, StockFile, 
                                        trim(left.corpidno,left,right) = trim(right.stock_corpidno,left,right) and
																				trim(left.microfilmno,left,right) = trim(right.stock_microfilmno,left,right),
                                        JoinMaster_Stock(left,right),
                                        right outer
                                       );        

 				// Function to convert the number string to a proper decimal number string value. 
				// Ex:- '10000.000100' = 10000.0001
				// Ex:- '10000.000000' = 10000.00
				fValuePerShare(string str) := function
					 instr    := trim(str, left, right);
					 pos      := StringLib.StringFind(trim(instr,left,right),'.',1);
					 sp1      := if (pos > 0, (string)(integer)instr[1..pos-1], (string)(integer)instr);
					 tsp2     := if (pos > 0, instr[pos+1..],'0');
					 itsp2    := (string)(integer)tsp2;
					 sp2      := if( itsp2[1] <> '0', stringlib.StringReverse((string)(integer)stringlib.StringReverse(tsp2)),'00');
					
					 return if((integer)sp1 = 0 and (integer)sp2 = 0, '', trim(sp1) + '.' + trim(sp2));
				end;
 
        //Stock1 TRANSFORM 
        Corp2.Layout_Corporate_Direct_Stock_In ny_stock1Transform(masterLayout_stockLayout input) := transform,
				                                 skip((trim(input.stocktype1) in ['','*'] and
																				       trim(input.sharecount1) in ['','*'] and
																							 trim(input.valuepershare1) in ['','*']) or  trim(input.corpidno) = '')
           self.corp_key                 := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor              := '36';
           self.corp_state_origin        := 'NY';
           self.corp_process_date        := fileDate;
           self.corp_sos_charter_nbr     := trim(input.corpidno, left, right);
           self.stock_type               := if(trim(input.stocktype1) <> '',trim(input.stocktype1, left, right),''); 
           self.stock_shares_issued      := if(trim(input.sharecount1) <> '',trim(input.sharecount1, left, right),'');
 					 self.stock_par_value          := if(trimUpper(input.stocktype1) = 'PV',fValuePerShare(input.valuepershare1),
					                                     if(trimUpper(input.stocktype1) = 'NPV','NO PAR VALUE','')); 
           self.stock_total_capital      := if(trimUpper(input.stocktype1) = 'CAP',fValuePerShare(input.valuepershare1),'');
					 self                          := [];
        end; // end of ny_Stock_transform

        MapStock1         := project(joinedMaster_Stock_file, ny_stock1Transform(left));
				
				//Stock2 TRANSFORM
        Corp2.Layout_Corporate_Direct_Stock_In ny_stock2Transform(masterLayout_stockLayout input) := transform,
				                                skip((trim(input.stocktype2) in ['','*'] and 
																				      trim(input.sharecount2) in ['','*'] and
																						  trim(input.valuepershare2) in ['','*']) or trim(input.corpidno) = '')
           self.corp_key                := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor             := '36';
           self.corp_state_origin       := 'NY';
           self.corp_process_date       := fileDate;
           self.corp_sos_charter_nbr    := trim(input.corpidno, left, right);
           self.stock_type              := if(trim(input.stocktype2) <> '',trim(input.stocktype2, left, right),''); 
           self.stock_shares_issued     := if(trim(input.sharecount2) <> '',trim(input.sharecount2, left, right),'');
					 self.stock_par_value         := if(trimUpper(input.stocktype2) = 'PV',fValuePerShare(input.valuepershare2),
					                                    if(trimUpper(input.stocktype2)='NPV' ,'NO PAR VALUE',''));
					 self.stock_total_capital     := if(trimUpper(input.stocktype2) = 'CAP',fValuePerShare(input.valuepershare2),'');
           self                         := [];
        end; // end of ny_Stock_transform

        MapStock2         := project(joinedMaster_Stock_file, ny_stock2Transform(left));

        //Stock3 TRANSFORM
        Corp2.Layout_Corporate_Direct_Stock_In ny_stock3Transform(masterLayout_stockLayout input) := transform,
				                                skip((trim(input.stocktype3) in ['','*'] and 
																				      trim(input.sharecount3) in ['','*'] and
																						  trim(input.valuepershare3) in ['','*']) or  trim(input.corpidno) = '')
           self.corp_key                := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor             := '36';
           self.corp_state_origin       := 'NY';
           self.corp_process_date       := fileDate;
           self.corp_sos_charter_nbr    := trim(input.corpidno, left, right);
           self.stock_type              := if(trim(input.stocktype3) <> '',trim(input.stocktype3, left, right),''); 
           self.stock_shares_issued     := if(trim(input.sharecount3) <> '',trim(input.sharecount3, left, right),'');
					 self.stock_par_value         := if(trimUpper(input.stocktype3) = 'PV',fValuePerShare(input.valuepershare3),
					                                    if(trimUpper(input.stocktype3) = 'NPV','NO PAR VALUE',''));
					 self.stock_total_capital     := if(trimUpper(input.stocktype3) = 'CAP',fValuePerShare(input.valuepershare3),'');
           self                         := [];
        end; // end of ny_Stock_transform
        
				MapStock3         := project(joinedMaster_Stock_file, ny_stock3Transform(left));
				
        //Stock4 TRANSFORM 
        Corp2.Layout_Corporate_Direct_Stock_In ny_stock4Transform(masterLayout_stockLayout input) := transform,
				                               skip((trim(input.stocktype4) in ['','*'] and 
																			       trim(input.sharecount4) in ['','*'] and
																						 trim(input.valuepershare4) in ['','*']) or trim(input.corpidno) = '')
           self.corp_key               := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor            := '36';
           self.corp_state_origin      := 'NY';
           self.corp_process_date      := fileDate;
           self.corp_sos_charter_nbr   := trim(input.corpidno, left, right);
           self.stock_type             := if(trim(input.stocktype4) <> '',trim(input.stocktype4, left, right),''); 
           self.stock_shares_issued    := if(trim(input.sharecount4) <> '',trim(input.sharecount4, left, right),'');
					 self.stock_par_value        := if(trimUpper(input.stocktype4) = 'PV',fValuePerShare(input.valuepershare4),
					                                   if(trimUpper(input.stocktype4) = 'NPV','NO PAR VALUE',''));
					 self.stock_total_capital    := if(trimUpper(input.stocktype4) = 'CAP',fValuePerShare(input.valuepershare4),'');
           self                        := [];        
        end; // end of ny_Stock_transform
        
				MapStock4         := project(joinedMaster_Stock_file, ny_stock4Transform(left));
				
        //Stock5 TRANSFORM 
        Corp2.Layout_Corporate_Direct_Stock_In ny_stock5Transform(masterLayout_stockLayout input) := transform,
				                               skip((trim(input.stocktype5) in ['','*'] and 
																			       trim(input.sharecount5) in ['','*'] and 
																						 trim(input.valuepershare5) in ['','*']) or trim(input.corpidno) = '')
           self.corp_key               := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor            := '36';
           self.corp_state_origin      := 'NY';
           self.corp_process_date      := fileDate;
           self.corp_sos_charter_nbr   := trim(input.corpidno, left, right);
           self.stock_type             := if(trim(input.stocktype5) <> '',trim(input.stocktype5, left, right),''); 
           self.stock_shares_issued    := if(trim(input.sharecount5) <> '',trim(input.sharecount5, left, right),'');
 					 self.stock_par_value        := if(trimUpper(input.stocktype5) = 'PV',fValuePerShare(input.valuepershare5),
					                                   if(trimUpper(input.stocktype5) = 'NPV','NO PAR VALUE',''));
					 self.stock_total_capital    := if(trimUpper(input.stocktype5) = 'CAP',fValuePerShare(input.valuepershare5),'');
           self                        := [];
        end; // end of ny_Stock_transform M.R.
        
				MapStock5         := project(joinedMaster_Stock_file, ny_stock5Transform(left));
        
        //Stock6 TRANSFORM  
				Corp2.Layout_Corporate_Direct_Stock_In ny_stock6Transform(masterLayout_stockLayout input) := transform,
				                               skip((trim(input.stocktype6) in ['','*'] and
																			       trim(input.sharecount6) in ['','*'] and
																						 trim(input.valuepershare6) in ['','*']) or trim(input.corpidno) = '')
           self.corp_key               := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor            := '36';
           self.corp_state_origin      := 'NY';
           self.corp_process_date      := fileDate;
           self.corp_sos_charter_nbr   := trim(input.corpidno, left, right);
           self.stock_type             := if(trim(input.stocktype6) <> '',trim(input.stocktype6, left, right),''); 
           self.stock_shares_issued    := if(trim(input.sharecount6) <> '',trim(input.sharecount6, left, right),'');
					 self.stock_par_value        := if(trimUpper(input.stocktype6) = 'PV',fValuePerShare(input.valuepershare6),
					                                   if(trimUpper(input.stocktype6) = 'NPV','NO PAR VALUE',''));
					 self.stock_total_capital    := if(trimUpper(input.stocktype6) = 'CAP',fValuePerShare(input.valuepershare6),'');
           self                        := [];        
        end; // end of ny_Stock_transform 
        
				MapStock6         := project(joinedMaster_Stock_file, ny_stock6Transform(left));
				
        //Stock7 TRANSFORM  
        Corp2.Layout_Corporate_Direct_Stock_In ny_stock7Transform(masterLayout_stockLayout input) := transform,
				                               skip((trim(input.stocktype7) in ['','*'] and 
																			       trim(input.sharecount7) in ['','*'] and
																						 trim(input.valuepershare7) in ['','*']) or trim(input.corpidno) = '')
           self.corp_key               := '36-'+trim(input.corpidno, left, right);
           self.corp_vendor            := '36';
           self.corp_state_origin      := 'NY';
           self.corp_process_date      := fileDate;
           self.corp_sos_charter_nbr   := trim(input.corpidno, left, right);
           self.stock_type             := if(trim(input.stocktype7) <> '',trim(input.stocktype7, left, right),''); 
           self.stock_shares_issued    := if(trim(input.sharecount7) <> '',trim(input.sharecount7, left, right),'');
					 self.stock_par_value        := if(trimUpper(input.stocktype7) = 'PV',fValuePerShare(input.valuepershare7),
					                                   if(trimUpper(input.stocktype7) = 'NPV','NO PAR VALUE',''));
					 self.stock_total_capital    := if(trimUpper(input.stocktype7) = 'CAP',fValuePerShare(input.valuepershare7),'');
           self                        := [];
        end; // end of ny_Stock_transform
        
				MapStock7         := project(joinedMaster_Stock_file, ny_stock7Transform(left));
				
        //Stock8 TRANSFORM 
				Corp2.Layout_Corporate_Direct_Stock_In ny_stock8Transform(masterLayout_stockLayout input) := transform,
				                               skip((trim(input.stocktype8) in ['','*'] and 
																			       trim(input.sharecount8) in ['','*'] and
																						 trim(input.valuepershare8) in ['','*']) or trim(input.corpidno) = '')
           self.corp_key               := '36-'+trim(input.corpidno,left,right);
           self.corp_vendor            := '36';
           self.corp_state_origin      := 'NY';
           self.corp_process_date      := fileDate;
           self.corp_sos_charter_nbr   := trim(input.corpidno, left, right);
           self.stock_type             := if(trim(input.stocktype8) <> '',trim(input.stocktype8, left, right),''); 
           self.stock_shares_issued    := if(trim(input.sharecount8) <> '',trim(input.sharecount8, left, right),'');
					 self.stock_par_value        := if(trimUpper(input.stocktype8) = 'PV',fValuePerShare(input.valuepershare8),
					                                   if(trimUpper(input.stocktype8) = 'NPV','NO PAR VALUE',''));
					 self.stock_total_capital    := if(trimUpper(input.stocktype8) = 'CAP',fValuePerShare(input.valuepershare8),'');
           self                        := [];
        end; // end of ny_Stock_transform
        
				MapStock8         := project(joinedMaster_Stock_file, ny_stock8Transform(left));
            
        MapStock          := MapStock1 + MapStock2 + MapStock3 + MapStock4 + MapStock5 + MapStock6 + MapStock7 + MapStock8;
        
				//******************************* End Of STOCK Mappings ********************************************
	
				VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_ny'  ,sort(cleanCorp,corp_key),corp_out ,,,pOverwrite);        
        VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ny' ,AllEvent_j1      ,event_out,,,pOverwrite);
        VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ny'    ,MapAR                   ,ar_out   ,,,pOverwrite);
        VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_ny'  ,cleanCont               ,cont_out ,,,pOverwrite);
        VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ny' ,dedup(sort(MapStock,corp_key),record),stock_out,,,pOverwrite);

        mapped_ny_Filing :=  parallel( corp_out    
																		  ,event_out
																		  ,ar_out        
																		  ,cont_out    
																		  ,stock_out
																		 );
        
        result := 
          sequential(
           if(pShouldSpray = true,
					    sequential(
							   fSprayFiles('ny',filedate,pOverwrite := pOverwrite),
								 if(pQuartlyReload = true,
								    sequential(
										   fileservices.clearsuperfile('~thor_data400::in::corp2::ny::vendor_master'),
											 fileservices.clearsuperfile('~thor_data400::in::corp2::ny::vendor_merger'),
											 fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_master' ,'~thor_data400::in::corp2::'+filedate+'::master::ny'),
											 fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_merger' ,'~thor_data400::in::corp2::'+filedate+'::merger::ny')
											 )
							       )
							)
					 )
          ,mapped_ny_Filing 
          ,parallel(
              fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp' ,'~thor_data400::in::corp2::'+version+'::corp_ny'),              
              fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont' ,'~thor_data400::in::corp2::'+version+'::cont_ny'),
              fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'   ,'~thor_data400::in::corp2::'+version+'::ar_ny'),
              fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_ny'),
              fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_ny')
					),
					if(pQuartlyReload = false,
						 parallel(
								fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_master' ,'~thor_data400::in::corp2::'+filedate+'::master::ny'),
								fileservices.addsuperfile('~thor_data400::in::corp2::ny::vendor_merger' ,'~thor_data400::in::corp2::'+filedate+'::merger::ny')		
						))					
          );      
        return result;        
    end;//Function end
end; // end of Ny module    