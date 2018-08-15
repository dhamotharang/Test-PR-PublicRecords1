import iesp, patriot;

EXPORT FormatXG5_ResponseFlat (DATASET(OFAC_XG5.Layout.ResponseRec) responseXG5) := FUNCTION
													

NonErrorRecs := responseXG5(errormessage = '');

EntityMatchFLAT := RECORD
	OFAC_XG5.Layout.EntityMatch  ;
	string350 BestFullName;
	string50 BestFName;
	string50 BestMName;
	string50 BestLName;
	integer BestAKAID;
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
	STRING75 remarks_1;
	STRING75 remarks_2;
	STRING75 remarks_3;
	STRING75 remarks_4;
	STRING75 remarks_5;
	STRING75 remarks_6;
	STRING75 remarks_7;
	STRING75 remarks_8;
	STRING75 remarks_9;
	STRING75 remarks_10;
	STRING75 remarks_11;
	STRING75 remarks_12;
	STRING75 remarks_13;
	STRING75 remarks_14;
	STRING75 remarks_15;
	STRING75 remarks_16;
	STRING75 remarks_17;
	STRING75 remarks_18;
	STRING75 remarks_19;
	STRING75 remarks_20;
	STRING75 remarks_21;
	STRING75 remarks_22;
	STRING75 remarks_23;
	STRING75 remarks_24;
	STRING75 remarks_25;
	STRING75 remarks_26;
	STRING75 remarks_27;
	STRING75 remarks_28;
	STRING75 remarks_29;
	STRING75 remarks_30;
	
END;


PrepDenormEntity_pre := project(NonErrorRecs.entityRec, 
														transform(EntityMatchFLAT, self := left, 
																														self := []));

PrepDenormEntity := DEDUP( PrepDenormEntity_pre, RECORD, ALL, HASH );

AKARecord := RECORD
	OFAC_XG5.Layout.AKABestMatches ;
END;

BestAKA_pre := project(NonErrorRecs, 
									transform(AKARecord,
									BestAKA := left.akaRec(bestId = akaID);
									self := BestAKA[1]));

BestAKA := DEDUP( BestAKA_pre, RECORD, ALL, HASH );
									
AddBestAKA := join(prepDenormEntity, BestAKA, 
									left.blockID = right.blockID and left.EntitySeq = right.EntitySeq,
									transform(EntityMatchFLAT,
														self.BestFullName := right.bestname,
														self.BestFName := right.Firstname,
														self.BestMName := right.Middlename,
														self.BestLName := right.Lastname,
														self.BestAKAID := right.bestid,
														self := left), left outer);
																														
AddressMatchPlus := RECORD																												
   OFAC_XG5.Layout.AddressMatches;
	 string50 addr1;
	 string50 addr2;
	 integer Addrpartcount;
	 string50 AddrValue;
end;


																														
AddressMatchPlus GetAddressParts(OFAC_XG5.Layout.AddressMatches le) :=  TRANSFORM  // address in 1, country in 2, so on that way.

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
														addrPart1 <> '' and addrPart2 = '' => 1,
														addrPart1 = '' and addrPart2 <> '' => 1,
														0);
	self.Addrpartcount := AddrpartcountTemp;
	self.AddrValue := if(AddrpartcountTemp = 1 and addrPart1 <> '', addrPart1 , addrPart2 );
	self := le;
END;																														

PrepAddress_pre := project(NonErrorRecs.addrRec(addresstype <> 0), GetAddressParts(left));

PrepAddress := DEDUP( PrepAddress_pre, RECORD, ALL, HASH );

AddressMatchPlus normAddrs(PrepAddress le, integer File_counter) := TRANSFORM
	self.AddrValue := if(File_counter = 1, le.addr1,  le.addr2);
	self.addr1 := le.addr1;
	self.addr2 := le.addr2;
	self := le;
END;

normAddress := normalize(PrepAddress(Addrpartcount = 2), 2, normAddrs(left, counter));

alladdress := sort(normAddress + PrepAddress(Addrpartcount <> 2), blockid, entitySeq);

EntityMatchFLAT GetAddress(AddBestAKA le,alladdress ri, integer i) :=  TRANSFORM  // address in 1, country in 2, so on that way.
	
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
	self := [];
END;


DenormAddr := denormalize(AddBestAKA, alladdress,
													left.blockID = right.blockID and left.EntitySeq = right.EntitySeq,
													GetAddress(left,right,counter), left outer);

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

 normMatchIDRemarks := project(NonErrorRecs.MatchIDRec(MatchIDremarks <>''), GetIDRemarks(left));
 
 remarks  GetDescRemarks(OFAC_XG5.Layout.ResultMatchEntityDescription le) := TRANSFORM

   self.blockid :=  le.blockid;
	 self.EntitySeq := le.EntitySeq;
	 self.remarkXG5  := le.remarks;
END;

 normDescRemarks := project(NonErrorRecs.DescRec(remarks <>''), GetDescRemarks(left));
 
  remarks  GetEntityRemarks(OFAC_XG5.Layout.EntityMatch le) := TRANSFORM

   self.blockid :=  le.blockid;
	 self.EntitySeq := le.EntitySeq;
	 self.remarkXG5  := le.EntityNotes;
END;

 normEntityRemarks := project(NonErrorRecs.EntityRec(EntityNotes <> ''), GetEntityRemarks(left));
 
 AllRemarks := dedup(sort(normMatchIDRemarks + normDescRemarks + normEntityRemarks, blockid,entityseq), blockid,entityseq, remarkXG5);
 
 
EntityMatchFLAT GetRemarks(DenormAddr le, AllRemarks ri, integer i) :=  TRANSFORM  
	
	self.remarks_1   :=   if(1 = i, ri.remarkXG5, le.remarks_1);
	self.remarks_2   :=   if(2 = i, ri.remarkXG5, le.remarks_2);
	self.remarks_3   :=   if(3 = i, ri.remarkXG5, le.remarks_3);
	self.remarks_4   :=   if(4 = i, ri.remarkXG5, le.remarks_4);
	self.remarks_5   :=   if(5 = i, ri.remarkXG5, le.remarks_5);
	self.remarks_6   :=   if(6 = i, ri.remarkXG5, le.remarks_6);
	self.remarks_7   :=   if(7 = i, ri.remarkXG5, le.remarks_7);
	self.remarks_8   :=   if(8 = i, ri.remarkXG5, le.remarks_8);
	self.remarks_9   :=   if(9 = i, ri.remarkXG5, le.remarks_9);
	self.remarks_10   :=   if(10 = i, ri.remarkXG5, le.remarks_10);
	self.remarks_11   :=   if(11 = i, ri.remarkXG5, le.remarks_11);
	self.remarks_12   :=   if(12 = i, ri.remarkXG5, le.remarks_12);
	self.remarks_13   :=   if(13 = i, ri.remarkXG5, le.remarks_13);
	self.remarks_14   :=   if(14 = i, ri.remarkXG5, le.remarks_14);
	self.remarks_15   :=   if(15 = i, ri.remarkXG5, le.remarks_15);
	self.remarks_16   :=   if(16 = i, ri.remarkXG5, le.remarks_16);
	self.remarks_17   :=   if(17 = i, ri.remarkXG5, le.remarks_17);
	self.remarks_18   :=   if(18 = i, ri.remarkXG5, le.remarks_18);
	self.remarks_19   :=   if(19 = i, ri.remarkXG5, le.remarks_19);
	self.remarks_20   :=   if(20 = i, ri.remarkXG5, le.remarks_20);
	self.remarks_21   :=   if(21 = i, ri.remarkXG5, le.remarks_21);
	self.remarks_22   :=   if(22 = i, ri.remarkXG5, le.remarks_22);
	self.remarks_23   :=   if(23 = i, ri.remarkXG5, le.remarks_23);
	self.remarks_24   :=   if(24 = i, ri.remarkXG5, le.remarks_24);
	self.remarks_25   :=   if(25 = i, ri.remarkXG5, le.remarks_25);
	self.remarks_26   :=   if(26 = i, ri.remarkXG5, le.remarks_26);
	self.remarks_27   :=   if(27 = i, ri.remarkXG5, le.remarks_27);
	self.remarks_28   :=   if(28 = i, ri.remarkXG5, le.remarks_28);
	self.remarks_29   :=   if(29 = i, ri.remarkXG5, le.remarks_29);
	self.remarks_30   :=   if(30 = i, ri.remarkXG5, le.remarks_30);
	self := le;
END; 
 
 AddRemarks := denormalize(DenormAddr, AllRemarks,
													left.blockID = right.blockID and left.EntitySeq = right.EntitySeq,
													GetRemarks(left,right,counter), left outer);


patriot.layout_batch_out formatOut(NonErrorRecs le , DenormAddr ri) :=  TRANSFORM

	EntityScore := (string)le.EntityRec[1].EntityMatchScore;
	extraZeros := '000'[1..5-LENGTH(EntityScore)];
											
	self.score := EntityScore + extraZeros;
	self.HitNum := (string)le.entityseq;
	self.orig_pty_name :=  IF(le.searchType <> 'C',if(ri.bestAKAid = 0, le.EntityRec[1].EntityNameFull, ri.BestFullName), '');
	
	SELF.pty_key := le.EntityRec[1].EntityPartyKey;
	sourceLength := length(le.FileRec[1].FileName);
	
	SELF.source :=  le.FileRec[1].FileName[1..(sourceLength - 4)];  // remove the .cdf and .bdf extensions

	SELF.blocked_country := IF(le.entityrec[1].entitytypedesc = 'COUNTRY',le.entityrec[1].EntityCountry,'');
	SELF.name_first  := le.firstName;
	SELF.name_middle  :=  le.middleName;
	SELF.name_last  :=  le.lastName;
	SELF.name_unparsed  :=  le.FullName;
	SELF.search_type  := le.searchType;
	SELF.country  := le.country;
	SELF.dob := le.dob;
	self := ri;
	self := le;
	self := [];
END;

filled_outXG5Flat_pre := join(NonErrorRecs, AddRemarks,  
											left.blockid = right.blockid and
											left.entityseq = right.entityseq, formatOut(LEFT, right), left outer);

filled_outXG5Flat := DEDUP( filled_outXG5Flat_pre, RECORD, ALL, HASH );

// OUTPUT( NonErrorRecs, NAMED('NonErrorRecs') );
// OUTPUT( PrepDenormEntity, NAMED('PrepDenormEntity') );
// OUTPUT( BestAKA, NAMED('BestAKA') );
// OUTPUT( AddBestAKA, NAMED('AddBestAKA') );
// OUTPUT( PrepAddress, NAMED('PrepAddress') );
// OUTPUT( normAddress, NAMED('normAddress') );
// OUTPUT( alladdress, NAMED('alladdress') );
// OUTPUT( DenormAddr, NAMED('DenormAddr') );
// OUTPUT( normMatchIDRemarks, NAMED('normMatchIDRemarks') );
// OUTPUT( normDescRemarks, NAMED('normDescRemarks') );
// OUTPUT( normEntityRemarks, NAMED('normEntityRemarks') );
// OUTPUT( AllRemarks, NAMED('AllRemarks') );
// OUTPUT( AddRemarks, NAMED('AddRemarks') );
// OUTPUT( filled_outXG5Flat, NAMED('filled_outXG5Flat') );

RETURN filled_outXG5Flat;

END;


