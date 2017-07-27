Import Aid, address;

Export Layouts := Module

Export Lay_In := Record
			String	Address;
			String	City;
			String	Added_Date;
End;

//Internal SourceNames and Ids
// Source: DCF ; SourceID: '01'
// Source: <newSource> ; SourceID: '02'
// Source: <newSource> ; SourceID: '03'

Export Lay_Seq_In := Record
			Unsigned8 Seq_Num:=0;
			String	Source := ''; 
			Unsigned2	SourceId := 0;
			String	Address;
			String	City;
			String2	State:='';
			String	ZipCode := '';
			String	Added_Date;
End;

Export AID_Prep := Record
			Lay_Seq_In;
			String77	Append_Prep_Address_Situs;
			String54	Append_Prep_Address_Last_Situs;
			AID.Common.xAID	AID;
End;

Export Lay_Base := Record		
			Unsigned8 rawaid;
			String8 date_first_seen;
			String8 date_last_Seen;
			String8 date_first_Reported;
			String8 date_last_Reported;
			String1 Status := 'C'; //C : Current, H : Historical
			Unsigned8 Seq_Num;
			String	Source; 
			Unsigned2	SourceId;
			String	Address;
			String	City;
			String2	State;
			String	ZipCode;
			String Added_Date;
			String10 prim_range;
			String2	predir;
			String28	prim_name;
			String4	addr_suffix;
			String2	postdir;
			String10	unit_desig;
			String8	sec_range;
			String25	p_city_name;
			String25	v_city_name;
			String2	st;
			String5	zip;
			String4	zip4;
			String4	cart;
			String1	cr_sort_sz;
			String4	lot;
			String1	lot_order;
			String2	dbpc;
			String1	chk_digit;
			String2	rec_type;
			String5	county;
			String10	geo_lat;
			String11	geo_long;
			String4	msa;
			String7	geo_blk;
			String1	geo_match;
			String4	err_stat;
End;

Export Lay_KeyAddress := Record		
Lay_Base  and not [address , city];
			String100	Address;
			String40	City;				

End;
End;