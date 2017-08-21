export fnAddPersistentRecordID_Main(dataset(recordof(uccv2.File_UCC_Main_Base)) in_ds) := function

//W20130605-074935
//the workunit above shows the analysis of the fields needs to create a unique record_id
//a few other comments:
//1)
//some non-displayable fields do make some records unique, those are listed below
//process_date-date_vendor_changed-date_vendor_removed
//i did not feel it necessary to assign another unique ID just because the process_date was different
//3)
//Result5 shows that when you exclude those fields listed above and dedup on the entire record, there are no IDs associated with more than 1 record

 recordof(in_ds) xform1(in_ds le) := transform
  self.persistent_record_id := hash64(
			 le.tmsid	
			+le.rmsid	
			//+le.process_date;	
			//+le.static_value
			//+le.date_vendor_removed
			//+le.date_vendor_changed
			//+le.Filing_Jurisdiction//*
			+le.orig_filing_number
			+le.orig_filing_type
			+le.orig_filing_date
			+le.orig_filing_time
			+le.filing_number
			//+le.filing_number_indc//*
			+le.filing_type
			+le.filing_date
			+le.filing_time
			+le.filing_status//not needed to establish unique-ness but i still decided to add it to the hash - refer to W20130604-155735
			+le.Status_type
			+le.page
			+le.expiration_date
			+le.contract_type
			//+le.vendor_entry_date//*
			//+le.vendor_upd_date//*
			+le.statements_filed
			//+le.continuious_expiration//*
			+le.microfilm_number
			+le.amount//not needed to establish unique-ness but i still decided to add it to the hash - refer to W20130604-155735
			//+le.irs_serial_number//*
			//+le.effective_date//*
			//+le.Signer_Name//*
			//+le.title//*
			//+le.filing_agency//*
			//+le.address//*
			//+le.city//*
			//+le.state//*
			//+le.county//*
			//+le.zip//*
			+le.duns_number//not needed to establish unique-ness but i still decided to add it to the hash - refer to W20130604-155735
			//+le.cmnt_effective_date//*
			//+le.description//*
	    +le.collateral_desc
			+le.prim_machine
			//+le.sec_machine//*
			+le.manufacturer_code
			+le.manufacturer_name
			+le.model
			+le.model_year//not needed to establish unique-ness but i still decided to add it to the hash - refer to W20130604-155735
			+le.model_desc
			+le.collateral_count
			+le.manufactured_year//not needed to establish unique-ness but i still decided to add it to the hash - refer to W20130604-155735
			//+le.new_used//*
			+le.serial_number
			+le.Property_desc
			+le.borough
			+le.block
			+le.lot
			+le.collateral_address
			+le.air_rights_indc
			//+le.subterranean_rights_indc//*
			//+le.easment_indc//*
			);									
  self := le;
 end;

 p1 := project(in_ds(persistent_record_id=0),xform1(left));
 
 concat := in_ds(persistent_record_id>0) + p1;

 return concat;

end;