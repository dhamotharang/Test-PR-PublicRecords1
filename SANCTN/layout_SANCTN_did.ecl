IMPORT standard, bipv2;

export layout_SANCTN_did := record
  SANCTN.layout_SANCTN_party_clean_orig;
	bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
	unsigned8 source_rec_id := 0; //Added for BIP project
	unsigned6	did;
	unsigned3 did_score;
	unsigned6 bdid;
  unsigned3 bdid_score;
	string9		ssn_appended;
	string60 dba_name;
  string30 contact_name;
	string1	enh_did_src:='';					//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public
	//CCPA-283 Adding CCPA new fields
	UNSIGNED4 global_sid := 0;
	UNSIGNED8 record_sid:=0;
	UNSIGNED4 dt_effective_first:=0;
  	UNSIGNED4 dt_effective_last:=0;
  	UNSIGNED1 delta_ind := 0;
end;