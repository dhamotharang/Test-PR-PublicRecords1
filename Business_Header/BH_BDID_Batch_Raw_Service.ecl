/*--SOAP--
<message name="BusinessHeaderBDIDRawBatch">
  <part name="batch_in" type="tns:XmlDataSet"/>
  <part name="BestAppend" type="xsd:string"/>
  <part name="BestVerify" type="xsd:string"/>
  <part name="Threshold" type="xsd:unsignedInt"/>
</message>
*/

export BH_BDID_Batch_Raw_Service() := MACRO

STRING120 best_append_val1 := '' : stored('BestAppend');
STRING120 best_verify_val1 := '' : stored('BestVerify');
UNSIGNED1 threshold_value := 1 : stored('Threshold');
best_append_val := stringlib.StringToUpperCase(best_append_val1);
best_verify_val := stringlib.StringToUpperCase(best_verify_val1);

string DataRestrictionMask := AutoStandardI.Constants.DataRestrictionMask_default : STORED('DataRestrictionMask');
string DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default : STORED('DataPermissionMask');

/* input batch with acctno */
inBatch_rec := rECORD
	  String20  acctno;
		Business_Header_SS.Layout_BDID_InBatch;
END;

/* output batch with acctno */
Layout_BDID_OutBatch_append := rECORD
  string20 acctno;
	Business_Header_SS.Layout_BDID_OutBatch;
END;

/* verified itneger att */
verify_int_att := RECORD
  unsigned1 verify_best_phone := 255;
  unsigned1 verify_best_fein := 255;
  unsigned1 verify_best_address := 255;
  unsigned1 verify_best_CompanyName := 255;
	unsigned6 seq;
END;	

/* output batch rec with all string fields */
OutBatch_rec := RECORD
    String12 BDID := '0';
    string3 score := '0';
    inBatch_rec - seq;
    Business_Header_SS.Layout_Best_Append - verify_int_att;
		string3 verify_best_phone := '255';
		string3 verify_best_fein := '255';
		string3 verify_best_address := '255';
		string3 verify_best_CompanyName := '255';
END;

/* input cleaning */
inbatch := dataset([], inBatch_rec) : stored('batch_in', few);

inBatch_rec xfm_clean_input(inBatch_rec in_bt) := TRANSFORM
	SELF.company_name := stringlib.StringToUpperCase(in_bt.company_name);
	SELF.prim_range := stringlib.StringToUpperCase(in_bt.prim_range);
	SELF.predir := stringlib.StringToUpperCase(in_bt.predir);
	SELF.prim_name := stringlib.StringToUpperCase(in_bt.prim_name);
	SELF.addr_suffix := stringlib.StringToUpperCase(in_bt.addr_suffix);
	SELF.postdir := stringlib.StringToUpperCase(in_bt.postdir);
	SELF.unit_desig := stringlib.StringToUpperCase(in_bt.unit_desig);
	SELF.sec_range := stringlib.StringToUpperCase(in_bt.sec_range);
	SELF.p_city_name := stringlib.StringToUpperCase(in_bt.p_city_name);
	SELF.st := stringlib.StringToUpperCase(in_bt.st);
	SELF.seq := HASH32(in_bt.acctno);
  SELF := in_bt;
END;

cleaned_in := PROJECT(inbatch,xfm_clean_input(LEFT));

Business_Header_SS.MAC_BDID_Append(
	cleaned_in,
	match_res,
	threshold_value
)

Business_Header_SS.MAC_BestAppend(
	match_res,
	best_append_val,
	best_verify_val,
	best_res,
	DataPermissionMask,
	DataRestrictionMask,
	true
)

/* convert output to all strings */
OutBatch_rec xfm_best_res(cleaned_in l,Business_Header_SS.Layout_BDID_OutBatch r) := TRANSFORM
		SELF.verify_best_phone := INTFORMAT(r.verify_best_phone,3,1);
		SELF.verify_best_fein := INTFORMAT(r.verify_best_fein,3,1);
		SELF.verify_best_address := INTFORMAT(r.verify_best_address,3,1);
		SELF.verify_best_CompanyName := INTFORMAT(r.verify_best_CompanyName,3,1);
		SELF.BDID := IF(r.bdid=0,'',INTFORMAT(r.BDID,12,1));
		SELF.score := INTFORMAT(r.score,3,1);
		SELF := r;
		SELF := l;
END;

out_res_acctno := JOIN(cleaned_in,best_res
                        ,HASH32(LEFT.acctno) = RIGHT.seq
												,xfm_best_res(LEFT,RIGHT));
out_res := SORT(out_res_acctno,acctno);

output(out_res, named('Result'))

ENDMACRO;
