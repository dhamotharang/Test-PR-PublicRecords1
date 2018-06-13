IMPORT STD, Nid, Address, AID, DID_add, didville, Risk_Indicators, CellPhone, Gong, ut, _Validate;

Layout_Captions := RECORD
	 Layout_Neustar;
	 string	  temp_cap1    :='';
	 string   temp_cap2    :='';
	 string   temp_cap3    :='';
	 string   temp_cap4    :='';
	 string   temp_cap5    :='';
	 string   temp_cap6    :='';
	 string   temp_cap7    :='';
	 string	  temp_hseno   :='';
	 string	  temp_hsesx   :='';
	 string	  temp_strt    :='';
	 string   temp_address1:='';
	 string   temp_address2:='';
END;

proc_AddIndents(dataset(Layout_Neustar) infile) := FUNCTION
		Layout_Captions  concatCaps(Layout_Captions L,Layout_Captions R ) := transform

			 self.temp_cap1 := if(r.indent = 1,r.business_captions,if(r.indent > 1,l.temp_cap1,''));
			 self.temp_cap2 := if(r.indent = 2,r.business_captions,if(r.indent > 2,l.temp_cap2,''));
			 self.temp_cap3 := if(r.indent = 3,r.business_captions,if(r.indent > 3,l.temp_cap3,''));
			 self.temp_cap4 := if(r.indent = 4,r.business_captions,if(r.indent > 4,l.temp_cap4,''));
			 self.temp_cap5 := if(r.indent = 5,r.business_captions,if(r.indent > 5,l.temp_cap5,''));
			 self.temp_cap6 := if(r.indent = 6,r.business_captions,if(r.indent > 6,l.temp_cap6,''));
			 self.temp_cap7 := if(r.indent = 7,r.business_captions,if(r.indent > 7,l.temp_cap7,''));
			 
			 //Propogate SubHd2 detail records that have addresses
			 //self.temp_hseno := map(R.temp_hseno != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hseno, L.hseno);
			 //self.temp_hsesx := map(R.temp_hsesx != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hsesx, L.hsesx);
			 //self.temp_strt  := map(R.temp_strt  != '' and R.lststy = '2' and R.indent > '1'  => R.temp_strt , L.strt );
			 self := R;
	end;

	iCaps := iterate(PROJECT(infile,Layout_Captions),concatCaps(left,right));
	return iCaps;

end;


string MakeListedName(string fname, string mname, string lname, string sfx) :=
					TRIM(STD.Str.CleanSpaces(STD.Str.ToUpperCase(lname + ' ' + fname + ' ' + mname + ' ' + sfx)),LEFT,RIGHT);
				

EXPORT ProcessAdds(dataset(layout_Neustar) adds,string rundate = ut.Now()) := function

	addsWithCaps := proc_AddIndents(Adds);

	//master1 := PROJECT(addsWithCaps(record_type<>'R' OR Listing_Type='P' OR Original_Last_Name<>'' OR Original_First_Name<>'' OR Original_Middle_Name<>''
	//													OR Original_Suffix <>'' OR Original_Address<>'' OR Original_Last_Line<>''),
	master1 := PROJECT(addsWithCaps,
											TRANSFORM(Layout_gongMaster,

				self.filedate := ExtractFileDate(Left.filename, rundate);
				self.dt_first_seen:= IF(_Validate.Date_New(1991,2100).fIsValid(Left.add_date), Left.add_date, self.filedate[1..8]);
				self.dt_last_seen:= ExtractDate(Left.filename, rundate);
				self.current_record_flag:= 'Y';  
				self.deletion_date:= '';
				self.bell_id := 'NEU';
				self.sequence_number := COUNTER;
				self.SeisintID  		:= NeustarToSeisintId(left.Record_ID);
				self.group_id				:= self.SeisintID;
				self.listing_type_bus	:= IF(Left.RECORD_TYPE in ['B','b','P'],'B',' ');
				self.listing_type_res := IF(Left.RECORD_TYPE in ['R','r'],'R',' ');
				self.listing_type_gov := IF(Left.RECORD_TYPE in Gong_Neustar.Constants.govtRecordTypes,'G',' ');

				self.prior_area_code:= '';
				//self.company_name := Std.str.touppercase(left.Business_name);
				self.company_name := if(left.Business_name='',MakeListedName(Left.first_name,Left.middle_name,Left.last_name,Left.suffix_name),
															STD.Str.ToUpperCase(Left.Business_name));
				self.caption_text	    	:=  REGEXREPLACE('^[ |]+',
								Std.str.touppercase(
							   if(Left.temp_cap1 = '','',Left.temp_cap1)+
							   if(Left.temp_cap2 = '','','|'+Left.temp_cap2)+
							   if(Left.temp_cap3 = '','','|'+Left.temp_cap3)+
							   if(Left.temp_cap4 = '','','|'+Left.temp_cap4)+
							   if(Left.temp_cap5 = '','','|'+Left.temp_cap5)+
							   if(Left.temp_cap6 = '','','|'+Left.temp_cap6)+
							   if(Left.temp_cap7 = '','','|'+Left.temp_cap7)),'');

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

				CleanPhone					:= CellPhone.CleanPhones(LEFT.TELEPHONE);	
				self.phone10				:= if(self.publish_code = 'N' or cleanphone[4..10]='0000000','',cleanphone);

//				self.caption_text	:= Left.BUSINESS_CAPTIONS;
				self := left;)
	);
  master1a :=  proc_AddPriorAreaCodes(master1);
	master1b := proc_addGroup(master1a);
	master2 := proc_CleanNames(master1b);
	master3 := proc_CleanAddresses(master2);
	master6 := proc_LinkUp(master3);
	
	//master7 := proc_addGroup(master1a);

	return master6;
END;
