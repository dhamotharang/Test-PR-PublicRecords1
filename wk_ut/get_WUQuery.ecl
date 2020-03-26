/*
  WUQuery gets workunits, archived & not archived
       <Type>archived workunits</Type>
*/
import Workman;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUQuery := Workman.get_WUQuery;