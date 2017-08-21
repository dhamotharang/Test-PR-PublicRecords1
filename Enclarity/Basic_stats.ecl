IMPORT Enclarity;

EXPORT Basic_stats := MODULE

/************************************************************************
* Description:
*     Brute Force Macro to create a table for composited Fixed Record Files
*
* Input Parameters:
*     AddFileXX - the Addition count input file to be processed
*     LostFileXX - the Lost count input file to be processed
*     FileNameXX - the name of the base count file to be processed
*     Field Name - the name of the specific field processed (counted)
*     (All of these X16) to catch all of the files
*
*  Returns:
*      The output dataset defining the results table
*
*  Comments:
*       Also added an output to the system log of the final results
* 
*************************************************************************/
SHARED OutputTablePopulationCompositeRecord(AddFile01, LostFile01, FileName01, FieldName01, NewCnt01, OldCnt01, RecDiff01, Percent01, NewH01, OldH01, NewC01, OldC01,
                                     AddFile02, LostFile02, FileName02, FieldName02, NewCnt02, OldCnt02, RecDiff02, Percent02, NewH02, OldH02, NewC02, OldC02,
                                     AddFile03, LostFile03, FileName03, FieldName03, NewCnt03, OldCnt03, RecDiff03, Percent03, NewH03, OldH03, NewC03, OldC03,
                                     AddFile04, LostFile04, FileName04, FieldName04, NewCnt04, OldCnt04, RecDiff04, Percent04, NewH04, OldH04, NewC04, OldC04,
                                     AddFile05, LostFile05, FileName05, FieldName05, NewCnt05, OldCnt05, RecDiff05, Percent05, NewH05, OldH05, NewC05, OldC05,
                                     AddFile06, LostFile06, FileName06, FieldName06, NewCnt06, OldCnt06, RecDiff06, Percent06, NewH06, OldH06, NewC06, OldC06,
                                     AddFile07, LostFile07, FileName07, FieldName07, NewCnt07, OldCnt07, RecDiff07, Percent07, NewH07, OldH07, NewC07, OldC07,
                                     AddFile08, LostFile08, FileName08, FieldName08, NewCnt08, OldCnt08, RecDiff08, Percent08, NewH08, OldH08, NewC08, OldC08,
                                     AddFile09, LostFile09, FileName09, FieldName09, NewCnt09, OldCnt09, RecDiff09, Percent09, NewH09, OldH09, NewC09, OldC09,
                                     AddFile10, LostFile10, FileName10, FieldName10, NewCnt10, OldCnt10, RecDiff10, Percent10, NewH10, OldH10, NewC10, OldC10,
                                     AddFile11, LostFile11, FileName11, FieldName11, NewCnt11, OldCnt11, RecDiff11, Percent11, NewH11, OldH11, NewC11, OldC11,
                                     AddFile12, LostFile12, FileName12, FieldName12, NewCnt12, OldCnt12, RecDiff12, Percent12, NewH12, OldH12, NewC12, OldC12,
                                     AddFile13, LostFile13, FileName13, FieldName13, NewCnt13, OldCnt13, RecDiff13, Percent13, NewH13, OldH13, NewC13, OldC13,
                                     AddFile14, LostFile14, FileName14, FieldName14, NewCnt14, OldCnt14, RecDiff14, Percent14, NewH14, OldH14, NewC14, OldC14,
                                     AddFile15, LostFile15, FileName15, FieldName15, NewCnt15, OldCnt15, RecDiff15, Percent15, NewH15, OldH15, NewC15, OldC15,
                                     AddFile16, LostFile16, FileName16, FieldName16, NewCnt16, OldCnt16, RecDiff16, Percent16, NewH16, OldH16, NewC16, OldC16,
																		 AddFile17, LostFile17, FileName17, FieldName17, NewCnt17, OldCnt17, RecDiff17, Percent17, NewH17, OldH17, NewC17, OldC17,
																		 AddFile18, LostFile18, FileName18, FieldName18, NewCnt18, OldCnt18, RecDiff18, Percent18, NewH18, OldH18, NewC18, OldC18,
																		 AddFile19, LostFile19, FileName19, FieldName19, NewCnt19, OldCnt19, RecDiff19, Percent19, NewH19, OldH19, NewC19, OldC19,
																		 AddFile20, LostFile20, FileName20, FieldName20, NewCnt20, OldCnt20, RecDiff20, Percent20, NewH20, OldH20, NewC20, OldC20,
																		 AddFile21, LostFile21, FileName21, FieldName21, NewCnt21, OldCnt21, RecDiff21, Percent21, NewH21, OldH21, NewC21, OldC21) := FUNCTIONMACRO
    
    // Dataset to define the format of the Table output
   d := dataset([{FileName01, FieldName01, count(AddFile01), count(LostFile01), count(AddFile01) - count(LostFile01), NewCnt01, OldCnt01, RecDiff01, Percent01, NewH01, OldH01, NewC01, OldC01}, 
                 {FileName02, FieldName02, count(AddFile02), count(LostFile02), count(AddFile02) - count(LostFile02), NewCnt02, OldCnt02, RecDiff02, Percent02, NewH02, OldH02, NewC02, OldC02}, 
                 {FileName03, FieldName03, count(AddFile03), count(LostFile03), count(AddFile03) - count(LostFile03), NewCnt03, OldCnt03, RecDiff03, Percent03, NewH03, OldH03, NewC03, OldC03}, 
                 {FileName04, FieldName04, count(AddFile04), count(LostFile04), count(AddFile04) - count(LostFile04), NewCnt04, OldCnt04, RecDiff04, Percent04, NewH04, OldH04, NewC04, OldC04}, 
                 {FileName05, FieldName05, count(AddFile05), count(LostFile05), count(AddFile05) - count(LostFile05), NewCnt05, OldCnt05, RecDiff05, Percent05, NewH05, OldH05, NewC05, OldC05}, 
                 {FileName06, FieldName06, count(AddFile06), count(LostFile06), count(AddFile06) - count(LostFile06), NewCnt06, OldCnt06, RecDiff06, Percent06, NewH06, OldH06, NewC06, OldC06}, 
                 {FileName07, FieldName07, count(AddFile07), count(LostFile07), count(AddFile07) - count(LostFile07), NewCnt07, OldCnt07, RecDiff07, Percent07, NewH07, OldH07, NewC07, OldC07}, 
                 {FileName08, FieldName08, count(AddFile08), count(LostFile08), count(AddFile08) - count(LostFile08), NewCnt08, OldCnt08, RecDiff08, Percent08, NewH08, OldH08, NewC08, OldC08}, 
                 {FileName09, FieldName09, count(AddFile09), count(LostFile09), count(AddFile09) - count(LostFile09), NewCnt09, OldCnt09, RecDiff09, Percent09, NewH09, OldH09, NewC09, OldC09}, 
                 {FileName10, FieldName10, count(AddFile10), count(LostFile10), count(AddFile10) - count(LostFile10), NewCnt10, OldCnt10, RecDiff10, Percent10, NewH10, OldH10, NewC10, OldC10}, 
                 {FileName11, FieldName11, count(AddFile11), count(LostFile11), count(AddFile11) - count(LostFile11), NewCnt11, OldCnt11, RecDiff11, Percent11, NewH11, OldH11, NewC11, OldC11}, 
                 {FileName12, FieldName12, count(AddFile12), count(LostFile12), count(AddFile12) - count(LostFile12), NewCnt12, OldCnt12, RecDiff12, Percent12, NewH12, OldH12, NewC12, OldC12},
                 {FileName13, FieldName13, count(AddFile13), count(LostFile13), count(AddFile13) - count(LostFile13), NewCnt13, OldCnt13, RecDiff13, Percent13, NewH13, OldH13, NewC13, OldC13}, 
                 {FileName14, FieldName14, count(AddFile14), count(LostFile14), count(AddFile14) - count(LostFile14), NewCnt14, OldCnt14, RecDiff14, Percent14, NewH14, OldH14, NewC14, OldC14}, 
                 {FileName15, FieldName15, count(AddFile15), count(LostFile15), count(AddFile15) - count(LostFile15), NewCnt15, OldCnt15, RecDiff15, Percent15, NewH15, OldH15, NewC15, OldC15}, 
                 {FileName16, FieldName16, count(AddFile16), count(LostFile16), count(AddFile16) - count(LostFile16), NewCnt16, OldCnt16, RecDiff16, Percent16, NewH16, OldH16, NewC16, OldC16},
								 {FileName17, FieldName17, count(AddFile17), count(LostFile17), count(AddFile17) - count(LostFile17), NewCnt17, OldCnt17, RecDiff17, Percent17, NewH17, OldH17, NewC17, OldC17},
								 {FileName18, FieldName18, count(AddFile18), count(LostFile18), count(AddFile18) - count(LostFile18), NewCnt18, OldCnt18, RecDiff18, Percent18, NewH18, OldH18, NewC18, OldC18},
								 {FileName19, FieldName19, count(AddFile19), count(LostFile19), count(AddFile19) - count(LostFile19), NewCnt19, OldCnt19, RecDiff19, Percent19, NewH19, OldH19, NewC19, OldC19},
								 {FileName20, FieldName20, count(AddFile20), count(LostFile20), count(AddFile20) - count(LostFile20), NewCnt20, OldCnt20, RecDiff20, Percent20, NewH20, OldH20, NewC20, OldC20},
								 {FileName21, FieldName21, count(AddFile21), count(LostFile21), count(AddFile21) - count(LostFile21), NewCnt21, OldCnt21, RecDiff21, Percent21, NewH21, OldH21, NewC21, OldC21}],
                  // Format
                  {string40 FileName, string12 Field, string40 NumAdded, string40 NumLost, string40 TotalNumGain, string40 NewRecCount, string40 OldRecCount, string40 RecCntGain, string40 PctGain, string40 NewHRec, string40 OldHRec, string40 NewCRec, string40 OldCRec});          

    return output(d, named('CompositeTableOfRecords'));
endmacro;

	EXPORT Field_to_use := MODULE
		EXPORT comp_lnpid	:= RECORD
			unsigned8 lnpid;
		END;
		EXPORT comp_gk	:= RECORD
			string38 group_key;
		END;
		EXPORT comp_did	:= RECORD
			unsigned6 did;
		END;
		EXPORT comp_bdid	:= RECORD
			unsigned6 bdid;
		END;
		EXPORT comp_lic_num	:= RECORD
			string25 lic_num;
		END;
		EXPORT comp_sanc_lic	:= RECORD
			string25 sanc1_lic_num;
		END;
		EXPORT comp_npi_num	:= RECORD
			string10 npi_num;
		END;
		EXPORT comp_assoc_npi	:= RECORD
			string50 bill_npi;
		END;
	END;

	EXPORT Which_file:= MODULE
		EXPORT prev_ind_base	:= dataset('~thor_data400::base::enclarity::individual::father', 	enclarity.layouts.individual_base, 	flat);
		EXPORT curr_ind_base	:= dataset('~thor_data400::base::enclarity::individual::qa', 			enclarity.layouts.individual_base, 	flat);
		EXPORT prev_fac_base	:= dataset('~thor_data400::base::enclarity::facility::father', 		enclarity.layouts.facility_base, 		flat);
		EXPORT curr_fac_base	:= dataset('~thor_data400::base::enclarity::facility::qa', 				enclarity.layouts.facility_base, 		flat);
		EXPORT prev_assoc_base:= dataset('~thor_data400::base::enclarity::associate::father', 	enclarity.layouts.associate_base, 	flat);
		EXPORT curr_assoc_base:= dataset('~thor_data400::base::enclarity::associate::qa', 			enclarity.layouts.associate_base, 	flat);
		EXPORT prev_sanc_base	:= dataset('~thor_data400::base::enclarity::sanction::father', 		enclarity.layouts.sanction_base, 		flat);
		EXPORT curr_sanc_base	:= dataset('~thor_data400::base::enclarity::sanction::qa', 				enclarity.layouts.sanction_base, 		flat);
		EXPORT prev_addr_base	:= dataset('~thor_data400::base::enclarity::address::father', 		enclarity.layouts.address_base, 		flat);
		EXPORT curr_addr_base	:= dataset('~thor_data400::base::enclarity::address::qa', 				enclarity.layouts.address_base, 		flat);
		
		EXPORT new_ind 		:= dedup(sort(distribute(project(curr_ind_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT old_ind 		:= dedup(sort(distribute(project(prev_ind_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT new_ind2 	:= dedup(sort(distribute(project(curr_ind_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT old_ind2 	:= dedup(sort(distribute(project(prev_ind_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT new_ind3 	:= dedup(sort(distribute(project(curr_ind_base, Field_to_use.comp_did),hash(did)),did,local),did,local);
		EXPORT old_ind3 	:= dedup(sort(distribute(project(prev_ind_base, Field_to_use.comp_did),hash(did)),did,local),did,local);
		EXPORT new_ind4 	:= dedup(sort(distribute(project(curr_ind_base, Field_to_use.comp_lic_num),hash(lic_num)),lic_num,local),lic_num,local);
		EXPORT old_ind4 	:= dedup(sort(distribute(project(prev_ind_base, Field_to_use.comp_lic_num),hash(lic_num)),lic_num,local),lic_num,local);
		EXPORT new_ind5 	:= dedup(sort(distribute(project(curr_ind_base, Field_to_use.comp_npi_num),hash(npi_num)),npi_num,local),npi_num,local);
		EXPORT old_ind5 	:= dedup(sort(distribute(project(prev_ind_base, Field_to_use.comp_npi_num),hash(npi_num)),npi_num,local),npi_num,local);
		EXPORT new_ind6 	:= dedup(sort(distribute(project(curr_ind_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);
		EXPORT old_ind6 	:= dedup(sort(distribute(project(prev_ind_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);

		EXPORT new_fac 		:= dedup(sort(distribute(project(curr_fac_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT old_fac 		:= dedup(sort(distribute(project(prev_fac_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT new_fac2 	:= dedup(sort(distribute(project(curr_fac_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT old_fac2 	:= dedup(sort(distribute(project(prev_fac_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT new_fac4 	:= dedup(sort(distribute(project(curr_fac_base, Field_to_use.comp_lic_num),hash(lic_num)),lic_num,local),lic_num,local);
		EXPORT old_fac4 	:= dedup(sort(distribute(project(prev_fac_base, Field_to_use.comp_lic_num),hash(lic_num)),lic_num,local),lic_num,local);
		EXPORT new_fac5 	:= dedup(sort(distribute(project(curr_fac_base, Field_to_use.comp_npi_num),hash(npi_num)),npi_num,local),npi_num,local);
		EXPORT old_fac5 	:= dedup(sort(distribute(project(prev_fac_base, Field_to_use.comp_npi_num),hash(npi_num)),npi_num,local),npi_num,local);
		EXPORT new_fac6 	:= dedup(sort(distribute(project(curr_fac_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);
		EXPORT old_fac6 	:= dedup(sort(distribute(project(prev_fac_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);

		EXPORT new_sanc 	:= dedup(sort(distribute(project(curr_sanc_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT old_sanc 	:= dedup(sort(distribute(project(prev_sanc_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT new_sanc2 	:= dedup(sort(distribute(project(curr_sanc_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT old_sanc2 	:= dedup(sort(distribute(project(prev_sanc_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT new_sanc4 	:= dedup(sort(distribute(project(curr_sanc_base, Field_to_use.comp_sanc_lic),hash(sanc1_lic_num)),sanc1_lic_num,local),sanc1_lic_num,local);
		EXPORT old_sanc4 	:= dedup(sort(distribute(project(prev_sanc_base, Field_to_use.comp_sanc_lic),hash(sanc1_lic_num)),sanc1_lic_num,local),sanc1_lic_num,local);

		EXPORT new_assoc 	:= dedup(sort(distribute(project(curr_assoc_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT old_assoc 	:= dedup(sort(distribute(project(prev_assoc_base, Field_to_use.comp_lnpid),hash(lnpid)),lnpid,local),lnpid,local);
		EXPORT new_assoc2 := dedup(sort(distribute(project(curr_assoc_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT old_assoc2 := dedup(sort(distribute(project(prev_assoc_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT new_assoc3 := dedup(sort(distribute(project(curr_assoc_base, Field_to_use.comp_did),hash(did)),did,local),did,local);
		EXPORT old_assoc3 := dedup(sort(distribute(project(prev_assoc_base, Field_to_use.comp_did),hash(did)),did,local),did,local);	
		EXPORT new_assoc5 := dedup(sort(distribute(project(curr_assoc_base, Field_to_use.comp_assoc_npi),hash(bill_npi)),bill_npi,local),bill_npi,local);
		EXPORT old_assoc5 := dedup(sort(distribute(project(prev_assoc_base, Field_to_use.comp_assoc_npi),hash(bill_npi)),bill_npi,local),bill_npi,local);
		EXPORT new_assoc6 := dedup(sort(distribute(project(curr_assoc_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);
		EXPORT old_assoc6 := dedup(sort(distribute(project(prev_assoc_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);

		EXPORT new_addr2 := dedup(sort(distribute(project(curr_addr_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT old_addr2 := dedup(sort(distribute(project(prev_addr_base, Field_to_use.comp_gk),hash(group_key)),group_key,local),group_key,local);
		EXPORT new_addr6 := dedup(sort(distribute(project(curr_addr_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);
		EXPORT old_addr6 := dedup(sort(distribute(project(prev_addr_base, Field_to_use.comp_bdid),hash(bdid)),bdid,local),bdid,local);

	END;

	EXPORT	What_to_do	:= MODULE
	
		SHARED Field_to_use.comp_lnpid	JoinInd(Which_file.new_ind L, Which_file.old_ind R)	:= TRANSFORM, SKIP(L.lnpid = R.lnpid)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_lnpid	JoinFac(Which_file.new_fac L, Which_file.old_fac R)	:= TRANSFORM, SKIP(L.lnpid = R.lnpid)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_lnpid	JoinSanc(Which_file.new_sanc L, Which_file.old_sanc R)	:= TRANSFORM, SKIP(L.lnpid = R.lnpid)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_lnpid	JoinAssoc(Which_file.new_assoc L, Which_file.old_assoc R)	:= TRANSFORM, SKIP(L.lnpid = R.lnpid)
			SELF	:= L;
		END;				
		SHARED Field_to_use.comp_gk	JoinInd2(Which_file.new_ind2 L, Which_file.old_ind2 R)	:= TRANSFORM, SKIP(L.group_key = R.group_key)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_gk	JoinFac2(Which_file.new_fac2 L, Which_file.old_fac2 R)	:= TRANSFORM, SKIP(L.group_key = R.group_key)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_gk	JoinSanc2(Which_file.new_sanc2 L, Which_file.old_sanc2 R)	:= TRANSFORM, SKIP(L.group_key = R.group_key)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_gk	JoinAssoc2(Which_file.new_assoc2 L, Which_file.old_assoc2 R)	:= TRANSFORM, SKIP(L.group_key = R.group_key)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_gk	JoinAddr2(Which_file.new_addr2 L, Which_file.old_addr2 R)	:= TRANSFORM, SKIP(L.group_key = R.group_key)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_did	JoinInd3(Which_file.new_ind3 L, Which_file.old_ind3 R)	:= TRANSFORM, SKIP(L.did = R.did)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_did	JoinAssoc3(Which_file.new_assoc3 L, Which_file.old_assoc3 R)	:= TRANSFORM, SKIP(L.did = R.did)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_lic_num	JoinInd4(Which_file.new_ind4 L, Which_file.old_ind4 R)	:= TRANSFORM, SKIP(L.lic_num = R.lic_num)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_lic_num	JoinFac4(Which_file.new_fac4 L, Which_file.old_fac4 R)	:= TRANSFORM, SKIP(L.lic_num = R.lic_num)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_sanc_lic	JoinSanc4(Which_file.new_sanc4 L, Which_file.old_sanc4 R)	:= TRANSFORM, SKIP(L.sanc1_lic_num = R.sanc1_lic_num)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_npi_num	JoinInd5(Which_file.new_ind5 L, Which_file.old_ind5 R)	:= TRANSFORM, SKIP(L.npi_num = R.npi_num)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_npi_num	JoinFac5(Which_file.new_fac5 L, Which_file.old_fac5 R)	:= TRANSFORM, SKIP(L.npi_num = R.npi_num)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_assoc_npi	JoinAssoc5(Which_file.new_assoc5 L, Which_file.old_assoc5 R)	:= TRANSFORM, SKIP(L.bill_npi = R.bill_npi)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_bdid	JoinInd6(Which_file.new_ind6 L, Which_file.old_ind6 R)	:= TRANSFORM, SKIP(L.bdid = R.bdid)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_bdid	JoinFac6(Which_file.new_fac6 L, Which_file.old_fac6 R)	:= TRANSFORM, SKIP(L.bdid = R.bdid)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_bdid	JoinAssoc6(Which_file.new_assoc6 L, Which_file.old_assoc6 R)	:= TRANSFORM, SKIP(L.bdid= R.bdid)
			SELF	:= L;
		END;
		SHARED Field_to_use.comp_bdid	JoinAddr6(Which_file.new_addr6 L, Which_file.old_addr6 R)	:= TRANSFORM, SKIP(L.bdid= R.bdid)
			SELF	:= L;
		END;

		
		EXPORT base_a	:= dedup(JOIN(Which_file.new_ind, Which_file.old_ind,	LEFT = RIGHT,
										JoinInd(LEFT,RIGHT), LEFT OUTER, local), all);
										
		EXPORT base_b	:= dedup(JOIN(Which_file.old_ind, Which_file.new_ind,	LEFT = RIGHT,
										JoinInd(LEFT,RIGHT), LEFT OUTER, local), all);
		
		EXPORT base_a2	:= dedup(JOIN(Which_file.new_ind2, Which_file.old_ind2, LEFT = RIGHT,
										JoinInd2(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_b2	:= dedup(JOIN(Which_file.old_ind2, Which_file.new_ind2,	LEFT = RIGHT,
										JoinInd2(LEFT,RIGHT),	LEFT OUTER, local), all);
								
		EXPORT base_a3	:= dedup(JOIN(Which_file.new_ind3, Which_file.old_ind3,	LEFT = RIGHT,
										JoinInd3(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_b3	:= dedup(JOIN(Which_file.old_ind3, Which_file.new_ind3,	LEFT = RIGHT,
										JoinInd3(LEFT,RIGHT),	LEFT OUTER, local), all);

		EXPORT base_a4	:= dedup(JOIN(Which_file.new_ind4, Which_file.old_ind4,	LEFT = RIGHT,
										JoinInd4(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_b4	:= dedup(JOIN(Which_file.old_ind4, Which_file.new_ind4,	LEFT = RIGHT,
										JoinInd4(LEFT,RIGHT),	LEFT OUTER, local), all);
								
		EXPORT base_a5	:= dedup(JOIN(Which_file.new_ind5, Which_file.old_ind5,	LEFT = RIGHT,
										JoinInd5(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_b5	:= dedup(JOIN(Which_file.old_ind5, Which_file.new_ind5, LEFT = RIGHT,
										JoinInd5(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_a6	:= dedup(JOIN(Which_file.new_ind6, Which_file.old_ind6,	LEFT = RIGHT,
										JoinInd6(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_b6	:= dedup(JOIN(Which_file.old_ind6, Which_file.new_ind6, LEFT = RIGHT,
										JoinInd6(LEFT,RIGHT),	LEFT OUTER, local), all);
				
		EXPORT new_ind_cnt	:= count(Which_file.curr_ind_base);
		EXPORT old_ind_cnt	:= count(Which_file.prev_ind_base);
		EXPORT ind_cnt_diff	:= new_ind_cnt - old_ind_cnt;
		EXPORT ind_pct			:= (ind_cnt_diff/old_ind_cnt) * 100;
		EXPORT new_ind_h_cnt:= count(Which_file.curr_ind_base(record_type='H'));
		EXPORT old_ind_h_cnt:= count(Which_file.prev_ind_base(record_type='H'));
		EXPORT new_ind_c_cnt:= count(Which_file.curr_ind_base(record_type='C'));
		EXPORT old_ind_c_cnt:= count(Which_file.prev_ind_base(record_type='C'));
		
		EXPORT base_c	:= dedup(JOIN(Which_file.new_fac, Which_file.old_fac,	LEFT = RIGHT,
										JoinFac(LEFT,RIGHT), LEFT OUTER, local), all);
										
		EXPORT base_d	:= dedup(JOIN(Which_file.old_fac, Which_file.new_fac,	LEFT = RIGHT,
										JoinFac(LEFT,RIGHT), LEFT OUTER, local), all);
		
		EXPORT base_c2	:= dedup(JOIN(Which_file.new_fac2, Which_file.old_fac2,	LEFT = RIGHT,
										JoinFac2(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_d2	:= dedup(JOIN(Which_file.old_fac2, Which_file.new_fac2,	LEFT = RIGHT,
										JoinFac2(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_c4	:= dedup(JOIN(Which_file.new_fac4, Which_file.old_fac4,	LEFT = RIGHT,
										JoinFac4(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_d4	:= dedup(JOIN(Which_file.old_fac4, Which_file.new_fac4,	LEFT = RIGHT,
										JoinFac4(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_c5	:= dedup(JOIN(Which_file.new_fac5, Which_file.old_fac5,	LEFT = RIGHT,
										JoinFac5(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_d5	:= dedup(JOIN(Which_file.old_fac5, Which_file.new_fac5,	LEFT = RIGHT,
										JoinFac5(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_c6	:= dedup(JOIN(Which_file.new_fac6, Which_file.old_fac6,	LEFT = RIGHT,
										JoinFac6(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_d6	:= dedup(JOIN(Which_file.old_fac6, Which_file.new_fac6,	LEFT = RIGHT,
										JoinFac6(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT new_fac_cnt	:= count(Which_file.curr_fac_base);
		EXPORT old_fac_cnt	:= count(Which_file.prev_fac_base);
		EXPORT fac_cnt_diff	:= new_fac_cnt - old_fac_cnt;
		EXPORT fac_pct			:= (fac_cnt_diff/old_fac_cnt) * 100;
		EXPORT new_fac_h_cnt:= count(Which_file.curr_fac_base(record_type='H'));
		EXPORT old_fac_h_cnt:= count(Which_file.prev_fac_base(record_type='H'));
		EXPORT new_fac_c_cnt:= count(Which_file.curr_fac_base(record_type='C'));
		EXPORT old_fac_c_cnt:= count(Which_file.prev_fac_base(record_type='C'));
									
		EXPORT base_e	:= dedup(JOIN(Which_file.new_sanc, Which_file.old_sanc,	LEFT = RIGHT,
										JoinSanc(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_f	:= dedup(JOIN(Which_file.old_sanc, Which_file.new_sanc,	LEFT = RIGHT,
										JoinSanc(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_e2	:= dedup(JOIN(Which_file.new_sanc2, Which_file.old_sanc2,	LEFT = RIGHT,
										JoinSanc2(LEFT,RIGHT),LEFT OUTER, local), all);
										
		EXPORT base_f2	:= dedup(JOIN(Which_file.old_sanc2, Which_file.new_sanc2,	LEFT = RIGHT,
										JoinSanc2(LEFT,RIGHT), LEFT OUTER, local), all);
		
		EXPORT base_e4	:= dedup(JOIN(Which_file.new_sanc4, Which_file.old_sanc4,	LEFT = RIGHT,
										JoinSanc4(LEFT,RIGHT), LEFT OUTER, local), all);
										
		EXPORT base_f4	:= dedup(JOIN(Which_file.old_sanc4, Which_file.new_sanc4,	LEFT = RIGHT,
										JoinSanc4(LEFT,RIGHT), LEFT OUTER, local), all);
		
		EXPORT new_sanc_cnt	:= count(Which_file.curr_sanc_base);
		EXPORT old_sanc_cnt	:= count(Which_file.prev_sanc_base);
		EXPORT sanc_cnt_diff	:= new_sanc_cnt - old_sanc_cnt;
		EXPORT sanc_pct			:= (sanc_cnt_diff/old_sanc_cnt) * 100;
		EXPORT new_sanc_h_cnt:= count(Which_file.curr_sanc_base(record_type='H'));
		EXPORT old_sanc_h_cnt:= count(Which_file.prev_sanc_base(record_type='H'));
		EXPORT new_sanc_c_cnt:= count(Which_file.curr_sanc_base(record_type='C'));
		EXPORT old_sanc_c_cnt:= count(Which_file.prev_sanc_base(record_type='C'));
												
		EXPORT base_g	:= dedup(JOIN(Which_file.new_assoc, Which_file.old_assoc,	LEFT = RIGHT,
										JoinAssoc(LEFT,RIGHT), LEFT OUTER, local), all);
										
		EXPORT base_h	:= dedup(JOIN(Which_file.old_assoc, Which_file.new_assoc,	LEFT = RIGHT,
										JoinAssoc(LEFT,RIGHT), LEFT OUTER, local), all);
		
		EXPORT base_g2	:= dedup(JOIN(Which_file.new_assoc2, Which_file.old_assoc2,	LEFT = RIGHT,
										JoinAssoc2(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_h2	:= dedup(JOIN(Which_file.old_assoc2, Which_file.new_assoc2,	LEFT = RIGHT,
										JoinAssoc2(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_g3	:= dedup(JOIN(Which_file.new_assoc3, Which_file.old_assoc3,	LEFT = RIGHT,
										JoinAssoc3(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_h3	:= dedup(JOIN(Which_file.old_assoc3, Which_file.new_assoc3,	LEFT = RIGHT,
										JoinAssoc3(LEFT,RIGHT),	LEFT OUTER, local), all);
																										
		EXPORT base_g5	:= dedup(JOIN(Which_file.new_assoc5, Which_file.old_assoc5,	LEFT = RIGHT,
										JoinAssoc5(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_h5	:= dedup(JOIN(Which_file.old_assoc5, Which_file.new_assoc5,	LEFT = RIGHT,
										JoinAssoc5(LEFT,RIGHT),	LEFT OUTER, local), all);
		
		EXPORT base_g6	:= dedup(JOIN(Which_file.new_assoc6, Which_file.old_assoc6,	LEFT = RIGHT,
										JoinAssoc6(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_h6	:= dedup(JOIN(Which_file.old_assoc6, Which_file.new_assoc6,	LEFT = RIGHT,
										JoinAssoc6(LEFT,RIGHT),	LEFT OUTER, local), all);

		EXPORT new_assoc_cnt	:= count(Which_file.curr_assoc_base);
		EXPORT old_assoc_cnt	:= count(Which_file.prev_assoc_base);
		EXPORT assoc_cnt_diff	:= new_assoc_cnt - old_assoc_cnt;
		EXPORT assoc_pct			:= (assoc_cnt_diff/old_assoc_cnt) * 100;
		EXPORT new_assoc_h_cnt:= count(Which_file.curr_assoc_base(record_type='H'));
		EXPORT old_assoc_h_cnt:= count(Which_file.prev_assoc_base(record_type='H'));
		EXPORT new_assoc_c_cnt:= count(Which_file.curr_assoc_base(record_type='C'));
		EXPORT old_assoc_c_cnt:= count(Which_file.prev_assoc_base(record_type='C'));
		
		EXPORT base_i2	:= dedup(JOIN(Which_file.new_addr2, Which_file.old_addr2,	LEFT = RIGHT,
										JoinAddr2(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_j2	:= dedup(JOIN(Which_file.old_addr2, Which_file.new_addr2,	LEFT = RIGHT,
										JoinAddr2(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_i6	:= dedup(JOIN(Which_file.new_addr6, Which_file.old_addr6,	LEFT = RIGHT,
										JoinAddr6(LEFT,RIGHT),	LEFT OUTER, local), all);
										
		EXPORT base_j6	:= dedup(JOIN(Which_file.old_addr6, Which_file.new_addr6,	LEFT = RIGHT,
										JoinAddr6(LEFT,RIGHT),	LEFT OUTER, local), all);	
		
		EXPORT new_addr_cnt	:= count(Which_file.curr_addr_base);
		EXPORT old_addr_cnt	:= count(Which_file.prev_addr_base);
		EXPORT addr_cnt_diff	:= new_addr_cnt - old_addr_cnt;
		EXPORT addr_pct			:= (addr_cnt_diff/old_addr_cnt) * 100;
		EXPORT new_addr_h_cnt:= count(Which_file.curr_addr_base(record_type='H'));
		EXPORT old_addr_h_cnt:= count(Which_file.prev_addr_base(record_type='H'));
		EXPORT new_addr_c_cnt:= count(Which_file.curr_addr_base(record_type='C'));
		EXPORT old_addr_c_cnt:= count(Which_file.prev_addr_base(record_type='C'));
																		
	END;
	   
	EXPORT Show_me_the_output	:= SEQUENTIAL(
        OutputTablePopulationCompositeRecord(
							What_to_do.base_a,  What_to_do.base_b, 	'individual', 'lnpid', What_to_do.new_ind_cnt, What_to_do.old_ind_cnt, What_to_do.ind_cnt_diff, What_to_do.ind_pct, What_to_do.new_ind_h_cnt, What_to_do.old_ind_h_cnt, What_to_do.new_ind_c_cnt, What_to_do.old_ind_c_cnt,
				      What_to_do.base_a2, What_to_do.base_b2,	'individual', 'group_key','<- group_key','lost','should','be zero','','','','',
              What_to_do.base_a3, What_to_do.base_b3,	'individual', 'did','','','','','','','','',
              What_to_do.base_a4, What_to_do.base_b4,	'individual', 'lic_num','','','','','','','','',
              What_to_do.base_a5, What_to_do.base_b5,	'individual', 'npi_num','','','','','','','','',
							What_to_do.base_a6, What_to_do.base_b6,	'individual',	'bdid','','','','','','','','',

              What_to_do.base_c,  What_to_do.base_d, 	'facility', 'lnpid', What_to_do.new_fac_cnt, What_to_do.old_fac_cnt, What_to_do.fac_cnt_diff, What_to_do.fac_pct, What_to_do.new_fac_h_cnt, What_to_do.old_fac_h_cnt, What_to_do.new_fac_c_cnt, What_to_do.old_fac_c_cnt,
		          What_to_do.base_c2, What_to_do.base_d2,	'facility', 'group_key','<- group_key','lost','should','be zero','','','','',
              What_to_do.base_c4, What_to_do.base_d4,	'facility', 'lic_num','','','','','','','','',
              What_to_do.base_c5, What_to_do.base_d5,	'facility', 'npi_num','','','','','','','','',
							What_to_do.base_c6, What_to_do.base_d6,	'facility',	'bdid','','','','','','','','',
																						 
							What_to_do.base_g,  What_to_do.base_h, 	'associate', 'lnpid', What_to_do.new_assoc_cnt, What_to_do.old_assoc_cnt, What_to_do.assoc_cnt_diff, What_to_do.assoc_pct, What_to_do.new_assoc_h_cnt, What_to_do.old_assoc_h_cnt, What_to_do.new_assoc_c_cnt, What_to_do.old_assoc_c_cnt,
							What_to_do.base_g2, What_to_do.base_h2, 'associate', 'group_key','<- group_key','lost','should','be zero','','','','',
              What_to_do.base_g3, What_to_do.base_h3, 'associate', 'did','','','','','','','','',
							What_to_do.base_g5, What_to_do.base_h5, 'associate', 'npi_num','','','','','','','','',
							What_to_do.base_g6, What_to_do.base_h6,	'associate',	'bdid','','','','','','','','',

              What_to_do.base_e,  What_to_do.base_f, 	'sanction', 'lnpid', What_to_do.new_sanc_cnt, What_to_do.old_sanc_cnt, What_to_do.sanc_cnt_diff, What_to_do.sanc_pct, What_to_do.new_sanc_h_cnt, What_to_do.old_sanc_h_cnt, What_to_do.new_sanc_c_cnt, What_to_do.old_sanc_c_cnt,
              What_to_do.base_e2, What_to_do.base_f2,	'sanction', 'group_key','<- group_key','lost','should','be zero','','','','',
              What_to_do.base_e4, What_to_do.base_f4, 'sanction', 'lic_num','','','','','','','','',
																						 
							What_to_do.base_i2, What_to_do.base_j2,	'address',	'group_key', What_to_do.new_addr_cnt, What_to_do.old_addr_cnt, What_to_do.addr_cnt_diff, What_to_do.addr_pct, What_to_do.new_addr_h_cnt, What_to_do.old_addr_h_cnt, What_to_do.new_addr_c_cnt, What_to_do.old_addr_c_cnt,
							What_to_do.base_i6, What_to_do.base_j6,	'address',	'bdid','group_key','lost','(previous row)','should','be zero','','','');
         
    
        // Individual - Samples
        output(What_to_do.base_a, named('individual_lnpid_added'));
        output(What_to_do.base_b, named('individual_lnpid_lost'));
        output(What_to_do.base_a2, named('individual_group_key_added'));
        output(What_to_do.base_b2, named('individual_group_key_lost'));
        output(What_to_do.base_a3, named('individual_did_added'));
        output(What_to_do.base_b3, named('individual_did_lost'));
        output(What_to_do.base_a4, named('individual_lic_num_added'));
        output(What_to_do.base_b4, named('individual_lic_num_lost'));
        output(What_to_do.base_a5, named('individual_npi_num_added'));
        output(What_to_do.base_b5, named('individual_npi_num_lost'));
        output(What_to_do.base_a6, named('individual_bdid_added'));
        output(What_to_do.base_b6, named('individual_bdid_lost'));

				//  Facility - Samples 
        output(What_to_do.base_c, named('facility_lnpid_added'));
        output(What_to_do.base_d, named('facility_lnpid_lost'));
        output(What_to_do.base_c2, named('facility_group_key_added'));
        output(What_to_do.base_d2, named('facility_group_key_lost'));
        output(What_to_do.base_c4, named('facility_lic_num_added'));
        output(What_to_do.base_d4, named('facility_lic_num_lost'));
        output(What_to_do.base_c5, named('facility_npi_num_added'));
        output(What_to_do.base_d5, named('facility_npi_num_lost'));
        output(What_to_do.base_c6, named('facility_bdid_added'));
        output(What_to_do.base_d6, named('facility_bdid_lost'));

				//  Sanction - Samples
        output(What_to_do.base_e, named('sanction_lnpid_added'));
        output(What_to_do.base_f, named('sanction_lnpid_lost'));
        output(What_to_do.base_e2, named('sanction_group_key_added'));
        output(What_to_do.base_f2, named('sanction_group_key_lost'));
        output(What_to_do.base_e4, named('sanction_lic_num_added'));
        output(What_to_do.base_f4, named('sanction_lic_num_lost'));

				//   Associate - Samples
        output(What_to_do.base_g, named('associate_lnpid_added'));
        output(What_to_do.base_h, named('associate_lnpid_lost'));
        output(What_to_do.base_g2, named('associate_group_key_added'));
        output(What_to_do.base_h2, named('associate_group_key_lost'));
        output(What_to_do.base_g3, named('associate_did_added'));
        output(What_to_do.base_h3, named('associate_did_lost'));
        output(What_to_do.base_g5, named('associate_npi_num_added'));
        output(What_to_do.base_h5, named('associate_npi_num_lost'));
				output(What_to_do.base_g6, named('associate_bdid_added'));
        output(What_to_do.base_h6, named('associate_bdid_lost'));
				
				//   Address - Samples
        output(What_to_do.base_i2, named('address_group_key_added'));
        output(What_to_do.base_j2, named('address_group_key_lost'));
				output(What_to_do.base_i6, named('address_bdid_added'));
        output(What_to_do.base_j6, named('address_bdid_lost'))
	  );
END;
