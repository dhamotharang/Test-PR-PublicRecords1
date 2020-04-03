IMPORT Business_Header, doxie, iesp, census_data, dx_Gong, AddrBest, Risk_Indicators, Royalty, BIPV2;

export Layouts := MODULE
export in_address:=record
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  // string4 zip4:='';
  // string60	county:='';
end;
export slim_address:=record
  unsigned6 did;
  unsigned6 bdid;
  in_address;
  string4 zip4;
end;
export slim_address_phone:=record
  slim_address;
  string10 phone10;
  string10 ListingPhone10;
  string120 ListingName;
  string1 PubNonpub;
  string1 listing_type;
  string4 TimeZone;
  string4 ListingTimeZone;
end;
 EXPORT layout_Business := record
  unsigned6 group_id;
  Business_Header.Layout_BH_Best;
end;

EXPORT layout_Business_out :=record
  unsigned6 group_id;
  unsigned6 bdid := 0;
  BIPV2.IDlayouts.l_header_ids;
  unsigned4 dt_last_seen := 0;
  qstring120 company_name := '';
  qstring10 prim_range := '';
  string2 predir := '';
  qstring28 prim_name := '';
  qstring4 addr_suffix := '';
  string2 postdir := '';
  qstring5 unit_desig := '';
  qstring8 sec_range := '';
  qstring25 city := '';
  string2 state := '';
  string5 zip := '';
  string4 zip4 := '';
  unsigned6 phone := 0;
  unsigned4 fein := 0;        // Federal Tax ID
  unsigned1 best_flags := 0;
  string2 source := '';	   // source type (non-blank only if DPPA_State is non-blank)
  string2 DPPA_State := ''; // If nonblank, indicates state code for a DPPA restricted record
end;

export resident_best_layout := record
  doxie.layout_best;
  unsigned3 addr_dt_first_seen := 0;
end;

export resident_layout :=record
  boolean is_best; // to tell "best" records from header ones, when in the same dataset
  unsigned6 did := 0;
  qstring10 phone := '';
  string4 timezone :='';
  qstring9 ssn := '';
  qstring9 ssn_unmasked := '';
  qstring5 title := '';
  qstring20 fname := '';
  qstring20 mname := '';
  qstring20 lname := '';
  qstring5 name_suffix := '';
  qstring10 prim_range := '';
  string2 predir := '';
  qstring28 prim_name := '';
  qstring4 suffix := '';
  string2 postdir := '';
  qstring10 unit_desig := '';
  qstring8 sec_range := '';
  qstring25 city_name := '';
  string2 st := '';
  qstring5 zip := '';
  qstring4 zip4 := '';
  unsigned3 addr_dt_last_seen := 0;
  unsigned3 addr_dt_first_seen := 0;
  qstring17 Prpty_deed_id := '';
  qstring22 Vehicle_vehnum := '';
  qstring22 Bkrupt_CrtCode_CaseNo := '';
  qstring15 DL_number := '';
  integer4 run_date := 0;
  integer4 total_records := 0;
  string1 valid_ssn := '';
  iesp.share.t_Identity Identity;
end;

export residents_final_out:=record
  resident_layout;
  string addr := '';
  qstring3 height := '';
  qstring3 weight := '';
  qstring3 hair_color := '';
  qstring3 eye_color := '';
  dataset(iesp.share.t_identity) AKAs {xpath('AKAs/Identity'), MAXCOUNT(iesp.constants.AR.MaxAKAs)};
  dataset(iesp.addressreport.t_AddrReportRealTimePhone) CurrentPhone {xpath('CurrentPhone'), MAXCOUNT(iesp.Constants.AR.MaxPhones)};
  dataset(Risk_Indicators.Layout_Desc) hri_address {MAXCOUNT(AddressReport_Services.Constants.MaxCountHRI)} := dataset([], Risk_Indicators.Layout_Desc);
end;

export residents_final_out_w_royalties := record
  dataset(residents_final_out) residents;
  dataset(Royalty.Layouts.Royalty) Royalties := dataset([], Royalty.Layouts.Royalty);
end;

export rel_asst_layout := record
	doxie.layout_relative_dids;
	doxie.layout_best;
end;

export census_layout :=record
  recordof(census_data.Key_Smart_Jury);
end;

export possible_owner_layout := record
  doxie.layout_best;
  unsigned6 bdid;
  qstring120 company_name := '';
end;

k := dx_Gong.layouts.i_history_address;

Export phone_out_layout := record
  doxie.layout_AppendGongByAddr_input;
  k.business_flag;
  k.name_first;
  k.name_last;
  k.publish_code;
  k.omit_phone;
end;

EXPORT BestAddressWithResponseCode_layout := RECORD
  STRING2 ResponseCode;
  AddrBest.Layout_BestAddr.best_Out_common;
END;

EXPORT AddressSummaryHeaderSlim_layout := record
  string20 fname := '';
  string20 mname := '';
  string20 lname := '';
  string5 name_suffix := '';
  unsigned3 dt_first_seen := 0;
  unsigned3 dt_last_seen := 0;
  unsigned3 dt_vendor_last_reported := 0;
  string10 prim_range := '';
  string2 predir := '';
  string28 prim_name := '';
  string4 suffix := '';
  string2 postdir := '';
  string10 unit_desig := '';
  string8 sec_range := '';
  string25 city_name := '';
  string2 st := '';
  string5 zip := '';
end;

EXPORT AddressSummaryVerifiedName_layout := record
  AddressSummaryHeaderSlim_layout.fname;
  AddressSummaryHeaderSlim_layout.mname;
  AddressSummaryHeaderSlim_layout.lname;
  AddressSummaryHeaderSlim_layout.name_suffix;
  boolean IsVerified := TRUE;
end;

export iesp_out_plus_royalties_layout := record
  iesp.addressreport.t_AddressReportResponse ReportResponse;
  dataset(Royalty.Layouts.Royalty) Royalties;
end;


export iesp_addrpt_possveh_plusdid_layout := record
  iesp.addressreport.t_AddrReportPossibleVehicles;
  unsigned6 registrant_did;
end;

export iesp_addrpt_posshf_plusdid_layout := record
  iesp.addressreport.t_AddrReportPossibleHuntingFishing;
  unsigned6 licensee_did;
end;

END;
