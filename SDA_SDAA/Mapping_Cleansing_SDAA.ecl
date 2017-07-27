import Address,Business_header,mdr,lib_stringLib,ut;

export Mapping_Cleansing_SDAA(string filedate) := FUNCTION 


Recod_type_sdaa		:= [ '0200' , '0300' , '0301' , '0310' , '0311' , '0312' , '0313' ,
						 '0314' , '0315' , '0316' , '0317' , '0318' , '0400' , '0450' , 
						 '0500' , '0600' , '0700' , '0800' , '0900' , '01000'];


dRecod_not_used  	:= [ '0311' , '0312' , '0313' , '0314' , '0317' , '0318' , '0400' , 
						 '0450' , '0500' , '0600' , '0900' , '1000' ];
Layout_withID 
    :=RECORD
			unsigned8 id			:=0;
			unsigned8 seq			:=0;
			Layout_SDA_in.Sda_in;
END; 
 
Layout_withID t_Add_ID(Layout_withID pLeft ,Layout_withID pRight,integer c) 
    := TRANSFORM
		  SELF.id				:=if(pleft.id=0,1,if(pRight.recordid='0200',pleft.id+1,pleft.id));
		  SELF.level			:=pRight.level;
		  SELF.recordid			:=pRight.recordid;
		  SELF.rest				:=stringlib.StringToUpperCase(pRight.rest);
		  SELF.seq				:=c;
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
			
			//string182 clean_address :=IF(address1='','',Address.CleanAddress182(address1, CITY +' '+STATE+' '+ZIP));
			string73 name				:=if(pLeft.RecordID='0700' or pLeft.RecordID='0800',pLeft.rest[71..120],'');
						
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
			SELF.dt_first_seen 		:=(unsigned4) filedate;				
			SELF.company_name 		:=if(pLeft.RecordID='0200' or pLeft.RecordID='3200',pLeft.rest[6..155],'');
			SELF.company_department	:=if(pLeft.RecordID='2602'  ,pLeft.rest[6..55],'');
			SELF.vendor_id	 		:=if(pLeft.RecordID='0200' or pLeft.RecordID='3200',pLeft.rest[158..163],'');
			//SELF.clean     		    :=if(clean_address[179..180]<='E3' or clean_address[179..180]='E5','',clean_address);
			self.email_Address      :=if(pLeft.recordid='0318',pleft.rest[9..129],'');
			SELF.company_phone		:=if(pLeft.RecordID='0310' or pLeft.RecordID='3310' ,
										 stringlib.stringfilter(pLeft.rest[6..30],'0123456789'),'');
										 
			SELF.company_phone1		:=if(pLeft.RecordID='0310' or pLeft.RecordID='3310' ,
										 stringlib.stringfilter(pLeft.rest[31..55],'0123456789'),'');
			SELF.company_phone2		:=if(pLeft.RecordID='0310' or pLeft.RecordID='3310' ,
										 stringlib.stringfilter(pLeft.rest[56..80],'0123456789'),'');
			SELF.company_title		:=if(pLeft.RecordID='0700' or pLeft.RecordID='0800' ,pLeft.rest[6..70],'');
	
			SELF.clean_name				:=if(name='','',Address.CleanPersonFML73(name));	
			SELF                	:=pLeft;
		end;  

Layouts.Layout_AID tNormalizePhone(Layouts.Layout_AID  pInput, unsigned1 pCounter)
    :=TRANSFORM
		  SELF.Company_phone	:=choose(pCounter,pInput.company_phone,pInput.company_phone1,pInput.company_phone2);	 
		  SELF					    	:=pInput;	
END;
	 
Layouts.Layout_AID t_ITERATE(Layouts.Layout_AID  pLEFT,Layouts.Layout_AID  PRIGHT)
    :=TRANSFORM
		 SELF.company_name				:=IF(pLEFT.company_name='',pRIGHT.company_name,pLEFT.company_name);
		 //SELF.Clean   					:=IF(pLEFT.clean='' ,pRIGHT.clean,pLEFT.clean); 
		 SELF.prep_addr_line1			:=IF(pLEFT.prep_addr_line1='' ,pRIGHT.prep_addr_line1,pLEFT.prep_addr_line1); 
		 SELF.prep_addr_line_last	:=IF(pLEFT.prep_addr_line_last='' ,pRIGHT.prep_addr_line_last,pLEFT.prep_addr_line_last); 
		 SELF.Company_phone				:=IF(pLEFT.Company_phone='',pRIGHT.Company_phone,pLEFT.Company_phone);	 
		 SELF.vENDor_id						:=IF(pLEFT.vENDor_id	='',pRIGHT.vENDor_id,pLEFT.vENDor_id);
		 SELF											:=pRIGHT;	
END;

Layouts.Base t_map(Layouts.Layout_AID pInput)
     :=TRANSFORM
		
		 STRING  title     				:= pInput.clean_name[1..5];	   
		 STRING  fname						:= pInput.clean_name[6..25];
		 STRING  mname						:= pInput.clean_name[26..45];
		 STRING  lname						:= pInput.clean_name[46..65];		 
		 STRING  name_suffix			:= pInput.clean_name[66..70];
		 
		 SELF.source 							:= MDR.sourceTools.src_sdaa;
	   SELF.record_type 				:= 'C';
		 SELF.vl_id        			 	:= pInput.vendor_id;
		 SELF.phone 							:= (integer) pInput.company_phone;
		 SELF.dt_last_seen				:= pInput.dt_first_seen;
		 SELF.title         			:= trim(title);
		 SELF.fname								:= trim(fname);
		 SELF.mname								:= trim(mname);
		 SELF.lname								:= trim(lname);
		 SELF.name_suffix					:= trim(name_suffix);
		 SELF.name_score					:= if(pInput.Clean_name='','',Business_Header.CleanName(fname,mname,lname,name_suffix)[142]);

		 SELF.company_phone 			:= (integer) pInput.company_phone;
		 SELF											:= pInput;
		 SELF											:= [];
END; 
 
Dsda_in     	:=dataset(cluster.cluster_in+'in::SDAA_'+filedate,Layout_SDA_in.SDA_in,flat);
dSdaID      	:=iterate(PROJECT(Dsda_in(RecordID not in dRecod_not_used),Layout_withID ),t_Add_ID(left,right,counter));
dSdaHead    	:=project(dSdaID(recordid<>'0100'),t_mapping(left));		 
		 
dSORTContact 	:=GROUP(SORT(DISTRIBUTE(normalize(dSdaHead (recordid<='0800' ),3,tNormalizephone(left,counter))
                                        ,HASH(id)),id,seq,LOCAL),id,LOCAL);

dCompany      :=ITERATE(dSORTContact,t_ITERATE(LEFT,RIGHT))(recordid>='0700');

dBase					:=DEDUP(PROJECT(dCompany ,t_map(LEFT)),all); 

RETURN dBase;
END;