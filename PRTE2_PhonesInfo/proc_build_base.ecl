
IMPORT PRTE2_PhoneFinderUpdateRules, PromoteSupers, PRTE2_PhoneFraud;

EXPORT proc_build_base := FUNCTION

	type_in_calc:=project(files.type_in,transform(layouts.phone_type,
	self.record_sid := hash64(left.phone + left.source + left.account_owner + left.carrier_name + left.vendor_first_reported_dt + left.vendor_first_reported_time + left.spid + left.operator_fullname + left.serv + left.line + left.high_risk_indicator + left.prepaid + left.reference_id) + (integer)left.phone;	
  SELF := LEFT;
 ));

trans_in_calc :=project(Files.trans_in,transform(Layouts.transactions,
 self.record_sid := hash64(
 left.phone +
 left.source +
 left.transaction_code +
 left.transaction_start_dt +
 left.transaction_start_time +
 left.transaction_end_dt +
 left.transaction_end_time +
 left.transaction_count +
 left.vendor_first_reported_dt +
 left.vendor_first_reported_time +
 left.vendor_last_reported_dt +
 left.vendor_last_reported_time +
 left.country_code +
 left.country_abbr +
 left.routing_code +
 left.dial_type +
 left.spid +
 left.carrier_name +
 left.phone_swap +
 left.ocn +
 left.alt_spid +
 left.lalt_spid +
 left.global_sid +
 left.record_sid);
 SELF := LEFT;
 ));
 
 trans_out:=files.trans_in_prime_flat + trans_in_calc;
 
 type_out:=files.type_in_prime_flat + type_in_calc;

 PromoteSupers.MAC_SF_BuildProcess(trans_out, constants.trans_base_name, bld_base_trans, ,, true);
 
 PromoteSupers.MAC_SF_BuildProcess(type_out, constants.type_base_name, bld_base_type, ,, true);

 return sequential(bld_base_trans,bld_base_type);
 

END;

