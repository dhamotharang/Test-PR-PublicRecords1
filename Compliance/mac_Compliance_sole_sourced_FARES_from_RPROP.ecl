//First, run "mac_Compliance_sole_sourced_PHdr_extract".

IMPORT Compliance,LN_PropertyV2,Data_Services,ut;


//----------


EXPORT mac_Compliance_sole_sourced_FARES_from_RPROP(infile,eval_case = '',row_ID = 0, source_field,outfile) := 
  MACRO

//------------
#OPTION('multiplePersistInstances',FALSE);

//		rec_PHdr_extract := Compliance.Layout_PHDR_extract;
		rec_PHdr_extract := Compliance.Layout_PHDR_extract_V2;
	

		PHdr_extract := DATASET('~thor400_92::in::compliance::sole_sourced_PHDR_extract_'+eval_case + '.csv'
																,rec_PHdr_extract
																,CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')));

//----------------------
//Sole-sourced from:
//f.	FARES 

set_FARES := [mdr.sourcetools.src_Fares_Deeds_from_Asrs			//     := 'FB';
							,mdr.sourcetools.src_LnPropV2_Fares_Asrs			//     := 'FA';
							,mdr.sourcetools.src_LnPropV2_Fares_Deeds			//     := 'FP';
							,mdr.sourcetools.src_Foreclosures							//     := 'FR';
							,mdr.sourcetools.src_Foreclosures_Delinquent	//	   := 'NT';  // aka Notice of Default/Delinquency (NOD)
						 ];

rec_criteria := 
	RECORD
		rec_PHdr_extract;
		
		boolean has_ssn;
		boolean has_dob;
		boolean has_DL;
		
		boolean src_is_FARES;
		boolean src_is_not_FARES;
		
	END;

rec_criteria xfmPHDR(PHdr_extract LE) :=   
	TRANSFORM
	 self.src_is_FARES					:= LE.src IN set_FARES;
	 self.src_is_not_FARES      := self.src_is_FARES = false;
	 
	 self.has_ssn              := ut.full_ssn(LE.ssn) = true;
	 self.has_dob              := IF(LE.dob <> 0,true,false);
	 self.has_DL	             := (LE.src IN mdr.sourcetools.set_DL OR LE.src IN mdr.sourcetools.set_Certegy) AND LE.vendor_id <> '';
	 
	 SELF                      := LE;
	END;

PHdr_extract_plus  := PROJECT(PHdr_extract, xfmPHDR(LEFT));

//----------------

set_name_FARES := 'FARES';

//segment_name := 'CORE';
segment_name := '_All_SEGMENTS_';

//----------------

// Make sure to use Header data, not Key (Best) data, for sole-sourced //

layout_no_Header_KEY := Header.layout_header_v2 - [did,src,dt_last_seen,dt_vendor_last_reported];

rec_infile_slim := {infile} - layout_no_Header_KEY;

rec_infile_sole_source := 
	RECORD
		rec_infile_slim;
		unsigned6 result_rid;
	END;
		
infile_slim := PROJECT(infile, transform({rec_infile_sole_source}, self.result_rid := left.rid; self := left)
												);
output(infile_slim, named('infile_slim'+'_sample'));

#OPTION('multiplePersistInstances',FALSE); 

is_FARES := infile_slim.source_field IN set_FARES;

//---------------------------------------------------------------

// Sole-sourced Fares in Real Property dataset
// Thesea re DIDs that came back from a PHDR search, 
//not an actual RP search.
//This may cause more DIDs to come back than were actually exposed,
//so probably should NOT use this query.

// Search RP Search, using DIDs from PHDR Results: 

qry_RPROP := sort(distribute(DEDUP(infile(srch_dataset = 'Real_Prop'), append_row_id, did, all)
									,hash(append_row_id)), append_row_id, did, local);

//----------

Prop_Search_Mnthly := DATASET(Data_Services.foreign_prod+'thor_data400::base::ln_propertyv2::search',
															LN_PropertyV2.Layout_DID_Out, flat);

rSource := 
	RECORD
		string source_val;
		string which_prop_file;
		LN_PropertyV2.Layout_DID_Out;
	END;

rSource TwoSourcesMonthly(LN_PropertyV2.Layout_DID_Out pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF.which_prop_file := 'SEARCH_MONTHLY';
		SELF := pInput;
	END;

File_Base_Search_Mnthly := PROJECT(Prop_Search_Mnthly, TwoSourcesMonthly(LEFT)); 

Prop_Search_Fast := DATASET(Data_Services.foreign_prod+'thor_data400::base::property_fast::search_father',
															LN_PropertyV2.Layout_DID_Out, flat);
															
rSource TwoSourcesFast(LN_PropertyV2.Layout_DID_Out pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF.which_prop_file := 'SEARCH_FAST';
		SELF := pInput;
	END;

File_Base_Search_Fast := PROJECT(Prop_Search_Fast, TwoSourcesFast(LEFT)); 

Prop_Search_all := File_Base_Search_Mnthly + File_Base_Search_Fast;
Prop_Search := DISTRIBUTE(Prop_Search_all(did > 0), skew(0.5));

//-----

rs_RPROP_results := JOIN(Prop_Search,
												qry_RPROP,
												LEFT.did = RIGHT.did,
												Compliance.xfmRPROP_orig(LEFT, RIGHT)
												,MANY LOOKUP
												,skew(1.0)
												);

//save as CSV
RPROP_results_save := OUTPUT(rs_RPROP_results,,'~thor400_dev::persist::compliance::RPROP_results_' + eval_case +'.csv', CSV(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite);

//Should only report Property owned by DID
results_RPROP := rs_RPROP_results(pflag1 IN ['B', 'O', 'C'] AND pflag2 = 'P');


//-----	This is for determining sole-sourced FARES:
//Count number of sources per DID. If less than two and equals Source A, then sole-sourced Fares.

rs_from_RPROP_Search_Sources := DEDUP(sort(distribute(results_RPROP(did > 0, RawAID > 0), hash(append_row_id))
																					,append_row_id, did, RawAID, source_value, -dt_last_seen, local)
																			,append_row_id, did, RawAID, source_value, all,local);

tbl_from_RPROP_Search_Sources := TABLE(rs_from_RPROP_Search_Sources, {append_row_id, did, RawAID, source_count := count(group)}, append_row_id,did,RawAID, few);
tbl_from_RPROP_Search_OneSource := tbl_from_RPROP_Search_Sources(source_count = 1);

rs_from_RPROP_Search_join := JOIN(sort(distribute(rs_from_RPROP_Search_Sources, hash(append_row_id)), append_row_id, did, RawAID, local),
																				sort(distribute(tbl_from_RPROP_Search_OneSource, hash(append_row_id)), append_row_id, did, RawAID, local),
																				LEFT.append_row_id = RIGHT.append_row_id
																				 AND LEFT.did = RIGHT.did
																				 AND LEFT.RawAID = RIGHT.RawAID,
																				TRANSFORM(left)
																				,skew(1.0)
																				);

rs_from_RPROP_Search_FARESonly := rs_from_RPROP_Search_join(source_value = 'Source A');

count_from_RPROP_Search_FARESonly := OUTPUT(COUNT(rs_from_RPROP_Search_FARESonly), named('count_'+'from_RPROP_Search_FARESonly_' + eval_case));
from_RPROP_Search_FARESonly := OUTPUT(TOPN(rs_from_RPROP_Search_FARESonly,3000,append_row_id), ALL, named('from_RPROP_Search_FARESonly_sample_' + eval_case));

//--------------------------------------------------

outfile := 	parallel(RPROP_results_save
											,count_from_RPROP_Search_FARESonly
											,from_RPROP_Search_FARESonly
												
												);
											 
	ENDMACRO;
//---------------------------------------------------------------------------------------------------------
