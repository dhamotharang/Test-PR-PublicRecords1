export proc_chuncks(
	dataset(FidelityProp.layouts.out_dob) inf,
	string outf_prefix='~thor_data400::out::FidelityPropSlice400staging::'
) := FUNCTION


// l_out := FidelityProp.layouts.out_dob;
l_out := FidelityProp.layouts.out_dob_crim;

outrec := record(l_out)
	unsigned6 seqnum;
end;

// ut.MAC_Sequence_Records_NewRec(inf,outrec,seqnum,outf)
outf :=
project(
	inf,
	transform(
		outrec,
		self.seqnum := counter,
		self.transaction_type := if (trim(left.fares_transaction_type,left,right)='' , 
                                      left.fidelity_transaction_type,left.fares_transaction_type); 
    self.transaction_type_code := if(trim(left.fares_transaction_type,left,right)='', left.first_td_loan_type_code, 
                                     left.fares_transaction_type_code); 
		self.owner_1_did := if(left.owner_1_did=0,'',(string) left.owner_1_did);
		self.owner_2_did := if(left.owner_2_did=0,'',(string) left.owner_2_did);
		self.seller_1_did := if(left.seller_1_did=0,'',(string) left.seller_1_did);
		self.seller_2_did := if(left.seller_2_did=0,'',(string) left.seller_2_did);

		self := left
	)
);

r := distribute(outf, hash(seqnum)) : persist('cemtemp::test400staging');

f(dataset(outrec) d, integer i) := module

	integer recsper := 
		// 3914550;  //this is the total/20 (+ a few for fudge)
	  // 4000000; 
		count(r)/30;  //this for my file with 105M and 30 chunks
		// 7200000; //for some reason (reading from 200x to 400x?), it did half of what i want so i am doubling this number
	
	startp  := ((i - 1) * recsper) + 1;
	endp		:= i * recsper;
	
	export slice := project(d(seqnum >= startp and seqnum <= endp), FidelityProp.layouts.out_dob_crim);
	
	export out := 
	output(
		slice,,
		outf_prefix + trim((string)i),
		csv(
			heading(
				 fidelityprop.csvHeading.out_dob_crim, 
				//fidelityprop.csvHeading.out, 
				single
			),
			separator(','), 
			terminator('\n'), 
			quote('"')
		),
		overwrite
		, __compressed__
	);
	
end;

f(r,1).out;
f(r,2).out;
f(r,3).out;
f(r,4).out;
f(r,5).out;
f(r,6).out;
f(r,7).out;
f(r,8).out;
f(r,9).out;
f(r,10).out;
f(r,11).out;
f(r,12).out;
f(r,13).out;
f(r,14).out;
f(r,15).out;
f(r,16).out;
f(r,17).out;
f(r,18).out;
f(r,19).out;
f(r,20).out;
f(r,21).out;
f(r,22).out;
f(r,23).out;
f(r,24).out;
f(r,25).out;
f(r,26).out;
f(r,27).out;
f(r,28).out;
f(r,29).out;
f(r,30).out;

return output(if(exists(inf), 0, -1));

END;