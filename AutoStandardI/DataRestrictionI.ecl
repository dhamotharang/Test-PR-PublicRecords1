// !!!NOTE1: ECL developers:  
//           If you want to add coding to use a new position to restrict certain data, 
//           FIRST THE PRODUCT OR PROJECT MANAGER SHOULD CREATE AN ISIT TICKET DESCRIBING WHAT
//           DATA IS TO BE RESTRICTED AND THE REQUEST SHOULD BE COMMUNICATED TO: 
//           RIS-BCT BTRequests <-----------------***
//           Once the request is approved and processed, then the requestor should inform you 
//           of which DRM position should be used.  You can't jsut assume the next available 
//           position will be used because multiple new DRM requests could be in process at the
//           same time.

// NOTE2: To understand this code, it's critical to understand that
//       DataRestrictionMask is a string, _not_ an integer.  Each
//       position in the string controls a particular source, so
//       for example "1" and "00001" are completely different.

import ut, mdr;

export DataRestrictionI := module

	export params := interface(AutoStandardI.PermissionI_Tools.params)
		// DataRestrictionMask: is controlled administratively to prevent viewing of
		// certain types of data.  If not entered, it is set to a default in 
		// AutoStandardI.GlobalModule.
		export string DataRestrictionMask;
		// ignoreFares and ignoreFidelity are caller controlled options meaning caller wants to
		// opt out of information they have the authority to view
		// NOTE The difference between "DataRestrictionMask" and "ignoreFares" /"IgnoreFidelity"
		export boolean ignoreFares;
		export boolean ignoreFidelity;
	end;

	export val(params in_mod) := module
		shared drm_type := string50;
		shared allow := AutoStandardI.PermissionI_Tools.val(in_mod).AllowAll_value;
		export drm_type fixed_DRM := in_mod.DataRestrictionMask;
		shared string1 DRM_bit(drm_type drm, unsigned1 b) := IF(drm<>'', drm[b], fixed_DRM[b]);

		export FARES := (~allow and fixed_DRM[1]<>'0') OR in_mod.ignoreFares; // Fares=property data
		export QSENT := ~allow and fixed_DRM[2]<>'0'; // QSent = realtime phones gateway
		export EBR	 := ~allow and fixed_DRM[3]<>'0'; // EBR=Experian Business Reports
		export WH		 := ~allow and fixed_DRM[4]<>'0'; // WH=Weekly header
		export Fidelity := (~allow and (fixed_DRM[5] not in ['0',''])) OR in_mod.ignoreFidelity;
		// The "Fidelity" clause above differs from the other due to a need for
		// backward compatibility.  For property testing, at least, its been fairly
		// common to set DataRestrictionMask=0 to indicate "I want everything".  To
		// preserve that, I had to include the empty string comparison when I added
		// the Fidelity clause.  I didnt feel comfortable changing the logic in the
		// other clauses to match that, because I have no way of knowing whose test
		// cases or database entries might be counting on the existing behavior to 
		// remain _exactly_ as it is.

		// ECH = Experian Credit Header data
		export boolean isECHRestricted(drm_type drm='') := ~allow and DRM_bit(drm,6)<>'0';
		export boolean ECH := isECHRestricted(fixed_DRM);		
		// CY = Certegy data
		export CY := ~allow and (fixed_DRM[7] not in ['0','']);
		// EQ = Equifax Credit Header data
		export boolean isEQCHRestricted(drm_type drm='') := ~allow and (DRM_bit(drm,8) not in ['0','']);	
		export boolean EQ := isEQCHRestricted(fixed_DRM);
		//Restricting CreditHeader data from being returned in the qsent gateway
		export string1 RequestCredential := if(fixed_DRM[9] = '','0', fixed_DRM[9]);		
		// TCH = Transunion Credit Header data
		export boolean isTCHRestricted(drm_type drm='') := ~allow and (DRM_bit(drm,10) not in ['0','']);	
		export boolean TCH := isTCHRestricted(fixed_DRM);	
		
		export boolean isHeaderSourceRestricted(string src, drm_type data_restriction_mask = '') := MAP(
			MDR.sourceTools.SourceIsExperian_Credit_Header(src) => isECHRestricted(data_restriction_mask),
			MDR.sourceTools.SourceIsTransUnion_Credit_Header(src) => isTCHRestricted(data_restriction_mask),
			MDR.sourceTools.SourceIsEquifax(src) => isEQCHRestricted(data_restriction_mask),
			false);

		// TT = TeleTrack data restriction, position 11
		export TT := ~allow and (fixed_DRM[11] not in ['0','']);
		
		// ADVO = ADVO data restriction, position 12
		export ADVO := ~allow and (fixed_DRM[12] not in ['0','']);
		
		// Bureau Death Records, position 13 
		export BureauDeceasedRecords := ~allow and (fixed_DRM[13] not in ['0','']);
		
		// ECHF = Experian Credit Header FCRA data, position 14
		export ECHF := ~allow and (fixed_DRM[14] not in ['0','']);
		
		// Experian phones (Metronet and Experian File One)
		export ExperianPhones := ~allow and (fixed_DRM[15] not in ['0','']);

		// Inquiries = Customer supplied input data, position 16
		export Inquiries := ~allow and (fixed_DRM[16] not in ['0','']);

		// Infutor motor vehicles, position 17
		export InfutorMV := ~allow and (fixed_DRM[17] not in ['0','']);

		// Infutor watercrafts, position 18
		export InfutorWC := ~allow and (fixed_DRM[18] not in ['0','']);

		// Enclarity = Customer allowed to see Enclarity records or not, position 19
		export EnclarityRecords := ~allow and (fixed_DRM[19] not in ['0','']);

    // Targus gateway for phone finder, position 20
    export PhoneFinderTargus := ~allow and (fixed_DRM[20] not in ['0','']);

    // NCPDP = Customer allowed to see NCPDP records or not, position 21
    export NCPDPRecords := ~allow and (fixed_DRM[21] not in ['0','']);
    export NCPDPFull := ~allow and (fixed_DRM[21] in ['2']);

    // SKA = Customer allowed to see SKA records or not, position 22
    export SKARecords := ~allow and (fixed_DRM[22] not in ['0','']);

		// Customer allowed to see GLB protected data prior to June 2001 ('Pre GLB'), position 23.		
		export restrictPreGLB := ~allow and (fixed_DRM[23] not in ['0','']);

		//Equifax (PhoneMart) phones position 24
		export EquifaxPhoneMart := ~allow and (fixed_DRM[24] not in ['0','']);		

		// FraudDefenseNetwork (FDN) Market Activity/Inquiry data allowed or not, position 25 (Virtual Fraud data)
		export FDNInquiry := ~allow and (fixed_DRM[25] not in ['0','']);
		
		//when I submitted the DRM for Juli they said the next available was 41.

		// Judgments & Liens (JuLi) Toggle use of JuLi dat, position 41 (JuLi data)
		export JuLi_data := ~allow and (fixed_DRM[41] not in ['0','']);
		
		// Cortera data, position 42
		export Cortera := ~allow and (fixed_DRM[42] not in ['0','']);
		
		// ATT LIDB = Line Information DataBase data
		export boolean isATT_LIDBRestricted(drm_type drm='') := ~allow and (fixed_DRM[43] not in ['0','']);
		export boolean ATT_LIDB := isATT_LIDBRestricted(fixed_DRM);	
		
		// AccuData - OCN (Carrier & Porting) & CNAM (CallerID Name)
		export boolean isAccuDataRestricted(drm_type drm='') := ~allow and (fixed_DRM[44] not in ['0','']);
		export boolean AccuData := isAccuDataRestricted(fixed_DRM);		
    
    // not sure where CSR is used
    // CSR := ~allow and (fixed_DRM[45] not in ['0','']);

		// BriteVerify gateway for Emails 
		export boolean BriteVerifyData := ~allow and (fixed_DRM[46] not in ['0','']);

  end;

end;
