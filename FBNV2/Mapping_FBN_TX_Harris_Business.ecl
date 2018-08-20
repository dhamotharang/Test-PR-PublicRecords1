
IMPORT FBNV2, ut, _validate;

// Since we're always going to have old logic and new logic that's not so easily done in 1 transform,
// we'll project into a common layout, doing the unique logic necessary, before going to the final
// layout.
cleaned_common_rec := RECORD
  Layout_File_TX_Harris_in.Cleaned;
	// Needed fields for unique logic
	UNSIGNED4 the_cancellation_date := 0;
	STRING10  business_status := '';
END;

cleaned_common_rec xform_old_to_common(Layout_File_TX_Harris_in.Cleaned L) := TRANSFORM
  the_date_filed        		 := L.DATE_FILED[5..8] + L.DATE_FILED[1..4];
	SELF.the_cancellation_date := IF(L.RECORD_TYPE = '3', (INTEGER)the_date_filed, 0);
	SELF.business_status       := IF(L.RECORD_TYPE = '3', 'INACTIVE', 'ACTIVE');

  SELF := L;
END;

cleaned_common_rec xform_new_to_common(Layout_File_TX_Harris_in.Cleaned L) := TRANSFORM
  // NOTE: There is no cancellation date for the new input
	SELF.business_status := IF(L.ASSUMED_NAME='W',
			                       'WITHDRAWN',
														 IF(L.EXPIRED_TERM = 'Y', 'EXPIRED', ''));

  SELF := L;
END;

// dOldFiling := PROJECT(File_TX_Harris_in.Cleaned_Old(FILE_NUMBER != ''), xform_old_to_common(LEFT));
dNewFiling := PROJECT(File_TX_Harris_in.Cleaned(FILE_NUMBER != ''), xform_new_to_common(LEFT));
dFiling_combined := 
                     // dOldFiling + 
										 dNewFiling;
dFiling_dist     := DISTRIBUTE(dFiling_combined, HASH(FILE_NUMBER));
dFiling_sort     := SORT(dFiling_dist, RECORD, LOCAL);
dFiling          := DEDUP(dFiling_sort, RECORD, LOCAL);

layout_common.Business_AID tFiling(dFiling pInput) := TRANSFORM
  // All versions (old and new) stored as MMDDYYYY, translate back to YYYYMMDD
  the_date_filed        				:= pInput.DATE_FILED[5..8] + pInput.DATE_FILED[1..4];

	SELF.tmsid					          := 'TXH' + HASH(pInput.CITY1 + pInput.NAME1);
	SELF.rmsid                    := 'T' + IF(pInput.FILE_NUMBER <> '',
	                                          HASH(pInput.FILE_NUMBER),
																						IF(the_date_filed <> '',
																						   HASH(the_date_filed),
																							 HASH(pInput.STREET_ADD1)));
	
	SELF.dt_first_seen      		  := if(_validate.date.fIsValid((string) the_date_filed), (integer) the_date_filed,0); 
	SELF.dt_last_seen       		  := if(_validate.date.fIsValid((string) the_date_filed), (integer) the_date_filed,0); 
	SELF.dt_vendor_first_reported := if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
	SELF.dt_vendor_last_reported  := if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
	SELF.Filing_Jurisdiction      := 'TXH';
	SELF.FILING_NUMBER           	:= pInput.FILE_NUMBER;
	SELF.Filing_date              := if(_validate.date.fIsValid((string) the_date_filed), (integer) the_date_filed,0); 
	SELF.BUS_NAME           		  := pInput.NAME1;
	SELF.LONG_BUS_NAME            := pInput.NAME1;
	SELF.BUS_ADDRESS1           	:= pInput.STREET_ADD1;
	SELF.BUS_CITY                 := pInput.CITY1;
	SELF.BUS_STATE                := 'TX';
	SELF.BUS_COUNTY								:= 'HARRIS';
	SELF.BUS_ZIP           			  := (INTEGER)pInput.ZIP1;
	SELF.MAIL_STREET  				    := pInput.STREET_ADD1;
	SELF.MAIL_CITY 					      := pInput.CITY1;
	SELF.MAIL_STATE 				      := pInput.STATE1;
	SELF.MAIL_ZIP 					      := pInput.ZIP1;
	SELF.EXPIRATION_DATE          := if(_validate.date.fIsValid((string) ((INTEGER)the_date_filed + (INTEGER)pInput.TERM * 10000)), ((INTEGER)the_date_filed + (INTEGER)pInput.TERM * 10000),0); 
	SELF.BUS_STATUS               := pInput.business_status;
	SELF.cancellation_date        := if(_validate.date.fIsValid((string) pInput.the_cancellation_date), (integer) pInput.the_cancellation_date,0); 
	SELF.prep_addr_line1					:= pInput.prep_addr1_line1;
	SELF.prep_addr_line_last			:= pInput.prep_addr1_line_last;
	SELF.prep_mail_addr_line1			:= pInput.prep_addr1_line1;
	SELF.prep_mail_addr_line_last	:= pInput.prep_addr1_line_last;
	
	SELF := pInput;
END;

layout_common.Business_AID rollupXform(layout_common.Business_AID pLeft, layout_common.Business_AID pRight) := TRANSFORM
	SELF.Dt_First_Seen            := ut.Min2(pLeft.dt_First_Seen, pRight.dt_First_Seen);
	SELF.Dt_Last_Seen             := MAX(pLeft.dt_Last_Seen , pRight.dt_last_seen);
	SELF.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported, pRight.dt_Vendor_First_Reported);
	SELF.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported, pRight.dt_Vendor_Last_Reported);

	SELF := pLeft;
END;

// DEDUP removed because it's unnecessary
dSortFiling	:= SORT(DISTRIBUTE(PROJECT(dfiling, tfiling(LEFT)), HASH(ORIG_FILING_NUMBER)),
                    RECORD,
										   EXCEPT dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
										LOCAL);
dout := ROLLUP(dSortFiling,
               rollupXform(LEFT, RIGHT),
					     RECORD,
							    EXCEPT dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
							 LOCAL) : PERSIST(cluster.cluster_out + 'persist::FBNV2::TXH::Business');

EXPORT Mapping_FBN_TX_Harris_Business := dout;