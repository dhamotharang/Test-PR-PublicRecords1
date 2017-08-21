//Create a key with all expired DIDs and their new DID

a := watchdog.File_Delta(assigned_did>1);

two_dids := record
 string12 old_did;
 string12 new_did;
end;

two_dids keyFormat(a L) := transform
 self.old_did := intformat(l.did,12,1);
 self.new_did := if(l.assigned_did=2,intformat(0,12,1),intformat(l.assigned_did,12,1));
end;

first1 := output(project(a,keyFormat(left))(old_did!=new_did),,'jgtemp::watchdog_did_list',overwrite);

//******Build Keys
string_rec := record
	two_dids;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

t := dataset('jgtemp::watchdog_did_list',string_rec,flat);

second1 := BUILDINDEX(t,,'~thor_data400::key::watchdog_moxie_old_did.did', overwrite, moxie);

export Proc_Old_DID := sequential(first1,second1);