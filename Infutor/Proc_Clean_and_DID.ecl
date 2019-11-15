import infutor, ut, header_slimsort, did_add, didville,watchdog,lib_StringLib,AID,idl_header,address, AID_Support, PromoteSupers;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
#option('multiplePersistInstances',FALSE);

ds := infutor.File_Infutor;
output(choosen(enth(ds,1,30000,1),10000),named('Infutor_Raw_Sample'));

fun_clean(string instring)   := function
  v_replace1 := stringlib.stringfindreplace(instring,' PO BOX ST ',  ' ST PO BOX ');
  v_replace2 := stringlib.stringfindreplace(v_replace1,             ' POB ST ',     ' ST PO BOX ');
  v_replace3 := stringlib.stringfindreplace(v_replace2,             ' P O BOX ST ', ' ST PO BOX ');
  v_replace4 := stringlib.stringfindreplace(v_replace3,             ' COUNTY RD # ',' COUNTY ROAD ');
  v_replace5 := stringlib.stringfindreplace(v_replace4,             ' CNTY RD ',    ' COUNTY ROAD ');
  v_replace6 := stringlib.stringfindreplace(v_replace5,             ' COUNTY RD ',  ' COUNTY ROAD ');
return v_replace6 ;
end ;

infutor.infutor_layout_main.temp_rec t_slim(infutor.layout_in_fixed l, integer c) := transform

 self.prev1_addr_street_blob   := fun_clean(trim(l.prev1_addr[1..54],left,right));
 self.prev1_city               := trim(l.prev1_addr[55..81],left,right);
 self.prev1_st                 := l.prev1_addr[82..83];
 self.prev1_zip                := l.prev1_addr[84..88];
 
 self.prev2_addr_street_blob   := fun_clean(trim(l.prev2_addr[1..54],left,right));
 self.prev2_city               := trim(l.prev2_addr[55..81],left,right);
 self.prev2_st                 := l.prev2_addr[82..83];
 self.prev2_zip                := l.prev2_addr[84..88];
 
 self.prev3_addr_street_blob   :=fun_clean(trim(l.prev3_addr[1..54],left,right));
 self.prev3_city               :=trim(l.prev3_addr[55..81],left,right);  
 self.prev3_st                 := l.prev3_addr[82..83]; 
 self.prev3_zip                := l.prev3_addr[84..88];
 
 self.prev4_addr_street_blob   :=fun_clean(trim(l.prev4_addr[1..54],left,right));
 self.prev4_city               :=trim(l.prev4_addr[55..81],left,right); 
 self.prev4_st                 := l.prev4_addr[82..83];
 self.prev4_zip                := l.prev4_addr[84..88];
 
 self.prev5_addr_street_blob   :=fun_clean(trim(l.prev5_addr[1..54],left,right));
 self.prev5_city               :=trim(l.prev5_addr[55..81],left,right);
 self.prev5_st                 :=l.prev5_addr[82..83]; 
 self.prev5_zip                :=l.prev5_addr[84..88]; 
  
 self.orig_addr_street_blob := fun_clean(l.orig_addr_street_blob);
 self.orig_dob_dd_appended  := if(l.orig_dob<>'',l.orig_dob+'00','');
 self.boca_id               := c+1;
 self                       := l;
end;

d_slim := project(infutor.File_Infutor(orig_first_name<>'' and orig_last_name<>''),t_slim(left,counter));
 
// norm ssn 
infutor.infutor_layout_main.r_norm_ssn t_norm(d_slim l, integer c) := transform
 self.ssn       := choose(c,l.ssn1,l.ssn2);
 self.which_ssn := choose(c,'1','2');
 self           := l;
end;

d_norm := normalize(d_slim,2,t_norm(left,counter));

d_ssn1 := d_norm(which_ssn='1');
d_ssn2 := d_norm(which_ssn='2',ssn<>'');
d_ssn1_ssn2 := d_ssn1+d_ssn2;

// norm names  
infutor.infutor_layout_main.r_norm_name  t_norm_name(d_ssn1_ssn2 l, integer c) := transform
 
 orig_name := l.orig_first_name+' '+l.orig_middle_name+' '+l.orig_last_name+' '+l.orig_name_suffix;
 self.name       := choose(c,orig_name,l.alias1,l.alias2,l.alias3);
 self.name_type  := choose(c,'O','A1','A2','A3');
 self           := l;
end;

d_norm_name := normalize(d_ssn1_ssn2,4,t_norm_name(left,counter));

// norm addr
infutor.infutor_layout_main.r_norm_name  t_norm_addr(d_norm_name l, integer c) := transform
 
 self.addr_street_blob :=choose(c,l.orig_addr_street_blob,l.prev1_addr_street_blob,l.prev2_addr_street_blob,l.prev3_addr_street_blob,l.prev4_addr_street_blob,l.prev5_addr_street_blob);
 self.city := choose(c,l.orig_city,l.prev1_city,l.prev2_city,l.prev3_city,l.prev4_city,l.prev5_city);
 self.st := choose(c,l.orig_st,l.prev1_st,l.prev2_st,l.prev3_st,l.prev4_st,l.prev5_st);
 self.zip := choose(c,l.orig_zip,l.prev1_zip,l.prev2_zip,l.prev3_zip,l.prev4_zip,l.prev5_zip);
 self.zip4 := choose(c,l.orig_zip4,'','','','','');
 self.addr_type := choose(c,'O','p1','P2','P3','P4','P5');
 self.flag := choose(c,'Y',if(l.prev1_addr_street_blob <>'' ,'Y','N'), 
                           if(l.prev2_addr_street_blob <>'' ,'Y','N'),
						   if(l.prev3_addr_street_blob <>'' ,'Y','N'),
						   if(l.prev4_addr_street_blob <>'' ,'Y','N'),
						   if(l.prev5_addr_street_blob <>'' ,'Y','N'));
self := l ;

end;

d_norm_aadr := normalize(d_norm_name(name<>''),6,t_norm_addr(left,counter));
d_norm_aadr1 := d_norm_aadr(flag ='Y'); 

// Dedup name, addr before seinding to cleaner
d_norm_aadr1_n := distribute(d_norm_aadr1,hash(name)); 
dedup_name := dedup(sort(d_norm_aadr1_n,name,local),name,local);

d_norm_aadr1_a := distribute(d_norm_aadr1,hash(addr_street_blob,city,st,zip,zip4)); 
dedup_addr0 := dedup(sort(d_norm_aadr1_a,addr_street_blob,city,st,zip,zip4,local),addr_street_blob,city,st,zip,zip4,local); 

// Clean address for AID
// l_CleanAddr	:= RECORD
// recordof dedup_addr0;
// string address_1;
// string address_2;
// unsigned8 RawAID := 0;
// END;

// lCleanAddr	tCleanAddress(dedup_addr0 l) := TRANSFORM

dedup_addr  := project(dedup_addr0, transform({dedup_addr0, string address_1 , string address_2,unsigned8 RawAID:=0}, 
                                    
									searchpattern :='^([0-9]+) # ([0-9]+)$' ;
									searchpattern2 := '^([0-9]+) (PO BOX |PO BOX| POB |P O B+)$';
									searchpattern3 := '^([0-9]+) (TH +)';
									searchpattern4 := '^([0-9]+[A-Z]) (PO BOX |PO BOX| POB |P O B+)$';
									searchpattern5 := '^([1-9]+)(ST |ND |TH )';
                                   
								    // blank junk 
									temp_address_0 := infutor.Mod_clean_addr.blankjunk(lib_StringLib.StringLib.StringCleanSpaces(left.addr_street_blob)); 
									// remove leading zeros 
									temp_address_1 := regexreplace('^[^A-Z1-9]+',temp_address_0, '');
                                    
									// Add space between direction and street number 
                  temp_address_2:= if(infutor.Mod_clean_addr.StrIndexdir(temp_address_1)>0 and 
                                        regexfind('^[0-9]',temp_address_1[infutor.Mod_clean_addr.StrIndexdir(temp_address_1)+3]), 
                                        temp_address_1[1..infutor.Mod_clean_addr.StrIndexdir(temp_address_1)+2] + ' '+ 
					                              temp_address_1[infutor.Mod_clean_addr.StrIndexdir(temp_address_1)+3..]
                                       ,temp_address_1);  
														
				          // blank out bad addresses 
									temp_address_3 := if(regexfind(searchpattern,temp_address_2),'',temp_address_2) ;
									
									// Reverse PO BOX addresses 
									temp_address_4 := trim(if(regexfind(searchpattern2,temp_address_3)
									                    ,temp_address_3[infutor.Mod_clean_addr.StrIndex(temp_address_3)..] + ' '+ temp_address_3[1..infutor.Mod_clean_addr.StrIndex(temp_address_3)-1]
									                    ,temp_address_3),left,right) ;
									
                                     
                  temp_address_5 := trim(if(regexfind(searchpattern4,temp_address_4)
                                             ,temp_address_4[infutor.Mod_clean_addr.StrIndex(temp_address_4)..] 
				                                     + ' '+ temp_address_4[1..infutor.Mod_clean_addr.StrIndex(temp_address_4)-1]
                                             ,temp_address_4),left,right) ;
													   
				         // Blank out POBOX in the middle of street address 
									temp_address_6 := infutor.Mod_clean_addr.StrcleanPOB(temp_address_5);
									
									//remove space btw TH and street number	
									temp_address_7	:= REGEXREPLACE('^0 ',if(regexfind(searchpattern3,temp_address_6) ,  
                                                           trim(temp_address_6[1..StringLib.StringFind(temp_address_6,' TH ',1)],left,right)+
	                                                         trim(temp_address_6[StringLib.StringFind(temp_address_6,' TH ',1)..],left,right)
	                                                         ,temp_address_6 ),'');
									ClnAddress1	:= IF(regexfind(searchpattern5,temp_address_7),'',temp_address_7);
									self.address_1 := IF(ClnAddress1 <> '',Address.fn_addr_clean_prep(ClnAddress1, 'first'),'');
									
									ClnAddress2		 := lib_StringLib.StringLib.StringCleanSpaces(If(left.city <> '' and left.st <> '' and left.zip <> '',
																																								trim(left.CITY,left,right) + ', ' + trim(left.ST,left,right)
																																								+ ' ' + trim(left.ZIP,left,right)[1..5],
																																								'')); 
																		
									self.address_2 := IF(ClnAddress2 <> '',Address.fn_addr_clean_prep(ClnAddress2, 'last'),'');
									self := left));

infutor.infutor_layout_main.r_norm_name_clean  tclean( dedup_name l) := transform 

self.clean_name := if(l.name_type ='O',Address.cleanpersonfml73(l.name),Address.cleanpersonlfm73(l.name));
self:=l ; 
end ; 
name_clean := project(dedup_name, tclean(left)); 

// Join back clean name 
infutor.infutor_layout_main.r_final  tjoin (d_norm_aadr1 l, name_clean r ) := transform

self.clean_name := r.clean_name ; 
self:= l ;
end; 

getname := join(d_norm_aadr1_n,name_clean,left.name =right.name 
                         ,tjoin(left,right), left outer,local); 

invalid_prim_name := [
'NONE',
'UNKNOWN',
'UNKNWN',
'UNKNOWEN',
'UNKNONW',
'UNKNON',
'UNKNWON',
'UNKONWN',
'UNEKNOWN',
'UN KNOWN',
'GENERAL DELIVERY'
];

// Append AID
//Only pass full addresses to AID
HasAddr	:=  dedup_addr(trim(address_1,left,right) <> '' and trim(address_2,left,right) <> '');

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(HasAddr, address_1, address_2, RawAID, addr_clean, lFlags);

// join back clean addr 
infutor.infutor_layout_main.layout_base_tracker  tjoin1 (getname l, addr_clean r ) := transform

 string28  v_prim_name := r.AIDWork_ACECache.prim_name;
 string5   v_zip       := r.AIDWork_ACECache.zip5;
 string4   v_zip4      := r.AIDWork_ACECache.zip4;
 
 self.RawAID	   :=	r.AIDWork_RawAID;
 self.prim_range       :=   r.AIDWork_ACECache.prim_range;
 self.predir           :=   r.AIDWork_ACECache.predir;
 self.prim_name        :=   if(trim(v_prim_name) in invalid_prim_name,'',v_prim_name);
 self.addr_suffix      :=   r.AIDWork_ACECache.addr_suffix;
 self.postdir          :=   r.AIDWork_ACECache.postdir;
 self.unit_desig	   :=	r.AIDWork_AceCache.unit_desig;
 self.sec_range        :=   r.AIDWork_ACECache.sec_range;
 self.p_city_name      :=   r.AIDWork_ACECache.p_city_name;
 self.v_city_name      :=   r.AIDWork_ACECache.v_city_name;
 self.st               :=   r.AIDWork_ACECache.st;
 self.zip              :=   if(v_zip='00000','',v_zip);
 self.zip4             :=   if(v_zip4='0000','',v_zip4);
 self.cart		       :=	r.AIDWork_AceCache.cart;
 self.cr_sort_sz	   :=	r.AIDWork_AceCache.cr_sort_sz;
 self.lot		       :=	r.AIDWork_AceCache.lot;
 self.lot_order		   :=	r.AIDWork_AceCache.lot_order;
 self.dbpc		       :=	r.AIDWork_AceCache.dbpc;
 self.chk_digit		   :=	r.AIDWork_AceCache.chk_digit;
 self.rec_type	       :=	r.AIDWork_AceCache.rec_type;
 self.county	       :=	r.AIDWork_AceCache.county;
 self.geo_lat		   :=	r.AIDWork_AceCache.geo_lat;
 self.geo_long		   :=	r.AIDWork_AceCache.geo_long;
 self.msa			   :=	r.AIDWork_AceCache.msa;
 self.geo_blk		   :=	r.AIDWork_AceCache.geo_blk;
 self.geo_match		   :=	r.AIDWork_AceCache.geo_match;
 self.err_stat		   :=	r.AIDWork_AceCache.err_stat;
 self.title       := l.clean_name[ 1.. 5];
 self.fname       := l.clean_name[ 6..25];
 self.mname       := l.clean_name[26..45];
 self.lname       := l.clean_name[46..65];
 self.name_suffix := l.clean_name[66..70];
 self.name_score  := l.clean_name[71..73];
 self.ssn         := if(REGEXFIND('^[[:digit:]]+$',l.ssn) =true ,l.ssn,'');
 self:= l ;
end; 

getaddr := join(distribute(getname,hash(addr_street_blob,city,st,zip,zip4)),
														addr_clean,
                            left.addr_street_blob = right.addr_street_blob and
                            left.city =right.city and
														left.st = right.st and 
														left.zip = right.zip and 
														left.zip4 = right.zip4 
               ,tjoin1(left,right), left outer,local): persist('~thor_data400::persist::infutor_clean');
							 
getaddr_filt := getaddr(fname<>'',
															lname<>'',
															zip<>'',
															(phone<>'' or (prim_range<>'' and prim_name<>'')),
															~(stringlib.stringfind(prim_name,'PO BOX',1)>0 and trim(zip4)='')
															); 

#if(__ECL_VERSION__ < '7.4.24')
	d_clean_filt  := dedup(sort(getaddr_filt, record, local), record, local);
#else
	d_clean_filt  := dedup(getaddr_filt, all);   // Original Code
#end  


// Apply Flip name macro
ut.mac_flipnames(d_clean_filt,fname,mname,lname,flip_out);
	 				   
matchset := ['A','P','Z','D','S'];

did_add.MAC_Match_Flex
	(flip_out, matchset,					
	 ssn, orig_dob_dd_appended, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, infutor.infutor_layout_main.layout_base_tracker, false, DID_Score_field,
	 75, d_did)


// append ssn 

did_add.MAC_Add_SSN_By_DID(d_did, did, append_SSN, file_w_ssn, false);								 
file_infutor_w_ssn := infutor_reflection(file_w_ssn) ;

// Apply phone suppression, area code correction and blank out invalid phones. 

ut.mac_suppress_by_phonetype(file_infutor_w_ssn,phone,st,inf_supp_out,true,did);

// Correct phone numbers which have invalid area codes

inf_supp_phone_populated	:=	inf_supp_out(trim(phone,left,right)	!=	'');
inf_supp_phone_blank			:=	inf_supp_out(trim(phone,left,right)	=		'');

ut.mac_phone_areacode_corrections(inf_supp_phone_populated,inf_areacode_corrections,phone);

// Blank out phone numbers which we aren't able to correct where area code or exchange code is not valid
yellowpages.NPA_PhoneType(inf_areacode_corrections,phone,phonetype,inf_phone_type);

inf_invalid_areacode	:=	project(inf_phone_type(trim(phonetype,left,right)	  =		'INVALID-NPA/NXX/TB'), transform({file_infutor_w_ssn}, self.phone := '',self := left));
inf_valid_areacode		:=	project(inf_phone_type(trim(phonetype,left,right)	 !=	  'INVALID-NPA/NXX/TB'), transform({file_infutor_w_ssn}, self := left));

result_out := inf_invalid_areacode + inf_valid_areacode + inf_supp_phone_blank ;

PromoteSupers.mac_sf_buildprocess(result_out, '~thor_data400::base::infutor', build_infutor_base, 2,,true);

export Proc_Clean_and_DID := sequential(build_infutor_base, Infutor.New_records_sample);