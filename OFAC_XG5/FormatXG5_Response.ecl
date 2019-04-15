import iesp, patriot, lib_stringlib;

EXPORT FormatXG5_Response (DATASET(OFAC_XG5.Layout.ResponseRec) responseXG5)
													:= FUNCTION



EntityMatchwAddress := RECORD
	OFAC_XG5.Layout.EntityMatch  ;
	integer addressCount;
	STRING100 country;
	STRING50 addr_1;
	STRING50 addr_2;
	STRING50 addr_3;
	STRING50 addr_4;
	STRING50 addr_5;
	STRING50 addr_6;
	STRING50 addr_7;
	STRING50 addr_8;
	STRING50 addr_9;
	STRING50 addr_10;
END;


PrepDenormEntity := project(responseXG5.entityRec, 
														transform(EntityMatchwAddress, self := left, 
																														self := []));
AddressMatchPlus := RECORD																												
   OFAC_XG5.Layout.AddressMatches;
	 string50 addr1;
	 string50 addr2;
	 integer Addrpartcount;
	 string50 AddrValue;
end;


																														
AddressMatchPlus GetAddressParts(OFAC_XG5.Layout.AddressMatches le) :=  TRANSFORM  


	addrPart1 :=  trim(le.StreetAddress1) + if(trim(le.StreetAddress2) <> '', ' ' + trim(le.StreetAddress2),'');
	citystzipcntry := Map ( trim(le.City) <>  '' and trim(le.state) <> '' and trim(le.PostalCode) <> '' and trim(le.country) <> '' =>  trim(le.City) + ' ' + trim(le.state) + ' ' + trim(le.PostalCode) + ' ' + trim(le.country),
													trim(le.City) <>  '' and trim(le.state) <> '' and trim(le.PostalCode) <> '' and trim(le.country) = '' =>  trim(le.City) + ' ' + trim(le.state) + ' ' +  trim(le.PostalCode),
													trim(le.City) <>  '' and trim(le.state) = '' and trim(le.PostalCode) <> '' and trim(le.country) <> '' =>  trim(le.City) + ' ' + trim(le.PostalCode) + ' ' + trim(le.country),
													trim(le.City) <>  '' and trim(le.state) = '' and trim(le.PostalCode) = '' and trim(le.country) <> '' =>  trim(le.City) + ' ' + trim(le.country),
													trim(le.City) <>  '' and trim(le.state) = '' and trim(le.PostalCode) <> '' and  trim(le.country) <> '' =>  trim(le.City) + ' ' + trim(le.PostalCode) + ' ' + trim(le.country),
													trim(le.City) <>  '' and trim(le.state) = '' and trim(le.PostalCode) = '' and trim(le.country) <> '' =>  trim(le.City) + ' ' + trim(le.country),
													trim(le.City) =  '' and trim(le.state) <> '' and trim(le.PostalCode) <> '' and trim(le.country) <> '' =>  trim(le.state) + ' ' + trim(le.PostalCode) + ' ' + trim(le.country),
													trim(le.City) =  '' and trim(le.state) <> '' and trim(le.PostalCode) = '' and trim(le.country) <> '' =>  trim(le.state) + ' ' + trim(le.country),
													trim(le.City) <>  ''  =>  trim(le.City),
													trim(le.state) <>  ''  =>  trim(le.state),
													trim(le.country) <>  ''  =>  trim(le.country),
													trim(le.PostalCode) <>  '' => trim(le.PostalCode),
											    '');

	addrPart2 :=  trim(citystzipcntry);
								
	self.addr1   :=   Map ( 
												  trim(addrPart1) <> '' =>  addrPart1,
													trim(addrPart2) <> ''=>  addrPart2,
													'');
	self.addr2   :=   if(addrPart2 <> '' and addrPart1 <> '', addrPart2, '');

	AddrpartcountTemp := map(	addrPart1 <> '' and addrPart2 <> '' => 2,
														addrPart1 <> '' or  addrPart2 <> '' => 1,
														0);
	self.Addrpartcount := AddrpartcountTemp;
	self.AddrValue := if(AddrpartcountTemp = 1 and addrPart1 <> '', addrPart1 , addrPart2 );
	self := le;
END;																														

PrepAddress := project(responseXG5.addrRec(addresstype <> 0), GetAddressParts(left));

AddressMatchPlus normAddrs(PrepAddress le, integer File_counter) := TRANSFORM
	self.AddrValue := if(File_counter = 1, le.addr1,  le.addr2);
	self.addr1 := le.addr1;
	self.addr2 := le.addr2;
	self := le;
END;

normAddress := normalize(PrepAddress(Addrpartcount = 2), 2, normAddrs(left, counter));

alladdress := sort(normAddress + PrepAddress(Addrpartcount <> 2), blockid, entitySeq);


EntityMatchwAddress GetAddress(PrepDenormEntity le,alladdress ri, integer i) :=  TRANSFORM  // address in 1, country in 2, so on that way.
	
  self.country   :=  ri.country;
	self.addr_1   :=   if(1 = i, ri.AddrValue, le.addr_1);
	self.addr_2   :=   if(2 = i, ri.AddrValue, le.addr_2);
	self.addr_3   :=   if(3 = i,ri.AddrValue, le.addr_3);
	self.addr_4   :=   if(4 = i,ri.AddrValue, le.addr_4);
	self.addr_5   :=   if(5 = i,ri.AddrValue, le.addr_5);
	self.addr_6   :=   if(6 = i,ri.AddrValue, le.addr_6);
	self.addr_7   :=   if(7 = i,ri.AddrValue, le.addr_7);
	self.addr_8   :=   if(8 = i,ri.AddrValue, le.addr_8);
	self.addr_9   :=   if(9 = i,ri.AddrValue, le.addr_9);
	self.addr_10  :=   if(10 = i,ri.AddrValue, le.addr_10);
	self := le;
END;


DenormAddr := denormalize(PrepDenormEntity, alladdress,
													left.blockID = right.blockID and left.EntitySeq = right.EntitySeq,
													GetAddress(left,right,counter), keep(10));

remarks :=  RECORD
  integer blockid;
	integer EntitySeq;
  STRING75 remarkXG5;
END;

remarks  GetIDRemarks(OFAC_XG5.Layout.ResultMatchID le) := TRANSFORM

   self.blockid :=  le.blockid;
	 self.EntitySeq := le.EntitySeq;
	 self.remarkXG5  := le.MatchIDremarks;
END;

 normMatchIDRemarks := project(responseXG5.MatchIDRec(MatchIDremarks <>''), GetIDRemarks(left));
 
 remarks  GetDescRemarks(OFAC_XG5.Layout.ResultMatchEntityDescription le) := TRANSFORM

   self.blockid :=  le.blockid;
	 self.EntitySeq := le.EntitySeq;
	 self.remarkXG5  := le.remarks;
END;

 normDescRemarks := project(responseXG5.DescRec(remarks <>''), GetDescRemarks(left));
 
  remarks  GetEntityRemarks(OFAC_XG5.Layout.EntityMatch le) := TRANSFORM

   self.blockid :=  le.blockid;
	 self.EntitySeq := le.EntitySeq;
	 self.remarkXG5  := le.EntityNotes;
END;

 normEntityRemarks := project(responseXG5.EntityRec(EntityNotes <> ''), GetEntityRemarks(left));
 
 AllRemarks := dedup(sort(normMatchIDRemarks + normDescRemarks + normEntityRemarks, blockid,entityseq, remarkXG5), blockid,entityseq, remarkXG5);
 
 RemarksOut := project(allRemarks, 	transform(Patriot.layout_search_out.remark, self.remark_v := left.remarkXG5));
 
 
 AKAsRec :=  RECORD
  integer blockid;
	integer EntitySeq;
  UNICODE350 akaname;
	STRING5 score;
END;

 AKAsRec aka_tran(OFAC_XG5.Layout.AKABestMatches le) := TRANSFORM
  AKAScore := (string)le.BestScore;
	extraZeros := '000'[1..5-LENGTH(AKAScore)];
	SELF.score := if(le.akaid = le.bestid, AKAScore + extraZeros, '.000');
	SELF.akaname := le.fullname;
	SELF.blockid := le.blockid;
	SELF.entityseq := le.entityseq;
END;
 
 PrepAKAs := sort(project(responseXG5.AKARec(FullName <> ''), aka_tran(left)), blockid,entityseq, -(real)score);
					


patriot.layout_search_out.parent formatOut(responseXG5 le , DenormAddr ri) :=  TRANSFORM

	EntityScore := (string)le.EntityRec[1].EntityMatchScore;
	extraZeros := '000'[1..5-LENGTH(EntityScore)];
	BestAKA := le.akaRec(bestId = akaID);
	// self.programReason := '';//	OFAC_XG5.Program_lookup(lib_stringlib.stringlib.StringToUpperCase(trim(le.EntityRec[1].EntityReason)));									
	self.score := EntityScore + extraZeros;
	self.orig_pty_name :=  IF(le.searchType <>'C', if(BestAKA[1].bestid = 0, le.EntityRec[1].EntityNameFull, BestAKA[1].BestName), '');
	SELF.akas := choosen(join(responseXG5(EntitySeq = le.EntitySeq), PrepAKAs, left.blockid = right.blockid and left.entityseq = right.entityseq,
													transform(Patriot.layout_search_out.AKA, self.orig_pty_name := right.akaname, self.score := right.score)),10);
	SELF.addresses := join(responseXG5(EntitySeq = le.EntitySeq), DenormAddr, left.blockid = right.blockid and left.entityseq = right.entityseq,
													transform(Patriot.layout_search_out.address, self := right));
	SELF.remarks := choosen(join(responseXG5(EntitySeq = le.EntitySeq), AllRemarks, left.blockid = right.blockid and left.entityseq = right.entityseq,
													transform(Patriot.layout_search_out.remark, self.remark_v := right.remarkXG5),left outer),30);
	SELF.pty_key := le.EntityRec[1].EntityPartyKey;
	sourceLength := length(le.FileRec[1].FileName);
	
	SELF.source :=  le.FileRec[1].FileName[1..(sourceLength - 4)];  // remove the .cdf and .bdf extensions
	SELF.record_type := MAP(le.entityrec[1].entitytypedesc = 'BUSINESS'=>'N',
												  le.entityrec[1].entitytypedesc = 'COUNTRY'=>'C',
												  le.entityrec[1].entitytypedesc = 'INDIVIDUAL'=>'I',
													'U');

	SELF.blocked_country := IF(SELF.record_type='C',le.entityrec[1].EntityCountry,'');
	self := [];
END;

filled_outXG5 := join(responseXG5, DenormAddr,  
											left.blockid = right.blockid and
											left.entityseq = right.entityseq, formatOut(LEFT, right), left outer);
											

RETURN filled_outXG5;

END;


