import Address,Business_header,mdr;
export Mapping_Cleansing (string filedate) := FUNCTION 

dRecod_type			:= [ '0200' ,	'0300' ,	'0301' ,	'0311' ,	'0312' ,	'0313' ,	'0314' ,	
						 '0317' ,	'0318' ,    '0400' ,	'0700' ,	'1500' ,	'1600' ,	'1601' ,	
						 '1602' ,	'1603' ,	'1604' ,	'1605' ,    '2500' ,	'3000' ,	'3050' ,	
						 '3100' ,	'3150' ,	'3200' ,	'3250' ,	'3300' ,	'3350' ,    '3400' ,	
						 '3410' ,	'3450' ,	'3500' ,	'3550' ,	'3600' ,	'3650' ,	'3700' ,	
						 '3750' ,	'3800' ,	'3850' ,	'3900' ,	'3950' ,	'3960' ,	'3970' ,	
						 '3980' ];
dRecod_used  	    := [ '0200' ,	'0300' ,	'0310' ,	'0318',     '0700' ,'1500' ];

Layout_withID 
    :=RECORD
		  unsigned8 id			:=0;
		  unsigned8 seq			:=0;
		  Layout_acf_in;
    END; 
 
Layout_withID t_Add_ID(Layout_withID pLeft ,Layout_withID pRight,integer c) 
    := TRANSFORM
		  SELF.id				:=if(pleft.id=0,1,if(pRight.recordid='0200',pleft.id+1,pleft.id));
		  SELF.level			:=pRight.level;
		  SELF.recordid			:=pRight.recordid;
		  SELF.rest				:=stringlib.StringToUpperCase(pRight.rest);
		  SELF.seq				:=c;
	END;
	 
Layout_map
    :=Record
			unsigned8 	id				:=0;
			unsigned8 	seq				:=0;
			unsigned4 	dt_first_seen ;
			string1   	level;
			string4   	RecordID		:='';
			string73    Orig_name       :='';
			string70 	orig_Address	:='';
			string30 	orig_city       :='';
			string2  	orig_State      :='';
			string15 	orig_zip        :='';
			qstring120 	company_name;
			qstring35 	company_title;
			string182 	clean;
			string120 	email_Address;
			string73  	clean_name;
			string10  	Company_phone;
			string10  	Company_phone1;
			string10  	Company_phone2;
			qstring34 	vendor_id;
	END;
	
Layout_map t_mapping (Layout_withID  pLeft)
    :=transform
			string70 Address1		:=if(pLeft.RecordID='0300' ,pLeft.rest[6..75],'');
			string30 city       	:=if(pLeft.RecordID='0300' ,pLeft.rest[141..170],'');
			string2  State      	:=if(pLeft.RecordID='0300' ,pLeft.rest[306..307],'');
			string15 zip        	:=if(pLeft.RecordID='0300' ,pLeft.rest[308..322],''); 
			string182 clean_address :=IF(address1='','',address.CleanAddress182(address1, CITY +' '+STATE+' '+ZIP));
			string73  name			:=if(pLeft.RecordID='0700',pLeft.rest[6..55],'');
			
			self.orig_name       	:=name;
			self.orig_Address	  	:=Address1;
			self.orig_city       	:=city;
			self.orig_State      	:=State ;
			self.orig_zip        	:=zip;
			SELF.dt_first_seen 		:=(unsigned4) filedate;				
			SELF.company_name 		:=if(pLeft.RecordID='0200' ,pLeft.rest[6..155],'');
			SELF.vendor_id	 		:=if(pLeft.RecordID='0200' ,pLeft.rest[158..163],'');
			SELF.clean     		    :=if(clean_address[179..180]<='E3' or clean_address[179..180]='E5','',clean_address);
			self.email_Address      :=if(pLeft.recordid='0318' and pleft.rest[6..7]='EM',pleft.rest[8..129],'');
			SELF.company_phone		:=if(pLeft.RecordID='0310',stringlib.stringfilter(pLeft.rest[6..30],'0123456789'),'');										 
			SELF.company_phone1		:=if(pLeft.RecordID='0310',stringlib.stringfilter(pLeft.rest[31..55],'0123456789'),'');
			SELF.company_phone2		:=if(pLeft.RecordID='0310',stringlib.stringfilter(pLeft.rest[56..80],'0123456789'),'');
			SELF.company_title		:=if(pLeft.RecordID='0700',pLeft.rest[71..105],'');
			SELF.clean_name 		:=if(name='','',address.CleanPersonFML73(name));
			SELF                	:=pLeft;
		end;  

layout_map tNormalizePhone(Layout_Map  pInput, unsigned1 pCounter)
    :=TRANSFORM
		  SELF.Company_phone		:=choose(pCounter,pInput.company_phone,pInput.company_phone1,pInput.company_phone2);	 
		  SELF					    :=pInput;
	
	 END;
	 
layout_map t_ITERATE(layout_map  pLEFT,layout_map  PRIGHT)
    :=TRANSFORM
		 SELF.company_name		:=IF(pLEFT.company_name='',pRIGHT.company_name,pLEFT.company_name);
		 SELF.Clean   			:=IF(pLEFT.clean='' ,pRIGHT.clean,pLEFT.clean); 
		 SELF.Company_phone		:=IF(pLEFT.Company_phone='',pRIGHT.Company_phone,pLEFT.Company_phone);	 
		 SELF.vENDor_id			:=IF(pLEFT.vENDor_id	='',pRIGHT.vENDor_id,pLEFT.vENDor_id);
		 SELF.email_address		:=IF(pLEFT.email_address='',pRIGHT.email_address,pLEFT.email_address);
		 SELF.orig_address		:=IF(pLEFT.orig_address='',pRIGHT.orig_address,pLEFT.orig_address);
		 SELF.orig_city         :=IF(pLEFT.orig_city='',pRIGHT.orig_city,pLEFT.orig_city);
		 SElf.orig_state		:=IF(pLEFT.orig_state='',pRIGHT.orig_state,pLEFT.orig_state);
		 Self.orig_zip			:=IF(pLEFT.orig_zip='',pRIGHT.orig_zip,pLEFT.orig_zip);
		 SELF					:=pRIGHT;
 
	 END;
	  
Layout_Base  t_map(layout_map pInput)
     :=TRANSFORM
		
	     STRING  fname		:=pInput.clean_name[6..25];
		 STRING  mname		:=pInput.clean_name[26..45];
		 STRING  lname		:=pInput.clean_name[46..65];
		 
		 STRING  name_suffix:=pInput.clean_name[66..70];
		 STRING  title      :=pInput.clean_name[1..5];
		 
		 SELF.title                 := title;
		 SELF.source 				:= MDR.sourceTools.src_ACF;
	     SELF.record_type 			:= 'C';
		 SELF.phone 				:= (integer) pInput.company_phone;
		 SELF.dt_last_seen			:=  pInput.dt_first_seen;
		 SELF.fname					:=	fname;
		 SELF.mname					:=	mname;
		 SELF.lname					:=	lname;
		 SELF.name_suffix			:=	name_suffix;
		 SELF.name_score			:=	if(pInput.Clean_name='','',Business_Header.CleanName(fname,mname,lname,name_suffix)[142]);
		 SELF.company_prim_range 	:=	pInput.clean[1..10];
		 SELF.company_predir 		:=	pInput.clean[11..12];
		 SELF.company_prim_name 	:=	pInput.clean[13..40];
		 SELF.company_addr_suffix	:=	pInput.clean[41..44];
		 SELF.company_postdir 		:=	pInput.clean[45..46];
		 SELF.company_unit_desig 	:=	pInput.clean[47..56];
		 SELF.company_sec_range 	:=	pInput.clean[57..64];
		 SELF.company_city		 	:=	pInput.clean[90..114];
		 SELF.company_state			:=	pInput.clean[115..116];
		 SELF.company_zip 			:=	(integer)pInput.clean[117..121];
		 SELF.company_zip4 			:=	(integer) pInput.clean[122..125];
		 SELF.prim_range 			:=	pInput.clean[1..10];
		 SELF.predir 				:=	pInput.clean[11..12];
		 SELF.prim_name 			:=	pInput.clean[13..40];
		 SELF.addr_suffix			:=	pInput.clean[41..44];
		 SELF.postdir 				:=	pInput.clean[45..46];
		 SELF.unit_desig 			:=	pInput.clean[47..56];
		 SELF.sec_range 			:=	pInput.clean[57..64];
		 SELF.city		 			:=	pInput.clean[90..114];
		 SELF.state					:=	pInput.clean[115..116];
		 SELF.zip 					:=	(integer)pInput.clean[117..121];
		 SELF.zip4 					:=	(integer) pInput.clean[122..125];
		 SELF.geo_lat 				:=	pInput.clean[146..155];
		 SELF.geo_long 				:=	pInput.clean[156..166];
		 SELF.msa 					:=	pInput.clean[167..170];
		 SELF.county				:=	pInput.clean[143..145];
		 SELF.company_phone 		:=  (integer) pInput.company_phone;
		 SELF						:=	pInput;
		END; 

DACF_in     	:=dataset(cluster.cluster_in+'in::acf_'+filedate,Layout_ACF_in,flat)(level='1');
dACFID      	:=iterate(PROJECT(DACF_in(RecordID in dRecod_used),Layout_withID ),t_Add_ID(left,right,counter));
dACFHead    	:=project(dACFID,t_mapping(left));

		 
dSORTContact 	:=GROUP(SORT(DISTRIBUTE(normalize(dACFHead (recordid<='0700' ),3,tNormalizephone(left,counter))
                                        ,HASH(id)),id,seq,LOCAL),id,LOCAL);

dCompany      	:=ITERATE(dSORTContact,t_ITERATE(LEFT,RIGHT))(recordid>='0700');

dBase			:=DEDUP(PROJECT(dCompany ,t_map(LEFT)),all); 

RETURN dBase ;
END;
