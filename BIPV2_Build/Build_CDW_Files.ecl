import BIPV2,BIPV2_PostProcess,BIPV2_Best,tools;

EXPORT Build_CDW_Files(

  string pversion = bipv2.KeySuffix

) :=
function

  //add email notification
  //should these reference datasets rather than files on disk so that they can run during build?
  /*
  1) dedup owner file on all fields
  2) make files dated and put them into superfiles
  2) add this to the BIP build at the end
  3) add email notification to behnoosh and me
  4) make sure all these fields are in the owner file (some will need to be
  added):
  first_name
  middle_name
  Last_name
  suffix
  prim_range
  predir
  Prim_name
  addr_suffix
  postdir
  unit_desig
  sec_range
  city
  state
  zip
  zip4
  SSN

  */
  /*
  https://bugzilla.seisint.com/show_bug.cgi?id=168171


  */
  // b := pull(choosen(BIPV2_Best.Key_LinkIds.KeyFather, ALL));// : persist('~thor_data400::cemtemp.b');
  // h := choosen(BIPV2.CommonBase.DS_FATHER, ALL);// : persist('~thor_data400::cemtemp.h'); //change!!!!
  b := pull(choosen(BIPV2_Best.Key_LinkIds.KeyBuilt, ALL));// : persist('~thor_data400::cemtemp.b');
  h := choosen(BIPV2.CommonBase.DS_BUILT, ALL);// : persist('~thor_data400::cemtemp.h');

  // output(choosen(b, 200), named('b'));
  // output(choosen(h, 200), named('h'));

  //constants
  set_owner_types := ['OWNER'];

  //layouts
  best_rec := {b.ultid, b.orgid, b.seleid, b.proxid, b.company_name.company_name, b.company_phone.company_phone, b.company_fein.company_fein, b.company_url.company_url, 
    b.company_address.company_prim_range, b.company_address.company_prim_name, b.company_address.company_sec_range, typeof(b.company_address.address_v_city_name) company_v_city_name,
    b.company_address.company_st, b.company_address.company_zip5, b.company_address.company_zip4,
    b.company_incorporation_date.company_incorporation_date, b.duns_number.duns_number,string8 company_sic_code,string6 company_naics_code,
    string20 segmentation,boolean sele_gold};
    
  owner_rec := {h.ultid, h.orgid, h.seleid, h.proxid, h.company_name, h.fname, h.mname, h.lname, h.name_suffix,h.contact_did, h.contact_type_derived,h.prim_range,h.predir,h.prim_name,h.addr_suffix,h.postdir,h.unit_desig,h.sec_range,h.v_city_name,h.st,h.zip,h.zip4,h.contact_ssn};
  //add sic & naics fields -- two blank fields for now

  //  Append segmentation
  //	Flatten the file
  j :=
  join(
    b,
    dedup(h, seleid, proxid, all),
    left.seleid = right.seleid and 
    (left.proxid = 0 or left.proxid = right.proxid), //allows join on both types of best records
    transform(
      best_rec,
      cp := left.company_phone[1].company_phone;    
      self.company_phone := cp;
      self.company_name   :=  left.company_name[1].company_name;
      self.company_fein   :=  left.company_fein[1].company_fein;
      self.company_url    :=  left.company_url[1].company_url;
      ca := left.company_address[1];
      self.company_prim_range := ca.company_prim_range; 
      self.company_prim_name := ca.company_prim_name;
      self.company_sec_range := ca.company_sec_range; 
      self.company_v_city_name := ca.address_v_city_name;  
      self.company_st := ca.company_st;
      self.company_zip5 := ca.company_zip5;    
      self.company_zip4 := ca.company_zip4;
      self.company_incorporation_date := left.company_incorporation_date[1].company_incorporation_date;
      self.duns_number := left.duns_number[1].duns_number;
      self.company_sic_code   := '';
      self.company_naics_code := '';
      self.segmentation := if(left.proxid = 0, BIPV2_PostProcess.constants.fDesc(right.sele_seg), BIPV2_PostProcess.constants.fDesc(right.prox_seg));
      self.sele_gold  := if(right.sele_gold = 'G' ,true,false);
      self := left;
    ),
    hash,
    keep(1)
  );

  // output(j, named('j'));
  write_best_flat := tools.macf_WriteFile(BIPV2_Build.filenames(pversion).best_flat.logical,j);
  
  // output(j,, '~thor_data400::BIP_Best_Flat', overwrite);

  //  OWNER records
  own := dedup(project(h(contact_type_derived in set_owner_types), owner_rec),record,all);
  // output(own, named('own'));
  // output(own,, '~thor_data400::BIP_Owners', overwrite);
  write_BIP_Owners := tools.macf_WriteFile(BIPV2_Build.filenames(pversion).BIP_Owners.logical,own);
  
  return sequential(
    parallel(
       write_best_flat
      ,write_BIP_Owners
    )
   ,BIPV2_Build.Promote(pversion,'Best_Flat|BIP_Owners').new2built
 );

end;