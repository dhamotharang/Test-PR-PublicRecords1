IMPORT corp2, corp2_mapping, lib_stringlib;

EXPORT Functions := Module

		//********************************************************************
		//fgetCorpStatusDesc: Returns "corp_status_desc".
		//********************************************************************	
		EXPORT fgetCorpStatusDesc(STRING s) := FUNCTION

			uc_Status  := corp2.t2u(s);
			RETURN map( uc_Status='1'=>'ACTIVE',
									uc_Status='2'=>'ADMINISTRATIVELY DISSOLVED',
									uc_Status='3'=>'INACTIVE',
									uc_Status='4'=>'CANCELLED',
									uc_Status='5'=>'VOLUNTARILY DISSOLVED',
									uc_Status='6'=>'REVOKED',
									uc_Status='7'=>'WITHDRAWN',
									uc_Status='8'=>'MERGED',
									uc_Status='9'=>'JUDICIALLY DISSOLVED',
									uc_Status='10'=>'NON-QUALIFIED MERGED',
								  uc_Status='11'=>'SURRENDERED',
									'');
							
		END;	

		//****************************************************************************
			//fGetCorpFedTaxIDLLC: returns the "corp_fed_tax_id"
		//****************************************************************************
		export fGetCorpFedTaxIDLLC(string s) := function
					 uc_s := corp2.t2u(s);
					 
					 //The search pattern is looking for the following:
					 //1) A string of nine numbers of the same digit.  E.g. 000000000 or 111111111
					 //2) A string of "123456789" (which is also an invalid federal tax id 
					 searchpattern := '^(0{9})*(1{9})*(2{9})*(3{9})*(4{9})*(5{9})*(6{9})*(7{9})*(8{9})*(9{9})*(123456789)*$';
					 cleaned_fein := if(regexfind(searchpattern,uc_s,0) <> '' or (integer)uc_s = 0,'',uc_s);
					 return if(length(cleaned_fein) <> 9,'',cleaned_fein);
		end;

		//********************************************************************
		//fgetCorpActs: Returns "corp_acts".
		//********************************************************************	
		EXPORT fgetCorpActs(STRING s) := FUNCTION

			uc_Acts  := corp2.t2u(s);
			RETURN map( uc_Acts='1'=>'INDIANA BUSINESS CORPORATION LAW',
									uc_Acts='2'=>'INDIANA PROFESSIONAL CORPORATION ACT OF 1983',
									uc_Acts='3'=>'INDIANA NONPROFIT CORPORATION ACT OF 1991',
									uc_Acts='4'=>'INDIANA BUSINESS FLEXIBILITY ACT',
									uc_Acts='5'=>'REVISED UNIFORM LIMITED PARTNERSHIP ACT',
									uc_Acts='6'=>'UNIFORM PARTNERSHIP ACT',
									uc_Acts='7'=>'INDIANA AGRICULTURAL COOPERATIVE ACT',
									uc_Acts='8'=>'INDIANA BUSINESS TRUST ACT OF 1963',
									uc_Acts='9'=>'THE INDIANA FINANCIAL INSTITUTIONS ACT',
									uc_Acts='10'=>'INDIANA INSURANCE LAW',
									uc_Acts='11'=>'MISCELLANEOUS',
									uc_Acts=''=>'',
									'**|'+ uc_Acts);
						
		END;	
		//********************************************************************
		//fgetcontTitle: Returns "cont_title1_desc".
		//********************************************************************	
		EXPORT fgetcontTitle(STRING s) := FUNCTION

			uc_Title  := corp2.t2u(s);
			RETURN map( UC_TITLE='1'=>'PRESIDENT',
									UC_TITLE='2'=>'VICE PRESIDENT',
									UC_TITLE='3'=>'SECRETARY',
									UC_TITLE='4'=>'TREASURER',
									UC_TITLE='5'=>'INCORPORATOR',
									UC_TITLE='6'=>'NEW FILING OFFICER',
									UC_TITLE='7'=>'GENERAL PARTNER',
									UC_TITLE='8'=>'DIRECTOR',
									UC_TITLE='9'=>'OTHER',
									UC_TITLE='10'=>'MANAGER',
									UC_TITLE='11'=>'PARTNER',
									UC_TITLE='12'=>'CEO',
									UC_TITLE='13'=>'TRUSTEE',
									UC_TITLE='14'=>'ATTORNEY',
									UC_TITLE='15'=>'CPA',
									UC_TITLE='16'=>'REGISTERED AGENT',
									UC_TITLE=''=>'',
									'**|'+ UC_TITLE);
						
		END;	
		//********************************************************************
		//fgetOrgStructDesc: Returns "corp_orig_org_structure_desc".
		//********************************************************************		
		EXPORT  string fgetOrgStructDesc(STRING code) := FUNCTION

			st  := corp2.t2u(code);
			RETURN case(st,
				'1'=>'FOR-PROFIT DOMESTIC CORPORATION',
				'2'=>'DOMESTIC PROFESSIONAL CORPORATION',
				'3'=>'FOR-PROFIT FOREIGN CORPORATION',
				'4'=>'FOREIGN PROFESSIONAL CORPORATION',
				'5'=>'NON-PROFIT DOMESTIC CORPORATION',
				'6'=>'NON-PROFIT FOREIGN CORPORATION',
				'7'=>'DOMESTIC LIMITED LIABILITY COMPANY (LLC)',
				'8'=>'FOREIGN LIMITED LIABILITY COMPANY (LLC)',
				'9'=>'DOMESTIC LIMITED PARTNERSHIP (LP)',
				'10'=>'FOREIGN LIMITED PARTNERSHIP (LP)',
				'11'=>'DOMESTIC LIMITED LIABILITY PARTNERSHIP (LLP)',
				'12'=>'FOREIGN LIMITED LIABILITY PARTNERSHIP (LLP)',
				'13'=>'NON-QUALIFIED FOREIGN ENTITY',
				'14'=>'DOMESTIC AGRICULTURAL COOP',
				'15'=>'FOREIGN AGRICULTURAL COOP',
				'16'=>'DOMESTIC BUSINESS TRUST',
				'17'=>'FOREIGN BUSINESS TRUST',
				'18'=>'DOMESTIC FINANCIAL INSTITUTES',
				'19'=>'FOREIGN FINANCIAL INSTITUTES',
				'20'=>'DOMESTIC INSURANCE CORPORATION',
				'21'=>'FOREIGN INSURANCE CORPORATION',
				'22'=>'MISCELLANEOUS',
				''=>'',
				'**|'+ st);
				
		END;

		//********************************************************************
		//Get_State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
		//********************************************************************	
		EXPORT Get_State_Code(string code) 
			:= map (corp2.t2u(code) in 
					['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY',
					 'LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK',
					 'OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AP','AA',
					 'CB','UK','GB','CD','HK','MX','EU','CI','SA','II','SL','US','BE','FR','JA','NL','NS','OA','BR',
					 'AF','IE','AU','LX','CH','CZ','PH','BL','BW','GR','PN']=> corp2.t2u(code),
						corp2.t2u(code) in ['XX','X','..','.','12','AN','']=>'', //as per CI
					 '**');
				
		//********************************************************************
		//fGetStateDesc: Returns full name from "Two digit State_Code" 
		//********************************************************************	
		EXPORT  string fGetStateDesc(STRING state) := FUNCTION

			st  := corp2.t2u(state);
			RETURN case(st,
				'AL'=>'ALABAMA',
				'AK'=>'ALASKA',
				'AS'=>'AMERICAN SAMOA',
				'AZ'=>'ARIZONA',
				'AR'=>'ARKANSAS',
				'CA'=>'CALIFORNIA',
				'CO'=>'COLORADO',
				'CT'=>'CONNECTICUT',
				'DE'=>'DELAWARE',
				'DC'=>'DISTRICT OF COLUMBIA',
				'FM'=>'FEDERATED STATES OF MICRONESIA',
				'FL'=>'FLORIDA',
				'GA'=>'GEORGIA',
				'GU'=>'GUAM',
				'HI'=>'HAWAII',
				'ID'=>'IDAHO',
				'IL'=>'ILLINOIS',
				'IN'=>'INDIANA',
				'IA'=>'IOWA',
				'KS'=>'KANSAS',
				'KY'=>'KENTUCKY',
				'LA'=>'LOUISIANA',
				'ME'=>'MAINE',
				'MD'=>'MARYLAND',
				'MA'=>'MASSACHUSETTS',
				'MI'=>'MICHIGAN',
				'MN'=>'MINNESOTA',
				'MS'=>'MISSISSIPPI',
				'MO'=>'MISSOURI',
				'MT'=>'MONTANA',
				'NE'=>'NEBRASKA',
				'NV'=>'NEVADA',
				'NH'=>'NEW HAMPSHIRE',
				'NJ'=>'NEW JERSEY',
				'NM'=>'NEW MEXICO',
				'NY'=>'NEW YORK',
				'NC'=>'NORTH CAROLINA',
				'ND'=>'NORTH DAKOTA',
				'MP'=>'NORTHERN MARIANA ISLANDS',
				'OH'=>'OHIO',
				'OK'=>'OKLAHOMA',
				'OR'=>'OREGON',
				'PW'=>'PALAU',
				'PA'=>'PENNSYLVANIA',
				'PR'=>'PUERTO RICO',
				'RI'=>'RHODE ISLAND',
				'SC'=>'SOUTH CAROLINA',
				'SD'=>'SOUTH DAKOTA',
				'TN'=>'TENNESSEE',
				'TX'=>'TEXAS',
				'UT'=>'UTAH',
				'VT'=>'VERMONT',
				'VI'=>'VIRGIN ISLANDS',
				'VA'=>'VIRGINIA',
				'WA'=>'WASHINGTON',
				'WV'=>'WEST VIRGINIA',
				'WI'=>'WISCONSIN',
				'WY'=>'WYOMING',
				'AE'=>'ARMED FORCES EUROPE, THE MIDDLE EAST, AND CANADA',
				'AP'=>'ARMED FORCES PACIFIC',
				'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA)',
				'CB'=>'COLUMBIA',
				'UK'=>'UNITED KINGDOM',
				'GB'=>'GREAT BRITAIN',
				'CD'=>'CANADA',
				'HK'=>'HONG KONG',
				'MX'=>'MEXICO',
				'EU'=>'EUROPE',
				'CI'=>'COOK ISLANDS',
				'SA'=>'OTHER S&C AMERICAN',
				'II'=>'INDIA',
				'SL'=>'SCOTLAND',
				'US'=>'UNITED STATES',
				'BE'=>'BERMUDA',
				'FR'=>'FRANCE',
				'JA'=>'JAPAN',
				'MH'=>'MARSHALL ISLANDS',
				'NL'=>'NETHERLANDS',
				'NS'=>'NOVA SCOTIA, CANADA',
				'OA'=>'OTHER ASIA',
				'BR'=>'BARBADOS',
				'AF'=>'AFRICA',
				'IE'=>'IRELAND',
				'AU'=>'AUSTRALIA',
				'LX'=>'LUXEMBOURG',
				'CH'=>'CHINA',
				'CZ'=>'CANAL ZONE',
				'PH'=>'PHILIPPINES',
				'BL'=>'BELGIUM',
				'BW'=>'BRITISH WEST INDIES',
				'GR'=>'GERMANY',
				'PN'=>'PANAMA',
				'XX'=>'',
				'X' =>'',
				'..'=>'',
				'.' =>'',
				'12'=>'',
				'AN'=>'',				
				''  =>'',
				'**|'+ st);
			
		END;

	//********************************************************************
		//fgetFiling_desc: Returns "event_filing_desc".
		//********************************************************************	
	EXPORT  string fgetFiling_desc(STRING code) := FUNCTION

		st  := corp2.t2u(code);
		RETURN map(	st in['18','46','106','145','265','312','431'] => 'ADMINISTRATIVE DISSOLUTION',
								st in['706','707','708','709','722','724','800','801','802','804','805','806','807','808','811']=>'ADMINISTRATIVE ENTITY DELETE',				
								st in['830','834','835','836','837','838','839','840','843','844','846','849','854','856','831']=>'ADMINISTRATIVE FILING DELETE',				
								st in['822','824','826','832','950','951','970','950','951','970']=>'ADMINISTRATIVE ENTITY EDIT',
								st in['600','601','602','604','606','607','608']=> 'AMENDED AND RESTATED ARTICLES',
								st='605'=> 'AMENDED AND RESTATED ARTICLES OF LIMITED PARTNERSHIP',
								st='603'=> 'AMENDED AND RESTATED ARTICLES OF ORGANIZATION',
								st='421'=> 'AMENDMENT OF DOCUMENT',
								st in['301','321']=> 'AMENDMENT TO TRUST INSTRUMENT',
								st in['280','360']=> 'APPLICATION FOR ADMISSION',
								st in['281','361']=> 'APPLICATION FOR AMENDED CERTIFICATE OF ADMISSION',
								st in['51','71','111','151','401']=> 'APPLICATION FOR AMENDED CERTIFICATE OF AUTHORITY',
								st in['50','70','110','150','400']=> 'APPLICATION FOR CERTIFICATE OF AUTHORITY',
								st in['52','72','112','152','212','232','282','362','402']=> 'APPLICATION FOR CERTIFICATE OF WITHDRAWAL',
								st='190'=> 'APPLICATION FOR REGISTRATION',
								st='9'=> 'ARTICLES OF ACCEPTANCE',
								st in['2','31','91','131','251','341','381']=> 'ARTICLES OF AMENDMENT',
								st='700'=>'ARTICLES OF CHARTER SURRENDER',
								st in['702','704']=>'ARTICLES OF ACCEPTANCE',
								st in['269','397']=> 'ARTICLES OF CONSOLIDATION',
								st in['10','38','57','77','99','117','138','157','258','287','425']=>'ARTICLES OF CORRECTION',
								st in['3','32','92','132','252','342','382']=>'ARTICLES OF DISSOLUTION',
								st='415'=> 'ARTICLES OF DOMESTICATION',
								st in['12','40','348','388']=>'ARTICLES OF EXCHANGE',
								st in['1','30','90','250','340','380']=> 'ARTICLES OF INCORPORATION',
								st in['8','37','97','136','256','315','346','386','434']=> 'ARTICLES OF MERGER',
								st='130'=> 'ARTICLES OF ORGANIZATION',
								st in['7','36','55','75','96','115','137','155','257','285','305','325']=> 'ARTICLES OF REINSTATEMENT',
								st='396'=> 'ARTICLES OF REORGANIZATION',
								st in['6','35','95','135','255','345','385']=> 'ARTICLES OF RESTATEMENT',
								st in['11','39','100','259']=> 'ARTICLES OF REVOCATION OF DISSOLUTION',
								st in['268','297']=> 'ARTICLES OF SPECIAL TRANSACTIONS',
								st in['13','41','60','80','101','119','140','159','289','307','327','260']=> 'BUSINESS ENTITY REPORT',
								st in['5','34','54','74','94','114','134','154','174','194','214','234','254','284','304','324','344','364','384','404','424']=> 'CANCELLATION OF ASSUMED BUSINESS NAME', 
								st='171'=> 'CERTIFICATE OF AMENDMENT OF LIMITED PARTNERSHIP',
								st in['191','211','231']=> 'CERTIFICATE OF AMENDMENT OF REGISTRATION',
								st in['4','33','53','73','93','113','133','153','173','193','213','233','253','283','303','323','343','363','383','403','423']=> 'CERTIFICATE OF ASSUMED BUSINESS NAME',
								st='247'=> 'CERTIFICATE OF AUTHORITY',
								st in['172','192']=> 'CERTIFICATE OF CANCELLATION',
								st in['59','79','367','407']=> 'CERTIFICATE OF EXCHANGE',
								st='170'=> 'CERTIFICATE OF LIMITED PARTNERSHIP',
								st in['76','116','156','176','196','215','235','245','286','335','365','405','56']=> 'CERTIFICATE OF MERGER', 
								st in['16','44','63','83','104','122','263','292','351','370','391','410','429','143']=> 'CHANGE OF OFFICER',
								st in['17','45','64','84','105','123','144','163','181','201','220','240','264','293','311','331','352','371','392','411','430']=> 'CHANGE OF PRINCIPAL ADDRESS',
								st='420'=> 'INITIAL FILING',
								st in['19','47','66','86','107','125','146','165','183','203','222','242','266','295','313','333','354','394','413','432','373']=> 'JUDICIAL DISSOLUTION',
								st in['21','49','68','88','109','127','148','167','185','205','244','248','270','298','336','356','375','398','416','224']=> 'MERGED OUT OF EXISTENCE', 
								st in['316','435']=> 'MERGED OUT OF EXISTENCE', 
								st in['20','48','67','87','108','126','147','166','184','204','223','243','267','296','314','334','355','374','395','414','433']=> 'MISCELLANEOUS',
								st in['504','514','524','534','543']=> 'NAME CANCELLED',
								st='540'=> 'NAME REGISTRATION',
								st in['501','511','521','531','541']=> 'NAME RENEWAL',
								st in['500','510','520','530']=> 'NAME RESERVATION',
								st in['502','512','522','532']=> 'NAME TRANSFER',
								st in['14','42','61','81','102','120','141','160','178','198','217','237','261','290','308','328','349','368','389','408','427']=> 'NOTICE OF CHANGE OF REGISTERED OFFICE OR REGISTERED AGENT',
								st in['620','621','622','623','625','246','626','624','627','628','629']=> 'NOTICE OF MERGER',
								st in['210','230']=> 'REGISTRATION OF LIMITED LIABILITY PARTNERSHIP',
								st='175'=> 'RESTATED CERTIFICATE OF LIMITED PARTNERSHIP',
								st='195'=> 'RESTATED CERTIFICATE OF REGISTRATION',
								st in['65','85','124','164','294','332']=> 'REVOCATION',
								st in['15','43','62','82','103','121','142','161','179','199','218','238','262','291','309','329','350','369','390','409','428','302']=> 'SURRENDER OF AUTHORITY TO TRANSACT BUSINESS',
								st='322'=> 'SURRENDER OF AUTHORITY TO TRANSACT BUSINESS',
								st in['300','320']=> 'TRUST AGREEMENT',
								st='422'=> 'WITHDRAWAL / DISSOLUTION',
								st=''=>'',
								'**|'+ st);
			END;

END;