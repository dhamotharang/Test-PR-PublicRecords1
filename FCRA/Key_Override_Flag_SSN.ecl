/*2012-03-21T20:12:03Z (Dave Schlangen_Prod)
added prefix to point at dataland for override keys to test on 1 way roxie
*/
import fcra, ut, data_services;

ds := FCRA.File_flag;

fcra.Layout_override_flag proj_recs(ds l) := transform
	self.did := trim(intformat((integer)l.did,12,0),left,right);
	self := l;
end;

ds_out := project(ds,proj_recs(left));

kf1 := distribute(ds_out
				(did <> '' and flag_file_id not in FCRA.Suppress_Flag_File_ID),hash(did,record_id,file_id));

sortkf1 := sort(kf1,did,record_id,file_id,-flag_file_id,local);

kf := dedup(sortkf1,did,record_id,file_id,local);

export key_override_flag_ssn := index(kf,{l_ssn := ssn}, {kf},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::flag::qa::ssn');