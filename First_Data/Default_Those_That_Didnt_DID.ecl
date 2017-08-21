
infutor_census_no_did := first_data.Get_Census(did=0);

first_data.layout_fatrec assign_those_that_didnt_did(first_data.layout_fatrec l) := transform
 //What this code is intended to do is take Marketing Header record (based on lname + address)
 //over the Infutor record that didn't DID.
 //Sort/Dedup is on infutor_or_mktg_ind: 1=Infutor_did, 2=Marketing, and 3=Infutor_no_did
 self.infutor_or_mktg_ind := '3';
 self.mktg_fname          :=l.fname;
 self.mktg_mname          :=l.mname;
 self.mktg_lname          :=l.lname;
 self.mktg_name_suffix    :=l.name_suffix;
 self.mktg_dob            := 0;
 self.mktg_dod            :='';
 self.mktg_total_records  := 0;
 self.mktg_attempt        :=''; 
 self                     := l;
end;

export Default_Those_That_Didnt_DID := project(infutor_census_no_did,assign_those_that_didnt_did(left));