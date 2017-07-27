import ut, doxie_cbrs, business_header;

export fn_DCA_records_dayton(
  dataset(doxie_cbrs.layout_references) thegroupids,
	boolean in_use_supergroup,
	unsigned1 in_direction = 0
) := function
	bdid_dataset :=
		table(
			doxie_cbrs.fn_getSupergroup(
				project(
					thegroupids,
					transform(
						doxie_cbrs.layout_supergroup,
						self.group_id := 0,
						self.level := 0,
						self := left)),
				business_header.stored_use_Levels_val),
			{bdid});
	ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use)
	
	tempdca := doxie_cbrs.get_DCA_records(if(in_use_supergroup,bdids_use,thegroupids),if(in_use_supergroup,1,in_direction));
	temprec := record
	  tempdca;
		unsigned6 group_id;
	end;
	kb := Business_Header.Key_BH_SuperGroup_BDID;
	temprec attachgroupid(tempdca l, kb r) := transform
	  self.group_id := r.group_id;
		self := l;
	end;
	res := join (tempdca, kb,
               keyed (left.bdid=right.bdid),
               attachgroupid(left,right),
               left outer,
               keep (1), limit (0));
  return res (group_id <> 0);
end;