import Address,Business_header,mdr,ut;
export Mapping_Cleansing_SDA (string filedate) := FUNCTION 

dRecod_type_sda		:= [ '0100' , '0200' , '0300' , '0301' , '0310' , '0311' , '0312' , 
						 '0313' , '0314' , '0317' , '0318' , '0400' , '0500' , '0600' , 
						 '0700' , '1500' , '1600' , '1700' , '2400' , '2500' , '2600' , 
						 '2601' , '2602' , '3200' , '3210' , '3300' , '3301' , '3310' ];
dRecod_not_used  	:= [ '0311' , '0312' , '0313' , '0314' , '0317' , '0400' , '0500' ,
						 '0600' , '1600' , '1700' , '2400' , '2600' , '3200' , '3210' ,
						 '3310' ];

Layout_withID 
    :=RECORD
			unsigned8 id			:=0;
			unsigned8 seq			:=0;
			Layout_SDA_in.Sda_in;
END; 
 
Layout_withID t_Add_ID(Layout_withID pLeft ,Layout_withID pRight,integer c) 
    := TRANSFORM
			self.id					:=if(pleft.id=0,1,if(pRight.RecordID='0100',pleft.id+1,pleft.id));
			self.level				:=pRight.level;
			self.RecordID			:=pRight.RecordID;
			self.rest				:=stringlib.StringToUpperCase(pRight.rest);
			self.seq				:=c;
END;
	 

Layouts.Layout_AID t_mapping (Layout_withID  pLeft)
    :=transform
			string70 Address1		:=if(pLeft.RecordID='0300' or pLeft.RecordID='0301' 
										or pLeft.RecordID='3300' or pLeft.RecordID='3301' ,pLeft.rest[6..75],'');
			string30 city       	:=if(pLeft.RecordID='0300' or pLeft.RecordID='0301'  
										or pLeft.RecordID='3300' or pLeft.RecordID='3301' ,pLeft.rest[141..170],'');
			string2  State      	:=if(pLeft.RecordID='0300' or pLeft.RecordID='0301'  or pLeft.RecordID='3300' 
										or pLeft.RecordID='3301' ,pLeft.rest[306..307],'');
			string15 zip        	:=if(pLeft.RecordID='0300' or pLeft.RecordID='0301'  or  pLeft.RecordID='3300'
										or pLeft.RecordID='3301' ,pLeft.rest[308..322],''); 
			//string182 clean_address :=IF(address='','',Address.CleanAddress182(address, CITY +' '+STATE+' '+ZIP));
			string73  name				:=if(pLeft.RecordID='0700' or pLeft.RecordID='2601',pLeft.rest[71..120],'');
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			SELF.prep_addr_line1 		 := Address.Addr1FromComponents(
																						stringlib.stringtouppercase(Address1	)
																						,''
																						,''
																						,''
																						,''
																						,''
																						,''
																					); 
			SELF.prep_addr_line_last := Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(city 	)	
																						,stringlib.stringtouppercase(State	)	
																						,trim(zip,left,right)[1..5]
																					);
			
			self.dt_first_seen 		:=(unsigned4) filedate;				
			self.company_name 		:=if(pLeft.RecordID='0200' or pLeft.RecordID='3200',pLeft.rest[6..155],'');
			self.company_department	:=if(pLeft.RecordID='2602'  ,pLeft.rest[6..55],'');
			self.vendor_id	 		:=if(pLeft.RecordID='0200' or pLeft.RecordID='3200',pLeft.rest[158..163],'');
			//self.clean     		    :=if(clean_address='E502','',clean_address);
			self.email_Address      :=if(pLeft.recordid='0318',pleft.rest[9..129],'');
			self.company_phone		:=if(pLeft.RecordID='0310'  ,
										 stringlib.stringfilter(pLeft.rest[6..30],'0123456789'),'');
			self.company_phone1		:=if(pLeft.RecordID='0310' ,
										 stringlib.stringfilter(pLeft.rest[31..55],'0123456789'),'');
			self.company_phone2		:=if(pLeft.RecordID='0310' ,
										 stringlib.stringfilter(pLeft.rest[56..80],'0123456789'),'');
			
			self.company_title		:=if(name<>'',pLeft.rest[6..70],'');
							
			self.clean_name 			:=if(name='','',Address.CleanPersonFML73(name));
	
			self                	:=pLeft;
end;  

Layouts.Layout_AID tNormalizePhone(Layouts.Layout_AID  pInput, unsigned1 pCounter)
    :=TRANSFORM
	      	
		  STRING73  clean_name  :=if(trim(pInput.clean_name,left,right)='000','',pInput.clean_name);
		  
		  SELF.Company_phone		:=choose(pCounter,pInput.company_phone,pInput.company_phone1,pInput.company_phone2);
	 	  SELF.clean_name       :=clean_name;
		  self.company_title    :=IF(clean_name='','',pInput.company_title);
		  SELF					    		:=pInput;	
END;
	 
Layouts.Layout_AID t_ITERATE(Layouts.Layout_AID  pLEFT,Layouts.Layout_AID  PRIGHT)
    :=TRANSFORM
		 SELF.company_Name				:=IF(pLEFT.company_name='',pRIGHT.company_name,pLEFT.company_name);
		 //SELF.Clean   					:=IF(pLEFT.clean='' ,pRIGHT.clean,pLEFT.clean); 
 		 SELF.prep_addr_line1			:=IF(pLEFT.prep_addr_line1='' ,pRIGHT.prep_addr_line1,pLEFT.prep_addr_line1); 
		 SELF.prep_addr_line_last	:=IF(pLEFT.prep_addr_line_last='' ,pRIGHT.prep_addr_line_last,pLEFT.prep_addr_line_last); 

		 SELF.Company_phone				:=IF(pLEFT.Company_phone='',pRIGHT.Company_phone,pLEFT.Company_phone);	 
		 SELF.vENDor_id						:=IF(pLEFT.vENDor_id	='',pRIGHT.vENDor_id,pLEFT.vENDor_id);
		 SELF											:=pRight;	
END;
	 
Layouts.Layout_AID t_add_dept(Layouts.Layout_AID pLEFT,Layouts.Layout_AID  PRIGHT)
	:=TRANSFORM
		 SELF.company_department:=pRight.company_department;
		 SELF.Company_phone		:=IF(pRIGHT.Company_phone<>'',pRIGHT.Company_phone,pLEFT.Company_phone);	
		 SELF.clean_name			:=pRIGHT.clean_name;		 
		 SELF.company_title		:=pRIGHT.company_title;
		 SELF		  						:=pLeft;
END;
	 
Layouts.Base t_map(Layouts.Layout_AID pInput)
     :=TRANSFORM
		  
		 STRING  fname						:= pInput.clean_name[6..25];
		 STRING  mname						:= pInput.clean_name[26..45];
		 STRING  lname						:= pInput.clean_name[46..65];
		 STRING  name_suffix			:= pInput.clean_name[66..70];
		 STRING  title     	 			:= pInput.clean_name[1..5];
		 
		 SELF.source 							:= MDR.sourceTools.src_sda;
	   SELF.record_type 				:= 'C';
		 SELF.vl_id         			:= pInput.vendor_id;
		 SELF.phone 							:= (integer) pInput.company_phone;
		 SELF.dt_last_seen				:=  pInput.dt_first_seen;
		 SELF.title         			:=	trim(title);
		 SELF.fname								:=	trim(fname);
		 SELF.mname								:=	trim(mname);
		 SELF.lname								:=	trim(lname);
		 SELF.name_suffix					:=	trim(name_suffix);
		 SELF.name_score					:=	if(pInput.Clean_name='','',Business_Header.CleanName(fname,mname,lname,name_suffix)[142]);
		 
		 SELF.company_phone 			:=  (integer) pInput.company_phone;		 
		 SELF											:=	pInput;
		 SELF											:=	[];
END; 

Dsda_in     	:=dataset(cluster.cluster_in+'in::SDA_'+filedate,Layout_SDA_in.SDA_in,flat);
dSdaID      	:=iterate(PROJECT(Dsda_in(RecordID not in dRecod_not_used),Layout_withID ),t_Add_ID(left,right,counter));
dSdaHead    	:=project(dSdaID(recordid<>'0100'),t_mapping(left));

dSORTAggent  	:=GROUP(SORT(DISTRIBUTE(NORMaLIZE(dSdaHead(recordid>='2600' ),3,tNormalizephone(left,counter))
										,HASH(id)),id,-seq,LOCAL),id,LOCAL);
dSORTContact 	:=GROUP(SORT(DISTRIBUTE(NORMaLIZE(dSdaHead(recordid<'1500' ),3,tNormalizephone(left,counter))
										,HASH(id)),id,seq,LOCAL),id,LOCAL);

dagency		 	:=ITERATE(dSORTAggent,t_ITERATE(LEFT,RIGHT))(recordid<='2602');
dCompany      	:=ITERATE(dSORTContact,t_ITERATE(LEFT,RIGHT))(recordid='0700');

dSORTCompany	:=SORT(DISTRIBUTE(dedup(dCompany ,EXCEPT seq,id,all),HASH(id)),id, LOCAL);
dSORTAgency  	:=SORT(DISTRIBUTE(dedup(dagency  ,EXCEPT seq,id,all),HASH(id)),id, LOCAL);

dCompanyAgency	:=JOIN(dSORTCompany,dSORTAgency , 
					   LEFT.id=RIGHT.id,t_add_dept(LEFT,RIGHT), LOCAL);
						 
dBase			:=DEDUP(PROJECT(dCompanyAgency+dCompany ,t_map(LEFT)),all);

RETURN dbase;
end;