/*2016-09-22T23:10:04Z (Wendy Ma)

*/
import Header,FCRA_list,Watercraft;

export Watercraft_as_Header(dataset(Watercraft.Layout_Watercraft_Search_Base) pWatercraftSearch = dataset([],Watercraft.Layout_Watercraft_Search_Base),
							dataset(Watercraft.Layout_Watercraft_Main_Base) pWatercraftMain = dataset([],Watercraft.Layout_Watercraft_Main_Base),
							dataset(Watercraft.Layout_Watercraft_CoastGuard_Base) pWatercraftCG = dataset([],Watercraft.Layout_Watercraft_CoastGuard_Base),
							boolean pForHeaderBuild=false,
							boolean pForFCRAHeaderBuild=false,
							boolean IsPRCT = false
							)
 :=
  function
	dWatercraftAsSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().WA,
	                         Watercraft.Watercraft_as_Source(pWatercraftSearch,pWatercraftMain,pWatercraftCG,pForHeaderBuild,pForFCRAHeaderBuild));

	unsigned3 fYYYYMMIntegerFromDate(string pDateIn)
	 :=
	  (unsigned3)(string6)pDateIn;
	 ;

	Header.Layout_New_Records	tWatercraftToHeader(dWatercraftAsSource pInput)
	 :=
	  transform
		self.did						:= IF(pForFCRAHeaderBuild, (unsigned6)pInput.did,
															IF(IsPRCT,(unsigned6)pInput.did, 0));
		self.rid						:= IF(pForFCRAHeaderBuild, pInput.UID, 0);
		self.src						:= Watercraft.Header_Source_Code(pInput.Source_Code, pInput.State_Origin);
		self.dt_first_seen				:= fYYYYMMIntegerFromDate(pInput.Date_First_Seen);
		self.dt_last_seen				:= fYYYYMMIntegerFromDate(pInput.Date_Last_Seen);
		self.dt_vendor_last_reported	:= fYYYYMMIntegerFromDate(pInput.Date_Vendor_Last_Reported);
		self.dt_vendor_first_reported 	:= fYYYYMMIntegerFromDate(pInput.Date_Vendor_First_Reported);
		self.dt_nonglb_last_seen  		:= fYYYYMMIntegerFromDate(pInput.Date_Last_Seen);
		self.rec_type 					:= if(pInput.History_Flag='','1','2');
		self.ssn						:= pInput.Orig_SSN;
		self.dob						:= (integer)pInput.DOB;
		self.title						:= pInput.title;
		self.fname						:= pInput.fname;
		self.mname						:= pInput.mname;
		self.lname						:= pInput.lname;
		self.name_suffix				:= pInput.name_suffix;
		self.prim_range					:= pInput.prim_range;
		self.predir						:= pInput.predir;
		self.prim_name					:= pInput.prim_name;
		self.suffix						:= pInput.suffix;
		self.postdir					:= pInput.postdir;
		self.unit_desig					:= pInput.unit_desig;
		self.sec_range					:= pInput.sec_range;
		self.city_name					:= pInput.v_city_name;
		self.st							:= pInput.st;
		self.zip						:= pInput.zip5;
		self.zip4						:= pInput.zip4;
		self.county						:= pInput.county;
		self.cbsa						:= '';
		self.geo_blk					:= pInput.geo_blk;
		self.phone						:= pInput.phone_1;
		self.vendor_id					:= pInput.Watercraft_Key;
		self := pinput;
	  end
	 ;

	Watercraft_in := IF(pForFCRAHeaderBuild,
dedup(sort(distribute(project(dWatercraftAsSource,tWatercraftToHeader(left))(src = '8W'),hash(did)),
record, except rid,uid,vendor_id,persistent_record_id, local),record, except rid, uid, vendor_id,persistent_record_id,local), 
project(dWatercraftAsSource,tWatercraftToHeader(left))(src not in ['8W','W1']));
 
    return Watercraft_in;
  end
 ;
