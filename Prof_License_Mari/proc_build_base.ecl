// import ut, header_slimsort, did_add, didville, header,address, Business_Header_SS,Business_Header;
IMPORT business_header, business_header_ss, TopBusiness_External, DID_Add, ut, MDR, BIPv2;

EXPORT proc_build_base(DATASET(Prof_License_Mari.layouts.intermediate) in0) := MODULE
#option('multiplePersistInstances',FALSE);

remove_dba 				 := Prof_License_Mari.fNameDba_Website(in0);
cleaned_address    := Prof_License_Mari.fCleanNameAddr(remove_dba); //~thor_data400::persist::proflic_mari::pre_rollup
rolled_up          := Prof_License_Mari.fRollup(cleaned_address); //~thor_data400::persist::proflic_mari::rolled_up_v2


//Create MARI RID for Intermediate File
create_MariRid := Prof_License_Mari.fCreateMariRID(rolled_up);

//Reassign Temporary MARI RID to MARI RID
reformat_intermediate := PROJECT(create_MariRid, TRANSFORM(Prof_License_Mari.layouts.final, SELF.mari_rid := LEFT.tmp_mari_rid; self := left));

//Bug Ticket:177496- To set Current, History, Non Updating, Superseded and Dropped Mari records
current_flag			 := Prof_License_Mari.fn_SetResultCode(reformat_intermediate);

// Create unique id and reformat to base layout
ut.MAC_Sequence_Records(current_flag,mari_rid,dSeqNum);

EXPORT base_file_intermediate := dSeqNum;

seqrec := RECORD
				base_file_intermediate;
				UNSIGNED4	seq;
		END;

		seqrec into_seq(base_file_intermediate L, INTEGER C) := TRANSFORM
				SELF.seq := C;
				SELF := L;
		END;

		SeqFile := PROJECT(base_file_intermediate,into_seq(LEFT,COUNTER));

//Bug 183141-Populating BIP fields		
		SlimRec := RECORD
				UNSIGNED6 did;
				UNSIGNED6 did_score;
				UNSIGNED6	bdid;
				UNSIGNED1	bdid_score;
				STRING5		title;
				STRING20	fname;
				STRING20	mname;
				STRING20	lname;
				STRING5		name_suffix;
				STRING10	phone;
				STRING10	prim_range;
				STRING28	prim_name;
				STRING10	sec_range;
				STRING30  p_city_name; 
				STRING2		st;
				STRING5		zip;
				STRING254	company_name;
				STRING80	email;
		    STRING80	url;
				STRING9		fein;
				UNSIGNED8 persistent_record_id;
				UNSIGNED4	seq;
				bipv2.IDlayouts.l_xlink_ids;
		END;

			
		SlimRec into_temp(SeqFile L, INTEGER cnt) := TRANSFORM
				SELF.persistent_record_id	:= L.persistent_record_id;
				SELF.company_name		:= 	CHOOSE(cnt 	
																				,L.name_company
																				,L.name_company
																				,L.name_company_dba
																				,L.name_company_dba
																				);
																				
				SELF.phone 					:= 	CHOOSE(cnt
																				,L.phn_mari_1
																				,L.phn_mari_2
																				,L.phn_mari_1
																				,L.phn_mari_2
																					);
				
				SELF.prim_range 		:= 	CHOOSE(cnt 	
																				,l.Bus_prim_range
																				,l.Mail_prim_range
																				,l.Bus_prim_range
																				,l.Mail_prim_range																						
																			   );

				SELF.prim_name 			:= 	CHOOSE(cnt 	
																				,l.Bus_prim_name
																				,l.Mail_prim_name
																				,l.Bus_prim_name
																				,l.Mail_prim_name																						
																			   );

				SELF.sec_range 			:= 	CHOOSE(cnt 	
																				,l.Bus_sec_range
																				,l.Mail_sec_range
																				,l.Bus_sec_range
																				,l.Mail_sec_range																						
																			   );
				
				SELF.p_city_name		:=  CHOOSE(cnt 	
																				,l.Bus_p_city_name
																				,l.Mail_p_city_name
																				,l.Bus_p_city_name
																				,l.Mail_p_city_name
																			   );																												 

				SELF.zip						:= 	CHOOSE(cnt 	
																				,l.Bus_zip5
																				,l.Mail_zip5
																				,l.Bus_zip5
																				,l.Mail_zip5																				
																			   );
																				 
				SELF.st 						:= 	CHOOSE(cnt 	
																				,l.Bus_state
																				,l.Mail_state
																				,l.Bus_state
																				,l.Mail_state																				
																			   );
																				 
				SELF.fein 					:= 	CHOOSE(cnt 	
																				,IF(l.TAX_TYPE_1 = 'E', l.SSN_TAXID_1,'')
																				,IF(l.TAX_TYPE_2 = 'E', l.SSN_TAXID_2,'')
																				,IF(l.TAX_TYPE_1 = 'E', l.SSN_TAXID_1,'')
																				,IF(l.TAX_TYPE_2 = 'E', l.SSN_TAXID_2,'')
																			   );																																	
				SELF.seq 						:= 	L.seq;
				SELF.did						:= 0;
				SELF.did_score			:= 0;
				SELF.bdid 					:= 0;
				SELF.bdid_score 		:= 0;
				SELF								:=L;
		END;

		NormBusNameAddr := NORMALIZE(SeqFile,4,into_temp(LEFT,COUNTER));


		bdid_matchset := ['A','P','N'];
															
		Business_Header_SS.MAC_Match_Flex(NormBusNameAddr, 	//Input Dataset
																			bdid_matchset, 		//BDID matchset
																			company_name, 		//company_name
																			prim_range, 			//prim_range
																			prim_name, 				//prim_name
																			zip, 							//zip5

																			sec_range, 				//sec_range
																			st, 							//state
																			phone, 						//phone
																			fein, 						//fein
																			bdid, 						//bdid
																			SlimRec,  				//output layout
																			TRUE, 
																			bdid_score,     	//these should default to zero in definition
																			out_bdid,					//ouput dataset
																			,									//score_threshold
																			,									//file version (prod)
																			,									//use other environment?
																			,BIPV2.xlink_version_set  						//BIP2 ids
																			,url							//URL 
																			,email						//email 
																			,p_city_name			//city
																			,fname						//Contact's first name
																			,mname		  			//Contact's middle name
																			,lname						//Contact's last name
																			);

		SeqFile into_final(SeqFile L, out_bdid R) := TRANSFORM
				SELF.bdid				:= R.bdid;
				SELF.DotID			:= R.DotID;
				SELF.DotScore		:= R.DotScore;
				SELF.DotWeight	:= R.DotWeight;
				SELF.EmpID			:= R.EmpID;
				SELF.EmpScore		:= R.EmpScore;
				SELF.EmpWeight	:= R.EmpWeight;
				SELF.POWID			:= R.POWID;
				SELF.POWScore		:= R.POWScore;
				SELF.POWWeight	:= R.POWWeight;
				SELF.ProxID			:= R.ProxID;
				SELF.ProxScore	:= R.ProxScore;
				SELF.ProxWeight	:= R.ProxWeight;
				SELF.SELEID			:= R.SELEID;
				SELF.SELEScore	:= R.SELEScore;
				SELF.SELEWeight	:= R.SELEWeight;	
				SELF.OrgID			:= R.OrgID;
				SELF.OrgScore		:= R.OrgScore;
				SELF.OrgWeight	:= R.OrgWeight;
				SELF.UltID			:= R.UltID;
				SELF.UltScore		:= R.UltScore;
				SELF.UltWeight	:= R.UltWeight;	
				self 						:= L;
		END;
		
										
		outfinal := JOIN(	SORT(DISTRIBUTE(SeqFile, HASH(seq)) ,seq,LOCAL), 
											SORT(DISTRIBUTE(out_bdid, HASH(seq)), seq, -bdid_score,LOCAL),
											LEFT.seq = RIGHT.seq,
											into_final(LEFT,RIGHT),
											LOCAL,
											LEFT OUTER, KEEP(1)
										); /*: persist('~thor_data400::persist::proflic_mari::append_bdid');*/


		layout_mari_final_plus := RECORD
			Prof_License_Mari.layouts.final;
			UNSIGNED4	seq;
			UNSIGNED3 did_score:=0;
		END;
		outfinal_plus := PROJECT(outfinal,layout_mari_final_plus);

		did_matchset  := ['A','P','Z'];  
		DID_Add.MAC_Match_Flex(outfinal_plus, did_matchset,
                       foo, birth_dte, fname, mname, lname, name_sufx,
	    								 bus_prim_range, bus_prim_name, bus_sec_range, bus_zip5, bus_state,
											 phn_mari_1, did, outfinal_plus, TRUE, 
											 did_score, 
										   75,        
										   out_did1);
		
		WithDIDs		:=	out_did1(did!=0);
		WithOutDIDs	:=	out_did1(did=0);
		
		DID_Add.MAC_Match_Flex(WithOutDIDs, did_matchset,
                       foo, birth_dte, fname, mname, lname, name_sufx,
	    								 mail_prim_range, mail_prim_name, mail_sec_range, mail_zip5, mail_state,
											 phn_mari_2, did, WithOutDIDs, TRUE, 
											 did_score, 
										   75,        
										   out_did2);

		//Build Midex DID lookup table
		WithDID2s		:=	out_did2(did!=0);
		WithOutDID2s	:=	out_did2(did=0);
		Prof_License_Mari.fnMidexDid.buildMidexDidFile(WithDIDs, WithDID2s);
		
		//Propagate DID on records without DIDs
		MARI_Enhance_Did(DATASET(RECORDOF(WithOutDID2s)) infile) := FUNCTION
			
			//lookup table
			fMidex_did						:= Prof_License_Mari.fnMidexDid.file_MidexDid;
			
			layout_mari_plus := RECORD
				infile;
				STRING  record_id;
			END;
			
			//contruct the record_id from names, business addresses, and license numbers
			f_mari_new_bus 				:= PROJECT(infile,
																				TRANSFORM(layout_mari_plus,
																									SELF.record_id:=TRIM(LEFT.lname)+TRIM(LEFT.fname)+/*TRIM(LEFT.bus_p_city_name)+*/TRIM(LEFT.bus_state)+
																											':'+Prof_License_Mari.fnMidexDid.cleanLicenseNbr(LEFT.license_nbr);
																									SELF:=LEFT;));		
			//propagate DID using name, business address, and license number
			f_mari_enhance_did 		:= JOIN(SORT(DISTRIBUTE(f_mari_new_bus,HASH(record_id)),record_id,LOCAL),
																		SORT(DISTRIBUTE(fMidex_did,HASH(record_id)),record_id,-did_score,LOCAL),
																		LEFT.record_id=RIGHT.record_id,
																		TRANSFORM(RECORDOF(out_did2), //Prof_License_Mari.layouts.final,
																						 SELF.did:=IF(LEFT.did<>0,LEFT.did,RIGHT.did);
																						 SELF.enh_did_src:=IF(SELF.did=0 OR LEFT.did<>0,'',
																																	CASE(RIGHT.source_code,'MARI'=>'M','SANCTN'=>'S','SANCTN_NP'=>'N','U'));
																							 SELF:=LEFT;),
																		LEFT OUTER);	
			f_mari_enhance_did_no_did:= f_mari_enhance_did(did=0);
			f_mari_enhance_did_with_did:= f_mari_enhance_did(did<>0);
			
			//contruct the record_id from names, mail addresses, and license numbers
			f_mari_new_mail 			:= PROJECT(f_mari_enhance_did_no_did,
																				TRANSFORM(layout_mari_plus,
																									SELF.record_id:=TRIM(LEFT.lname)+TRIM(LEFT.fname)+/*TRIM(LEFT.mail_p_city_name)+*/TRIM(LEFT.mail_state)+
																											':'+Prof_License_Mari.fnMidexDid.cleanLicenseNbr(LEFT.license_nbr);
																									SELF:=LEFT;));		
			
			f_mari_enhance_did2		:= JOIN(SORT(DISTRIBUTE(f_mari_new_mail,HASH(record_id)),record_id,LOCAL),
																		SORT(DISTRIBUTE(fMidex_did,HASH(record_id)),record_id,-did_score,LOCAL),
																		LEFT.record_id=RIGHT.record_id,
																		TRANSFORM(RECORDOF(out_did2), //Prof_License_Mari.layouts.final,
																						 SELF.did:=IF(LEFT.did<>0,LEFT.did,RIGHT.did);
																						 SELF.enh_did_src:=IF(SELF.did=0 OR LEFT.did<>0,'',
																																	CASE(RIGHT.source_code,'MARI'=>'M','SANCTN'=>'S','SANCTN_NP'=>'N','U'));
																							 SELF:=LEFT;),
																		LEFT OUTER);	

			new_mari						  := f_mari_enhance_did2 + f_mari_enhance_did_with_did;
						
			RETURN new_mari;
			
		END;

		//Propagate DID using Midex DID lookup table for those records do not have DIDs
		enh_did := MARI_Enhance_Did(WithOutDID2s);
		
		//DF-21263 removed records with same data except did, did score, and enh did src 
		AllDIDs	:=	DEDUP(SORT(DISTRIBUTE((WithDIDs + WithDID2s+ enh_did),HASH(cmc_slpk)),cmc_slpk,persistent_record_id,-did_score, LOCAL),RECORD, EXCEPT DID, did_score,enh_did_src);
					
		// Re-Create unique id and reformat to base layout
		ut.MAC_Sequence_Records(AllDIDs,mari_rid,dDID_Seq);

		//Reset Temporary MARI RID to MARI RID field
		dsSearch_RID := Prof_License_Mari.fCreateMariRID(dDID_Seq); //: persist('~thor_data400::persist::proflic_mari:persist_rid');

		reformat_searchRID := PROJECT(dsSearch_RID, TRANSFORM(Prof_License_Mari.layouts.final, SELF.mari_rid := LEFT.tmp_mari_rid; SELF := LEFT));

		EXPORT search_file	:=	reformat_searchRID;
		
			

END;
		