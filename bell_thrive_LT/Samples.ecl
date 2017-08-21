import address;
/*
For the LT File:
3rd sample LT file Consumer phones:
200 records (every 250th record )so that we can dial the ‘phone’  provided.
Details: fn/ln/address/phone
*/
export Samples(

	 dataset(layouts.base)	pBase								= files().base.qa
	,unsigned8							pNumConsumerRecords	= 500
	,unsigned8							pNumBusinessRecords	= 500

) :=
function

	dConsumer := project(
		pBase((unsigned6)clean_phones.Phone_Home != 0)
		,transform(
			{string firstname,string lastname, string address1, string address2, string phone},
			self.firstname 	:= left.clean_name.fname;
			self.lastname 	:= left.clean_name.lname;
			self.address1 	:= Address.Addr1FromComponents(
														 left.clean_address.prim_range
														,left.clean_address.predir
														,left.clean_address.prim_name
														,left.clean_address.addr_suffix
														,left.clean_address.postdir
														,left.clean_address.unit_desig
														,left.clean_address.sec_range
			);
			self.address2 	:= Address.Addr2FromComponents(
														 left.clean_address.v_city_name
														,left.clean_address.st
														,left.clean_address.zip
			);
			self.phone		 	:= left.clean_phones.Phone_Home;
		)
	);
	
	dBusiness := project(
		pBase((unsigned6)clean_phones.Phone_Work != 0)
		,transform(
			{string businessname, string firstname,string lastname,string address1, string address2, string phone},
			self.firstname 	:= left.clean_name.fname;
			self.lastname 	:= left.clean_name.lname;
			self.businessname 	:= left.rawfields.employer;
			self.address1 	:= Address.Addr1FromComponents(
														 left.clean_address.prim_range
														,left.clean_address.predir
														,left.clean_address.prim_name
														,left.clean_address.addr_suffix
														,left.clean_address.postdir
														,left.clean_address.unit_desig
														,left.clean_address.sec_range
			);
			self.address2 	:= Address.Addr2FromComponents(
														 left.clean_address.v_city_name
														,left.clean_address.st
														,left.clean_address.zip
			);
			self.phone		 	:= left.clean_phones.Phone_Work;
		)
	);

	consumerdenom := count(dConsumer) / pNumConsumerRecords;
  businessdenom := count(dBusiness) / pNumBusinessRecords;
									 
	dConsumer_sample := enth(dConsumer,1,consumerdenom);
	dBusiness_sample := enth(dBusiness,1,businessdenom);

	return parallel(
		 output(consumerdenom			,named('consumerdenom'		),all)
		,output(businessdenom			,named('businessdenom'		),all)
		,output(dConsumer_sample	,named('dConsumer_sample'	),all)
		,output(dBusiness_sample	,named('dBusiness_sample'	),all)
	);

end;