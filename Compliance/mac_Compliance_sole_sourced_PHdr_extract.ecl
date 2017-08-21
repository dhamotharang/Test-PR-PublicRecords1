

//See EXAMPLE below

//Data Provider analysis for Compliance: sole-sourced data from select sources
//The number of consumers whose information was exposed where any of the following data sources were sole-sourced:
//a.	DMVs
//b.	Equifax 
//c.	Experian
//d.	TransUnion
//e.	Targus_Ptrack (CP Targus) 
//f.	FARES	
//g.	LSSi
//h.	Targus
//i.	Certegy		//as of March 2015, to get sole-sourced DLs
//j.	NM (Claims/Tag & Title) //Insurance; not in Accurint 
//k.	WA (Claims-Tag & Title) //Insurance; not in Accurint


EXPORT mac_Compliance_sole_sourced_PHdr_extract(infile,eval_case = '') := 
  MACRO


			hdr_prod 			:= DATASET(ut.foreign_prod+'thor_data400::base::header_prod', Header.layout_header_v2, flat);	//Header.File_Headers;	 no TU sources
			hdr_tu_True   := DATASET(ut.foreign_prod+'thor_data400::base::TransunionCred_did',header.Layout_Header, flat);	//Header.file_tn_did; TU True CHdr records used in HDR
			hdr_tu_CP   	:= DATASET(ut.foreign_prod+'thor_data400::base::tucs_did',header.Layout_Header, flat);	// Header.File_Targus_did; TU legacy CP (external source)
			hdr_tu_LN   	:= DATASET(ut.foreign_prod+'thor_data400::base::transunion_did',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN (external source)

			PHDR_GLB_now    := hdr_prod + hdr_tu_True + hdr_tu_CP + hdr_tu_LN; 

//-----------------------

//Previous Header build:

//Header.file_header_previous
header_prev := DATASET(ut.foreign_prod+'thor_data400::base::header_father',header.Layout_Header,flat);
//Base PHDR files - PREVIOUS BUILD (Father):
header_father := header_prev(fname<>'',lname<>'');
hdr_tu_True_father   := DATASET(ut.foreign_prod+'thor_data400::base::transunioncred_did_father',header.Layout_Header, flat);
hdr_tu_LNCP_father  	:= DATASET(ut.foreign_prod+'thor_data400::base::transunion_did_father',header.Layout_Header, flat);	//Header.File_Transunion_did;		//TU legacy LN/CP (LT, TU)
hdr_TUCS_father	   	:= DATASET(ut.foreign_prod+'thor_data400::base::tucs_did_father',header.Layout_Header, flat);	// Header.File_TUCS_did; 

PHDR_GLB_father    := header_father + hdr_tu_True_father + hdr_tu_LNCP_father + hdr_TUCS_father; 

//----------------------------

PHDR_GLB_orig := PHDR_GLB_now;
//PHDR_GLB_orig := PHDR_GLB_father;


			infile_DIDs := DEDUP(sort(distribute(infile(did <> 0), hash(did))
																			,did, local, skew(1.0))
																 ,did, all,local);
			
			output(COUNT(infile_DIDs), named('count_'+'infile_DIDs'));

			DIDs_extract := JOIN(sort(distribute(PHDR_GLB_orig, hash(did)), did, local,skew(1.0)),
													sort(distribute(infile_DIDs, hash(did)), did, local,skew(1.0)),
													LEFT.did = RIGHT.did, TRANSFORM(LEFT), LOOKUP);

			PHDR_GLB_extract := DIDs_extract;
			
			output(PHDR_GLB_extract, named('PHDR_GLB_extract'));
			
			//-----------------------------------------------------------------------------
			
			#OPTION('multiplePersistInstances',FALSE); 

			file_segments := watchdog.file_best;
			file_CORE 		:= watchdog.file_best(adl_ind='CORE');
			
			
			Compliance.Layout_PHDR_extract xfmSegments(PHDR_GLB_extract LE, file_segments RI) :=
					TRANSFORM
						SELF.DID_segment := RI.adl_ind;
						
						SELF := LE;
					END;
					
			PHDR_GLB_extract_seg := JOIN(sort(distribute(PHDR_GLB_extract(DID <> 0), hash(DID)), DID, local,skew(1.0))
																	,sort(distribute(file_segments(DID <> 0), hash(DID)), DID, local,skew(1.0))         
																	,LEFT.did = RIGHT.did
																	,xfmSegments(LEFT,RIGHT)
																	,LEFT OUTER								// Return all extracted DIDs
																	,skew(1.0)
																	);
																			
			PHDR_GLB_extract_seg_sort := SORT(distribute(PHDR_GLB_extract_seg, hash(did)), did, local,skew(1.0))
																		:PERSIST('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case);

			output(PHDR_GLB_extract_seg_sort, named('PHDR_GLB_extract_segmented'));
			
			OUTPUT(sort(PHDR_GLB_extract_seg_sort,did, skew(1.0)),,'~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);
			
			PHDR_GLB_extract_seg_DIDs := DEDUP(PHDR_GLB_extract_seg_sort, did, all);
			output(PHDR_GLB_extract_seg_DIDs, named('PHDR_GLB_extract_seg_DIDs'));
			output(count(PHDR_GLB_extract_seg_DIDs), named('count_'+'PHDR_GLB_extract_seg_DIDs'));
			
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

mac_Compliance_sole_sourced_PHdr_extract(rs_results_all_save, 'CASE_2014_000002A');
*/
