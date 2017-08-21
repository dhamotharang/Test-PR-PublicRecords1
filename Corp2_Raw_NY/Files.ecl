import corp2, tools, Corp2_Raw_NY, Corp2_mapping, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE,
						 BOOLEAN pquarterlyReload = FALSE) := MODULE

	// Input Files   
	//-----------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Input.MasterLatest, Corp2_Raw_NY.Layouts.MasterLayoutIn252, MasterLatest);
		tools.mac_FilesInput(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Input.MasterSuper,  Corp2_Raw_NY.Layouts.MasterLayoutIn,    MasterSuper);
		
		tools.mac_FilesInput(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Input.MergerLatest,	Corp2_Raw_NY.Layouts.MergerLayoutIn,    MergerLatest);
		tools.mac_FilesInput(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Input.MergerSuper,	Corp2_Raw_NY.Layouts.MergerLayoutIn,    MergerSuper);
				
		EXPORT rawMasterLatest  := if(pquarterlyReload = false ,MasterLatest.logical);
		EXPORT rawMasterSuper   := MasterSuper.Root;

		EXPORT rawMergerLatest  := if(pquarterlyReload = false ,MergerLatest.logical);
		EXPORT rawMergerSuper   := MergerSuper.Root;
				
	  //------------------------------------------------------------------------------------
    // Prepare the Master file based on if this is a Quarterly Reload or a Weekly Update 
	  //------------------------------------------------------------------------------------
		
		// Weekly Master recs are 10 chars less than Quarterly Master recs. Project Weekly recs into Quarterly layout
		EXPORT masterWeekly := if(pquarterlyReload = false
		                          ,project(rawMasterLatest,Corp2_Raw_NY.Layouts.MasterLayoutIn));	  
	  
		// Join to get Quarterly Master Reload recs that match current Weekly Master Update recs		
		jMastUpdates	:=	if(pquarterlyReload = false
		                     ,join(rawMasterSuper, masterWeekly,
															 left.corp_id_no=right.corp_id_no,
															 transform(Corp2_Raw_NY.Layouts.MasterLayoutIn, self := left), lookup ));
				
		// If Quarterly Reload then, just read recs from masterSuper, otherwise use the Quarterly/Weekly joined file
		EXPORT MasterUnload	:= if(pquarterlyReload = true
													    ,rawMasterSuper
													    ,dedup(sort(distribute(jMastUpdates + masterWeekly, hash(corp_id_no)),record, local), record, local) );
		
	 	// Parse the different Master record types into the appropriate layout
			
		// Master Recs (Type 01)
		Corp2_Raw_NY.Layouts.MasterLayout trfMaster(Corp2_Raw_NY.Layouts.MasterLayoutIn l) :=  transform
				 self.corpidno                := corp2.t2u(l.corp_id_no);
				 self.microfilmno             := corp2.t2u(l.microfilm_no);
				 self.recordtype              := corp2.t2u(l.record_type);
				 self.datefiled               := l.blob[1..8];
				 self.doccode_CertCd					:= l.blob[9..10];
				 self.doccode_AuthTyp					:= l.blob[11];
				 self.doccode_BusTyp					:= l.blob[12];
				 self.doccode_filler					:= l.blob[13];
				 self.doccode_FictTyp					:= l.blob[14];
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
				 self.filler                  := l.blob[224..230];
		  end;
		
  	  EXPORT MasterFile := PROJECT(MasterUnload(record_type = '01'), trfMaster(LEFT));
	
	  
		  // Process Address Recs (Type 02)
			Corp2_Raw_NY.Layouts.ProcAddrLayout  trfProcAddr(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.Process_corpidno       := corp2.t2u(l.corp_id_no);
				 self.Process_microfilmno    := corp2.t2u(l.microfilm_no);
				 self.Process_recordtype     := corp2.t2u(l.record_type);
				 self.Process_corpname       := l.blob[1..60];
				 self.Process_addr1          := l.blob[61..90];
				 self.Process_addr2          := l.blob[91..120];
				 self.Process_city           := l.blob[121..143];
				 self.Process_state          := l.blob[144..146];
				 self.Process_zip            := l.blob[147..155];
				 self.Process_filler         := l.blob[156..230];
			end;
			
			EXPORT ProcAddrFile    := PROJECT(MasterUnload(record_type = '02'), trfProcAddr(LEFT));    
			
		  // Register Agent Address Recs (Type 03)
			Corp2_Raw_NY.Layouts.RegAgentLayout  trfRegAgent(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.register_corpidno       := corp2.t2u(l.corp_id_no);
				 self.register_microfilmno    := corp2.t2u(l.microfilm_no);
				 self.register_recordtype     := corp2.t2u(l.record_type);
				 self.register_corpname      	:= l.blob[1..60];
				 self.register_addr1        	:= l.blob[61..90];
				 self.register_addr2         	:= l.blob[91..120];
				 self.register_city          	:= l.blob[121..143];
				 self.register_state         	:= l.blob[144..146];
				 self.register_zip           	:= l.blob[147..155];
				 self.register_filler        	:= l.blob[156..230];      
			end;
			
			EXPORT RegAgentFile    := PROJECT(MasterUnload(record_type = '03'), trfRegAgent(LEFT));
			
		  // Fictitious Name Recs (Type 04)
			Corp2_Raw_NY.Layouts.FictNameLayout trfFictName(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.fictname_corpidno        := corp2.t2u(l.corp_id_no);
				 self.fictname_microfilmno     := corp2.t2u(l.microfilm_no);
				 self.fictname_recordtype      := corp2.t2u(l.record_type);
				 self.fictname_corpname        := l.blob[1..150];
				 self.fictname_filler          := l.blob[151..230];
			end;
			
			EXPORT FictNameFile := PROJECT(MasterUnload(record_type = '04'), trfFictName(LEFT));

		  // Stock Recs (Type 05)
			Corp2_Raw_NY.Layouts.StockLayout  trfStock(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.stock_corpidno         := corp2.t2u(l.corp_id_no);    
				 self.stock_microfilmno      := corp2.t2u(l.microfilm_no);    
				 self.stock_recordtype       := corp2.t2u(l.record_type);   
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
				 self.stock_filler           := l.blob[225..230];        
			end;
			
			EXPORT StockFile    := PROJECT(MasterUnload(record_type = '05'), trfStock(LEFT));

		  // Chairman / Chief Executive Recs (Type 06)
			Corp2_Raw_NY.Layouts.ChairmanLayout  trfChairman(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.Chairman_corpidno         := corp2.t2u(l.corp_id_no);
				 self.Chairman_microfilmno      := corp2.t2u(l.microfilm_no);
				 self.Chairman_recordtype       := corp2.t2u(l.record_type);
				 self.Chairman_corpname      		:= l.blob[1..60];
				 self.Chairman_addr1        		:= l.blob[61..90];
				 self.Chairman_addr2         		:= l.blob[91..120];
				 self.Chairman_city          		:= l.blob[121..143];
				 self.Chairman_state         		:= l.blob[144..146];
				 self.Chairman_zip           		:= l.blob[147..155];
				 self.Chairman_filler        		:= l.blob[156..230];					 
			end;
			
			EXPORT ChairmanFile    := PROJECT(MasterUnload(record_type = '06'), trfChairman(LEFT));

		  // Executive Office Address Recs (Type 07)
			Corp2_Raw_NY.Layouts.ExecOffLayout  trfExecOff(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.Executive_corpidno       	:= corp2.t2u(l.corp_id_no);
				 self.Executive_microfilmno    	:= corp2.t2u(l.microfilm_no);
				 self.Executive_recordtype     	:= corp2.t2u(l.record_type);
				 self.Executive_corpname   			:= l.blob[1..60];
				 self.Executive_addr1        		:= l.blob[61..90];
				 self.Executive_addr2         	:= l.blob[91..120];
				 self.Executive_city          	:= l.blob[121..143];
				 self.Executive_state         	:= l.blob[144..146];
				 self.Executive_zip           	:= l.blob[147..155];
				 self.Executive_filler         	:= l.blob[156..230];						 
			end;
			
			EXPORT ExecOffFile := PROJECT(MasterUnload(record_type = '07'), trfExecOff(LEFT));
			
		  // Original Partnership Recs (Type 08)
			Corp2_Raw_NY.Layouts.OrigPartLayout  trfOrigPart(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.origpart_corpidno        := corp2.t2u(l.corp_id_no);
				 self.origpart_microfilmno     := corp2.t2u(l.microfilm_no);
				 self.origpart_recordtype      := corp2.t2u(l.record_type);
				 self.origpart_corpname        := l.blob[1..150];
				 self.origpart_filler          := l.blob[151..230];
			end;
			
			EXPORT OrigPartFile    := PROJECT(MasterUnload(record_type = '08'), trfOrigPart(LEFT));
 
		  // Current Partnership Recs (Type 09)
			Corp2_Raw_NY.Layouts.CurrPartLayout  trfCurrPart(Corp2_Raw_NY.Layouts.MasterLayoutIn l) := TRANSFORM
				 self.currpart_corpidno        := corp2.t2u(l.corp_id_no);
				 self.currpart_microfilmno     := corp2.t2u(l.microfilm_no);
				 self.currpart_recordtype      := corp2.t2u(l.record_type);
				 self.currpart_corpname        := l.blob[1..150];
				 self.currpart_filler          := l.blob[151..230];
			end;
			
			EXPORT CurrPartFile    := PROJECT(MasterUnload(record_type = '09'), trfCurrPart(LEFT));
		
		
		//------------------------------------------------------------------------------------
    // Prepare the Merger file based on it this is a Quarterly Reload or a Weekly Update 
	  //------------------------------------------------------------------------------------	
			
		// Join to get Quarterly Merger Reload recs that match current Weekly Merger Update recs
		jMergUpdates	:=	if(pquarterlyReload = false
		                     ,join(rawMergerSuper, rawMergerLatest,
															 left.merger_corp_id_no=right.merger_corp_id_no,
															 transform(Corp2_Raw_NY.Layouts.MergerLayoutIn, self := left), lookup ));
		
		// If Quarterly Reload then, just read recs from masterSuper, otherwise use the Quarterly/Weekly joined file
		EXPORT MergerUnload	:= if(pquarterlyReload = true
													,rawMergerSuper
													,dedup(sort(distribute(jMergUpdates + rawMergerLatest, hash(merger_corp_id_no)),record, local), record, local) );
	
		
	END;

	
	// Base Files  
	//-----------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.Master,   Corp2_Raw_NY.Layouts.MasterLayoutBase,   Master);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.ProcAddr, Corp2_Raw_NY.Layouts.ProcAddrLayoutBase, ProcAddr);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.RegAgent, Corp2_Raw_NY.Layouts.RegAgentLayoutBase, RegAgent);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.FictName, Corp2_Raw_NY.Layouts.FictNameLayoutBase, FictName);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.Stock,    Corp2_Raw_NY.Layouts.StockLayoutBase,    Stock);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.Chairman, Corp2_Raw_NY.Layouts.ChairmanLayoutBase, Chairman);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.ExecOff,  Corp2_Raw_NY.Layouts.ExecOffLayoutBase,  ExecOff);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.OrigPart, Corp2_Raw_NY.Layouts.OrigPartLayoutBase, OrigPart);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.CurrPart, Corp2_Raw_NY.Layouts.CurrPartLayoutBase, CurrPart);
		tools.mac_FilesBase(Corp2_Raw_NY.Filenames(pversion, pUseOtherEnvironment).Base.Merger,   Corp2_Raw_NY.Layouts.MergerLayoutBase,   Merger);
	END;

END;
