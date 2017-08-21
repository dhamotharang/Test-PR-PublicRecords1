IMPORT PRTE2_ATF, ATF;

EXPORT layouts := MODULE

EXPORT lAtf_Firearms_in	:=	RECORD
  ATF.ATF_Layout_SearchFile and not [persistent_record_id, lf, source, ATF_id, DID];
	UNSIGNED8 ATF_id;
	UNSIGNED1 zero:=0;
	STRING1		blank:= '';
	STRING20	cust_name;
	STRING10	bug_num;
  STRING9   link_ssn;
  STRING8		link_dob;
  STRING9   link_fein;
  STRING8   link_inc_date;
END;
	
EXPORT Base := ATF.layout_firearms_explosives_out_BIP;

EXPORT Base_ext := RECORD
	Base;
	STRING20	cust_name;
	STRING10	bug_num;
  STRING9   link_ssn;
  STRING8		link_dob;
  STRING9   link_fein;
  STRING8   link_inc_date;
END;

EXPORT SearchFile	:= ATF.ATF_Layout_SearchFile; //Used by most of the keys
	
// temp layout created to convert STRING12 did_out to UNSIGNED6 type and added
// other fields zero/blank for passing into autokey build.

EXPORT tempAutokey := RECORD
	RECORDOF (ATF.layout_firearms_explosives_out and not [persistent_record_id, lf]);
	UNSIGNED8 ATF_id := 0;
	UNSIGNED1 zero:=0;
	STRING1   blank:= '';
	UNSIGNED6 did_out6 := 0;
	UNSIGNED6 bdid6;	 
END; 
	
END;