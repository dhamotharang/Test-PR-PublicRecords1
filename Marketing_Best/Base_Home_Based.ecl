import Business_header, Address_File;

export Base_Home_Based(

	 dataset(marketing_Best.Layout_Common			) inDataSet
	,string																			fileDesc
	,dataset(Business_header.Layout_BH_Best		) pBH_Best						= Business_header.Files().Base.Business_Header_Best.built
	,dataset(Address_file.Layout_address_file	) pAddressId					= Address_File.File_AddressID
	,string																			pPersistName				= '~thor_data400::persist::Marketing_best::Base_Home_Based.'

) := 
function

ds_bus_header_best := distribute(pBH_Best(bdid <> 0),hash32(bdid));

ds_marketing_best  := distribute(BestJoined(inDataSet,fileDesc),hash32(bdid));

Layout_MrkBest_with_Addr := record
  Marketing_best.Layout_Best;
	string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   suffix;
  string2   postdir;
  string10  unit_desig;
  string8   sec_range;
  string25  city_name;
  string2   st;
  string5   zip;
  string4   zip4;
end;

Layout_MrkBest_with_Addr trfAddress(ds_marketing_best l, ds_bus_header_best r) := transform
	self.prim_range := trim(r.prim_range,left,right);
  self.predir 	  := trim(r.predir,left,right);
  self.prim_name  := trim(r.prim_name,left,right);
  self.suffix     := trim(r.addr_suffix,left,right);
  self.postdir    := trim(r.postdir,left,right);
  self.unit_desig := trim(r.unit_desig,left,right);
  self.sec_range  := trim(r.sec_range,left,right);
  self.city_name  := trim(r.city,left,right);
  self.st         := trim(r.state,left,right);
  self.zip        := if (r.zip  = 0, '', (string)r.zip);
  self.zip4       := if (r.zip4 = 0, '', (string)r.zip4);
  self            := l;
end;

ds_AddrBdid := join(ds_marketing_best, ds_bus_header_best, 
										left.bdid = right.bdid,
                    trfAddress(left,right),left outer,local);


Layout_Mrk_Best := Marketing_Best.Layout_Best;

ds_AddrBdid_fil := ds_AddrBdid(trim(prim_name,left,right) <> '' and
															 trim(zip,left,right) <> '');
																
ds_AddrBdid_emp := ds_AddrBdid(trim(prim_name,left,right) = '' or
															 trim(zip,left,right) = '');


Layout_Mrk_Best trfSlim(ds_AddrBdid_emp l) := transform
 self := l;
end;

ds_AddrBdid_slim := project(ds_AddrBdid_emp, trfSlim(left));

dis_ds_AddrBdid := distribute(ds_AddrBdid_fil, hash32(prim_range, prim_name, suffix, predir, postdir, unit_desig, sec_range, zip));

ds_AddrFile := pAddressId(trim(resident_flag,left,right) = 'Y' and
																					 trim(business_flag,left,right) = 'Y' and
																					 trim(prim_name,left,right) <> ''  and 
                                           trim(zip,left,right) <> '');

dis_ds_AddrFile := distribute(ds_AddrFile, hash32(prim_range, prim_name, suffix, predir, postdir, unit_desig, sec_range, zip));



Layout_Mrk_Best getHomeBased(dis_ds_AddrBdid l, dis_ds_AddrFile r) := transform
	 self.home_based_flag := if(trim(r.resident_flag,left,right) = 'Y' and 
															trim(r.business_flag,left,right) = 'Y', 'Y','');
	 self := l;	
end;

ds_homebased := join(dis_ds_AddrBdid, dis_ds_AddrFile, 
								  trim(left.prim_range,left,right) = trim(right.prim_range,left,right) and
								 (trim(left.prim_name,left,right)  = trim(right.prim_name,left,right) and
									trim(left.prim_name,left,right)  <> '') and
									trim(left.suffix,left,right)     = trim(right.suffix,left,right) and
									trim(left.predir,left,right)     = trim(right.predir,left,right) and
									trim(left.postdir,left,right)    = trim(right.postdir,left,right) and
									trim(left.unit_desig,left,right) = trim(right.unit_desig,left,right) and
									trim(left.sec_range,left,right)  = trim(right.sec_range,left,right) and
									//trim(left.city_name,left,right)  = trim(right.city_name,left,right) and
									//Strim(left.st,left,right)         = trim(right.st,left,right) and
								 (trim(left.zip,left,right)        = trim(right.zip,left,right) and
									trim(left.zip,left,right) <> ''),
									getHomeBased(left,right),left outer, local);

srt_ds_homebased := sort(distribute(ds_homebased + ds_AddrBdid_slim, hash32(bdid)),bdid,local);

resultsOut := srt_ds_homebased : persist(pPersistName+fileDesc);
									
return resultsOut;
end;

