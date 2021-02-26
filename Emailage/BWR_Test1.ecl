import Header, MDR, STD, _Control, Watchdog, ut, dx_BestRecords;

#workunit('name', 'EMailage Stats build');
// #workunit('name', 'EMailage DeSpray Files');
// $.Despray;

metadata    := $.Files.MetaData;
names 		:= $.Files.Names;
address 	:= $.Files.Address;
emails 		:= $.Files.Emails;
phones 		:= $.Files.Phones;
relatives 	:= $.Files.Relatives;
fraudflags  := $.Files.FraudFlag;

t_names := table(names, {lexid, cnt := count(group)}, lexid, few, merge);
j_names := join(names, t_names, left.lexid = right.lexid, local);
output(choosen(j_names(cnt > 15), 100), named('sample_names_w_cnt_gt_15'));
output(choosen(j_names((cnt between 5 and 15)), 100), named('sample_names_w_cnt_bt_5_15'));
output(choosen(j_names(cnt < 5), 100), named('sample_names_w_cnt_lt_5'));

t_address := table(address, {lexid, cnt := count(group)}, lexid, few, merge);
j_address := join(address, t_address, left.lexid = right.lexid, local);
output(choosen(j_address(cnt > 15), 100), named('sample_address_w_cnt_gt_15'));
output(choosen(j_address((cnt between 5 and 15)), 100), named('sample_address_w_cnt_bt_5_15'));
output(choosen(j_address(cnt < 5), 100), named('sample_address_w_cnt_lt_5'));

output(emails, named('sample_emails'));
output(relatives, named('sample_relatives'));

t_phones := table(phones, {lexid, cnt := count(group)}, lexid, few, merge);
output(sort(t_phones, -cnt), named('phones_cnt'));
output(phones, named('sample_phones'));

t_fraudflags := table(fraudflags, {lexid, cnt := count(group)}, lexid, few, merge);
output(sort(t_fraudflags, -cnt), named('fraudflags_cnt'));
output(fraudflags, named('sample_fraudflags'));

rSeg := RECORD
	string seg;
	unsigned4 cnt_main := 0;
	unsigned4 cnt_names := 0;
	unsigned4 cnt_address := 0;
	unsigned4 cnt_email := 0;
	unsigned4 cnt_relatives := 0;
	unsigned4 cnt_phones := 0;
	unsigned4 cnt_fraudflags := 0;
END;

seg := pull(Header.key_ADL_segmentation);
main_seg := join(distribute(metadata, hash(lexid)), distribute(seg, hash(did)), left.lexid = right.did, local);
t := table(main_seg, {ind1, cnt_main := count(group)}, ind1, few, merge);

names_seg := join(dedup(distribute(names, hash(lexid)), lexid,all), distribute(seg, hash(did)), left.lexid = right.did, local);
t1 := table(names_seg, {ind1, cnt_names := count(group)}, ind1, few, merge);

address_seg := join(dedup(distribute(address, hash(lexid)), lexid,all), distribute(seg, hash(did)), left.lexid = right.did, local);
t2 := table(address_seg, {ind1, cnt_address := count(group)}, ind1, few, merge);

emails_seg := join(dedup(distribute(emails, hash(lexid)), lexid,all), distribute(seg, hash(did)), left.lexid = right.did, local);
t3 := table(emails_seg, {ind1, cnt_email := count(group)}, ind1, few, merge);

rels_seg := join(dedup(distribute(relatives, hash(lexid1)), lexid1,all), distribute(seg, hash(did)), left.lexid1 = right.did, local);
t4 := table(rels_seg, {ind1, cnt_relatives := count(group)}, ind1, few, merge);

phones_seg := join(dedup(distribute(phones, hash(lexid)), lexid,all), distribute(seg, hash(did)), left.lexid = right.did, local);
t5 := table(phones_seg, {ind1, cnt_phones := count(group)}, ind1, few, merge);

fraudflags_seg := join(dedup(distribute(fraudflags, hash(lexid)), lexid,all), distribute(seg, hash(did)), left.lexid = right.did, local);
t6 := table(fraudflags_seg, {ind1, cnt_fraudflags := count(group)}, ind1, few, merge);

j := join(t,t1,   left.ind1 = right.ind1 ,transform(rSeg, self.seg := left.ind1; self := left; self := right;));
j1 := join(j,t2,  left.seg = right.ind1  ,transform(rSeg, self := right; self := left;));
j2 := join(j1,t3, left.seg = right.ind1  ,transform(rSeg, self := right; self := left;));
j3 := join(j2,t4, left.seg = right.ind1  ,transform(rSeg, self := right; self := left;));
j4 := join(j3,t5, left.seg = right.ind1  ,transform(rSeg, self := right; self := left;));
j5 := join(j4,t6, left.seg = right.ind1  ,transform(rSeg, self := right; self := left;));
output(j5, named('all_seg_cnt'));

// hdr := Header.File_Headers;
// hdr_filtered_by_src := hdr(src not in PublicData.Filters.SRC_EXCLUSIONS and ~MDR.Source_is_DPPA(src)) + Header.File_TUCS_did;/* + Header.File_TN_did*/

// count(hdr_filtered_by_src); //11,039,206,088
// count(hdr_filtered_by_src(mdr.sourceTools.SourceIsGLB(src) = true)); //5,070,472,799
// count non_glb = 11,039,206,088 - 5,070,472,799 = 5,968,733,289
// output(count(hdr_filtered_by_src(~mdr.Source_is_Utility(src) and src <> 'EQ')), named('nonglb_count')); //5,968,733,289

