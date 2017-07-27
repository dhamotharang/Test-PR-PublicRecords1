export Layout_Edgar_Company_In := record
	String60 companyName; // Conformed Company Name
	String20 accNumber; // Document Accession number
	String20 taxid; // Company tax id
	String20 formtype; // Source document type (10K or DEF14A)
	String20 incState; // State of Incorporation
	String20 fiscalyear; // Month/day of fiscal year end
	String20 cikcode; // SEC CIK code (unique company identifier)
	String20 sicCode; // Standard Industry Classification for the company
	// Business address
	String40 busstreet1;
	String40 busstreet2;
	String40 buscity;
	String40 busstate;
	String40 buszip;
	String40 busphone;
	// Mailing address
	String40 mailstreet1;
	String40 mailstreet2;
	String40 mailcity;
	String40 mailstate;
	String40 mailzip;
	String40 mailphone;
end;