#workunit('name', 'OutwardMedia')

import  ut,
						AID,
						DID_Add,
						header_slimsort,
						address,
						lib_StringLib;

 EXPORT Proc_Build_Base(STRING version) := FUNCTION
 valid_states :=	['AE','AP','CN','GU','ON','PR','AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
												 'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX',
												 'UT','VA','VI','VT','WA','WI','WV','WY'];
// Assigning the returned dataset from Proc_Fix_Recs to First_InputFile
 First_InputFile := Proc_Fix_Recs_01032011(Version);

Layout_FormatFields	:= Record
Recordof(First_InputFile);
AID.Common.xAID	AID;
STRING8 date_first_seen;
STRING8 date_last_seen;
STRING8 date_vendor_first_reported;
STRING8 date_vendor_last_reported;
End;																			

Layout_FormatFields tFormatFields(First_InputFile pInput) := Transform
		Self.AID	:=	0;
		Self.date_vendor_first_reported := version;
		Self.date_vendor_last_reported  := version;
		Self.date_first_seen  := pInput.optin[1..4]+pInput.optin[6..7]+pInput.optin[9..10];
    Self.date_last_seen  := SELF.date_first_seen;
		Self	:=	pInput;
End;

InputFile := Project(First_InputFile, tFormatFields(Left));
	//Project last Basefile into Rollup layout
BaseFile := Project(OutwardMedia.Files.File_OutwardMedia_Base,  Layout_FormatFields);

 PreRollup	:=	BaseFile + InputFile;
 // PreRollupFile	:=	NewInputFile;

Layout_FormatFields tPreRollup(PreRollup L) := Transform
Self.email := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.email)), Left, Right);
Self.firstname := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.firstname)), Left, Right);
Self.lastname := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.LastName)), Left, Right);
Self.address1 := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.address1)), Left, Right);
Self.address2 := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.address2)), Left, Right);
Self.City 		:= Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.City)), Left, Right);
Self.state		:=	Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.state)), Left, Right);
Self.zip			:=	Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.zip)), Left, Right);
Self.Phone := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.Phone)), Left, Right);
Self.Ipaddress := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.Ipaddress)), Left, Right);
Self.weburl := Trim(StringLib.StringCleanSpaces(stringlib.stringtouppercase(L.weburl)), Left, Right);
Self := L;
end; 
 
 PreRollupFile := Project(PreRollup, tPreRollup(Left));
  
  Layout_FormatFields rollitup(Layout_FormatFields L, Layout_FormatFields R):=TRANSFORM
    SELF.date_first_seen:=IF(L.date_first_seen<R.date_first_seen, L.date_first_seen, R.date_first_seen);
    SELF.date_last_seen:=IF(L.date_last_seen>R.date_last_seen, L.date_last_seen, R.date_last_seen);
    SELF.date_vendor_first_reported:=IF(L.date_vendor_first_reported<R.date_vendor_first_reported, L.date_vendor_first_reported, R.date_vendor_first_reported);
    SELF.date_vendor_last_reported:=IF(L.date_vendor_last_reported>R.date_vendor_last_reported, L.date_vendor_last_reported, R.date_vendor_last_reported);
    SELF:=IF(L.date_vendor_last_reported > R.date_vendor_last_reported, L, R);
		SELF	:=	L;
		SELF	:=	[];
  END;
  BOOLEAN basefileexists:=fileservices.GetSuperFileSubCount('~thor400::base::OutwardMedia')>0;
	PreRollupFileDist	:=	DISTRIBUTE(PreRollupFile, HASH32(email,firstname,lastname));
  PreRollupFileSort :=	SORT(PreRollupFileDist, email,firstname,lastname, LOCAL);
	NewBaseFile				:=	ROLLUP(PreRollupFileSort, rollitup(LEFT,RIGHT),email,firstname,lastname,LOCAL);

		//Parse out bad addresses
		NewBaseFileBadAddr	:=	NewBaseFile(REGEXFIND('[^0-9a-zA-z .,#-/]', address1) OR 
																															 REGEXFIND('[^0-9a-zA-z .,#-/]', address2) OR 
																															 (address1 = '' and address2 = '') OR 
 																															 (~(Regexfind('[0-9]', ADDRESS1)) and ~(Regexfind('[0-9]', ADDRESS2))) OR // neither address1 nor address2 has numbers.
																															 REGEXFIND('[^a-zA-Z ]', city) OR
																															 state NOT IN valid_states OR 
																															 REGEXFIND('^(?![0-9]{5}(-[0-9]{4})?$).*$', zip));
		NewBaseFileGoodAddr	:=	NewBaseFile(~(REGEXFIND('[^0-9a-zA-z .,#]', address1) OR 
																																	 REGEXFIND('[^0-9a-zA-z .,#-/]', address2) OR
																																	 (address1 = '' and address2 = '') OR 
																																	 (~(Regexfind('[0-9]', ADDRESS1)) and ~(Regexfind('[0-9]', ADDRESS2))) OR // neither address1 nor address2 has numbers.
																																	 REGEXFIND('[^a-zA-Z ]', city) OR 
																																	 state NOT IN valid_states OR 
																																	 REGEXFIND('^(?![0-9]{5}(-[0-9]{4})?$).*$', zip)));
	  
	 layout_AID_prep := RECORD
				string77	Append_Prep_Address_Situs;
				string54	Append_Prep_Address_Last_Situs;
				Layout_FormatFields;
			END;
			
	layout_AID_prep	tPreAddrClean(Layout_FormatFields pInput) := TRANSFORM
				self.Append_Prep_Address_Situs			:=	ut.fn_addr_clean_prep(pInput.address1, 'first');
				self.Append_Prep_Address_Last_Situs	:=	ut.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.zip, 'last');
				self																:=	pInput;
				self																:=	[];
			END;
			
	rsRawPreClean := PROJECT(NewBaseFileGoodAddr ,tPreAddrClean(LEFT));
	
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	AID.MacAppendFromRaw_2Line(rsRawPreClean,
															Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, AID,
															rsCleanAID, lAIDFlags);
		
	OutwardMedia.Layouts.Layout_OutwardMedia_DID tProjectClean(rsCleanAID pInput) := TRANSFORM
	
		clean_name:= Address.CleanPersonFML73(TRIM(TRIM(pInput.firstname) + ' ' + TRIM(pInput.lastname)));
		
		self.clean_title				:=	clean_name[1..5];
		self.clean_fname				:=	clean_name[6..25];
		self.clean_mname				:=	clean_name[26..45];
		self.clean_lname				:=	clean_name[46..65];
		self.clean_name_suffix	:=	clean_name[66..70];
		self.clean_name_score		:=	clean_name[71..73];
		
	  SELF.clean_prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.clean_predir               := pInput.aidwork_acecache.predir;
    SELF.clean_prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.clean_postdir              := pInput.aidwork_acecache.postdir;
    SELF.clean_unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.clean_sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.clean_p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.clean_st                   := pInput.aidwork_acecache.st;
    SELF.clean_zip                  := pInput.aidwork_acecache.zip5;
    SELF.clean_zip4                 := pInput.aidwork_acecache.zip4;
    SELF.clean_cart                 := pInput.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot                  := pInput.aidwork_acecache.lot;
    SELF.clean_lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.clean_dbpc                 := pInput.aidwork_acecache.dbpc;
    SELF.clean_chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.clean_rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.clean_county               := pInput.aidwork_acecache.county;
    SELF.clean_geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.clean_geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.clean_msa                  := pInput.aidwork_acecache.msa;
    SELF.clean_geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.clean_geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.clean_err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.aid                    		:= pInput.aidwork_rawaid;
    SELF  := pInput;
		
	END;
	
	rsOutwardMediaCleanParsedGood := PROJECT(rsCleanAID, tProjectClean(LEFT));

	OutwardMedia.Layouts.Layout_OutwardMedia_DID tProjectNotClean(NewBaseFileBadAddr pInput) := TRANSFORM
	
		clean_name	:= Address.CleanPersonFML73(TRIM(TRIM(pInput.firstname) + ' ' + TRIM(pInput.lastname)));
    cl_addr			:= Address.CleanAddress182(TRIM(pInput.address1)+ ' ' + TRIM(pInput.address2), TRIM(pInput.city) + ' ' + TRIM(pInput.state) + ' ' + TRIM(pInput.zip));
		
		self.clean_title				:=	clean_name[1..5];
		self.clean_fname				:=	clean_name[6..25];
		self.clean_mname				:=	clean_name[26..45];
		self.clean_lname				:=	clean_name[46..65];
		self.clean_name_suffix	:=	clean_name[66..70];
		self.clean_name_score		:=	clean_name[71..73];
		SELF.clean_prim_range  	:=  cl_addr[1..10];
		SELF.clean_predir  			:=  cl_addr[11..12];
		SELF.clean_prim_name  	:=  cl_addr[13..40];
		SELF.clean_addr_suffix  :=  cl_addr[41..44];
		SELF.clean_postdir  		:=  cl_addr[45..46];
		SELF.clean_unit_desig  	:=  cl_addr[47..56];
		SELF.clean_sec_range  	:=  cl_addr[57..64];
		SELF.clean_p_city_name  :=  cl_addr[65..89];
		SELF.clean_v_city_name  :=  cl_addr[90..114];
		SELF.clean_st  					:=  cl_addr[115..116];
		SELF.clean_zip  				:=  cl_addr[117..121];
		SELF.clean_zip4  				:=  cl_addr[122..125];
		SELF.clean_cart  				:=  cl_addr[126..129];
		SELF.clean_cr_sort_sz  	:=  cl_addr[130];
		SELF.clean_lot  				:=  cl_addr[131..134];
		SELF.clean_lot_order  	:=  cl_addr[135];
		SELF.clean_dbpc  				:=  cl_addr[136..137];
		SELF.clean_chk_digit  	:=  cl_addr[138];
		SELF.clean_rec_type  		:=  cl_addr[139..140];
		SELF.clean_county  			:=  cl_addr[141..145];
		SELF.clean_geo_lat  		:=  cl_addr[146..155];
		SELF.clean_geo_long  		:=  cl_addr[156..166];
		SELF.clean_msa  				:=  cl_addr[167..170];
		SELF.clean_geo_blk  		:=  cl_addr[171..177];
		SELF.clean_geo_match  	:=  cl_addr[178];
		SELF.clean_err_stat  		:=  cl_addr[179..182];
		SELF  									:= 	pInput;
		self										:=	[];
		
	END;
	
	rsOutwardMediaCleanParsedBad := PROJECT(NewBaseFileBadAddr, tProjectNotClean(LEFT));

	rsOutwardMediaCleanParsedAll	:=	rsOutwardMediaCleanParsedGood + rsOutwardMediaCleanParsedBad;

matchset	:=	['A','P','Z'];
DID_Add.MAC_Match_Flex(rsOutwardMediaCleanParsedAll, matchset,
											 foo, foo, clean_FName, clean_MNAME, clean_LName, clean_NAME_SUFFIX, 
											 clean_PRIM_RANGE, clean_PRIM_NAME, clean_SEC_RANGE, clean_ZIP, clean_ST, PHONE,
											 DID,
											 Layouts.Layout_OutwardMedia_DID,
											 true, DID_Score, //these should default to zero in definition
											 75,	  //dids with a score below here will be dropped 	
											 rsOutwardMediaDid);
  OutwardDID := rsOutwardMediaDid;
 Return OutwardDID;
End;