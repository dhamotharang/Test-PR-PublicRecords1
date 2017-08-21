import bipv2, business_header, business_header_ss, DID_Add, ut, MDR; 
// did not put call to get_best_lnpid here because the lnpid field does not exist in the file that is being passed here

export fAppend_ADLS := MODULE
	export prov_info(DATASET(NCPDP.layouts.base.prov_information) pKeyBuildFile) := FUNCTION

		seqrec := record
				pKeyBuildFile;
				unsigned4	seq;
		end;

		seqrec into_seq(pKeyBuildFile L, integer C) := transform
				self.seq := C;
				self := L;
		end;

		SeqFile := project(pKeyBuildFile,into_seq(LEFT,COUNTER));

		SlimRec := record
				unsigned6	bdid;
				BIPV2.IDlayouts.l_xlink_ids;
				unsigned1	score;
				pKeyBuildFile.NCPDP_provider_id;
				pKeyBuildFile.federal_tax_id;
				string10	phone;
				string10	prim_range;
				string28	prim_name;
				string10	sec_range;
				string5		zip;
				string2		st;
				string100	name;
				unsigned4	seq;
				Layouts.Keybuild.Phys_p_city_name;
				Layouts.Input.prov_information.contact_first_name;
				Layouts.Input.prov_information.contact_middle_initial;
				Layouts.Input.prov_information.contact_last_name;			
		end;

		SlimRec into_temp(SeqFile L, integer cnt) := transform
				self.name 						:= 	choose(cnt 	
																						,l.legal_business_name
																						,l.legal_business_name
																						,l.doctor_name
																						,l.doctor_name
																						,l.DBA
																						,l.DBA																						
																			  );
				self.phone 						:= 	l.phys_loc_phone;
				self.prim_range 			:= 	choose(cnt 	
																						,l.Phys_prim_range
																						,l.Mail_prim_range
																						,l.Phys_prim_range
																						,l.Mail_prim_range
																						,l.Phys_prim_range
																						,l.Mail_prim_range																						
																			   );
				self.prim_name 				:= 	choose(cnt 	
																						,l.Phys_prim_name
																						,l.Mail_prim_name
																						,l.Phys_prim_name
																						,l.Mail_prim_name
																						,l.Phys_prim_name
																						,l.Mail_prim_name																						
																			   );
				self.sec_range 				:= 	choose(cnt 	
																						,l.Phys_sec_range
																						,l.Mail_sec_range
																						,l.Phys_sec_range
																						,l.Mail_sec_range
																						,l.Phys_sec_range
																						,l.Mail_sec_range																						
																			   );
				self.zip							:= 	choose(cnt 	
																						,l.Phys_zip5
																						,l.Mail_zip5
																						,l.Phys_zip5
																						,l.Mail_zip5
																						,l.Phys_zip5
																						,l.Mail_zip5																				
																			   );
																				 
				self.st 							:= 	choose(cnt 	
																						,l.Phys_state
																						,l.Mail_state
																						,l.Phys_state
																						,l.Mail_state
																						,l.Phys_state
																						,l.Mail_state																				
																			   );
				self.seq 							:= 	L.seq;
				self.bdid 						:= 	0;
				self.score 						:= 	0;			
				self									:=	l;
		end;

		NormBusNameAddr := normalize(SeqFile,6,into_temp(LEFT,COUNTER));

		business_header.MAC_Source_Match(	NormBusNameAddr,
																			out1,
																			false,
																			bdid,
																			false,
																			MDR.sourceTools.src_NCPDP,
																			false,
																			foo,
																			Name,
																			prim_range,
																			prim_name,
																			sec_range,
																			zip,
																			true,
																			Phone,
																			true, 
																			federal_tax_id
																		 );

		outWithBDID 	 := out1(bdid != 0);
		outWithOutBDID := out1(bdid  = 0);
		
		// we want these at the top of the sort order.
		outWithBDID add_fake_score(outWithBDID L) := transform
				self.score	:= 101;
				self 				:= l;
		end;

		OutWithBDID_score := project(outWithBDID,add_fake_score(LEFT));
		dsAllRecs 				:= OutWithBDID_score + outWithOutBDID;

		myset := ['A','P','F'];

		business_header_ss.MAC_Match_Flex(
					 dsAllRecs														// input dataset						
					,myset				                				// bdid matchset what fields to match on           
					,name	                  							// company_name	              
					,prim_range		                  			// prim_range		              
					,prim_name		                    		// prim_name		              
					,zip					                    		// zip5					              
					,sec_range		                    		// sec_range		              
					,st				        		          			// state				              
					,phone						                    // phone				              
					,federal_tax_id            			      // fein              
					,bdid														  		// bdid												
					,SlimRec			    										// output layout 
					,true                               	// output layout has bdid score field? 																	
					,score                     						// bdid_score                 
					,out2				          								// output dataset
					,																			// keep count
					,																			// default threshold
					,																			// use prod version of superfiles
					,																			// default is to hit prod from dataland, and on prod hit prod.		
					,BIPV2.xlink_version_set							// create BIP keys only
					,																			// url
					,																			// email 
					,Phys_p_city_name											// city
					,contact_first_name										// fname
					,contact_middle_initial								// mname
					,contact_last_name										// lname
				);				

		outf := rollup(sort(distribute(out2,hash(seq)),seq,bdid,local),
												transform(recordof(left),
												self.bdid 			:= if(right.score 			> left.score,				right.bdid,					left.bdid),
												self.DotID			:= if(right.DotID 			> left.DotID,				right.DotID,				left.DotID),
												self.DotScore		:= if(right.DotScore 		> left.DotScore,		right.DotScore,			left.DotScore),
												self.DotWeight	:= if(right.DotWeight 	> left.DotWeight,		right.DotWeight,		left.DotWeight),
												self.EmpID			:= if(right.EmpID 			> left.EmpID,				right.EmpID,				left.EmpID),
												self.EmpScore		:= if(right.EmpScore 		> left.EmpScore,		right.EmpScore,			left.EmpScore),
												self.EmpWeight	:= if(right.EmpWeight 	> left.EmpWeight,		right.EmpWeight,		left.EmpWeight),
												self.POWID			:= if(right.POWID 			> left.POWID,				right.POWID,				left.POWID),
												self.POWScore		:= if(right.POWScore 		> left.POWScore,		right.POWScore,			left.POWScore),
												self.POWWeight	:= if(right.POWWeight 	> left.POWWeight,		right.POWWeight,		left.POWWeight),
												self.ProxID			:= if(right.ProxID 			> left.ProxID,			right.ProxID,				left.ProxID),
												self.ProxScore	:= if(right.ProxScore 	> left.ProxScore,		right.ProxScore,		left.ProxScore),
												self.ProxWeight	:= if(right.ProxWeight 	> left.ProxWeight,	right.ProxWeight,		left.ProxWeight),
												self.SELEID			:= if(right.SELEID 			> left.SELEID,			right.SELEID,				left.SELEID),
												self.SELEScore	:= if(right.SELEScore 	> left.SELEScore,		right.SELEScore,		left.SELEScore),
												self.SELEWeight	:= if(right.SELEWeight 	> left.SELEWeight,	right.SELEWeight,		left.SELEWeight),
												self.OrgID			:= if(right.OrgID 			> left.OrgID,				right.OrgID,				left.OrgID),
												self.OrgScore		:= if(right.OrgScore 		> left.OrgScore,		right.OrgScore,			left.OrgScore),
												self.OrgWeight	:= if(right.OrgWeight 	> left.OrgWeight,		right.OrgWeight,		left.OrgWeight),
												self.UltID			:= if(right.UltID 			> left.UltID,				right.UltID,				left.UltID),
												self.UltScore		:= if(right.UltScore 		> left.UltScore,		right.UltScore,			left.UltScore),
												self.UltWeight	:= if(right.UltWeight 	> left.UltWeight,		right.UltWeight,		left.UltWeight),
												self 						:= left),
												seq,local);

		SeqFile into_final(SeqFile L, outf R) := transform
												self.bdid				:= R.bdid;
												self.DotID			:= R.DotID;
												self.DotScore		:= R.DotScore;
												self.DotWeight	:= R.DotWeight;
												self.EmpID			:= R.EmpID;
												self.EmpScore		:= R.EmpScore;
												self.EmpWeight	:= R.EmpWeight;
												self.POWID			:= R.POWID;
												self.POWScore		:= R.POWScore;
												self.POWWeight	:= R.POWWeight;
												self.ProxID			:= R.ProxID;
												self.ProxScore	:= R.ProxScore;
												self.ProxWeight	:= R.ProxWeight;
												self.SELEID			:= R.SELEID;
												self.SELEScore	:= R.SELEScore;
												self.SELEWeight	:= R.SELEWeight;	
												self.OrgID			:= R.OrgID;
												self.OrgScore		:= R.OrgScore;
												self.OrgWeight	:= R.OrgWeight;
												self.UltID			:= R.UltID;
												self.UltScore		:= R.UltScore;
												self.UltWeight	:= R.UltWeight;					
												self 						:= L;
		end;

		outfinal := join(	distribute(SeqFile,hash(seq)),
											outf,
											left.seq = right.seq,
											into_final(LEFT,RIGHT),
											local,
											left outer
										);
										
		Did_Matchset := ['A','P'];
			
		DID_Add.MAC_Match_Flex(
												outfinal					// Input Dataset
												,Did_Matchset   	// Did_Matchset  what fields to match on
												,''								// ssn
												,''								// dob
												,clean_fname						// fname
												,clean_mname						// mname
												,clean_lname						// lname
												,clean_suffix						// name_suffix
												,Phys_prim_range	// prim_range
												,Phys_prim_name		// prim_name
												,Phys_sec_range		// sec_range
												,Phys_zip5				// zip5
												,Phys_state				// state
												,contact_phone		// phone
												,did							// Did
												,SeqFile					// output layout
												,false						// Does output record have the score
												,did_score				// did score field
												,75								// score threshold
												,dDidOut					// output dataset       
												); 
												
		WithDIDs		:=	dDidOut(did!=0);
		WithOutDIDs	:=	dDidOut(did=0);
												
		DID_Add.MAC_Match_Flex(
												WithOutDIDs				// Input Dataset
												,Did_Matchset   	// Did_Matchset  what fields to match on
												,''								// ssn
												,''								// dob
												,clean_fname						// fname
												,clean_mname						// mname
												,clean_lname						// lname
												,clean_suffix						// name_suffix
												,Mail_prim_range	// prim_range
												,Mail_prim_name		// prim_name
												,Mail_sec_range		// sec_range
												,Mail_zip5				// zip5
												,Mail_state				// state
												,contact_phone		// phone
												,did							// Did
												,SeqFile					// output layout
												,false						// Does output record have the score
												,did_score				// did score field
												,75								// score threshold
												,dDidOut2					// output dataset       
												); 
												
		AllDIDs	:=	distribute((WithDIDs + dDidOut2),hash(NCPDP_provider_id));
												
		FinalFile	:=	PROJECT(AllDIDs,TRANSFORM(NCPDP.Layouts.base.prov_information,SELF := LEFT;));
		
		return FinalFile;
	end;
end;