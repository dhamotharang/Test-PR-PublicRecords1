//-----------------------------------------------------------------------------
// Procedure that takes the two Acquireweb input files, joins them together and
// determines the AID and DID information

IMPORT ut,address,DID_Add,header_slimsort,AID,std;

EXPORT proc_build_base(STRING version) := FUNCTION
  ind_file_in   :=  Acquireweb_Email.files.file_acquireweb_email_ind_dedup;
  email_file_in :=  DISTRIBUTE(Acquireweb_Email.files.file_Acquireweb_Email_Emails,HASH32(AWID_Email));

  // Take the individual file and add fields for the cleaned name and the fields
  // to pass into the AID macro
  layout_ind_clean:=RECORD
    RECORDOF(ind_file_in);
    STRING5 clean_title;
    STRING20 clean_fname;
    STRING20 clean_mname;
    STRING20 clean_lname;
    STRING5 clean_name_suffix;
    STRING3 clean_name_score;
    STRING addr1;
    STRING addr2;
    UNSIGNED8 RawAID:=0;
  END;

  layout_ind_clean t_clean(ind_file_in L):=TRANSFORM
		SELF.clean_title:='';
    SELF.clean_fname        := TRIM(L.FIRSTNAME,RIGHT,LEFT);
    SELF.clean_mname        := '';
    SELF.clean_lname        := TRIM(L.LASTNAME,RIGHT,LEFT);
    SELF.clean_name_suffix  := '';
    SELF.clean_name_score   := '097';
    SELF.addr1:=StringLib.StringCleanSpaces(TRIM(TRIM(stringlib.stringtouppercase(L.address1),LEFT,RIGHT)+' '+TRIM(stringlib.stringtouppercase(L.address2),LEFT,RIGHT),LEFT,RIGHT));
    SELF.addr2:=StringLib.StringCleanSpaces(Address.Addr2FromComponents(stringlib.stringtouppercase(L.city),stringlib.stringtouppercase(L.state),stringlib.stringtouppercase(L.zip[..5])));
    SELF:=L;
  end;
  ind_name_clean:=PROJECT(ind_file_in,t_clean(LEFT));

  // Call the AID macro to get the cleaned address information
  UNSIGNED4 lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
  AID.MacAppendFromRaw_2Line(ind_name_clean, addr1, addr2, RawAID, ind_aid, lFlags);

  // Get standardized Name and Address fields
  Acquireweb_Email.layouts.layout_Acquireweb_Base tProjectClean(ind_aid L):=TRANSFORM
    SELF.awid                       := L.awid_ind;
    SELF.DID                        := 0;
    SELF.DID_Score                  := 0;
    SELF.date_vendor_first_reported := version;
    SELF.date_vendor_last_reported  := version;
    SELF.date_first_seen            := if(STD.Str.Contains(L.IndExportDate,'-',true),std.str.filter(L.IndExportDate,'0123456789'),ut.date_slashed_MMDDYYYY_to_YYYYMMDD(L.IndExportDate));
    SELF.date_last_seen             := SELF.date_first_seen;
		SELF.current_rec								:= true;
    SELF.clean_prim_range           := L.aidwork_acecache.prim_range;
    SELF.clean_predir               := L.aidwork_acecache.predir;
    SELF.clean_prim_name            := L.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix          := L.aidwork_acecache.addr_suffix;
    SELF.clean_postdir              := L.aidwork_acecache.postdir;
    SELF.clean_unit_desig           := L.aidwork_acecache.unit_desig;
    SELF.clean_sec_range            := L.aidwork_acecache.sec_range;
    SELF.clean_p_city_name          := L.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name          := L.aidwork_acecache.v_city_name;
    SELF.clean_st                   := L.aidwork_acecache.st;
    SELF.clean_zip                  := L.aidwork_acecache.zip5;
    SELF.clean_zip4                 := L.aidwork_acecache.zip4;
    SELF.clean_cart                 := L.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz           := L.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot                  := L.aidwork_acecache.lot;
    SELF.clean_lot_order            := L.aidwork_acecache.lot_order;
    SELF.clean_dbpc                 := L.aidwork_acecache.dbpc;
    SELF.clean_chk_digit            := L.aidwork_acecache.chk_digit;
    SELF.clean_rec_type             := L.aidwork_acecache.rec_type;
    SELF.clean_county               := L.aidwork_acecache.county;
    SELF.clean_geo_lat              := L.aidwork_acecache.geo_lat;
    SELF.clean_geo_long             := L.aidwork_acecache.geo_long;
    SELF.clean_msa                  := L.aidwork_acecache.msa;
    SELF.clean_geo_blk              := L.aidwork_acecache.geo_blk;
    SELF.clean_geo_match            := L.aidwork_acecache.geo_match;
    SELF.clean_err_stat             := L.aidwork_acecache.err_stat;
    SELF.aid                        := L.aidwork_rawaid;
    SELF                            := L;
    SELF                            := [];
  END;
  ind_cleaned:=PROJECT(ind_aid,tProjectClean(LEFT));

  // Find DIDs with a score of 75 or better
  matchset:=['A','D','P','Z'];  
  DID_Add.MAC_Match_Flex(ind_cleaned,matchset,foo,DOB,clean_fname,
    clean_mname,clean_lname,clean_name_suffix,clean_prim_range,
    clean_prim_name,clean_sec_range,clean_zip,
    clean_st,phone,DID,Acquireweb_Email.layouts.layout_Acquireweb_Base,true,DID_Score,75,ind_with_did);
  ind_with_did_2:=DISTRIBUTE(ind_with_did,HASH32(awid));

  // Join the cleaned IND file contianing AID and DID information to the e-mail file
  Acquireweb_Email.layouts.layout_Acquireweb_Base jointhem(ind_with_did_2 L,email_file_in R):=TRANSFORM
    SELF.emailid:=R.emailid;
    SELF.email:=R.email;
    SELF.activecode:=map(trim(R.activecode,left,right)='Y'=>'A',
												 trim(R.activecode,left,right)='N'=>'I',
												 trim(R.activecode,left,right)='A'=>'A',
												 trim(R.activecode,left,right)='I'=>'I','');
    SELF:=L;
    SELF:=[];
  END;
  new_acquireweb_data:=DISTRIBUTE(JOIN(ind_with_did_2,email_file_in,LEFT.awid=RIGHT.AWID_Email,jointhem(LEFT,RIGHT),INNER,LOCAL),HASH32(email));

  // merge the new data with the existing basefile.  Then roll it up on the
  // email and name fields, keeping the pertinent first and last date information
	prev_base := project(Acquireweb_Email.files.file_Acquireweb_Base, transform(layouts.layout_Acquireweb_Base, SELF.current_rec := false, SELF := LEFT));
  mergeddata:=SORT(new_acquireweb_data+prev_base,email,clean_fname,clean_mname,clean_lname);
  Acquireweb_Email.layouts.layout_Acquireweb_Base rollitup(Acquireweb_Email.layouts.layout_Acquireweb_Base L,Acquireweb_Email.layouts.layout_Acquireweb_Base R):=TRANSFORM
    SELF.date_first_seen:=IF(L.date_first_seen<R.date_first_seen,L.date_first_seen,R.date_first_seen);
    SELF.date_last_seen:=IF(L.date_last_seen>R.date_last_seen,L.date_last_seen,R.date_last_seen);
    SELF.date_vendor_first_reported:=IF(L.date_vendor_first_reported<R.date_vendor_first_reported,L.date_vendor_first_reported,R.date_vendor_first_reported);
    SELF.date_vendor_last_reported:=IF(L.date_vendor_last_reported>R.date_vendor_last_reported,L.date_vendor_last_reported,R.date_vendor_last_reported);
    SELF:=IF(L.date_vendor_last_reported>R.date_vendor_last_reported,L,R);
  END;
  BOOLEAN basefileexists:=nothor(fileservices.GetSuperFileSubCount('~thor_data200::base::acquireweb'))>0;
  newbasefile:=DISTRIBUTE(IF(basefileexists,ROLLUP(mergeddata,rollitup(LEFT,RIGHT),email,clean_fname,clean_mname,clean_lname,LOCAL),new_acquireweb_data),HASH32(awid));

  RETURN newbasefile(trim(AWID,left,right)<>'AWID');
END;
