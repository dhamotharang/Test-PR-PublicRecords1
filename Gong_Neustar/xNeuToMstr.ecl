import ut, std;

string MakeListedName(string fname, string mname, string lname, string sfx) :=
					TRIM(STD.Str.CleanSpaces(STD.Str.ToUpperCase(lname + ' ' + fname + ' ' + mname + ' ' + sfx)),LEFT,RIGHT);


export xNeuToMstr(dataset(layout_Neustar) adds,string rundate = ut.Now()) := function

	adds1 := PROJECT(adds, TRANSFORM(Layout_Neustar,
										self.unknownField := IntFormat(COUNTER, 10, 0);	// in order to return to original sequence
										self := LEFT;
								));


		AddSort := SORT(adds, RECORD, EXCEPT add_date,unknownField, TransactionID, latitude, longitude,filename);
		AddsD := ROLLUP(AddSort, TRANSFORM(Gong_Neustar.layout_neustar,
									self.Add_date := earlier(LEFT.add_date,RIGHT.add_date);
									self := LEFT;),
								RECORD, EXCEPT add_date,unknownField, TransactionID, latitude, longitude,filename);
		//AddsResort := SORT(AddsD, (integer)unknownField);
		
	master1 := PROJECT(AddsD,
											TRANSFORM(Layout_gongMaster,
				self.dt_first_seen:= Left.add_date;
				self.dt_last_seen:= ExtractDate(Left.filename, rundate);
				self.current_record_flag:= 'Y';  
				self.deletion_date:= '';
				//self.filedate := rundate + '_1';
				self.filedate := ExtractFileDate(Left.filename, rundate);
				self.bell_id := 'NEU';
				self.sequence_number := COUNTER;
				self.SeisintID  		:= NeustarToSeisintId(left.Record_ID);
				self.group_id				:= self.SeisintID;
				self.listing_type_bus	:= IF(Left.RECORD_TYPE in ['B','b','P'],'B',' ');
				self.listing_type_res := IF(Left.RECORD_TYPE in ['R','r'],'R',' ');
				self.listing_type_gov := IF(Left.RECORD_TYPE = 'G','G',' ');

				self.prior_area_code:= '';
				//self.company_name := Std.str.touppercase(left.Business_name);
				self.company_name := if(left.Business_name='',MakeListedName(Left.first_name,Left.middle_name,Left.last_name,Left.suffix_name),
															STD.Str.ToUpperCase(Left.Business_name));
				self.caption_text	    	:= Left.BUSINESS_CAPTIONS;

				self.publish_code			:= case(left.LISTING_TYPE,
											'L' => 'P',				// listed
											'U' => 'U',				// unlisted
											'P' => 'N',				// private
											' ');
				self.style_code			:= 'X';		// default ... no comparable Neustar field							   
				self.indent_code			:= (string)IF(left.indent BETWEEN 0 AND 10, left.indent, 0);
				self.omit_address  := left.omit_address;
				self.omit_phone    := 'N';
				self.omit_locality := 'N';
				self.privacy_flag 	:= 'N';		// no equivalent in Neustar	

				CleanPhone					:= LEFT.TELEPHONE;		//CellPhone.CleanPhones(LEFT.TELEPHONE);	
				self.phone10				:= if(self.publish_code = 'N' or cleanphone[4..10]='0000000','',cleanphone);

//				self.caption_text	:= Left.BUSINESS_CAPTIONS;
				self := left;)
	);		
		
		return master1;
END;