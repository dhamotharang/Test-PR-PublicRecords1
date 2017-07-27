/*

This common function is called by:

AddressHistory_Service and
AddressHistory_Batch_Service

*/

export AddressHistory_Common(dataset(didville.Layout_Did_OutBatch) infile,
                             boolean GLBin, 
														 boolean DPPAin,
														 unsigned4 maxrecordstoreturnIN,
														 boolean bestaddressIN,
														 string32 appType) := function

import AutoStandardI, address, doxie, header, mdr;

dedup_these := false;
appends     := 'BEST_ALL';

// Always do Fuzzy DID'ing
fz := 'Z4G';

didville.MAC_DidAppend(infile,resu,dedup_these,fz)

didville.MAC_HHid_Append(resu,appends,resu_out)

resu0 := if (stringlib.stringfind(appends,'HHID_',1)=0,resu,resu_out);

IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(resu0,
											 appends,
											 '',
											 0,
											 glbin,
											 resu2,
											 false,
											 doxie.DataRestriction.fixed_DRM,
											 ,
											 ,
											 ,
											 ,
											 appType,
											 ,
											 IndustryClass)

//Sort by sequence in case this is going to be the return dataset
//resu3 := sort(resu2, seq);

res   := resu2(did <> 0);  //Remove any dodgy records with 0 dids

AHistLayoutv2 := RECORD
	unsigned6   sequence := 0;
	unsigned6   seq;  //Input sequence - needed when batched input is used
	unsigned6   did;
	unsigned3   dt_first_seen; 
	unsigned3   dt_last_seen;
	string10    phone;
	string5     title;
	string20    fname;
	string20    mname;
	string20    lname;
	string5     name_suffix;
	string64    addr1;   
	string25    city_name;
	string2     st;
	string5     zip;
	string4     zip4;
	string1     tnt := ' ';
	unsigned3   dt_nonglb_last_seen;
	string2     src;
	string120   listed_name;
	string10    listed_phone;
	unsigned3   dt_max_seen;	
END;

AHistLayoutv2 AssembleHistory(res l, doxie.Key_Header r) := transform
  self.addr1        := address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name, r.suffix, r.postdir, r.unit_desig, r.sec_range);
	self.dt_last_seen := MAP( ~GLBin => r.dt_nonglb_last_seen, r.dt_last_seen <> 0 => r.dt_last_seen, 0); 
	self.dt_max_seen  := 0;
	self.seq          := l.seq;
	self              := r;
end; 

//Retrieve History records into new new record layout
fixed_DRM := doxie.DataRestriction.fixed_DRM;
AHist := join(res, doxie.Key_Header, keyed(left.did = right.s_did) and
		~Doxie.DataRestriction.isHeaderSourceRestricted(right.src,fixed_DRM),
		AssembleHistory(left, right));

//output(doxie.Key_Header);

//Now check for GLB and DPPA access restrictions
AHistLayoutv2  CheckForGLB_DPPA(AHistLayoutv2 l) := transform, 
               skip((mdr.source_is_DPPA(l.src) and DPPAin = false) or (~header.isPreGLB(l) and GLBin = false))
  self := l;  
end;

//Only perform CheckForGLB_DPPA if needed
//AHistGLB_DPPA_Checked := if(BestAddress = false, project(AHist, CheckForGLB_DPPA(left)), AHist);

AHistGLB_DPPA_Checked := project(AHist, CheckForGLB_DPPA(left));


//Get ready for rollup
AHistSort1 := sort(AHistGLB_DPPA_Checked, addr1, city_name, st, zip, -listed_name);


AHistLayoutv2 GetBestValues(AHistLayoutv2 l, AHistLayoutv2 r) := transform
  self.dt_first_seen := if(l.dt_first_seen <= r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);  //Prefer the lowest
	self.dt_last_seen  := if(l.dt_last_seen >= 0, l.dt_last_seen, r.dt_last_seen );  //Prefer the highest
  self               := if(l.zip4 = '', r, l);  //Prefer the one with zip4, if any	
end;

//Use rollup instead of dedup because we want to decide which record to throw away
AHist2 := rollup(AHistSort1, getBestValues(left, right), seq, addr1, city_name, st, zip);

//Set dt_max_seen
AHistLayoutv2 SetMaxSeen(AHistLayoutv2 l) := transform
	self.dt_max_seen := if(l.dt_first_seen >= l.dt_last_seen, l.dt_first_seen, l.dt_last_seen);  
  self             := l;	
end;

//Calculate max_seen for later use in sorting
MaxSeen := project(AHist2, SetMaxSeen(Left)); 
//output(MaxSeen);


//Use this function for sorting
tnt_score(string1 c) := CASE(c,
                        'B' => 1,            // Best
                        'V' => 1,            // Verified
                        'C' => 2,            // Current
                        'P' => 3,            // Probable
                        'R' => 4,            // Relative's Address
												5);                  // Historical


//Sort primarily on tnt and max seen
AHist3 := sort(MaxSeen, tnt_score(tnt), -dt_max_seen, title, fname, mname, lname, name_suffix, addr1, city_name, st, zip, zip4, sequence);

//Return Max records, if specified
AHist4 := if(MaxRecordsToReturnIn > 0, topn(AHist3, MaxRecordsToReturnIn, tnt_score(tnt), -dt_max_seen, title, fname, mname, lname, name_suffix, addr1, city_name, st, zip, zip4), AHist3); 

AHistLayoutv2 AssembleHistory2(res l) := transform
	self.dt_first_seen       := l.first_seen;
	self.dt_last_seen        := l.best_addr_date;
	self.phone               := l.best_phone;
	self.title               := l.best_title;
	self.fname               := l.best_fname;
	self.mname               := l.best_mname;
	self.lname               := l.best_lname;
	self.name_suffix         := l.best_name_suffix;
  self.addr1               := l.best_addr1; 
	self.city_name           := l.best_city;
	self.zip                 := l.best_zip;
	self.zip4                := l.best_zip4;
	self.st                  := l.best_state;
	self.tnt                 := 'C';
	self.dt_nonglb_last_seen := 0;   //Best already considers GLB
	self.src                 := '';  //Best does not use DPPA data 
	self.dt_max_seen         := 0;   //Don't need max_seen for a single record
	self.listed_name         := '';  //Ditto
	self.listed_phone        := '';  //Ditto
  self                     := l;	
end; 

//Return Best record or multiple records
AHist5 := if(BestAddressIn = false, AHist4, project(res, AssembleHistory2(left))); 


//Strip out the two fields that were used for GLB/DPPA checking
DidVille.AddressHistory_Layout_OutBatch StripFieldsAndSequence(AHistLayoutv2 l, integer c) := transform
  self.sequence := c;
	self          := l;
end;  

AHist6 := project(AHist5, StripFieldsAndSequence(left, counter));

//We want seq to be the primary sort
//outfile := sort(AHist6, seq, sequence); 

return AHist6;


END;  //FUNCTION