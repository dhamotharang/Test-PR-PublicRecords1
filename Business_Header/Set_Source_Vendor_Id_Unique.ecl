// The following source types are considered to have a unique vendor_id which is persistent from
// build to build.  Otherwise is is assumed the vendor_id could change in the source from build
// to build
export Set_Source_Vendor_Id_Unique := 
[
'C ',  // Corporations
'U ',  // UCC
'F ',  // FBN
'D ',  // Dun & Bradstreet
'B ',  // Bankruptcy
'I ',  // IRS5500
'ST',  // CA Sales Tax
'FD',  // FDIC
'SB',  // SEC Broker Dealer
'FN',  // FL Non-Profit Corp
'IN',  // IRS Non-Profit Corp
'PL',  // Professional License
'SK',  // SK&A Medical Professionals
'V',   // Vickers
'CU',   // Credit Unions
'AF',   //ATF Firearms & Explosives
'DC'   // DCA
];