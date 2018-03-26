// EXPORT z_Build_XREF_EIR_MHDR := 'todo';
IMPORT ut, MDR, RoxieKeyBuild, PRTE2_X_DataCleanse;
// output(MDR.sourceTools.dSource_Codes_proj.code);
// MDR.sourceTools.fTranslateSource('MW');


// PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;

hdrfiledate	:= '20150702'; //latest prct header build date

Layout_hdr_data_key := RECORD
//  unsigned6 s_did;
 unsigned6 did;
 unsigned6 rid;
 string1 pflag1;
 string1 pflag2;
 string1 pflag3;
 string2 src;
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned3 dt_vendor_last_reported;
 unsigned3 dt_vendor_first_reported;
 unsigned3 dt_nonglb_last_seen;
 string1 rec_type;
 qstring18 vendor_id;
 qstring10 phone;
 qstring9 ssn;
 integer4 dob;
 qstring5 title;
 qstring20 fname;
 qstring20 mname;
 qstring20 lname;
 qstring5 name_suffix;
 qstring10 prim_range;
 string2 predir;
 qstring28 prim_name;
 qstring4 suffix;
 string2 postdir;
 qstring10 unit_desig;
 qstring8 sec_range;
 qstring25 city_name;
 string2 st;
 qstring5 zip;
 qstring4 zip4;
 string3 county;
 qstring7 geo_blk;
 qstring5 cbsa;
 string1 tnt;
 string1 valid_ssn;
 string1 jflag1;
 string1 jflag2;
 string1 jflag3;
 unsigned8 rawaid;
 unsigned8 persistent_record_id;
 string1 valid_dob;
 unsigned6 hhid;
 string18 county_name;
 string120 listed_name;
 string10 listed_phone;
 unsigned4 dod;
 string1 death_code;
 unsigned4 lookup_did;
END;

source_code := {STRING10 source_code := ''};


prct_data_key := INDEX({unsigned6 s_did}, Layout_hdr_data_key, ut.foreign_prod+'prte::key::header::'+hdrfiledate+'::data');

sexBhdrDs := prct_data_key(
did = 999904471688  or
did = 999906027998  or
did = 999913797575  or
did = 999917204483  or
did = 999929569461  or
did = 999930705843  or
did = 999934011050  or
did = 999944672397  or
did = 999945224746  or
did = 999952310008  or
did = 999967393138  or
did = 999968052817  or
did = 999970864499  or
did = 999975445317  or
did = 999975649900  or
did = 999977380914  or
did = 999979002460  or
did = 999989872233  );

tblSexByDidDs := table(sexBhdrDs, {sexBhdrDs.did, sexBhdrDs.st, cnt := count(group)}, did, st);
// output(tblSexByDidDs, named('tblSexByDidDs'));
dedupedTblSexByDidDs := dedup(sort(tblSexByDidDs, did, -cnt) , did);
// output(dedupedTblSexByDidDs, named('dedupedTblSexByDidDs'));





prct_hdr_key  := PROJECT(prct_data_key, {Layout_hdr_data_key, source_code});
//srt_hdr_key := sort(distribute(prct_hdr_key, hash(src)), src, skew(1.0), local);
// srt_hdr_key := sort(distribute(prct_hdr_key, hash(did)), did, src, skew(1.0), local);

// get EIR product records which don't have src code.
CriminalOffDidDs := PRTE2_X_Ins_DataCleanse.Keys_EIR.Offenders_fcra_did;
UCCDidDs := PRTE2_X_Ins_DataCleanse.Keys_EIR.ucc_w_type_fcra_did;
SexOffDidDs := PRTE2_X_Ins_DataCleanse.Keys_EIR.sexOff_fcra_did;

// OUTPUT(JOIN(prct_hdr_key, CriminalOffDidDs, left.did= right.sdid, transform(recordof(CriminalOffDidDs), self := right), right only),named('CriminalOffOnly')); //no
// OUTPUT(JOIN(prct_hdr_key, UCCDidDs, left.did= right.did, transform(recordof(UCCDidDs), self := right), right only),all, named('UCCOnly')); // only small amount 354 out of 800K+
// count(JOIN(prct_hdr_key, UCCDidDs, left.did= right.did, transform(recordof(UCCDidDs), self := right), right only));
// OUTPUT(JOIN(prct_hdr_key, UCCDidDs, left.did= right.did, transform(recordof(UCCDidDs), self := right)), named('UCCinner'));
// count(JOIN(prct_hdr_key, UCCDidDs, left.did= right.did, transform(recordof(UCCDidDs), self := right)));
// OUTPUT(JOIN(prct_hdr_key, SexOffDidDs, left.did= right.did, transform(recordof(SexOffDidDs), self := right), right only),named('SexOffOnly')); //no

CriminalOffBHDR :=  JOIN(CriminalOffDidDs,prct_hdr_key, left.sdid= right.did, 
														transform(recordof(prct_hdr_key), 
																			self.source_code := 'Criminal'; 
																			self := RIGHT), keep(1));
UccBHDR := JOIN(UCCDidDs, prct_hdr_key,left.did= right.did, 
										transform(recordof(prct_hdr_key), 
															self.source_code := 'UCC'; self := RIGHT), keep(1));
SexOffBHDR := JOIN(SexOffDidDs,prct_hdr_key, left.did= right.did, 
											transform(recordof(prct_hdr_key), 
																self.source_code := 'SexOff'; self := RIGHT), keep(1));



// filter for some EIR product.
//Sources used by EIR 2, per email from Debby Kenworthy
eir_src := ['AM', 'AR', 'BA', 'E1', 'E2', 'E3', 'L2', 'LI', 'PL'];  //Airmen, Aircraft, Bank, Hunt/Fish, Cwpn, LiensJudg, ProLic
																																		//Crims and UCC are not loaded to PersonHeader
srt_hdr_key := prct_hdr_key(src in eir_src) + CriminalOffBHDR + UccBHDR +SexOffBHDR;


// Output Table of All Sources Found in PRCT PersonHeader w/source translation
tbl_hdr_key := table(prct_hdr_key,{src, cnt:=count(group), MDR.sourceTools.fTranslateSource(src)}, src, FEW);
output(tbl_hdr_key, all, named('PrctHeaderSources'));

// output(count(srt_hdr_key(src in eir_src)), named('PersonHdrRecsWithEirSource'));
//tbl_did_src := table(srt_hdr_key(src in eir_src), {did, src, MDR.sourceTools.fTranslateSource(src), cnt:=count(group)}, did, src, MANY);

r_Stats := record
  CountGrp := count(group); 
	srt_hdr_key.did;
	srt_hdr_key.st;
	AM_cnt := sum(group, if(srt_hdr_key.src='AM' AND srt_hdr_key.source_code='',1,0));		//AM=Airmen
	AR_cnt := sum(group, if(srt_hdr_key.src='AR' AND srt_hdr_key.source_code='',1,0));		//AR=Aircrafts
	BK_cnt := sum(group, if(srt_hdr_key.src='BA' AND srt_hdr_key.source_code='',1,0));		//BA=Bankruptcy
	E1_cnt := sum(group, if(srt_hdr_key.src='E1' AND srt_hdr_key.source_code='',1,0));		//E1=EMerge Hunt
	E2_cnt := sum(group, if(srt_hdr_key.src='E2' AND srt_hdr_key.source_code='',1,0));		//E2=EMerge Fish
	E3_cnt := sum(group, if(srt_hdr_key.src='E3' AND srt_hdr_key.source_code='',1,0));		//E3=EMerge CCW
	L2_cnt := sum(group, if(srt_hdr_key.src='L2' AND srt_hdr_key.source_code='',1,0));		//L2=Liens v2
	LI_cnt := sum(group, if(srt_hdr_key.src='LI' AND srt_hdr_key.source_code='',1,0));		//LI=Liens
	PL_cnt := sum(group, if(srt_hdr_key.src='PL' AND srt_hdr_key.source_code='',1,0));		//PL=Professional License
	Criminal_cnt 	:= sum(group, if(srt_hdr_key.source_code='Criminal',1,0));		
	UCC_cnt 			:= sum(group, if(srt_hdr_key.source_code='UCC',1,0));		
	SexOff_cnt 		:= sum(group, if(srt_hdr_key.source_code='SexOff',1,0));		
end;



//PersonHeader recs with sources used by EIR; table of count of dids per source
tbl_did_src0 := table(srt_hdr_key, r_Stats, did, st); //: ONWARNING(2168, ignore);

tbl_did_src := dedup(sort(tbl_did_src0, did, -CountGrp), did);

output(tbl_did_src, all, named('LexidsWithEirSources')); 
output(table(tbl_did_src, {tbl_did_src.st, cnt:= count(group)}, st), named('EirSourcesStateStats'));

tmp_eir_dis_rec := RECORD
	UNSIGNED4 joinID;
	tbl_did_src;
END;

groupedTblBySt := GROUP(SORT(tbl_did_src, st, -E2_cnt, -SexOff_cnt, -AR_cnt, -E3_cnt, -AM_cnt), st);
EirDisDsWithJoinID := PROJECT(groupedTblBySt,
										TRANSFORM(tmp_eir_dis_rec,
															SELF.joinID := COUNTER,
															SELF := LEFT));

finalEirDisDs := UNGROUP(EirDisDsWithJoinID);


MHDRDs :=PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_SF_DS;
filteredMHDRDs := DEDUP(SORT(MHDRDs(required_bc='Y'), id), id);
groupedMHDRDs := GROUP(SORT(filteredMHDRDs, fb_state), fb_state);

tmp_MHDR_rec := RECORD
	UNSIGNED4 joinID;
	filteredMHDRDs;
END;

finalMHDRDs := UNGROUP(PROJECT(groupedMHDRDs,
														TRANSFORM(tmp_MHDR_rec,
																		SELF.joinID := COUNTER,
																		SELF := LEFT)));


resDs := JOIN(finalMHDRDs, finalEirDisDs, 
							left.joinID=right.joinID and
							left.fb_state = right.st,
							transform(PRTE2_X_Ins_DataCleanse.Layouts.Layout_XREF_MHDR,
												self := left,
												self.eir_source_boca_did := right.did;
												self := right));

output(choosen(resDs,2000), all, named('sample_xref_dataset'));

fileversion:= REGEXREPLACE('-', ut.GetTimeDate(), '');

RoxieKeyBuild.Mac_SF_BuildProcess_V2(resDs,                  //thedataset - is the dataset to be written to disk
																		 PRTE2_X_Ins_DataCleanse.Files.BASE_PREFIX_NAME,   //prefix - base name 
																		 PRTE2_X_Ins_DataCleanse.Files.EIR_SUFFIX,    		 //Suffix
																		 fileversion,              //File date
																		 buildAlphaBase,           //seq_name - is the action         
																		 3,                        //numgenerations is currently to be just 2 or 3    
																		 false,                    //csvout - optional should you need a csv output
																		 true);                    //pcompress - optional should you need the file to be compressed.
																	

output(count(resDs), named('total_count'));

output(table(resDs, {resDs.fb_state, c := count(group)}, fb_state), named('MHDR_state_stats'));

output(dataset(
								[{'Airmen',count(resDs(AM_cnt!=0))},
								{'Aircrafts',count(resDs(AR_cnt!=0))},
								{'Bankruptcy',count(resDs(BK_cnt!=0))},
								{'EMerge Hunt',count(resDs(E1_cnt!=0))},
								{'EMerge Fish',count(resDs(E2_cnt!=0))},
								{'EMerge CCM',count(resDs(E3_cnt!=0))},
								{'Liens v2',count(resDs(L2_cnt!=0))},
								{'Liens',count(resDs(LI_cnt!=0))},
								{'Professional License',count(resDs(PL_cnt!=0))},
								{'CriminalOff',count(resDs(Criminal_cnt!=0))},
								{'UCC',count(resDs(UCC_cnt!=0))},
								{'SexOff',count(resDs(SexOff_cnt!=0))}
								],
								{string50 products, unsigned2 cnt}), named('MHDR_prods_stats'));
								
buildAlphaBase;
