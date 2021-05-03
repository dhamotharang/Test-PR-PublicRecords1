import property,lib_fileservices,ut,Business_Header,Header;

export	consumer_as_header(dataset(targus.layout_consumer_out) pTargusConsumer = dataset([],targus.layout_consumer_out), boolean pForHeaderBuild=false)
 :=
  function
	dDeathAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().WP,Targus.Consumer_as_Source(pTargusConsumer,pForHeaderBuild));

	dConsumerbase 	:= dDeathAsSource(lname != '' 
									  ,prim_name != '' 
									  ,zip != '' 
									  ,length(trim(fname))>1 
									  ,(unsigned)(Cleanname[71..73])>85);

	Header.Layout_New_Records Translate_consumer_to_Header(dConsumerbase pLeft) 
	   := transform
		self.did 					   	:= 0;
		self.rid 						:= 0;
		self.pflag1 					:= '';
		self.pflag2 					:= '';
		self.pflag3 					:= '';
		self.dt_first_seen 	        	:= if(pLeft.dt_first_seen >1, 
											  pLeft.dt_first_seen,
											  pLeft.dt_last_seen);
		self.dt_last_seen 				:= if(pLeft.dt_last_seen >1, 
											  pLeft.dt_last_seen,
											  pLeft.dt_first_seen);
		self.dt_vendor_first_reported 	:= pLeft.dt_vendor_first_reported;
		self.dt_vendor_last_reported 	:= pLeft.dt_vendor_last_reported;
		self.dt_nonglb_last_seen 		:= self.dt_last_seen;
		self.rec_type 					:= '';
		self.mname 				    	:= pLeft.minit;
		self.vendor_id 					:= trim(pLeft.record_id) + '_' +
											pLeft.pubdate;
		self.phone 						:= if(regexfind('[a-zA-Z]', pleft.phone_number), '', pleft.phone_number);
		self.ssn 						:= '';
		self.dob 						:= 0;
		self.cbsa 						:= if(pLeft.cbsa!='',pLeft.cbsa + '0','');
		self.tnt 						:= '';
		self.valid_ssn 					:= '';
		self.jflag1 					:= '';
		self.jflag2 					:= '';
		self.jflag3 					:= '';
		self 							:= pLeft;
	end; 

	Consumer_In := project(dConsumerbase,Translate_consumer_to_Header(left));
    return Consumer_In;
  end
 ;
