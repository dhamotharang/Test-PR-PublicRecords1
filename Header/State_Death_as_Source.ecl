import ut;
death_in := header.file_state_death;

src_rec := record
  Layout_Source_ID;
	layout_state_death;
end;

src_rec clean(death_in le) := transform
  self := le;
  self := [];
end;

no_id := project(death_in, clean(left));

header.Mac_Set_Header_Source(no_id, src_rec, src_rec, 'DS', with_id)

export State_Death_as_Source := with_id : persist('persist::headerbuild_state_death_src');