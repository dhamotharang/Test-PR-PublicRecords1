import GlobalWatchLists, iesp, patriot;

export BackwardsCompatible() := module

export Layout_DOBScore := record
	unsigned1	DOBRecordID := 0;
	unsigned1	DOBScore := 0;
	boolean IsDOBPartial := false;
end;

export DOBScore(dataset(iesp.share.t_Date) in_dobs, dataset(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAdditionalInfo) dobs) := function
	
		Layout_DOBScore ScoreDOBs(dobs l) := transform
		lYear := (integer)l.ParsedInfo[1..4];
		lMonth := (integer)l.ParsedInfo[6..7];
		lDay := (integer)l.ParsedInfo[9..10];
		
		// assume 1 DOB in user input for now
		YearNoMatch := in_dobs[1].Year<>0 and lYear<>0 and in_dobs[1].Year<>lYear;
		MonthNoMatch := in_dobs[1].Month<>0 and lMonth<>0 and in_dobs[1].Month<>lMonth;
		DayNoMatch := in_dobs[1].Day<>0 and lDay<>0 and in_dobs[1].Day<>lDay;   

		self.DOBRecordID := L.RecordID;
		self.DOBScore := map(YearNoMatch or MonthNoMatch or DayNoMatch => 0,
												in_dobs[1].Year<>0 and lYear<>0 => 100,
												in_dobs[1].Month<>0 and lMonth<>0 => 100,
												in_dobs[1].Day<>0 and lDay<>0 => 100,
												0);
		self.IsDOBPartial := in_dobs[1].Year=0 or lYear=0 or	in_dobs[1].Month=0 or lMonth=0 or in_dobs[1].Day=0 or lDay=0;
		self := [];
	end;
	BestScore := choosen(sort(project(dobs, ScoreDOBs(left)), -DOBScore),1);
	NoScore := dataset([{0,0,false}], Layout_DOBScore);

	return if(exists(in_dobs) and exists(dobs), BestScore, NoScore);
end;


export FormatScore(integer iScore) := function
	rScore := (real)iScore * .01;
	sScore := TRIM(((STRING)rScore)[1..5]);
	isWhole := LENGTH(sScore)=1;
	extraZeros := '000'[1..5-LENGTH(sScore)];
	formatted_score := sScore + IF(isWhole,'.000',extraZeros);
	return formatted_score;
end;

export Address(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddress address, boolean include_country = false) :=  function
	uAddress := address.StreetAddress1 + u' ' +
							address.StreetAddress2 + u' ' +
							address.City + u' ' +
							address.State  + u' ' +
							address.Zip + u' ';
	wCountry := if(include_country, uAddress + address.Country, uAddress);
	sAddress := (string)UnicodeLib.UnicodeCleanSpaces(wCountry);
	return sAddress;
end;

export Addresses(dataset(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAddress) addresses) :=  function
	patriot.layout_search_out.address convert_addresses(addresses l) := transform
		self.addr_1 := (string50)l.StreetAddress1;
		self.addr_2 := (string50)l.StreetAddress2;
		self.addr_3 := (string50)l.City;
		self.addr_4 := (string50)l.State;
		self.addr_5 := (string50)l.Zip;
		self.Country := (string100)l.Country;
		self := [];
	end;
	formatted_addresses := project(addresses, convert_addresses(left));
	return formatted_addresses;
end;

export Remarks(string4096 comments) := function
	dsRemarks := dataset([{comments[1..74]}, 
											{comments[75..149]},
											{comments[150..224]},
											{comments[225..299]},
											{comments[300..374]},
											{comments[375..449]},
											{comments[450..524]},
											{comments[525..599]},
											{comments[600..674]},
											{comments[675..749]},
											{comments[750..824]},
											{comments[825..899]},
											{comments[900..974]},
											{comments[975..1049]},
											{comments[1050..1124]},
											{comments[1125..1199]},
											{comments[1200..1274]},
											{comments[1275..1349]},
											{comments[1350..1424]},
											{comments[1425..1499]},
											{comments[1500..1574]},
											{comments[1575..1649]},
											{comments[1650..1724]},
											{comments[1725..1799]},
											{comments[1800..1874]},
											{comments[1875..1949]},
											{comments[1950..2024]},
											{comments[2025..2099]},
											{comments[2100..2174]},
											{comments[2175..2249]}
											],patriot.layout_search_out.remark);
	return dsRemarks(trim(remark_v)<>'');
end;

export EntityRemarks(string4096 comments, 
								dataset(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAdditionalInfo) addlinfo, 
								dataset(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutID) idnumbers) := function

	patriot.layout_search_out.remark convertIDNumbers(idnumbers l) := transform
		id_type_1 :=	trim(GlobalWatchLists.constants.GetIDTypeString(l.idtype));
		id_type_2 := if(id_type_1 = '' or l.idtype = 15, trim(id_type_1 + ' ' + (string)l.label), id_type_1);
		self.remark_v := trim(id_type_2 + ': ' + trim((string)l.idnumber) + ' ' + trim((string)l.issuedby) + ' ' + trim((string)l.comments));
	end;
	ds_idnumbers := project(idnumbers, convertIDNumbers(left));

	patriot.layout_search_out.remark convertAddlInfo(addlinfo l) := transform
		self.remark_v := trim(trim((string)l.addlinfotype) + ': ' + trim((string)l.addlinfo) + ' ' + trim((string)l.comments));
	end;
	ds_addlinfo := project(addlinfo, convertAddlInfo(left));

	dsRemarks := choosen(ds_idnumbers + ds_addlinfo + Remarks(comments), 30);									
	return dsRemarks;
end;

end;