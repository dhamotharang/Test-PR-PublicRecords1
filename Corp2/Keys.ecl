import doxie, tools, corp2_Mapping;

//export Keys :=
export Keys(const string pversion = '') :=
module

	shared CorpBase		:= Files().Base.Corp.Built;
	shared ContBase		:= Files().Base.Cont.Built;
	shared EventBase	:= Files().Base.Events.Built;
	shared StockBase	:= Files().Base.Stock.Built;
	shared ARBase			:= Files().Base.AR.Built;
	shared CorpBaseAID := Files().AID.Corp.Built;
	shared ContBaseAID := Files().AID.Cont.Built;

shared Layout_Corp_Base_Dir := Corp2.Layout_Corporate_Direct_Corp_Base;
shared Layout_Corp_Base_Linkids := Corp2.Layout_Corporate_Direct_Corp_Base_Linkids;

//Cleanup Corp base file	
  Layout_Corp_Base_Linkids TFixCorpBase(CorpBaseAID L) := TRANSFORM
		SELF.corp_legal_name 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.corp_legal_name);
		SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
		SELF := L;
  END;
	
	export CorpBaseCleanLinkids := PROJECT(CorpBaseAID,TFixCorpBase(LEFT));
	
	export CorpBaseClean := PROJECT(CorpBaseCleanLinkids, Layout_Corp_Base_Dir);
	
//Cleanup Cont base file
//Droping the cont records that have bad or blank contact name records as per #22540 	
shared Layout_Cont_Base := Corp2.Layout_Corporate_Direct_Cont_Base;
shared Layout_Cont_Base_Linkids := Corp2.Layout_Corporate_Direct_Cont_Base_Linkids;

  Layout_Cont_Base_Linkids TFixContBase(ContBaseAID L) := TRANSFORM,
												skip(length(Corp2_Mapping.fn_RemoveSpecialChars(L.cont_name)) <= 1)
												
		SELF.corp_legal_name 	:= Corp2_Mapping.fn_RemoveSpecialChars(L.corp_legal_name);
		SELF.cont_cname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_cname);
		SELF.cont_name 				:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_name);
		SELF.cont_fname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_fname);
		SELF.cont_mname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_mname);
		SELF.cont_lname 			:= Corp2_Mapping.fn_RemoveSpecialChars(L.cont_lname);
		SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
		SELF := L;
  END;
	export ContBaseCleanLinkids := PROJECT(ContBaseAID,TFixContBase(LEFT));
	export ContBaseClean := PROJECT(ContBaseCleanLinkids,Layout_Cont_Base);

  //Cleanup AR base file
	shared Layout_AR_Base := Corp2.Layout_Corporate_Direct_AR_Base;
	
  Layout_AR_Base TFixARBase(ARBase L) := TRANSFORM
		SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
    SELF := L;
  END;
  
	export ARBaseClean := PROJECT(ARBase,TFixARBase(LEFT));
	
	shared Layout_Event_Base := Corp2.Layout_Corporate_Direct_Event_Base;
	
  Layout_Event_Base TFixEventBase(EventBase L) := TRANSFORM
	 SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
     SELF := L;
  END;
  
	export EventBaseClean := PROJECT(EventBase,TFixEventBase(LEFT));

	//Cleanup Stock base file	
	shared Layout_Stock_Base := Corp2.Layout_Corporate_Direct_Stock_Base;
	
  Layout_Stock_Base TFixStockBase(StockBase L) := TRANSFORM
	 SELF.corp_sos_charter_nbr := StringLib.StringToUpperCase(L.corp_sos_charter_nbr);
     SELF := L;
  END;
  
	export StockBaseClean := PROJECT(StockBase,TFixStockBase(LEFT));
	
	export Corp :=
	module


		shared corp_sos_charter_nbr(string charter) := (string32) regexfind('([^0].*)$',charter,0);
		
		shared FilterBdids		:= CorpBaseClean(bdid != 0);
		shared DedupBdids			:= dedup(sort(distribute(FilterBdids,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local);
		shared FilterName			:= CorpBaseClean(corp_legal_name != '');
		
		shared corpkeyfields		:= {CorpBaseCleanLinkids.corp_key					, CorpBaseCleanLinkids.record_type};
		shared nameaddrkeyfields	:= {FilterName.corp_legal_name			, FilterName.corp_addr1_zip5, FilterName.corp_addr1_prim_name, FilterName.corp_addr1_prim_range};
		
		
		shared stcharterkeyfields 	 := {CorpBaseClean.corp_state_origin	, corp_sos_charter_nbr(CorpBaseClean.corp_sos_charter_nbr)};
				
		Shared CorpBaseClean_Sorted 					:= distribute(CorpBaseCleanLinkids,RANDOM() );																	
																
		Shared FilterName_Sorted 							:= distribute(FilterName,RANDOM() );
																		
		Shared CorpBaseClean_StCharter_Sorted := distribute(CorpBaseClean,RANDOM() );
																	
		export Bdid			 := tools.macf_FilesIndex('DedupBdids			                ,{bdid}							,{corp_key}			        ',keynames(pversion).Corp.Bdid			);
		export BdidPl		 := tools.macf_FilesIndex('DedupBdids			                ,{bdid}							,{DedupBdids}		        ',keynames(pversion).Corp.BdidPl		);
		export CorpKey	 := tools.macf_FilesIndex('CorpBaseClean_Sorted	          ,corpkeyfields			,{CorpBaseClean_Sorted} ',keynames(pversion).Corp.CorpKey	  );
		export NameAddr	 := tools.macf_FilesIndex('FilterName_Sorted			        ,nameaddrkeyfields	,{corp_key}			        ',keynames(pversion).Corp.NameAddr	);
		export StCharter := tools.macf_FilesIndex('CorpBaseClean_StCharter_Sorted	,stcharterkeyfields	,{corp_key}			        ',keynames(pversion).Corp.StCharter );

	end;

	export Cont :=
	module

		shared FilterBdids		 := ContBaseClean(bdid != 0);
		shared FilterDids		 := ContBaseClean(did != 0);
		Shared DedupBdids		 := dedup(sort(distribute(FilterBdids,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local);
		Shared dedupDids		 := project(dedup(sort(distribute(FilterDids,hash(did)),did,corp_key,-dt_last_seen,if(cont_type_desc=constants.Ra_desc,1,0), local),did,corp_key,local),transform({FilterDids.did,FilterDids.corp_key,FilterDids.cont_type_desc},self:=left));
		
		shared corpkeyfields	 := {ContBaseCleanLinkids.corp_key, ContBaseCleanLinkids.record_type};
		shared nameaddrkeyfields := {ContBaseClean.cont_lname, ContBaseClean.cont_fname, ContBaseClean.cont_state};
		
		Shared ContBaseClean_Sorted 					:= distribute(ContBaseCleanLinkids,RANDOM() );
														
		Shared ContBaseClean_NameAddr_Sorted 	:= distribute(ContBaseClean,RANDOM() );
																			
		export Bdid			 := tools.macf_FilesIndex('DedupBdids			                ,{bdid}							,{corp_key}			        ',keynames(pversion).Cont.BDid			);
		export CorpKey	 := tools.macf_FilesIndex('ContBaseClean_Sorted	          ,corpkeyfields			,{ContBaseClean_Sorted} ',keynames(pversion).Cont.CorpKey	  );
		export NameAddr	 := tools.macf_FilesIndex('ContBaseClean_NameAddr_Sorted  ,nameaddrkeyfields	,{corp_key}			        ',keynames(pversion).Cont.NameAddr	);
		export Did			 := tools.macf_FilesIndex('DedupDids			                ,{Did}							,{DedupDids}			      ',keynames(pversion).Cont.Did			  );

	end;

	export Events :=
	module

		shared FilterBdids		:= EventBaseClean(bdid != 0);
		Shared DedupBdids		:= dedup(sort(distribute(FilterBdids,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local);

		shared corpkeyfields	:= {EventBaseClean.corp_key, EventBaseClean.record_type};
		
		Shared EventBaseClean_Sorted 		:= distribute(EventBaseClean,RANDOM() );
																		
		export Bdid		 := tools.macf_FilesIndex('DedupBdids			        ,{bdid}				,{corp_key}				        ',keynames(pversion).Events.Bdid		);
		export CorpKey := tools.macf_FilesIndex('EventBaseClean_Sorted	,corpkeyfields,{EventBaseClean_Sorted}	',keynames(pversion).Events.CorpKey );

	end;

	export Stock :=
	module

		shared FilterBdids		:= StockBaseClean(bdid != 0);
		Shared DedupBdids		:= dedup(sort(distribute(FilterBdids,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local);

		shared corpkeyfields	:= {StockBaseClean.corp_key, StockBaseClean.record_type};

		Shared StockBaseClean_Sorted 		:= distribute(StockBaseClean,RANDOM() );
		
		export Bdid		 := tools.macf_FilesIndex('DedupBdids			        ,{bdid}					,{corp_key}				      ',keynames(pversion).Stock.Bdid		);
		export Corpkey := tools.macf_FilesIndex('StockBaseClean_Sorted	,corpkeyfields	,{StockBaseClean_Sorted}',keynames(pversion).Stock.CorpKey);

	end;

	export AR :=
	module

		shared FilterBdids		:= ARBaseClean(bdid != 0);
		Shared DedupBdids		:= dedup(sort(distribute(FilterBdids,hash(bdid)),bdid,corp_key,-dt_last_seen,local),bdid,corp_key,local);

		shared corpkeyfields	:= {ARBaseClean.corp_key, ARBaseClean.record_type};
		
		Shared ARBaseClean_Sorted 		:= distribute(ARBaseClean,RANDOM() );																				
																			
		export Bdid		 := tools.macf_FilesIndex('DedupBdids		      ,{bdid}					,{corp_key}			      ',keynames(pversion).AR.Bdid		);
		export Corpkey := tools.macf_FilesIndex('ARBaseClean_Sorted	,corpkeyfields	,{ARBaseClean_Sorted}	',keynames(pversion).AR.CorpKey );
		
	end;

end;