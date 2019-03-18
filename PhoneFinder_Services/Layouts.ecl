﻿IMPORT Autokey_batch,BatchShare,doxie,Doxie_Raw,iesp,Royalty,PhonesInfo,PhoneFraud;

EXPORT Layouts :=
MODULE

	EXPORT BatchIn :=
	RECORD
		STRING20	acctno;
	
		STRING20	name_first;
		STRING20	name_middle;
		STRING20	name_last;
		STRING5		name_suffix;

		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  p_city_name;
		STRING2   st;
		STRING5   z5;
		STRING4   z4;

		STRING12	ssn;
		STRING10  phone;

		UNSIGNED6 did;
	END;
	EXPORT BatchInAppendAcctno :=
	RECORD(BatchIn)
		STRING20 orig_acctno; // [internal]
		UNSIGNED2 did_count := 0;
		UNSIGNED6 orig_did;
		BatchShare.Layouts.ShareErrors;
	END;
	
	// Batch input with DID appended to the layout
	EXPORT BatchInAppendDID :=
	RECORD(Autokey_batch.Layouts.rec_inBatchMaster)
		UNSIGNED2 did_count := 0;
		UNSIGNED6 orig_did;
		STRING8   dod := '';
	END;
	
	// Carrier information
	EXPORT CarrierInfo :=
	MODULE
	
		EXPORT Base :=
		RECORD
			STRING3  carrier_type;
			STRING60 carrier_name;
			STRING50 carrier_city;
			STRING2  carrier_state;
			STRING1  dial_ind;
			STRING3  coctype;
			STRING4  ssc;
			STRING   coc_description;
			STRING   ssc_description;
		END;
	
	END;
	
	// Phone finder layouts
	EXPORT PhoneFinder :=
	MODULE
		
		// Phones common layout
		EXPORT Common :=
		RECORD(doxie.layout_pp_raw_common)
			BatchInAppendDID batch_in;
			UNSIGNED1        phone_source;
		END;		
		// ACCUDATA IN LAYOUT
		EXPORT Accudata_in := RECORD
		  	STRING20      acctno;
		    STRING10      phone;
		END;
		
		EXPORT PortHistory :=
		RECORD
			STRING ServiceProvider;
			UNSIGNED4 PortStartDate;
			UNSIGNED4 PortEndDate;		
		END;
		
		EXPORT Porting :=
		RECORD
			STRING PortingCode;
			UNSIGNED1 PortingCount;
			DATASET(PortHistory) PortingHistory;
			UNSIGNED4 FirstPortedDate;
			UNSIGNED4 LastPortedDate;
			STRING15 PhoneStatus;
			UNSIGNED4 ActivationDate;
			UNSIGNED4 DisconnectDate;
			BOOLEAN 	NoContractCarrier;
			BOOLEAN 	Prepaid;	
			UNSIGNED1 serviceType;
			STRING PortingStatus;	

		END;
		
		EXPORT SpoofHistory :=
		RECORD		
			STRING1 PhoneOrigin;
			STRING8 EventDate;
		END;
		EXPORT SpoofCommon :=
		RECORD
			BOOLEAN Spoofed;
			UNSIGNED SpoofedCount;
			UNSIGNED4 FirstSpoofedDate;
			UNSIGNED4 LastSpoofedDate;
		END;
		
		EXPORT SpoofingData :=
		RECORD
			SpoofCommon Spoof;
			SpoofCommon Destination;
			SpoofCommon Source;
			UNSIGNED TotalSpoofedCount;
			UNSIGNED4 FirstEventSpoofedDate;
			UNSIGNED4 LastEventSpoofedDate;
			DATASET(SpoofHistory) SpoofingHistory;
		END;	
		
		EXPORT OTPs :=
		RECORD			
			BOOLEAN 	OTPStatus;
			STRING8 	EventDate;
		END;
		
		EXPORT OneTimePassword :=
		RECORD
			BOOLEAN 	OTP;
			UNSIGNED2 OTPCount;
			UNSIGNED4 FirstOTPDate;
			UNSIGNED4 LastOTPDate;
			BOOLEAN 	LastOTPStatus;
			DATASET(OTPs) OTPHistory;
		END;			
		
		EXPORT	alert := 
		RECORD
			STRING flag;
			DATASET(iesp.share.t_StringArrayItem) messages;
			DATASET(iesp.phonefinder.t_PhoneFinderAlertIndicator) AlertIndicators;
		END;
		
		// Phone finder common layout with carrier information	
		EXPORT Final :=
		RECORD
			STRING20                                          acctno;
			UNSIGNED8                                         seq;
			UNSIGNED6                                         did;
			UNSIGNED2                                         penalt;
			STRING2                                           vendor_id;
			STRING2                                           src;
			STRING2                                           phone_vendor;
			STRING1                                           typeflag;
			STRING8                                           dt_first_seen;
			STRING8                                           dt_last_seen;
			STRING25	                                        append_phone_type;
			STRING10                                          phone;
			STRING2	                                          phoneState;		
			UNSIGNED1																					                    serviceType;
			STRING9                                           ssn;
			STRING2                                           SSNMatch;
			UNSIGNED4                                         dob;
			UNSIGNED4                                         dod;
			STRING1                                           deceased;
			STRING20                                          fname;
			STRING20                                          mname;
			STRING20                                          lname;
			STRING5                                           name_suffix;
			STRING10                                          prim_range;
			STRING2                                           predir;
			STRING28                                          prim_name;
			STRING4                                           suffix;
			STRING2                                           postdir;
			STRING10                                          unit_desig;
			STRING8                                           sec_range;
			STRING25                                          city_name;
			STRING2                                           st;
			STRING5                                           zip;
			STRING4                                           zip4;
			STRING5                                           county_code;
			STRING18                                          county_name;
			STRING1                                           tnt;
			STRING40																				                     	primary_address_type;			 
			STRING120                                         listed_name;
			STRING120                                         listed_name_targus;
			STRING10                                          listed_phone;
			STRING1                                           listing_type_res;
			STRING1                                           listing_type_bus;
			STRING1                                           listing_type_gov;
			STRING254                                         caption_text;
			UNSIGNED2	                                        ConfidenceScore;
			STRING1		                                        ActiveFlag;
			STRING2                                           TargusType;
			BOOLEAN                                           vendor_dt_last_seen_used;
			STRING1                                           dial_indicator;
			STRING60                                          carrier_name;
			STRING50                                          phone_region_city;
			STRING2                                           phone_region_st;
			STRING3                                           coctype;
			STRING                                            coc_description;
			STRING4                                           ssc;
			STRING                                            ssc_description;
			BOOLEAN                                           telcordia_only;
			BOOLEAN                                           isPrimaryPhone;
			UNSIGNED1                                         phone_source;
			// Fields pertaining only to waterfall process
			STRING8                                           matchcodes;
			INTEGER                                           error_code;
			STRING2                                           subj_phone_type;
			STRING2                                           subj_phone_type_new;
			UNSIGNED                                          sort_order;
			UNSIGNED                                          sort_order_internal;
			UNSIGNED                                          sub_rule_number;
			STRING3                                           phone_score;
			// Experian File One
			STRING3                                           Phone_Digits;
			STRING15                                          Encrypted_Experian_PIN;
			// QSent phone detail fields
			Doxie_Raw.PhonesPlus_Layouts.t_RealTimePhone_Ext1 RealTimePhone_Ext;
			// Batch input fields
			BatchInAppendDID                                  batch_in;
			Porting;
			SpoofingData;
			OneTimePassword;
			STRING4 PhoneRiskIndicator;
			BOOLEAN OTPRIFailed;
			DATASET(Alert) Alerts;
			DATASET({STRING17 InquiryDate})									InquiryDates;		
			UNSIGNED RecordsReturned;
			BOOLEAN PhoneOwnershipIndicator;
			STRING rec_source;
			STRING15 CallForwardingIndicator;
			string imsi_seensince;
			string8 imsi_changedate;
			string8 imsi_ActivationDate;
			integer imsi_changedthis_time;
			integer iccid_changedthis_time;
			string iccid_seensince;
			string imei_seensince;
			string8 imei_changedate;
			integer imei_changedthis_time;
			integer loststolen;
			string8 loststolen_date;
		END;
		
		EXPORT ExcludePhones :=
		RECORD
			STRING20 acctno;
			STRING10 phone;
		END;
		
		EXPORT IdentitySlim :=
		RECORD
			STRING20  acctno;
			UNSIGNED6 did;
			UNSIGNED2 penalt;
			STRING2   vendor_id;
			STRING2   src;
			STRING1   typeflag;
			UNSIGNED4 dt_first_seen;
			UNSIGNED4 dt_last_seen;
			STRING10  phone;
			UNSIGNED4 dob;
			STRING1   deceased;
			STRING20  fname;
			STRING20  mname;
			STRING20  lname;
			STRING5   name_suffix;
			STRING120 listed_name;
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			STRING4   suffix;
			STRING2   postdir;
			STRING10  unit_desig;
			STRING8   sec_range;
			STRING25  city_name;
			STRING2   st;
			STRING5   zip;
			STRING4   zip4;
			STRING5   county_code;
			STRING18  county_name;
			STRING40	primary_address_type;				
			UNSIGNED1 phone_source;
			STRING1 	tnt;
			BOOLEAN PhoneOwnershipIndicator;
		END;
		
		EXPORT PhoneSlim :=
		RECORD(Doxie_Raw.PhonesPlus_Layouts.t_RealTimePhone_Ext1)
			STRING20  acctno;
			UNSIGNED2 penalt;
			STRING2   vendor_id;
			STRING2   src;
			STRING1   typeflag;
			STRING10  orig_phone;
			STRING10  phone;
			STRING60  carrier_name;
			STRING50  phone_region_city;
			STRING2   phone_region_st;
			STRING    coc_description;
			UNSIGNED1 phone_source;
			STRING3   phone_score;
			UNSIGNED4 dt_first_seen;
			UNSIGNED4 dt_last_seen;
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			STRING4   suffix;
			STRING2   postdir;
			STRING10  unit_desig;
			STRING8   sec_range;
			STRING25  city_name;
			STRING2   st;
			STRING5   zip;
			STRING4   zip4;
			STRING5   county_code;
			STRING18  county_name;
			Porting - PortingCode;
			SpoofingData;
			OneTimePassword;
			STRING4 PhoneRiskIndicator;
			BOOLEAN OTPRIFailed;
			DATASET(Alert) Alerts;
			BOOLEAN PhoneOwnershipIndicator;
			STRING15 CallForwardingIndicator;
		END;
		
		EXPORT IdentityIesp :=
		RECORD(iesp.phonefinder.t_PhoneIdentityInfo)
			STRING20 acctno; 
			STRING10  phone;		
			STRING2   vendor_id; // for zumigo logging dataset
		END;
		
		EXPORT PhoneIesp :=
		RECORD(iesp.phonefinder.t_PhoneFinderDetailedInfo)
			STRING20 acctno;
		END;
		
		EXPORT OtherPhoneIesp :=
		RECORD(iesp.phonefinder.t_PhoneFinderInfo)
			STRING20 acctno;
		END;
		
		EXPORT TempOut :=
		RECORD(BatchInAppendAcctno)
			DATASET(iesp.phonefinder.t_PhoneIdentityInfo) identity_info;
			DATASET(iesp.phonefinder.t_PhoneFinderInfo)   other_phones;
			iesp.phonefinder.t_PhoneFinderDetailedInfo    phone_info;
			iesp.phonefinder.t_PhoneIdentityInfo          primary_identity;
		END;
		
		LOADXML('<xml/>');
		#DECLARE(IdentityInfo);
		#DECLARE(cntIdentity);
		
		#SET(IdentityInfo,'');
		#SET(cntIdentity,1);
		
		#LOOP
			#IF(%cntIdentity% > iesp.Constants.Phone_Finder.MaxIdentities)
				#BREAK;
			#ELSE
				#APPEND(IdentityInfo,
								'STRING   Identity' + %'cntIdentity'% + '_DID;' +
								'STRING62 Identity' + %'cntIdentity'% + '_Full;' +
								'STRING20 Identity' + %'cntIdentity'% + '_First;' +
								'STRING20 Identity' + %'cntIdentity'% + '_Middle;' +
								'STRING20 Identity' + %'cntIdentity'% + '_Last;' +
								'STRING5  Identity' + %'cntIdentity'% + '_Suffix;' +
								'STRING1  Identity' + %'cntIdentity'% + '_Deceased;' +
								'STRING10 Identity' + %'cntIdentity'% + '_StreetNumber;' +
								'STRING2  Identity' + %'cntIdentity'% + '_StreetPreDirection;' +
								'STRING28 Identity' + %'cntIdentity'% + '_StreetName;' +
								'STRING4  Identity' + %'cntIdentity'% + '_StreetSuffix;' +
								'STRING2  Identity' + %'cntIdentity'% + '_StreetPostDirection;' +
								'STRING10 Identity' + %'cntIdentity'% + '_UnitDesignation;' +
								'STRING8  Identity' + %'cntIdentity'% + '_UnitNumber;' +
								'STRING25 Identity' + %'cntIdentity'% + '_City;' +
								'STRING2  Identity' + %'cntIdentity'% + '_State;' +
								'STRING5  Identity' + %'cntIdentity'% + '_Zip5;' +
								'STRING4  Identity' + %'cntIdentity'% + '_Zip4;' +
								'STRING18 Identity' + %'cntIdentity'% + '_County;' +
								'STRING40 Identity' + %'cntIdentity'% + '_PrimaryAddressType;' +
								'STRING1  Identity' + %'cntIdentity'% + '_RecordType;' +
								'STRING8  Identity' + %'cntIdentity'% + '_FirstSeenWithPrimaryPhone;' +
								'STRING8  Identity' + %'cntIdentity'% + '_LastSeenWithPrimaryPhone;' +
								'STRING8  Identity' + %'cntIdentity'% + '_TimeWithPrimaryPhone;' +
								'STRING8  Identity' + %'cntIdentity'% + '_TimeSinceLastSeenWithPrimaryPhone;' +
								'BOOLEAN  Identity' + %'cntIdentity'% + '_PhoneOwnershipIndicator;');
				#SET(cntIdentity,%cntIdentity% + 1)
			#END
		#END
		
		#DECLARE(Alerts);
		#DECLARE(cntAlerts);
		
		#SET(Alerts,'');
		#SET(cntAlerts,1);
		
		#LOOP
			#IF(%cntAlerts% > PhoneFinder_Services.Constants.MaxAlertCategories)
				#BREAK;
			#ELSE
				#APPEND(Alerts,
								'STRING Alerts' + %'cntAlerts'% + '_Flag;' +
								'STRING Alerts' + %'cntAlerts'% + '_Messages;');
				#SET(cntAlerts,%cntAlerts% + 1)
			#END
		#END		
		
		#DECLARE(OtherPhones);
		#DECLARE(cntPhone);
		
		#SET(OtherPhones,'');
		#SET(cntPhone,1);
		
		#LOOP
			#IF(%cntPhone% > iesp.Constants.Phone_Finder.MaxOtherPhones)
				#BREAK;
			#ELSE
				#APPEND(OtherPhones,
								'STRING OtherPhone' + %'cntPhone'% + '_PhoneNumber;' +
								'STRING OtherPhone' + %'cntPhone'% + '_PhoneType;' +
								'STRING OtherPhone' + %'cntPhone'% + '_ListingName;' +
								'STRING OtherPhone' + %'cntPhone'% + '_Carrier;' +
								'STRING OtherPhone' + %'cntPhone'% + '_CarrierCity;' +
								'STRING OtherPhone' + %'cntPhone'% + '_CarrierState;' +
								'STRING OtherPhone' + %'cntPhone'% + '_PhoneStatus;' +
								'STRING OtherPhone' + %'cntPhone'% + '_PortCode;' +
								'STRING OtherPhone' + %'cntPhone'% + '_PhoneRiskIndicator;' +
								'BOOLEAN OtherPhone' + %'cntPhone'% + '_OTPRIFailed;' +
								'STRING8 OtherPhone' + %'cntPhone'% + '_LastPortedDate;' +
								'STRING10 OtherPhone' + %'cntPhone'% + '_StreetNumber;' +
								'STRING2  OtherPhone' + %'cntPhone'% + '_StreetPreDirection;' +
								'STRING28 OtherPhone' + %'cntPhone'% + '_StreetName;' +
								'STRING4  OtherPhone' + %'cntPhone'% + '_StreetSuffix;' +
								'STRING2  OtherPhone' + %'cntPhone'% + '_StreetPostDirection;' +
								'STRING10 OtherPhone' + %'cntPhone'% + '_UnitDesignation;' +
								'STRING8  OtherPhone' + %'cntPhone'% + '_UnitNumber;' +
								'STRING25 OtherPhone' + %'cntPhone'% + '_City;' +
								'STRING2  OtherPhone' + %'cntPhone'% + '_State;' +
								'STRING5  OtherPhone' + %'cntPhone'% + '_Zip5;' +
								'STRING4  OtherPhone' + %'cntPhone'% + '_Zip4;' +
								'STRING18 OtherPhone' + %'cntPhone'% + '_County;' +
								'STRING8  OtherPhone' + %'cntPhone'% + '_DateFirstSeen;' +
								'STRING8  OtherPhone' + %'cntPhone'% + '_DateLastSeen;' +
								'STRING8  OtherPhone' + %'cntPhone'% + '_MonthsWithPhone;' +
								'STRING8  OtherPhone' + %'cntPhone'% + '_MonthsSinceLastSeen;' +
								'BOOLEAN  OtherPhone' + %'cntPhone'% + '_PhoneOwnershipIndicator;' +
								'STRING15  OtherPhone' + %'cntPhone'% + '_CallForwardingIndicator;');
				#SET(cntPhone,%cntPhone% + 1)
			#END
		#END
		
		#DECLARE(PhoneHistoryInfo);
		#DECLARE(cntPhoneHist);
		
		#SET(PhoneHistoryInfo,'');
		#SET(cntPhoneHist,1);
		
		#LOOP
			#IF(%cntPhoneHist% > iesp.Constants.Phone_Finder.MaxPhoneHistory)
				#BREAK;
			#ELSE
				#APPEND(PhoneHistoryInfo,
								'STRING62 PhoneHist' + %'cntPhoneHist'% + '_Full;' +
								'STRING20 PhoneHist' + %'cntPhoneHist'% + '_First;' +
								'STRING20 PhoneHist' + %'cntPhoneHist'% + '_Middle;' +
								'STRING20 PhoneHist' + %'cntPhoneHist'% + '_Last;' +
								'STRING5  PhoneHist' + %'cntPhoneHist'% + '_Suffix;' +
								'STRING3  PhoneHist' + %'cntPhoneHist'% + '_Prefix;' +
								'STRING10 PhoneHist' + %'cntPhoneHist'% + '_StreetNumber;' +
								'STRING2  PhoneHist' + %'cntPhoneHist'% + '_StreetPreDirection;' +
								'STRING28 PhoneHist' + %'cntPhoneHist'% + '_StreetName;' +
								'STRING4  PhoneHist' + %'cntPhoneHist'% + '_StreetSuffix;' +
								'STRING2  PhoneHist' + %'cntPhoneHist'% + '_StreetPostDirection;' +
								'STRING10 PhoneHist' + %'cntPhoneHist'% + '_UnitDesignation;' +
								'STRING8  PhoneHist' + %'cntPhoneHist'% + '_UnitNumber;' +
								'STRING25 PhoneHist' + %'cntPhoneHist'% + '_City;' +
								'STRING2  PhoneHist' + %'cntPhoneHist'% + '_State;' +
								'STRING5  PhoneHist' + %'cntPhoneHist'% + '_Zip5;' +
								'STRING4  PhoneHist' + %'cntPhoneHist'% + '_Zip4;' +
								'STRING18 PhoneHist' + %'cntPhoneHist'% + '_County;' +
								'STRING8  PhoneHist' + %'cntPhoneHist'% + '_FirstSeen;' +
								'STRING8  PhoneHist' + %'cntPhoneHist'% + '_LastSeen;');
				#SET(cntPhoneHist,%cntPhoneHist% + 1)
			#END
		#END


		#DECLARE(PortingHistory);
		#DECLARE(cntPorts);
		
		#SET(PortingHistory,'');
		#SET(cntPorts,1);
		
		#LOOP
			#IF(%cntPorts% > iesp.Constants.Phone_Finder.MaxPorts)
				#BREAK;
			#ELSE
				#APPEND(PortingHistory,
								'STRING PortingHistory' + %'cntPorts'% + '_ServiceProvider;' +
								'STRING8 PortingHistory' + %'cntPorts'% + '_PortStartDate;' +
								'STRING8 PortingHistory' + %'cntPorts'% + '_PortEndDate;');
				#SET(cntPorts,%cntPorts% + 1)
			#END
		#END
			
		#DECLARE(SpoofingHistory);
		#DECLARE(cntSpoofs);
		
		#SET(SpoofingHistory,'');
		#SET(cntSpoofs,1);
		
		#LOOP
			#IF(%cntSpoofs% > iesp.Constants.Phone_Finder.MaxSpoofs)
				#BREAK;
			#ELSE
				#APPEND(SpoofingHistory,
								'STRING1 SpoofingHistory' + %'cntSpoofs'% + '_PhoneOrigin;' +
								'STRING8 SpoofingHistory' + %'cntSpoofs'% + '_EventDate;');
				#SET(cntSpoofs,%cntSpoofs% + 1)
			#END
		#END		
	
		#DECLARE(OTPHistory);
		#DECLARE(cntOTPs);
		
		#SET(OTPHistory,'');
		#SET(cntOTPs,1);
		
		#LOOP
			#IF(%cntOTPs% > PhoneFinder_Services.Constants.MaxOTPMatches)
				#BREAK;
			#ELSE
				#APPEND(OTPHistory,
								'BOOLEAN OTPHistory' + %'cntOTPs'% + '_OTPStatus;' +
								'STRING8 OTPHistory' + %'cntOTPs'% + '_EventDate;');
				#SET(cntOTPs,%cntOTPs% + 1)
			#END
		#END			
		
		#DECLARE(RoyaltyInfo);
		#DECLARE(cntRoyalty);
		
		#SET(RoyaltyInfo,'');
		#SET(cntRoyalty,1);
		
		#LOOP
			#IF(%cntRoyalty% > PhoneFinder_Services.Constants.MaxRoyalties)
				#BREAK;
			#ELSE
				#APPEND(RoyaltyInfo,
								'TYPEOF(Royalty.Layouts.Royalty.royalty_type) royalty_type_' + %'cntRoyalty'% + ';' +
								'TYPEOF(Royalty.Layouts.RoyaltySrc.royalty_src) royalty_src_' + %'cntRoyalty'% + ';');
				#SET(cntRoyalty,%cntRoyalty% + 1)
			#END
		#END
		
		EXPORT BatchOut :=
		RECORD,MAXLENGTH(20000)
			BatchIn;
			%IdentityInfo%
			%OtherPhones%
			%PhoneHistoryInfo%
			STRING   Number;
			STRING   _Type;
			STRING   Carrier;
			STRING   CarrierCity;
			STRING   CarrierState;
			STRING   ListingName;
			STRING   PhoneStatus;
			STRING   ListingType;
			STRING   PrivacyIndicator;
			STRING   MSA;
			STRING   CMSA;
			STRING   FIPS;
			STRING   CarrierRoute;
			STRING   CarrierRouteZoneCode;
			STRING   CongressionalDistrict;
			STRING   DeliveryPointCode;
			STRING10 Latitude;
			STRING11 Longitude;
			STRING   AddressType;
			STRING   PortingCode;
			UNSIGNED1 PortingCount;
			UNSIGNED4 FirstPortedDate;
			UNSIGNED4 LastPortedDate;
			UNSIGNED4 ActivationDate;
			UNSIGNED4 DisconnectDate;	
			BOOLEAN 	NoContractCarrier;
			BOOLEAN 	Prepaid;				
			STRING10 PortingStatus;
			%PortingHistory%
			BOOLEAN Spoof_Spoofed;
			UNSIGNED Spoof_SpoofedCount;
			UNSIGNED4 Spoof_FirstSpoofedDate;
			UNSIGNED4 Spoof_LastSpoofedDate;
			BOOLEAN Destination_Spoofed;
			UNSIGNED Destination_SpoofedCount;
			UNSIGNED4 Destination_FirstSpoofedDate;
			UNSIGNED4 Destination_LastSpoofedDate;	
			BOOLEAN Source_Spoofed;
			UNSIGNED Source_SpoofedCount;
			UNSIGNED4 Source_FirstSpoofedDate;
			UNSIGNED4 Source_LastSpoofedDate;	
			UNSIGNED TotalSpoofedCount;
			UNSIGNED4 FirstEventSpoofedDate;
			UNSIGNED4 LastEventSpoofedDate;	
			%SpoofingHistory%
			BOOLEAN 	OTPMatch;
			UNSIGNED2 OTPCount;
			UNSIGNED4 FirstOTPDate;
			UNSIGNED4 LastOTPDate;
			BOOLEAN 	LastOTPStatus;		
			%OTPHistory%
			STRING4 PhoneRiskIndicator;
			BOOLEAN OTPRIFailed;
			%Alerts%
			STRING15 CallForwardingIndicator;
			string100 PhoneVerificationDescription;
			boolean PhoneVerified;
			STRING   CallerID;
			STRING   CompanyNumber;
			STRING   Name;
			STRING10 StreetNumber;
			STRING2  StreetPreDirection;
			STRING28 StreetName;
			STRING4  StreetSuffix;
			STRING2  StreetPostDirection;
			STRING10 UnitDesignation;
			STRING8  UnitNumber;
			STRING60 StreetAddress1;
			STRING60 StreetAddress2;
			STRING25 City;
			STRING2  State;
			STRING5  Zip5;
			STRING4  Zip4;
			STRING18 County;
			STRING9  PostalCode;
			STRING50 StateCityZip;
			STRING   AffiliatedTo;
			STRING62 ContactName_Full;
			STRING20 ContactName_First;
			STRING20 ContactName_Middle;
			STRING20 ContactName_Last;
			STRING5  ContactName_Suffix;
			STRING3  ContactName_Prefix;
			STRING10 ContactAddress_StreetNumber;
			STRING2  ContactAddress_StreetPreDirection;
			STRING28 ContactAddress_StreetName;
			STRING4  ContactAddress_StreetSuffix;
			STRING2  ContactAddress_StreetPostDirection;
			STRING10 ContactAddress_UnitDesignation;
			STRING8  ContactAddress_UnitNumber;
			STRING60 ContactAddress_StreetAddress1;
			STRING60 ContactAddress_StreetAddress2;
			STRING25 ContactAddress_City;
			STRING2  ContactAddress_State;
			STRING5  ContactAddress_Zip5;
			STRING4  ContactAddress_Zip4;
			STRING18 ContactAddress_County;
			STRING9  ContactAddress_PostalCode;
			STRING50 ContactAddress_StateCityZip;
			STRING   Email;
			STRING   ContactPhone;
			STRING   ContactPhoneExt;
			STRING   Fax;
			%RoyaltyInfo%
			BatchShare.Layouts.ShareErrors;
		END;
	
	END;
	
	EXPORT SubjectPhone := RECORD
			STRING20 	acctno;
			UNSIGNED6 DID;
			STRING10  phone;
			UNSIGNED4 FirstSeenDate;
			UNSIGNED4 LastSeenDate;
	END;

	// Deltabase Layouts
	EXPORT DeltaPortedDataRecord := RECORD
		 UNSIGNED   transaction_id				{XPATH('id')};
		 STRING     date_added				  	{XPATH('date_added')};	
		 STRING10   phone				  				{XPATH('phone')};	
		 STRING10   spid				  				{XPATH('spid')};	
		 STRING5    source				  			{XPATH('source')};
		 UNSIGNED4  port_start_dt				  {XPATH('port_start_dt')};
		 UNSIGNED4  port_end_dt					  {XPATH('port_end_dt')};
		 BOOLEAN	  is_ported						  {XPATH('is_ported')};
	END;	
	
	EXPORT PortedMetadata := RECORD
		RECORDOF(PhonesInfo.Key_Phones.Ported_Metadata);	
	END;	
	
	EXPORT DeltabaseResponse := RECORD                         
		DATASET (DeltaPortedDataRecord) Records	 {XPATH('Records/Rec'), MAXCOUNT(PhoneFinder_Services.Constants.MaxPortedMatches)};
		STRING  RecsReturned                     {XPATH('RecsReturned'),MAXLENGTH(5)};
		STRING  Latency													 {XPATH('Latency')};
		STRING  ExceptionMessage								 {XPATH('Exceptions/Exception/Message')};
	END;			
	EXPORT DeltaSpoofedRec := RECORD
		 UNSIGNED   id										{XPATH('id')};
		 STRING     date_added				  	{XPATH('date_added')};	
		 STRING45   reference_id					{XPATH('reference_id')};
		 STRING20   mode_type						  {XPATH('mode_type')};
		 STRING 		event_time						{XPATH('event_time')};
		 STRING10   spoofed_phone_number	{XPATH('spoofed_phone_number')};
		 STRING10   destination_number		{XPATH('destination_number')};
		 STRING10   source_phone_number		{XPATH('source_phone_number')};
	END;	
	EXPORT SpoofDeltabaseResponse := RECORD                         
		DATASET (DeltaSpoofedRec) 			Records	{XPATH('Records/Rec'), MAXCOUNT(PhoneFinder_Services.Constants.MaxSpoofedMatches)};
		STRING  RecsReturned                    {XPATH('RecsReturned'),MAXLENGTH(5)};
		STRING  Latency													{XPATH('Latency')};
		STRING  ExceptionMessage								{XPATH('Exceptions/Exception/Message')};
	END;	
	EXPORT DeltaOTPRec := RECORD
		 STRING20  	transaction_id				{XPATH('transaction_id')};
		 STRING     date_added				  	{XPATH('date_added')};	
		 STRING 		event_time						{XPATH('event_time')};
		 STRING 		function_name					{XPATH('function_name')};
		 STRING10   otp_phone							{XPATH('otp_phone')};
		 BOOLEAN    verify_passed					{XPATH('verify_passed')};
		 STRING20   otp_id								{XPATH('otp_id')};
		 STRING1    otp_delivery_method		{XPATH('otp_delivery_method')};
	END;	
	EXPORT OTPDeltabaseResponse := RECORD                         
		DATASET (DeltaOTPRec) 					Records		{XPATH('Records/Rec'), MAXCOUNT(PhoneFinder_Services.Constants.MaxOTPMatches)};
		STRING  RecsReturned                     	{XPATH('RecsReturned'),MAXLENGTH(5)};
		STRING  Latency													 	{XPATH('Latency')};
		STRING  ExceptionMessage								 	{XPATH('Exceptions/Exception/Message')};
	END;			
	EXPORT SpoofedRec := RECORD
		RECORDOF(PhoneFraud.Key_Spoofing);
	END;	
	EXPORT OTPRec := RECORD
		RECORDOF(PhoneFraud.Key_OTP);
	END;
	
	EXPORT DeltaInquiryDataRecord := RECORD
	    	UNSIGNED8    seq {XPATH('Seq')};
				STRING10     phone {XPATH('Phone')};
	END;
	EXPORT DeltaInquiryDeltabaseResponse := RECORD                         
		DATASET (DeltaInquiryDataRecord) Response {XPATH('Records/Rec')};
		STRING  RecordsReturned                  	{XPATH('RecsReturned'),MAXLENGTH(5)};
		STRING  Latency													 	{XPATH('Latency')};
		STRING  ExceptionMessage								 	{XPATH('Exceptions/Exception/Message')};
	END;			
	
	EXPORT DeltaInquiry_recout := RECORD
	  UNSIGNED8    seq;
		STRING10     phone;
	  UNSIGNED RecordsReturned;
	END;
    
  EXPORT Input_CompanyId := RECORD
		STRING16  CompanyId;
	END;

	EXPORT PFResSnapShotSearch := RECORD
    STRING8 StartDate;
    STRING8 EndDate;
    STRING60 UserId;
    DATASET(Input_CompanyId) CompanyIds {MAXCOUNT(iesp.Constants.PfResSnapshot.MaxCompanyIds)};
    STRING15 PhoneNumber; 		
    STRING60 ReferenceCode;
    UNSIGNED8 UniqueId;
	END;
	
	//	DeltaPhones
	EXPORT delta_phones_rpt_transaction := record
   		STRING16 transaction_id;
		STRING32 transaction_date;
		STRING60 user_id;
		STRING8 product_code;
		STRING16 company_Id;
		STRING8 source_code; 		
   		STRING60 reference_code;
   		STRING32 phonefinder_type;
		//SearchTerms
		STRING32 submitted_lexid;
		STRING15 submitted_phonenumber;
		STRING20 submitted_firstname;
		STRING20 submitted_lastname;
		STRING20 submitted_middlename;
		STRING128 submitted_streetaddress1;
		STRING64 submitted_city;
		STRING16 submitted_state;
		STRING10 submitted_zip;
		//Primary Phone details
        STRING30 data_source;
   		STRING30 royalty_used;  
   		STRING30 carrier;
   		STRING15 phonenumber;
   		STRING16 risk_indicator;
   		STRING32 phone_type;
   		STRING32 phone_status;
   		Integer  ported_count;
		STRING32 last_ported_date; 
   		INTEGER  otp_count;
   		STRING32 last_otp_date;
   		integer  spoof_count;
   		STRING32 last_spoof_date;
   		STRING32 phone_forwarded;
   END;
		
	EXPORT	delta_phones_rpt_otherphones:= record
   		string16 transaction_id;
   		Integer sequence_number;
		Integer phone_id;
   		string15 phonenumber;
		string16 risk_indicator;
   		string32 phone_type;
   		string32 phone_status;
   		string64 listing_name;
   		string16 porting_code;
   		string32 phone_forwarded;
   		Integer1	verified_carrier; 
	END;
   	
   EXPORT	delta_phones_rpt_identities:= record
   		string16 transaction_id;
   		Integer  sequence_number;
		string32 lexid;
   		string128 full_name;
   		string128 full_address;
   		string64 city;
   		string16 state;
   		string10 zip;
   		Integer1	 verified_carrier; 
   	END;

	EXPORT delta_phones_rpt_riskindicators:= record
        string16 transaction_id;
        integer phone_id;
        integer sequence_number;
	    string256 risk_indicator_text;		 	
	    integer risk_indicator_id;
        string16 risk_indicator_level;
        string32 risk_indicator_category;
   END;
	 
	EXPORT delta_phones_rpt_Usage_records := RECORD
	   DATASET(delta_phones_rpt_transaction) delta_phones_rpt_transaction {xpath('delta__phonefinder_delta__phones_rpt__transaction/Row')};
       DATASET(delta_phones_rpt_otherphones) delta_phones_rpt_otherphones {xpath('delta__phonefinder_delta__phones_rpt__otherphones/Row')};
       DATASET(delta_phones_rpt_identities) delta_phones_rpt_identities {xpath('delta__phonefinder_delta__phones_rpt__identities/Row')};
       DATASET(delta_phones_rpt_riskindicators) delta_phones_rpt_riskindicators {xpath('delta__phonefinder_delta__phones_rpt__riskindicators/Row')};
	END;
	
END;