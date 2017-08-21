import Address, BIPV2,Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, Bankruptcy_Attorney_Trustee;

export Build_Base(file_in, layout_out, base_name, base_file, file_out, file_type, filedate) := macro
//****************************************Clean Addresses
#uniquename (file_in_d)
%file_in_d% := distribute(file_in, hash(Address,City,State,Zipcode));

#uniquename (file_in_s)
%file_in_s% := sort(%file_in_d%, Address,City,State,Zipcode, local);

#uniquename (file_slim)
%file_slim% := project(%file_in_s% , transform(Bankruptcy_Attorney_Trustee.Layouts.layout_addr, self := left));

#uniquename (file_slim_nonblank)
%file_slim_nonblank% := %file_slim% (trim(Address,left,right) <> '' or
															trim(City,left,right)  <> '' or
	  	                                                    trim(State,left,right) <> '' or
															trim(Zipcode,left,right)   <> '');
										
#uniquename (file_slim_dedp)
%file_slim_dedp% := dedup(%file_slim_nonblank%, Address,City,State,Zipcode, local);

#uniquename (t_clean_adrr)
Bankruptcy_Attorney_Trustee.Layouts.layout_addr_clean %t_clean_adrr% (%file_slim_dedp% le) := TRANSFORM
	self.CleanAddress := Address.cleanaddress182(le.Address , le.City + ' ' + le.State + ' ' + le.Zipcode);
	self := le;
end;

#uniquename (addr_clean)
%addr_clean% := PROJECT(%file_slim_dedp%, %t_clean_adrr%(LEFT));



//****************************************Append Clean Addresses
#uniquename (t_append_addr)
layout_out %t_append_addr%(%file_in_s% le, %addr_clean%  ri) := transform
    clean_name := if(trim(le.FullName,all) <> '', Address.cleanperson73(stringlib.stringcleanspaces(le.FullName)), '');
	phone_num := stringlib.stringfindreplace(le.Phone,' ','0');
	
	self.clean_phone						:=if(stringlib.stringfindreplace(phone_num,'0','')='','',phone_num);
	self.date_first_seen 					:= stringlib.stringfindreplace(le.LastUpdated[1..10],'-','');
	self.date_last_seen						:= stringlib.stringfindreplace(le.LastUpdated[1..10],'-','');
	self.date_vendor_first_reported 		:= filedate; //Bankruptcy_Attorney_Trustee.version;
	self.date_vendor_last_reported 			:= filedate; //Bankruptcy_Attorney_Trustee.version;
	self.company_name 						:= if(trim(le.Firm, all) <> '',stringlib.StringToUpperCase(trim(le.Firm,left,right)), stringlib.StringToUpperCase(trim(le.FullName,left,right)));
	self.active_flag						:= 'Y';
	
	SELF.title       						:= clean_name[ 1.. 5];
	SELF.fname       						:= clean_name[ 6..25];
	SELF.mname       						:= clean_name[26..45];
	SELF.lname       						:= clean_name[46..65];
	SELF.name_suffix 						:= clean_name[66..70];
	SELF.name_score  						:= clean_name[71..73];
	self.prim_range							:= ri.CleanAddress[	1	..	10	];
	self.predir								:= ri.CleanAddress[	11	..	12	];
	self.prim_name							:= ri.CleanAddress[	13	..	40	];
	self.addr_suffix						:= ri.CleanAddress[	41	..	44	];
	self.postdir							:= ri.CleanAddress[	45	..	46	];
	self.unit_desig							:= ri.CleanAddress[	47	..	56	];
	self.sec_range							:= ri.CleanAddress[	57	..	64	];
	self.p_city_name						:= ri.CleanAddress[	65	..	89	];
	self.v_city_name						:= ri.CleanAddress[	90	..	114	];
	self.st									:= ri.CleanAddress[	115	..	116	];
	self.zip								:= ri.CleanAddress[	117	..	121	];
	self.zip4								:= ri.CleanAddress[	122	..	125	];
	self.cart								:= ri.CleanAddress[	126	..	129	];
	self.cr_sort_sz							:= ri.CleanAddress[	130	..	130	];
	self.lot								:= ri.CleanAddress[	131	..	134	];
	self.lot_order							:= ri.CleanAddress[	135	..	135	];
	self.dbpc								:= ri.CleanAddress[	136	..	137	];
	self.chk_digit							:= ri.CleanAddress[	138	..	138	];
	self.rec_type							:= ri.CleanAddress[	139	..	140	];
	self.fips_county						:= ri.CleanAddress[	141	..	142	];
	self.county								:= ri.CleanAddress[	143	..	145	];
	self.geo_lat							:= ri.CleanAddress[	146	..	155	];
	self.geo_long							:= ri.CleanAddress[	156	..	166	];
	self.msa								:= ri.CleanAddress[	167	..	170	];
	self.geo_blk							:= ri.CleanAddress[	171	..	177	];
	self.geo_match							:= ri.CleanAddress[	178	..	178	];
	self.err_stat							:= ri.CleanAddress[	179	..	182	];
	self := le;
end;
#uniquename (file_appended)
%file_appended% := join(%file_in_s% , %addr_clean%, 
						left.Address = right.Address and
						left.City = right.City and
						left.State = right.State and
						left.Zipcode = right.Zipcode,
						%t_append_addr% (left, right), left outer, local);

						
//****************************************Append Did
#uniquename (Did_Matchset)
		%Did_Matchset%:= ['A','P'];
#uniquename (dDidOut)
		DID_Add.MAC_Match_Flex(
			 %file_appended%							// Input Dataset
			,%Did_Matchset%             				// Did_Matchset  what fields to match on
			,''                						// ssn
			,''                 					// dob
			,fname									// fname
			,mname			     					// mname
			,lname			     					// lname
			,name_suffix     						// name_suffix
			,prim_range	          					// prim_range
			,prim_name	          					// prim_name
			,sec_range	          					// sec_range
			,zip				          			// zip5
			,st			          					// state
			,phone			          				// phone10
			,did                      				// Did
			,layout_out	 							// output layout
			,TRUE                     				// Does output record have the score
			,did_score                				// did score field
			,75                       				// score threshold
			,%dDidOut%								// output dataset			
		);   
		

//****************************************Append Bdid
#uniquename (BDID_Matchset)		
		%BDID_Matchset% := ['A','P'];
		
#uniquename (dBdidOut)	
		Business_Header_SS.MAC_Add_BDID_Flex(
			 %dDidOut%						  // Input Dataset						
			,%BDID_Matchset%                        // BDID Matchset what fields to match on           
			,company_name	                        // company_name	              
			,prim_range		                        // prim_range		              
			,prim_name		                        // prim_name		              
			,zip					                // zip5					              
			,sec_range		                        // sec_range		              
			,st				                    	// state				              
			,phone				                    // phone				              
			,fein_not_used                          // fein              
			,bdid								    // bdid												
			,layout_out           					// Output Layout 
			,true                                 // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,%dBdidOut%                              // Output Dataset
			,																	// deafult threscold
			,																	// use prod version of superfiles
			,																	// default is to hit prod from dataland, and on prod hit prod.		
			,bipv2.xlink_version_set					// boolean indicator set to create bdid's & xlinkids
			,																	// url
			,																	// email 
			,p_city_name											// city
			,fname														// fname
			,mname														// mname
			,lname														// lname			
		);             
		
	

//****************************************Rollup to eliminate duplicated records
#uniquename (base_file_reset)
%base_file_reset% := project(base_file, transform(layout_out, self.active_flag := '', self := left)); 

#uniquename (file_all)	
%file_all% := if(nothor(FileServices.GetSuperFileSubCount(base_name) = 0), %dBdidOut%, %dBdidOut% + %base_file_reset%);
#uniquename (file_all_d)
%file_all_d%  := distribute(%file_all% (company_name <> '' and trim(prim_range + prim_name, left, right) <> ''), hash64(did, bdid, firm));
#uniquename (file_all_s )
#if(file_type = 'attorney')
%file_all_s% := sort(%file_all_d%,
						UltID,
						OrgID,
						SELEID,
						ProxID,
						POWID,
						EmpID,
						DotID,
						did,
						bdid,
						firm,
						fullname,
						email,
						fax,
						clean_phone,
						prim_range,
						predir,
						prim_name,
						addr_suffix,
						postdir,
						sec_range,
						p_city_name,
						v_city_name,
						st,
						zip,
						zip4,
							-date_last_seen,
							-LastUpdated,
							local);
#end
#if(file_type = 'trustee')
%file_all_s% := sort(%file_all_d%, 
						UltID,
						OrgID,
						SELEID,
						ProxID,
						POWID,
						EmpID,
						DotID,
						did,
						bdid,
						firm,
						fullname,						
						email,
						clean_phone,
						prim_range,
						predir,
						prim_name,
						addr_suffix,
						postdir,
						sec_range,
						p_city_name,
						v_city_name,
						st,
						zip,
						zip4,
							-date_last_seen,
							-LastUpdated,
					    local);				
					
#end
#uniquename (t_rollup)
layout_out %t_rollup% (%file_all_s% le, %file_all_s% ri) := transform
	 self.date_first_seen := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
	 self.date_last_seen :=  (string8)ut.max2((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
	 self.date_vendor_first_reported := (string8)ut.min2((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
	 self.date_vendor_last_reported := (string8) ut.max2((unsigned)le.date_vendor_last_reported, (unsigned)ri.date_vendor_last_reported);
	 self.LastUpdated:= if(le.LastUpdated > ri.LastUpdated, le.LastUpdated , ri.LastUpdated);
	 self.active_flag:= if(le.active_flag = 'Y', le.active_flag, ri.active_flag);
	 self := le;
  
end;

#if(file_type = 'attorney') 
file_out := rollup(%file_all_s% , 
					%t_rollup%(left, right), 
					except  LastUpdated ,
								  date_first_seen,
									date_last_seen, 
									date_vendor_first_reported, 
									date_vendor_last_reported,
									active_flag,
									UltScore,
									OrgScore,
									SELEScore,
									ProxScore,
									POWScore,
									EmpScore,
									DotScore,
									UltWeight,
									OrgWeight,
									SELEWeight,
									ProxWeight,
									POWWeight,
									EmpWeight,
									DotWeight,									
									name_score,
									did_score,
									bdid_score,									
									phone,
									title,
									fname,
									mname,
									lname,
									name_suffix,
									company_name,
									address,
									city,
									state,
									zipcode,
								  unit_desig,									
									Country, 
									cart,
									cr_sort_sz,
									lot,
									lot_order,
									dbpc,
									chk_digit,
									rec_type,
									fips_county,
									county,
									geo_lat,
									geo_long,
									msa,
									geo_blk,
									geo_match,
									err_stat,
									local);
#end

#if(file_type = 'trustee') 
file_out := rollup(%file_all_s% , 
					%t_rollup%(left, right), 
					except LastUpdated ,
								  date_first_seen,
									date_last_seen, 
									date_vendor_first_reported, 
									date_vendor_last_reported,
									active_flag,
									UltScore,
									OrgScore,
									SELEScore,
									ProxScore,
									POWScore,
									EmpScore,
									DotScore,
									UltWeight,
									OrgWeight,
									SELEWeight,
									ProxWeight,
									POWWeight,
									EmpWeight,
									DotWeight,									
									name_score, 
									did_score, 
									bdid_score,									
									phone,
									title,
									fname,
									mname,
									lname,
									name_suffix,
									company_name,
									address,
									city,
									state,
									zipcode,
								  unit_desig,									
									cart,
									cr_sort_sz,
									lot,
									lot_order,
									dbpc,
									chk_digit,
									rec_type,
									fips_county,
									county,
									geo_lat,
									geo_long,
									msa,
									geo_blk,
									geo_match,
									err_stat,
									local);
																
#end
endmacro;