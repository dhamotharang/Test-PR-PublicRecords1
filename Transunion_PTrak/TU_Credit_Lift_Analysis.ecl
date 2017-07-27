#workunit('name', 'EXP - TU True Lift Analysis');
import header;
Layout_Standard := RECORD
	 unsigned6 in_did;
	 string20  in_fname;
	 string20  in_lname;
	 string10  in_prim_range;
	 string28  in_prim_name;
	 string8   in_sec_range;
	 string5   in_zip;
	 string8   in_dob  		:= '';
	 boolean   in_has_dob 	:= false;
	 string9   in_ssn  		:= '';
	 boolean   in_has_ssn 	:= false;
END;

Layout_Standard2 := RECORD
   Layout_Standard;
   	 unsigned6 cnt 			;
	 string10  ind 			;
END;

	slimr :=
	RECORD
		unsigned6 did;
		unsigned3 dt_last_seen;
		unsigned3 dt_first_seen;
		qstring9   ssn;
		string1   jflag2;
		qstring28  prim_name;
		unsigned8 cnt := 1;
		STRING10 ind := '';
	END;
	

Layout_out := RECORD
		unsigned6 did;
		unsigned3 dt_last_seen;
		unsigned3 dt_first_seen;
		qstring9   ssn;
		string1   jflag2;
		qstring28  prim_name;
		unsigned8 cnt := 1;
		STRING10 ind := '';
	    string20  in_fname;
		string20  in_lname;
		string10  in_prim_range;
		string28  in_prim_name;
		string8   in_sec_range;
		string5   in_zip;
		string8   in_dob  		:= '';
		boolean   in_has_dob 	:= false;
		string9   in_ssn  		:= '';
		boolean   in_has_ssn 	:= false;
		unsigned1   Experian ;
		unsigned1   TU_true;
	END;

	
header_file_segmented := header.fn_ADLSegmentation(header.file_headers).core_check;
header_file_segmented_dedup := dedup(sort(distribute(header_file_segmented, hash(did)) , did, LOCAL), did, LOCAL): persist('persist::jtrost_hdr_seg');


//Lift files for Experian
//TU_true_ln := DATASET('~thor400::base::transunion_ln', Transunion_PTrak.Layout_ln_TU_true_Out.Layout_ln_TU_true_Final_Out, FLAT);

exp_dob := DATASET('~thor400_84::persist::header_uniquedidsdoblift5',Layout_Standard, THOR);

exp_ssn := DATASET('~thor400_84::persist::header_UniqueDidsSsnLift5',Layout_Standard, THOR);

exp_did_name_addr := DATASET('~thor400_84::persist::header_UniqueDidsNameAddressLift5',Layout_Standard, THOR);

//exp_name_addr := DATASET('~thor400_84::persist::header_UniqueNameAddressLift',Layout_Standard, THOR);

//Lift files for TU True
TU_true_dob := DATASET('~thor400_84::persist::header_uniquedidsdoblift4',Layout_Standard2, THOR);

TU_true_ssn := DATASET('~thor400_84::persist::header_UniqueDidsSsnLift4',Layout_Standard2, THOR);

TU_true_did_name_addr := DATASET('~thor400_84::persist::header_UniqueDidsNameAddressLift4',Layout_Standard2, THOR);

//TU_true_name_addr := DATASET('~thor400_84::persist::header_UniqueNameAddressLift2',Layout_Standard, THOR);





//-----------------------------------Exclusive Exp DOB
exp_dob_sort := DEDUP(SORT(DISTRIBUTE(exp_dob, HASH(in_did)), in_did, LOCAL), in_did, LOCAL);
TU_true_dob_sort := DEDUP(SORT(DISTRIBUTE(TU_true_dob, HASH(in_did)), in_did, LOCAL), in_did, LOCAL);

Layout_out t_dob1(header_file_segmented_dedup L, exp_dob_sort  R) := TRANSFORM
	self.did := if (L.did > 0 , L.did, R.in_did);
	self.Experian := 1;
	self.TU_true := 0;
	self := L;
	self := R;

END;



exp_dob_segmented := JOIN(header_file_segmented_dedup, exp_dob_sort , LEFT.did = RIGHT.in_did, t_dob1(LEFT, RIGHT), RIGHT OUTER);


Layout_out t_dob2(header_file_segmented_dedup L, TU_true_dob_sort   R) := TRANSFORM
	self.did := if (L.did > 0 , L.did, R.in_did);
	self.Experian := 0;
	self.TU_true := 1;
	self := L;
	self := R;

END;

TU_true_dob_segmented := JOIN(header_file_segmented_dedup, TU_true_dob_sort   , LEFT.did = RIGHT.in_did, t_dob2(LEFT, RIGHT), RIGHT OUTER);


Layout_out t_dob_exclusive (exp_dob_segmented  L, TU_true_dob_segmented R) := TRANSFORM
self.Experian := L.Experian;
self.TU_true:= R.TU_true;
	SELF.did :=  IF(L.did > 0,L.did, R.did);
	SELF.cnt :=  IF(L.cnt > 0,L.cnt, R.cnt);
	SELF.ind :=  IF(L.ind <> '',L.ind, R.ind);
	self := L;
	self := R;
END;

dob := JOIN(exp_dob_segmented, TU_true_dob_segmented, 
														LEFT.did = RIGHT.did ,
														t_dob_exclusive (LEFT, RIGHT) , FULL OUTER);

OUTPUT(table(dob(Experian = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(dob(TU_true = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(dob(Experian = 1 and TU_true = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(dob(Experian = 1 and TU_true = 0),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(dob(Experian = 0 and TU_true = 1),{ind,count(group,ind)},ind, FEW));


//-----------------------------------Exclusive Exp SSN
exp_ssn_sort := DEDUP(SORT(DISTRIBUTE(exp_ssn, HASH(in_did)), in_did, LOCAL), in_did, LOCAL);
TU_true_ssn_sort := DEDUP(SORT(DISTRIBUTE(TU_true_ssn, HASH(in_did)), in_did, LOCAL), in_did, LOCAL);

Layout_out t_ssn1(header_file_segmented_dedup L, exp_ssn_sort  R) := TRANSFORM
	self.did := if (L.did > 0 , L.did, R.in_did);
	self.Experian := 1;
	self.TU_true := 0;
	self := L;
	self := R;
END;

exp_ssn_segmented := JOIN(header_file_segmented_dedup, exp_ssn_sort , LEFT.did = RIGHT.in_did, t_ssn1(LEFT, RIGHT), RIGHT OUTER);


Layout_out t_ssn2(header_file_segmented_dedup L, TU_true_ssn_sort   R) := TRANSFORM
	self.did := if (L.did > 0 , L.did, R.in_did);
	self.Experian := 0;
	self.TU_true := 1;
	self := L;
	self := R;
END;

TU_true_ssn_segmented := JOIN(header_file_segmented_dedup, TU_true_ssn_sort , LEFT.did = RIGHT.in_did, t_ssn2(LEFT, RIGHT), RIGHT OUTER);


Layout_out t_ssn_exclusive (exp_ssn_segmented  L, TU_true_ssn_segmented R) := TRANSFORM
	self.Experian := L.Experian;
	self.TU_true:= R.TU_true;
	SELF.did :=  IF(L.did > 0,L.did, R.did);
	SELF.cnt :=  IF(L.cnt > 0,L.cnt, R.cnt);
	SELF.ind :=  IF(L.ind <> '',L.ind, R.ind);
	self := L;
	self := R;
END;

ssn := JOIN(exp_ssn_segmented, TU_true_ssn_segmented, 
														LEFT.did = RIGHT.did ,
														t_ssn_exclusive (LEFT, RIGHT) , FULL OUTER);
														
OUTPUT(table(ssn(Experian = 1),{ind,count(group,ind)},ind, FEW));		

OUTPUT(table(ssn(TU_true = 1),{ind,count(group,ind)},ind, FEW));											

OUTPUT(table(ssn(Experian = 1 and TU_true = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(ssn(Experian = 1 and TU_true = 0),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(ssn(Experian = 0 and TU_true = 1),{ind,count(group,ind)},ind, FEW));


//-----------------------------------Exclusive Exp did, name, addr
exp_did_name_addr_sort := SORT(DISTRIBUTE(exp_did_name_addr, HASH(in_did)), in_did, LOCAL);
TU_true_did_name_addr_sort := SORT(DISTRIBUTE(TU_true_did_name_addr, HASH(in_did)), in_did, LOCAL);


Layout_out t_did_name_addr1(header_file_segmented_dedup L, exp_did_name_addr_sort  R) := TRANSFORM
	self.did := if (L.did > 0 , L.did, R.in_did);
	self.Experian := 1;
	self.TU_true := 0;
	self := L;
	self := R;
END;

exp_did_name_addr_segmented := JOIN(header_file_segmented_dedup, exp_did_name_addr_sort , LEFT.did = RIGHT.in_did, t_did_name_addr1(LEFT, RIGHT), SKEW(10000),RIGHT OUTER);


Layout_out t_did_name_addr2(header_file_segmented_dedup L, TU_true_did_name_addr_sort   R) := TRANSFORM
	self.did := if (L.did > 0 , L.did, R.in_did);
	self.Experian := 0;
	self.TU_true := 1;
	self := L;
	self := R;
END;

TU_true_did_name_addr_segmented := JOIN(header_file_segmented_dedup, TU_true_did_name_addr_sort , LEFT.did = RIGHT.in_did, t_did_name_addr2(LEFT, RIGHT), SKEW(10000), RIGHT OUTER);



exp_did_name_addr_segmented_sort := SORT(DISTRIBUTE(exp_did_name_addr_segmented, HASH(did,in_fname,in_lname,in_prim_range,in_prim_name,in_sec_range,in_zip)), did,in_fname,in_lname,in_prim_range,in_prim_name,in_sec_range,in_zip, LOCAL);
TU_true_did_name_addr_segmented_sort := SORT(DISTRIBUTE(TU_true_did_name_addr_segmented, HASH(did,in_fname,in_lname,in_prim_range,in_prim_name,in_sec_range,in_zip)), did,in_fname,in_lname,in_prim_range,in_prim_name,in_sec_range,in_zip, LOCAL);



Layout_out t_did_name_addr_exclusive (exp_did_name_addr_segmented  L, TU_true_did_name_addr_segmented R) := TRANSFORM
self.Experian := L.Experian;
self.TU_true:= R.TU_true;;
	SELF.did :=  IF(L.did > 0,L.did, R.did);
	SELF.cnt :=  IF(L.cnt > 0,L.cnt, R.cnt);
	SELF.ind :=  IF(L.ind <> '',L.ind, R.ind);
	self := L;
	self := R;
END;

did_name_addr := JOIN(exp_did_name_addr_segmented, TU_true_did_name_addr_segmented, 
														left.did=right.did and
                              left.in_fname=right.in_fname and
							  left.in_lname=right.in_lname and
							  left.in_prim_range=right.in_prim_range and
							  left.in_prim_name=right.in_prim_name and
							  left.in_sec_range=right.in_sec_range and
							  left.in_zip=right.in_zip,
														t_did_name_addr_exclusive (LEFT, RIGHT) ,SKEW(10000), FULL OUTER);


OUTPUT(table(did_name_addr(Experian = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(did_name_addr(TU_true = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(did_name_addr(Experian = 1 and TU_true = 1),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(did_name_addr(Experian = 1 and TU_true = 0),{ind,count(group,ind)},ind, FEW));

OUTPUT(table(did_name_addr(Experian = 0 and TU_true = 1),{ind,count(group,ind)},ind, FEW));


export TU_Credit_Lift_Analysis := 'todo';