import aca, business_header, header, fcra, versioncontrol,paw,corp2;

export HRI_Businesses(

	 boolean	isFCRA
	,boolean	pUseDatasets	= false
	,string		pPersistname		= 'persist::Risk_Indicators::HRI_Businesses::'
	,string		pPersistUnique	= ''
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps 				= paw.fCorpInactives()
	
) := function

use_prod := versioncontrol._Flags.IsDataland;

thor_cluster := business_header._dataset().thor_cluster_Persists;

sic_code_set := ['0971','2710','2711','4311','4449','4783','4822',
                 '6515','7011','7021','7032','7033','7291','7323',
                 '7331','7334','8051','8052','8059','8062','8063'
								 ,'8082','8211','8221','8222','8231','8322','8361'
								 ,'9223','9711'];

package_set := ['73891603','73891302'];

persistrootname := thor_cluster + pPersistname + pPersistUnique;
persistname := if (isFCRA, persistrootname + 'bh_bdid_sic_FCRA', persistrootname + 'bh_bdid_sic');
uniquename := if (isFCRA, '::FCRA', '::NotFCRA');

sicunique := if(pPersistUnique = '', '', '::' + pPersistUnique[1..(length(trim(pPersistUnique)) - 2)]);

sicptname  := business_header.persistnames().BHBDIDSIC			+ sicunique;
sicFptname := business_header.persistnames().BHBDIDSICFCRA	+ sicunique;

f_bdid_sic_nonpersisted := if (isFCRA, business_header.bh_bdid_sic_FCRA(pUseDatasets := pUseDatasets,pPersistname := sicFptname,pInactiveCorps := pInactiveCorps), business_header.bh_bdid_sic(pUseDatasets := pUseDatasets,pPersistname := sicptname,pInactiveCorps := pInactiveCorps));
f_bdid_sic_persisted 		:= if (isFCRA, business_header.bh_bdid_sic_FCRA(pUseDatasets := pUseDatasets,pPersistname := sicFptname,pInactiveCorps := pInactiveCorps), business_header.bh_bdid_sic(pUseDatasets := pUseDatasets,pPersistname := sicptname,pInactiveCorps := pInactiveCorps)) : persist(persistname);
                                                                                                                                                                                                                          
f_bdid_sic	:= if(pUseDatasets	,f_bdid_sic_nonpersisted	,f_bdid_sic_persisted);

sic4_rec := record
	unsigned6 bdid;
	string2 source;
	string4 sic_code;
end;

sic4_rec get_sic4(f_bdid_sic l) := transform
	self.sic_code := if(l.sic_code[1..4] in sic_code_set or l.sic_code in package_set,
	                    l.sic_code[1..4], '');
	self := l;
end;


f_bdid_sic_slim := project(f_bdid_sic, get_sic4(left));
f_bdid_sic_valid := f_bdid_sic_slim(sic_code<>'',source<>'D');
/////////////////////
f_bdid_sic_dist := distribute(f_bdid_sic_valid,hash(bdid,sic_code));
f_bdid_sic_sort := sort(f_bdid_sic_dist,bdid,sic_code,local);
f_bdid_sic_dedup := dedup(f_bdid_sic_sort,bdid,sic_code,local);

f_bdid_dist := distribute(f_bdid_sic_dedup, hash(bdid));

bh_base := business_header.files(, use_prod).Base.business_headers.built(~isFCRA or ~fcra.Restricted_BusHeader_Src(source, vendor_id[1..2]));

layout_bh_bestphone := RECORD
	bh_base.bdid;
	bh_base.phone;
END;

dbestphonepersisted := business_header.bestphone(bh_base) : persist(persistrootname + 'BestPhone' + uniquename);

bestphone := if(pUseDatasets
							,dataset(persistrootname + 'BestPhone' + uniquename, layout_bh_bestphone ,flat)
							,dbestphonepersisted
						);

b_h_bestphone_dist := distribute(bestphone, hash(bdid));

f_sic_addr_out_1 := join(b_h_bestphone_dist, f_bdid_dist, 
                       left.bdid = right.bdid, right outer, local);

layout_bh_bestcompanyname :=
RECORD
	bh_base.bdid;
	bh_base.company_name;
END;

dBestCompanyNamePersisted := business_header.BestCompanyName(bh_base) : persist(persistrootname + 'BestCompanyName' + uniquename);

BestCompanyName := if(pUseDatasets
											,dataset(persistrootname + 'BestCompanyName' + uniquename	,layout_bh_bestcompanyname	,flat)
											,dBestCompanyNamePersisted
									);


bh_best_company_dist := distribute(BestCompanyName,random());
//////////////
f_sic_addr_out_2 := join(bh_best_company_dist, f_sic_addr_out_1, 
					left.bdid = right.bdid, right outer);

layout_bh_bestaddress := RECORD
	bh_base.bdid;
	bh_base.prim_range;
	bh_base.predir;
	bh_base.prim_name;
	QSTRING4 addr_suffix;
	bh_base.postdir;
	QSTRING5 unit_desig;
	bh_base.sec_range;
	QSTRING25 city;
	STRING2 state;
	UNSIGNED3 zip;
	UNSIGNED2 zip4;
	unsigned4 dt_last_seen;
END;

BestAddressPersisted := business_header.BestAddress(bh_base) : persist(persistrootname + 'BestAddress' + uniquename);

BestAddress := if(pUseDatasets
											,dataset(persistrootname + 'BestAddress' + uniquename	,layout_bh_bestaddress	,flat)
											,BestAddressPersisted
									);

bh_best_address_dist := distribute(BestAddress,random());

f_sic_addr_out := join (bh_best_address_dist, distribute(f_sic_addr_out_2, random()),
                        left.bdid = right.bdid,
												right outer);
						
// Get a date of the first time we saw this business
rec := RECORD
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	integer3  zip;
	integer2  zip4;
  string4   sic_code;
	unsigned3 dt_first_seen;
	string120	company_name;
	integer	phone;
	unsigned6	bdid;
	string2	source;
END;

rec get_date(Business_Header.File_Business_Header le, f_sic_addr_out ri) := TRANSFORM
	SELF.dt_first_seen := le.dt_first_seen DIV 100;
	SELF := ri;
END;

bhfile := distribute(business_header.files(,use_prod).Base.business_headers.built(~isFCRA or ~FCRA.Restricted_BusHeader_Src(source, vendor_id[1..2])) ,random());

j := JOIN (bhfile, distribute(f_sic_addr_out, random()), 
           LEFT.bdid=RIGHT.bdid,
           get_date(LEFT,RIGHT));


rec cleaner(j l) := TRANSFORM
	self.sic_code := map( l.sic_code = '0971' => '2330',
                          l.sic_code = '2710' => '2335',
					 l.sic_code = '2711' => '2335',
                          l.sic_code = '4311' => '2265', 
                          l.sic_code = '4449' => '2325',
                          l.sic_code = '4783' => '2310',
                          l.sic_code = '4822' => '2300',
                          l.sic_code = '6515' => '2285',
                          l.sic_code = '7011' => '2210',
                          l.sic_code = '7021' => '2230',
                          l.sic_code = '7032' => '2290',
                          l.sic_code = '7033' => '2215',
                          l.sic_code = '7291' => '2340',
                          l.sic_code = '7323' => '2305',
                          l.sic_code = '7331' => '2220',
                          l.sic_code = '7334' => '2280',
                          l.sic_code = '7389' => '2320',
                          l.sic_code = '8051' => '2275',
													l.sic_code = '8052' => '2384',
													l.sic_code = '8059' => '2381',
                          l.sic_code = '8062' => '2260',
                          l.sic_code = '8063' => '2315',
													l.sic_code = '8082' => '2382',
                          l.sic_code = '8211' => '2345',
                          l.sic_code = '8221' => '2270',
                          l.sic_code = '8222' => '2350',
                          l.sic_code = '8231' => '2355',
													l.sic_code = '8322' => '2383',
													l.sic_code = '8361' => '2380',
                          l.sic_code = '9223' => '2225',
                          l.sic_code = '9711' => '2295',
                          '');
	SELF := l;
END;

clean1 := PROJECT(j, cleaner(LEFT));

rec get_ACAs(recordof(aca.File_ACA_Clean()) L) := transform
	self.sic_code := '2225';
	self.zip := (integer)L.zip;
	self.zip4 := (integer)L.zip4;
	self.phone := (integer)L.phone;
	self.bdid := 0;
	self.source := 'AC';
	//self.dt_last_seen := 0;
	self.company_name := L.institution;
	//self.fein := 0;
	//self.best_flags := 0;
	//self.dppa_state := L.st;
	self.dt_first_seen := 0;
	self := l;
end;

pACAPersistname	:= '~thor_data400::persist::aca::file_aca_clean' + sicunique;

clean2 := project(aca.File_ACA_Clean(pUseDatasets := pUseDatasets, pPersistname := pACAPersistname), get_ACAs(LEFT));

return clean1 + clean2;

end;