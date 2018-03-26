IMPORT eMerges, PRTE_CSV;

EXPORT Layouts := MODULE

	EXPORT AlphaBaseOUT := RECORD
			eMerges.layout_hunters_out;
				// 		this has the field name
				// unsigned8 persistent_record_id := 0;
				//		instead of 
				// unsigned8 did;
				// and
				// string did_out				
	END;

		// this is the same layout as AlphaBaseOUT if you add:
		// unsigned8 did;
		// unsigned8 __filepos;
		// persistent_record_id is moved to the bottom, but it's there.
	rKeyEmerges__hunters_doxie_did	:= PRTE_CSV.Emerges.rthor_data400__key__Emerges__hunters_doxie_did;
	

END;