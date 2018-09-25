import _control,header,doxie_build,mdr;
// l := {InsuranceHeader_Salt_T46.ManualSuppression.recLayout, boolean bogus};
layout_alpha_suppression := RECORD
  unsigned8 rid;
  unsigned8 did;
  string9 src;
  unsigned8 source_rid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 ambiguous;
  string1 consumer_disclosure;
  unsigned2 cleavepenalty;
  string1 ssn_ind;
  string1 dob_ind;
  string1 dlno_ind;
  string1 fname_ind;
  string1 mname_ind;
  string1 lname_ind;
  string2 addr_ind;
  string1 best_addr_ind;
  string1 phone_ind;
  string10 phone;
  string9 ssn;
  unsigned4 dob;
  string25 dl_nbr;
  string2 dl_state;
  string5 title;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  string5 occupation;
  string1 gender;
  string1 derived_gender;
  unsigned8 address_id;
  string4 addr_error_code;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 city;
  string2 st;
  string5 zip;
  string4 zip4;
  string5 addressstatus;
  string3 addresstype;
  unsigned6 boca_did;
  string18 vendor_id;
  string6 ambest;
  string20 policy_number;
  string2 insurance_type;
  string20 claim_number;
  unsigned4 dt_effective_first;
  unsigned4 dt_effective_last;
  string25 userid;
  unsigned4 dt_added;
  boolean bogus;
 END;


 
foreign_aprod := '~foreign::' + _control.IPAddress.aprod_thor_dali + '::';

ins_sp_base := dataset(foreign_aprod+'thor_data400::base::insuranceheader::suppress::qa',
               layout_alpha_suppression,thor);
                               
fr := sort(table(ins_sp_base,{src, unsigned8 cnt := count(group)},src),-cnt);

boc_sprsn := header.fn_block_records.current_block_list;

ins_only := join(ins_sp_base(regexreplace('ADL(.*)',src,'\\1') in ['LT','TS','TN','TU']),boc_sprsn,
                    LEFT.rid = RIGHT.rid, LEFT only);
boc_only := join(ins_sp_base(regexreplace('ADL(.*)',src,'\\1') in ['LT','TS','TN','TU']),boc_sprsn,
                    LEFT.rid = RIGHT.rid, RIGHT only);

output_as_is_files := parallel(
                                output(fr,named('alpha_all_suppressions_summary_by_src'))
                                ,output(ins_only,named('alpha_only_by_rid'))
                                ,output(boc_only,named('boca_only_by_rid'))
                               );

//filedate := header.version_build;

blank_head := dataset([], header.Layout_Header_v2);
key_fr_name := '~thor_data400::key::pre_file_header_building::father'; // header building BEFORE filtering
key_qa_name := '~thor_data400::key::pre_file_header_building::qa'; // header building BEFORE filtering
pre_file_header_building := doxie_build.fn_file_header_building(blank_head)(Header.Blocked_data_new());

key_pre_qa := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                 key_qa_name); 
key_pre_fr := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                 key_fr_name);
                                

ins_only_by_did_rid    := dedup(
                            join(ins_only,key_pre_qa,KEYED(LEFT.did=RIGHT.did) AND LEFT.RID=RIGHT.RID,LEFT ONLY)
                          + join(ins_only,key_pre_fr,KEYED(LEFT.did=RIGHT.did) AND LEFT.RID=RIGHT.RID,LEFT ONLY)
                          ,all);

rec_compare := record

    {ins_only};
    unsigned8 dob_a;
    unsigned8 dob_b;
    qstring9 ssn_a;
    qstring9 ssn_b;

end;
rec_compare join_them(ins_only L, key_pre_qa R) := TRANSFORM

    SELF.dob_a := L.dob;
    SELF.dob_b := R.dob;
    SELF.ssn_a := L.ssn;
    SELF.ssn_b := R.ssn;
    SELF:=L;
    SELF:=R;

END;


                          
in_both_by_did_rid := dedup(
                            join(ins_only,key_pre_qa,KEYED(LEFT.did=RIGHT.did) AND LEFT.RID=RIGHT.RID,join_them(LEFT,RIGHT))
                          + join(ins_only,key_pre_fr,KEYED(LEFT.did=RIGHT.did) AND LEFT.RID=RIGHT.RID,join_them(LEFT,RIGHT))
                          ,all);

o1:=output(ins_only_by_did_rid ,named('ins_only_by_did_rid')); // need to manually re-identify the rid
o2:=output(in_both_by_did_rid  ,named('in_both_by_did_rid')); // these we can add now from key to boca list

// Run the HEADER filter and see what we do not match

not_in_key_pre_qa :=  join( ins_only,key_pre_qa,
             KEYED(LEFT.did=RIGHT.did)
             AND LEFT.ssn 			  = RIGHT.ssn
			 AND LEFT.dob 			  = RIGHT.dob
			 AND LEFT.title 		  = RIGHT.title
			 AND LEFT.fname 		  = RIGHT.fname
			 AND LEFT.mname 		  = RIGHT.mname
			 AND LEFT.lname 		  = RIGHT.lname
			 AND LEFT.name_suffix     = RIGHT.name_suffix
             AND LEFT.prim_range      = RIGHT.prim_range
             AND LEFT.predir 		  = RIGHT.predir
             AND LEFT.prim_name       = RIGHT.prim_name
             AND LEFT.suffix 		  = RIGHT.suffix
             AND LEFT.postdir 		  = RIGHT.postdir
             AND LEFT.st 			  = RIGHT.st
             AND LEFT.zip 			  = RIGHT.zip    , LEFT ONLY,FEW);

not_in_key_pre_qa_or_fr := join( not_in_key_pre_qa,key_pre_fr,
             KEYED(LEFT.did=RIGHT.did)
             AND LEFT.ssn 			  = RIGHT.ssn
			 AND LEFT.dob 			  = RIGHT.dob
			 AND LEFT.title 		  = RIGHT.title
			 AND LEFT.fname 		  = RIGHT.fname
			 AND LEFT.mname 		  = RIGHT.mname
			 AND LEFT.lname 		  = RIGHT.lname
			 AND LEFT.name_suffix     = RIGHT.name_suffix
             AND LEFT.prim_range      = RIGHT.prim_range
             AND LEFT.predir 		  = RIGHT.predir
             AND LEFT.prim_name       = RIGHT.prim_name
             AND LEFT.suffix 		  = RIGHT.suffix
             AND LEFT.postdir 		  = RIGHT.postdir
             AND LEFT.st 			  = RIGHT.st
             AND LEFT.zip 			  = RIGHT.zip    ,LEFT ONLY,FEW);

not_in_key_or_sprn_list := join( not_in_key_pre_qa_or_fr, boc_sprsn,
                 LEFT.did             = RIGHT.did
             AND LEFT.ssn 			  = RIGHT.ssn
			 AND LEFT.dob 			  = RIGHT.dob
			 AND LEFT.title 		  = RIGHT.title
			 AND LEFT.fname 		  = RIGHT.fname
			 AND LEFT.mname 		  = RIGHT.mname
			 AND LEFT.lname 		  = RIGHT.lname
			 AND LEFT.name_suffix     = RIGHT.name_suffix
             AND LEFT.prim_range      = RIGHT.prim_range
             AND LEFT.predir 		  = RIGHT.predir
             AND LEFT.prim_name       = RIGHT.prim_name
             AND LEFT.suffix 		  = RIGHT.suffix// ok till here
             AND LEFT.postdir 	      = RIGHT.postdir
             AND LEFT.st 		      = RIGHT.st
             AND LEFT.zip 		      = RIGHT.zip
             ,LEFT ONLY,FEW);

o3:=output(not_in_key_or_sprn_list,named('not_in_key_or_sprn_list'));      
      
need_to_auto_add_before_rebuilding_keys := in_both_by_did_rid+join(in_both_by_did_rid,not_in_key_or_sprn_list, LEFT.did=RIGHT.did AND LEFT.rid=RIGHT.rid,few):independent;
o4:=output(need_to_auto_add_before_rebuilding_keys,named('need_to_auto_add_before_rebuilding_keys'));

need_to_reidentify_rid_before_being_able_to_suppress := join(in_both_by_did_rid,not_in_key_or_sprn_list, LEFT.did=RIGHT.did AND LEFT.rid=RIGHT.rid,LEFT ONLY,few);
o5:= output(need_to_reidentify_rid_before_being_able_to_suppress,named('Alpha_recs_not_filtering_by_rid'));

// Run the QH filter and see what we do not match

add_alpha_suppressions := 
if (count(need_to_auto_add_before_rebuilding_keys)>0,
    header.fn_block_records.add_dataset('Alpharetta',project(need_to_auto_add_before_rebuilding_keys,{LEFT.did,LEFT.rid}))
    ,output('No suppression records were added')
  );
  
base_name := '~thor_data400::key::pre_file_header_building::';
file_date := header.version_build;

promote := sequential(
    fileservices.createsuperfile    (base_name+'qa'                         ,,true),
    fileservices.createsuperfile    (base_name+'father'                     ,,true),
    fileservices.createsuperfile    (base_name+'delete'                     ,,true),
    fileservices.addsuperfile       (base_name+'delete',base_name+'father'  ,,true),
    fileservices.clearsuperfile     (base_name+'father'                           ),
    fileservices.addsuperfile       (base_name+'father',base_name+'qa'      ,,true),
    fileservices.clearsuperfile     (base_name+'qa'                               ),
    fileservices.addsuperfile       (base_name+'qa'    ,base_name+'built'   ,,true),
    fileservices.clearsuperfile     (base_name+'built'                            ),
    fileservices.RemoveOwnedSubFiles(base_name+'delete'                     ,true ),
);

supression_status_report := sequential(output_as_is_files);

// THIS BWR: W:\Projects\Header\suppress_header_records\check_and_update_boca_suppression.ecl


// /* STEP 1 */ sequential(o1,o2,o3,o4,o5); // Check: JUST RUN. It will generate report
// /* STEP 2 */ add_alpha_suppressions; 
/* STEP 3 */ sequential(o1,o2,o3,o4,o5); // Check: JUST RUN. It will generate report

/*

version
(p)romote key
(b)uild key
(c)heck after
(u)pdate file
(c)heck before

20180821
W20180917-125931
W20180917-130347
W20180917-130554

20180724
W20180819-214803
W20180819-215320
W20180819-215645

20180626
W20180709-105822
W20180709-110234
W20180709-111217

20180522
W20180615-105332
W20180615-105734
W20180615-110234


201804xx

p
b http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180521-095347#/stub/Summary
c http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180513-110707#/stub/Summary
u http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180513-110527#/stub/Summary
c 142/4 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-150202#/stub/Summary

20180423

u
c 283/19 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180513-110338#/stub/Summary

20180320

p http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180420-095236#/stub/Summary
b http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-151417#/stub/Summary
c http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180405-133348#/stub/Summary
u http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180405-133109#/stub/Summary
c http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180405-132641#/stub/Summary

20180221
p http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180418-122227#/stub/Summary
b W20180320-134501
c W20180312-125637
u W20180312-125529
c (206/4) W20180312-125238

20180130
p W20180314-160244
b W20180314-152436
u W20180226-132752
c (184/ 12) W20180226-131544

*/
// OLD 
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |check1 no add   |add to boca list|check2 no orphan|key build       |Promote Key     |Gap found|version |
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20180124-113918|W20180124-114041|W20180124-114116|W20180206-095112|W20180215-141638|500/35   |20171227|
// |W20171211-141935|W20171211-142152|W20171211-142341|W20180102-143031|W20180124-113536|523/25   |20171121|
// |W20171115-083721|W20171115-084336|                |W20171206-091345|W20180102-142338|756/48   |20171025a|
// |W20171115-083721|W20171115-084336|48/756 | ----------------------------------------------------20171025|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20171019-090728|W20171019-090909|W20171019-091115|W20171102-203853|W20171110-110026                              | 201/26  |20170925|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170925-104901|W20170925-110306|W20170925-110431|W20171019-082349|W20171023-160515| 533/17  |20170828|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170828-085216|W20170828-085358|W20170828-085541|W20170906-115500|W20170925-110023|242+4    |20170725|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170719-162644|W20170719-163313|W20170719-163348|W20170807-100444|W20170816-103151| 211/09  |20170628|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170623-131537|W20170623-131902|                |W20170717-121541|MANUAL 20170807 | 200/10  |20170522|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170526-202752|W20170526-203018|W20170526-203218|W20170612-101541|W20170623-131537|         |20170430|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170418-094239|W20170418-094519|W20170418-094609|W20170426-132643|W20170509-115106| 511     |20170321|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170310-115503|W20170310-115750|W20170310-115931|W20170404-135903|----------------|---------|20170223|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170213-083040|W20170213-111421|W20170213-123014|                |----------------| 355     |--------|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+
// |W20170106-123258 W20170106-123552 W20170106-123839|W20170119-164353|----------------|  was 180|--------|
// +----------------+----------------+----------------+----------------+----------------+---------+--------+

// W20161201-113108 promote
// W20160830-105116
// W20160812-141406
// W20160812-124003
