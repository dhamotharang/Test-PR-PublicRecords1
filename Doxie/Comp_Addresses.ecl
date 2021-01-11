import AutoStandardI, header, ut, doxie_crs, PhonesFeedback_Services, doxie, PhonesFeedback, suppress;

doxie.MAC_Header_Field_Declare()
doxie.MAC_Selection_Declare()

global_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModule();

Address_Format := Layout_Comp_Addresses;
isKnowx := mod_access.isConsumer();
Nbrs := doxie.historic_nbr_records_crs();

Address_Format fn(NBrs  le) := transform
  self.dt_first_seen := le.dt_first_seen;
  self.dt_last_seen := MAP( ~glb_ok=>le.dt_nonglb_last_seen,
                            le.dt_last_seen<>0 => le.dt_last_seen, 0);
  self.hri_address := [];
  // self.Feedback := [];
  self.shared_address := '';  // neighbors never share an addr with the subject, by definition
  self := le;
  end;

Ns1 := project(Nbrs,fn(left));

// new neighbors routine
Nbrs2 := doxie_crs.nbr_records;
Address_Format fn_nbr(NBrs2 le) := transform
  self.hri_address := [];
  self.shared_address := '';  // neighbors never share an addr with the subject, by definition
  self.dt_vendor_first_reported := 0;
  self.dt_vendor_last_reported := 0;
  self := le;
  end;
Ns2 := project(Nbrs2,fn_nbr(left));

Relative_addresses := 
  relative_records(header.constants.checkRNA)((Include_RelativeAddresses_val and isRelative) or 
                   (Include_Associates_val and ~isRelative));
                   
Address_Format fr(Relative_Addresses  le) := transform
  self.dt_first_seen := le.dt_first_seen;
  // knowx key has non glb data so it does not need to get dt_nonglb_last_seen.
  self.dt_last_seen := MAP( ~glb_ok and ~isKnowx =>le.dt_nonglb_last_seen,
                            le.dt_last_seen<>0 => le.dt_last_seen, 0);
  self.hri_address := [];
  self := le;
  end;
  
Rels := project(Relative_Addresses,fr(left));  

Main_tmp_a := doxie.Comp_Subject_Addresses_wrap.addresses;

Main_tmp_a add_sub_Ind (Main_tmp_a le):=transform
self.isSubject:=true;
self:=le;
end;
Main_tmp :=project(Main_tmp_a,add_sub_Ind(LEFT));
// Main is for the subj add here

PhonesFeedback_Services.Mac_Append_Feedback(Main_tmp
                                            ,did
                                            ,Phone
                                            ,Main_all
                                       ,mod_access);


Main_all select_fb_subj (Main_all le):=transform
  self.feedback:=if(le.issubject=true,le.feedback,DATASET ([], PhonesFeedback_Services.Layouts.feedback_report));
  self:=le;
end;
Main_fb:=project(Main_all,select_fb_subj(LEFT));
Main:=if(IncludePhonesFeedback,Main_fb,Main_tmp);

Address_Format add_s(Address_Format le, Main ri) := transform
  self.shared_address := IF(ri.did<>0,'S','');
  self := le;
  end;

Rels1 := join(Rels,Main, left.prim_name=right.prim_name and
          left.prim_range = right.prim_range and
          ut.nneq(left.sec_range, Right.sec_range) and
          left.zip = right.zip,
          add_s(left,right),left outer);  

doxie.MAC_Address_Rollup(Rels1,Max_RelativeAddresses,Rels_Dn_pre, isKnowx);
 
//Do address Hiearchy sorting for relatives/associate addresses
Rels_Dn_ranked := Header.Mac_Append_addr_ind(Rels_Dn_pre, addr_ind, /*src*/, did, prim_range, prim_name, sec_range, city_name
                                              , st, zip, predir, postdir, suffix, dt_first_seen, dt_last_seen, dt_vendor_first_reported
                                              , dt_vendor_last_reported /*,isTrusted,*/ /*isFCRA,*/ /*hitQH,*/ /*debug*/);
                                                       
Rels_1 := if(do_address_hierarchy,project(Rels_Dn_ranked,Address_Format),Rels_Dn_pre);

Address_Format tra(Address_Format lef,Address_Format ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);
  self := ref;
end;

// Switches all the infutor dates that comes from data in the vendor dates.
Address_Format traConsumer(Address_Format lef,Address_Format ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);  
  self.dt_last_seen := if(ref.isSubject, ref.dt_last_seen, ref.dt_vendor_last_reported);
  self.dt_first_seen := if(ref.isSubject, ref.dt_first_seen, ref.dt_vendor_first_reported);
  self.dt_vendor_first_reported := if(ref.isSubject, ref.dt_vendor_first_reported, ref.dt_first_seen);
  self.dt_vendor_last_reported := if(ref.isSubject, ref.dt_vendor_last_reported , ref.dt_last_seen);
  self := ref;		
end;

//Rels_Dn_All := iterate( Rels_1, tra(left,right));
//Rels_Dn_Consumer := iterate( Rels_1, traConsumer(left, right));

Rels_Dn_All := iterate(sort(Main, address_seq_no) & Rels_1, tra(left,right));
Rels_Dn_Consumer := iterate(sort(Main, address_seq_no) & Rels_1, traConsumer(left, right));

Rels_Dn := IF (isKnowx, Rels_Dn_Consumer, Rels_Dn_All);

doxie.MAC_Address_Rollup(NS1,Addresses_PerNeighbor,NS_Dn);
doxie.MAC_Address_Rollup(NS2,Addresses_PerNeighbor,NS2_Dn);

NS_All := NS_Dn+NS2_Dn;
// if consumer copy seen dates to vendor dates so later on the switch dates
// for consmer will get the right dates.
NS_All_Dn := if(isKnowx, project(NS_All, transform(recordof(NS_Dn),
    self.dt_vendor_last_reported := left.dt_last_seen,
    self.dt_vendor_first_reported := left.dt_first_seen,
    self := left)), NS_All);
//output(Rels1, named('relatives'));
//output(NS_All, named('neighbors'));
//output(NS_All_Dn, named('NS_All_Dn'));

Dn := Main+Rels_Dn+NS_All_Dn;
//output(dn, named('dn'));
doxie.MAC_Address_Rollup(Dn,1000,res, isKnowx);
//output(res, named('res'));
doxie.mac_AddHRIAddress(res, res_wrisk)

res4out := if(include_hri_val, res_wrisk, res);

//need sequence numbers on all addresses now for residents
needseq := res4out(address_seq_no < 0);
hadseq := res4out(address_seq_no >= 0);

/* Address_Format tra(Address_Format lef,Address_Format ref) := transform
     self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);
     self := ref;
     end;
   
   // Switches all the infutor dates that comes from data in the vendor dates.
   Address_Format traConsumer(Address_Format lef,Address_Format ref) := transform
     self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);  
     self.dt_last_seen := if(ref.isSubject, ref.dt_last_seen, ref.dt_vendor_last_reported);
     self.dt_first_seen := if(ref.isSubject, ref.dt_first_seen, ref.dt_vendor_first_reported);
     self.dt_vendor_first_reported := if(ref.isSubject, ref.dt_vendor_first_reported, ref.dt_first_seen);
     self.dt_vendor_last_reported := if(ref.isSubject, ref.dt_vendor_last_reported , ref.dt_last_seen);
     self := ref;		
     end;
*/
  
//****** Push infile through transform above, note that only non-subject 
//addresses will go through the transform because subject addresses 
// already have a sequence.
wseq := iterate(sort(hadseq, address_seq_no) & needseq, tra(left,right));
wseq_C := iterate(sort(hadseq, address_seq_no) & needseq, traConsumer(left, right));

//ut.MAC_Sequence_Records_Seeded(needseq, address_seq_no, max(hadseq,address_seq_no), gotseq)

results := choosen(IF (isKnowx, wseq_C, wseq), Max_Addresses);
//output(Rels_Dn_pre_ranking,named('Rels_Dn_pre_ranking'),EXTEND);
//output(project(Rels_Dn_ranked,rec_rela_plus),named('Rels_Dn_ranked'),EXTEND);
export Comp_Addresses :=   results (prim_name[1..4]<>'DOD ', prim_name<>'' OR prim_range<>'' OR sec_range<>'');
