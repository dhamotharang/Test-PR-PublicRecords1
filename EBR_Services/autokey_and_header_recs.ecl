import business_header, autokeyb, doxie, dx_common, dx_EBR, EBR, AutoKeyI, AutoStandardI, doxie_cbrs;

export autokey_and_header_recs(boolean workhard = false, boolean nofail =false) :=
Module

  business_header.doxie_MAC_Field_Declare()
  shared t :=EBR.constants('').Str_autokeyName;
  shared ds := dataset([],EBR_services.layout_autokeyready);

  //***** Get BDIDS from autokeys. 'BC' is a Fake ID indicator.  When the autokeys were built
  //***** records with no bdid were given a fake BDID and 'BC' was passed in to indicate how
  //***** those BDIDS were assigned. 'BC' indicates that if a bdid is above 15 * 10^12 it is fake.
  //***** ['C','F'] are skip indicators. C prevents regular autokeys from being scanned (meanng
  //***** only business autokeys will be scanned) and F prevents the fein business autokey from
  //***** being scanned.  Workhard set to true allows key searches that only evalaute some of the
  //***** keyed fields, allowing looser matches but also placing more stress on the keys.
  //***** Workhard set to false places less strain on the keys.  Nofail prevents an error message
  //***** from being generated when a key index returns more than 10000 by using skip.

  tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
    export string autokey_keyname_root := t;
    export string typestr := 'BC';
    export set of string1 get_skip_set := ['C','F'];
    export boolean workHard := ^.workHard;
    export boolean noFail := ^.noFail;
    export boolean useAllLookups := false;
  end;
  shared ak_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;


  //***** Get the payload from the fake IDs, in this case, ak_ids with a fake bdid.  T provides the
  //***** the name of the key.  Ds is used in the fake ID index declaration to provide the key layout
  //***** (and since its providing only the layout and not the records for the key it is empty).
  //***** ds.zero and ds.bdid are the key fields used to make the Fake ID payload key but here they
  //***** are irrelevant, since the key has already been built (they need only be the right type
  //***** for the code to compile).

  autokeyb.mac_get_payload(ak_ids,t,ds,outpl_pre,ds.zero,ds.bdid, 'BC');
  outpl := dx_common.Incrementals.mac_Rollup(outpl_pre, dx_EBR.mod_delta_rid.key_autokey_payload_delta_rid);

  //***** RECORDs with Fake BDIDS
  shared byFakeID := project(outpl, transform(ebr.Layout_0010_Header_Base,self:=left));

  //*****Fake BDIDS from Autokeys
  shared FakeBDIDS :=project(byFakeID,transform(doxie.Layout_ref_bdid,self:=left));

  //***** BDIDs from Autokeys
  shared bdids_ak := project(ak_ids(isbdid), transform(doxie.Layout_ref_bdid, self.bdid := left.id));

  //*****BDIDS from header
  shared bdids_header :=business_header.doxie_get_bdids();

  SHARED UNSIGNED bdid := (UNSIGNED) AutoStandardI.InterfaceTranslator.bdid_val.val(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.InterfaceTranslator.bdid_val.params, OPT));
  SHARED BOOLEAN bypass := bdid <> 0;
  SHARED bdids_in := DATASET([{bdid}], doxie_cbrs.layout_references);

  bdids_for_key := IF(bypass, bdids_in, bdids_header + bdids_ak);
  pre_bybdid := dx_EBR.Get.Header_0010_By_Bdid(bdids_for_key, keep_number := 500);

  SHARED bybdid := PROJECT(pre_bybdid, ebr.Layout_0010_Header_Base);

  //***** Dedup the records by fields that are not going to be shown in accurint

  export recs := dedup(sort(IF(bypass, bybdid, bybdid + byFakeID),record, record_type, -process_date, -extract_date,-orig_extract_date_mdy, -orig_file_estab_date_mmyy,-process_date_last_seen,
                      -date_last_seen,-process_date_first_seen,-date_first_seen, geo_lat, geo_long)  ,record,except record_type,  process_date,extract_date,orig_extract_date_mdy, orig_file_estab_date_mmyy, process_date_last_seen,
                      date_last_seen,process_date_first_seen,date_first_seen, geo_lat, geo_long);

  layout_rec :=record
    unsigned6 bdid;
    boolean isDeepDive;
  end;

  export ids  := Dedup(sort(
                project(FakeBDIDS + bdids_ak,transform(layout_rec,self:=left,self.isDeepDive :=False))+
                project(bdids_header,transform(layout_rec,self:=left,self.isDeepDive :=TRUE)),bdid,(unsigned1)isDeepDive),
                bdid);

END;
