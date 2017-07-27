
IMPORT doxie, Autokey_batch, BatchServices, Address;

ds_sample :=
	DATASET(
		// [
		// acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did, bdid
		[{'2','','','','','','hytex integrated berhad','','','','','','','',0,0},
		 {'3','','','','','','','','','','','','','',0,51311917},
     {'4','','740 hemlock rd','','morgantown','pa','Nilfisk-Advance','','','','','','','',0,0},
		 {'9','','553 carter','54136','kimberly','wi','','','','','','','','',0,0}],
		BatchServices._Sample_layout_input_raw
	);

records := 
	PROJECT(
		ds_sample,
		TRANSFORM(DCA_Services.layouts_batch.Batch_in,
			clean_address := doxie.cleanaddress182( LEFT.addr, TRIM(LEFT.city) + ' ' + TRIM(LEFT.state) + ' ' + TRIM(LEFT.zip) );
			ca := Address.CleanFields(clean_address);
			SELF.prim_range  := ca.prim_range,
			SELF.predir      := ca.predir,
			SELF.prim_name   := ca.prim_name,
			SELF.addr_suffix := ca.addr_suffix,
			SELF.postdir     := ca.postdir,
			SELF.sec_range   := ca.sec_range,
			SELF.p_city_name := ca.p_city_name,
			SELF.st          := ca.st,
			SELF.z5          := ca.zip,
			SELF             := LEFT
		)
	);
	
EXPORT _canned_records := records;
