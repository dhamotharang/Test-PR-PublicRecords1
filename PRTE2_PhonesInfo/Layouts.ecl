IMPORT PhonesInfo;

EXPORT Layouts := MODULE
 
	 EXPORT layout_phones_ported_metadata_base_in := PhonesInfo.Layout_Common.portedMetadata_Main;
	 EXPORT layout_carrier_reference_base := PhonesInfo.Layout_Common.sourceRefBase;
	 
		//phones ported metadata in plus additional fields to save off original values before the update
		EXPORT layout_phones_ported_metadata_base_ext	:= RECORD	
			layout_phones_ported_metadata_base_in;
			unsigned8		orig_dt_last_reported										:= 0;
			unsigned8		orig_porting_dt																:= 0;
			string6				orig_porting_time														:= '';
			unsigned8		orig_vendor_last_reported_dt			:= 0;
			string6				orig_vendor_last_reported_time	:= '';
			unsigned8		orig_port_start_dt													:= 0;
			string6				orig_port_start_time											:= '';
			unsigned8		orig_port_end_dt															:= 0;
			string6				orig_port_end_time													:= '';
			unsigned8		orig_deact_start_dt												:= 0;
			string6				orig_deact_start_time										:= '';
			unsigned8		orig_deact_end_dt														:= 0;
			string6				orig_deact_end_time												:= '';
			unsigned8		orig_react_start_dt												:= 0;
			string6				orig_react_start_time										:= '';
			unsigned8		orig_react_end_dt														:= 0;
			string6				orig_react_end_time												:= '';
		END;


 END;




