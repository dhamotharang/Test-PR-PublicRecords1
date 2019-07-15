IMPORT idl_header, insuranceHeader_preprocess, Insurance_Header_AlpharettaDL;

EXPORT Add_Update_DMVData(dataset(idl_header.Layout_Header_Link) hdr) := MODULE

		NEDMV := IDL_Header.SourceTools.src_ins_dmv_ne;
		RestrictedSources := [NEDMV];
		
		header_layout 		:= idl_header.Layout_Header_Link;
		// IKS, INC, INM
		ks_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_KS(hdr).base_ks_header;
		nc_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_NC(hdr).base_nc_header;
		nm_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_NM(hdr).base_nm_header;
		// CIDMO, CIDNH, CIDOR, CIDSC
		mo_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_MO(hdr).base_mo_header;
		nh_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_NH(hdr).base_nh_header;
		or_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_OR(hdr).base_or_header;
		sc_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_SC(hdr).base_sc_header;		
		wi_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_WI(hdr).base_wi_header;
		wv_as_header 	:= Insurance_Header_AlpharettaDL.AsHeader_File_WV(hdr).base_wv_header;
		
		// Insurance Data
		insdmv := ks_as_header + nc_as_header + nm_as_header;
		ciddmv	:= mo_as_header + nh_as_header + or_as_header + sc_as_header + wi_as_header + wv_as_header;
		
		DATASET(header_layout) update1(recordof(header_layout) L) := TRANSFORM
				
				SELF.DT_LAST_SEEN  						:= L.dt_last_seen;
				SELF.DT_VENDOR_LAST_REPORTED  := L.dt_vendor_last_reported;
				SELF.dl_nbr										:= L.dl_nbr;
				SELF.dl_state									:= L.dl_state;
				SELF.gender										:= L.gender;
				SELF.FNAME										:= L.fname;
				SELF.MNAME										:= L.mname;
				SELF.LNAME										:= L.lname;
				SELF.dob											:= L.dob;
				SELF.ssn											:= L.ssn;
				SELF.prim_range								:= L.prim_range;
				SELF.predir										:= L.predir;
				SELF.prim_name								:= L.prim_name;
				SELF.addr_suffix							:= L.addr_suffix;
				SELF.postdir									:= L.postdir;
				SELF.unit_desig								:= L.unit_desig;
				SELF.sec_range								:= L.sec_range;
				SELF.city											:= L.city;
				SELF.st												:= L.st;
				SELF.zip											:= L.zip;
				SELF.zip4											:= L.zip4;
				SELF 													:= L;
		END;
		updated_insdmv_hdr := PROJECT(insdmv + ciddmv,update1(LEFT));
	  
EXPORT getRecords         := updated_insdmv_hdr;
		
END;


