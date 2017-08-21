//---------------------------------------------------------------------------
// This macro enables a local iterate to assign truly sequential unique IDs 
// to a distributed file.  User passes in the following parameters:
//   ds      : The dataset to be sequenced (already distributed as needed)
//   idfield : The numeric field that will contain the sequence number
//   offset  : The number on which to start the sequence number
//   result  : The name of the resulting dataset
//---------------------------------------------------------------------------
EXPORT MAC_sequence_records_3(ds,idfield,offset,result):=MACRO
  // Add a field "n" that contains the node number each records is on
  #UNIQUENAME(nodenums)
  %nodenums%:=TABLE(ds,{ds,UNSIGNED n:=thorlib.node()+1;});
	// create a small table with one row per node containing the row count for
	// that node in field "c"
  #UNIQUENAME(nodecounts)
  %nodecounts%:=TABLE(%nodenums%,{%nodenums%.n;UNSIGNED c:=COUNT(GROUP);UNSIGNED o:=0;},n);
	// The field "o" is the offset plus the total number of records in all
	// rows prior to the current one
  #UNIQUENAME(nodeoffsets)
  %nodeoffsets%:=ITERATE(%nodecounts%,TRANSFORM(RECORDOF(%nodecounts%),SELF.o:=IF(LEFT.c=0,offset,LEFT.o+LEFT.c);SELF:=RIGHT;));
	// Joining the node table back to the original will give each row an
	// offset for beginning the sequence ON THAT NODE
  #UNIQUENAME(readytosequence)
  %readytosequence%:=JOIN(%nodenums%,%nodeoffsets%,LEFT.n=RIGHT.n,MANY LOOKUP);
	// Now the iterate can be local by simply initializing the first row on each
	// node to the node offset, and then counting from there.
  #UNIQUENAME(sequenced)
  %sequenced%:=ITERATE(%readytosequence%,TRANSFORM(RECORDOF(%readytosequence%),SELF.idfield:=IF(LEFT.n=RIGHT.n,LEFT.idfield+1,RIGHT.o);SELF:=RIGHT;),LOCAL);
	// Return the sequenced table in the original layout of the file
  result:=PROJECT(%sequenced%,TRANSFORM(RECORDOF(ds),SELF:=LEFT;),LOCAL);
ENDMACRO;



