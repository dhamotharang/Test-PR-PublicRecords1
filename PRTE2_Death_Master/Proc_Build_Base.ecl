import ut,promotesupers, std, prte2_death_master, lib_date, prte2,nid;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

  ds_in := PROJECT(prte2_death_master.files.Death_Master_IN, 
                             TRANSFORM(Layouts.layout_death_master_base, 
                                       SElF := LEFT, 
                                       SELF := []
                                       )
                             ); 

  //uppercase and remove spaces from in file
  PRTE2.CleanFields(ds_in, ds_clean);
  
  ds_prep := project(ds_clean, TRANSFORM
                               (layouts.layout_death_master_base, 
                               self.dph_lname := metaphonelib.DMetaPhone1(LEFT.lname);
                               self.pfname := NID.PreferredFirstVersionedStr(LEFT.fname, NID.version);
                               self := LEFT;
                               SELF := []
                               )
                     );
  
  //Splitting New & Old Records
  d_OldRecords := ds_prep(cust_name = '');
  d_NewRecords	:= ds_prep(cust_name <> '');  
 
  //clean new records
  layouts.layout_death_master_base xform(d_NewRecords le) := transform
    months_since_death := STD.Date.MonthsBetween((unsigned8)le.dod8,STD.Date.Today());
    restricted_ssa := months_since_death <= 36 and le.death_rec_src='SSA';
    unrestricted_ssa := months_since_death > 36 and le.death_rec_src='SSA';
    //flag as ssa restricted for records where date of death is < 3 years and source = 'SSA'
    self.src := if(restricted_ssa, 'D$', if(unrestricted_ssa, 'DE', le.src));
    fake_did :=  (string)prte2.fn_AppendFakeID.did(le.fname, le.lname, le.link_ssn, le.link_dob, le.cust_name);
    self.did :=  fake_did;
    self.l_did := fake_did;
    self := le;
  end;
  d_NewRecords_Clean := project(d_NewRecords, xform(left));
  
  d_AllRecordsClean := d_OldRecords + d_NewRecords_Clean;
  
  PromoteSupers.Mac_SF_BuildProcess(d_AllRecordsClean, prte2_death_master.Constants.DEATH_MASTER_BASE,writefile,,,,filedate);  
  
  RETURN writefile;

END;