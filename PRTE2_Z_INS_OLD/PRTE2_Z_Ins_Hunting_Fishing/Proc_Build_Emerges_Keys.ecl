import	_control, PRTE_CSV;

EXPORT Proc_Build_Emerges_Keys(string pIndexVersion) := FUNCTION

		// this is the same layout as AlphaBaseOUT if you add:
		// unsigned8 did;
		// unsigned8 __filepos;
		// persistent_record_id is moved to the bottom, but it's there.
		rKeyEmerges__hunters_doxie_did	:= PRTE_CSV.Emerges.rthor_data400__key__Emerges__hunters_doxie_did;
		dKeyEmerges__hunters_doxie_did		:= 	project(PRTE_CSV.Emerges.dthor_data400__key__Emerges__hunters_doxie_did, rKeyEmerges__hunters_doxie_did);
		kKeyEmerges__hunters_doxie_did		:=	index(dKeyEmerges__hunters_doxie_did, {did}, {dKeyEmerges__hunters_doxie_did}, '~prte::key::Emerges::' + pIndexVersion + '::hunters_doxie_did');

	//fcra keys
		kKeyEmerges__hunters_doxie_did_fcra		:=	index(dKeyEmerges__hunters_doxie_did, {did}, {dKeyEmerges__hunters_doxie_did}, '~prte::key::Emerges::fcra::' + pIndexVersion + '::hunters_doxie_did');

		return	parallel( build(kKeyEmerges__hunters_doxie_did    		, update),
											build(kKeyEmerges__hunters_doxie_did_fcra  	, update)
										);
END;
