
import Doxie, DriversV2, DriversV2_Services, ut;

export fn_getDriversLicenseRecs( dataset(Layouts.LookupId) ids = dataset([],Layouts.LookupId) ) :=
	function
		/*
			Requirement 4.1-24:
			Search Drivers Licenses by the best subject being returned to ERO.  Once all DL records 
			are returned for the subject, compare the input gender to the DL gender:
				o   Compare values of Male and Female only.  Any DL records where the gender does not 
						match the input gender will be eliminated as a possible DL to be returned in 
						the output.  For example, if input from ERO’s input record is Male, but a record  
						foundin DL indicates a Female, that record should be eliminated.  
				o   If no gender is available (i.e., blank, Unknown, etc), then keep the record.

			Once all gender comparisons have been made, choose the Best DL record to return to ERO.

			Populate the DL Address Unique Flag:
				o   Return Y1 indicator if address matches  output address 1 
				o   Return Y2 indicator if address matches output  address 2
				o   Address match for indicator will be based on house number, primary name and zip code 
						of address (for instance, 123 NW Main St, Jupiter, FL 33458.... Match would be 
						determined on 123, Main, 33458. )
		*/
		/*
			Engineering notes (1/25/2013):
			The Drivers License batch service is a mess in that there's a lot of code we don't want, like
			an Autokey lookup, DL number lookup and a penalization routine that seemed to be in vogue a 
			few years back but is really expensive in terms of processing time. The best fit for what 
			we're trying to do here is imitate the DriversV2_Services.DLReportService, which calls 
			DriversV2_Services.fn_getDL_report and returns the results with very few additional steps.
			fn_getDL_report also takes a dataset of dids, so it's ideal for processing our input. And,
			it has all of the business rules for DPPA and GLBA built in, plus some nice formatting.	--cda
		*/
    // create unique list of DIDs regardless of acctno...they will get joined back into ids later on.
	   in_dids := dedup(sort(project(ids,doxie.layout_references),did),did);
		// Lookup dl_seq key values by DID; transform into record of {acctno,did,dl_seq}.
		by_did := 
			join(
				in_dids, DriversV2.Key_DL_DID,
				keyed(left.did = right.did),
				transform( {doxie.layout_references_acctno,DriversV2.Layout_DL_Decoded.dl_seq}, 
					self := right,
					self := left
				),
				limit(ERO_Services.Constants.Limits.MAX_DL_JOIN_LIMIT));

		seqs := project(by_did,DriversV2_Services.layouts.seq);

		// Generate simple DL report by dl_seq number.
		dl_recs := DriversV2_Services.DLRaw.narrow_view.by_seq(seqs);
		
		// Join back to acctno, did. No transform; just connect the right side to the left.
		dl_recs_with_ids :=
			join(
				by_did, dl_recs,
				left.dl_seq = right.dl_seq,
				inner
			);
		
		// Sort most current DL record to the top (we're calling this "Best"); group for rollup.
		dl_recs_grouped :=
			group(
				sort(
					dl_recs_with_ids,
					acctno, did, -(unsigned)(history_name = 'Current'), -expiration_date, -dt_last_seen
				),
				acctno, did
			);
		
		// Group rollup on acctno, did. DL_Gender field is the only reason we need to rollup at all.
		// Assign a standardized, concatenated value to DL_Address_prange_pname_zip, which will be used
		// later in match-coding in Vehicles and Accidents. The result is one record per acctno/did group.	
		dl_recs_rollup :=
			rollup(
				dl_recs_grouped,
				group,
				transform( ERO_Services.Layouts.DriversLicense_out_plus_DL_Address,
					self.acctno    := left.acctno,
					self.did       := left.did,
					self.DL_Name   := functions.fn_format_name(trim(left.lname), trim(left.fname), trim(left.mname)),
					self.DL_SSN    := left.ssn,
					self.DL_DOB    := functions.fn_format_date( (string)left.dob ),
					self.DL_Gender := 
							map( // if the driver has moved from one state to another, there may be inconsistent gender values.
								exists(rows(left)(sex_flag = 'M')) AND exists(rows(left)(sex_flag = 'F')) => 'M,F', // look first for something really strange
								left.sex_flag != ''                => left.sex_flag,
								exists(rows(left)(sex_flag = 'M')) => 'M', // The most current record may
								exists(rows(left)(sex_flag = 'F')) => 'F', // be blank, but other records
								exists(rows(left)(sex_flag = 'U')) => 'U', // might have values.
								/* default........................ */ ''
							),
					self.DL_Number          := left.dl_number,
					self.DL_Issue_Date      := functions.fn_format_date( (string)left.lic_issue_date ),
					self.DL_Expiration_Date := functions.fn_format_date( (string)left.expiration_date ),
					self.DL_Street_Address  := left.addr1,
					self.DL_City            := left.p_city_name,
					self.DL_State           := left.st,
					self.DL_Zip             := left.zip5,
					self.DL_Unique_Address_Flag := '',
					self.DL_prim_range      := left.prim_range,
					self.DL_predir          := left.predir,
					self.DL_prim_name       := left.prim_name,
					self.DL_addr_suffix     := left.suffix,
					self.DL_postdir         := left.postdir,
					self.DL_unit_desig      := left.unit_desig,
					self.DL_sec_range       := left.sec_range,
					self.DL_p_city_name     := left.p_city_name,
					self.DL_st              := left.st,
					self.DL_z5              := left.zip5
				));			
		
		// Join back to 'ids' formal parameter to look for gender mismatches and to compare addresses.
		// Again, no transform; just connect the right side to the left.
		dl_recs_joined_back := 
			join(
				ids, dl_recs_rollup,
				left.did = right.did,
				inner
			);
		
		// Remove the gender mismatches.
		dl_recs_gender_mismatches_removed :=
				dl_recs_joined_back( // just a fancy-looking filter
				  (ut.getage(ut.ConvertDate(DL_Expiration_Date,'%m/%d/%Y','%Y%m%d'))<=1)   //only return DL that are 2year old or newer
				  AND
					NOT(
						(input_gender = 'M' and DL_Gender = 'F') 
							or 
						(input_gender = 'F' and DL_Gender = 'M')
					) );

		// Populate the DL Address Unique Flag. The following function compares the two Best
		// addresses retrieved earlier in this service with the address in the DL record and 
		// returns a code if there is a match.
		fn_determine_DL_address_unique( recordof(dl_recs_gender_mismatches_removed) le ) := 
				function
					// For output_address _1 and _2, and the DL address, concatenate address data, 
					// capitalize, remove non-alphanumeric chars. 
					output_address_1 :=
						StringLib.StringFilter(
							StringLib.StringToUpperCase(
								trim(le.addr1.prim_range) + trim(le.addr1.prim_name) + trim(le.addr1.z5)
							), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	);
					
					output_address_2 :=
						StringLib.StringFilter(
							StringLib.StringToUpperCase(
								trim(le.addr2.prim_range) + trim(le.addr2.prim_name) + trim(le.addr2.z5)
							), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	);
					
					dl_record_address := 
						StringLib.StringFilter(
							StringLib.StringToUpperCase(
								trim(le.DL_prim_range) + trim(le.DL_prim_name) + trim(le.DL_z5)
							), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	);
					
					// Compare and return.
					unique_address_flag :=
						map(
							dl_record_address = output_address_1 => 'Y1',
							dl_record_address = output_address_2 => 'Y2',
							/* default........................... */ ''
						);
					
					return unique_address_flag;
				end;
		
		dl_recs_address_flag_marked :=
			PROJECT(
				dl_recs_gender_mismatches_removed,
				transform( ERO_Services.Layouts.DriversLicense_out_plus_DL_Address,
					self.DL_Unique_Address_Flag := fn_determine_DL_address_unique(left),
					self := left
				));
		
		return dl_recs_address_flag_marked;		
	end; 
