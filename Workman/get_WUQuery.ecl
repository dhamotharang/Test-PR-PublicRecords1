/*
  WUQuery gets workunits, archived & not archived
       <Type>archived workunits</Type>
*/
import WsWorkunits;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUQuery := WsWorkunits.soapcall_WUQuery;