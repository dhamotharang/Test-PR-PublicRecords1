import BIPV2_Build,BIPV2,lksd;

//gather some randomish test data along with the IDs in question
ck := BIPV2_Build.key_contact_linkids.key;
samp := ck(ultid in [88399440,281,2702,3943,731603213,56091671,221053333,219872093,558241890,14102647,14167680] + set(BIPV2_Suppression.ds_contacts, biz.ID));
lksd.oc(samp)

//test the BH linkid key
bhkey := BIPV2.Key_BH_Linking_Ids.kfetch( project(samp, transform(BIPV2.IDlayouts.l_xlink_ids, self := left, self := [])));
lksd.oc(bhkey)
bhkey_shady := bhkey(fname in set(BIPV2_Suppression.ds_contacts, person.fname) and lname in set(BIPV2_Suppression.ds_contacts, person.lname));
lksd.oc(bhkey_shady)

//run the suppression on this sample
BIPV2_Suppression.mac_contacts(samp, outf_clean, outf_dirty)

//check the restuls from this sample
outf_dirty_simple := dedup(table(outf_dirty, {outf_dirty.company_name, outf_dirty.contact_name.fname, outf_dirty.contact_name.mname, outf_dirty.contact_name.lname}), all);
lksd.oc(outf_clean)
lksd.oc(outf_dirty)
lksd.oc(outf_dirty_simple)
output(if(count(samp) = count(outf_clean) + count(outf_dirty), 'GOOD: counts match', 'BAD: Counts do not match! (but may be to new unaccounted for calls to Suppress.MAC_Suppress)'));

//now run the fetch that contains the suppression
seles := dedup(dataset(set(BIPV2_Suppression.ds_contacts, biz.id), {unsigned6 ultid}), all);
seles_4fetch := project(seles, transform(BIPV2.IDlayouts.l_xlink_ids, self := left, self := []));
fetched := BIPV2_Build.key_contact_linkids.kfetch(seles_4fetch, BIPV2.IDconstants.Fetch_Level_UltID);
fetched_shady := fetched(contact_name.fname in set(BIPV2_Suppression.ds_contacts, person.fname) and contact_name.lname in set(BIPV2_Suppression.ds_contacts, person.lname));
lksd.oc(seles_4fetch)
lksd.oc(fetched)
lksd.oc(fetched_shady)
