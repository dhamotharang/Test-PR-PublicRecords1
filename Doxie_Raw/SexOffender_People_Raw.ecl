import sexoffender,doxie_build,autokey,ut,doxie,suppress, sexoffender_Services, FCRA, lib_ziplib, Data_Services,FFD;

export SexOffender_People_Raw(
			dataset(Doxie.layout_references) dids,
			string14 did_value = '',
			string60 sid_value = '',
			string14 uid_value= '',
			boolean includeExtra = false,
			unsigned4 dateVal = 0,
			unsigned1 dppa_purpose = 0,
			unsigned1 glb_purpose = 0,
			string32 application_type_value = '',
			string6 ssn_mask_value = 'NONE',
			string5 in_zip_value = '',
			unsigned8 maxresults = 2000,
			string9 in_ssn_value = '',
			boolean zip_only_search_flag = false,
			boolean IsFCRA = false,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0
) := FUNCTION

//keys
key_did := sexoffender.key_sexoffender_did (IsFCRA);
key_spk := sexoffender.key_sexoffender_spk (IsFCRA);

real in_lat_value := (real)(ziplib.ZipToGeo21(in_zip_value)[1..9]);
real in_long_value := (real)(ziplib.ZipToGeo21(in_zip_value)[11..]);

res_spk :=
RECORD
	typeof(key_spk.sspk) spk;
	unsigned6 did;
	real dist;
	unsigned1 rec_source := 0; //0 from SO file, 1 from enh
END;

/* ******* Get all sex offenders by standard did ********** */
res_spk get_recs_did(key_did r) := transform
	self.spk := r.seisint_primary_key;
	self.did := r.did;
	self.dist := map(in_zip_value='' => 0,
	                 r.lat=0 and r.long=0 => 999999,
				  ut.LL_Dist(in_lat_value,in_long_value,r.lat,r.long));
end;
//did_records := join(TOPN(dids,MaxResults_val,did),sexoffender.key_sexoffender_did,keyed(left.did=right.sdid), get_recs_did(right));
did_records := join(dids, key_did, 
                    keyed(left.did=right.did), 
                    get_recs_did(right), ATMOST (ut.limits. SOFFENDER_MAX));

/* ******* Get all sex offenders by sid and then did********** */
res_spk get_recs_spk(key_spk r) := transform
	self.spk := r.seisint_primary_key;
	self.did := r.did;
	self.dist := map(in_zip_value='' => 0,
	                 r.lat=0 and r.long=0 => 999999,
				  ut.LL_Dist(in_lat_value,in_long_value,r.lat,r.long));
end; 

ds_sspk := key_spk(keyed(sspk=sid_value AND sid_value<>''));

// artificial limit until #22000 is fixed; after that should just SOFFENDER_MAX
SSPK_MAX := 5 * ut.limits.SOFFENDER_MAX;

sid_records := project (LIMIT (ds_sspk, SSPK_MAX, SKIP), get_recs_spk(left));
sid_did_records := join(sid_records,key_did,
                        keyed(left.did=right.did), 
                        get_recs_did(right), ATMOST (ut.limits. SOFFENDER_MAX))+sid_records;

/* ******* Get all sex offenders by fake did********** */
i := sexoffender.Key_SexOffender_fdid;

res_spk get_fake_recs(i ri, unsigned1 src_val) :=
TRANSFORM
	self.spk := ri.seisint_primary_key;
	self.did := ri.did;
	self.dist := map(in_zip_value='' => 0,
	                 ri.lat=0 and ri.long=0 => 999999,
				  ut.LL_Dist(in_lat_value,in_long_value,ri.lat,ri.long));
	self.rec_source := src_val;			  
	
END;
fake_fetch := JOIN(autokey.get_dids(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::so_' + doxie_build.buildstate,,,false),
				           i, keyed(left.did=right.did),
                   get_fake_recs(right, 0), KEEP (1));
									
fake_dids_plus := if(zip_only_search_flag, doxie.sexoffender_fetch_by_zip(~includeExtra),
                autokey.get_dids(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::so_enh' + doxie_build.buildstate,,,~includeExtra));									
									 
fake_fetch_plus := JOIN(fake_dids_plus,
				           i, keyed(left.did=right.did), 
                   get_fake_recs(right, 1), KEEP (1));

/* ******* Figure out what we want and get those records ********** */
sid_mapped := MAP(IsFCRA => did_records,
									sid_value<>'' AND (uid_value<>'' OR did_value<>'')	=> did_records+sid_did_records,
									sid_value<>'' 								=> sid_did_records,
									did_records+fake_fetch+IF(includeExtra,fake_fetch_plus));

sid_chooser := TOPN(dedup(sort(sid_mapped, spk, dist, rec_source), spk), maxResults, dist, rec_source, spk);
sid_recs := project(sid_chooser, transform(sexOffender_Services.Layouts.search, 
																					self.seisint_primary_key := left.spk, 
																					self := [])); //isDeepDive

// overrides for FCRA
ds_best  := project(sid_mapped,transform(doxie.layout_best,self.did:=left.did, self:=[])); //using sid_mapped since it has did if available. For FCRA we only use DID to get overrides.
ds_flags := if(isFCRA, FCRA.GetFlagFile (ds_best)); //this could potentially be for more than one person....

fetchedLocal := SexOffender_Services.Raw.getRawOffenders(sid_recs, application_type_value,isFCRA, ds_flags, slim_pc_recs, inFFDOptionsMask);
doxie.layout_sexoffender_searchperson get_full_rec(SexOffender_Services.Layouts.raw_rec ri) :=
TRANSFORM
	self.source := doxie_build.buildstate;
	self.unit_desig := if(ri.unit_desig='DEPT' and ri.sec_range='OF', '', ri.unit_desig);
	self.sec_range := if(ri.unit_desig='DEPT' and ri.sec_range='OF', '', ri.sec_range);
	SELF.addresses := [];
	SELF := ri;
END;
f_fetchedlocal := project(fetchedLocal(dateVal = 0 or (unsigned3)(dt_first_reported) <= dateVal), get_full_rec(left));

out_f := sort(f_fetchedlocal(ssn_appended='' or in_ssn_value='' or ssn_appended=in_ssn_value),record);

doxie.MAC_PruneOldSSNs(out_f, out_f_p1, ssn, did, isFCRA);
doxie.MAC_PruneOldSSNs(out_f_p1, out_pruned, ssn_appended, did, isFCRA);

suppress.MAC_Mask(out_pruned, results_cleaned, ssn, blank, true, false);
suppress.MAC_Mask(results_cleaned, out_mskd, ssn_appended, blank, true, false);

return out_mskd;

END;
