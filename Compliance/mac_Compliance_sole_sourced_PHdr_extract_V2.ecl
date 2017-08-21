IMPORT Header,Death_Master,ut,Data_Services,Compliance;

//"PHDR_extract" gets the base PHDR records for all DIDs exposed per IADP request.
//Note that SSA D$ are not in PHDR, and are added separately. (See Compliance.Death_restricted_as_Header)
//PHDR_extract records are used to determine "sole-sourced" data elements:
//	LexID; Name; Address; SSN; DOB; DL; DOD


//	See EXAMPLE below	//

//Data Provider analysis for IADP/Compliance: sole-sourced data from select sources
//The number of consumers whose information was exposed where any of the following data sources were sole-sourced:
//a.	DMVs
//b.	Equifax 
//c.	Experian
//d.	TransUnion
//e.	TUCS_Ptrack (CP TUCS) 
//f.	FARES	
//g.	LSSi
//h.	Targus
//i.	Certegy		//as of March 2015, to get sole-sourced DLs
//j.	SSA				//as of August 2016, both unrestricted and restricted
//		NM (Claims/Tag & Title) //Insurance; not in Accurint 
//		WA (Claims-Tag & Title) //Insurance; not in Accurint


EXPORT mac_Compliance_sole_sourced_PHdr_extract_V2(infile,eval_case = '') := 
  MACRO

			hdr_prod 			:= DATASET(ut.foreign_prod+'thor_data400::base::header_prod', Header.layout_header_v2, flat);	//Header.File_Headers;	 no TU sources
			hdr_tu_True   := DATASET(ut.foreign_prod+'thor_data400::base::TransunionCred_did',header.Layout_Header, flat);	//Header.file_tn_did; TU True CHdr records used in HDR
			hdr_tu_CP   	:= DATASET(ut.foreign_prod+'thor_data400::base::tucs_did',header.Layout_Header, flat);	// Header.File_Targus_did; TU legacy CP (external source)
			hdr_tu_LN   	:= DATASET(ut.foreign_prod+'thor_data400::base::transunion_did',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN (external source)

			PHDR_GLB_now  := hdr_prod + hdr_tu_True + hdr_tu_CP + hdr_tu_LN; 

//August 2016:			
			PHDR_GLB_now_plus_DOD := PROJECT(PHDR_GLB_now
																			 ,TRANSFORM({PHDR_GLB_now
																								 ,string8 DOD_from_LNDMF := ''}
																								 , self := left)
																			 );

			//Header.File_DID_Death_MasterV3_ssa
			File_DID_Death_MasterV3_ssa := DATASET(Data_Services.foreign_prod+'thor_data400::base::did_death_masterV3_ssa',
                                        Header.Layout_Did_Death_MasterV3, flat);
																				
			SSA_D$ := Compliance.Death_restricted_as_Header(File_DID_Death_MasterV3_ssa);
			
			PHDR_GLB := PHDR_GLB_now_plus_DOD + SSA_D$;
			
//-----------------------

//Previous Header build:

//Header.file_header_previous
			header_prev := DATASET(ut.foreign_prod+'thor_data400::base::header_father',header.Layout_Header,flat);
//Base PHDR files - previous build (Father):
			header_father := header_prev(fname<>'',lname<>'');
			hdr_tu_True_father   := DATASET(ut.foreign_prod+'thor_data400::base::transunioncred_did_father',header.Layout_Header, flat);
			hdr_tu_LNCP_father  	:= DATASET(ut.foreign_prod+'thor_data400::base::transunion_did_father',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN/CP (LT, TU)
			hdr_TUCS_father	   	:= DATASET(ut.foreign_prod+'thor_data400::base::tucs_did_father',header.Layout_Header, flat);	// Header.File_TUCS_did; 

			PHDR_GLB_previous    := header_father + hdr_tu_True_father + hdr_tu_LNCP_father + hdr_TUCS_father; 

//August 2016:
			PHDR_GLB_previous_plus_DOD := PROJECT(PHDR_GLB_previous
																			 ,TRANSFORM({PHDR_GLB_previous
																									, string8 DOD_from_LNDMF := ''}
																									, self := left)
																			 );

			File_DID_Death_MasterV3_ssa_father := DATASET(Data_Services.foreign_prod+'thor_data400::base::did_death_masterV3_ssa_father',
																										Header.Layout_Did_Death_MasterV3, flat);
																				
			SSA_D$_father := Compliance.Death_restricted_as_Header(File_DID_Death_MasterV3_ssa_father);
			
			PHDR_GLB_father := PHDR_GLB_previous_plus_DOD + SSA_D$_father;
			
//-------------------------------------------------

			PHDR_GLB_orig := PHDR_GLB;


			infile_DIDs := DEDUP(sort(distribute(infile(did <> 0), hash(did))
																			,did, local, skew(1.0))
																 ,did, all,local);
			
			output(COUNT(infile_DIDs), named('count_'+'infile_DIDs'));

			DIDs_extract := JOIN(sort(distribute(PHDR_GLB_orig, hash(did)), did, local,skew(1.0)),
													sort(distribute(infile_DIDs, hash(did)), did, local,skew(1.0)),
													LEFT.did = RIGHT.did
													,TRANSFORM(LEFT)
													,LOOKUP);

			PHDR_GLB_extract := DIDs_extract;
			
			output(PHDR_GLB_extract, named('sample_'+'PHDR_GLB_extract'));
			
			//-----------------------------------------------------------------------------
			
			#OPTION('multiplePersistInstances',FALSE); 
			
			//Add Segmentation
			rec_key_IDLHdr_DIDInd_Boca :=
				RECORD
					//  unsigned8 did;
					string10 ind;
					unsigned8 cnt;
					string9 ssn;
					unsigned4 dob;
				END;

			key_IDLHdr_DIDInd_Boca := PULL(INDEX({unsigned8 did},rec_key_IDLHdr_DIDInd_Boca, Data_Services.foreign_prod+'thor_data400::key::insuranceheader_segmentation::did_ind_qa'));
			
			file_segments := key_IDLHdr_DIDInd_Boca;
			file_CORE 		:= file_segments(ind='CORE');
			
			
			Compliance.Layout_PHDR_extract_V2 xfmSegments(PHDR_GLB_extract LE, file_segments RI) :=
					TRANSFORM
						SELF.DID_segment := IF(LE.did = 0, 'noDID', if(RI.ind = '', 'NO SEGMENT', RI.ind));
						
						SELF := LE;
					END;
					
			PHDR_GLB_extract_seg := JOIN(sort(PHDR_GLB_extract(DID <> 0), DID, skew(1.0))
																	,sort(file_segments(DID <> 0), DID, skew(1.0))         
																	,LEFT.did = RIGHT.did
																	,xfmSegments(LEFT,RIGHT)
																	,LEFT OUTER								// Return all extracted DIDs
																	,skew(1.0)
																	);
																			
			PHDR_GLB_extract_seg_sort := SORT(PHDR_GLB_extract_seg, DID, skew(1.0))
																		:PERSIST('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case);

			output(PHDR_GLB_extract_seg_sort, named('sample_'+'PHDR_GLB_extract_segmented'));
			output(COUNT(PHDR_GLB_extract_seg_sort), named('count_'+'PHDR_GLB_extract_segmented'));
			OUTPUT(SORT(PHDR_GLB_extract_seg_sort,did, skew(1.0)),,'~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
			
			//----------
			
			PHDR_GLB_extract_seg_DIDs := DEDUP(PHDR_GLB_extract_seg_sort, did, all);
			output(PHDR_GLB_extract_seg_DIDs, named('sample_'+'PHDR_GLB_extract_seg_DIDs'));
			output(count(PHDR_GLB_extract_seg_DIDs), named('count_'+'PHDR_GLB_extract_seg_DIDs'));
			
			//----------
			
			//Add in LNDMF data (August 2016)
			
			PHDR_GLB_extract_wLNDMF := Compliance.fn_PHDR_extract_addLNDMF(PHDR_GLB_extract_seg);
			
			PHDR_GLB_extract_wLNDMF_save := SORT(PHDR_GLB_extract_wLNDMF, DID, skew(1.0))
																		:PERSIST('~thor400_92::in::compliance::sole_sourced_PHDR_extract_wLNDMF_'+eval_case);

			output(PHDR_GLB_extract_wLNDMF, named('sample_'+'sole_sourced_PHDR_extract_wLNDMF'));
			output(COUNT(PHDR_GLB_extract_wLNDMF), named('count_'+'sole_sourced_PHDR_extract_wLNDMF'));
			output(COUNT(DEDUP(PHDR_GLB_extract_wLNDMF, all)), named('count_'+'sole_sourced_PHDR_extract_wLNDMF_DIDs'));
			
			OUTPUT(SORT(PHDR_GLB_extract_wLNDMF,did, skew(1.0)),,'~thor400_92::in::compliance::sole_sourced_PHDR_extract_wLNDMF_'+eval_case + '.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
			
	ENDMACRO;
	
//--------------------------------------------------------------------------------------------------------
/*
//EXAMPLE:

version := '';

orig_file_name := 'CASE_2014_000002A';		

//rs_results_all_save := DATASET(ut.foreign_prod+'~thor400_92::persist::compliance::rs_results_all_' + orig_file_name + version
rs_results_all_save := DATASET(ut.foreign_prod+'~thor400_92::persist::compliance::phdr_results_' + orig_file_name + version
																,Compliance.Layout_search_results
																,THOR);

mac_Compliance_sole_sourced_PHdr_extract_V2(rs_results_all_save, 'CASE_2014_000002A');
*/
