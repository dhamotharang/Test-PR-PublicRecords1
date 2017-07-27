import AutoKeyI, InstantID_Archiving;

export AutoKey_IDs(IParam.ak_params in_mod) := module
		c := AutoKey_constants;

		tempmod := module(project(in_mod, AutoKeyI.AutoKeyStandardFetchArgumentInterface, opt))
			export string autokey_keyname_root := c.ak_keyname;
			export string typestr              := c.ak_typeStr;
			export set of string1 get_skip_set := c.ak_skipSet;
			export boolean useAllLookups       := true;
			export boolean workHard            := true;
		end;

		ak_ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;		
		ak_id_keys :=
			JOIN(
				ak_ids,InstantID_Archiving.Key_AutokeyPayload,
				KEYED( LEFT.id = RIGHT.transaction_id_key),
				TRANSFORM(RIGHT),
				INNER,
				ATMOST(Constants.MAX_COUNT_RECORDS)
			);
	 outpl_payload :=
			JOIN(
				ak_id_keys, InstantID_Archiving.Key_Payload,
				KEYED( LEFT.transaction_id = RIGHT.transaction_id),
				TRANSFORM(RIGHT),
				INNER,
				ATMOST(Constants.MAX_COUNT_RECORDS)
			);
		
	outpl_transId := PROJECT(InstantID_Archiving.Key_Payload(trim(in_mod.TransactionId) != '' and KEYED(transaction_id = in_mod.TransactionId )), TRANSFORM(LEFT));	
//if enter transaction id, must match on transaction Id and not the inputted data
	outpl_all := if(trim(in_mod.TransactionId) = '', 
										outpl_payload, 
										outpl_payload(trim(in_mod.TransactionId) != '' and (transaction_id = in_mod.TransactionId )) + outpl_transId);

	export outpl := DEDUP( SORT( outpl_all, transaction_id, -(INTEGER)date_added ), transaction_id );
end;	

