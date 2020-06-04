EXPORT Layout_Port := MODULE

		//Telo Input
		EXPORT Daily_Common := RECORD
			UNSIGNED8 number;								//number block
			UNSIGNED8 updated;							//Unix timestamp of record modification
			UNSIGNED8 ActivationTimestamp;  //SP provided timestamp for when the record becomes active
			STRING19 	DatabaseName;					//which database owns the record
			STRING17 	DownloadReason;				//new, modified, audit-discrepency, or delete for the entry
			UNSIGNED4 Id;										//internal record ID
			STRING4 	LnpType;							//- LNP type
			UNSIGNED8 Lrn;									//routing number
			STRING2 	Object;								//PB (number pool block) or SV (subscription version)
			STRING1 	Operation;						//M(odify) or D(delete)
			STRING4 	Spid;									//service provider ID
			UNSIGNED8 Tn;										//telephone number
			UNSIGNED4 UniqueID;							//NPAC record unique ID
			STRING24 	SvType;								//number service type
			STRING6 	CnamDPC;							//destination point code for CNAM service
			BOOLEAN 	CnamSSN;							//subsystem number for CNAM service
			STRING17 	OperationTimestamp;		//timestamp of when the operation was performed by the service provider
			STRING6 	LidbDPC;							//destination point code for LIDB service
			BOOLEAN 	LidbSSN;							//subsystem number for LIDB service
			STRING6 	ClassDPC;							//destination point code for CLASS service
			BOOLEAN 	ClassSSN;							//subsystem number for CLASS service
			UNSIGNED8 AltEulv;							//alternative EULV
			STRING4 	AltSpid;							//alternative SPID
			UNSIGNED1 AltEult;							//alternative EULT
			STRING4 	AltBid;								//alternative BID
			STRING6 	IsvmDPC;							//destination point code for ISVM service
			BOOLEAN 	IsvmSSN;							//subsystem number for ISVM service
			STRING6 	WsmscDPC;							//destination point code for WSMS service
			BOOLEAN 	WsmscSSN;							//subsystem number for WSMS service
			STRING38 	MmsUri;								//URI for MMS messages
			STRING38 	SmsUri;								//URI for SMS messages
		END;
		
		EXPORT Daily := RECORD
			Daily_Common;
			STRING255 filename{VIRTUAL (logicalfilename)}; //Logical File Name (Must Force to Thor to View)
		END;
		
		EXPORT History := RECORD
			Daily_Common;
			STRING255 filename;
		END;
	
END;