import Address, Didville, Business_Header_SS, Business_Header, ut, Inquiry_AccLogs;

export fn_portfolio_update_george(UNSIGNED1 pseudo_environment,
                           STRING spray_ip_address,
                           STRING spray_ip_path) := function

	// Current WUID
	ts := thorlib.wuid();
	string in_timestamp := ts[2..9] + ts[11..16];
	
	// Actions:
	MODIFY   := AccountMonitoring.constants.actions.MODIFY;
	PRODUCTS := AccountMonitoring.constants.actions.PRODUCTS;
	GO       := AccountMonitoring.constants.actions.GO;
	STOP     := AccountMonitoring.constants.actions.STOP;
	DELETE   := AccountMonitoring.constants.actions.DELETE;
	
	// Spray the update file
	spray_input_files := AccountMonitoring.proc_input_portfolio_update(pseudo_environment,spray_ip_address,spray_ip_path,ts);
	
	// Read and distribute the update file by PID and RID
	portfolio_update  := distribute(files(pseudo_environment).portfolio.update,hash32(pid,rid));
	
	// Project into the style of portfolio base
	portfolio_update_as_base_FOR_MODIFY := project(portfolio_update(action_code = MODIFY),
		transform(Layouts.Portfolio.Base,
			self.pid := left.pid,
			self.rid := left.rid,
			self.timestamp := ts[2..9] + ts[11..16],
			self.action_code := left.action_code,
			self.did := 0,
			self.bdid := 0,
			self.product_mask := left.product_mask,
			self.name_first := stringlib.StringToUpperCase(left.name_first),
			self.name_middle := if(left.name_first = '','',stringlib.StringToUpperCase(left.name_middle)),
			self.name_last := if(left.name_first = '','',stringlib.StringToUpperCase(left.name_last)),
			self.name_suffix := if(left.name_first = '','',stringlib.StringToUpperCase(left.name_suffix)),
			self.comp_name := if(left.name_first = '',stringlib.StringToUpperCase(left.name_last),''),
			clnd := Address.GetCleanAddress(left.address_1 + ' ' + left.address_2,
																			left.city + ', ' + left.state + ' ' + left.zip,
																			Address.Components.Country.US).results;
			self.prim_range  := clnd.prim_range,
			self.predir      := clnd.predir,
			self.prim_name   := clnd.prim_name,
			self.addr_suffix := clnd.suffix,
			self.postdir     := clnd.postdir,
			self.unit_desig  := clnd.unit_desig,
			self.sec_range   := clnd.sec_range,
			self.p_city_name := clnd.p_city,
			self.st          := clnd.state,
			self.z5          := clnd.zip,
			self.zip4        := clnd.zip4,
			self.fein        := left.ssn,
			self.ssn         := left.ssn,
			self.dob         := left.dob,
			self.phone       := left.phone,
			self.hash_docid  := 0
			));
	
	// Set up a temporary record for holding identifiers
	id_rec := record
		unsigned4 seq;
		unsigned6 did := 0;
		unsigned6 bdid := 0;
	end;
	
	// Get DIDs
	DidVille.Layout_Did_InBatch xfm_to_did_inbatch(layouts.portfolio.base l) :=
		TRANSFORM
			SELF.seq         := HASH32(l.pid, l.rid);
			SELF.title       := '';
			SELF.fname       := l.name_first;
			SELF.mname       := l.name_middle;
			SELF.lname       := l.name_last;
			SELF.suffix      := l.name_suffix;
			SELF.phone10     := l.phone;
			SELF             := l;
		END;
		
	f_did_in     := PROJECT( portfolio_update_as_base_FOR_MODIFY( name_last != '' ), xfm_to_did_inbatch(LEFT) );

	f_did_out := PIPE(f_did_in
			, 'roxiepipe' +
			' -iw ' + SIZEOF(DidVille.Layout_Did_InBatch) +
			' -vip' +
			' -t 2' +
			' -ow ' + SIZEOF(DidVille.Layout_Did_OutBatch) +
			' -b 100' +
			' -mr 2' +
			' -h ' + 'roxiebatch.br.seisint.com:9856' + 
			' -r Result' +
			' -q "<DidVille.DID_Batch_Service format=\'raw\'><Fuzzies>ALL</Fuzzies><Deduped>TRUE</Deduped>' +
			'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in>' +
			'</DidVille.DID_Batch_Service>"'
			, DidVille.Layout_Did_OutBatch);

	best_dids_slim := PROJECT(DISTRIBUTED(f_did_out,seq), id_rec);
		
	// Get BDIDs
	Business_Header_SS.Layout_BDID_InBatch xfm_to_bdid_inbatch(layouts.portfolio.base l) :=
		TRANSFORM
			SELF.seq         := HASH32(l.pid, l.rid);
			SELF.company_name:= l.comp_name;
			SELF.phone10     := l.phone;
			SELF             := l;
		END;
		
	f_bdid_in := PROJECT( portfolio_update_as_base_FOR_MODIFY( comp_name != '' ), xfm_to_bdid_inbatch(LEFT) );

	f_bdid_out := PIPE(f_bdid_in
		, 'roxiepipe' +
		' -iw ' + SIZEOF(Business_Header_SS.Layout_BDID_InBatch) +
		' -vip' +
		' -t 2' +
		' -ow ' + SIZEOF(Business_Header.layout_BDID_OutBatch_Expanded) +
		' -b 100' +
		' -mr 2' +
		' -h ' + 'roxiebatch.br.seisint.com:9856' +
		' -r Result' +
		' -q "<Business_Header.BH_BDID_Batch_Service format=\'raw\'>' +
		'<bdid_batch_in id=\'id\' format=\'raw\'></bdid_batch_in>' +
		'</Business_Header.BH_BDID_Batch_Service>"'
		, Business_Header.layout_BDID_OutBatch_Expanded);

	best_bdids_slim := PROJECT(DISTRIBUTED(f_bdid_out,seq), id_rec);
	
	// Combine identifiers
	best_ids_slim := best_dids_slim + best_bdids_slim;
	
	// Join identifiers back to the update file and persist
	layouts.portfolio.base toPortfolio(layouts.portfolio.base l, id_rec r) := 
		TRANSFORM
			SELF := r;
			SELF := l;
		END;
		
	modify_updates := JOIN(portfolio_update_as_base_FOR_MODIFY, best_ids_slim,
												 HASH32(left.pid,left.rid) = RIGHT.seq,
												 toPortfolio(LEFT, RIGHT),
												 KEEP(1), LOCAL);
	
	// Take the update file and find non-MODIFY actions
	portfolio_update_NONMODIFY := portfolio_update(action_code in [PRODUCTS, GO, STOP, DELETE]);
	
	// Join against existing portfolio to ensure actions are against existing PID/RIDs, and create new portfolio records
	current_portfolio_dist   := distribute(AccountMonitoring.files(pseudo_environment).portfolio.base,hash32(pid,rid));
	current_portfolio_sorted := sort(current_portfolio_dist,pid,rid,-timestamp,local);
	current_portfolio_dedup  := dedup(current_portfolio_sorted,pid,rid,local);
	
	current_portfolio_reduced := join(
		current_portfolio_dedup,
		portfolio_update,
		left.pid = right.pid and
		left.rid = right.rid,
		transform(left),
		local);
	
	product_or_delete_updates := join(
		current_portfolio_reduced,
		portfolio_update_NONMODIFY,
		// current_portfolio_sorted,
		left.pid = right.pid and
		left.rid = right.rid,
		transform(layouts.portfolio.base,
			self.timestamp := ts[2..9] + ts[11..16],
			self.action_code := IF(right.action_code = constants.actions.DELETE,right.action_code,left.action_code),
			self.product_mask := MAP(
				left.action_code = constants.actions.GO       =>    right.product_mask | left.product_mask,
				left.action_code = constants.actions.STOP     =>    left.product_mask & BNOT(right.product_mask),
				left.action_code = constants.actions.DELETE   =>    left.product_mask,
		 /* left.action_code = constants.actions.PRODUCTS => */ right.product_mask),
			self := left),
		local);
	
	all_updates_sorted := sort(modify_updates + product_or_delete_updates,pid,rid,local);
	
	merged_portfolio := 
		MERGE(
			all_updates_sorted, current_portfolio_sorted,
			SORTED(pid,rid),
			LOCAL
		);
	
	// Now take the portfolio and create inquiry tracking info from it
	// Take the "last" portfolio records for all PID/RIDs that had an update
	inquiry_tracking_base := merge(
		all_updates_sorted,
		sort(current_portfolio_reduced,pid,rid,local),
		sorted(pid,rid),
		local);
	
	inquiry_tracking_plus := project(inquiry_tracking_base,
		transform({inquiry_tracking_base;unsigned8 whatsnew;unsigned8 whatsgone;},
			self.whatsnew := left.product_mask,
			self.whatsgone := 0,
			self := left));
	
	whats_changed := rollup(inquiry_tracking_plus,
		transform(recordof(inquiry_tracking_plus),
			self.whatsnew := (left.whatsnew ^ right.product_mask) & left.whatsnew,
			self.whatsgone := (left.whatsnew ^ right.product_mask) & bnot(left.whatsnew),
			self := left),
		pid,rid,
		local);
	
	whats_new_normalized := normalize(whats_changed,64,
		transform({layouts.portfolio.base,boolean whatsnew},
			self.product_mask := if(ut.bit_test(left.whatsnew,counter-1),ut.bit_set(0,counter-1),skip),
			self.whatsnew := true;
			self := left));
			
	whats_gone_normalized := normalize(whats_changed,64,
		transform({layouts.portfolio.base,boolean whatsnew},
			self.product_mask := if(ut.bit_test(left.whatsgone,counter-1),ut.bit_set(0,counter-1),skip),
			self.whatsnew := false;
			self := left));

	final_inquiry_tracking_file := project(whats_new_normalized + whats_gone_normalized,transform(Inquiry_AccLogs.Layout.Common,
		self.MBS.Company_ID := (string)left.pid;
		self.Person_Q.Personal_Phone := left.phone;
		self.Person_Q.DOB := left.dob;
		self.Person_Q.SSN := left.ssn;
		self.Person_Q.fname := left.name_first;
		self.Person_Q.mname := left.name_middle;
		self.Person_Q.lname := left.name_last;
		self.Person_Q.name_suffix := left.name_suffix;
		self.Person_Q.prim_range := left.prim_range;
		self.Person_Q.predir := left.predir;
		self.Person_Q.prim_name := left.prim_name;
		self.Person_Q.addr_suffix := left.addr_suffix;
		self.Person_Q.postdir := left.postdir;
		self.Person_Q.unit_desig := left.unit_desig;
		self.Person_Q.sec_range := left.sec_range;
		self.Person_Q.city := left.p_city_name;
		self.Person_Q.st := left.st;
		self.Person_Q.zip := left.z5;
		self.Person_Q.zip4 := left.zip4;
		self.Person_Q.Appended_ADL := left.did;
		self.Bus_Q.CName := left.comp_name;
		self.Bus_Q.Company_Phone := left.phone;
		self.Bus_Q.EIN := left.fein; // unique id
		self.Bus_Q.prim_range := left.prim_range;
		self.Bus_Q.predir := left.predir;
		self.Bus_Q.prim_name := left.prim_name;
		self.Bus_Q.addr_suffix := left.addr_suffix;
		self.Bus_Q.postdir := left.postdir;
		self.Bus_Q.unit_desig := left.unit_desig;
		self.Bus_Q.sec_range := left.sec_range;
		self.Bus_Q.city := left.p_city_name;
		self.Bus_Q.st := left.st;
		self.Bus_Q.zip := left.z5;
		self.Bus_Q.zip4 := left.zip4;
		self.Bus_Q.Appended_BDID := left.bdid;
		self.Search_Info.DateTime := in_timestamp;
		self.Search_Info.Start_Monitor := if(left.whatsnew,in_timestamp,'');
		self.Search_Info.Stop_Monitor := if(not left.whatsnew,in_timestamp,'');
		self.Search_Info.Transaction_ID := in_timestamp;
		self.Search_Info.Sequence_Number := (string)left.pid + '-' + (string)left.rid;
		self.Search_Info.Method := 'Monitoring';
		self.Search_Info.Product_Code := (string)left.product_mask;
		self := []));

	DELETE_SUBFILE      := TRUE;
	COPY_FILE_CONTENTS  := TRUE;
	
	inquiry_superfile_stem_name := filenames(pseudo_environment).inquirytracking;
	inquiry_logical_file_name   := inquiry_superfile_stem_name + in_timestamp;
	INQUIRY_ROLLBACK            := FALSE; // Not really worried about it being zero, otherwise COUNT(final_inquiry_tracking_file) = 0;

	portfolio_superfile_stem_name := filenames(pseudo_environment).portfolio.base;
	portfolio_logical_file_name   := portfolio_superfile_stem_name + in_timestamp;
	PORTFOLIO_ROLLBACK            := FALSE; // Not really worried about it being zero, otherwise COUNT(merged_portfolio) = 0;
	
	update_portfolio_and_inquiry_superfiles := SEQUENTIAL(
		PARALLEL(
			IF(NOT PORTFOLIO_ROLLBACK,OUTPUT(merged_portfolio,,portfolio_logical_file_name,COMPRESSED)),
			IF(NOT INQUIRY_ROLLBACK,OUTPUT(final_inquiry_tracking_file,,inquiry_logical_file_name,COMPRESSED))
		),
		PARALLEL(
			IF(NOT PORTFOLIO_ROLLBACK,Utilities.fn_update_superfiles(portfolio_superfile_stem_name, portfolio_logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS)),
			IF(NOT INQUIRY_ROLLBACK,SEQUENTIAL(
				IF( NOT FileServices.SuperfileExists(inquiry_superfile_stem_name),
					FileServices.CreateSuperFile(inquiry_superfile_stem_name) ),
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(inquiry_superfile_stem_name, inquiry_logical_file_name), 
				FileServices.FinishSuperFileTransaction()
			))
		)
	);
	
	fnms := AccountMonitoring.filenames(pseudo_environment);

	mac_update_documents_file(pseudo_environment,bankruptcy,spray_ip_address,spray_ip_path,fnms.documents.bankruptcy.remote,write_updated_bankruptcy_documents_file);
	mac_update_documents_file(pseudo_environment,deceased,spray_ip_address,spray_ip_path,fnms.documents.deceased.remote,write_updated_deceased_documents_file);
	mac_update_documents_file(pseudo_environment,address,spray_ip_address,spray_ip_path,fnms.documents.address.remote,write_updated_address_documents_file);
	mac_update_documents_file(pseudo_environment,phone,spray_ip_address,spray_ip_path,fnms.documents.phone.remote,write_updated_phone_documents_file);
	mac_update_documents_file(pseudo_environment,paw,spray_ip_address,spray_ip_path,fnms.documents.paw.remote,write_updated_paw_documents_file);
	mac_update_documents_file(pseudo_environment,property,spray_ip_address,spray_ip_path,fnms.documents.property.remote,write_updated_property_documents_file);
	mac_update_documents_file(pseudo_environment,litigiousdebtor,spray_ip_address,spray_ip_path,fnms.documents.litigiousdebtor.remote,write_updated_litigiousdebtor_documents_file);
	mac_update_documents_file(pseudo_environment,liens,spray_ip_address,spray_ip_path,fnms.documents.liens.remote,write_updated_liens_documents_file);
	mac_update_documents_file(pseudo_environment,criminal,spray_ip_address,spray_ip_path,fnms.documents.criminal.remote,write_updated_criminal_documents_file);
	mac_update_documents_file(pseudo_environment,phonefeedback,spray_ip_address,spray_ip_path,fnms.documents.phonefeedback.remote,write_updated_phonefeedback_documents_file);
	mac_update_documents_file(pseudo_environment,foreclosure,spray_ip_address,spray_ip_path,fnms.documents.foreclosure.remote,write_updated_foreclosure_documents_file);
	mac_update_documents_file(pseudo_environment,workplace,spray_ip_address,spray_ip_path,fnms.documents.workplace.remote,write_updated_workplace_documents_file);
	
	write_updated_files := PARALLEL(
		update_portfolio_and_inquiry_superfiles,
		write_updated_bankruptcy_documents_file,
		write_updated_deceased_documents_file,
		write_updated_address_documents_file,
		write_updated_phone_documents_file,
		write_updated_paw_documents_file,
		write_updated_property_documents_file,
		write_updated_litigiousdebtor_documents_file,
		write_updated_liens_documents_file,
		write_updated_criminal_documents_file,
		write_updated_phonefeedback_documents_file,
		write_updated_foreclosure_documents_file,
		write_updated_workplace_documents_file
	);
	
	RETURN SEQUENTIAL(
			spray_input_files,
			write_updated_files);

end;
