import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;
EXPORT Update_Base (string filedate, boolean pUseProd = false) := function
std_input := thrive.StandardizeInputFile(filedate, pUseProd);
//clean name
NID.Mac_CleanParsedNames(std_input, cleanNames
													, firstname:=orig_fname,middlename:=orig_mname,lastname:=orig_lname
													, includeInRepository:=true, normalizeDualNames:=false, useV2 := true
												);

//clean address

cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string orig_addr1, string orig_addr2},
																		self.orig_addr1 := stringlib.stringfilterout(left.orig_addr,'.^!$+<>@=%?*\''),			
																		self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																					trim(left.orig_city)
																					+ if(left.orig_city <> '',',','')
																					+ ' '+ left.orig_state
																					+ ' '+ if(length(trim(left.orig_zip5[..5],all)) = 5,
																										left.orig_zip5[..5],''))
																										,left,right),
																		self := left));			
																					
																			
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(cleanNames_t,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

Layouts.base tr(cleanAddr l) := TRANSFORM
	self.title := l.cln_title;
	self.fname := l.cln_fname;
	self.mname := l.cln_mname;
	self.lname := l.cln_lname;
	self.name_suffix := l.cln_suffix;
	self.RawAID     := l.aidwork_rawaid;
	self.ACEAID			:= l.	aidwork_acecache.aid;
	self.prim_range := stringlib.stringfilterout(l.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
	self.zip        := l.aidwork_acecache.zip5;
	self.fips_st    := l.aidwork_acecache.county[1..2];
	self.fips_county:= l.aidwork_acecache.county[3..5];
	self.msa        := if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
	self            := l.aidwork_acecache;
	self            := l;
END;

cleanAdd_t := project(cleanAddr,tr(left));

//Add to previous base
base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).lBaseTemplate_built)) = 0
											 ,cleanAdd_t
											 ,cleanAdd_t + thrive.Files(filedate, pUseProd).base.built);

new_base_d := distribute(base_and_update, hash(orig_Fname,orig_Lname,orig_Addr,orig_Zip5,employer,income));  
new_base_s := sort(new_base_d,
									orig_Fname,						//	LT & PD
									orig_Lname,						//	LT & PD
									orig_Zip5,							//	LT & PD
									Employer,					//	LT & PD
									Income,						//	LT & PD									
									orig_Addr,							//	LT & PD
									orig_City,							//	LT & PD
									orig_State,						//	LT & PD
									orig_Mname,						//	PD	
									orig_Zip4,							//	LT & PD
									Email,						//	LT & PD
									Pay_Frequency,		//	LT & PD
									Phone_Work,				//	LT & PD
									Phone_Home,				//	PD
									Phone_Cell,				//	PD
									DOB,							//	PD
									MonthsEmployed,		//	PD
									Own_Home,					//	PD
									Is_Military,			//	PD		
									Drvlic_State,			//	PD	
									MonthsAtBank,			//	PD
									IP,								//	PD
									YrsThere,					//	LT
									BestTime,					//	LT
									Credit,						//	LT
									LoanAmt,					//	LT
									LoanType,					//	LT
									RateType,					//	LT
									MortRate,					//	LT	
									LTV,							//	LT
									PropertyType,			//	LT
									-dt_last_seen, 
									-dt_vendor_last_reported,
									local);
						
Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
	self.dt_first_seen            := ut.EarliestDate (le.dt_first_seen, ri.dt_first_seen);
	self.dt_last_seen             := MAX(le.dt_last_seen, ri.dt_last_seen);
	self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
	self.dt_vendor_last_reported  := MAX(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
	self.persistent_record_id     := if(le.persistent_record_id < ri.persistent_record_id,le.persistent_record_id, ri.persistent_record_id); 
	self.did 					:= 0;
	self.bdid 				:= 0;
	self.DotID				:=	0;
	self.DotScore			:=	0;
	self.DotWeight		:=	0;
	self.EmpID				:=	0;
	self.EmpScore			:=	0;
	self.EmpWeight		:=	0;
	self.POWID				:=	0;
	self.POWScore			:=	0;
	self.POWWeight		:=	0;
	self.ProxID				:=	0;
	self.ProxScore		:=	0;
	self.ProxWeight		:=	0;
	self.SELEID				:=	0;
	self.SELEScore		:=	0;
	self.SELEWeight		:=	0;
	self.OrgID				:=	0;
	self.orgScore			:=	0;
	self.OrgWeight		:=	0;
	self.UltID				:=	0;
	self.UltScore			:=	0;
	self.UltWeight		:=	0; 
	self 							:= le;
end;

thrive_base := rollup(new_base_s,
									left.orig_Fname = right.orig_Fname						//	LT & PD
						  and left.orig_Lname = right.orig_Lname						//	LT & PD
						  and left.orig_Zip5 = right.orig_Zip5							//	LT & PD
						  and left.Employer = right.Employer					//	LT & PD
						  and left.Income = right.Income					//	LT & PD									
						  and left.orig_Addr = right.orig_Addr							//	LT & PD
						  and left.orig_City = right.orig_City							//	LT & PD
						  and left.orig_State = right.orig_State						//	LT & PD
						  and left.orig_Mname = right.orig_Mname						//	PD	
						  and left.orig_Zip4 = right.orig_Zip4							//	LT & PD
						  and left.Email = right.Email						//	LT & PD
						  and left.Pay_Frequency = right.Pay_Frequency		//	LT & PD
						  and left.Phone_Work = right.Phone_Work				//	LT & PD
						  and left.Phone_Home = right.Phone_Home				//	PD
						  and left.Phone_Cell = right.Phone_Cell				//	PD
						  and left.DOB = right.DOB							//	PD
						  and left.MonthsEmployed = right.MonthsEmployed		//	PD
						  and left.Own_Home = right.Own_Home					//	PD
						  and left.Is_Military = right.Is_Military			//	PD		
						  and left.Drvlic_State = right.Drvlic_State			//	PD	
						  and left.MonthsAtBank = right.MonthsAtBank			//	PD
						  and left.IP = right.IP								//	PD
						  and left.YrsThere = right.YrsThere					//	LT
						  and left.BestTime = right.BestTime					//	LT
						  and left.Credit = right.Credit						//	LT
						  and left.LoanAmt = right.LoanAmt					//	LT
						  and left.LoanType = right.LoanType					//	LT
						  and left.RateType = right.RateType					//	LT
						  and left.MortRate = right.MortRate					//	LT	
						  and left.LTV = right.LTV							//	LT
						  and left.PropertyType = right.PropertyType			//	LT
																	,t_rollup(left, right)
																	,local);

//Norm phones
phone_norm_layout := record
Layouts.base;
string10 phone;
end;

norm := project(thrive_base, transform(phone_norm_layout, self.phone := left.clean_phone_work, self := left)) +
				project(thrive_base, transform(phone_norm_layout, self.phone := left.clean_phone_home, self := left)) (clean_phone_home <> '') +
				project(thrive_base, transform(phone_norm_layout, self.phone := left.clean_phone_cell, self := left)) (clean_phone_cell <> '');																						


//DID

matchset := ['A','Z','D','P'];
did_add.MAC_Match_Flex
	(norm, matchset,					
	 foo,clean_dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone, 
	 DID, phone_norm_layout, true, did_score,
	 75, d_did,true, src);
	 
//BDID
BDID_Matchset := ['A','P']; /* Match on Address and Phone */
      Business_Header_SS.MAC_Add_BDID_Flex(
				d_did 								// Input Dataset                 
				,BDID_Matchset				// BDID Matchset what fields to match on           
				,employer							// company_name                 
				,prim_range						// prim_range
				,prim_name						// prim_name
				,zip									// zip5
				,sec_range						// sec_range
				,st										// state
        ,phone								// phone                      
        ,''										// fein              
        ,bdid									// bdid                                    
        ,phone_norm_layout		// Output Layout 
        ,true									// output layout has bdid score field?                       
        ,bdid_score						// bdid_score                 
        ,dBdidOut							// Output Dataset
				,
				,											// default to use prod version of superfiles
				,											// default is to hit prod from dataland, and on prod hit prod.
				,BIPV2.xlink_version_set 
				,
				,
				,
				,fname
				,mname
				,lname
				);										 

dids_bdids  := project(dedup(sort(distribute(dBdidOut, hash(persistent_record_id)),persistent_record_id,-did, -bdid, -proxScore,-proxweight, local), persistent_record_id, local),Layouts.base);

return dids_bdids;
end;