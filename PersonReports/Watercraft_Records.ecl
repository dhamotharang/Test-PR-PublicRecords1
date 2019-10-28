import $, iesp, WatercraftV2_Services, doxie, Census_data, fcra, FFD;

iesp.watercraft.t_WaterCraftAddress FormatWAddresses (string City, string State, string Province, string Country) :=
  ROW ({City, State, Province, Country}, iesp.watercraft.t_WaterCraftAddress);

export Watercraft_Records(
  dataset (doxie.layout_references) dids,
  $.IParam.watercrafts in_params = module ($.IParam.watercrafts) end,
  boolean IsFCRA = false,
	boolean IsReport = false,
	dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
	
) := MODULE

raw_recs := WatercraftV2_Services.WatercraftV2_raw.Report_View.by_did (
                     dids, in_params.ssn_mask, IsReport, isFCRA, flagfile, in_params.non_subject_suppression,
										 in_params.include_NonRegulated_WatercraftSources, slim_pc_recs, in_params.FFDOptionsMask);
//returns WatercraftV2_Services.Layouts.report_out

shared raw_limited := sort (raw_recs, -date_last_seen, -Registration_Date);


// ==============================================================================
// ============================ ESP-compliant output ============================
// ==============================================================================
MAC_COMMON_ESP () := MACRO
  // t_WaterCraftDescriptionEx Description {xpath('Description')};
  Self.Description.Breadth    := L.Registered_Breadth;
  Self.Description.Depth      := L.Registered_Depth;
  Self.Description.GrossTons  := L.Registered_Gross_Tons;
  Self.Description.NetTons    := L.Registered_Net_Tons;
  Self.Description.Length     := (integer) (if (L.registered_length <> '', L.registered_length, L.watercraft_length));
  Self.Description.Width      := (integer) L.watercraft_width;
  Self.Description.Weight     := (integer) L.watercraft_weight;
  Self.Description.Make       := L.Watercraft_Make_Description;
  Self.Description.Model      := L.watercraft_model_description;
  Self.Description.YearMake   := (integer3) L.Model_Year;
  Self.Description.HullType   := L.Hull_type_Description;
  Self.Description.Use        := L.use_description;
  Self.Description.MajorColor := L.watercraft_color_1_description;
  Self.Description.MinorColor := L.watercraft_color_2_description; //?
  Self.Description.PropulsionType := L.Propulsion_Description;
  Self.Description.FuelType   := L.fuel_description;
  // t_WaterCraftRegistration Registration {xpath('Registration')};
  Self.Registration.Status         := L.Registration_Status_Description;
  Self.Registration.Number         := L.registration_number;
  Self.Registration.IssueDate      := iesp.ECL2ESP.toDate ((integer4) L.Registration_Date);
  Self.Registration.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.Registration_Expiration_Date);
  // t_WaterCraftTitle Title {xpath('Title')};
  Self.Title.State     := L.title_state;
  Self.Title.Status    := L.Title_Status_Description;
  Self.Title.Number    := L.Title_Number;
  Self.Title._Type      := L.Title_Type_Description;
  Self.Title.IssueDate := iesp.ECL2ESP.toDate ((integer4) L.Title_Issue_Date);
  // t_WaterCraftPurchase Purchase {xpath('Purchase')};
  Self.Purchase.Date           := iesp.ECL2ESP.toDate ((integer4) L.purchase_date);
  Self.Purchase.Price          := (integer) L.purchase_price;
  Self.Purchase.Dealer         := L.dealer;
  Self.Purchase.StatePurchased := L.state_purchased;
  //t_WaterCraftManufacture Manufacture {xpath('Manufacture')};
  Self.Manufacture.ShipYard             := L.ship_yard;
  Self.Manufacture.YearBuilt            := (integer) L.vessel_build_year;
  Self.Manufacture.HailingPort          := L.hailing_port;
  Self.Manufacture.HailingPortAddress   := FormatWAddresses (L.Hailing_Port, L.Hailing_Port_State, 
                                                             L.Hailing_Port_Province, '');
  Self.Manufacture.HullBuildAddress     := FormatWAddresses (L.Vessel_Hull_Build_city, L.Vessel_Hull_Build_state,
                                                             L.Vessel_Hull_Build_Province, L.Vessel_Hull_Build_Country);
  Self.Manufacture.CompleteBuildAddress := FormatWAddresses (L.vessel_complete_build_city, L.vessel_complete_build_state,
                                                             L.vessel_complete_build_province, l.vessel_complete_build_country);
  // uncategorised
  Self.StateOfOrigin := l.State_Origin;
  Self.StateOfOriginName := l.state_origin_full;
  Self.HullNumber := l.Hull_Number;
  Self.VesselName := l.Name_of_Vessel;
  Self.RecordType := l.Rec_Type;
  Self.VesselNumber := l.vessel_id;
  Self.DateLastSeen := iesp.ECL2ESP.toDate ((integer4) L.Date_Last_Seen);
ENDMACRO;

iesp.watercraft_fcra.t_FcraWaterCraftOwner GetOwners (WatercraftV2_services.Layouts.owner_report_rec L) := transform
  Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, L.orig_name);
	CountyName := if(L.st!='' and L.county!='',Census_data.Key_Fips2County(keyed(L.st=state_code and L.county=county_fips))[1].county_name,'');
  Self.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, 
                                           L.sec_range, L.v_city_name, L.st, L.zip5, L.zip4, CountyName, '');
  Self.SSN := L.ssn;
  Self.DOB := iesp.ECL2ESP.toDate ((integer) l.dob);
	Self.CompanyName := L.company_name;
  Self.UniqueId := L.did;
	Self.StatementIDs := L.StatementIDs;
	Self.isDisputed := L.isDisputed;
end;

// MOXIE SEARCH:


iesp.watercraft.t_WaterCraftEngine GetEngines (WatercraftV2_services.Layouts.engine_rec L) := transform	
  Self.horsepower := (integer) l.watercraft_hp;
  Self.Make       := L.engine_make;
  Self.Model      := L.engine_model;
end;

//  generally, WatercraftV2_services.layouts.lien_rec = doxie_crs.layout_watercraft_lien
iesp.watercraft.t_WaterCraftLienHolder GetLiens (WatercraftV2_services.Layouts.lien_rec l) := transform
  Self.Name := iesp.ECL2ESP.SetName ('', '', '', '', '', L.lien_name);
  Self.Address := iesp.ECL2ESP.SetAddress ('', '', '', '', '', '', '', l.lien_city, l.lien_state, l.lien_zip,
                                           '', '', '', L.lien_address_1, L.lien_address_2);
end;

iesp.watercraft_fcra.t_FcraWaterCraftReportRecord FormatReport (WatercraftV2_Services.Layouts.report_out L) := transform
	//Self.WatercraftKey := L.watercraft_key;
	Self.NonDMVSource := L.NonDMVSource;
  Self.owners      := choosen (project (L.owners, GetOwners (Left)), iesp.Constants.WATERCRAFTS.MaxOwners);
  eng_ddp   := dedup (sort (L.engines, watercraft_hp, engine_make, engine_model), watercraft_hp, engine_make, engine_model);
  //TODO: this sort doesn't make sense as it is: "record" should be either removed or moved to the end.
  liens_ddp := dedup (sort (L.lienholders, record, -lien_date), except lien_date);
  Self.engines     := choosen (project (eng_ddp, GetEngines(Left)), iesp.Constants.WATERCRAFTS.MaxEngines);
  self.lienholders := choosen (project (liens_ddp,GetLiens (Left)), iesp.Constants.WATERCRAFTS.MaxLienholders);
	Self.StatementIDs := L.StatementIDs;
	Self.isDisputed := L.isDisputed;
  MAC_COMMON_ESP ()
end;

//did = 38300
/* FFD debug
	output(raw_limited,named('raw_limited_watercraft')); 
*/
//TODO: change name to "watercrafts"
// Generally, should be
   // wtcr := doxie/watercraft_records; and then see ws_distrix/watercraftrpt.cpp
EXPORT wtr_recs := project (raw_limited, FormatReport (Left));

EXPORT watercrafts_v2 := project(raw_limited, WatercraftV2_Services.Transforms.FormatReport2Record(Left));

// see quickxslt\rx_watercraftrpt2.cpp (createWaterCraftHandle)
END;

