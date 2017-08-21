import ut, std;

export File_GongVendorIDs := module

	export voips := dataset([
			{'Vendor Name','Vendor ID','Decimal','Hex','File Name','File Type','Install'},
			{'Comcast','comcast','3','0x03','Core','VoIP','Prem'},
			{'Sprint Nextel','sprintnex','5','0x05','Core','VoIP','Prem'},
			{'Merge Lo','mergelo','7','0x07','Core','VoIP','Non'},
			{'Charter','charter','8','0x08','Core','VoIP','Prem'},
			{'iCore','icore','19','0x13','Core','VoIP','Prem'},
			{'Voip Innovations','voin','29','0x1d','Core','VoIP','Non'},
			{'IP Centrics','ipc','34','0x22','Core','VoIP','Prem'},
			{'Iristel','iristel','89','0x59','Core','VoIP','Non'},
			{'SocketTel','socket','90','0x5a','Core','VoIP','Prem'},
			{'Light Speed','lspeed','165','0xa5','Core','VoIP','Prem'},
			{'Pulver','pulver','28','0x1c','Core','VoIP','Non'}], 
	{string VoipVendorName, string LSSiVendorID, string VDecimal, string Vendor, string File_Name, string File_Type, string Install});
	
	export vendor_translations := dataset([
			{'0x01','LSSi Disconnects',false},
			{'0x02','Acxiom',false},
			{'0x03','Comcast',false},
			{'0x05','Sprint Nextel',false},
			{'0x06','Lssilo',false},
			{'0x07','ETS (MergeLo)', false},
			{'0x09','Alltel - DUPE',true},
			{'0x09','CenturyTel - DUPE',true},
			{'0x09','Chester/Truvista - DUPE',true},
			{'0x09','Copper Valley Telephone - DUPE',true},
			{'0x09','Frontier - DUPE',true},
			{'0x09','GTE - DUPE',true},
			{'0x09','Guam - DUPE',true},
			{'0x09','Hawaii Telecom - DUPE',true},
			{'0x09','HickoryTech - DUPE',true},
			{'0x09','MTUP - DUPE',true},
			{'0x09','North State - DUPE',true},
			{'0x09','Puerto Rico - DUPE',true},
			{'0x09','Qwest - DUPE',true},
			{'0x09','RNK - DUPE',true},
			{'0x09','Rock Hill Telephone - DUPE',true},
			{'0x09','TDS - DUPE',true},
			{'0x09','US Tracers - DUPE',true},
			{'0x09','Verizon North - DUPE',true},
			{'0x09','Verizon South - DUPE',true},
			{'0x09','Verizon West - DUPE',true},
			{'0x09','Whaleback - DUPE',true},
			{'0x0a','Ameritech',false},
			{'0x0c','PSTel',false},
			{'0x0d','Union',false},
			{'0x0e','Lexcom data (no longer a supplier)', false},
			{'0x0f','RCN',false},
			{'0x10','Eatel',false},
			{'0x13','iCore', false},
			{'0x14','Bellsouth',false},
			{'0x16','AT&T CallVantage  (no longer a supplier)', false},
			{'0x1a','Fairpoint',false},
			{'0x1C','Pulver',false},
			{'0x1d','VoIP Innovations',false},
			{'0x1e','Nevada Bell (acquired by PacBell) - DUPE',true},
			{'0x1e','Pacbell - DUPE',true},
			{'0x22','IP Centrics',false},
			{'0x3c','Pioneer',false},
			{'0x46','Horizon',false},
			{'0x5a','SocketTel',false},
			{'0x67','Centris',false},
			{'0x6a','Chickasaw',false},
			{'0x6e','Southwest Bell',false},
			{'0x70','Onvoy',false},
			{'0x72','Concord (acquired by Windstream) - DUPE',true},
			{'0x72','Lexcom (acquired by Windstream) - DUPE',true},
			{'0x72','Valor (acquired by Windstream) - DUPE',true},
			{'0x72','Windstream - DUPE',true},
			{'0x73','Panhandle', false},
			{'0x75','SDNet',false},
			{'0x7a','Arvig',false},
			{'0x7d','Cinn.Bell',false},
			{'0x82','Acxiom TF',false},
			{'0x86','SNET',false},
			{'0x87','Clearlink',false},
			{'0x88','IowaTel  (no longer a supplier)', false},
			{'0x8B','Sprint TF',false},
			{'0x8c','Sprint',false},
			{'0x8e','National',false},
			{'0x90','OSC',false},
			{'0x93','GCI Alaska',false},
			{'0xA0','AT&T TF',false},
			{'0xa5','Light Speed', false},
			{'0xb4','CCOS',false},
			{'0xbe','SCNET - Farmers',false},
			{'0xbf','SCNET - Horry',false},
			{'0xc0','SCNET - Chester',false},
			{'0xc1','SCNET - Rockhill',false},
			{'0xc2','SCNET - Hargray',false},
			{'0xc3','SCNET - Palmetto Rural',false},
			{'0xc4','SCNET - Pond Branch',false},
			{'0xc8','Uhaul',false},
			{'0xc9','Freeway',false},
			{'0xd2','AT&T local',false},
			{'0xe0','NDIS',false},
			{'0xf5','Pay Per Listing',false},
			{'0xfa','Lssihi',false},
			{'0xfe','Household',false},
			{'0xff','Neustar',false}],
			{string vendor, string vendorname, boolean isDuplicateCo});
			
import ut;


export fn_master_vendor_counts(dataset(layout_gongMaster) master = File_Master, string newest_date = GetDate) := function

					Assign_VoIPs_To_Translations := join(vendor_translations, 
																							 voips,
																								left.vendor = right.vendor, 
																								transform({recordof(vendor_translations), recordof(voips) - [VoipVendorName,vendor]},
																															self.vendor := max([left.vendor, right.vendor]),
																															self.vendorname := max([left.vendorname, right.VoipVendorName]),
																															self := left, 
																															self := right), full outer);

					trimMaster_layout := record
						string recordid;
						string npa;
						string telno;
						string phone10;
						string vendor;
						string last_udt_date;
						string8 filedate;
						string fsn;
						string current_record_flag;
					end;
					
					trimMaster_layout trimMaster(File_Master mst) := TRANSFORM
							self.recordid := mst.record_id;
							self.npa := mst.telephone[1..3];
							self.telno := mst.telephone[4..10];
							self.vendor :=  if(mst.DATA_SOURCE='HH','0xfe','0xff');
							self.last_udt_date := mst.add_date;
							self.fsn := mst.company_name;
							self := mst;
					END;


					currentDate := GetDate;
					currentMonth := GetDate[1..6];
					pastMonth := if(GetDate[5..6] = '01', 
																(string)((unsigned)GetDate[1..4] - 1)+ '12' + (string)((unsigned)GetDate[7..8] + 1), 
																GetDate[1..4] + (string)intformat(((unsigned)GetDate[5..6] - 1), 2, 1) + (string)((unsigned)GetDate[7..8] + 1)); 
					past2Year := (string)((unsigned)GetDate[1..4] - 2) +  GetDate[5..8];
					
					trimmed := project(master(filedate between past2Year and currentDate), trimMaster(LEFT)); 


					Filter_TrimMaster := join(
																dedup(sort(trimmed,record),record), 
																dedup(Assign_VoIPs_To_Translations, record, except vendorname, all), 
																left.vendor = right.vendor, left outer, lookup);

					// Filter_TrimMaster := TrimMaster;

					SubtractMonths(unsigned howmany) := (string)intformat((if((unsigned)GetDate[5..6] - howmany = 0, 12 - (unsigned)GetDate[5..6], (unsigned)GetDate[5..6] - howmany)), 2, 1);

					AllMaster := Filter_TrimMaster;

					calcKeepMonths(integer pMonths) := function // 2 years only

								mb := pMonths - 1;
								// if(mb > 23, fail('Keep Months Greater than 24'));

								gm := (string)intformat(map(mb - (integer)GetDate[5..6] = 0 => 12,
														mb - (integer)GetDate[5..6] < 0 => (integer)GetDate[5..6] - mb,
														mb - (integer)GetDate[5..6] = 12 => 12,
														mb - (integer)GetDate[5..6] < 12 => 12 - (mb - (integer)GetDate[5..6]),
														12 - ((mb - (integer)GetDate[5..6]) - 12)), 2, 1);


								gy := (string)map((integer)GetDate[5..6] - mb > 0 => (integer)GetDate[1..4],
													(integer)GetDate[5..6] - mb > -12 => (integer)GetDate[1..4] - 1,
													(integer)GetDate[1..4] - 2);

					return gy+gm;
					end;


					calcKeepDays(integer pDays) := function // 2 years only

					db := pdays - 1;

					year := (integer4)((string)Newest_Date[1..4]);
					month := (integer4)((string)Newest_Date[5..6]);
					day := (integer4)((string)Newest_Date[7..8]);
								
					//DayOfYear := ut.DayOfYear(year,month,day);
					DayOfYear := Std.date.DayOfYear((integer)Newest_Date);

					NewDayOfYear := map(DayOfYear - db <= 0 => 365 + (DayOfYear - db),
															DayOfYear - db);
					NewYear := map(DayOfYear - db <= 0 => year - 1,
															year);
					NewDate := ut.Date_YYYYDayOfYr(NewYear, NewDayOfYear);

					return NewDate;
					end;

					tbByMonth := table(AllMaster(filedate between past2Year and currentDate), 
																				 {string5 vendor := vendor,
																					string20 vendorname := vendorname,
																					total := count(group),
																					string8 Month01   := max(group,calcKeepMonths(1) ),
																					Month01Back := count(group, filedate[1..6] = calcKeepMonths(1) ),
																					Month01BackDisc := count(group, filedate[1..6] = calcKeepMonths(1) and current_record_flag <> 'Y'),
																					string8 Month02   := max(group,calcKeepMonths(2) ),
																					Month02Back := count(group, filedate[1..6] = calcKeepMonths(2) ),
																					Month02BackDisc := count(group, filedate[1..6] = calcKeepMonths(2) and current_record_flag <> 'Y'),
																					string8 Month03   := max(group,calcKeepMonths(3) ),
																					Month03Back := count(group, filedate[1..6] = calcKeepMonths(3) ),
																					Month03BackDisc := count(group, filedate[1..6] = calcKeepMonths(3) and current_record_flag <> 'Y'),
																					string8 Month04   := max(group,calcKeepMonths(4) ),
																					Month04Back := count(group, filedate[1..6] = calcKeepMonths(4) ),
																					Month04BackDisc := count(group, filedate[1..6] = calcKeepMonths(4) and current_record_flag <> 'Y'),
																					string8 Month05   := max(group,calcKeepMonths(5) ),
																					Month05Back := count(group, filedate[1..6] = calcKeepMonths(5) ),
																					Month05BackDisc := count(group, filedate[1..6] = calcKeepMonths(5) and current_record_flag <> 'Y'),
																					string8 Month06   := max(group,calcKeepMonths(6) ),
																					Month06Back := count(group, filedate[1..6] = calcKeepMonths(6) ),
																					Month06BackDisc := count(group, filedate[1..6] = calcKeepMonths(6) and current_record_flag <> 'Y'),
																					string8 Month07   := max(group,calcKeepMonths(7) ),
																					Month07Back := count(group, filedate[1..6] = calcKeepMonths(7) ),
																					Month07BackDisc := count(group, filedate[1..6] = calcKeepMonths(7) and current_record_flag <> 'Y'),
																					string8 Month08   := max(group,calcKeepMonths(8) ),
																					Month08Back := count(group, filedate[1..6] = calcKeepMonths(8) ),
																					Month08BackDisc := count(group, filedate[1..6] = calcKeepMonths(8) and current_record_flag <> 'Y'),
																					string8 Month09   := max(group,calcKeepMonths(9) ),
																					Month09Back := count(group, filedate[1..6] = calcKeepMonths(9) ),
																					Month09BackDisc := count(group, filedate[1..6] = calcKeepMonths(9) and current_record_flag <> 'Y'),
																					string8 Month10   := max(group,calcKeepMonths(10) ),
																					Month10Back := count(group, filedate[1..6] = calcKeepMonths(10) ),
																					Month10BackDisc := count(group, filedate[1..6] = calcKeepMonths(10) and current_record_flag <> 'Y'),
																					string8 Month11   := max(group,calcKeepMonths(11) ),
																					Month11Back := count(group, filedate[1..6] = calcKeepMonths(11) ),
																					Month11BackDisc := count(group, filedate[1..6] = calcKeepMonths(11) and current_record_flag <> 'Y'),
																					string8 Month12   := max(group,calcKeepMonths(12) ),
																					Month12Back := count(group, filedate[1..6] = calcKeepMonths(12) ),
																					Month12BackDisc := count(group, filedate[1..6] = calcKeepMonths(12) and current_record_flag <> 'Y'),
																					string8 Month13   := max(group,calcKeepMonths(13) ),
																					Month13Back := count(group, filedate[1..6] = calcKeepMonths(13) ),
																					Month13BackDisc := count(group, filedate[1..6] = calcKeepMonths(13) and current_record_flag <> 'Y'),
																					string8 Month14   := max(group,calcKeepMonths(14) ),
																					Month14Back := count(group, filedate[1..6] = calcKeepMonths(14) ),
																					Month14BackDisc := count(group, filedate[1..6] = calcKeepMonths(14) and current_record_flag <> 'Y'),
																					string8 Month15   := max(group,calcKeepMonths(15) ),
																					Month15Back := count(group, filedate[1..6] = calcKeepMonths(15) ),
																					Month15BackDisc := count(group, filedate[1..6] = calcKeepMonths(15) and current_record_flag <> 'Y'),
																					string8 Month16   := max(group,calcKeepMonths(16) ),
																					Month16Back := count(group, filedate[1..6] = calcKeepMonths(16) ),
																					Month16BackDisc := count(group, filedate[1..6] = calcKeepMonths(16) and current_record_flag <> 'Y'),
																					string8 Month17   := max(group,calcKeepMonths(17) ),
																					Month17Back := count(group, filedate[1..6] = calcKeepMonths(17) ),
																					Month17BackDisc := count(group, filedate[1..6] = calcKeepMonths(17) and current_record_flag <> 'Y'),
																					string8 Month18   := max(group,calcKeepMonths(18) ),
																					Month18Back := count(group, filedate[1..6] = calcKeepMonths(18) ),
																					Month18BackDisc := count(group, filedate[1..6] = calcKeepMonths(18) and current_record_flag <> 'Y'),
																					string8 Month19   := max(group,calcKeepMonths(19) ),
																					Month19Back := count(group, filedate[1..6] = calcKeepMonths(19) ),
																					Month19BackDisc := count(group, filedate[1..6] = calcKeepMonths(19) and current_record_flag <> 'Y'),
																					string8 Month20   := max(group,calcKeepMonths(20) ),
																					Month20Back := count(group, filedate[1..6] = calcKeepMonths(20) ),
																					Month20BackDisc := count(group, filedate[1..6] = calcKeepMonths(20) and current_record_flag <> 'Y'),
																					string8 Month21   := max(group,calcKeepMonths(21) ),
																					Month21Back := count(group, filedate[1..6] = calcKeepMonths(21) ),
																					Month21BackDisc := count(group, filedate[1..6] = calcKeepMonths(21) and current_record_flag <> 'Y'),
																					string8 Month22   := max(group,calcKeepMonths(22) ),
																					Month22Back := count(group, filedate[1..6] = calcKeepMonths(22) ),
																					Month22BackDisc := count(group, filedate[1..6] = calcKeepMonths(22) and current_record_flag <> 'Y'),
																					string8 Month23   := max(group,calcKeepMonths(23) ),
																					Month23Back := count(group, filedate[1..6] = calcKeepMonths(23) ),
																					Month23BackDisc := count(group, filedate[1..6] = calcKeepMonths(23) and current_record_flag <> 'Y'),
																					string8 Month24   := max(group,calcKeepMonths(24) ),
																					Month24Back := count(group, filedate[1..6] = calcKeepMonths(24) ),
																					Month24BackDisc := count(group, filedate[1..6] = calcKeepMonths(24) and current_record_flag <> 'Y')
																					}, vendor, vendorname, few);

					tbByDay := table(AllMaster(filedate between pastMonth and currentDate), 
																				 {string5 vendor := vendor,
																					string20 vendorname := vendorname,
																					total := count(group),															string8 Day01   := max(group,calcKeepDays(1) ),
																					Day01Back := count(group, filedate = calcKeepDays(1) ),
																					Day01BackDisc := count(group, filedate = calcKeepDays(1) and current_record_flag <> 'Y'),
																				string8 Day02   := max(group,calcKeepDays(2) ),
																					Day02Back := count(group, filedate = calcKeepDays(2) ),
																					Day02BackDisc := count(group, filedate = calcKeepDays(2) and current_record_flag <> 'Y'),
																				string8 Day03   := max(group,calcKeepDays(3) ),
																					Day03Back := count(group, filedate = calcKeepDays(3) ),
																					Day03BackDisc := count(group, filedate = calcKeepDays(3) and current_record_flag <> 'Y'),
																				string8 Day04   := max(group,calcKeepDays(4) ),
																					Day04Back := count(group, filedate = calcKeepDays(4) ),
																					Day04BackDisc := count(group, filedate = calcKeepDays(4) and current_record_flag <> 'Y'),
																				string8 Day05   := max(group,calcKeepDays(5) ),
																					Day05Back := count(group, filedate = calcKeepDays(5) ),
																					Day05BackDisc := count(group, filedate = calcKeepDays(5) and current_record_flag <> 'Y'),
																				string8 Day06   := max(group,calcKeepDays(6) ),
																					Day06Back := count(group, filedate = calcKeepDays(6) ),
																					Day06BackDisc := count(group, filedate = calcKeepDays(6) and current_record_flag <> 'Y'),
																				string8 Day07   := max(group,calcKeepDays(7) ),
																					Day07Back := count(group, filedate = calcKeepDays(7) ),
																					Day07BackDisc := count(group, filedate = calcKeepDays(7) and current_record_flag <> 'Y'),
																				string8 Day08   := max(group,calcKeepDays(8) ),
																					Day08Back := count(group, filedate = calcKeepDays(8) ),
																					Day08BackDisc := count(group, filedate = calcKeepDays(8) and current_record_flag <> 'Y'),
																				string8 Day09   := max(group,calcKeepDays(9) ),
																					Day09Back := count(group, filedate = calcKeepDays(9) ),
																					Day09BackDisc := count(group, filedate = calcKeepDays(9) and current_record_flag <> 'Y'),
																				string8 Day10   := max(group,calcKeepDays(10) ),
																					Day10Back := count(group, filedate = calcKeepDays(10) ),
																					Day10BackDisc := count(group, filedate = calcKeepDays(10) and current_record_flag <> 'Y'),
																				string8 Day11   := max(group,calcKeepDays(11) ),
																					Day11Back := count(group, filedate = calcKeepDays(11) ),
																					Day11BackDisc := count(group, filedate = calcKeepDays(11) and current_record_flag <> 'Y'),
																				string8 Day12   := max(group,calcKeepDays(12) ),
																					Day12Back := count(group, filedate = calcKeepDays(12) ),
																					Day12BackDisc := count(group, filedate = calcKeepDays(12) and current_record_flag <> 'Y'),
																				string8 Day13   := max(group,calcKeepDays(13) ),
																					Day13Back := count(group, filedate = calcKeepDays(13) ),
																					Day13BackDisc := count(group, filedate = calcKeepDays(13) and current_record_flag <> 'Y'),
																				string8 Day14   := max(group,calcKeepDays(14) ),
																					Day14Back := count(group, filedate = calcKeepDays(14) ),
																					Day14BackDisc := count(group, filedate = calcKeepDays(14) and current_record_flag <> 'Y'),
																				string8 Day15   := max(group,calcKeepDays(15) ),
																					Day15Back := count(group, filedate = calcKeepDays(15) ),
																					Day15BackDisc := count(group, filedate = calcKeepDays(15) and current_record_flag <> 'Y'),
																				string8 Day16   := max(group,calcKeepDays(16) ),
																					Day16Back := count(group, filedate = calcKeepDays(16) ),
																					Day16BackDisc := count(group, filedate = calcKeepDays(16) and current_record_flag <> 'Y'),
																				string8 Day17   := max(group,calcKeepDays(17) ),
																					Day17Back := count(group, filedate = calcKeepDays(17) ),
																					Day17BackDisc := count(group, filedate = calcKeepDays(17) and current_record_flag <> 'Y'),
																				string8 Day18   := max(group,calcKeepDays(18) ),
																					Day18Back := count(group, filedate = calcKeepDays(18) ),
																					Day18BackDisc := count(group, filedate = calcKeepDays(18) and current_record_flag <> 'Y'),
																				string8 Day19   := max(group,calcKeepDays(19) ),
																					Day19Back := count(group, filedate = calcKeepDays(19) ),
																					Day19BackDisc := count(group, filedate = calcKeepDays(19) and current_record_flag <> 'Y'),
																				string8 Day20   := max(group,calcKeepDays(20) ),
																					Day20Back := count(group, filedate = calcKeepDays(20) ),
																					Day20BackDisc := count(group, filedate = calcKeepDays(20) and current_record_flag <> 'Y'),
																				string8 Day21   := max(group,calcKeepDays(21) ),
																					Day21Back := count(group, filedate = calcKeepDays(21) ),
																					Day21BackDisc := count(group, filedate = calcKeepDays(21) and current_record_flag <> 'Y'),
																				string8 Day22   := max(group,calcKeepDays(22) ),
																					Day22Back := count(group, filedate = calcKeepDays(22) ),
																					Day22BackDisc := count(group, filedate = calcKeepDays(22) and current_record_flag <> 'Y'),
																				string8 Day23   := max(group,calcKeepDays(23) ),
																					Day23Back := count(group, filedate = calcKeepDays(23) ),
																					Day23BackDisc := count(group, filedate = calcKeepDays(23) and current_record_flag <> 'Y'),
																				string8 Day24   := max(group,calcKeepDays(24) ),
																					Day24Back := count(group, filedate = calcKeepDays(24) ),
																					Day24BackDisc := count(group, filedate = calcKeepDays(24) and current_record_flag <> 'Y'),
																				string8 Day25   := max(group,calcKeepDays(25) ),
																					Day25Back := count(group, filedate = calcKeepDays(25) ),
																					Day25BackDisc := count(group, filedate = calcKeepDays(25) and current_record_flag <> 'Y'),
																				string8 Day26   := max(group,calcKeepDays(26) ),
																					Day26Back := count(group, filedate = calcKeepDays(26) ),
																					Day26BackDisc := count(group, filedate = calcKeepDays(26) and current_record_flag <> 'Y'),
																				string8 Day27   := max(group,calcKeepDays(27) ),
																					Day27Back := count(group, filedate = calcKeepDays(27) ),
																					Day27BackDisc := count(group, filedate = calcKeepDays(27) and current_record_flag <> 'Y'),
																				string8 Day28   := max(group,calcKeepDays(28) ),
																					Day28Back := count(group, filedate = calcKeepDays(28) ),
																					Day28BackDisc := count(group, filedate = calcKeepDays(28) and current_record_flag <> 'Y'),
																				string8 Day29   := max(group,calcKeepDays(29) ),
																					Day29Back := count(group, filedate = calcKeepDays(29) ),
																					Day29BackDisc := count(group, filedate = calcKeepDays(29) and current_record_flag <> 'Y'),
																				string8 Day30   := max(group,calcKeepDays(30) ),
																					Day30Back := count(group, filedate = calcKeepDays(30) ),
																					Day30BackDisc := count(group, filedate = calcKeepDays(30) and current_record_flag <> 'Y')
																					}, vendor, vendorname, few);

return parallel(
						output('filedate between ' + past2Year + ' and ' + currentDate),
						output(choosen(trimmed,50)),
						output(sort(tbByMonth, vendor), named('Master_By_Month'));
						output(sort(tbByDay, vendor), named('Master_By_Day')));
end;
			
end;