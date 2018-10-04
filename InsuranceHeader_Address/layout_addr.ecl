/*2014-07-11T16:59:18Z (Steven Stockton)
Add id_cnt.
*/
import idl_header,InsuranceHeader_PostProcess;

EXPORT Layout_Addr := MODULE

EXPORT slimrec := record
	  unsigned8 rid,
		unsigned8 did,
    string2 addr_ind,
		string9 src,
		string10 prim_range,
		string28 prim_name,
		string  unit_desig,
		string8 sec_range,
		string25  city,
		string2 st,
		string5 zip,
		string4 zip4,
		integer dt_first_seen,
		integer dt_last_seen,
		integer days_differ,	
		integer seq,
		unsigned4 segment,
		unsigned6 id,
		unsigned6 id_cnt,
    string5 AddressStatus;
    string3 AddressType;
		string1 best_addr_ind;
		unsigned8 address_group_id;
		unsigned4 src_cnt;
	end;
	
EXPORT preprocess_slimrec := record
  UNSIGNED6 	RID;
	UNSIGNED6 	DID;
	STRING9			SRC;
	UNSIGNED4		DT_FIRST_SEEN;
	UNSIGNED4		DT_LAST_SEEN;
	STRING2			ADDR_IND;		
  UNSIGNED6 	ADDRESS_GROUP_ID;
	STRING4			ADDR_ERROR_Code;
	STRING10    PRIM_Range;
	STRING10		PRIM_RANGE_alpha;
	STRING10		PRIM_RANGE_num;
	STRING3     PRIM_RANGE_fract;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING28    PRIM_NAME_alpha;
	STRING28    PRIM_NAME_num;
	// STRING50    PRIM_NAME_unparsed;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
  STRING8			SEC_RANGE;
  STRING8			SEC_RANGE_alpha;
  UNSIGNED4		SEC_RANGE_num;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
	UNSIGNED4   REC_CNT;
	UNSIGNED4   SRC_CNT;
end;
	
EXPORT outrec := record
    idl_header.Layout_Header_address;
		unsigned6 bureaucnt;
		unsigned6 propcnt;
		unsigned6 utilcnt;
		unsigned6 vehcnt;
		unsigned6 dlcnt;
		unsigned6 votecnt;
		unsigned6 id;
		unsigned6 id_cnt;
end;

EXPORT addrsegrec := record
    idl_header.Layout_Header_address;
		unsigned6 id;
		unsigned6 id_cnt;
end;

EXPORT newaddrindrec := record
    addrsegrec;
		integer   new_addr_ind;
end;

EXPORT cntrec := record
    outrec;
		unsigned6 OSDcnt;
		unsigned6 OSRcnt;
		unsigned6 OSScnt;
		unsigned6 zip4cnt;
		unsigned6 osdzip4cnt;
		unsigned6 IC1cnt;
		unsigned6 IC2cnt;
		unsigned6 IC3cnt;
		unsigned6 VCCcnt;
		unsigned6 VPRcnt;
		unsigned6 SECcnt;
		unsigned6 BUScnt;
		unsigned6 SEAcnt;
		unsigned6 SECICCcnt;
		unsigned6 BUSICCcnt;
		unsigned6 SEAICCcnt;
end;

EXPORT proprec := record
  unsigned8 did,
  string2   addr_ind,
  string10  prim_range;
  string28  prim_name;
  string4   suffix;
  string8   sec_range;
  string5   zip;
	string8   purchase_date,
	string8   sale_date,
	boolean   owner_occupied,
end;

END;