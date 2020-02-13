import  UCCV2,RoxieKeyBuild,promoteSupers,autokey;

export Proc_Build_UCC_Keys(string filedate) := function

SuperKeyName       := cluster.cluster_out+'Key::ucc::';
BaseKeyName 		:= SuperKeyName+filedate;

// Process NON-FCRA KEYS																
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_did,SuperKeyName+'did',BaseKeyName+'::did',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_bdid,SuperKeyName+'bdid',BaseKeyName+'::bdid',key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_ssn,SuperKeyName+'ssn',BaseKeyName+'::ssn',key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_fein,SuperKeyName+'fein',BaseKeyName+'::fein',key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_jurisdiction,SuperKeyName+'jurisdiction',BaseKeyName+'::jurisdiction',key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_main(),SuperKeyName+'main_rmsid',BaseKeyName+'::main_rmsid',key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_party(),SuperKeyName+'party_rmsid',BaseKeyName+'::party_rmsid',key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_filing_number,SuperKeyName+'Filing_number',BaseKeyName+'::filing_number',key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_filing_date,SuperKeyName+'filing_date',BaseKeyName+'::Filing_date',key9); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_RMSID,SuperKeyName+'RMSID',BaseKeyName+'::RMSID',key10); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(uccv2.Key_Did_w_Type(),SuperKeyName+'did_w_type',BaseKeyName+'::did_w_type',key11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(uccv2.Key_Bdid_w_Type,SuperKeyName+'bdid_w_type',BaseKeyName+'::bdid_w_type',key12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(UCCV2.Key_LinkIds.key,SuperKeyName+'linkids',BaseKeyName+'::linkids',key13);
//Deprecated Key - Jira DF-26976
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_party_linkids(),SuperKeyName+'party_rmsid_linkids',BaseKeyName+'::party_rmsid_linkids',key14);

Keys_NON_FCRA := parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13);

//Move NON_FCRA Logical Key File Names to the associated Key Superfile Names
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did',BaseKeyName+'::did',mv1,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid',BaseKeyName+'::bdid',mv2,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'ssn',BaseKeyName+'::ssn',mv3,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'fein',BaseKeyName+'::fein',mv4,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'jurisdiction',BaseKeyName+'::jurisdiction',mv5,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'main_rmsid',BaseKeyName+'::main_rmsid',mv6,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'party_rmsid',BaseKeyName+'::party_rmsid',mv7,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'Filing_number',BaseKeyName+'::filing_number',mv8,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'filing_date',BaseKeyName+'::Filing_date',mv9,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'RMSID',BaseKeyName+'::RMSID',mv10,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'did_w_type',BaseKeyName+'::did_w_type',mv11,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'bdid_w_type',BaseKeyName+'::bdid_w_type',mv12,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'linkids',BaseKeyName+'::linkids',mv13,2);
//RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'party_rmsid_linkids',BaseKeyName+'::party_rmsid_linkids',mv14,2);

Move_NON_FCRA_keys := parallel(mv1, mv2, mv3, mv4, mv5, mv6, mv7, mv8, mv9,mv10,mv11,mv12,mv13);	

//Move NON_FCRA Keys from Built to QA
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'did','Q',toq1,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'bdid','Q',toq2,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'ssn','Q',toq3,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'fein','Q',toq4,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'jurisdiction','Q',toq5,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'main_rmsid','Q',toq6,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'party_rmsid','Q',toq7,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'Filing_number','Q',toq8,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'filing_date','Q',toq9,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'RMSID','Q',toq10,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'did_w_type','Q',toq11,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'bdid_w_type','Q',toq12,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'linkids','Q',toq13,2);
//promoteSupers.MAC_SK_Move_V2(SuperKeyName+'party_rmsid_linkids','Q',toq14,2);
						
To_NON_FCRA_qa    :=parallel(toq1, toq2, toq3, toq4, toq5, toq6, toq7, toq8, toq9,toq10,toq11,toq12,toq13);


// Process FCRA KEYS		
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_main(true),SuperKeyName+'fcra::main_rmsid',BaseKeyName+'::fcra::main_rmsid',key1_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_rmsid_party(true),SuperKeyName+'fcra::party_rmsid',BaseKeyName+'::fcra::party_rmsid',key2_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(uccv2.Key_Did_w_Type(true),SuperKeyName+'fcra::did_w_type',BaseKeyName+'::fcra::did_w_type',key3_fcra);

Keys_FCRA := parallel(key1_fcra,key2_fcra,key3_fcra);


//Move FCRA Logical Key File Names to the associated Key Superfile Names
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'fcra::main_rmsid',BaseKeyName+'::fcra::main_rmsid',mv1_fcra,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'fcra::party_rmsid',BaseKeyName+'::fcra::party_rmsid',mv2_fcra,2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'fcra::did_w_type',BaseKeyName+'::fcra::did_w_type',mv3_fcra,2);

Move_FCRA_keys := parallel(mv1_fcra, mv2_fcra, mv3_fcra);	

//Move FCRA Keys from Built to QA
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'fcra::main_rmsid','Q',toq1_fcra,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'fcra::party_rmsid','Q',toq2_fcra,2);
promoteSupers.MAC_SK_Move_V2(SuperKeyName+'fcra::did_w_type','Q',toq3_fcra,2);
						
To_FCRA_qa :=parallel(toq1_fcra, toq2_fcra, toq3_fcra);	



d := uccv2.File_UCC_Main_Base(not regexfind('[a-zA-Z]+',process_date) and process_date <= filedate);

new_rec := record
	string3 tms;
	d.process_date;
end;

new_rec proj_rec(d l) := transform
	self.tms := if(l.tmsid[1..3] = 'NYC' or l.tmsid[1..3] = 'TXH' or l.tmsid[1..3] = 'TXD',l.tmsid[1..3],l.tmsid[1..2]);
	self := l;
end;

proj_out := project(d,proj_rec(left));

sub_rec := record
	proj_out.tms;
	string8 max_process_date := max(group,proj_out.process_date);
end;

sub_tab := table(proj_out,sub_rec,tms,few);

uccv2.Layout_UCC_Common.Layout_ucc join_recs(uccv2.File_UCC_Main_Base l,sub_tab r) := transform
	self := l;
end;

MA_main_base_layout := 
  RECORD,maxlength(32767)
  string31 tmsid;
  string23 rmsid;
  string8 process_date;
  string12 static_value;
  string8 date_vendor_removed;
  string8 date_vendor_changed;
  string3 filing_jurisdiction;
  string25 orig_filing_number;
  string40 orig_filing_type;
  string8 orig_filing_date;
  string4 orig_filing_time;
  string25 filing_number;
  string1 filing_number_indc;
  string40 filing_type;
  string8 filing_date;
  string4 filing_time;
  string8 filing_status;
  string30 status_type;
  string3 page;
  string8 expiration_date;
  string9 contract_type;
  string8 vendor_entry_date;
  string4 vendor_upd_date;
  string3 statements_filed;
  string8 continuious_expiration;
  string17 microfilm_number;
  string17 amount;
  string17 irs_serial_number;
  string8 effective_date;
  string75 signer_name;
  string60 title;
  string120 filing_agency;
  string64 address;
  string30 city;
  string2 state;
  string30 county;
  string9 zip;
  string9 duns_number;
  string8 cmnt_effective_date;
  string500 description;
  string512 collateral_desc;
  string145 prim_machine;
  string145 sec_machine;
  string5 manufacturer_code;
  string120 manufacturer_name;
  string15 model;
  string4 model_year;
  string50 model_desc;
  string5 collateral_count;
  string4 manufactured_year;
  string1 new_used;
  string30 serial_number;
  string50 property_desc;
  string9 borough;
  string5 block;
  string4 lot;
  string60 collateral_address;
  string1 air_rights_indc;
  string1 subterranean_rights_indc;
  string1 easment_indc;
  string3 volume;
  unsigned8 persistent_record_id;
 END;


old_base := dataset('~thor_data400::base::ucc::main::ma_father', MA_main_base_layout, thor);
new_base := dataset('~thor_data400::base::ucc::main::ma', MA_main_base_layout, thor);

Record_results := join(old_base, new_base, left.tmsid=right.tmsid,right only);

build_file := Record_results;

									
dnb := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='DN'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),500),named('DNBDailySample'));
ca := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='CA'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('CADailySample'));
tx := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='TX'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('TXDailySample'));
il := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='IL'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('ILDailySample'));
/*txh := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='MA'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100));*/
//txh := output(choosen(build_file,500)); //Updated MA Samples
/*txh := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..3]='TXH'),sub_tab,
									left.tmsid[1..3] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('TXHSample'));
txd := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..3]='TXD'),sub_tab,
									left.tmsid[1..3] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('TXDSample'));*/
nyc := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..3]='NYC'),sub_tab,
									left.tmsid[1..3] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('NYCWeeklySample'));
wa := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='WA'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('WAWeeklySample'));

ma := output(choosen(join(uccv2.File_UCC_Main_Base(tmsid[1..2]='MA'),sub_tab,
									left.tmsid[1..2] = right.tms and left.process_date = right.max_process_date,
									join_recs(left,right),lookup),100),named('MAWeeklySample'));



stats := parallel(dnb,ca,tx,nyc,ma,il,wa);

buildkeys := sequential(
												Keys_NON_FCRA
											 ,Move_NON_FCRA_keys
											 ,To_NON_FCRA_qa
											 ,Keys_FCRA
											 ,Move_FCRA_keys
											 ,To_FCRA_qa											 
											 ,stats
											 ,FileServices.sendemail('qualityassurance@seisint.com;randy.reyes@lexisnexisrisk.com;Claudio.Amaral@lexisnexis.com','UCCV2 DAILY SAMPLE READY','at ' + thorlib.WUID())
											 );

return buildkeys;

end;

