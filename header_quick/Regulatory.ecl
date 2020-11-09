EXPORT Regulatory := Module

		// copied from header_quick.FN_KeyBuild
		EXPORT string_header_layout := Record
				string15  did;
				string15  rid;
				string1   pflag1;
				string1   pflag2;
				string1   pflag3;
				string2   src;
				string8   dt_first_seen;
				string8   dt_last_seen;
				string8   dt_vendor_last_reported;
				string8   dt_vendor_first_reported;
				string8   dt_nonglb_last_seen;
				string1   rec_type;
				string18  vendor_id;
				string10  phone;
				string9   ssn;
				string10  dob;
				string5   title;
				string20  fname;
				string20  mname;
				string20  lname;
				string5   name_suffix;
				string10  prim_range;
				string2   predir;
				string28  prim_name;
				string4   suffix;
				string2   postdir;
				string10  unit_desig;
				string8   sec_range;
				string25  city_name;
				string2   st;
				string5   zip;
				string4   zip4;
				string3   county;
				string7   geo_blk;
				string5   cbsa;
				string1   tnt;
				string1   valid_SSN;
				string1   jflag1;
				string1   jflag2;
				string1   jflag3;	
				string2   eor;
		End;		
		
		EXPORT applyQH() := FUNCTIONMACRO
				import Header, Suppress;
	
				supplementalData := suppress.applyregulatory.getFile('file_qh_inj.txt', header_quick.regulatory.string_header_layout);

				header.layout_header  ReformatInput(header_quick.regulatory.string_header_layout l) := TRANSFORM
						self.did := (unsigned6) l.did;
						self.rid := (unsigned6) l.rid;
						self.dt_first_seen := (unsigned3) l.dt_first_seen;
						self.dt_last_seen := (unsigned3) l.dt_last_seen;
						self.dt_vendor_last_reported := (unsigned3) l.dt_vendor_last_reported;
						self.dt_vendor_first_reported := (unsigned3) l.dt_vendor_first_reported;
						self.dt_nonglb_last_seen := (unsigned3) l.dt_nonglb_last_seen;
						self.dob := (integer4) l.dob;
						self := l;
						self := [];
				END;

				return PROJECT(supplementalData, ReformatInput(LEFT));		

		ENDMACRO;

End;