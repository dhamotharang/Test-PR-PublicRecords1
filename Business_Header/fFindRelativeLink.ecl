// ok, now got all links between records, now find how two passed bdids are related
// looks like in the creation of the supergroups, there would be a maximum degree separation of five
// based on the transitive closure join--adds 1
// and the three mac_chain_child calls + 3
// and the relatives file itself + 2
/*
	transitive closure join takes two relatives records(which make a link between three bdids--two are the same)
	and makes a new relative record using the bdid2s of the two records(the bdid1s are the same).
	at this point we would have three records.  one with the left relative record by itself, one with the right, 
	and one with all three, so we don't miss any links.
*/
export fFindRelativeLink(unsigned6 pBdid1 = 0, unsigned6 pBdid2 = 0, unsigned6 pGroup_Id = 0) :=
function

	file_sg := File_Super_Group(group_id = pGroup_Id);
	
	thor_cluster := '~thor_data400::';
	
	layout_bdid := 
	record
		file_sg.bdid;
	end;
	// Get all bdids in the group
	group_bdids := table(file_sg, layout_bdid, bdid) + dataset([(pGroup_Id)], layout_bdid);
	
	file_rel := Business_Header.Key_Business_Relatives;
	
	// Get all business relatives records for the bdids in the group
	Layout_Relative_Link.Relative_Flagged tGetLinks(recordof(file_rel) l) :=
	transform
	
		self := l;
	
	end;

	relative_links := join(	 group_bdids
							,file_rel
							,left.bdid = right.bdid1
							,tGetLinks(right)
							,keyed
						);
	
	Layout_Relative_Link.Relative_Flagged Reverse_BDIDs(Layout_Relative_Link.Relative_Flagged L) :=
	transform
		self.bdid1	:= L.bdid2;
		self.bdid2	:= L.bdid1;
		self		:= L;
	end;

	Layout_Relative_Link.Relative_Flagged ReformatRelatives(recordof(file_rel) L) :=
	transform
		self		:= L;
	end;
	full_relatives		:= project(file_rel, ReformatRelatives(left));
	relative_links_reverse := project(relative_links, Reverse_BDIDs(left));

	relative_links_total := if(pGroup_Id != 0, relative_links + relative_links_reverse
											, full_relatives);
	
	relative_links_dedup := dedup(sort(distribute(relative_links_total, hash(bdid1, bdid2)), bdid1, bdid2, local), bdid1, bdid2, local);
	
	links_count := output(count(relative_links_dedup) + ' Relative records for GroupId: ' + pGroup_Id);

	all_links := fTransitiveClosure(relative_links_dedup);

	return all_links;

end;






