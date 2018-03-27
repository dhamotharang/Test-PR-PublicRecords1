/*2015-06-05T21:49:59Z (Cyndy Yu)

*/
//------------------------------------
//----- Read AlphaDS and BocaDS ------
//------------------------------------
IMPORT prte_csv;
// Alpha Base
AlphaDS_Layout:= RECORD
  STRING5 DataSource := 'ALPHA';
  prte_csv.ge_header_base.layout_payload;
END;

// Boca Base
BocaDS_Layout := RECORD
  STRING5 DataSource := 'Boca';
  PRTE_CSV.Header.rthor_data400__key__header__data_new2;
END;


AlphaDS := PROJECT(PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_Prod, AlphaDS_Layout); // 48514
BocaDS  := PROJECT(PRTE2_Header_Ins.Files.BOCA_MAIN_PAYLOAD_DS, BocaDS_Layout);    //186351311

// appendAll := AlphaDS + BocaDS; 
// BocaDS_Deduped := DEDUP(SORT(BocaDS, record), record);
// Alpha_Deduped := DEDUP(SORT(AlphaDS, record), record);
// COUNT(BocaDS_Deduped);   //13576735
// COUNT(Alpha_Deduped);    //48514

// /*					 
//=========================================
//--------Find Duplicate phone, SSN--------
//=========================================					 			 
DS_phone := JOIN(BocaDS(phone!=''), AlphaDS(phone!=''), 
           left.phone = right.phone,
					 transform(AlphaDS_Layout, self:= left), skew(0.93));
					 
DS_phone;

DS_SSN := JOIN(BocaDS(SSN!=''), AlphaDS(SSN!=''), 
           left.SSN = right.SSN,
					 transform(AlphaDS_Layout, self:= left), skew(0.93));
					 
DS_SSN;
// */

/*
outrecord := record
  unsigned6 Alpha_did;
	qstring20 Alpha_fname;
	qstring20 Alpha_mname;
	qstring20 Alpha_lname;
	qstring10 Alpha_prim_range;
	qstring28 Alpha_prim_name;
	qstring25 Alpha_city_name;
	string2   Alpha_st;
	integer4  Alpha_dob;
  // string	  Alpha_orig_address;
	
	unsigned6 Boca_did;
	qstring20 Boca_fname;
	qstring20 Boca_mname;
	qstring20 Boca_lname;
	qstring20 Boca_prim_range;
	qstring28 Boca_prim_name;
	qstring25 Boca_city_name;
	string2   Boca_st;
	integer4  Boca_dob;
  // string	  Boca_orig_address;
END;
outrecord xGetDuplicate(AlphaDS_Layout Alpha, BocaDS_Layout Boca):= transform
	SELF.Alpha_did := Alpha.Did;
  SELF.Alpha_fname  := Alpha.fname;
  SELF.Alpha_mname  := Alpha.mname;
  SELF.Alpha_lname  := Alpha.lname;
	SELF.Alpha_prim_range := Alpha.prim_range;
	SELF.Alpha_prim_name  := Alpha.prim_name;
	SELF.Alpha_city_name  := Alpha.city_name;
	SELF.Alpha_st  := Alpha.st;
  SELF.Alpha_dob    := Alpha.dob;
  // SELF.Alpha_orig_address := Address.Addr1FromComponents(Alpha.prim_range, Alpha.predir, Alpha.prim_name,Alpha.suffix, Alpha.postdir, Alpha.unit_desig, Alpha.sec_range) ; 	
	SELF.Boca_did := Boca.Did;
  SELF.Boca_fname   := Boca.fname;
  SELF.Boca_mname   := Boca.mname;
  SELF.Boca_lname   := Boca.lname;
	SELF.Boca_prim_range := Boca.prim_range;
	SELF.Boca_prim_name  := Boca.prim_name;
	SELF.Boca_city_name  := Boca.city_name;
	SELF.Boca_st  := Boca.st;
  SELF.Boca_dob     := Boca.dob;
  // SELF.Boca_orig_address  := Address.Addr1FromComponents(Boca.prim_range, Boca.predir, Boca.prim_name,Boca.suffix, Boca.postdir, Boca.unit_desig, Boca.sec_range) ; 	
end;
*/
//================================================================
//--------Find Duplicate fname, mname, lanme, dob, address--------
//================================================================	
/*
DS_Name := JOIN(AlphaDS, BocaDS,  
                (LEFT.fname = RIGHT.fname )
                 AND (LEFT.mname  = RIGHT.mname  )
                 AND (LEFT.lname  = RIGHT.lname  )
                 AND (LEFT.dob = RIGHT.dob )
								 AND (LEFT.prim_range = RIGHT.prim_range )
                 AND (LEFT.prim_name  = RIGHT.prim_name  )
                 AND (LEFT.city_name  = RIGHT.city_name  )
                 AND (LEFT.st         = RIGHT.st         ),								 
                 xGetDuplicate(LEFT, RIGHT), skew(0.5));

DS_Name;
count(DS_Name);  //0
*/

//==================================================
//--------Find Duplicate fname, mname, lanme--------
//==================================================
/*
DS_Name := JOIN(AlphaDS, BocaDS,  
                (LEFT.fname = RIGHT.fname )
                 AND (LEFT.mname  = RIGHT.mname  )
                 AND (LEFT.lname  = RIGHT.lname  ),					 
                 xGetDuplicate(LEFT, RIGHT), skew(0.5));
DS_Name;
count(DS_Name);  //4259


DS_NameDeduped := DEDUP(SORT(DS_Name, record), record);
DS_NameDeduped;
count(DS_NameDeduped); //30
*/

//===========================================
//--------Find Duplicate fname, lanme--------
//===========================================
/*
DS_Name := JOIN(AlphaDS, BocaDS,  
                (LEFT.fname = RIGHT.fname )
                 // AND (LEFT.mname  = RIGHT.mname  )
                 AND (LEFT.lname  = RIGHT.lname  ),					 
                 xGetDuplicate(LEFT, RIGHT), skew(0.5));
DS_Name;
count(DS_Name);  //33200



DS_NameDeduped := DEDUP(SORT(DS_Name, record), record);
DS_NameDeduped;
count(DS_NameDeduped); //303
*/

//=======================================================
//--------Find Duplicate fname, mname, lanme, dob--------
//=======================================================
/*
DS_Name := JOIN(AlphaDS, BocaDS,  
                (LEFT.fname = RIGHT.fname )
                 AND (LEFT.mname  = RIGHT.mname  )
                 AND (LEFT.lname  = RIGHT.lname  )
                 AND (LEFT.dob = RIGHT.dob ),					 
                 xGetDuplicate(LEFT, RIGHT), skew(0.5));
DS_Name;
count(DS_Name);  //1529


DS_NameDeduped := DEDUP(SORT(DS_Name, record), record);
DS_NameDeduped;
count(DS_NameDeduped); //10
*/

/*
//=========================================
//----------Find Duplicate address---------
//=========================================		

DS_Address_noName := JOIN(AlphaDS, BocaDS,  
                     (LEFT.prim_range = RIGHT.prim_range )
                     AND (LEFT.prim_name  = RIGHT.prim_name  )
                     AND (LEFT.city_name  = RIGHT.city_name  )
                     AND (LEFT.st         = RIGHT.st         ),
                     xGetDuplicate(LEFT, RIGHT), skew(0.2));
DS_Address_noName;
COUNT(DS_Address_noName); //0
*/