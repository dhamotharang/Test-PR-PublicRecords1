// Calculate number of business links

f := Business_Header.File_Super_Group;

layout_group_stat := record
f.group_id;
cnt := count(group);
end;

fstat := table(f, layout_group_stat, group_id);

count(fstat);
count(fstat(cnt > 1));
sum(fstat(cnt > 1), cnt);

/*
fr := Business_Header.File_Business_Relatives(not rel_group);
round(count(fr)/2);

// Select only BDIDs we group together
frg := join(fr,
            f,
		  left.bdid1 = right.bdid,
		  transform(Business_Header.Layout_Business_Relative, self := left),
		  hash);
		  
count(frg);
round(count(frg)/2);
*/

br := business_header.File_Business_Relatives(not rel_group, bdid2 < bdid1);
br_init := br(business_header.mac_isGroupRel(br));

count(br_init);

// Count number of BBB businesses
count(bbb2.Files.base.member.qa);
count(bbb2.Files.base.nonmember.qa);

