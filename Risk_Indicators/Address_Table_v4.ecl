import header, ut, avm_v2, fcra, header_quick, doxie_build, mdr, Std;

export Address_Table_v4(boolean isFCRA) := function
	
h_full := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building)(trim(prim_name)<>'' and length(trim(zip))=5 and (integer)zip<>0 and ~iid_constants.filtered_source(src, st));
h_quick := project( header_quick.file_header_quick(trim(prim_name)<>'' and length(trim(zip))=5 and (integer)zip<>0 and ~iid_constants.filtered_source(src, st)), 
													transform(header.Layout_Header, self.src := IF(left.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, left.src), self := left));
headerprod_building := ungroup(h_full + h_quick);

valid_header_uncorrected := if(isFCRA, headerprod_building(~fcra.Restricted_Header_Src(src, vendor_id[1]) AND
																			((src='BA' AND FCRA.bankrupt_is_ok((STRING8)Std.Date.Today(),(string)dt_first_seen)) OR
																				(src='L2' AND FCRA.lien_is_ok((STRING8)Std.Date.Today(),(string)dt_first_seen)) OR src NOT IN ['BA','L2'])),
																	headerprod_building);
/* ****************************************************
 *                  Apply Corrections                 *
 ****************************************************** */
valid_header_corrected := Risk_Indicators.Header_Corrections_Function(valid_header_uncorrected);

valid_header_before_suppress := IF(isFCRA, valid_header_corrected, valid_header_uncorrected);

valid_header := fn_suppress_ccpa(valid_header_before_suppress, TRUE, 'RiskTable', 'src', 'global_sid', TRUE); // CCPA-795: OptOut Prefilter Data Layer

/* ****************************************************
 * Corrections have been applied - Continue as normal *
 ****************************************************** */
combo := Address_Table_Function(valid_header);				// full header
eq := Address_Table_Function(valid_header(src not in [mdr.sourceTools.src_Experian_Credit_Header, mdr.sourceTools.src_TU_CreditHeader]));	// header for use in equifax products
en := Address_Table_Function(valid_header(src not in [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_TU_CreditHeader]));	// header for use in experian products
tn := Address_Table_Function(valid_header(src not in [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_Experian_Credit_Header]));	// header for use in transunion products

layout_counts := record
	unsigned2 ssn_ct;
	unsigned2 ssn_ct_c6;
	unsigned2 did_ct;
	unsigned2 did_ct_c6;
end;

layout_avm := record
	string5 fips_code;
	string7 geo_blk;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer price_index_valuation;
	integer tax_assessment_valuation;
	integer hedonic_valuation;
	integer automated_valuation;
	integer confidence_score;
end;

layout_addr_risk := record
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string8 sec_range;
	string5 zip;
	layout_counts combo;
	layout_counts eq;
	layout_counts en;
	layout_counts tn;
	layout_avm;
	//CCPA-768
	UNSIGNED4	global_sid := 0;
	UNSIGNED8 record_sid := 0;
end;

// join combo to eq
addr_table_eq := join(combo, eq, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
											 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
											transform(layout_addr_risk, 
														use_right := left.zip='';
														self.prim_range := if(use_right, right.prim_range, left.prim_range),
														self.predir := if(use_right, right.predir , left.predir ),
														self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
														self.suffix := if(use_right, right.suffix , left.suffix ),
														self.postdir := if(use_right, right.postdir , left.postdir ),
														self.sec_range := if(use_right, right.sec_range , left.sec_range ),
														self.zip := if(use_right, right.zip , left.zip ),
														// populate the combo portion
														self.combo.ssn_ct := left.ssn_ct,
														self.combo.ssn_ct_c6 := left.ssn_ct_c6,
														self.combo.did_ct := left.did_ct,
														self.combo.did_ct_c6 := left.did_ct_c6,
														// populate the eq portion
														self.eq.ssn_ct := right.ssn_ct,
														self.eq.ssn_ct_c6 := right.ssn_ct_c6,
														self.eq.did_ct := right.did_ct,
														self.eq.did_ct_c6 := right.did_ct_c6,
														// en and avm are blank yet
														self := []), 
											left outer, local);

// add in en										
addr_table_eqen := join(addr_table_eq, en, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
												 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
												transform(layout_addr_risk, 
															use_right := left.zip='';
															self.prim_range := if(use_right, right.prim_range, left.prim_range),
															self.predir := if(use_right, right.predir , left.predir ),
															self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
															self.suffix := if(use_right, right.suffix , left.suffix ),
															self.postdir := if(use_right, right.postdir , left.postdir ),
															self.sec_range := if(use_right, right.sec_range , left.sec_range ),
															self.zip := if(use_right, right.zip , left.zip ),
															// populate the en portion
															self.en.ssn_ct := right.ssn_ct,
															self.en.ssn_ct_c6 := right.ssn_ct_c6,
															self.en.did_ct := right.did_ct,
															self.en.did_ct_c6 := right.did_ct_c6,
															
															self := left), 
												full outer, local);

// add in en										
addr_table_eqenTN := join(addr_table_eqen, tn, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
												 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
												transform(layout_addr_risk, 
															use_right := left.zip='';
															self.prim_range := if(use_right, right.prim_range, left.prim_range),
															self.predir := if(use_right, right.predir , left.predir ),
															self.prim_name  := if(use_right, right.prim_name , left.prim_name ),
															self.suffix := if(use_right, right.suffix , left.suffix ),
															self.postdir := if(use_right, right.postdir , left.postdir ),
															self.sec_range := if(use_right, right.sec_range , left.sec_range ),
															self.zip := if(use_right, right.zip , left.zip ),
															// populate the transunion header portion
															self.tn.ssn_ct := right.ssn_ct,
															self.tn.ssn_ct_c6 := right.ssn_ct_c6,
															self.tn.did_ct := right.did_ct,
															self.tn.did_ct_c6 := right.did_ct_c6,
															self := left), 
												full outer, local);
												
												
// do the avm part just once
avm_distr := distribute(avm_v2.File_AVM_Base(trim(prim_name)<>'' and trim(zip)<>''), hash(zip,prim_range,predir,prim_name,suffix,postdir,sec_range));

persist_name := IF (IsFCRA, 'persist::address_risk_v4_filtered', 'persist::address_risk_v4'); 

addr_rsk_tbl := join(addr_table_eqenTN, avm_distr, left.zip=right.zip and left.prim_range=right.prim_range and left.predir=right.predir and
											 left.prim_name=right.prim_name and left.suffix=right.suffix and left.postdir=right.postdir and left.sec_range=right.sec_range,
											transform(layout_addr_risk, 
														self.prim_range := left.prim_range,
														self.predir := left.predir ,
														self.prim_name  := left.prim_name,
														self.suffix := left.suffix ,
														self.postdir := left.postdir,
														self.sec_range := left.sec_range,
														self.zip := left.zip,
														self := right,
														self := left), 
											left outer, keep(1), local) : persist(persist_name);
											
addGlobalSID := mdr.macGetGlobalSID(addr_rsk_tbl,'RiskTable_Virtual','','global_sid'); //DF-26530: Populate Global_SID Field

return addGlobalSID;

end;
											

