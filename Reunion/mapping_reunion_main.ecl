//-----------------------------------------------------------------------------
// Builds the main, which is a file of header info associated with the data
// from the input files and some relatives.
//-----------------------------------------------------------------------------
IMPORT address, STD;

EXPORT mapping_reunion_main(unsigned1 mode = 1, STRING sVersion = reunion.constants.sVersion) := MODULE

// various_appends is the reunion_clean with some relatives added in and with
// additional information on best, phone, death, and job information
// dAppends:=reunion.various_appends;
sPrefix := '~thor::base::mylife::' + reunion.Constants.sMode(mode) + '::';
attrSF := sPrefix + 'append_attributes';

dFullMain := project(reunion.files(1).dMain, transform({unsigned6 did}, self.did := (unsigned6)left.adl));
dCoreMain := project(reunion.files(2).dMain, transform({unsigned6 did}, self.did := (unsigned6)left.adl));
dCurrentMain := distribute(dedup(dFullMain + dCoreMain, did, all), HASH(did));

dwAttributes := dataset(attrSF, reunion.layouts.lMainRaw, thor);
dwCoreAttributes := join(dCurrentMain, distribute(dwAttributes, hash(did)), left.did = right.did, transform(right), right only, local);

dAppends := if(mode = 1, dwAttributes, dwCoreAttributes);

dPatchedFname:=if(count(dAppends(TRIM(fname)='')) > 0, reunion.fn_patch_blank_fname(dAppends), dAppends);
dPatchedLname:=if(count(dAppends(TRIM(lname)='')) > 0, reunion.fn_patch_blank_lname(dPatchedFname), dPatchedFname);

// Reformat the patched appends data to put the best information in the
// appropriate fields
lAppends:=RECORD
  dPatchedLname.did;
  dPatchedLname.came_from;
  dPatchedLname.prim_range;
  dPatchedLname.prim_name;
  dPatchedLname.sec_range;
  dPatchedLname.zip;
  reunion.layouts.lMain;
  reunion.layouts.lAttributes - [main_adl];
  UNSIGNED6 record_id:=0;
  BOOLEAN get_other_elements:=FALSE;
END;

lAppends tGetBest(dPatchedLname L):=TRANSFORM 
  SELF.adl:=INTFORMAT(L.did,12,1);
  SELF.best_title:=L.title;
  SELF.best_fname:=L.fname;
  SELF.best_mname:=L.mname;
  SELF.best_lname:=L.lname;
  SELF.best_name_suffix:=L.name_suffix;
  SELF.best_street:=address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.suffix,L.postdir,L.unit_desig,L.sec_range);
  SELF.best_city:=L.city_name;
  SELF.best_st:=L.st;
  SELF.best_zip:=L.zip+IF(L.zip4<>'','-'+L.zip4,''); 
  SELF.phone:=L.phone;
  SELF.best_dob:=IF((INTEGER)L.dob<>0,L.dob,'');
  SELF.prof_lic_job_desc:=L.job_desc;
  SELF:=L;
END;
dAppendsFormatted:=PROJECT(dPatchedLname,tGetBest(LEFT));

// We only want to keep best up to a specific number of relative rows, so
// separate out relatives from the formatted file and then assign a sequential
// number to them, then add them back to the non-relative data
dCandidates:=dAppendsFormatted(came_from IN ['2','3']);
dNotCandidates:=dAppendsFormatted(~(came_from IN ['2','3']));
dCandidates02:=PROJECT(dCandidates,TRANSFORM(lAppends,SELF.record_id:=COUNTER+1;SELF.get_other_elements:=TRUE;SELF:=LEFT;));
dAll:=dNotCandidates+dCandidates02;

// Remove best information for any relative records that exceed the threshold
lAppends tKeepBest(dAll L, integer C):=TRANSFORM
  // bInclude:=L.came_from='1' OR (L.get_other_elements=TRUE AND L.record_id<reunion.constants.threshold_);
  bInclude:=L.came_from in ['1', '4', '5'] OR (L.get_other_elements=TRUE AND L.record_id<reunion.constants.threshold_);
  SELF.best_street:=IF(bInclude=TRUE,L.best_street,'');
  SELF.best_city:=IF(bInclude=TRUE,L.best_city,'');
  SELF.best_st:=IF(bInclude=TRUE,L.best_st,'');
  SELF.best_zip:=IF(bInclude=TRUE,L.best_zip,''); 
  SELF.phone:=IF(bInclude=TRUE,L.phone,'');
  SELF.prof_lic_job_desc:=IF(bInclude=TRUE,L.prof_lic_job_desc,'');
  SELF.get_other_elements:=bInclude;  //important step
  SELF:=L;
END;
dMain:=PROJECT(dAll,tKeepBest(LEFT, COUNTER));

EXPORT all := dMain:PERSIST('~thor::persist::mylife::mapping_main::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));

END;