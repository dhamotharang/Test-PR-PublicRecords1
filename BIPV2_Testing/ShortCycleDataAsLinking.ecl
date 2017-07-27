EXPORT ShortCycleDataAsLinking := 
MODULE
import ut,Business_Header;

shared rec := Business_Header.Layout_Business_Linking.Linking_Interface;

export fullds :=
MODULE
	export bk := dataset(ut.foreign_prod + 'thor_data400::persist::bankruptcyv2::bankruptv2_as_business_linking', rec, thor);
	// thor_data400::persist::bbb::bbb_as_business_linking
	// thor_data400::persist::busdata::ska_as_business_linking
	// thor_data400::persist::busreg::busreg_as_business_linking
	export corp := dataset(ut.foreign_prod + 'thor_data400::persist::corp2::as_business_linking', rec, thor);
	// thor_data400::persist::credit_unions::as_business_linking
	export lnca := dataset(ut.foreign_prod + 'thor_data400::persist::dcav2::as_business_linking', rec, thor);
	// thor_data400::persist::dea::dea_as_business_linking
	export dbdmi := dataset(ut.foreign_prod + 'thor_data400::persist::dnb_dmi::as_business_linking', rec, thor);
	export ebr := dataset(ut.foreign_prod + 'thor_data400::persist::ebr::ebr_as_business_linking', rec, thor);
	// thor_data400::persist::faa::faa_aircraft_reg_as_business_linking', rec, thor);
	// thor_data400::persist::frandx::as_business_linking', rec, thor);
	// thor_data400::persist::gong_v2::as_business_linking', rec, thor);
	// thor_data400::persist::govdata::ca_sales_tax_as_business_linking', rec, thor);
	// thor_data400::persist::govdata::fdic_as_business_linking', rec, thor);
	// thor_data400::persist::govdata::irs_non_profit_as_business_linking', rec, thor);
	// thor_data400::persist::infousa::abius_company_as_business_linking', rec, thor);
	// thor_data400::persist::infousa::deadco_as_business_linking', rec, thor);
	// thor_data400::persist::irs5500::irs5500_as_business_linking', rec, thor);
	// thor_data400::persist::jigsaw::as_business_linking', rec, thor);
	export lj := dataset(ut.foreign_prod + 'thor_data400::persist::liensv2::liensv2_as_business_linking', rec, thor);
	export prop := dataset(ut.foreign_prod + 'thor_data400::persist::ln_propertyv2::ln_propertyv2_as_business_linking', rec, thor);
	// thor_data400::persist::oshair::oshair_inspection_as_business_linking', rec, thor);
	// thor_data400::persist::txbus::cleaned_txbus_as_business_linking', rec, thor);
	export ucc := dataset(ut.foreign_prod + 'thor_data400::persist::uccv2::as_business_linking', rec, thor);
	// thor_data400::persist::utilfile::as_business_linking', rec, thor);
	export mvr := dataset(ut.foreign_prod + 'thor_data400::persist::vehiclev2::as_business_linking', rec, thor);
	// thor_data400::persist::watercraft::watercraft_as_business_linking', rec, thor);
	// thor_data400::persist::workers_compensation::as_business_linking', rec, thor);
	// thor_data400::persist::yellowpages::as_business_linking', rec, thor);
	// thor_data400::persist::zoom::zoom_as_business_linking', rec, thor);

	/*
	thor_data400::out::frandx::as_business_linking_slim
	thor_data400::out::frandx::as_business_linking_slim_csv
	*/
END;//fullds

export my := 
MODULE
import BIPV2;
	// export bk := fullds.bk(vl_id in set(BIPV2_Testing.ShortCycleData.bk, tmsid)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.bk');
	export bk := project(fullds.bk, transform({fullds.bk}, self.vl_id := left.vl_id[1..14], self := left))
		(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.bk, tmsid)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.bk');
	export corp := fullds.corp(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.corp, ck)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.corp');
	// export lnca := fullds.lnca(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.lnca, ck)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.corp');
	//  root and sub?
	export dbdmi := fullds.dbdmi(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.dbdmi, duns_number)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.dbdmi');
	export ebr := fullds.ebr(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.ebr, file_number)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.ebr');
	export lj := fullds.lj(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.lj, tmsid2)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.lj');  
	export prop := project(fullds.prop, transform({fullds.prop}, self.vl_id := left.vl_id[4..], self := left))
		(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.prop, fid)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.prop');
	export ucc := project(fullds.ucc, transform({fullds.ucc}, self.vl_id := ut.Word(left.vl_id, 1, ' '), self := left))
		(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.ucc, tmsid)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.ucc');
	export mvr := fullds.mvr(vl_id <> '' and vl_id in set(BIPV2_Testing.ShortCycleData.mvr, vk)) : persist('~thor_data400::BIPV2_Testing.ShortCycleDataAsLinking.my.mvr');
	
	
	shared mac(ds) :=
	functionmacro
	
		return 
		project(
			ds,
			transform(
				{ds, string10 src2, BIPV2.IDlayouts.l_xlink_ids},
				self.src2 := #text(ds),
				self := left
			)
		);
	endmacro;

	export _all :=
		mac(bk)
		+mac(corp)
		// +mac(lnca)
		+mac(dbdmi)
		+mac(ebr)
		+mac(lj)
		+mac(prop)
		+mac(ucc)
		+mac(mvr)
		;

END;//my
/*
1) join answer key to AL by VL ID, add a secondary source type and persist - use existing macro?
2) in separate area of shortcycle module, add these together and pump thru macro
3) split them back up by src2 and measure
*/

END;