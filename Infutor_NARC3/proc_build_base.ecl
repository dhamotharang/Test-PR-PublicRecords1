
import ut, _validate, NID, AID, address, std, did_add, VersionControl;

EXPORT proc_build_base(string	pVersion,BOOLEAN	pUseProd	=	FALSE) := function

	filename :=  Filenames(pVersion,pUseProd).Input.WithdrawnStatus.Using;
	
	FileLogical := dataset(filename,Infutor_NARC3.Layout_Infile,csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['"'])));	
  
  dedup_FileLogical := dedup(sort(FileLogical,record),record);	
	
Infutor_NARC3.Layout_Basefile		tMapping(dedup_FileLogical L) := TRANSFORM
		SELF.Date_vendor_first_reported := (unsigned)pVersion;
		SELF.Date_vendor_last_reported 	:= (unsigned)pVersion;
		SELF.date_first_seen := '0';  //Blank dates are acceptable since raw data does not 
    SELF.date_last_seen := '0';   //present any supporting evidence of first and last seen dates
		SELF.clean_phone 								:= if(ut.CleanPhone(L.orig_TelephoneNumber_1) [1] not in ['0','1'],ut.CleanPhone(L.orig_TelephoneNumber_1), '') ;
		SELF.clean_dob 									:= if(L.orig_dob <> '', _validate.date.fCorrectedDateString(L.orig_dob,false), '');
		SELF.record_type								:= 'C';  
		self.src := 'XX';
		SELF  :=  L;
		SELF 	:= [];
	END;

std_input := project(dedup_FileLogical, tMapping(LEFT));


//Clean Name 
NID.Mac_CleanParsedNames(std_input, cleanNames0
		, firstname:=orig_FNAME,middlename:=orig_mname,lastname:=orig_LNAME,namesuffix:=orig_SUFFIX
		, includeInRepository:=true, normalizeDualNames:=false,useV2:=true
		);
		
cleanNames := cleanNames0(nametype='P');

cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string orig_addr1, string orig_addr2},

																							self.orig_addr1 := trim(stringlib.stringfilterout(left.orig_ADDRESS,'.^!$+<>@=%?*\''), left, right),			
																							self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																																					trim(left.orig_city)
																																					+  if(left.orig_city <> '',',','')
																																					+ ' '+ left.orig_state
																																					+ ' '+ if(length(trim(left.orig_zip[..5],all)) = 5,
																																										left.orig_zip[..5],''))
																																											,left,right),
																							self := left));			


																		
//unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;
AID.MacAppendFromRaw_2Line(cleanNames_t,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

Infutor_NARC3.Layout_Basefile 		tr(cleanAddr l) := TRANSFORM
		self.title 				:= IF(l.cln_title IN ['MR', 'MS'], l.cln_title, '');
		self.fname 				:= l.cln_fname;
		self.mname 				:= l.cln_mname;
		self.lname 				:= l.cln_lname;
		self.name_suffix 	:= l.cln_suffix;
		self.RawAID     	:= l.aidwork_rawaid;
		self.prim_range 	:= l.aidwork_acecache.prim_range;
		self.predir      	:= l.aidwork_acecache.predir;
		self.addr_suffix  := l.aidwork_acecache.addr_suffix;
		self.postdir     	:= l.aidwork_acecache.postdir;
		self.unit_desig  	:= l.aidwork_acecache.unit_desig;
		self.sec_range   	:= stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
		self.v_city_name 	:= if(length(std.str.filterout(std.str.ToUpperCase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
		self.p_city_name 	:= if(length(std.str.filterout(std.str.ToUpperCase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
		self.zip4        	:= l.aidwork_acecache.zip4;
		SELF.cart       	:= l.aidwork_acecache.cart;
		SELF.cr_sort_sz 	:= l.aidwork_acecache.cr_sort_sz;
		SELF.lot        	:= l.aidwork_acecache.lot;
		SELF.lot_order  	:= l.aidwork_acecache.lot_order;
		SELF.chk_digit  	:= l.aidwork_acecache.chk_digit;
		SELF.rec_type   	:= l.aidwork_acecache.rec_type;
		self.st          	:= l.aidwork_acecache.st;
		self.fips_st     	:= l.aidwork_acecache.county[1..2];
		self.fips_county 	:= l.aidwork_acecache.county[3..5];
		SELF.geo_lat    	:= l.aidwork_acecache.geo_lat;
		SELF.geo_long   	:= l.aidwork_acecache.geo_long;
		self.msa         	:= if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
		SELF.geo_blk    	:= l.aidwork_acecache.geo_blk;
		SELF.geo_match  	:= l.aidwork_acecache.geo_match;
		SELF.err_stat   	:= l.aidwork_acecache.err_stat;
		SELF.prim_name  	:= std.str.filterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
    SELF.Zip         	:= L.aidwork_acecache.zip5;
    SELF.dbpc       	:= l.aidwork_acecache.dbpc;
		self:=l;
			END;

cleanAdd_t := project(cleanAddr,tr(left));

//Appending DID
	matchset := ['A','Z','D','P'];
	
	did_add.MAC_Match_Flex(cleanAdd_t, matchset,					
													foo,clean_dob, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip, st,clean_phone, 
													DID, Infutor_NARC3.Layout_Basefile, true, did_score,
													75, d_did
												  );
												
							 
  //////d_did is outpout

  	
  todays_processed_file := dataset(infutor_narc3.Filenames(pVersion).Base.WithdrawnStatus.new,infutor_narc3.Layout_Basefile,thor); 
 
	current_base := dedup(sort(Infutor_NARC3.Files.base,record),record);
	
	//Ingest todays_processed_file into current_base to get new_base
	base_with_tag := Infutor_NARC3.Ingest(false,,current_base,todays_processed_file);
	
	new_base :=  base_with_tag.AllRecords;	
	
  add_record_type	:= Project(new_base, TRANSFORM(Infutor_NARC3.Layout_Basefile, 
																								   self.record_type := left.__Tpe;
																								   self := left;
																									 self:= [];));
	
	//Need to output new base before base_with_tag.Dostats can be called. 
  VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.WithdrawnStatus.new	,add_record_type, build_logical_file,true);									 	
	
  return sequential(build_logical_file,
	                  base_with_tag.Dostats										
				           );		
									 
end;
 
									 

