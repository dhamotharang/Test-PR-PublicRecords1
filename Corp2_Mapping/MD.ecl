Import _Control, Corp2, lib_stringlib, Corp2_Raw_MD, Scrubs, Scrubs_Corp2_Mapping_MD_Main, Scrubs_Corp2_Mapping_MD_Event, Tools, UT, VersionControl, std;

export MD := MODULE

	export Update(string filedate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) :=Function

		state_origin	:= 'MD';
		state_fips	 	:= '24';
		state_desc	 	:= 'MARYLAND';
		
		//Per CI :All records with ID_BUS_PREFIX_TYPE = "L" & (cd_address_type) ='L' – do not use ,These are unincorporated accounts & Personal property addresses !"
		AmendHist			:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.AmendOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		ARCAmendHist	:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.ARCAmendOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local) :independent;
		BusAddr				:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.BusAddrOutFile(corp2.t2u(id_bus_prefix)<>'L' and corp2.t2u(cd_address_type) <>'L' ),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		ARCBusAddr		:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.ARCBusAddrOutFile(corp2.t2u(id_bus_prefix)<>'L'and corp2.t2u(cd_address_type) <>'L' ),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		BusNmIndx			:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.BusNmIndxOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		ARCBusNmIndx	:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.ARCBusNmIndxOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		BusEntity			:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.BusEntityOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		ReserveName   := dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.ReserveNameOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local):independent;
		TradeName			:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.TradeNameOutFile(corp2.t2u(id_bus_prefix)<>'L'),hash(id_bus_prefix + id_bus)),record,local),record,local) :independent;	
		BusComment		:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.BusCommentOutFile,hash(id_comments)),record,local),record,local):independent;
		FilmIndx			:= dedup(sort(distribute(Corp2_Raw_MD.Files(filedate,pUseProd).input.FilmIndxOutFile,hash(idFlngNbr)),record,local),record,local):independent;
		EntityStatus	:= dedup(sort(Corp2_Raw_MD.Files(filedate,pUseProd).input.EntityStatusOutFile,record),record);	
		FilingType	 	:= dedup(sort(Corp2_Raw_MD.Files(filedate,pUseProd).input.FilingTypeOutFile,record),record);	
		BusType				:= dedup(sort(Corp2_Raw_MD.Files(filedate,pUseProd).input.BusTypeOutFile,record),record);	
		
		//populating Statusdesc from EntitySatus table to map "corp_status_desc"
		EntityWithStatusdesc  := join(BusEntity, EntityStatus,
																	corp2.t2u(left.cd_status) = corp2.t2u(right.cd_status),
																	Transform(Corp2_Raw_MD.Layouts.Temp_EntityWithLookups,
																						self.Statusdesc := corp2.t2u(right.tx_descript);
																						self:=left;
																						self:=right;
																						self:=[];
																						),
																	left outer, lookup
																 );
																	
		//populating BusTypedesc from BusType table to map "corp_orig_bus_type_desc"												
		EntityWithBusTypedesc	  := join(EntityWithStatusdesc, BusType,
																	  corp2.t2u(left.CD_BUS_TYPE) = corp2.t2u(right.CD_BUS_TYPE),
																	  Transform(Corp2_Raw_MD.Layouts.Temp_EntityWithLookups,
																						  self.BusTypedesc := corp2.t2u(right.tx_descript);
																						  self						 :=left;
																						  self						 :=right;
																							),
																	  left outer,lookup
																		);
					
		join_EntityWithName       := join(EntityWithBusTypedesc,BusNmIndx ,
																			corp2.t2u(left.id_bus_prefix + left.id_bus ) = corp2.t2u(right.id_bus_prefix + right.id_bus ),
																			Transform(Corp2_Raw_MD.Layouts.Temp_EntityWithName,
																								self.nm_ts_end			  :=right.ts_end;
																								self.nm_ts_effective	:=right.ts_effective;
																								self								  :=left;
																								self									:=right;
																								),
																		  left outer,local
																		  ):independent;
																			
    update_EntityName:=distribute(join_EntityWithName(corp2.t2u(fl_archived)='Y'),hash(id_bus_prefix + id_bus));
		EntityName       :=join_EntityWithName(corp2.t2u(fl_archived)<>'Y');
		
		//MD corps has missing information in the update files, according to Re corps CI , populating missing info from Archived files!
		//when update file field values are blank & fl_archived='Y' then populating values from Archived files
		Corp2_Raw_MD.Layouts.Temp_EntityWithName MergeEntityARCName(Corp2_Raw_MD.Layouts.BusNmIndxLayout l,Corp2_Raw_MD.Layouts.Temp_EntityWithName r ) := transform

		  self.id_bus_prefix 					:= if(corp2.t2u(r.id_bus_prefix)=''   ,corp2.t2u(l.id_bus_prefix)		,corp2.t2u(r.id_bus_prefix));
			self.id_bus									:= if(corp2.t2u(r.id_bus)=''   				,corp2.t2u(l.id_bus)					,corp2.t2u(r.id_bus));
			self.cd_name_type						:= if(corp2.t2u(r.cd_name_type)=''    ,corp2.t2u(l.cd_name_type)		,corp2.t2u(r.cd_name_type));	 
			self.nm_ts_effective				:= if(corp2.t2u(r.nm_ts_effective)='' ,corp2.t2u(l.ts_effective)	  ,corp2.t2u(r.nm_ts_effective));
			self.nm_ts_end							:= if(corp2.t2u(r.nm_ts_end)=''   		,corp2.t2u(l.ts_end)		      ,corp2.t2u(r.nm_ts_end));
			self.nm_name								:= if(corp2.t2u(r.nm_name)=''         ,corp2.t2u(l.nm_name)					,corp2.t2u(r.nm_name));
			self.ts_last_updt						:= if(corp2.t2u(r.ts_last_updt)=''    ,corp2.t2u(l.ts_last_updt)		,corp2.t2u(r.ts_last_updt));
			self												:= r;
			
		end; 
		
		joinEntityWithARCName   := join(ARCBusNmIndx,update_EntityName,
																	  corp2.t2u(left.id_bus_prefix + left.id_bus ) = corp2.t2u(right.id_bus_prefix + right.id_bus ),
																	  MergeEntityARCName(left,right),
																	  right outer,local
																	);
																			
																		
		//Combining records --- update records for those fl_archived <>'Y'  and retrieved info from archived files for those update records which have ,fl_archived ='Y' 												
		ds_Temp_EntityWithName_ArcName:=	distribute(EntityName + joinEntityWithARCName,hash(id_bus_prefix + id_bus)):independent;
		
		join_EntityWithName_Trade := join(ds_Temp_EntityWithName_ArcName, TradeName,
																			corp2.t2u(left.id_bus_prefix + left.id_bus ) = corp2.t2u(right.id_bus_prefix + right.id_bus ),
																			Transform(Corp2_Raw_MD.Layouts.Temp_EntityWithName_trade,
																								self:=left;
																								self:=right;
																								),
																			left outer,local
																			):independent;
																		 
		joinEntityWithNameTrade_Addr   := join( join_EntityWithName_Trade, BusAddr ,
																						corp2.t2u(left.id_bus_prefix + left.id_bus ) = corp2.t2u(right.id_bus_prefix + right.id_bus ),
																						Transform(Corp2_Raw_MD.Layouts.Temp_EntityNameTrade_Addr, //joining Entity with corp addresses
																											self.Addr_name			  :=right.nm_name;
																											self.Addr_ts_effective:=right.ts_effective;
																											self.Addr_ts_end      :=right.ts_end;
																											self								  :=left;
																											self								  :=right;
																											),
																						left outer,local
																						):independent;		
																						
	  joinEntityWithNameTrade_AddrReserve := join(joinEntityWithNameTrade_Addr, ReserveName,
																								corp2.t2u(left.id_bus_prefix + left.id_bus ) = corp2.t2u(right.id_bus_prefix + right.id_bus ),
																								Transform(Corp2_Raw_MD.Layouts.Temp_EntityNameTrade_AddrReserve,
																													self:=left;
																													self:=right;
																													),
																								left outer,local
																								):independent;
																								
		Update_Entity_Addr :=distribute(joinEntityWithNameTrade_AddrReserve(corp2.t2u(fl_archived)='Y'),hash(id_bus_prefix + id_bus));
		Entity_Addr        :=joinEntityWithNameTrade_AddrReserve(corp2.t2u(fl_archived)<>'Y');
		
		//MD corps has missing information in the update files, according to Re corps CI , populating missing info from Archived files!
		//when update file field values are blank & fl_archived='Y' then populating values from Archived files
		Corp2_Raw_MD.Layouts.Temp_EntityNameTrade_AddrReserve  MergeEntityARCAddr(Corp2_Raw_MD.Layouts.BusAddrLayout l,Corp2_Raw_MD.Layouts.Temp_EntityNameTrade_AddrReserve r) := transform
			
			self.cd_address_type				:= if(corp2.t2u(r.cd_address_type)='',  corp2.t2u(l.cd_address_type),   corp2.t2u(r.cd_address_type));
			self.Addr_ts_effective			:= if(corp2.t2u(r.Addr_ts_effective)='',corp2.t2u(l.ts_effective),      corp2.t2u(r.Addr_ts_effective));
			self.Addr_ts_end						:= if(corp2.t2u(r.Addr_ts_end)='',      corp2.t2u(l.ts_end),            corp2.t2u(r.Addr_ts_end));
			self.Addr_name							:= if(corp2.t2u(r.Addr_name)='',				corp2.t2u(l.nm_name),					  corp2.t2u(r.Addr_name));
			self.ad_line1								:= if(corp2.t2u(r.ad_line1)='',					corp2.t2u(l.ad_line1),				  corp2.t2u(r.ad_line1));
			self.ad_line2								:= if(corp2.t2u(r.ad_line2)='',					corp2.t2u(l.ad_line2),				  corp2.t2u(r.ad_line2));
			self.ad_line3								:= if(corp2.t2u(r.ad_line3)='',					corp2.t2u(l.ad_line3),				  corp2.t2u(r.ad_line3));
			self.ad_line4								:= if(corp2.t2u(r.ad_line4)='',					corp2.t2u(l.ad_line4),				  corp2.t2u(r.ad_line4));
			self.ad_city								:= if(corp2.t2u(r.ad_city)='',					corp2.t2u(l.ad_city),					  corp2.t2u(r.ad_city));
			self.ad_state								:= if(corp2.t2u(r.ad_state)='',					corp2.t2u(l.ad_state),				  corp2.t2u(r.ad_state));	
			self.ad_zip									:= if(corp2.t2u(r.ad_zip)='',						corp2.t2u(l.ad_zip),					  corp2.t2u(r.ad_zip));	
			self.ts_last_updt						:= if(corp2.t2u(r.ts_last_updt)='',			corp2.t2u(l.ts_last_updt),		  corp2.t2u(r.ts_last_updt));	
			self						  					:= r;
		end; 

    joinEntityARCNameAddr  := join(ARCBusAddr,Update_Entity_Addr,
																	 corp2.t2u(left.id_bus_prefix + left.id_bus) = corp2.t2u(right.id_bus_prefix + right.id_bus),
																	 MergeEntityARCAddr(left,right),
																	 right outer,local
																	);
																			
		//Combining records --- update records for those fl_archived <>'Y'  and retrieved info from archived files for those update records which have ,fl_archived ='Y' 												
		ds_Temp_EntityNameAddr := Entity_Addr + joinEntityARCNameAddr:independent;
	
	/* Per CI :'OT','OX' are Contacts only & do not use name types (OU, TA)" 
		 'TA'– do not pick up for tradename – unincorporated accounts 
		 'OU'- do not pick up for contacts - unincorporated account owners  */
		Corp2_Mapping.LayoutsCommon.Main MD_corpTrans(Corp2_Raw_MD.Layouts.Temp_EntityNameTrade_AddrReserve input):=transform,
		skip (corp2.t2u(input.cd_name_type)in ['OT','OU','OX','TA']	)   

			self.dt_vendor_first_reported								:=(integer)fileDate;
			self.dt_vendor_last_reported								:=(integer)fileDate;
			self.dt_first_seen													:=(integer)fileDate;
			self.dt_last_seen														:=(integer)fileDate;
			self.corp_ra_dt_first_seen									:=(integer)fileDate;
			self.corp_ra_dt_last_seen										:=(integer)fileDate;
			self.corp_process_date											:= fileDate;    	
			self.corp_key					    		  						:= state_fips+'-'+corp2.t2u(input.id_bus_prefix + input.id_bus);
			self.corp_orig_sos_charter_nbr  						:= corp2.t2u(input.id_bus_prefix + input.id_bus);
			self.corp_vendor														:= state_fips;
			self.corp_state_origin				  						:= state_origin;
			self.corp_inc_state													:= state_origin;
			self.corp_legal_name												:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.nm_Name).BusinessName; 
			cleanNameType																:= corp2.t2u(input.cd_name_type);
			self.corp_ln_name_type_cd										:= map(cleanNameType in ['CR','GP','LC','LL','LP','UN'] => '01',		
																												 cleanNameType in ['TR','TX'] 										=> '04',
																												 cleanNameType  = 'RG' 														=> '09',
																												 cleanNameType  = 'RV' 														=> '07',
																												 cleanNameType
																												);																							 
			self.corp_ln_name_type_desc									:= map(self.corp_ln_name_type_cd ='01' => 'LEGAL',		
																												 self.corp_ln_name_type_cd ='P'  => 'PRIOR',	
																												 self.corp_ln_name_type_cd ='04' => 'TRADENAME',
																												 self.corp_ln_name_type_cd ='09' => 'REGISTRATION',
																												 self.corp_ln_name_type_cd ='07' => 'RESERVED',
																												 '');    //CI-Codes Tab has full descriptions
			domestic_type                               :=['A', 'B', 'C', 'D', 'L', 'M', 'R', 'S', 'T', 'U', 'V', 'W'];
			foreign_type                                :=['E','F','P','Z'];	
			valid_Date                          				:= Corp2_Mapping.fValidateDate(input.TS_FORMATION[1..10],'CCYY-MM-DD').PastDate ;						
			self.corp_foreign_domestic_ind							:= map(corp2.t2u(input.cd_st_of_formation)in[ state_origin,''] and corp2.t2u(input.id_bus_prefix)  in domestic_type   	 =>'D',
																												 corp2.t2u(input.cd_st_of_formation)not in[ state_origin,''] and corp2.t2u(input.id_bus_prefix) in foreign_type	 	 =>'F',
																												 corp2.t2u(input.cd_st_of_formation)='' and corp2.t2u(input.id_bus_prefix) in foreign_type										 		 =>'F',
																												 corp2.t2u(input.id_bus_prefix) in foreign_type																																		 =>'F', //noticed in the data, states which are MD and have forein type									 		 																				 =>'F',
																												 corp2.t2u(input.id_bus_prefix) in domestic_type  																																 =>'D', //noticed in the data which  are other than MD and have domestic type  																												   =>'D',
																												 '');
			self.corp_inc_date													:= map(corp2.t2u(input.cd_st_of_formation)in[ state_origin,''] and corp2.t2u(input.id_bus_prefix)  in domestic_type  =>valid_Date,
																												 corp2.t2u(input.cd_st_of_formation)='' and corp2.t2u(input.id_bus_prefix) not in foreign_type								 =>valid_Date,
																												 corp2.t2u(input.id_bus_prefix) not in foreign_type										 																		     =>valid_Date,
																												 '');  
			self.corp_forgn_date												:= map(corp2.t2u(input.cd_st_of_formation)not in[ state_origin,''] and corp2.t2u(input.id_bus_prefix) in foreign_type =>valid_Date,
																												 corp2.t2u(input.cd_st_of_formation)='' and corp2.t2u(input.id_bus_prefix) in foreign_type										  =>valid_Date,
																												 corp2.t2u(input.id_bus_prefix) in foreign_type										 																					    =>valid_Date,
																												'');
			self.corp_orig_bus_type_cd									:= corp2.t2u(input.cd_bus_type);
			self.corp_orig_bus_type_desc								:= map(corp2.t2u(input.BusTypedesc)<>''		=>corp2.t2u(input.BusTypedesc),//from table
																												 corp2.t2u(input.cd_bus_type)='3'		=>'ORDINARY BUSINESS – STOCK', //per CI
																												 corp2.t2u(input.cd_bus_type)='20'	=>'OTHER', //  not in table  ,per CI 
																												 corp2.t2u(input.cd_bus_type)='TR'	=>'TRADENAME', //  not in table  ,per CI 
																												 corp2.t2u(input.cd_bus_type)=''		=>'',
																												 '**|'+ corp2.t2u(input.cd_bus_type)//scrubs will catch codes those not have descriptions ;
																												 );
			self.corp_orig_org_structure_cd							:= if(corp2.t2u(input.id_bus_prefix) not in['R', 'T', 'V'],corp2.t2u(input.id_bus_prefix),'');
			self.corp_orig_org_structure_desc						:= corp2_Raw_MD.Functions.OrgStrucdesc(input.id_bus_prefix);
			self.corp_status_cd													:= corp2.t2u(input.cd_Status);			
			self.corp_status_desc												:= map(corp2.t2u(input.Statusdesc)<>''	=>corp2.t2u(input.Statusdesc),//from table
																												 corp2.t2u(input.cd_Status)=''		=>'',
																												 '**|'+ corp2.t2u(input.cd_Status)//scrubs will catch codes those not have descriptions ;
																												 );
			self.corp_status_date												:= corp2_Mapping.fValidateDate(input.dt_stat_effective[1..10],'CCYY-MM-DD').PastDate;
			self.Corp_name_effective_Date   						:= Corp2_Mapping.fValidateDate(input.nm_ts_effective[1..10],'CCYY-MM-DD').GeneralDate;	
			self.corp_forgn_state_cd										:= map(corp2.t2u(input.cd_st_of_formation) not in [state_origin,'']=>Corp2_Raw_MD.Functions.fGetStateCode(input.cd_st_of_formation),
																										     corp2.t2u(input.cd_st_of_formation)='' and corp2.t2u(input.id_bus_prefix)  in foreign_type =>Corp2_Raw_MD.Functions.fGetStateCode(input.cd_st_of_formation),
																												 '' );	
			self.corp_forgn_state_desc									:= map(corp2.t2u(input.cd_st_of_formation) not in [state_origin,'']=>Corp2_Raw_MD.Functions.fGetStatedesc(input.cd_st_of_formation),
																										     corp2.t2u(input.cd_st_of_formation)='' and corp2.t2u(input.id_bus_prefix)  in foreign_type =>Corp2_Raw_MD.Functions.fGetStatedesc(input.cd_st_of_formation),
																												 '' );
			cleanExpireDate															:= corp2_Mapping.fValidateDate(input.dt_expiration[1..10],'CCYY-MM-DD').GeneralDate;   
			self.corp_term_exist_cd											:= if(cleanExpireDate<>'','D','');	
			self.corp_term_exist_desc										:= if(cleanExpireDate<>'','EXPIRATION','');
			self.corp_term_exist_exp										:= cleanExpireDate;
			self.corp_filing_date												:= corp2_Mapping.fValidateDate(input.dt_registration[1..10],'CCYY-MM-DD').PastDate;
			cleanCancelledDate													:= corp2_Mapping.fValidateDate(input.dt_cancelled[1..10],'CCYY-MM-DD').PastDate;
			self.corp_addl_info													:= map(cleanCancelledDate<>'' and corp2.t2u(input.fl_archived)='Y' =>'CANCELLED DATE: ' + cleanCancelledDate+' ;'+'CORPORATION DATA IS ARCHIVED BY SOS MD',
																											   cleanCancelledDate<>''=>'CANCELLED DATE: ' + cleanCancelledDate,
																												 corp2.t2u(input.fl_archived)='Y'=>'CORPORATION DATA IS ARCHIVED BY SOS MD',
																												 '');																			 
			self.Corp_name_reservation_expiration_date 	:= cleanExpireDate;
			self.Corp_name_reservation_date						 	:= corp2_Mapping.fValidateDate(input.nm_ts_effective[1..10],'CCYY-MM-DD').GeneralDate; 
			temp_addr1																	:= map(lib_stringlib.StringLib.StringFind(corp2.t2u(input.nm_Name),corp2.t2u(input.ad_line1),1)<>0 =>'',
																												 lib_stringlib.StringLib.StringFind(corp2.t2u(input.addr_Name),corp2.t2u(input.ad_line1),1)<>0 =>'',
																												 corp2.t2u(input.ad_line1)
   																											);//According to Salt report, Names are found in address field 																									 
			addr1																				:= corp2.t2u(temp_addr1 +' '+ input.ad_line2);
			addr2	 																		  := corp2.t2u(input.ad_line3 +' '+ input.ad_line4); //PER CI:cd_address_type='A' are contacts , 'R' belong to RA agent addrs !! and 'F','M' belong to Mailing addresses!
			self.corp_address1_line1										:= if(corp2.t2u(input.cd_address_type)in ['P','T'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).AddressLine1,'');
			self.corp_address1_line2				 						:= if(corp2.t2u(input.cd_address_type)in ['P','T'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).AddressLine2,'');
			self.corp_address1_line3				 						:= if(corp2.t2u(input.cd_address_type)in ['P','T'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).AddressLine3,'');
			self.corp_prep_addr1_line1									:= if(corp2.t2u(input.cd_address_type)in ['P','T'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).PrepAddrLine1,'');
			self.corp_prep_addr1_last_line							:= if(corp2.t2u(input.cd_address_type)in ['P','T'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).PrepAddrLastLine,'');
			self.corp_address1_type_cd									:= if(corp2.t2u(input.cd_address_type)in ['P','T'] and Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).ifAddressExists,
																												'B','');
			self.corp_address1_type_desc								:= if(corp2.t2u(input.cd_address_type)in ['P','T']and Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).ifAddressExists,
																												'BUSINESS','');  //CI-Codes Tab has full descriptions
			self.corp_address1_effective_date           := if(corp2.t2u(input.cd_address_type)in ['P','T'],corp2_Mapping.fValidateDate(input.addr_ts_effective[1..10],'CCYY-MM-DD').GeneralDate,''); 
			self.corp_address2_line1										:= if(corp2.t2u(input.cd_address_type)in ['F','M'] ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).AddressLine1,'');
			self.corp_address2_line2				 						:= if(corp2.t2u(input.cd_address_type)in ['F','M'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).AddressLine2,'');
			self.corp_address2_line3				 						:= if(corp2.t2u(input.cd_address_type)in ['F','M'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).AddressLine3,'');
			self.corp_prep_addr2_line1									:= if(corp2.t2u(input.cd_address_type)in ['F','M'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).PrepAddrLine1,'');
			self.corp_prep_addr2_last_line							:= if(corp2.t2u(input.cd_address_type)in ['F','M'],Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).PrepAddrLastLine,'');
			self.corp_address2_type_cd									:= if(corp2.t2u(input.cd_address_type)in ['F','M'] and Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).ifAddressExists,
																												'M','');
			self.corp_address2_type_desc								:= if(corp2.t2u(input.cd_address_type)in ['F','M'] and Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,input.AD_City,input.AD_State,input.AD_Zip).ifAddressExists,
																												'MAILING',''); 
			self.corp_address2_effective_date           :=if(corp2.t2u(input.cd_address_type)in ['F','M'],corp2_Mapping.fValidateDate(input.addr_ts_effective[1..10],'CCYY-MM-DD').GeneralDate,''); 
			self.Corp_ra_full_name											:= if(corp2.t2u(input.cd_address_type) = 'R' and  corp2.t2u(input.addr_Name) not in ['NA','N/A'],Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.addr_Name).BusinessName,'');
			self.corp_ra_address_type_cd		  					:= if(corp2.t2u(input.cd_address_type) = 'R' and Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).ifAddressExists,'R','');
			self.corp_ra_address_type_desc		  				:= if(corp2.t2u(input.cd_address_type) = 'R' and Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1			 	  				:= if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).AddressLine1,'');
			self.corp_ra_address_line2			 	  				:= if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).AddressLine2,'');
			self.corp_ra_address_line3				  				:= if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).AddressLine3,'');
			self.ra_prep_addr_line1						  				:= if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).PrepAddrLine1,'');
			self.ra_prep_addr_last_line				  				:= if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,input.AD_CITY,input.AD_STATE,input.AD_zip).PrepAddrLastLine,'');
			self.corp_ra_effective_date                 := if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fValidateDate(input.addr_ts_effective[1..10],'CCYY-MM-DD').GeneralDate,'');
			self.corp_ra_resign_date                    := if(corp2.t2u(input.cd_address_type) = 'R' ,Corp2_Mapping.fValidateDate(input.addr_ts_end[1..10],'CCYY-MM-DD').GeneralDate,'');
			//Added for scrub purposes; new vendor 'id_bus_prefix' values will be captured!,id_bus_prefix values are crucial for dates & indicator fields!
			self.internalfield1													:= if(corp2.t2u(input.id_bus_prefix)not in[domestic_type, foreign_type,''],'**'+ corp2.t2u(input.id_bus_prefix),'');
			self.recordorigin														:= 'C';
			self 																				:= [];
			
		end;

		MapEntity						:= project(ds_Temp_EntityNameAddr,MD_corpTrans(left)):independent;		
		// Eliminating duplicates	
		Corp2_Mapping.LayoutsCommon.main tGetCorpStandardized(Corp2_Mapping.LayoutsCommon.main  l	,Corp2_Mapping.LayoutsCommon.main  r) :=transform
			
			self.corp_ra_address_line1								 := if(r.corp_ra_address_line1 <>''				,r.corp_ra_address_line1	  ,l.corp_ra_address_line1);
			self.corp_ra_address_line2								 := if(r.corp_ra_address_line2<>''				,r.corp_ra_address_line2	  ,l.corp_ra_address_line2);
			self.corp_ra_address_line3								 := if(r.corp_ra_address_line3 <>''				,r.corp_ra_address_line3	  ,l.corp_ra_address_line3);
			self.ra_prep_addr_line1										 := if(r.ra_prep_addr_line1 <>''					,r.ra_prep_addr_line1			  ,l.ra_prep_addr_line1);
			self.ra_prep_addr_last_line								 := if(r.ra_prep_addr_last_line <>''			,r.ra_prep_addr_last_line	  ,l.ra_prep_addr_last_line);	
			self.corp_ra_address_type_cd		    			 := if(r.corp_ra_address_type_cd <>''			,r.corp_ra_address_type_cd	,l.corp_ra_address_type_cd);
			self.corp_ra_address_type_desc	    			 := if(r.corp_ra_address_type_desc<>''		,r.corp_ra_address_type_desc,l.corp_ra_address_type_desc);
			self.corp_ra_resign_date									 := if(r.corp_ra_resign_date <>''		  		,r.corp_ra_resign_date			,l.corp_ra_resign_date);
			self.corp_ra_effective_date								 := if(r.corp_ra_effective_date <>''			,r.corp_ra_effective_date		,l.corp_ra_effective_date);
			self.Corp_ra_full_name   									 := if(r.Corp_ra_full_name <>''				  	,r.Corp_ra_full_name			  ,l.Corp_ra_full_name);
			self.corp_address1_line1									 := if(r.corp_address1_line1 <>''			  	,r.corp_address1_line1			,l.corp_address1_line1);
			self.corp_address1_line2									 := if(r.corp_address1_line2<>''					,r.corp_address1_line2			,l.corp_address1_line2);
			self.corp_address1_line3									 := if(r.corp_address1_line3 <>''					,r.corp_address1_line3			,l.corp_address1_line3);
			self.corp_prep_addr1_line1								 := if(r.corp_prep_addr1_line1 <>''				,r.corp_prep_addr1_line1		,l.corp_prep_addr1_line1);
			self.corp_prep_addr1_last_line						 := if(r.corp_prep_addr1_last_line <>''		,r.corp_prep_addr1_last_line,l.corp_prep_addr1_last_line);	
			self.corp_address1_type_cd		    				 := if(r.corp_address1_type_cd <>''				,r.corp_address1_type_cd		,l.corp_address1_type_cd);
			self.corp_address1_type_desc	    				 := if(r.corp_address1_type_desc<>''			,r.corp_address1_type_desc	,l.corp_address1_type_desc);
			self.corp_address2_line1									 := if(r.corp_address2_line1 <>''			  	,r.corp_address2_line1			,l.corp_address2_line1);
			self.corp_address2_line2									 := if(r.corp_address2_line2<>''					,r.corp_address2_line2			,l.corp_address2_line2);
			self.corp_address2_line3									 := if(r.corp_address2_line3 <>''					,r.corp_address2_line3			,l.corp_address2_line3);
			self.corp_prep_addr2_line1								 := if(r.corp_prep_addr2_line1 <>''				,r.corp_prep_addr2_line1		,l.corp_prep_addr2_line1);
			self.corp_prep_addr2_last_line						 := if(r.corp_prep_addr2_last_line <>''		,r.corp_prep_addr2_last_line,l.corp_prep_addr2_last_line);	
			self.corp_address2_type_cd		    				 := if(r.corp_address2_type_cd <>''				,r.corp_address2_type_cd		,l.corp_address2_type_cd);
			self.corp_address2_type_desc	    				 := if(r.corp_address2_type_desc<>''			,r.corp_address2_type_desc	,l.corp_address2_type_desc);
			self.corp_address1_effective_date					 := if(r.corp_address1_effective_date<>''	,r.corp_address1_effective_date	,l.corp_address1_effective_date);
			self.corp_address2_effective_date					 := if(r.corp_address2_effective_date<>''	,r.corp_address2_effective_date	,l.corp_address2_effective_date);
		  self.corp_name_effective_Date 						 := if(r.corp_name_effective_Date <>''		,r.corp_name_effective_Date			,l.corp_name_effective_Date);
			self.corp_name_reservation_expiration_date := if(r.corp_name_reservation_expiration_date <>''	,r.corp_name_reservation_expiration_date,l.corp_name_reservation_expiration_date);
			self.corp_name_reservation_date						 := if(r.corp_name_reservation_date <>''					 ,r.corp_name_reservation_date,l.corp_name_reservation_date);			
			self 																			 := l;
			
		end;
		
    ds_MapCorp     := distribute(MapEntity,hash(corp_key,corp_legal_name)) ;
		denorm_MapCorp := denormalize( ds_MapCorp
																	,ds_MapCorp
																	,left.corp_key        				 = right.corp_key and
																	 left.corp_legal_name 				 = right.corp_legal_name 
																	,tGetCorpStandardized(left,right)
																	,local
																);
		
		sortDedup_MapCorp	:= dedup(sort(distribute(denorm_MapCorp,hash(corp_key,corp_legal_name)),record,local),record,local):independent;		
		Md_addr1_blank 		:= sortDedup_MapCorp(corp2.t2u(corp_address2_line1 + corp_address2_line2 + corp_address2_line3 ) <>'' and corp2.t2u(corp_address1_line1 + corp_address1_line2 + corp_address1_line3 ) ='');
	
	//Per CI: Maping business addresses from Mailing addresses & blanking mailing addresses ,if there are only mailing addresses;
		Corp2_Mapping.LayoutsCommon.Main AddressTransform(Corp2_Mapping.LayoutsCommon.Main l ,Corp2_Mapping.LayoutsCommon.Main r):=transform
		
			self.corp_address1_line1									 := if(l.corp_address1_line1 ='',r.corp_address2_line1,l.corp_address1_line1);
			self.corp_address1_line2									 := if(l.corp_address1_line2 ='',r.corp_address2_line2,l.corp_address1_line2);
			self.corp_address1_line3									 := if(l.corp_address1_line3 ='',r.corp_address2_line3,l.corp_address1_line3);
			self.corp_prep_addr1_line1								 := if(l.corp_prep_addr1_line1 ='',r.corp_prep_addr2_line1,l.corp_prep_addr1_line1);
			self.corp_prep_addr1_last_line						 := if(l.corp_prep_addr1_last_line ='',r.corp_prep_addr2_last_line,l.corp_prep_addr1_last_line);	
			self.corp_address1_type_cd		    				 := if(l.corp_address1_type_cd ='','B',l.corp_address1_type_cd);
			self.corp_address1_type_desc	    				 := if(l.corp_address1_type_desc ='','BUSINESS',l.corp_address1_type_desc);
			self.corp_address1_effective_date          := if(l.corp_address1_effective_date ='',r.corp_address2_effective_date,l.corp_address1_effective_date);
			self.corp_address2_line1									 := if(l.corp_address1_line1 ='','',l.corp_address2_line1);
			self.corp_address2_line2									 := if(l.corp_address1_line2 ='','',l.corp_address2_line2);
			self.corp_address2_line3									 := if(l.corp_address1_line3 ='','',l.corp_address2_line3);
			self.corp_prep_addr2_line1								 := if(l.corp_prep_addr1_line1 ='','',l.corp_prep_addr2_line1);
			self.corp_prep_addr2_last_line						 := if(l.corp_prep_addr1_last_line='','',l.corp_prep_addr2_last_line);
			self.corp_address2_type_cd		    				 := if(l.corp_address1_type_cd='','',l.corp_address2_type_cd);
			self.corp_address2_type_desc	    				 := if(l.corp_address1_type_desc='','',l.corp_address2_type_desc);
			self.corp_address2_effective_date          := if(l.corp_address1_effective_date='','',l.corp_address2_effective_date);
			self                                       := l;
		
		End;
   	dist_addr1_blank	:= distribute(Md_addr1_blank,hash(corp_key,corp_legal_name)) ;
		ds_MD_corps 			:= join(sortDedup_MapCorp,dist_addr1_blank,
															left.corp_key  = right.corp_key and
															left.corp_legal_name  = right.corp_legal_name, 
															AddressTransform(left,right),
															left outer,
															local);	
												
		sd_MapCorp			:=distribute(ds_MD_corps ,hash(corp_key)); 
		
   	//Per CI: Marking businesses name types as legal & prior depending on their effective date;
		SortEntiy_legal := group(sort(sd_MapCorp(corp_ln_name_type_cd='01'),corp_key,-corp_name_effective_Date),corp_key);
		SortEntiy_Other := sd_MapCorp(corp_ln_name_type_cd<>'01');
		
		Corp2_Mapping.LayoutsCommon.main  Trans_SetNameType(Corp2_Mapping.LayoutsCommon.main l ,	Corp2_Mapping.LayoutsCommon.main r, c)	:=	transform
   				
			LeffectiveDate						  := if(c = 1,r.corp_name_effective_Date,'');
			self.corp_ln_name_type_cd		:= if(c = 1 ,'01', if(l.corp_name_effective_Date= LeffectiveDate  or r.corp_name_effective_Date= LeffectiveDate,'01' ,'P')
																				);	
			self.corp_ln_name_type_desc	:= if(c = 1 ,'LEGAL',if(l.corp_name_effective_Date= LeffectiveDate  or r.corp_name_effective_Date= LeffectiveDate,'LEGAL','PRIOR')
																			 );	
			self         							  := r;
   										
    end;
   
		ds_All_NameTypes := distribute(iterate(SortEntiy_legal,Trans_SetNameType(left,right,counter)) + SortEntiy_Other,hash(corp_key)):independent;
		
		//Contact file Mappings 
		ds_ContNameAddr	 := project(ds_Temp_EntityNameAddr(corp2.t2u(cd_name_type) in ['OT','OX'] and corp2.t2u(cd_address_type) = 'A'),transform(Corp2_Raw_MD.Layouts.Temp_ContNameAddr,self:=left;));		
		
		Corp2_Mapping.LayoutsCommon.main MD_contactTransform(Corp2_Raw_MD.Layouts.Temp_ContNameAddr l):=transform,
		skip( trim(l.nm_Name)='' )
				
			self.dt_vendor_first_reported			:=(integer)fileDate;
			self.dt_vendor_last_reported			:=(integer)fileDate;
			self.dt_first_seen								:=(integer)fileDate;
			self.dt_last_seen									:=(integer)fileDate;
			self.corp_ra_dt_last_seen					:=(integer)fileDate;
			self.corp_ra_dt_first_seen				:=(integer)fileDate;
			self.corp_process_date						:= fileDate;    	
			self.corp_key					    		  	:= state_fips+'-'+corp2.t2u(l.id_bus_prefix + l.id_bus);
			self.corp_orig_sos_charter_nbr  	:= corp2.t2u(l.id_bus_prefix + l.id_bus);
			self.corp_vendor									:= state_fips;
			self.corp_state_origin				  	:= state_origin;
			self.corp_inc_state								:= state_origin;
			self.cont_full_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.nm_Name).BusinessName;
			temp_addr1												:= map(lib_stringlib.StringLib.StringFind(corp2.t2u(l.nm_Name),corp2.t2u(l.ad_line1),1)<>0 =>'',
																							 lib_stringlib.StringLib.StringFind(corp2.t2u(l.addr_Name),corp2.t2u(l.ad_line1),1)<>0 =>'',
																							 corp2.t2u(l.ad_line1)
   																						 );//According to Salt report, Names are found in address fiel																				
			addr1															:= corp2.t2u(temp_addr1 +' '+ l.ad_line2);
			addr2	 														:= corp2.t2u(l.ad_line3 +' '+ l.ad_line4);
			self.cont_address_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).AddressLine1;
			self.cont_address_line2				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).AddressLine2;
			self.cont_address_line3				 		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).AddressLine3;
			self.cont_prep_addr_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).PrepAddrLine1;
			self.cont_prep_addr_last_line			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).PrepAddrLastLine;
			self.cont_address_type_cd					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).ifAddressExists,
																							'O','');
			self.cont_address_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,addr1,addr2,l.AD_City,l.AD_State,l.AD_Zip).ifAddressExists,
																							'OWNER','');
			self.cont_type_cd									:= if(corp2.t2u(l.cd_name_type) in ['OT','OX'],'O','');
			self.cont_type_desc								:= if(corp2.t2u(l.cd_name_type) in ['OT','OX'],'OWNER','');																						
			self.cont_address_effective_date  := Corp2_Mapping.fValidateDate(l.ts_effective[1..10],'CCYY-MM-DD').GeneralDate;																				
			self.recordorigin									:= 'T';	
			self                           		:= [];
						
	  end;
	 
		MapCont  	:= project(ds_ContNameAddr,md_contactTransform(left));			
		d_MapCont := distribute(MapCont	,hash(corp_key,cont_full_name)); 
		
		// Eliminating duplicate contact owners	
		Corp2_Mapping.LayoutsCommon.main tGetContStandardized(Corp2_Mapping.LayoutsCommon.main  l	,Corp2_Mapping.LayoutsCommon.main  r) :=transform
			
			self.cont_address_line1					:= if(r.cont_address_line1 <>''						,r.cont_address_line1							,l.cont_address_line1);
			self.cont_address_line2					:= if(r.cont_address_line2<>''						,r.cont_address_line2							,l.cont_address_line2);
			self.cont_address_line3					:= if(r.cont_address_line3 <>''						,r.cont_address_line3							,l.cont_address_line3);
			self.cont_prep_addr_line1				:= if(r.cont_prep_addr_line1 <>''					,r.cont_prep_addr_line1						,l.cont_prep_addr_line1);
			self.cont_prep_addr_last_line		:= if(r.cont_prep_addr_last_line <>''			,r.cont_prep_addr_last_line				,l.cont_prep_addr_last_line);	
			self.cont_address_type_cd		    := if(r.cont_address_type_cd <>''					,r.cont_address_type_cd						,l.cont_address_type_cd);
			self.cont_address_type_desc	    := if(r.cont_address_type_desc<>''				,r.cont_address_type_desc					,l.cont_address_type_desc);
			self.cont_address_effective_date:= if(r.cont_address_effective_date <>''	,r.cont_address_effective_date		,l.cont_address_effective_date);
			self 														:= l;
			
		end;

		denom_MapCont	:= denormalize(  d_MapCont
																	,d_MapCont
																	,left.corp_key = right.corp_key and
																	 left.cont_full_name = right.cont_full_name
																	,tGetContStandardized(left,right)
																	,local
																);	
																
		sd_MapCont	 				:= dedup(sort(distribute(denom_MapCont ,hash(corp_key)),record,local),record,local):independent; 		
		MapContWithLegalNm	:= join(ds_All_NameTypes,sd_MapCont,
																corp2.t2u(left.corp_key) = corp2.t2u(right.corp_key),
																transform(Corp2_Mapping.LayoutsCommon.main,
																					self.corp_legal_name :=left.corp_legal_name,
																					self:=right;
																					),
																inner,local);
																			 
    AllCorp   := dedup(sort(distribute(ds_All_NameTypes +
																			 MapContWithLegalNm ,hash(corp_key)),
														record, -corp_name_effective_Date,local), //Per CI: legal & prior should be sorted according to their effective date
											 record,local):independent;
		
		//**********Event file Mppings
		//Only Entity Matched Amendments for event file 
		join_EntityWithAmend := join(BusEntity,AmendHist,
																 corp2.t2u(left.id_bus_prefix + left.id_bus ) = corp2.t2u(right.id_bus_prefix + right.id_bus ),
																 Transform(Corp2_Raw_MD.Layouts.Temp_EntityWithAmend,
																				  self:=left;
																				  self:=right;
																					),
																 left outer,local):independent;
		
		update_Amend :=distribute(join_EntityWithAmend(corp2.t2u(fl_archived)='Y'),hash(id_bus_prefix + id_bus));
		EntityAmend  :=join_EntityWithAmend(corp2.t2u(fl_archived)<>'Y');
		
		//MD corps has missing information issue before, according to Re corps CI , populating missing info from Archived files!
		//when update file field values are blank and fl_archived='Y' - Populating Amendment info from Archived file!														
		Corp2_Raw_MD.Layouts.Temp_EntityWithAmend MergeEntity2_ARCAmend(Corp2_Raw_MD.Layouts.AmendHistLayout l, Corp2_Raw_MD.Layouts.Temp_EntityWithAmend r ) := transform
      
			self.cdFilingType					  := if(corp2.t2u(r.cdFilingType)=''      ,corp2.t2u(l.cdFilingType)			, corp2.t2u(r.cdFilingType));
			self.tsBusEffective				  := if(corp2.t2u(r.tsBusEffective)=''    ,corp2.t2u(l.tsBusEffective)		, corp2.t2u(r.tsBusEffective));
			self.flStock								:= if(corp2.t2u(r.flStock)=''           ,corp2.t2u(l.flStock)					  , corp2.t2u(r.flStock));
			self.flClose								:= if(corp2.t2u(r.flClose)=''           ,corp2.t2u(l.flClose)						, corp2.t2u(r.flClose));
			self.idComments						  := if(corp2.t2u(r.idComments)=''			  ,corp2.t2u(l.idComments)				, corp2.t2u(r.idComments));
			self.tsLastUpdt						  := if(corp2.t2u(r.tsLastUpdt)=''				,corp2.t2u(l.tsLastUpdt)				, corp2.t2u(r.tsLastUpdt));
			self.tsEffective						:= if(corp2.t2u(r.tsEffective)=''				,corp2.t2u(l.tsEffective)				, corp2.t2u(r.tsEffective));
			self.idFlngNbr							:= if(corp2.t2u(r.idFlngNbr)=''					,corp2.t2u(l.idFlngNbr)					, corp2.t2u(r.idFlngNbr));
			self.cdStatus							  := if(corp2.t2u(r.cdStatus)=''					,corp2.t2u(l.cdStatus)					, corp2.t2u(r.cdStatus));
			self.cdBusType							:= if(corp2.t2u(r.cdBusType)=''					,corp2.t2u(l.cdBusType)					, corp2.t2u(r.cdBusType));
			self.cdFormationType				:= if(corp2.t2u(r.cdFormationType)=''		,corp2.t2u(l.cdFormationType)		, corp2.t2u(r.cdFormationType));
			self.FlChgRA								:= if(corp2.t2u(r.FlChgRA)=''						,corp2.t2u(l.FlChgRA)						, corp2.t2u(r.FlChgRA));
			self.FlChgRAAddr						:= if(corp2.t2u(r.FlChgRAAddr)=''				,corp2.t2u(l.FlChgRAAddr)				, corp2.t2u(r.FlChgRAAddr));
			self.FlChgPO								:= if(corp2.t2u(r.FlChgPO)=''						,corp2.t2u(l.FlChgPO)						, corp2.t2u(r.FlChgPO));
			self.dtStatEffective				:= if(corp2.t2u(r.dtStatEffective)=''		,corp2.t2u(l.dtStatEffective)		, corp2.t2u(r.dtStatEffective));
			self.fl_archived						:= r.fl_archived;		//Entity file has fl_archived flag, idicates where to use archive files
			self                        := r;
			self                        := l;
			
		end; 
		
    joinEntityWith_ARCAmend  := join(ARCAmendHist ,update_Amend ,
																		 corp2.t2u(left.id_bus_prefix + left.id_bus) = corp2.t2u(right.id_bus_prefix + right.id_bus),
																		 MergeEntity2_ARCAmend(left,right),
																		 right outer,local):independent;		
																		 
		//Combining records & distributing --- update records ( fl_archived <>'Y') + retrieved info from archived AmendHist file for those updates fl_archived ='Y' & projecting into AmendHistLayout																											
		ds_join_EntityWithAmend  := dedup(sort(distribute(EntityAmend + joinEntityWith_ARCAmend,hash(corp2.t2u(id_bus_prefix +id_bus))),record,local),record,local) :independent;
		AmendWithFilingdesc 		 := join(ds_join_EntityWithAmend , FilingType,
																		 corp2.t2u(left.cdFilingType) = corp2.t2u(right.cd_filing_type),
																		 Transform(Corp2_Raw_MD.Layouts.Temp_AmendHistWithFilingDesc ,
																							 self.Filingdesc := corp2.t2u(right.tx_filing_type);
																							 self:=left;
																							 self:=right;
																							 ),
																		 left outer,lookup
																		 );
		
   join_AmendWithComment     := join(AmendWithFilingdesc, BusComment,
																	   corp2.t2u(left.IdComments) = corp2.t2u(right.id_comments),
																	   Transform(Corp2_Raw_MD.Layouts.Temp_AmendWithComment ,
																							 self:=left;
																							 self:=right;
																							),
																		 left outer,local
																		):independent;
		
   join_AmendWithComment_FilmIndx := join(join_AmendWithComment, FilmIndx,
																				  corp2.t2u(left.idFlngNbr) = corp2.t2u(right.idFlngNbr),
																				  Transform(Corp2_Raw_MD.Layouts.Temp_AmendCommentWithFilmIndx ,
																									  self:=left;
																									  self:=right;
																									 ),
																				  left outer,local
																				 ):independent;
						
		Corp2_Mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_MD.Layouts.Temp_AmendCommentWithFilmIndx input):=transform,
		skip(corp2.t2u(input.id_bus_prefix + input.id_bus ) ='' or 
				 corp2.t2u(input.cdVolume + input.cdStartPage + input.TX_Comments + input.cdFilingType + Corp2_Mapping.fValidateDate(input.tsBusEffective[1..10],'CCYY-MM-DD').PastDate) =''
				 )
		
			self.corp_key					    		  	:= state_fips+'-'+corp2.t2u(input.id_bus_prefix + input.id_bus );
			self.corp_sos_charter_nbr  				:= corp2.t2u(input.id_bus_prefix + input.id_bus );
			self.corp_vendor									:= state_fips;
			self.corp_state_origin				  	:= state_origin;
			self.corp_process_date						:= fileDate;
			self.event_filing_cd							:= corp2.t2u(input.cdFilingType);
			self.event_filing_desc						:= map(corp2.t2u(input.filingdesc)<>''=>corp2.t2u(input.filingdesc),
																							 corp2.t2u(input.cdFilingType) in['C46','C46A']=>'OTHER', //not in table  ,per CI 
																							 corp2.t2u(input.cdFilingType)=''=>'',
																							 '**|'+ corp2.t2u(input.cdFilingType)
																							 );//scrubs will catch codes those not have descriptions 
			self.event_filing_date						:= Corp2_Mapping.fValidateDate(input.tsBusEffective[1..10],'CCYY-MM-DD').PastDate;
			self.event_date_type_cd						:= if(self.event_filing_date<>'' ,'FIL','');
			self.event_date_type_desc					:= if(self.event_filing_date<>'' ,'FILING','');
			self.event_microfilm_nbr					:= corp2.t2u(input.cdVolume);
			self.event_start									:= corp2.t2u(input.cdStartPage);
			self.event_desc										:= corp2.t2u(input.TX_Comments);
			self															:= [];
			
		end;
																
		mapEvent		:= dedup(sort(distribute(project(join_AmendWithComment_FilmIndx, EventTransform(left)),hash(corp_key)),record,local),record,local) : independent;

		Corp2_Mapping.LayoutsCommon.stock MD_StockTrans(Corp2_Raw_MD.Layouts.Temp_EntityWithAmend   input):=transform,
		skip(corp2.t2u(input.id_bus_prefix + input.id_bus ) ='' or  corp2.t2u(input.flStock + input.flClose)='')

			self.corp_key					    		  	:= state_fips	+	'-'	+	corp2.t2u(input.id_bus_prefix + input.id_bus);
			self.corp_sos_charter_nbr  				:= corp2.t2u(input.id_bus_prefix + input.id_bus);
			self.corp_vendor									:= state_fips;
			self.corp_state_origin				  	:= state_origin;
			self.corp_process_date						:= fileDate;
			self.stock_stock_description			:= map(corp2.t2u(input.flStock)='Y'=>'STOCK',
																						   corp2.t2u(input.flStock)='N'=>'NONSTOCK',
																							 corp2.t2u(input.flStock)='U'=>'N/A', // Per CI: N/A is on the website,to match with website
																							 '');
			self.stock_addl_info							:= map(corp2.t2u(input.flClose)='Y'=>'CLOSE',
																							 corp2.t2u(input.flClose)='N'=>'NO CLOSE',
																							 corp2.t2u(input.flClose)='U'=>'UNKNOWN',
																							 '');		
			self          										:= [];

		end;

		MapStock	  := dedup(sort(distribute(project(ds_join_EntityWithAmend, MD_StockTrans(left)),hash(corp_key)),
															record,local),record,local) : independent;

		//--------------------------------------------------------------------	
			//Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= AllCorp;
		Main_S 										:= Scrubs_Corp2_Mapping_MD_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MD_'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MD_'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MD'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_MD_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_MD Report' 	//subject
																																	 ,'Scrubs CorpMain_MD Report'  //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpMDMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																															   );
																								 
		EXPORT Main_BadRecords		 := Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid          		 <> 0 or
																													dt_vendor_last_reported_Invalid          			 <> 0 or
																													dt_first_seen_Invalid         					 			 <> 0 or
																													dt_last_seen_Invalid          					  		 <> 0 or
																													corp_ra_dt_first_seen_Invalid          	  		 <> 0 or
																													corp_ra_dt_last_seen_Invalid          				 <> 0 or
																													corp_key_Invalid         								  		 <> 0 or
																													corp_vendor_Invalid          									 <> 0 or
																													corp_state_origin_Invalid          						 <> 0 or
																													corp_process_date_Invalid          						 <> 0 or
																													corp_orig_sos_charter_nbr_Invalid         		 <> 0 or
																													corp_legal_name_Invalid          							 <> 0 or
																													corp_ln_name_type_cd_Invalid          				 <> 0 or
																													corp_address1_effective_date_Invalid      		 <> 0 or
																													corp_address2_effective_date_Invalid      		 <> 0 or
																													corp_filing_date_Invalid          			  		 <> 0 or
																													corp_status_cd_Invalid         					  		 <> 0 or
																													corp_status_desc_Invalid         				  		 <> 0 or
																													corp_inc_state_Invalid          				  		 <> 0 or
																													corp_inc_date_Invalid          								 <> 0 or
																													corp_term_exist_exp_Invalid          					 <> 0 or
																													corp_foreign_domestic_ind_Invalid         		 <> 0 or
																													corp_forgn_state_cd_Invalid          					 <> 0 or
																													corp_forgn_state_desc_Invalid          				 <> 0 or
																													corp_forgn_date_Invalid          							 <> 0 or
																													corp_orig_org_structure_cd_Invalid        		 <> 0 or
																													corp_orig_org_structure_desc_Invalid      		 <> 0 or
																													corp_orig_bus_type_cd_Invalid          				 <> 0 or
																													corp_orig_bus_type_desc_Invalid           		 <> 0 or
																													corp_ra_effective_date_Invalid          			 <> 0 or
																													corp_agent_assign_date_Invalid          			 <> 0 or
																													corp_name_effective_date_Invalid         			 <> 0 or
																													corp_name_reservation_expiration_date_Invalid  <> 0 or
																													corp_name_reservation_date_Invalid						 <> 0 or
																													internalfield1_Invalid												 <> 0 or
																													recordorigin_Invalid													 <> 0
																											);
																											
		EXPORT Main_GoodRecords		:= Main_N.ExpandedInFile( 	dt_vendor_last_reported_Invalid          			 = 0 and
																													dt_first_seen_Invalid         					 			 = 0 and
																													dt_last_seen_Invalid          					  		 = 0 and
																													corp_ra_dt_first_seen_Invalid          	  		 = 0 and
																													corp_ra_dt_last_seen_Invalid          				 = 0 and
																													corp_key_Invalid         								  		 = 0 and
																													corp_vendor_Invalid          									 = 0 and
																													corp_state_origin_Invalid          						 = 0 and
																													corp_process_date_Invalid          						 = 0 and
																													corp_orig_sos_charter_nbr_Invalid         		 = 0 and
																													corp_legal_name_Invalid          							 = 0 and
																													corp_ln_name_type_cd_Invalid          				 = 0 and
																													corp_address1_effective_date_Invalid      		 = 0 and
																													corp_address2_effective_date_Invalid      		 = 0 and
																													corp_filing_date_Invalid          			  		 = 0 and
																													corp_status_cd_Invalid         					  		 = 0 and
																													corp_status_desc_Invalid         				  		 = 0 and
																													corp_inc_state_Invalid          				  		 = 0 and
																													corp_inc_date_Invalid          								 = 0 and
																													corp_term_exist_exp_Invalid          					 = 0 and
																													corp_foreign_domestic_ind_Invalid         		 = 0 and
																													corp_forgn_state_cd_Invalid          					 = 0 and
																													corp_forgn_state_desc_Invalid          				 = 0 and
																													corp_forgn_date_Invalid          							 = 0 and
																													corp_orig_org_structure_cd_Invalid        		 = 0 and
																													corp_orig_org_structure_desc_Invalid      		 = 0 and
																													corp_orig_bus_type_cd_Invalid          				 = 0 and
																													corp_orig_bus_type_desc_Invalid           		 = 0 and
																													corp_ra_effective_date_Invalid          			 = 0 and
																													corp_agent_assign_date_Invalid          			 = 0 and
																													corp_name_effective_date_Invalid          		 = 0 and
																													corp_name_reservation_expiration_date_Invalid  = 0 and																													
																													corp_name_reservation_date_Invalid						 = 0 and
																													internalfield1_Invalid												 = 0 and 
																													recordorigin_Invalid													 = 0
																										);


		EXPORT Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_MD_Main.Threshold_Percent.CORP_KEY										   => true,
																	Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_MD_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
																	Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_MD_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
																	count(Main_GoodRecords) = 0																																																																																											   => true,
																	false
															  );
											
		EXPORT Main_ApprovedRecords 	:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
		
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
		Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_MD',overwrite,__compressed__,named('Sample_Rejected_MainRecs_MD_'+filedate))
																									,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																															 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_MD_'+filedate))
																															 )
																									)
																						)
																				,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainScrubsReportWithExamples_MD_'+filedate))																		
																				//Send Alerts if Scrubs exceeds thresholds
																				,IF(COUNT(Main_ScrubsAlert) > 0,Main_SendEmailFile, OUTPUT('CORP2_MAPPING.MD - No "MAIN" Corp Scrubs Alerts'))
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport
																				,Main_SomeErrorValues																	 
																			//,Main_AlertsCSVTemplate
																				,Main_SubmitStats				
																		 );
																			
	//********************************************************************
		// SCRUB EVENT
	//********************************************************************	
	Event_F := mapEvent;
	Event_S := Scrubs_Corp2_Mapping_MD_Event.Scrubs;						// Scrubs module
	Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
	Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
	Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
	
	//Outputs reports
	Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MD'+filedate));
	Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MD'+filedate));
	Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MD'+filedate));
	Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	Event_OrbitStats					:= Event_U.OrbitStats();

	//Outputs files
	Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_MD_event_scrubs_bits',overwrite,compressed);	//long term storage
	Event_TranslateBitMap			:= output(Event_T);
	//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
	Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

	Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
	
	Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
	Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
	Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_MD Report' //Subject
																																 ,'Scrubs CorpEvent_MD Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMDEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray
																															);
												
	Event_BadRecords 			:= Event_T.ExpandedInFile (event_filing_desc_invalid 	<> 0 );	
	Event_GoodRecords			:= Event_T.ExpandedInFile(event_filing_desc_invalid	 = 0 );	
	Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
	
	Event_RejFile_Exists	:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	Event_ALL							:= sequential(IF(count(Event_BadRecords)<> 0
																					 ,if(poverwrite
																							,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_MD',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_MD_'+filedate))
																							,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_MD_'+filedate)))))
																				 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventMDScrubsReportWithExamples'+filedate))
																				 //Send Alerts if Scrubs exceeds thresholds
																				 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.MD - No "EVENT" Corp Scrubs Alerts'))
																				 ,Event_ErrorSummary
																				 ,Event_ScrubErrorReport
																				 ,Event_SomeErrorValues
																				 //,Event_AlertsCSVTemplate
																					 ,Event_SubmitStats
																					);
																					
		//==========================================VERSION CONTROL====================================================
		IsScrubErrors	:= IF(Event_IsScrubErrors = TRUE OR Main_IsScrubErrors = TRUE,TRUE,FALSE);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Main_' + state_origin, Main_ApprovedRecords , main_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Event_' + state_origin, mapEvent  , event_out,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' + version + '::Stock_' + state_origin, mapStock ,stock_out,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' + state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' + state_origin	,Event_F ,write_fail_event,,,pOverwrite);
	
		mapMD:= sequential( if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
												 //,Corp2_Raw_MD.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,stock_out										
												,if ( count(Main_BadRecords) <> 0 or count(Event_GoodRecords)<> 0
															,sequential(fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' + state_origin)
																					,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' + state_origin)																		 
																					,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_' + state_origin)
																					,if( count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																							,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),,count(Event_ApprovedRecords),count(mapStock)).RecordsRejected																				 
																							,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),,count(Event_ApprovedRecords),count(mapStock)).MappingSuccess																				 
																						)
																					,if(IsScrubErrors
																							,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																							)
																			   )
															,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				  ,write_fail_event
																				  ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,Event_All
												,Main_All	
										);
										
		//Validating the filedate entered is within 30 days								
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if(isFileDateValid
													,mapMD
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).invalidFileDateParm
																			 ,FAIL('Corp2_Mapping.'+state_origin+' failed. An invalid filedate was passed in as a parameter.')
																			)
											   );
		return result;
		
	end;	// end of Update function

end;  // end of  module