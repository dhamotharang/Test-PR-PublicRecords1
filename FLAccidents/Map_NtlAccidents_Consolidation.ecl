//In this attribute National Accidents data is consolidated for eCrash build.

IMPORT PromoteSupers, ut, Std;
	
  NtlAccidents := BaseFile_NtlAccidents_Alpharetta;

	Layout_NtlAccidents_Alpharetta.ConsolidationBase tNtlAccidents(NtlAccidents L) := TRANSFORM
		SELF.did := IF(L.did = 0, '000000000000', INTFORMAT(L.did, 12, 1));	
		SELF.accident_nbr := (STRING40)((UNSIGNED6)L.vehicle_incident_id + 10000000000);
		SELF.accident_date := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
		SELF.b_did := IF(L.bdid = 0, '', INTFORMAT(L.bdid, 12, 1)); 
		SELF.cname := STD.Str.ToUpperCase(L.business_name);
		SELF.addr_suffix := L.suffix;
		SELF.zip := L.zip5;
		SELF.record_type := CASE(STD.Str.ToUpperCase(TRIM(L.party_type, LEFT, RIGHT)),
														 'OWNER' => 'Property Owner',
														 'DRIVER' => 'Vehicle Driver',
														 'VEHICLE OWNER' => 'Property Owner',
                             'VEHICLE DRIVER' => 'Vehicle Driver',
                             '');
		SELF.driver_license_nbr := IF(REGEXFIND('[0-9]', L.pty_drivers_license), L.pty_drivers_license, '');
		SELF.dlnbr_st := L.pty_drivers_license_st;
		SELF.tag_nbr := IF(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1, L.tag, '');	
		SELF.tagnbr_st := IF(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1, L.tag_state, '');
		SELF.vin := L.vehvin;
		SELF.accident_location := MAP(L.cross_street <> '' AND L.cross_street <> 'N/A' => L.street + ' & ' + L.cross_street, L.street);
		SELF.accident_street := L.street;
		SELF.accident_cross_street := MAP(L.cross_street <> 'N/A' => L.cross_street, '');
		SELF.jurisdiction := TRIM(L.edit_agency_name, LEFT, RIGHT);
		SELF.jurisdiction_state := L.state_abbr;
		SELF.st := IF(l.st = '', SELF.jurisdiction_state, l.st);
		SELF.jurisdiction_nbr := L.agency_id;
		SELF.image_hash := L.pdf_image_hash;
		SELF.airbags_deploy := L.airbags_deploy;
		SELF.dob := L.dob;
		SELF.Policy_num := L.policy_nbr; 
		SELF.Policy_Effective_Date := ''; 
		SELF.Policy_Expiration_Date := '';
		SELF.Report_Has_Coversheet := IF(L.PDF_IMAGE_HASH <> '' OR L.tif_image_hash <> '', '1', '0');
		SELF.other_vin_indicator := '';
		SELF.vehicle_year := L.vehYear;	
		SELF.vehicle_make := L.vehMake;
		SELF.make_description := IF(L.make_description <> '', L.make_description, L.vehMake);
		SELF.model_description := IF(L.model_description <> '', L.model_description, L.vehModel);
		SELF.vehicle_incident_city := STD.Str.ToUpperCase(L.inc_city);
		SELF.vehicle_incident_st := STD.Str.ToUpperCase(L.state_abbr);
		SELF.point_of_impact := L.impact_location;
		SELF.towed := L.Car_Towed;
		SELF.Impact_Location := L.Impact_Location;
		SELF.carrier_name := L.legal_name;
		SELF.client_type_id := L.client_type_id;
		SELF.vehicle_unit_number := '';
		SELF.next_street := '';
		SELF.work_type_id := ''; 
		SELF.ssn := ''; 
		SELF.cru_order_id := L.order_id; 
		SELF.cru_sequence_nbr :=L.sequence_nbr; 
		SELF.date_vendor_last_reported := L.last_changed;
		SELF.creation_date := ''; 
		SELF.report_type_id := L.service_id;
		SELF.tif_image_hash := L.tif_image_hash; 
		SELF.acct_nbr := L.acct_nbr; 
		SELF.addl_report_number := L.REPORT_NBR;
		SELF.agency_id := L.agency_id;
		SELF := L;
		SELF := [];
	END;
	NtlAccidentsConsolidationBase := PROJECT(NtlAccidents, tNtlAccidents(LEFT));

EXPORT Map_NtlAccidents_Consolidation := NtlAccidentsConsolidationBase;