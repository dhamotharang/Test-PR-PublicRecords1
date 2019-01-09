Import fieldstats, business_header, business_header_ss, did_add, didville, ut, census_data, 
STRATA, header, MDR, BIPV2,Health_Provider_Services, DEA, std, promotesupers;

#stored('did_add_force','thor');

Export proc_build_base(String filedate) := Function

df	:=	DEA.Proc_Build_Preprocess(filedate);

//Rollup the input file to get rid of duplicates
//Bug 102042 removed clean name fields from the rollup to prevent duplications caused by changes to name cleaner
df RollupDEA(df L, df R) := TRANSFORM
  Self.date_first_reported          := (String8)ut.EarliestDate( ut.EarliestDate( (Integer)L.date_first_reported, (Integer)R.date_first_reported ),
                                                        ut.EarliestDate( (Integer)L.date_last_reported,  (Integer)R.date_last_reported ));
	Self.date_last_reported         := (String8)max( (Integer)L.date_last_reported, (Integer)R.date_last_reported );
	Self.Address1                     	:= ut.CleanSpacesAndUpper(L.Address1);	
	Self.Address2                     	:= ut.CleanSpacesAndUpper(L.Address2);	
	Self.Address3                     	:= ut.CleanSpacesAndUpper(L.Address3);	
	Self.Address4                    	:= ut.CleanSpacesAndUpper(L.Address4);	
	Self.Address5                     	:= ut.CleanSpacesAndUpper(L.Address5);	
	Self.Drug_Schedules              := ut.CleanSpacesAndUpper(L.Drug_Schedules);	
	Self.State                        		:= ut.CleanSpacesAndUpper(L.State);	
	Self.Zip_Code                     	:= ut.CleanSpacesAndUpper(L.Zip_Code);	
	Self.cname                        		:= ut.CleanSpacesAndUpper(L.cname);	
	Self                              			:= L;
End;

df_dist   := DISTRIBUTE(df, HASH(Dea_Registration_Number));
df_sort   := SORT(df_dist, Dea_Registration_Number, Business_activity_code, Drug_Schedules, Expiration_Date, 
                  Address1, Address2, Address3, Address4, Address5, State, Zip_Code, Bus_Activity_Sub_Code, 
                  Exp_of_Payment_Indicator, -date_last_reported, /*title, fname, mname, lname, cname,*/ LOCAL);

df_Rollup := ROLLUP(df_sort,
                    TRIM(LEFT.Dea_Registration_Number,LEFT,RIGHT)  = TRIM(RIGHT.Dea_Registration_Number,LEFT,RIGHT) AND
										ut.CleanSpacesAndUpper(LEFT.Business_activity_code)			= ut.CleanSpacesAndUpper(RIGHT.Business_activity_code) AND
										ut.CleanSpacesAndUpper(LEFT.Drug_Schedules)						= ut.CleanSpacesAndUpper(RIGHT.Drug_Schedules) AND
										ut.CleanSpacesAndUpper(LEFT.Expiration_Date)						= ut.CleanSpacesAndUpper(RIGHT.Expiration_Date) AND
										ut.CleanSpacesAndUpper(LEFT.Address1)									= ut.CleanSpacesAndUpper(RIGHT.Address1) AND
										ut.CleanSpacesAndUpper(LEFT.Address2)									= ut.CleanSpacesAndUpper(RIGHT.Address2) AND
										ut.CleanSpacesAndUpper(LEFT.Address3)									= ut.CleanSpacesAndUpper(RIGHT.Address3) AND
										ut.CleanSpacesAndUpper(LEFT.Address4)									= ut.CleanSpacesAndUpper(RIGHT.Address4) AND
										ut.CleanSpacesAndUpper(LEFT.Address5)									= ut.CleanSpacesAndUpper(RIGHT.Address5) AND
										ut.CleanSpacesAndUpper(LEFT.State)											= ut.CleanSpacesAndUpper(RIGHT.State) AND
										ut.CleanSpacesAndUpper(LEFT.Zip_Code)									= ut.CleanSpacesAndUpper(RIGHT.Zip_Code) AND
										ut.CleanSpacesAndUpper(LEFT.Bus_Activity_Sub_Code)			= ut.CleanSpacesAndUpper(RIGHT.Bus_Activity_Sub_Code) AND
										ut.CleanSpacesAndUpper(LEFT.Exp_of_Payment_Indicator)	= ut.CleanSpacesAndUpper(RIGHT.Exp_of_Payment_Indicator) ,
										RollupDEA(LEFT, RIGHT), 					                              	
										LOCAL);

fieldstats.mac_stat_file(df_Rollup,pre,'DEA',50,6,false,
		                     Dea_Registration_Number,'String','M',
		                     Expiration_Date,'String','M',
		                     Drug_Schedules,'String','M',
		                     prim_name,'String','M',
		                     lname,'String','M',
		                     cname,'String','M');

dfseq := record
	unsigned8 	did									:= 0;
	unsigned1 	did_score						:= 0;
	integer2		xadl2_weight 				:= 0;
	unsigned2		xadl2_score	 				:= 0;
	integer1		xadl2_distance			:= 0;
	unsigned4		xadl2_keys_used			:= 0;
	string			xadl2_keys_desc			:= '';
	string60		xadl2_matches				:= '';
	string			xadl2_matches_desc	:= '';
	string9 		best_ssn						:= '';
	Unsigned6		bdid 								:= 0;
	df_Rollup;
	BIPV2.IDlayouts.l_xlink_ids;		   	//Added for BIP project
	String2 src := MDR.sourceTools.src_DEA;             		 	//Added for BIP project
	String2 source := MDR.sourceTools.src_DEA;             		 	//Added for BIP project
  Unsigned8 source_rec_id := 0;  	           //Added for BIP project
End;


//Add the new source_rec_id's and seq
//Bug 102042 removed clean name fields from source_rec_id to keep a consiste value unaffected by changes to name cleaner

dfseq into_seq(df L) := transform
	Self.source_rec_id := HASH64( ut.CleanSpacesAndUpper(L.Dea_Registration_Number) +
																ut.CleanSpacesAndUpper(L.Business_activity_code) +
																ut.CleanSpacesAndUpper(L.Drug_Schedules) +
																ut.CleanSpacesAndUpper(L.Expiration_Date) +
																ut.CleanSpacesAndUpper(L.Address1) +
																ut.CleanSpacesAndUpper(L.Address2) +
																ut.CleanSpacesAndUpper(L.Address3) +
																ut.CleanSpacesAndUpper(L.Address4) +
																ut.CleanSpacesAndUpper(L.Address5) +
																ut.CleanSpacesAndUpper(L.State) +
																ut.CleanSpacesAndUpper(L.Zip_Code) +
																ut.CleanSpacesAndUpper(L.Bus_Activity_Sub_Code) +
																ut.CleanSpacesAndUpper(L.Exp_of_Payment_Indicator)
																);
								// Self.did := (unsigned8)L.did;
								// Self.bdid := (unsigned6)L.bdid;
								Self := L;
								Self := [];
				End;

df2 := project(df_Rollup,into_seq(LEFT))
    : PERSIST('~thor_data400::persist::DEA::proc_build_base::seq');
 
d_ :=df2  (fname<>'' and lname<>'' and prim_name<>'') ;
d__:=df2(~(fname<>'' and lname<>'' and prim_name<>''));

matchset := ['N','A'];
did_add.MAC_Match_Flex
	(d_, matchset,					
	 '','', fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 DID, dfseq, true, did_score,
	 75, d1,true,src);
	 
did_desc1 := project (d1,transform (recordof(df2), 
                       self.xadl2_keys_desc := InsuranceHeader_xLink.Process_xIDL_Layouts(false).KeysUsedToText (left.xadl2_keys_used); 
                       self.xadl2_matches_desc := InsuranceHeader_xLink.fn_MatchesToText(left.xadl2_matches);
                       self := left;));	 

outf1:=did_desc1 + d__ ;

did_add.MAC_Add_SSN_By_DID(outf1,did,best_ssn,df4);

df5 := df4(cname != '');
outf2 := df4(cname = '');

business_header.MAC_Source_Match(df5,outf3,
					false,bdid,
					false,MDR.sourceTools.src_Dea,
					false,foo,
					cname,
					prim_Range,prim_Name,sec_range,zip,
					false,foo,
					false,foo);

myset := ['A'];
				 
business_header_ss.MAC_Add_BDID_FLEX(
								outf3									// input dataset						
								,myset									// bdid matchset what fields to match on           
								,cname								// company_name	              
								,prim_range						// prim_range		              
								,prim_name						// prim_name		              
								,zip										// zip5					              
								,sec_range							// sec_range		              
								,st										// state				              
								,foo										// phone				              
								,foo										// fein              
								,bdid									// bdid												
								,dfseq								// output layout 
								,false									// output layout has bdid score field? 																	
								,foo										// bdid_score                 
								,outf4									// output dataset
								,											// default threshold
								,											// use prod version of superfiles
								,											// default is to hit prod from dataland, and on prod hit prod.		
								,BIPV2.xlink_version_set	// create BIP keys only
								,											// url
								,											// email 
								,p_city_name						// city
								,fname								// fname
								,mname								// mname
								,lname								// lname
								,											// Contact_SSN
								,source								// Source MDR.sourceTools
								,source_rec_id					// Source_Reccord_Id
								,true									// Src_Matching_is_priorty
);						
					
outf := outf2 + outf4;

outrec := dea.layout_dea_out_basev2;

outrec finalize(outf L) := transform
			Self.did           := if(L.did!=0 ,intformat(L.did,12,1),'');
			Self.score         := intformat(L.did_score,3,1);
			Self.bdid          := if (L.bdid = 0, '', intformat(L.bdid,12,1));
			Self.DotID         := L.DotID;
			Self.DotScore      := L.DotScore;
			Self.DotWeight     := L.DotWeight;
			Self.EmpID         := L.EmpID;
			Self.EmpScore      := L.EmpScore;
			Self.EmpWeight     := L.EmpWeight;
			Self.POWID         := L.POWID;
			Self.POWScore      := L.POWScore;
			Self.POWWeight     := L.POWWeight;
			Self.ProxID        := L.ProxID;
			Self.ProxScore     := L.ProxScore;
			Self.ProxWeight    := L.ProxWeight;
			Self.SELEID        := L.SELEID;
			Self.SELEScore     := L.SELEScore;
			Self.SELEWeight    := L.SELEWeight;
			Self.OrgID         := L.OrgID;
			Self.OrgScore      := L.OrgScore;
			Self.OrgWeight     := L.OrgWeight;
			Self.UltID         := L.UltID;
			Self.UltScore      := L.UltScore;
			Self.UltWeight     := L.UltWeight;
			Self.source_rec_id := L.source_rec_id;
			Self := L;
			Self := [];
End;

pre_outfinal := project(outf,finalize(LEFT));

pre_outfinal getCounty(pre_outfinal L, census_data.File_Fips2County  R) := transform
			Self.county_Name := R.county_name;
			Self := L;
End;

p_outfinal := join(pre_outfinal,
						   census_data.File_Fips2County,
						   left.county = right.county_fips and
						   left.state = right.state_code,
						   getCounty(LEFT,RIGHT),left outer, lookup);
							 
Health_Provider_Services.mac_get_best_lnpid_on_thor (
			p_outfinal
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,best_SSN
			,//clean_DOB
			,//phone1
			,//LIC_STATE
			,//LIC_Num_in
			,//TAX_ID
			,//DEA_NUM
			,//group_key
			,//NPI_NUM
			,//UPIN
			,DID
			,BDID
			,//SRC
			,source_rec_id
			,out_final,false,38
			);

promotesupers.MAC_SF_BuildProcess(out_final,'~thor_data400::base::dea',writejob,pCompress:=true)

STRATA.CreateAsHeaderStats(DEA.DEA_as_header(dea.File_DEAv2),
													 'DEA Controlled Substances',
													 'data',
													 filedate,
													 '',
													 runAsHeaderStats); 

STRATA.CreateAsBusinessHeaderStats(DEA.fDEA_As_Business_Header(DEA.File_DEAv2),
																	 'DEA Controlled Substances',
																	 'data',
																	 filedate,
																	 '',
																	 runAsBusinessHeaderStats);

f := fileservices.sEndemail(	'asiddique@seisint.com;djustin@seisint.com','DEA FieldPop Stats',
												'Finished DEA Build ' + (STRING8)STD.Date.Today() +  '\r\n \r\n ' +
												'Results and stats:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + 
												workunit + '\r\n');

Result := sequential( pre
									 ,writejob
									 ,parallel(dea.Out_Base_Stats_Population(filedate)
									 ,runAsHeaderStats
									 ,runAsBusinessHeaderStats)
									 ,f); 
Return Result;

End;