import tools;
export KeyPrep_Source_ID(
	dataset(Layout_Linking.Linked) linking_master,
	dataset(Layout_Industry.Linked) industry_master,
	dataset(Layout_Abstract.Linked) abstract_master,
	dataset(Layout_UCC.Main.Linked) ucc_master,
	dataset(Layout_Liens.Main.Linked) liens_master,
	dataset(Layout_Aircraft.Main.Linked) aircraft_master,
	dataset(Layout_Watercraft.Main.Linked) watercraft_master,
	dataset(Layout_Incorporation.Linked) incorporation_master,
	dataset(Layout_Mark.Linked) mark_master,
	dataset(Layout_Bankruptcy.Main.Linked) bankruptcy_master,
	dataset(Layout_Finance.Linked) finance_master,
	dataset(Layout_Property.Main.Linked) property_master,
	string version,
	boolean pUseOtherEnvironment = false) := function

	name_items := project(linking_master(company_name != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.NAME,
			self.item_hash := hash32(left.company_name),
			self := left));

	address_items := project(linking_master(zip != '' and prim_name != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.ADDRESS,
			self.item_hash := hash32(left.zip,left.prim_name,left.prim_range),
			self := left));

	phone_items := project(linking_master(phone != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.PHONE,
			self.item_hash := hash32(left.phone),
			self := left));

	url_items := project(linking_master(url != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.URL,
			self.item_hash := hash32(left.url),
			self := left));

	sic_items := project(Industry_Master(siccode != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.SIC,
			self.item_hash := hash32(left.siccode),
			self := left));

	naic_items := project(Industry_Master(naics != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.NAIC,
			self.item_hash := hash32(left.naics),
			self := left));

	industry_desc_items := project(Industry_Master(industry_description != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.INDUSTRYDESC,
			self.item_hash := hash32(left.industry_description),
			self := left));

	business_desc_items := project(Abstract_Master(business_description != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.BUSINESSDESC,
			self.item_hash := hash32(left.business_description),
			self := left));

	ucc_items := project(UCC_Master(filing_jurisdiction != '' and orig_filing_number != ''),
		transform(KeyLayouts.Source,
			self.item_type := map(
				left.source_party[1] = 'D' => map(
					left.status_type in ['LAPSED','L'] =>
						Constants.ItemTypes.UCC_DEBTOR_TERMINATED,
					/* otherwise => */
						Constants.ItemTypes.UCC_DEBTOR_ACTIVE),
				left.source_party[1] in ['S','A'] => map(
					left.status_type in ['LAPSED','L'] =>
						Constants.ItemTypes.UCC_SECURED_TERMINATED,
					/* otherwise => */
						Constants.ItemTypes.UCC_SECURED_ACTIVE),
				skip),
			self.item_hash := hash32(left.filing_jurisdiction,left.orig_filing_number),
			self := left));

	lien_items := project(Liens_Master(filing_jurisdiction != '' and orig_filing_number != ''),
		transform(KeyLayouts.Source,
			self.item_type := map(
				left.release_date != '' or
				left.satisfaction_type in ['FULL','YES', 'VACATE'] or
				left.judg_satisfied_date != '' or
				left.judg_vacated_date != '' or
				left.lapse_date != '' or
				left.expiration_date != '' or
				left.filing_type_desc in ['TERMINATION'] =>
					Constants.ItemTypes.LIEN_TERMINATED,
				/* otherwise */
					Constants.ItemTypes.LIEN_ACTIVE),
			self.item_hash := hash32(left.filing_jurisdiction,left.orig_filing_number),
			self := left));

	aircraft_items := project(Aircraft_Master(serial_number != '' and registration_date != ''),
		transform(KeyLayouts.Source,
			self.item_type := map(
				left.current_prior_flag = 'A' =>
					Constants.ItemTypes.AIRCRAFT_CURRENT,
				/* otherwise */
					Constants.ItemTypes.AIRCRAFT_PRIOR),
			self.item_hash := hash32(left.serial_number,left.registration_date),
			self := left));

	watercraft_items := project(Watercraft_Master(hull_number != '' and registration_date != ''),
		transform(KeyLayouts.Source,
			self.item_type := map(
				left.history_flag = '' =>
					Constants.ItemTypes.WATERCRAFT_CURRENT,
				/* otherwise */
					Constants.ItemTypes.WATERCRAFT_PRIOR),
			self.item_hash := hash32(left.hull_number,left.registration_date),
			self := left));

	corpinfo_items := project(Incorporation_Master(corp_state_origin != '' and corp_orig_sos_charter_nbr != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.CORPINFO,
			self.item_hash := hash32(left.corp_state_origin,left.corp_orig_sos_charter_nbr),
			self := left));

	mark_items := project(Mark_Master(mark_description != ''),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.MARK,
			self.item_hash := hash32(left.mark_description),
			self := left));

	bankruptcy_items := project(Bankruptcy_Master(court_code != '' and orig_case_number != ''),
		transform(KeyLayouts.Source,
			self.item_type := map(
				left.source_party[1] = 'D' =>
					Constants.ItemTypes.BANKRUPTCY_DEBTOR,
				left.source_party[1] = 'A' =>
					Constants.ItemTypes.BANKRUPTCY_ATTORNEY,
				/* otherwise */
				skip),
			self.item_hash := hash32(left.court_code,left.orig_case_number),
			self := left));

	// license_items := project(License_Master,
		// transform(KeyLayouts.Source,
		// self.IsCurrent := if (l.expiration_date <> '', 
												                       // (unsigned4) l.expiration_date >= 
																									// (unsigned4) ut.DateFrom_DaysSince1900(ut.DaysSince1900(CurDate[1..4], 
																				                           // CurDate[5..6], CurDate[7..8]) - (integer)'365'),
																							   // false);
			// self.item_type := map(
				// left.expiration_date != '' and
				// (unsigned4)left.expiration_date >= (unsigned4)ut.DateFrom_DaysSince1900(ut.DaysSince1900(CurDate[1..4]
				// Constants.ItemTypes.LICENSE,
			// self.item_hash := hash32(left.jurisdiction,left.license_number),
			// self := left));

	// contact_items := project(Contact_Master(did != 0 or (name_last != '' and name_first != '')),
		// transform(KeyLayouts.Source,
			// self.item_type := Constants.ItemTypes.CONTACT,
			// self.item_hash := hash32(left.did,if(left.did = 0,left.name_last,''),if(left.did = 0,left.name_first,'')),
			// self := left));

	// executive_items := project(Executives_Master,
		// transform(KeyLayouts.Source,
			// self.item_type := Constants.ItemTypes.EXECUTIVE,
			// self.item_hash := hash32(left.did),
			// self := left));

	// associated_business_items := project(Relationship_Master,
		// transform(KeyLayouts.Source,
			// self.item_type := Constants.ItemTypes.ASSOCIATEDBUSINESS,
			// self.item_hash := hash32(left.other_bid),
			// self := left));

	// parent_business_items := project(ParentBusinesses_Master,
		// transform(KeyLayouts.Source,
			// self.item_type := Constants.ItemTypes.PARENTBUSINESS,
			// self.item_hash := hash32(left.other_bid),
			// self := left));

	finance_items := project(Finance_Master(fiscalyearending != 0 and sales != 0),
		transform(KeyLayouts.Source,
			self.item_type := Constants.ItemTypes.FINANCE,
			self.item_hash := hash32(left.fiscalyearending,left.sales),
			self := left));

	property_items := project(Property_Master(source_docid != ''),
		transform(KeyLayouts.Source,
			self.item_type := map(
				left.current_flag =>
					Constants.ItemTypes.PROPERTY_CURRENT,
				/* otherwise */
					Constants.ItemTypes.PROPERTY_PRIOR),
			self.item_hash := hash32(left.source_docid),
			self := left));
			
  // foreclosurenod_items := project(Property_Master_Foreclosure(source_docid != ''),
		// transform(KeyLayouts.Source,
			// self.item_type := Constants.ItemTypes.foreclosurenod,
			// self.item_hash := hash32(left.source_docid),
			// self := left));			


	all_items :=
		name_items +
		address_items +
		phone_items +
		url_items +
		sic_items +
		naic_items +
		industry_desc_items +
		business_desc_items +
		ucc_items +
		lien_items +
		aircraft_items +
		watercraft_items +
		corpinfo_items +
		mark_items +
		bankruptcy_items +
		// license_items +
		// contact_items +
		// executive_items +
		// associated_business_items +
		// parent_business_items +
		finance_items +
		property_items;
		// foreclosurenod_items;
		
	deduped_items := dedup(all_items,record,all);

	tools.mac_FilesIndex('deduped_items,{bid,item_type,item_hash,source},{deduped_items}',keynames(version,pUseOtherEnvironment).Source,idx);

	return idx;

end;
