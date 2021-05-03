//
// base_layout copied from header.layout_header_v2
// work completed 10-4-19
// 
// added code to process FCRA_Header

Export Regulatory := module

		export Base_Layout := record
				
				unsigned6  did := 0;
				//unsigned6  PreGLB_did := 0;
				unsigned6  rid;
				string1 	 pflag1 := '';		//for original pflag purposes
				// A is the former A1A
				// P is the former A1P - although i see none of these
				// + is the former A1+
				string1		 pflag2 := '';		//for phone number related work
				// R is where a phone number was replaced by gong hist phone number
				// E is where a phone number was enhance by gong hist phone number
				// N is where we have added an area code using zip and nxx match to tpm file
				// P is where you accidentally got a property phone that we later cleaned out
				// A is where we added an apt number - see header.apt_patch
				//see gong.BWR_Patch_Header
				string1		 pflag3 := '';		//for marking records that will have to be split into multiples for despray
				//see header.translatePflag3
				string2    src;
				unsigned3  dt_first_seen;
				unsigned3  dt_last_seen;
				unsigned3  dt_vendor_last_reported;
				unsigned3  dt_vendor_first_reported;
				unsigned3  dt_nonglb_last_seen;
				string1    rec_type;
				qstring18  vendor_id;
				qstring10  phone;
				qstring9   ssn;
				integer4   dob;
				qstring5   title;
				qstring20  fname;
				qstring20  mname;
				qstring20  lname;
				qstring5   name_suffix;
				qstring10  prim_range;
				string2    predir;
				qstring28  prim_name;
				qstring4   suffix;
				string2    postdir;
				qstring10  unit_desig;
				qstring8   sec_range;
				qstring25  city_name;
				string2    st;
				qstring5   zip;
				qstring4   zip4;
				string3    county;
				qstring7	 geo_blk;
				qstring5   cbsa := '';
				string1    tnt := ' ';
				// these are computed during header build
				// N = Name+Address does not exist in Gong
				// Y = Name+Address does exist in Gong
				// P = Name+Address+Phone does exist in Gong
				// D = Dead
				// these are computed at query time
				// TNT Verification levels
				// B = Bullseye Ã‚â€“ is currently the Ã‚â€˜bestÃ‚â€™ address and is a DID match to the gong file
				// *** The ultimate, full phone verification and other records pointing at that being best address too
				// V = Verified Ã‚â€“ is currently the Ã‚â€˜bestÃ‚â€™ address and is a HHID match to the gong file
				// *** Other records support this as the best address and the HOUSEHOLD has a phone registered at this line. Will pick up women with different lname to husbands
				// C = Current Ã‚â€“ is best address but not validated by the gong file
				// *** Self evident, works even when there is no phone indicator
				// P = Probable Ã‚â€“ is not currently the best address, but is did verified or hhid verified with a dt_last_seen within 6 months
				// *** Most likely because the best address is a mailing (only) address. This annotates the address with the active phone line out of Ã‚â€˜lived inÃ‚â€™ addresses
				// R = Relative Ã‚â€“ is not currently the best address, and has a dt_last_seen > 6 months ago but is HHID verified
				// *** Probably identifies a situation where a family member moved out of the address
				// H = Historic Ã‚â€“ is not the best address and is not HHID or DID verified
				// *** A dead, historic address
				string1	   valid_SSN := '';
				// G=good, 
				// F=fatfingers(typo; one or two digits off in the same positions)
				// R=relative ; B=bad ; O=old (SSA issued before individual's DOB)
				// Z= ssn matches best_ssn, but someone else owns it
				// U=unknown */ 
				// M=SSN in the records is manufactured; it cam from watchdog non-GLB best if available
				// M is populated in the keys only.  base file does not contain M.
				string1	   jflag1 := '';  //valid_DOB
				// C - correct 
				// L - correct but low quality
				// I - invalid
				// T - typo
				// B - bad
				// U - undetermined
				string1    jflag2 := '';
				// set in header.Last_Rollup amd header.With_Did
				// Ambiguous := 'A';
				// AmbiguousPropertySingleton := 'D';
				// AmbiguousPropertyMultiple := 'E';
				// NotAmbiguousPropertyMultiple := 'C';
				// NotAmbiguousPropertySingleton := 'B';
				string1	   jflag3 := ''; //ssn confirmed from EQ or BA
				unsigned8  RawAID := 0; 
				string5    Dodgy_tracking:= '';  // UNK's from name_suffix
				unsigned8  NID:=0;  // name cleaner ID
				unsigned2  address_ind:=0;  // address indicator bitmap
				unsigned2  name_ind:=0;  // name indicator bitmap
				unsigned8  persistent_record_ID := 0; //tracking the record between full header and individual dataset
		end;

    export Header_LZ_Layout := 
      Record
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
        string20  RawAID;
        string1   eor; 
      end;

		Export Fcra_Header_LZ_Layout := Record
				string15	did;
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
				string20  RawAID; // added - KLM
				string1   eor; // changed from string2 to  string1 - KLM 
		end;

		export hash_layout := record
				string32 hval_s;
				string2  nl;
		end;
		
// process adl_segment_inj data

		export apply_ADL_Segment(ds) := 
				functionmacro											
						return Suppress.applyRegulatory.simple_append(ds, 'adl_segment_inj.txt', header.regulatory.base_layout);						
				endmacro; 

    export _apply(ds,filename,layout) :=
        functionmacro
						import Suppress, Header;
				
						Base_File_Append_In := Suppress.applyRegulatory.getfile(filename, layout);	

            // typically header.layout_header
						recordof(ds) reformat_header(Base_File_Append_In L) := transform
								// FileName_Loc;
								self.did := (unsigned6) L.did;
								self.rid := (unsigned6) L.rid;
								self.dt_first_seen := (unsigned3) L.dt_first_seen;
								self.dt_last_seen := (unsigned3) L.dt_last_seen;
								self.dt_vendor_last_reported := (unsigned3) L.dt_vendor_last_reported;
								self.dt_vendor_first_reported := (unsigned3) L.dt_vendor_first_reported;
								self.dt_nonglb_last_seen := (unsigned3) L.dt_nonglb_last_seen;
								self.title := trim(L.title, left, right);
								self.fname := trim(L.fname, left, right);
								self.mname := trim(L.mname, left, right);
								self.lname := trim(L.lname, left, right);
								self.name_suffix := trim(L.name_suffix, left, right);
								self.vendor_id := trim(l.vendor_id,left,right);
								self.phone := trim(l.phone,left,right);
								self.ssn := trim(l.ssn,left,right);
								self.prim_range := trim(l.prim_range,left,right);
								self.predir := trim(l.predir,left,right);
								self.prim_name := trim(l.prim_name,left,right);
								self.suffix := trim(l.suffix,left,right);
								self.postdir := trim(l.postdir,left,right);
								self.unit_desig := trim(l.unit_desig,left,right);
								self.sec_range := trim(l.sec_range,left,right);
								self.city_name := trim(l.city_name,left,right);
								self.st := trim(l.st,left,right);
								self.zip := trim(l.zip,left,right);
								self.zip4 := trim(l.zip4,left,right);
								self.county := trim(l.county,left,right);
								self.dob := (integer4) L.dob;
								self.RawAID := (unsigned8) L.RawAID;			
								self := L;
								self := [];
				    end;

				    return ds + project(Base_File_Append_In, reformat_header(left)); 

				endmacro; 

// process fcra_header_inj data

		export apply_FCRA_Header(ds) := 
				functionmacro	
						import Header;
				
						return (header.Regulatory._apply(ds,'file_fcra_header_inj.txt', header.regulatory.Fcra_Header_LZ_Layout));

				endmacro; 

// process header data

		export apply_Header(ds) := 
				functionmacro	
						import Header;
				
						return (header.Regulatory._apply(ds,'file_headersv2_inj.txt', header.regulatory.Header_LZ_Layout));

				endmacro; 

		EXPORT applySsnCorrectionSup(base_ds) := FUNCTIONMACRO
			import Header, Suppress;
			
					SsnCorrectionHash(recordof(base_ds) L) :=  hashmd5(L.ssn); 
					
					local _ds1 := Suppress.applyRegulatory.simple_sup(base_ds, 'ssn_corrections.txt', SsnCorrectionHash);
					return _ds1;
		ENDMACRO;
		

		EXPORT applySsnFilterSup(base_ds) := FUNCTIONMACRO
			import Header, Suppress;
			
					SsnFilterHash(recordof(base_ds) L) :=  hashmd5(intformat((unsigned6)L.did,15,1),Trim((string9)L.ssn, left, right)); 
					local supLayout := Suppress.applyRegulatory.layout_out;		
						
					sup_in := suppress.applyregulatory.getFile('file_ssn_filter.thor', supLayout);					

					_ds1 := join(base_ds, sup_in
											, SsnFilterHash(left) = right.hval
											, transform(left)
											, left only
											, lookup);
					return _ds1;
		ENDMACRO;
		
			
		EXPORT applyRidRecSup(base_ds) := FUNCTIONMACRO
			import Header, Suppress, doxie_build;
		
					local RidRecHash(recordof(base_ds) L) :=  hashmd5(intformat((unsigned6)L.rid,15,1)); 

					
					local _ds1 := Suppress.applyRegulatory.simple_sup(base_ds, 'ridrec_sup.txt', RidRecHash);
					return _ds1;
		ENDMACRO;

		EXPORT applyDidAddressSup(base_ds) := FUNCTIONMACRO
			import Header, Suppress, doxie_build;
		
					local DidAddressHash(recordof(base_ds) L) :=  hashmd5(intformat(l.did,15,1),(STRING)l.st, (STRING)l.zip, (STRING)l.city_name, 
																												(STRING)l.prim_name, (STRING)l.prim_range, (STRING)l.predir, (STRING)l.suffix, (STRING)l.postdir, (STRING)l.sec_range);
					
					local _ds1 := Suppress.applyRegulatory.simple_sup(base_ds, 'didaddress_sup.txt', DidAddressHash);
					return _ds1;
		ENDMACRO;

		EXPORT applyDidAddressSup2(base_ds) := FUNCTIONMACRO
			import Header, Suppress, doxie_build;
		
					local DidAddressHash(recordof(base_ds) L) :=  hashmd5(l.did,l.st,l.zip,l.city_name,l.prim_name,l.prim_range,l.predir,l.suffix,l.postdir,l.sec_range);
			
					local _ds1 := Suppress.applyRegulatory.simple_sup(base_ds, 'didaddress_sup.txt', DidAddressHash);
					return _ds1;
		ENDMACRO;

end;