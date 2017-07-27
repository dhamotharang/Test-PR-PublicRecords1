
IMPORT Didville, Standard;

EXPORT fn_append_dids_to_batch_in( DATASET(Experian_Phones_Services.layouts.batch_in_plus) ds_batch_in ) := 
	FUNCTION
		
		DidVille.Layout_Did_OutBatch xfm_to_inbatch(Experian_Phones_Services.layouts.batch_in_plus l) :=
			TRANSFORM
				SELF.seq         := (UNSIGNED)l.acctno;
				SELF.ssn         := l.ssn;
				SELF.dob         := l.dob;
				SELF.phone10     := '';
				SELF.title       := '';
				SELF.fname       := l.name_first;
				SELF.mname       := l.name_middle;
				SELF.lname       := l.name_last;
				SELF.suffix      := l.name_suffix;
				SELF.prim_range  := l.prim_range;
				SELF.predir      := l.predir;
				SELF.prim_name   := l.prim_name;
				SELF.addr_suffix := l.addr_suffix;
				SELF.postdir     := l.postdir;
				SELF.unit_desig  := l.unit_desig;
				SELF.sec_range   := l.sec_range;
				SELF.p_city_name := l.p_city_name;
				SELF.st          := l.st;
				SELF.z5          := l.z5;
				SELF.zip4        := l.zip4;
				SELF             := [];
			END;
							
		ds_batch_in_common_pre := PROJECT( ds_batch_in, xfm_to_inbatch(LEFT) );

		// Append did to the input batch records and filter on did score.
		didville.MAC_DidAppend(ds_batch_in_common_pre, ds_batch_in_common_with_did_raw, true, 'true');

		ds_batch_in_common_with_did := 
			project(
				ds_batch_in_common_with_did_raw, 
				transform( {ds_batch_in_common_with_did_raw}, 
					self.did := if(left.score >= 75, left.did, 0), 
					self     := left
				)
			);
		
		// Join back to input and return.
		ds_batch_in_common := 
			JOIN(
				ds_batch_in, ds_batch_in_common_with_did,
				LEFT.acctno = (STRING)RIGHT.seq,
				TRANSFORM( Experian_Phones_Services.layouts.batch_in_plus,
					SELF.did        := RIGHT.did,
					SELF.err_search := 
							IF( RIGHT.did != 0, 
									Standard.Errors.Search.NO_ERROR, 
									Standard.Errors.Search.DID_NOT_FOUND
								),
						// Set the error_code to 'not found' because if we didn't find the DID, we certainly won't
						// find the Experian record. If we find the Experian record later, we'll change this value.
					SELF.error_code := Constants.Search_Errors.EXPERIAN_RECORD_NOT_FOUND,
					SELF            := LEFT
				),
				INNER,
				KEEP(Experian_Phones_Services.Constants.Limits.MAX_JOIN_LIMIT)
			);
					
		RETURN ds_batch_in_common;
	END;