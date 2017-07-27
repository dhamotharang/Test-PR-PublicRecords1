export _Documentation :='';

//WARNING: Do not run twice with the same monthly load or you will have the same monthly data load
//		twice in the base file; MOVE father back to child before re-running.

// Background:
// The Certegy data is a nationwide listing of names, addresses and driver’s license information
// that is compiled though a check verification service. 

// The file contains information on individuals only. The identification information is collected from
// consumer supplied feedback that is collected from stores and check cashing facilities. The source receives
// information that is both hand written and swiped.

// The information comes directly from a driver’s license that the consumer provides.

// The initial file received from CERTEGY totaled 169,200,000 records. The data file covers
// 50 states plus DC. Per the source, approximately 16% (YY2004: 530,312/3,196,348) of their claims
// (a.k.a. bad checks) become, what they define as fraud, forgery, or stolen.

// Operation:
// Every month data receiving drops the vendor file to '/load01/choicepoint_inbound/certegy/yyyymmdd/.'
// Certegy.BWR_build_certegy does the rest after Certegy.version is changed to the correct date.

// Note:
// Drop directory name should match file name. example: if the vendor file was named 081213_certextr.dat
// the drop directory should be '/load01/choicepoint_inbound/certegy/20081213/'
