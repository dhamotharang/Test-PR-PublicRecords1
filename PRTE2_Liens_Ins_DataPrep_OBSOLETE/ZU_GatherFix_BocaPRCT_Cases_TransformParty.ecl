// PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_TransformParty

IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins_DataPrep, address, ut, STD;

PrimDrivers := PRTE2_X_Ins_DataCleanse.Files_Alpha.primDriverCleanDS;

AppendIF(STRING S1, STRING S2) := IF(S1='',S2,S1+' '+S2);
AppendIF4(STRING S1, STRING S2, STRING S3, STRING S4) := AppendIF(AppendIF(S1,S2),AppendIF(S3,S4));
UPPER(STRING S1) := STD.Str.ToUpperCase(S1);
EXPORT Party1DS U_GatherFix_BocaPRCT_Cases_TransformParty(Party1DS L, PrimDrivers R) := TRANSFORM
		// SELF.tmsid := yyy;										// string50 tmsid - recalc'd on main file
		// SELF.rmsid := yyy;										// string50 rmsid - recalc'd on main file

		tmpFullName := AppendIF4(R.LAST_NAME,R.FIRST_NAME,R.MIDDLE_NAME,R.NAME_SUFFIX);
		betterFullName := ut.CleanSpacesAndUpper(tmpFullName);

		SELF.orig_full_debtorname := betterFullName;
		SELF.orig_name 						:= betterFullName; 
		SELF.orig_lname 					:= UPPER(R.LAST_NAME);
		SELF.orig_fname 					:= UPPER(R.FIRST_NAME);
		SELF.orig_mname 					:= UPPER(R.MIDDLE_NAME);
		SELF.orig_suffix 					:= UPPER(R.NAME_SUFFIX);

		SELF.ssn := R.ssn;

		// SELF.address.Layout_Clean_Name;
		cName := Address.CleanPersonFML73(betterFullName);
		self.title				:= TRIM(cName[1..5]);
		self.fname				:= TRIM(cName[6..25]);
		self.mname				:= TRIM(cName[26..45]);
		self.lname				:= TRIM(cName[46..65]);
		self.name_suffix	:= TRIM(cName[66..70]);
		self.name_score		:= TRIM(cName[71..73]);		
		
		tmpAddr1 := R.STREET_ADDRESS;
		tmpAddr2 := AppendIF4('',R.CITY,R.STATE,R.ZIP5);
		tmpFullAddr := AppendIF4(R.STREET_ADDRESS,R.CITY,R.STATE,R.ZIP5);
		SELF.orig_address1 := UPPER(tmpAddr1);
		SELF.orig_address2 := UPPER(tmpAddr2);
		SELF.orig_city := UPPER(R.CITY);
		SELF.orig_state := UPPER(R.STATE);
		SELF.orig_zip5 := R.ZIP5;
		SELF.orig_zip4 := '';
		SELF.orig_county := '';
		SELF.orig_country :='';
		
		// SELF.address.Layout_Clean182;				Take this from the cleaned address in the Prim Drv record
		SELF.prim_range := R.prim_range;
		SELF.predir := R.predir;
		SELF.prim_name := R.prim_name;
		SELF.addr_suffix := R.addr_suffix;
		SELF.postdir := R.postdir;
		SELF.unit_desig := R.unit_desig;
		SELF.sec_range := R.sec_range;
		SELF.p_city_name := R.p_city_name;
		SELF.v_city_name := R.v_city_name;
		SELF.st := R.st;
		SELF.zip := R.zip;
		SELF.zip4 := R.zip4;
		SELF.cart := R.cart;
		SELF.cr_sort_sz := R.cr_sort_sz;
		SELF.lot := R.lot;
		SELF.lot_order := R.lot_order;
		SELF.dbpc := R.dbpc;
		SELF.chk_digit := R.chk_digit;
		SELF.rec_type := R.rec_type;
		SELF.county := R.fips_county;
		SELF.geo_lat := R.geo_lat;
		SELF.geo_long := R.geo_long;
		SELF.msa := R.msa;
		SELF.geo_blk := R.geo_blk;
		SELF.geo_match := R.geo_match;
		SELF.err_stat := R.err_stat;
		
		SELF.phone := '';					// NOT THERE
		SELF.name_type := 'D';		// imitating what I see in PRCT data which had: 6130=D, 12=A and 26=C
		SELF.DID  := (STRING)R.uniqueid;
		SELF.date_first_seen := R.date_first_seen;
		SELF.date_last_seen := R.date_last_seen;
		SELF.date_vendor_first_reported := R.date_first_seen;
		SELF.date_vendor_last_reported := R.date_last_seen;

		SELF.cname := '';								// no businesses
		SELF.BDID := '';								// no businesses
		SELF.tax_id := '';							// no businesses

		SELF := L;

END;
/*
// ********************************************************** PARTY********************************************************** 

unsigned8 persistent_record_id := 0 ; 


*/
