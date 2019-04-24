// Go to UtilFile.Util_Type_Desc for Utility Information.
// Utility connect date specifies the date when a specific utility was started at an Address.
// Logic - Join input to utility records using DIDs. Fetch oldest connect date using Name Match and Address Match.


EXPORT MAC_Add_UtilityConnection(InData, OutLayout, OutData, Isinputaddr, IsFCRA = FALSE, glb_ok = FALSE) := MACRO
import doxie, Utilfile, ut;

#UNIQUENAME(utildid)
#UNIQUENAME(unique_dids)
#UNIQUENAME(utilrecs_by_did)
#UNIQUENAME(ddp_srt_util_addr)
#UNIQUENAME(ddp_srt_util_name)
#UNIQUENAME(ddp_srt_util)
#UNIQUENAME(add_connectdate)
#UNIQUENAME(fnloutdata)
#UNIQUENAME(Is_utileqfx)

	// Full utility (Utilfile.Key_DID) includes all utility daily (UtilFile.Key_Util_Daily_Did) as well.
	%utildid% := Utilfile.Key_DID;
  %unique_dids% := DEDUP(SORT(InData,DID),DID);
	%utilrecs_by_did% := JOIN(%unique_dids%,%utildid%,
														KEYED(LEFT.did = RIGHT.s_did) AND RIGHT.connect_date <> '' AND RIGHT.util_type <> 'Z',TRANSFORM(RIGHT),
														LIMIT(ut.limits.FETCH_JUST_ADDR,SKIP));

	%ddp_srt_util_addr% := DEDUP(SORT(%utilrecs_by_did%, DID, prim_name, st, zip, prim_range, sec_range, connect_date), DID, prim_name, st, zip, prim_range, sec_range);
	%ddp_srt_util_name% := DEDUP(SORT(%utilrecs_by_did%, DID, lname, fname, mname, connect_date), did, lname, fname, mname, connect_date); // Oldest connect date required at the top.
  %ddp_srt_util% := IF(isinputaddr,%ddp_srt_util_addr%,%ddp_srt_util_name%); // Deduped by Name OR Address as per flag.
	
	OutLayout %add_connectdate%(InData L,%ddp_srt_util% R) := TRANSFORM
		SELF.util_connect_date := R.connect_date;
		SELF.util_type := UtilFile.Util_Type_Desc(R.util_type);
		SELF := L;
	END;

	#IF(Isinputaddr)
		%fnloutdata% :=
			SORT(JOIN(InData,%ddp_srt_util%,
			LEFT.zip <> '' AND LEFT.prim_name <> ''
			AND LEFT.DID = (unsigned)RIGHT.DID
			AND	LEFT.prim_name = RIGHT.prim_name
			AND LEFT.st = RIGHT.st
			AND	LEFT.zip = RIGHT.zip
			AND LEFT.prim_range = RIGHT.prim_range 
			AND LEFT.sec_range = RIGHT.sec_range
			AND LEFT.issubject, //Connect date appended only for subject address.
			%add_connectdate%(LEFT,RIGHT),LEFT OUTER,KEEP(1),LIMIT(200,SKIP)),address_seq_no); //Keep keeps only oldest connect_date for the address.
	#ELSE
		%fnloutdata% :=
			JOIN(InData,%ddp_srt_util%,
					LEFT.lname = RIGHT.lname
			AND LEFT.fname = RIGHT.fname
			AND LEFT.mname = RIGHT.mname,
			%add_connectdate%(LEFT,RIGHT),LEFT OUTER,KEEP(1),LIMIT(200,SKIP));
	#END

// Utility data is FCRA,GLB,Industry class-'UTILI resctricted.
		
	%Is_utileqfx% := Doxie.Compliance.isUtilityRestricted(ut.IndustryClass.Get()); 		
	outdata := IF(IsFCRA OR %Is_utileqfx% OR ~glb_ok,PROJECT(InData,TRANSFORM(OutLayout,SELF := LEFT,SELF := [])),%fnloutdata%);
		
ENDMACRO;