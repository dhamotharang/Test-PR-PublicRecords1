import fieldstats, business_header, business_header_ss, did_add, didville, fair_isaac, ut, census_data, 
STRATA, ngadl, header, mdr, MDR, BIPV2;

export proc_build_base(string filedate) := 
function

df := DEA.file_DEA_In;

//Rollup the input file to get rid of duplicates
df RollupDEA(df L, df R) := TRANSFORM
  SELF.date_first_reported          := (STRING8)ut.EarliestDate( ut.EarliestDate( (INTEGER)L.date_first_reported, (INTEGER)R.date_first_reported ),
                                                        ut.EarliestDate( (INTEGER)L.date_last_reported,  (INTEGER)R.date_last_reported ));
	SELF.date_last_reported           := (STRING8)ut.LatestDate( (INTEGER)L.date_last_reported, (INTEGER)R.date_last_reported );
	SELF.Address1                     := ut.fnTrim2Upper(L.Address1);	
	SELF.Address2                     := ut.fnTrim2Upper(L.Address2);	
	SELF.Address3                     := ut.fnTrim2Upper(L.Address3);	
	SELF.Address4                     := ut.fnTrim2Upper(L.Address4);	
	SELF.Address5                     := ut.fnTrim2Upper(L.Address5);	
	SELF.Drug_Schedules               := ut.fnTrim2Upper(L.Drug_Schedules);	
	SELF.State                        := ut.fnTrim2Upper(L.State);	
	SELF.Zip_Code                     := ut.fnTrim2Upper(L.Zip_Code);	
	SELF.cname                        := ut.fnTrim2Upper(L.cname);	
  SELF                              := L;
END;

df_dist   := DISTRIBUTE(df, HASH(Dea_Registration_Number));
df_sort   := SORT(df_dist, Dea_Registration_Number, Business_activity_code, Drug_Schedules, Expiration_Date, 
                  -date_last_reported, Address1, Address2, Address3, Address4, Address5, State, Zip_Code, Bus_Activity_Sub_Code, 
                  Exp_of_Payment_Indicator, title, fname, mname, lname, name_suffix, cname, LOCAL);

df_Rollup := ROLLUP(df_sort,
                    TRIM(LEFT.Dea_Registration_Number,LEFT,RIGHT)  = TRIM(RIGHT.Dea_Registration_Number,LEFT,RIGHT) AND
   									ut.fnTrim2Upper(LEFT.Business_activity_code)   = ut.fnTrim2Upper(RIGHT.Business_activity_code) AND
										ut.fnTrim2Upper(LEFT.Drug_Schedules)           = ut.fnTrim2Upper(RIGHT.Drug_Schedules) AND
										ut.fnTrim2Upper(LEFT.Expiration_Date)          = ut.fnTrim2Upper(RIGHT.Expiration_Date) AND
										ut.fnTrim2Upper(LEFT.Address1)                 = ut.fnTrim2Upper(RIGHT.Address1) AND
										ut.fnTrim2Upper(LEFT.Address2)                 = ut.fnTrim2Upper(RIGHT.Address2) AND
										ut.fnTrim2Upper(LEFT.Address3)                 = ut.fnTrim2Upper(RIGHT.Address3) AND
									  ut.fnTrim2Upper(LEFT.Address4)                 = ut.fnTrim2Upper(RIGHT.Address4) AND
										ut.fnTrim2Upper(LEFT.Address5)                 = ut.fnTrim2Upper(RIGHT.Address5) AND
										ut.fnTrim2Upper(LEFT.State)                    = ut.fnTrim2Upper(RIGHT.State) AND
										ut.fnTrim2Upper(LEFT.Zip_Code)                 = ut.fnTrim2Upper(RIGHT.Zip_Code) AND
										ut.fnTrim2Upper(LEFT.Bus_Activity_Sub_Code)    = ut.fnTrim2Upper(RIGHT.Bus_Activity_Sub_Code) AND
										ut.fnTrim2Upper(LEFT.Exp_of_Payment_Indicator) = ut.fnTrim2Upper(RIGHT.Exp_of_Payment_Indicator) AND
										ut.fnTrim2Upper(LEFT.title)                    = ut.fnTrim2Upper(RIGHT.title) AND
										ut.fnTrim2Upper(LEFT.fname)                    = ut.fnTrim2Upper(RIGHT.fname) AND
										ut.fnTrim2Upper(LEFT.mname)                    = ut.fnTrim2Upper(RIGHT.mname) AND
										ut.fnTrim2Upper(LEFT.lname)                    = ut.fnTrim2Upper(RIGHT.lname) AND
										ut.fnTrim2Upper(LEFT.name_suffix)              = ut.fnTrim2Upper(RIGHT.name_suffix) AND
										ut.fnTrim2Upper(LEFT.cname)                    = ut.fnTrim2Upper(RIGHT.cname),
										RollupDEA(LEFT, RIGHT), 					                              	
										LOCAL);
                    
fieldstats.mac_stat_file(df_Rollup,pre,'DEA',50,6,false,
		                     Dea_Registration_Number,'string','M',
		                     Expiration_Date,'string','M',
		                     Drug_Schedules,'string','M',
		                     prim_name,'string','M',
		                     lname,'string','M',
		                     cname,'string','M')

dfseq := record
	df_Rollup;
	unsigned4 seq;
  unsigned8 source_rec_id := 0;  	           //Added for BIP project
end;

//Add the new source_rec_id's and seq
dfseq into_seq(df L,integer C) := transform
	self.seq := C;
  self.source_rec_id := HASH64( ut.fnTrim2Upper(L.Dea_Registration_Number) +
																ut.fnTrim2Upper(L.Business_activity_code) +
																ut.fnTrim2Upper(L.Drug_Schedules) +
																ut.fnTrim2Upper(L.Expiration_Date) +
																ut.fnTrim2Upper(L.Address1) +
																ut.fnTrim2Upper(L.Address2) +
																ut.fnTrim2Upper(L.Address3) +
																ut.fnTrim2Upper(L.Address4) +
																ut.fnTrim2Upper(L.Address5) +
																ut.fnTrim2Upper(L.State) +
																ut.fnTrim2Upper(L.Zip_Code) +
																ut.fnTrim2Upper(L.Bus_Activity_Sub_Code) +
																ut.fnTrim2Upper(L.Exp_of_Payment_Indicator) +
																ut.fnTrim2Upper(L.title) +
																ut.fnTrim2Upper(L.fname) +
																ut.fnTrim2Upper(L.mname) +
																ut.fnTrim2Upper(L.lname) +
																ut.fnTrim2Upper(L.name_suffix) +
																ut.fnTrim2Upper(L.cname) );  
	self := L;
end;

df2 := distribute(project(df_Rollup,into_seq(LEFT,COUNTER)), hash(Seq))
    : PERSIST('~thor_data400::persist::DEA::proc_build_base::seq');
 
didville.Layout_Did_InBatch into(df2 L) := transform
	self.title := L.title;
	self.fname := L.fname;
	self.mname := L.mname;
	self.lname := L.lname;
	self.suffix := L.name_suffix;
	self.ssn := '';
	self.dob := '';
	self.phone10 := '';
	self.z5 := L.zip;
	self.seq := L.seq;
	self := L;
end;

df3 := project(df2,into(LEFT));

did_add.Mac_Match_Fast_Roxie(df3,outf1)

temprec := record
	outf1;
	string50	cname := '';
	string9		dea_registration_number := '';
	unsigned6	bdid := 0;
  BIPV2.IDlayouts.l_xlink_ids;		           //Added for BIP project
  unsigned8 source_rec_id := 0;  	           //Added for BIP project
  string2 source := MDR.sourceTools.src_DEA; //Added for BIP project
end;

temprec into_temp(outf1 L, df2 R) := transform
	self.cname := R.cname;
	self.dea_registration_number := R.dea_registration_number;
	self := L;
end;

df4 := join(distribute(outf1, hash(seq)), 
		  df2,
			left.seq = right.seq,
		  into_temp(LEFT,RIGHT),local);

df5 := df4(cname != '');
outf2 := df4(cname = '');

business_header.MAC_Source_Match(df5,outf3,
					false,bdid,
					false,MDR.sourceTools.src_Dea,
					false,foo,
					cname,
					prim_Range,prim_Name,sec_range,z5,
					false,foo,
					false,foo);
				
myset := ['A'];
				 
business_header_ss.MAC_Add_BDID_FLEX(
			 outf3 															// input dataset						
			,myset				                			// bdid matchset what fields to match on           
			,cname	                        		// company_name	              
			,prim_range		                  		// prim_range		              
			,prim_name		                    	// prim_name		              
			,z5					                    		// zip5					              
			,sec_range		                    	// sec_range		              
			,st				        		          		// state				              
			,foo						                  	// phone				              
			,foo            			           	  // fein              
			,bdid										        		// bdid												
			,temprec														// output layout 
			,false                              // output layout has bdid score field? 																	
			,foo                     						// bdid_score                 
			,outf4				          						// output dataset
			,																		// default threshold
			,																		// use prod version of superfiles
			,																		// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set						// create BIP keys only
			,																		// url
			,																		// email 
			,p_city_name												// city
			,fname															// fname
			,mname															// mname
			,lname															// lname
      ,					                          // Contact_SSN
      ,source				                      // Source – MDR.sourceTools
      ,source_rec_id			                // Source_Reccord_Id
      ,true				                        // Src_Matching_is_priorty
		);						
					
outf := outf2 + outf4;

outrec := dea.layout_dea_out_base;

outrec finalize(outf L, df2 R) := transform
	self.best_ssn      := if (L.score < 70,'',L.best_ssn);
	self.did           := if(L.did!=0 and l.score >= 70,intformat(L.did,12,1),'');
	self.score         := intformat(L.score,3,1);
	self.bdid          := if (L.bdid = 0, '', intformat(L.bdid,12,1));
  self.DotID         := L.DotID;
  self.DotScore      := L.DotScore;
  self.DotWeight     := L.DotWeight;
  self.EmpID         := L.EmpID;
  self.EmpScore      := L.EmpScore;
  self.EmpWeight     := L.EmpWeight;
  self.POWID         := L.POWID;
  self.POWScore      := L.POWScore;
  self.POWWeight     := L.POWWeight;
  self.ProxID        := L.ProxID;
  self.ProxScore     := L.ProxScore;
  self.ProxWeight    := L.ProxWeight;
  self.SELEID        := L.SELEID;
  self.SELEScore     := L.SELEScore;
  self.SELEWeight    := L.SELEWeight;
  self.OrgID         := L.OrgID;
  self.OrgScore      := L.OrgScore;
  self.OrgWeight     := L.OrgWeight;
  self.UltID         := L.UltID;
  self.UltScore      := L.UltScore;
  self.UltWeight     := L.UltWeight;
  self.source_rec_id := L.source_rec_id;
	self := R;
end;

pre_outfinal := join(distribute(outf,hash(seq)),
				             df2,
					           left.seq = right.seq,
				             finalize(LEFT,RIGHT),local);

pre_outfinal getCounty(pre_outfinal L, census_data.File_Fips2County  R) := transform
	self.county_Name := R.county_name;
	self := L;
end;

outfinal := join(pre_outfinal,
			           census_data.File_Fips2County,
				         left.county = right.county_fips and
				         left.state = right.state_code,
			           getCounty(LEFT,RIGHT),left outer, lookup);

ut.MAC_SF_BuildProcess(outfinal,'~thor_data400::base::dea',writejob)

STRATA.CreateAsHeaderStats(DEA.DEA_as_header(DEA.file_dea_modified),
													 'DEA Controlled Substances',
													 'data',
													 filedate,
													 '',
													 runAsHeaderStats); 
						  
STRATA.CreateAsBusinessHeaderStats(DEA.fDEA_As_Business_Header(DEA.file_dea_modified),
                                   'DEA Controlled Substances',
																	 'data',
																	 filedate,
																	 '',
                                   runAsBusinessHeaderStats);

f := fileservices.sendemail('asiddique@seisint.com;djustin@seisint.com','DEA FieldPop Stats',
                            'Finished DEA Build ' + ut.getDate +  '\r\n \r\n ' +
			                      'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + 
                            workunit + '\r\n');

result := sequential( pre
									   ,writejob
									   ,parallel(dea.Out_Base_Stats_Population(filedate)
									   ,runAsHeaderStats
										 ,runAsBusinessHeaderStats)
										 ,f); 
return result;

end;