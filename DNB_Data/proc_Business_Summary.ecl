import business_header, address, bankrupt;
export proc_Business_Summary :=
module

	BH := DATASET(business_header.Bus_Thor + 'base::dnb_data::firstphase::nj_and_ga', business_header.Layout_Business_Header_Base, THOR);
	
	BH_nonproblematic := BH(source not in DNB_Data.SetExcludeSources);
	
	pobox_regex := '^P[.]?O[.]? BOX';
	
	Layouts.out.business_summary tConvert2OutputLayout(business_header.Layout_Business_Header_Base l) :=
	transform
		is_pobox := regexfind(pobox_regex, l.prim_name, NOCASE) 
								or (l.prim_range = '' and l.zip4 != 0);
		
		address_line_1 := Address.Addr1FromComponents(
												 l.prim_range
												,l.predir
												,l.prim_name
												,l.addr_suffix
												,l.postdir
												,l.unit_desig
												,l.sec_range
											);

		self.bdid									:= intformat(l.bdid, 12,1);
		self.company_name					:= l.company_name;
		self.address_line_1				:= if(is_pobox, '', address_line_1);
		self.mailing_address			:= if(is_pobox, address_line_1, '');
		self.city									:= l.city;
		self.state								:= l.state;
		self.zip									:= if(l.zip != 0, intformat(l.zip, 5, 1), '');
		self.zip4									:= if(l.zip4 != 0, intformat(l.zip4, 4, 1), '');
		self.phone								:= if(l.phone != 0, (string10)l.phone, '');
		self.bankruptcy_indicator	:= '';
		self.OB_indicator					:= '';
		self.fein									:= if(l.fein != 0, intformat(l.fein, 9,1), '');
		self.duns_number					:= map(l.source = 'D' and l.vendor_id[1] != 'D' => l.vendor_id[1..9],
																		l.source = 'D' and l.vendor_id[1] = 'D' => l.vendor_id[2..10],
																		'');
		self.Dnb_record						:= if(l.source = 'D', 'Y', 'N');
		self											:= l;
	end;

	BH_outformat := project(BH_nonproblematic, tConvert2OutputLayout(left));
	
	bh_outformat_dedup := dedup(
													sort(
														distribute(BH_outformat, hash(bdid, company_name)),
															 bdid																				
															,company_name				
															,address_line_1			
															,mailing_address		
															,city								
															,state							
															,zip								
															,zip4								
															,phone							
															,bankruptcy_indicator
															,OB_indicator				
															,fein								
//															,duns_number				
															,-Dnb_record
															,local
															),
														except Dnb_record, duns_number
														,local
															);
	//now should do the address recleaning, since we have remove many records
	
//	address.mac_address_clean(infile,addr1_expr,addr2_expr,clean_misses,out_file)

	//now do rollup so records that have the same company name and address, but one has phone, the other doesn't
	//will rollup into one record
	
	//now match to bankruptcy search file, get the seq number
	//then mactch to bk main to get the chapter and disposition date
	
	bk_search						:= distribute(Bankrupt.File_BK_Search((unsigned6)bdid != 0), hash(bdid));
	bh_outformat_dedup_dist	:= distribute(bh_outformat_dedup, hash(bdid));
	
	layout_bkseq :=
	record
		Layouts.out.business_summary;
		string10   seq_number;
	end;
	
	layout_bkseq tjoin2bkMain(Layouts.out.business_summary l, bankrupt.Layout_BK_Search_v8 r) :=
	transform
		self := l;
		self.seq_number := r.seq_number;
	end;
	
	bh_outformat_bkmatch1 := join(bh_outformat_dedup_dist
																,bk_search
																,left.bdid = right.bdid
																,tjoin2bkMain(left,right)
																,left outer
																,local
																) : persist('~thor_data_400::persist::dnb_data::proc_business_summary::bkmatch1');
	
	//now match to main file to get onest a
	
	
	bk_main := Bankrupt.File_BK_Main(disposed_date = '' and chapter in ['7', '11', '12', '13']);
	bk_main_slim := distribute(table(bk_main, {seq_number}, seq_number), hash(seq_number));
	
	bh_outformat_bkmatch1_dist := distribute(bh_outformat_bkmatch1(seq_number != ''), hash(seq_number));
	
	Layouts.out.business_summary tgetbankruptcyflag(bh_outformat_bkmatch1_dist l, bk_main_slim r) :=
	transform
		self.bankruptcy_indicator := 'Y';
		self := l;
	end;
	
	bh_outformat_bkmatch2 := join(bh_outformat_bkmatch1_dist
																,bk_main_slim
																,left.seq_number = right.seq_number
																,tgetbankruptcyflag(left,right)
																,local
																,left outer
																);
	
	Layouts.out.business_summary tbacktoouts(bh_outformat_bkmatch1 l) :=
	transform
		self := l;
	end;
	
	bh_outformat_blankseq := project(bh_outformat_bkmatch1(seq_number = ''), tbacktoouts(left));
	
	bh_outformat_donebkmatch := bh_outformat_bkmatch2 + bh_outformat_blankseq;
	
	//now match to dead companies
	bh1 := business_header.File_Business_Header;
	bh_dead			:= bh1(source = 'ID');
	bh_dead_table := distribute(table(bh_dead, {bdid}, bdid), hash(bdid));
	
	Layouts.out.business_summary tgetdeadcompanies( Layouts.out.business_summary l, bh_dead_table r) :=
	transform
		self.ob_indicator := if(r.bdid != 0, 'Y', '');
		self := l;
	end;
	
	bh_outformat_donebkmatch_dist := distribute(bh_outformat_donebkmatch, hash((unsigned6)bdid));
	
	bh_dead_out := join(bh_outformat_donebkmatch_dist
											,bh_dead_table
											,(unsigned6)left.bdid = right.bdid
											,tgetdeadcompanies(left,right)
											,local
											,left outer
											);

	
	
	export myoutput := 
		sequential(
			output(bh_dead_out(mailing_address = ''),,thor_clusters.files + 'base::dnb_data::20061210::company::address', overwrite)
			,output(bh_dead_out(mailing_address != ''),,thor_clusters.files + 'base::dnb_data::20061210::company::mailing_address', overwrite)
		);

end;