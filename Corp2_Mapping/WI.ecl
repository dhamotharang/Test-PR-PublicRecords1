import Corp2, _validate, Address, _control, versioncontrol;

export WI := MODULE;
	
	export Layouts_Raw_Input := MODULE;

			export partialLine1_Layout := record
				integer keyValue;
				string68 org_name;
				string2  org_type;
				string8  org_id;
				string22 org_type_desc;
				string2  forgn_inc_state;
			    string8  paid_capitol_rep;
				string1  paid_capitol_mills;
				string8  inc_date;
				string3  status_code1;
				string10 status_code1_date;
				string36 reg_agent_name;
				string32 reg_agent_addr1;
				string30 reg_agent_city;
				string2  reg_agent_state;
				string10 reg_agent_zip;
				string3  status_code2;
				string10 status_code2_date;			
				end; 
	
			export fullLine1_Layout := record
				partialLine1_Layout;			
				string32 reg_agent_addr2;
				string11 most_recent_locator_number;
				string11 most_recent_form20;
				string3  status_code3;
				string10 status_code3_date;
				end; 

			export reportLIne := record,MAXLENGTH(137)
				string 	 lineVary;			
				end;
					
			export reportLIneLen := record,MAXLENGTH(150)
				integer  lineLen;
				reportLIne;
				end;
		
		    export sequencedLines := record
				integer  position := 0;
				string 	 lineVary;			
				end;
				
			export keyPositionLines  := record
				integer  keyValue := 0;
				sequencedLines;						
				end;
	end; // end of Layouts_Raw_Input module

	export Files_Raw_Input := MODULE;
	    
		// vendor file definition
		export corporations(string filedate) := dataset('~thor_data400::in::corp2::'+filedate+'::comfichex::wi',	
		layouts_Raw_Input.reportLIne,CSV(HEADING(1),SEPARATOR(['[|]']),TERMINATOR(['\r\n']),notrim));									 
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;				
  
		setForgnStates := ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY',
						   'LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK',
						   'OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AP','AA','CZ'];
						   
		setForgnTypes  := ['02','08','13','15','16','90'];
		
		setDomesticTypes := ['01','03','04','05','06','07','09','10','11','12','14','98'];  			
		
		corp2_mapping.Layout_CorpPreClean corpTransform01(Layouts_Raw_Input.fullLine1_Layout input) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '55-' + trim(input.org_id,left,right);
			self.corp_vendor					:= '55';
			self.corp_state_origin				:= 'WI';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.org_id,left,right);
			self.corp_src_type					:= 'SOS';						
			self.corp_legal_name				:= trimUpper(input.org_name); 														
			self.corp_ln_name_type_cd			:= '01';													   
			self.corp_ln_name_type_desc			:= 'LEGAL';																							
			self.corp_status_cd					:= trimUpper(input.status_code1);
			self.corp_status_desc				:= map(	
														trimUpper(input.status_code1) = 'ADS'  => 'ADMINISTRATIVELY DISSOLVED',
														trimUpper(input.status_code1) = 'CAN'  => 'CERTIFICATE OF CANCELLATION',
														trimUpper(input.status_code1) = 'CMC'  => 'NAME CONSENT REQUIRED',
														trimUpper(input.status_code1) = 'CNF'  => 'NAME CONFLICT',
														trimUpper(input.status_code1) = 'CNS'  => 'CONSOLIDATED -- NON-SURVIVOR',
														trimUpper(input.status_code1) = 'COM'  => 'IN PROCESS, NOT YET FILED',
														trimUpper(input.status_code1) = 'DEL'  => 'RECORD DELETED',
														trimUpper(input.status_code1) = 'DIS'  => 'DISSOLVED',
														trimUpper(input.status_code1) = 'DLQ'  => 'DELINQUENT',
														trimUpper(input.status_code1) = 'DNP'  => 'DISSOLVED, NAME PROTECTED',
														trimUpper(input.status_code1) = 'EXP'  => 'EXPIRED FOREIGN REGISTERED NAME',
														trimUpper(input.status_code1) = 'FDE'  => 'FILED, DELAYED EFFECTIVE',
														trimUpper(input.status_code1) = 'IBS'  => 'IN BAD STANDING',
														trimUpper(input.status_code1) = 'IGS'  => 'RESTORED TO GOOD STANDING',
														trimUpper(input.status_code1) = 'IDS'  => 'INVOLUNTARILY DISSOLVED',
														trimUpper(input.status_code1) = 'INC'  => 'INCORPORATED/QUALIFIED',
														trimUpper(input.status_code1) = 'MGD'  => 'MERGED -- NON-SURVIVOR',
														trimUpper(input.status_code1) = 'ORG'  => 'ORGANIZED',
														trimUpper(input.status_code1) = 'PND'  => 'NAME RESERVED, NOT YET FILED',
														trimUpper(input.status_code1) = 'RCA'  => 'CERTIFICATE OF AUTHORITY REVOKED',
														trimUpper(input.status_code1) = 'RES'  => 'NAME RESERVED, SHORT-TERM',
														trimUpper(input.status_code1) = 'RGD'  => 'REGISTERED',
														trimUpper(input.status_code1) = 'RGL'  => 'NAME REGISTERED, LONG-TERM',
														trimUpper(input.status_code1) = 'RLT'  => 'NAME RESERVED, LONG-TERM',
														trimUpper(input.status_code1) = 'TER'  => 'TERMINATED FOREIGN REGISTERED NAME',
														trimUpper(input.status_code1) = 'WTD'  => 'WITHDRAWAL',
														''
													   );
			self.corp_status_date                 := if(_validate.date.fIsValid(input.status_code1_date) and 
													  _validate.date.fIsValid(input.status_code1_date,_validate.date.rules.DateInPast),
											          input.status_code1_date,
													  ''
												      );													  	
			self.corp_inc_state					:= if(trim(input.org_type,left,right) <> '02',
			                                          'WI',
													  ''
														);												   
			self.corp_forgn_state_cd           := if(trim(input.org_type,left,right) = '02' and input.forgn_inc_state in setForgnStates,
			                                          input.forgn_inc_state,
													  ''
												      );								
			self.corp_ra_name					:= if(trimUpper(input.reg_agent_name) <> '' and 
												      trimUpper(input.reg_agent_name) <> 'AGENT RESIGNED' and		
													  trimUpper(input.reg_agent_name) <> 'FOR REFERENCE ONLY' and
													  trimUpper(input.reg_agent_name) <> 'ADDRESS FOR SERVICE OF PROCESS',
													  trimUpper(input.reg_agent_name),
													  '');
			self.corp_ra_addl_info             := if(trimUpper(input.reg_agent_name) = 'AGENT RESIGNED',
													  'AGENT RESIGNED',
													  '');
			self.corp_ra_address_line1			:= if(trimUpper(input.reg_agent_addr1) <> 'NO ADDRESS' and 
													  trimUpper(input.reg_agent_addr1) <> 'XX',
													  trimUpper(input.reg_agent_addr1),
													  '');
			self.corp_ra_address_line2			:= trimUpper(input.reg_agent_addr2);												
			self.corp_ra_address_line3			:= if(trimUpper(input.reg_agent_city) <> 'NO CITY' and
													  trimUpper(input.reg_agent_city) <> 'XX',
													  trimUpper(input.reg_agent_city),
													  '');
			self.corp_ra_address_line4			:= if(trimUpper(input.reg_agent_state) <> 'XX',
													  trimUpper(input.reg_agent_state),
													  '');
			self.corp_ra_address_line5			:= if((integer)trim(StringLib.StringFilterOut(input.reg_agent_zip,'-'),left,right) <> 0,
													  trim(StringLib.StringFilterOut(input.reg_agent_zip,'-'),left,right),
													  '');
													  
			self.corp_inc_date                 := if(input.org_type in setDomesticTypes and 													
													  _validate.date.fIsValid(input.inc_date) and 
													  _validate.date.fIsValid(input.inc_date,_validate.date.rules.DateInPast),
											          input.inc_date,
													  ''
												      );														
			self.corp_forgn_date 				:= if(input.org_type in setForgnTypes and 													
													  _validate.date.fIsValid(input.inc_date) and 
													  _validate.date.fIsValid(input.inc_date,_validate.date.rules.DateInPast),
											          input.inc_date,
													  ''
												      );
			self.corp_certificate_nbr		     := trim(input.most_recent_form20,left,right);
			self.corp_orig_org_structure_cd     := trim(input.org_type,left,right);
			self.corp_orig_org_structure_desc   := map(	
														trim(input.org_type,left,right) = '01' => 'DOMESTIC BUSINESS CORPORATION',
														trim(input.org_type,left,right) = '02' => 'FOREIGN CORPORATION',
														trim(input.org_type,left,right) = '03' => 'MEMBERSHIP COOPERATIVE',
														trim(input.org_type,left,right) = '04' => 'STOCK COOPERATIVE',														
														trim(input.org_type,left,right) = '05' => 'SERVICE CORPORATION',
														trim(input.org_type,left,right) = '06' => 'NONSTOCK CORPORATION',
														trim(input.org_type,left,right) = '07' => 'DOMESTIC BUSINESS TRUST',
														trim(input.org_type,left,right) = '08' => 'FOREIGN LIMITED PARTNERSHIP',
														trim(input.org_type,left,right) = '09' => 'CLOSE CORPORATION',
														trim(input.org_type,left,right) = '10' => 'SERVICE CLOSE CORPORATION',
														trim(input.org_type,left,right) = '11' => 'MISCELLANEOUS',
														trim(input.org_type,left,right) = '12' => 'DOMESTIC LIMITED LIABILITY COMPANY',
														trim(input.org_type,left,right) = '13' => 'FOREIGN LIMITED LIABILITY COMPANY',
														trim(input.org_type,left,right) = '14' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',	
														trim(input.org_type,left,right) = '15' => 'FOREIGN LIMITED LIABILITY PARTNERSHIP',	
														trim(input.org_type,left,right) = '16' => 'FOREIGN NONSTOCK CORPORATION',	
														trim(input.org_type,left,right) = '90' => 'FOREIGN REGISTERED NAME',	
														trim(input.org_type,left,right) = '98' => 'LONG-TERM NAME RESERVATION',	
														''
													   );														   			
			self := [];						
		end; // end CorpTransform01

  Corp2.Layout_Corporate_Direct_Corp_In corpTransform02(Layouts_Raw_Input.fullLine1_Layout input) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;			
			self.corp_key						:= '55-' + trim(input.org_id,left,right);
			self.corp_vendor					:= '55';
			self.corp_state_origin				:= 'WI';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.org_id,left,right);																										
			self.corp_status_cd				:= trimUpper(input.status_code2);
			self.corp_status_desc				:= map(	
														trimUpper(input.status_code2) = 'ADS'  => 'ADMINISTRATIVELY DISSOLVED',
														trimUpper(input.status_code2) = 'CAN'  => 'CERTIFICATE OF CANCELLATION',
														trimUpper(input.status_code2) = 'CMC'  => 'NAME CONSENT REQUIRED',
														trimUpper(input.status_code2) = 'CNF'  => 'NAME CONFLICT',
														trimUpper(input.status_code2) = 'CNS'  => 'CONSOLIDATED -- NON-SURVIVOR',
														trimUpper(input.status_code2) = 'COM'  => 'IN PROCESS, NOT YET FILED',
														trimUpper(input.status_code2) = 'DEL'  => 'RECORD DELETED',
														trimUpper(input.status_code2) = 'DIS'  => 'DISSOLVED',
														trimUpper(input.status_code2) = 'DLQ'  => 'DELINQUENT',
														trimUpper(input.status_code2) = 'DNP'  => 'DISSOLVED, NAME PROTECTED',
														trimUpper(input.status_code2) = 'EXP'  => 'EXPIRED FOREIGN REGISTERED NAME',
														trimUpper(input.status_code2) = 'FDE'  => 'FILED, DELAYED EFFECTIVE',
														trimUpper(input.status_code2) = 'IBS'  => 'IN BAD STANDING',
														trimUpper(input.status_code2) = 'IGS'  => 'RESTORED TO GOOD STANDING',
														trimUpper(input.status_code2) = 'IDS'  => 'INVOLUNTARILY DISSOLVED',
														trimUpper(input.status_code2) = 'INC'  => 'INCORPORATED/QUALIFIED',
														trimUpper(input.status_code2) = 'MGD'  => 'MERGED -- NON-SURVIVOR',
														trimUpper(input.status_code2) = 'ORG'  => 'ORGANIZED',
														trimUpper(input.status_code2) = 'PND'  => 'NAME RESERVED, NOT YET FILED',
														trimUpper(input.status_code2) = 'RCA'  => 'CERTIFICATE OF AUTHORITY REVOKED',
														trimUpper(input.status_code2) = 'RES'  => 'NAME RESERVED, SHORT-TERM',
														trimUpper(input.status_code2) = 'RGD'  => 'REGISTERED',
														trimUpper(input.status_code2) = 'RGL'  => 'NAME REGISTERED, LONG-TERM',
														trimUpper(input.status_code2) = 'RLT'  => 'NAME RESERVED, LONG-TERM',
														trimUpper(input.status_code2) = 'TER'  => 'TERMINATED FOREIGN REGISTERED NAME',
														trimUpper(input.status_code2) = 'WTD'  => 'WITHDRAWAL',
														''
													   );
			self.corp_status_date                 := if(_validate.date.fIsValid(input.status_code2_date) and 
													  _validate.date.fIsValid(input.status_code2_date,_validate.date.rules.DateInPast),
											          input.status_code2_date,
													  ''
												      );	
			self := [];						
		end; // end CorpTransform02		
		
		Corp2.Layout_Corporate_Direct_Corp_In corpTransform03(Layouts_Raw_Input.fullLine1_Layout input) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;			
			self.corp_key						:= '55-' + trim(input.org_id,left,right);
			self.corp_vendor					:= '55';
			self.corp_state_origin				:= 'WI';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.org_id,left,right);																										
			self.corp_status_cd					:= trimUpper(input.status_code3);
			self.corp_status_desc				:= map(	
														trimUpper(input.status_code3) = 'ADS'  => 'ADMINISTRATIVELY DISSOLVED',
														trimUpper(input.status_code3) = 'CAN'  => 'CERTIFICATE OF CANCELLATION',
														trimUpper(input.status_code3) = 'CMC'  => 'NAME CONSENT REQUIRED',
														trimUpper(input.status_code3) = 'CNF'  => 'NAME CONFLICT',
														trimUpper(input.status_code3) = 'CNS'  => 'CONSOLIDATED -- NON-SURVIVOR',
														trimUpper(input.status_code3) = 'COM'  => 'IN PROCESS, NOT YET FILED',
														trimUpper(input.status_code3) = 'DEL'  => 'RECORD DELETED',
														trimUpper(input.status_code3) = 'DIS'  => 'DISSOLVED',
														trimUpper(input.status_code3) = 'DLQ'  => 'DELINQUENT',
														trimUpper(input.status_code3) = 'DNP'  => 'DISSOLVED, NAME PROTECTED',
														trimUpper(input.status_code3) = 'EXP'  => 'EXPIRED FOREIGN REGISTERED NAME',
														trimUpper(input.status_code3) = 'FDE'  => 'FILED, DELAYED EFFECTIVE',
														trimUpper(input.status_code3) = 'IBS'  => 'IN BAD STANDING',
														trimUpper(input.status_code3) = 'IGS'  => 'RESTORED TO GOOD STANDING',
														trimUpper(input.status_code3) = 'IDS'  => 'INVOLUNTARILY DISSOLVED',
														trimUpper(input.status_code3) = 'INC'  => 'INCORPORATED/QUALIFIED',
														trimUpper(input.status_code3) = 'MGD'  => 'MERGED -- NON-SURVIVOR',
														trimUpper(input.status_code3) = 'ORG'  => 'ORGANIZED',
														trimUpper(input.status_code3) = 'PND'  => 'NAME RESERVED, NOT YET FILED',
														trimUpper(input.status_code3) = 'RCA'  => 'CERTIFICATE OF AUTHORITY REVOKED',
														trimUpper(input.status_code3) = 'RES'  => 'NAME RESERVED, SHORT-TERM',
														trimUpper(input.status_code3) = 'RGD'  => 'REGISTERED',
														trimUpper(input.status_code3) = 'RGL'  => 'NAME REGISTERED, LONG-TERM',
														trimUpper(input.status_code3) = 'RLT'  => 'NAME RESERVED, LONG-TERM',
														trimUpper(input.status_code3) = 'TER'  => 'TERMINATED FOREIGN REGISTERED NAME',
														trimUpper(input.status_code3) = 'WTD'  => 'WITHDRAWAL',
														''
													   );
			self.corp_status_date                 := if(_validate.date.fIsValid(input.status_code3_date) and 
													  _validate.date.fIsValid(input.status_code3_date,_validate.date.rules.DateInPast),
											          input.status_code3_date,
													  ''
												      );	
			self := [];						
		end; // end CorpTransform03
		
		Corp2.Layout_Corporate_Direct_AR_In ARTransform01(Layouts_Raw_Input.fullLine1_Layout input):=transform
													   
			self.corp_key					      := '55-' + trim(input.org_id,left,right);
			self.corp_vendor				      := '55';
			self.corp_state_origin			      := 'WI';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.org_id, left, right);
			self.ar_microfilm_nbr                := trim(input.most_recent_locator_number, left, right);	
			self.ar_annual_report_cap            := if(trimUpper(input.paid_capitol_mills) = 'M',
													   trim(input.paid_capitol_rep,left,right) + '000000',
													   trim(input.paid_capitol_rep,left,right));
			self                                  := [] ;
		end;
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorps(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');	
			
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
																			trim(input.corp_ra_address_line2,left,right),left,right),														                   
																			trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																			trim(input.corp_ra_address_line4,left,right) + ' ' +
																			trim(input.corp_ra_address_line5,left,right),left,right));
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
			self 								:= [];
		end;						
		reportLINES := Files_Raw_Input.corporations(fileDate);
		// lines := dataset('~thor_data400::in::pvsmith::20070709::corporations::wi',
		// reportLIne,CSV(HEADING(1),SEPARATOR(['[|]']),TERMINATOR(['\n','\r\n']),notrim));		
		
lines0 := reportLines(length(lineVary) > 0);
lines1 := lines0((not REGEXFIND('^DATE (.*)/(.*)/(.*)', lineVary[1..15]) and lineVary[114..122]<>'     PAGE') and (not REGEXFIND('^DATE (.*)/(.*)/(.*)', lineVary[2..16]) and lineVary[115..123]<>'     PAGE'));
lines2 := lines1((lineVary[1..21]<>'CORPORATION NAME     ') and (lineVary[1..21]<>'REGISTERED AGENT     ' and lineVary[2..22]<>'REGISTERED AGENT     '));	

Layouts_Raw_Input.sequencedLines setPosition(Layouts_Raw_Input.reportLIne l, INTEGER cntr) := TRANSFORM
	SELF.position := if((cntr % 3) = 0, 3, (cntr % 3));
	SELF 		  := l;
	END;
	
Layouts_Raw_Input.keyPositionLines setKeyPosition(Layouts_Raw_Input.sequencedLines l, INTEGER cntr) := TRANSFORM
	SELF.keyValue := cntr;
	SELF 		  := l;
	END;
	
positionedLines := PROJECT(lines2, setPosition(LEFT,COUNTER));

pos1 := positionedLines(position=1);
pos2 := positionedLines(position=2);
pos3 := positionedLines(position=3);

keyedLines1 := PROJECT(pos1, setKeyPosition(LEFT,COUNTER));
keyedLines2 := PROJECT(pos2, setKeyPosition(LEFT,COUNTER));
keyedLines3 := PROJECT(pos3, setKeyPosition(LEFT,COUNTER));

// Take the keyedLines1 and the keyedLines2 recordsets and merge their content								
 Layouts_Raw_Input.partialLine1_Layout   MergePos1Pos2(Layouts_Raw_Input.keyPositionLines l, Layouts_Raw_Input.keyPositionLines r) := transform			
			self.org_name 	        := l.lineVary[1..68];
			self.org_type 	        := l.lineVary[70..71];
			self.org_id			    := l.lineVary[73..73] + l.lineVary[75..80] ;
			self.org_type_desc		:= l.lineVary[82..103];
			self.forgn_inc_state    := l.lineVary[90..91];
			self.paid_capitol_rep   := l.lineVary[94..101];
			self.paid_capitol_mills := l.lineVary[102..102];
			self.inc_date			:= if(trim(l.lineVary[105..114],left,right) <> '',
											   l.lineVary[111..114]+l.lineVary[105..106]+l.lineVary[108..109],
											   '');
			self.status_code1		:= l.lineVary[119..121];
			self.status_code1_date	:= if(trim(l.lineVary[123..132],left,right) <> '',
											   l.lineVary[129..132]+l.lineVary[123..124]+l.lineVary[126..127],
											   '');
			self.reg_agent_name		:= r.lineVary[2..37];
			self.reg_agent_addr1	:= r.lineVary[40..71];
			self.reg_agent_city		:= r.lineVary[73..102];
			self.reg_agent_state	:= r.lineVary[105..106];
			self.reg_agent_zip		:= r.lineVary[108..117];
			self.status_code2		:= r.lineVary[119..121];
			self.status_code2_date	:= if(trim(r.lineVary[123..132],left,right) <> '',
											   r.lineVary[129..132]+r.lineVary[123..124]+r.lineVary[126..127],
											   '');
			self                    := r;
			end; 
		
 joinedLines1_2 := join(keyedLines1, keyedLines2,                                               							   							
					  left.keyValue = right.keyValue,
					  MergePos1Pos2(left,right),
					  left outer);

// Take the keyedLines1and2 and the keyedLines3 recordsets and merge their content								
 Layouts_Raw_Input.fullLine1_Layout   MergePos2Pos3(Layouts_Raw_Input.partialLine1_Layout l, Layouts_Raw_Input.keyPositionLines r) := transform			
			self          	        		:= l;			
			self.reg_agent_addr2			:= r.lineVary[40..71];
			self.most_recent_locator_number	:= r.lineVary[73..83];
			self.most_recent_form20			:= r.lineVary[85..95];
			self.status_code3				:= r.lineVary[119..121];
			self.status_code3_date			:= if(trim(r.lineVary[123..132],left,right) <> '',
													   r.lineVary[129..132]+r.lineVary[123..124]+r.lineVary[126..127],
													   '');
			end; 				

		corpsAndSummary := distribute(join(joinedLines1_2, keyedLines3,              
							left.keyValue = right.keyValue,
							MergePos2Pos3(left,right),
							left outer),hash32(org_id));
							
		//Get rid of the summary records that have mapped out to the following org_type values				 
		corpStatus01 := corpsAndSummary(trimUpper(org_type) not in[':','YP']);	
					  
		corpStatus02 := corpStatus01(trim(status_code2,left,right) <> '');
 
		corpStatus03 := corpStatus01(trim(status_code3,left,right) <> '');
		
		Corps03      	:= corpStatus03;
		mappedCorps03   := project(Corps03,CorpTransform03(left));
		
		Corps02      	:= corpStatus02;
		mappedCorps02   := project(Corps02,CorpTransform02(left));
		
		Corps01      	:= corpStatus01;
		mappedCorps01   := project(Corps01,CorpTransform01(left));
		
		cleanedCorps 	:= project(mappedCorps01,CleanCorps(left));
		
		corpsDist		:= distribute(cleanedCorps + mappedCorps02 + mappedCorps03,hash32(corp_orig_sos_charter_nbr));
		
		allCorps        := sort(corpsDist,corp_key,local);	
		
		AR01 			:= corpStatus01(org_type = '02' and (integer)trim(paid_capitol_rep,left,right) > 0 );
		mappedAR01   	:= project(AR01,ARTransform01(left));
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_wi',allCorps		,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_wi'	,mappedAR01	,ar_out		,,,pOverwrite);
                                    
		mapWI := parallel(                                                                                                                                       
			 corp_out	
			,ar_out		
   );
		
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('wi',filedate,pOverwrite := pOverwrite))
			,mapWI
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_wi')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'	,'~thor_data400::in::corp2::'+version+'::ar_wi')					  																																							  										
			)
		);      

		return result;
	end;					 
	
end; // end of WI module