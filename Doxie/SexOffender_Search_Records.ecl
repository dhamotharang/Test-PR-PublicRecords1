import doxie, codes, FFD;

export sexoffender_search_records (
  DATASET (doxie.layout_best) ds_best  = DATASET ([], doxie.layout_best),
  boolean IsFCRA = false,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0 
	) := function

doxie.mac_header_field_declare(IsFCRA);

so_slim_pc_recs := slim_pc_recs(datagroup in FFD.Constants.DataGroupSet.SexOffender);
f_person := doxie.SexOffender_Search_People_Records (ds_best, IsFCRA, so_slim_pc_recs, inFFDOptionsMask);
f_events := doxie.SexOffender_Search_Events_Records (f_person, ds_best, IsFCRA, so_slim_pc_recs, inFFDOptionsMask);

//dedup on every field except those name realted and did_score			   
f1 := dedup(f_person, except lname, except fname, except mname, except name_suffix, 
                      except name_orig, except name_type, except score, all);

//save spk and name fields
did_name_rec := record
	string60 	seisint_primary_key;
     doxie.layout_sexoffender_name;
end;

f2 := project(f_person, did_name_rec);

doxie.layout_sexoffender_report init_name_off(f1 L) := transform
     self.offenses := [];
     self.name := [];
	self.addresses := l.addresses(alt_type='B'); 
	self := l;
end;

f3 := project(f1, init_name_off(left));

//add name field
doxie.layout_sexoffender_report get_name(f3 l, f2 r) := transform
     self.name := l.name + project(r,transform(doxie.layout_sexoffender_name,self:=left));
     self := l;
end;

f4 := denormalize(f3, dedup(f2,all), left.seisint_primary_key = right.seisint_primary_key, get_name(left, right));

f5 := dedup(f_events,all);

//add offenses to f_person
doxie.layout_sexoffender_report get_offenses(f4 l, f5 r) := transform
     self.offenses := l.offenses + 
					project(r,
					transform(Layout_Sexoffender_Offense_Decode,
					self.victim_minor_name:=(string3)codes.GENERAL.YESNO(LEFT.victim_minor),
					self:=LEFT));

     // bring "best" name on top: 0 = primary name; 2 = AKA name; 3 = Alias DOB
     self.name := sort (l.name, name_type, lname,fname, mname, name_suffix=''); 
     self := l;
end;

f6 := denormalize(f4, f5, 
                  left.seisint_primary_key = right.seisint_primary_key,
			   get_offenses(left,right));

emptyout := dataset([], doxie.layout_sexoffender_report);

return if(is_a_neighbor, emptyout, f6);
end;