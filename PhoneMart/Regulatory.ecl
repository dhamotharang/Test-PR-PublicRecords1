EXPORT Regulatory := module

  // base layout is copied from PhoneMart

	export layout_PhoneMart_base := RECORD
				STRING10	PHONE;
				UNSIGNED6	DID;
				UNSIGNED4	DT_VENDOR_FIRST_REPORTED;
				UNSIGNED4 DT_VENDOR_LAST_REPORTED;
				UNSIGNED4 DT_FIRST_SEEN;
				UNSIGNED4	DT_LAST_SEEN;
				STRING1		RECORD_TYPE;			//M: CMS, D:CSD, V: INDV
				QSTRING18	CID_NUMBER;
				STRING10	CSD_REF_NUMBER;
				STRING10	OLD_CSD_REF_NUMBER;
				STRING9		SSN;
				STRING80	ADDRESS;					
				STRING28	CITY;
				STRING2		STATE;
				STRING5		ZIPCODE;
				STRING1		HISTORY_FLAG;
				STRING5		TITLE;						//Added for scoring purpose
				STRING20	FNAME;
				STRING20	MNAME;
				STRING20	LNAME;
				STRING5		NAME_SUFFIX;
				UNSIGNED8	ScrubsBits1	:=	0;
				UNSIGNED8	ScrubsBits2	:=	0;
				//CCPA-4 Add new fields for CCPA
				unsigned4 global_sid;
				unsigned8 record_sid;
	end;

	//// PhoneMart dataset
		export applyPhoneMart(ds) := 
				functionmacro
							phoneMartSupHash(recordof(ds) rec) := hashmd5(trim((string10)(rec.phone[4..10] + rec.phone[1..3]), left, right));
							local phoneMartSup := Suppress.applyRegulatory.simple_sup(ds, 'file_phonemart_sup.txt', phoneMartSupHash);
					return Suppress.applyRegulatory.simple_append(ds, 'file_phonemart_inj.thor', PhoneMart.Regulatory.layout_PhoneMart_base);						
				endmacro;				
				
export applyPhoneMartSup_DIDPhone(ds) := 
				functionmacro
						import suppress;			
						PhoneMart_DID_hash(recordof(ds) rec) := hashmd5(intformat(rec.did, 15, 1), trim((string10)(rec.phone[4..10] + rec.phone[1..3]), left, right));				
						local PhoneMart_Suppress := suppress.applyregulatory.simple_sup(ds,'file_phonemart_sup.txt', PhoneMart_DID_hash);

						return PhoneMart_Suppress;
				endmacro;


	export applyPhoneMartSup(ds) := 
				functionmacro
							phoneMartSupHash(recordof(ds) rec) := hashmd5(trim((string10)(rec.phone[4..10] + rec.phone[1..3]), left, right));
							local phoneMartSup := Suppress.applyRegulatory.simple_sup(ds, 'file_phonemart_sup.txt', phoneMartSupHash);
					return phoneMartSup ;
				endmacro;				
	
//
// perform get functions using applyRegulatory
//
		export getPhoneMartSup() := 
				functionmacro						
						import suppress;

						return suppress.applyregulatory.getFile('file_phonemart_sup.txt', suppress.applyregulatory.layout_in);
				endmacro; 

		export getPhoneMartInj() := 
				functionmacro										
						import suppress;

						return	suppress.applyregulatory.getFile('file_phonemart_inj.thor', PhoneMart.regulatory.layout_PhoneMart_base);
				endmacro; 				
end ;
