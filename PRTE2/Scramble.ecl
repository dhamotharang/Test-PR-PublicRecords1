//* Scramble - scramble the Foreclosures Customer Test File
IMPORT PRTE2,ut;
#WORKUNIT ('name', 'Scramble Foreclosures');

//* In Dev, uncomment the ut.foreign_prod thus:
//*  from prte_csv.ge_header_base.foreclosure_file_on_lz;
//*  testds := DATASET(ut.foreign_prod +  '~thor_data400::in::foreclosure_addresses_083112.csv',prte2.layouts.foreclosure_batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));

	  testds := DATASET(/*ut.foreign_prod + */ '~thor_data400::in::foreclosure_addresses_083112.csv',prte2.layouts.foreclosure_batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
	
  ForeclosureRec      := RECORD
	  PRTE2.layouts.Foreclosure_W_SEQ
  END;
	
 Sorted_Testds   := SORT(testds, address, apt, city, st, zip);
 
 Max_Orig 			 := COUNT(sorted_Testds);
 OUTPUT(max_orig, named('maxorig'));
 
 Foreclosure_Test_Deduped := DEDUP(Sorted_Testds,address,apt,city,st,zip);
 
 Max_Seq         := COUNT(Foreclosure_Test_Deduped);
 
 ForeclosureRec   AddSeqNo (Foreclosure_Test_Deduped L, integer C) := TRANSFORM
		self.old_seq_no     := (unsigned) C;
		new_seq             := (unsigned) C + 1;
		self.new_seq_no     := IF(new_seq > Max_seq, 1, new_seq);
		SELF                := L;
		SELF                := [];
	END;
Sequenced_DS          := PROJECT(Foreclosure_Test_Deduped, AddSeqNo (Left, Counter));

	
//* Join the sorted ln property to the file of addresses with sequence numbers,
//* appending the seq nos to the sorted LN_Property file).
Foreclosures_W_Seq := JOIN(Sorted_testds, Sequenced_DS,
		left.address  = right.address and
		left.apt      = right.apt and
		left.city     = right.city and
		left.st       = right.st and
		left.zip      = right.zip,  
		
		transform(ForeclosureRec,
				self.old_seq_no := right.old_seq_no,
				self.new_seq_no := right.new_seq_no,
				SELF            := left),
		left outer
		);
OUTPUT(choosen(Foreclosures_W_Seq,350), named('wseq'));
		


//* Now Join and Scrambled Addresses:

Foreclosures_PreScrambled  := JOIN(Foreclosures_W_Seq,Foreclosures_W_Seq,
		left.new_seq_no     =  right.old_seq_no, 

			transform(ForeclosureRec,
//* 
  
			  self.old_seq_no := left.old_seq_no,
				self.new_seq_no := left.new_seq_no,
				self.fname      := left.fname,
				self.mname      := left.mname,
				self.lname      := left.lname,
				self.SSN        := left.SSN,
				self.DOB        := left.DOB,
				self.address    := left.address,
				self.apt        := left.apt,
				self.city       := left.city,
				self.st         := left.st,
				self.zip        := left.zip,
				self.first_name_in 		 := left.first_name_in,
				self.middle_initial_in := left.middle_initial_in,
				self.last_name_in      := left.last_name_in,
				self.street_address_in := left.street_address_in,
				self.apt_in            := left.apt_in,
				self.city_in           := left.city_in,
				self.state_in          := left.state_in,
				self.zip_in            := left.zip_in,
				self.zip4_in           := left.zip4_in,
				self.prim_range_1      := left.prim_range_1,
				self.predir_1          := left.predir_1,
				self.prim_name_1       := left.prim_name_1,
				self.suffix_1          := left.suffix_1,
				self.postdir_1         := left.postdir_1,
				self.unit_desig_1      := left.unit_desig_1,
				self.sec_range_1       := left.sec_range_1,
				self.p_city_name_1     := left.p_city_name_1,
				self.st_1              := left.st_1,
				self.zip_1             := left.zip_1,
				self.zip4              := left.zip4;
				self.county            := left.county,
							
				self := right),
			left outer
			);



	
Sorted_Foreclosures_Scrambled     := SORT(Foreclosures_PreScrambled,
															 address, apt, city, st, zip, uniqueid);


Deduped_Foreclosures_Scrambled := DEDUP(Sorted_Foreclosures_Scrambled,address, apt, city, st, zip, uniqueid,owner_type, deed_event_type_cd, deed_event_type_desc,
doc_type_cd, doc_type_desc, cp_sale_amt, cp_auction_dt, lndr_cmpny_name, property_type_cd,
property_type_desc, ownr_1_first_name, ownr_1_last_name, ownr_1_cmpny_name, ownr_2_first_name, ownr_2_last_name, cp_recording_dt,
subdv_name, plntff1_name, trustee_name, foreclosure_type_flag, deed_document_type_desc,deed_recording_date);

OUTPUT(Deduped_Foreclosures_Scrambled,,'~prte::ct::foreclosure::scrambled::deduped',OVERWRITE);


//* remove sequence numbers
PRTE2.Layouts.foreclosure_batch_in WOSeqNo (Deduped_Foreclosures_Scrambled l) := TRANSFORM
		self := L,
		SELF := [],
END;
Unsequenced_DS  := PROJECT(Deduped_Foreclosures_Scrambled, WOSeqNo (LEFT));

max_final := COUNT(Unsequenced_DS);


//* write out the final descrambled file
OUTPUT(Unsequenced_DS,, PRTE2.Files.Foreclosure_Scrambled,
					CSV(Heading(Single), QUOTE('"'), Separator(','),NOTRIM), OVERWRITE);

//* end of Scramble
