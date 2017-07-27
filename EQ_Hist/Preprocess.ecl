import header, address, ut, doxie, AID, idl_header;

raw_input:=First_rollup;

setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
string fGetSuffix(string SuffixIn)	:=		map(SuffixIn = '1' => 'I'
																							,SuffixIn = '2' => 'II'
																							,SuffixIn = '3' => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn in setValidSuffix => SuffixIn
																							,'');

layout.base tNormalizeAddresses(raw_input l, unsigned1 c) :=  transform
	string15 v_mi          := if(trim(l.middle_initial)         not in ['NMI','NMN'],l.middle_initial,'');
	string15 v_former_mi   := if(trim(l.former_middle_initial)  not in ['NMI','NMN'],l.former_middle_initial,'');
	string15 v_former_mi_2 := if(trim(l.former_middle_initial2) not in ['NMI','NMN'],l.former_middle_initial2,'');
	string15 v_aka_mi      := if(trim(l.aka_middle_initial)     not in ['NMI','NMN'],l.aka_middle_initial,'');

	string9 ssn_1_2 := header.fn_rule_for_normalizing_eq_ssn(l.first_name, v_mi, l.last_name, l.former_first_name, v_former_mi,  l.former_last_name,  l.clean_ssn);
	string9 ssn_1_3 := header.fn_rule_for_normalizing_eq_ssn(l.first_name, v_mi, l.last_name, l.former_first_name2,v_former_mi_2,l.former_last_name2, l.clean_ssn);
	string9 ssn_1_4 := header.fn_rule_for_normalizing_eq_ssn(l.first_name, v_mi, l.last_name, l.aka_first_name,    v_aka_mi,     l.aka_last_name,     l.clean_ssn);

	dob_1_2 := if((integer)ssn_1_2>0,(integer)l.clean_dob,0);
	dob_1_3 := if((integer)ssn_1_3>0,(integer)l.clean_dob,0);
	dob_1_4 := if((integer)ssn_1_4>0,(integer)l.clean_dob,0);

	self.rec_tp := choose(c,
									 '1','2','2',
									 '2','2','2',
									 '3','3','3',
									 '3','3','3'
									 );

	cid 	   := header.Cid_Converter(l.cid[1])
						+ header.Cid_Converter(l.cid[2])
						+ header.Cid_Converter(l.cid[3])
						+ header.Cid_Converter(l.cid[4])
						+ header.Cid_Converter(l.cid[5])
						+ header.Cid_Converter(l.cid[6])
						+ header.Cid_Converter(l.cid[7])
						+ header.Cid_Converter(l.cid[8])
						+ header.Cid_Converter(l.cid[9]);

	self.vendor_id	  := if(Header.Vendor_Id_Null(header.make_new_vendor(cid)),'EQ'+(string)l.uid,cid);

	self.clean_ssn := choose(c,
							 l.clean_ssn,l.clean_ssn,l.clean_ssn,
							 ssn_1_2,ssn_1_2,ssn_1_2,
							 ssn_1_3,ssn_1_3,ssn_1_3,
							 ssn_1_4,ssn_1_4,ssn_1_4
							 );
	self.clean_dob := choose(c,
							 (integer)l.clean_dob,(integer)l.clean_dob,(integer)l.clean_dob,
							 dob_1_2,dob_1_2,dob_1_2,
							 dob_1_3,dob_1_3,dob_1_3,
							 dob_1_4,dob_1_4,dob_1_4
							 );
	self.orig_fname := choose(c,
							l.first_name,l.first_name,l.first_name,
							l.former_first_name,l.former_first_name,l.former_first_name,
							l.former_first_name2,l.former_first_name2,l.former_first_name2,
							l.aka_first_name,l.aka_first_name,l.aka_first_name
							);
	self.orig_mname := choose(c,
							v_mi,v_mi,v_mi,
							v_former_mi,v_former_mi,v_former_mi,
							v_former_mi_2,v_former_mi_2,v_former_mi_2,
							v_aka_mi,v_aka_mi,v_aka_mi
							);
	self.orig_lname := choose(c,
							l.last_name,l.last_name,l.last_name,
							l.former_last_name,l.former_last_name,l.former_last_name,
							l.former_last_name2,l.former_last_name2,l.former_last_name2,
							l.aka_last_name,l.aka_last_name,l.aka_last_name
							);
	self.orig_suffix := choose(c,
							l.suffix,l.suffix,l.suffix,
							l.former_suffix,l.former_suffix,l.former_suffix,
							l.former_suffix2,l.former_suffix2,l.former_suffix2,
							l.aka_suffix,l.aka_suffix,l.aka_suffix
							);
	self.orig_addr := choose(c,
							l.current_address,l.former1_address,l.former2_address,
							l.current_address,l.former1_address,l.former2_address,
							l.current_address,l.former1_address,l.former2_address,
							l.current_address,l.former1_address,l.former2_address
							);
	self.orig_city := choose(c,
						 l.current_city,l.former1_city,l.former2_city,
						 l.current_city,l.former1_city,l.former2_city,
						 l.current_city,l.former1_city,l.former2_city,
						 l.current_city,l.former1_city,l.former2_city
						 );
	self.orig_state := choose(c,
						l.current_state,l.former1_state,l.former2_state,
						l.current_state,l.former1_state,l.former2_state,
						l.current_state,l.former1_state,l.former2_state,
						l.current_state,l.former1_state,l.former2_state
						);
	self.orig_zip := choose(c,
						l.current_zip,l.former1_zip,l.former2_zip,
						l.current_zip,l.former1_zip,l.former2_zip,
						l.current_zip,l.former1_zip,l.former2_zip,
						l.current_zip,l.former1_zip,l.former2_zip
						);
	self.temp_addr2	:= trim(StringLib.StringCleanSpaces(	trim(self.orig_city) + if(self.orig_city <> '',',','')
																												+ ' '+ self.orig_state
																												+ ' '+ self.orig_zip
																												),left,right);

	self.jflag3   := if(trim(self.clean_ssn)='' and l.ssn_confirmed='C','',l.ssn_confirmed);

	self.dt_first_seen :=	(integer)choose(c,
						l.current_address_date_reported,l.former1_address_date_reported,l.former2_address_date_reported,
						l.current_address_date_reported,l.former1_address_date_reported,l.former2_address_date_reported,
						l.current_address_date_reported,l.former1_address_date_reported,l.former2_address_date_reported
						);
	self.dt_last_seen             :=	if(self.rec_tp='1',l.file_date_max,0);
	self.dt_vendor_first_reported :=	l.file_date_min;
	self.dt_vendor_last_reported  :=	l.file_date_max;

	self.addr_std := if(stringlib.stringfilterout(stringlib.stringtouppercase(self.orig_addr),'POBX -.0123456789')='' 
											and stringlib.stringfilterout(self.orig_addr,' -0123456789')<>''
												,'PO BOX ' + stringlib.stringfilterout(stringlib.stringtouppercase(self.orig_addr),'POBX -.')
												,self.orig_addr);				
	self         	:= l;
end;

dNormalizedAddresses0	:=normalize(raw_input,12,tNormalizeAddresses(left,counter));
//this is a tighter filter than what's in header.mac_normalize_header
dNormalizedAddresses1  :=dNormalizedAddresses0( stringlib.stringfilterout(stringlib.stringtouppercase(orig_fname),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')=''
																							,stringlib.stringfilterout(stringlib.stringtouppercase(orig_lname),'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-')=''
																							,orig_fname<>''
																							,orig_lname<>''
																							,orig_addr<>'');

fNameIfValid(string pFirst, string pMiddle, string pLast, string pSuffix)
 :=	if(stringlib.stringfilterout(stringlib.stringtouppercase(pFirst),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
			+stringlib.stringfilterout(stringlib.stringtouppercase(pMiddle),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
			+stringlib.stringfilterout(stringlib.stringtouppercase(pLast),'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-') = ''
					,Address.CleanPersonFML73(stringlib.stringtouppercase(pFirst)
																		+' '+stringlib.stringtouppercase(pMiddle)
																		+' '+stringlib.stringtouppercase(pLast)
																		+' '+fGetSuffix(pSuffix))
					,'');

names1:=dedup(
				table(dNormalizedAddresses1,{orig_fname,orig_mname,orig_lname,orig_suffix ,title,fname,mname,lname,name_suffix,name_score})
						,record,all);

{names1} tCleanNames(names1 l) := transform
	cleanName  := fNameIfValid(l.orig_fname,l.orig_mname,l.orig_lname,l.orig_suffix);
	good_score       := (integer)cleanName[71..73]>50;
	self.title := if(cleanName[1..5] in ['MR','MS'],cleanName[1..5],'');
	self.fname       := if(good_score,cleanName[6..25],'');
	self.mname       := if(good_score,cleanName[26..45],'');
	self.lname       := if(good_score,cleanName[46..65],'');
	self.name_suffix := if(good_score and cleanName[66..70]='',fGetSuffix(l.orig_suffix),cleanName[66..70]);
	self.name_score  := cleanName[71..73];
	self:=l;
end;

names:=project(names1,tCleanNames(left));
dNormalizedAddresses:=join(distribute(dNormalizedAddresses1,hash(orig_fname,orig_mname,orig_lname,orig_suffix))
													,distribute(names,                hash(orig_fname,orig_mname,orig_lname,orig_suffix))
																,		left.orig_fname=right.orig_fname
																and left.orig_mname=right.orig_mname
																and left.orig_lname=right.orig_lname
																and left.orig_suffix=right.orig_suffix
																,transform({dNormalizedAddresses1}
																	,self.title:=right.title
																	,self.fname:=if(left.orig_fname=right.orig_fname,right.fname,left.orig_fname)
																	,self.mname:=if(left.orig_mname=right.orig_mname,right.mname,left.orig_mname)
																	,self.lname:=if(left.orig_lname=right.orig_lname,right.lname,left.orig_lname)
																	,self.name_suffix:=if(left.orig_suffix=right.orig_suffix,right.name_suffix,left.orig_suffix)
																	,self.name_score:=right.name_score
																	,self:=left)
																,left outer
																,local);


unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(dNormalizedAddresses,addr_std,temp_addr2,RawAID,hdrs_addr, lFlags);

layout.base tr_addr(hdrs_addr le) := TRANSFORM
	self.RawAID     := le.aidwork_rawaid;
	self.prim_range := stringlib.stringfilterout(le.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(le.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(le.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(le.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,le.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(le.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,le.aidwork_acecache.p_city_name,'');
	self.zip        := le.aidwork_acecache.zip5;
	self.county     := le.aidwork_acecache.county[3..5];
	self.msa        := if(le.aidwork_acecache.msa='','',le.aidwork_acecache.msa+'0');
	self            := le.aidwork_acecache;
	self            := le;
END;

headers_preprocessed0 := project(hdrs_addr,tr_addr(left));
// headers_preprocessed0:=temp(dNormalizedAddresses); //used for testing sample ecords

ut.mac_flipnames(headers_preprocessed0,fname,mname,lname,headers_preprocessed);

dist_hdrs             := distribute(headers_preprocessed,hash(fname,lname,prim_range,prim_name,st));
sorted_hdrs           := sort(dist_hdrs,record,local);
deduped_hdr0          := dedup(sorted_hdrs,record,except uid,rec_tp,local);

ut.MAC_Sequence_Records(deduped_hdr0,rid,deduped_hdr);

did_hist :=EQ_hist.FN_DID(deduped_hdr):persist('~thor_data400::persist::eq_hist::did_hist');

with_did := did_hist(did>0) + project(did_hist(did=0) // create an artificial did so that duplicates within a cluster may be rolled off
								,transform(layout.base
									,self.did:=hash64(left.vendor_id)
									,self:=left));

header.Layout_PairMatch tra(with_did l, with_did r) := transform
  self.old_rid := r.rid;
  self.new_rid := l.rid;
  self.pflag := 0;
  end;

j := join(with_did,with_did,
					left.did=right.did
				and left.rid < right.rid
				and	left.fname      =right.fname
				and	left.lname      =right.lname
				and	left.prim_range =right.prim_range
				and	left.prim_name  =right.prim_name
				and	left.st         =right.st
				and	(
							(left.clean_ssn          =right.clean_ssn
						and	left.clean_dob         =right.clean_dob
						and	left.clean_phone       =right.clean_phone
						and	left.mname       =right.mname
						and	left.name_suffix =right.name_suffix
						and	left.sec_range   =right.sec_range
						and	left.zip         =right.zip
						and	left.county      =right.county)
					or
							(ut.nneq(left.clean_ssn          ,right.clean_ssn)
						and	ut.NNEQ_Date(left.clean_dob    ,right.clean_dob)
						and	ut.nneq(left.clean_phone       ,right.clean_phone)
						and	(
								ut.nneq(left.mname       ,right.mname)
							or (if(left.mname[1]=right.mname[1] and (length(trim(left.mname))=1 or length(trim(right.mname))=1),true,false))
							)
						and	ut.nneq(left.name_suffix ,right.name_suffix)
						and	ut.nneq(left.sec_range   ,right.sec_range)
						and	ut.nneq(left.zip         ,right.zip)
						and	ut.nneq(left.county      ,right.county)

						and	left.dt_first_seen            =right.dt_first_seen)
					)
								,tra(left,right)
								,local);

                
sj := sort(distribute(j,old_rid),old_rid,new_rid,local);

rolled_rids := dedup(sj,old_rid,local);

ut.MAC_Patch_Id(with_did, rid, rolled_rids, old_rid, new_rid, old_and_new);

dinfile := distribute(old_and_new,hash(rid));

BR_s := sort(dinfile, rid,dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,local);

fn_pick_populated(string le_in,string ri_in):= if(le_in='',ri_in,le_in);

dob_score(integer d) := 
	MAP( d = 0 => 0,
         d < 10000 or d % 10000 = 0 or (d < 1000000 and d % 100 = 0)=> 1,
         d < 1000000 or d % 100 = 0 => 2,
         3 );

Layout.base t_rollup(BR_s le,BR_s ri) := transform
	self.file_date_min                := min(le.file_date_min,ri.file_date_min);
	self.file_date_max                := max(le.file_date_max,ri.file_date_max);
	self.current_address_date_reported := (string)ut.Min2((integer)le.current_address_date_reported,(integer)le.current_address_date_reported);
	self.former1_address_date_reported := (string)ut.Min2((integer)le.former1_address_date_reported,(integer)ri.former1_address_date_reported);
	self.former2_address_date_reported := (string)ut.Min2((integer)le.former2_address_date_reported,(integer)ri.former2_address_date_reported);
	self.middle_initial               := fn_pick_populated(le.middle_initial,ri.middle_initial);
	self.suffix                       := fn_pick_populated(le.suffix,ri.suffix);
	self.current_city                 := fn_pick_populated(le.current_city,ri.current_city);
	self.former_first_name            :=fn_pick_populated(le.former_first_name, ri.former_first_name);
	self.former_middle_initial        :=fn_pick_populated(le.former_middle_initial, ri.former_middle_initial);
	self.former_last_name             :=fn_pick_populated(le.former_last_name, ri.former_last_name);
	self.former_suffix                :=fn_pick_populated(le.former_suffix, ri.former_suffix);
	self.former_first_name2           :=fn_pick_populated(le.former_first_name2, ri.former_first_name2);
	self.former_middle_initial2       :=fn_pick_populated(le.former_middle_initial2, ri.former_middle_initial2);
	self.former_last_name2            :=fn_pick_populated(le.former_last_name2, ri.former_last_name2);
	self.former_suffix2               :=fn_pick_populated(le.former_suffix2, ri.former_suffix2);
	self.aka_first_name               :=fn_pick_populated(le.aka_first_name, ri.aka_first_name);
	self.aka_middle_initial           :=fn_pick_populated(le.aka_middle_initial, ri.aka_middle_initial);
	self.aka_last_name                :=fn_pick_populated(le.aka_last_name, ri.aka_last_name);
	self.aka_suffix                   :=fn_pick_populated(le.aka_suffix, ri.aka_suffix);
	self.former1_address              :=fn_pick_populated(le.former1_address, ri.former1_address);
	self.former1_city                 :=fn_pick_populated(le.former1_city, ri.former1_city);
	self.former1_state                :=fn_pick_populated(le.former1_state, ri.former1_state);
	self.former1_zip                  :=fn_pick_populated(le.former1_zip, ri.former1_zip);
	self.former2_address              :=fn_pick_populated(le.former2_address, ri.former2_address);
	self.former2_city                 :=fn_pick_populated(le.former2_city, ri.former2_city);
	self.former2_state                :=fn_pick_populated(le.former2_state, ri.former2_state);
	self.former2_zip                  :=fn_pick_populated(le.former2_zip, ri.former2_zip);
	self.ssn                          :=fn_pick_populated(le.ssn, ri.ssn);
	self.clean_ssn                    :=fn_pick_populated(le.clean_ssn, ri.clean_ssn);
	self.ssn_confirmed                :=fn_pick_populated(le.ssn_confirmed, ri.ssn_confirmed);	
	self.clean_phone                  :=fn_pick_populated(le.clean_phone,ri.clean_phone); 	
	self.current_occupation_employer  :=fn_pick_populated(le.current_occupation_employer,ri.current_occupation_employer);
	self.former_occupation_employer   :=fn_pick_populated(le.former_occupation_employer,ri.former_occupation_employer);
	self.former2_occupation_employer  :=fn_pick_populated(le.former2_occupation_employer,ri.former2_occupation_employer); 
	self.other_occupation_employer    :=fn_pick_populated(le.other_occupation_employer,ri.other_occupation_employer); 
	self.other_former_occupation_employer :=fn_pick_populated(le.other_former_occupation_employer,ri.other_former_occupation_employer);

	self.dt_first_seen := 
	ut.EarliestDate(ut.EarliestDate(le.dt_first_seen,ri.dt_first_seen),
					ut.EarliestDate(le.dt_last_seen,ri.dt_last_seen));
	self.dt_last_seen := 
	ut.LatestDate(ut.LatestDate(if(le.rec_tp = '1', le.dt_first_seen, 0),
								if(ri.rec_tp = '1', ri.dt_first_seen, 0)),
				  ut.LatestDate(le.dt_last_seen,ri.dt_last_seen));
	self.dt_vendor_last_reported := ut.LatestDate(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
	self.rec_tp := if ( le.rec_tp='' or le.dt_last_seen<ri.dt_last_seen, ri.rec_tp, le.rec_tp );
	self.vendor_id := if (le.vendor_id='',ri.vendor_id,le.vendor_id);
	self.clean_dob := if ( dob_score(le.clean_dob) < dob_score(ri.clean_dob), ri.clean_dob, le.clean_dob );
	self.title := if (le.title = '', ri.title, le.title );
	self.fname := if (le.fname = '', ri.fname, le.fname );
	self.mname := if (le.mname = '' or le.mname=ri.mname[1], ri.mname, le.mname );
	self.lname := if (le.lname = '', ri.lname, le.lname );
	self.name_suffix := if (le.name_suffix = '' or ut.Translate_Suffix(le.name_suffix)=ri.name_suffix, ri.name_suffix, le.name_suffix );
	self.prim_range := if (le.prim_range = ''and le.zip4='', ri.prim_range, le.prim_range );
	self.predir := if (le.predir = ''and le.zip4='', ri.predir, le.predir );
	self.prim_name := if (le.prim_name = ''and le.zip4='', ri.prim_name, le.prim_name );
	self.addr_suffix := if (le.addr_suffix = ''and le.zip4='', ri.addr_suffix, le.addr_suffix );
	self.postdir := if (le.postdir = ''and le.zip4='', ri.postdir, le.postdir );
	self.unit_desig := if (le.unit_desig = ''and le.zip4='', ri.unit_desig, le.unit_desig );
	self.sec_range := if (le.zip4='' and ri.dt_last_seen>le.dt_last_seen, ri.sec_range, le.sec_range );
	self.v_city_name := if (le.v_city_name = ''and le.zip4='', ri.v_city_name, le.v_city_name );
	self.p_city_name := if (le.p_city_name = ''and le.zip4='', ri.p_city_name, le.p_city_name );
	self.st := if (le.st = ''and le.zip4='', ri.st, le.st );
	self.zip := if (le.zip = ''and le.zip4='', ri.zip, le.zip );
	self.zip4 := if (le.zip4 = '', ri.zip4, le.zip4 );
	self.county := if (le.county = ''and (le.zip4='' or (ri.county <> '' and ri.zip4 <> '')), ri.county, le.county );
	self.geo_blk := if((integer)le.geo_blk = 0,ri.geo_blk,le.geo_blk);
	self.jflag3 := if ( le.jflag3 = '', ri.jflag3, le.jflag3 );
	self.RawAid := if (le.RawAid = 0, ri.RawAid, le.RawAid );
	self:= le;
end;

merged := rollup(BR_s,left.rid=right.rid,t_rollup(left,right),local);

export Preprocess := merged;