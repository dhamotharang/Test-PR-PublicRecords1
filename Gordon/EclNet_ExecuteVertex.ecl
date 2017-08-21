/*--SOAP-- 
<message name="EdgarFindConnections">
<part name="Category" type="xsd:integer"/>
<part name="ID" type="xsd:string"/>
</message>
*/
/*--INFO-- NOT FOR DIRECT USE.  
*/
/*--HELP--
This is designed to be called from another program.  However, if you want to use it, type an id number
into each of the two fields
*/

export EclNet_ExecuteVertex := 
	macro
integer class := 0 : stored('Category');
string128 tag := 'KEN HAWK' : stored('ID');

// Since each web macro is called only once, don't need the uniquename
db := Edgar.File_Data_With_DID;

nameindexrec := record
string80 name := stringlib.stringfilterout(trim(db.firstname) + trim(db.middlename) + trim(db.lastname), ' ');
unsigned8 filepos := db.filepos;
end;

companyindexrec := record
string80 coname := stringlib.stringfilterout(trim(db.CompanyPrime)+ trim(db.companysecond), ' ');
unsigned8 filepos := db.filepos;
end;
//buildindex(db, nameindexrec, '~thor_marketing::edgar::dataDIDnameindex', overwrite);
//buildindex(db, companyindexrec, '~thor_marketing::edgar::dataDIDCoindex', overwrite);

nameindex := index(db, nameindexrec, '~thor_marketing::edgar::dataDIDnameindex');
companyindex := index(db, companyindexrec, '~thor_marketing::edgar::dataDIDCoindex');

#uniquename(nspacetag)
%nspacetag% := stringlib.stringfilterout(tag,' ');
// Suffix not currently used for match (not great, but will fix it later)
//nspacetag := trim(tag);

db copydb(db l) := TRANSFORM
	self := l;
end;
/*
// Get the matching sets
#uniquename(companiestosend)
%companiestosend% := fetch(db, nameindex(name = trim(%nspacetag%)), RIGHT.filepos, copydb(left));
#uniquename(namestosend)
%namestosend% := fetch(db, companyindex(coname = trim(%nspacetag%)), right.filepos, copydb(left));
*/ 
// Get the matching sets - workaround for bug in fetch
integer trimlen(string l) := length(trim(l));
#uniquename(companiestosend)
%companiestosend% := fetch(db, nameindex(name[1..trimlen(%nspacetag%)] = %nspacetag%), RIGHT.filepos); //, copydb(left));
#uniquename(namestosend)
ns1 := fetch(db, companyindex(coname[1..trimlen(%nspacetag%)] = %nspacetag%), right.filepos); //, copydb(left));
string whichco := stringlib.stringfilterout(trim(ns1.CompanyPrime)+ trim(ns1.companysecond), ' ');
%namestosend% := ns1(whichco = %nspacetag%);

#uniquename(whichtouse)
%whichtouse% := if (class = 0, %companiestosend%, %namestosend%);

// Add a space after the items to send because of STRING/VARSTRING conversion issue in release.
// This shouldn't affect anything when this gets fixed, since the first line will remove the extra space
// if it exists.
// Extra space is removed 10/30 - bug is gone, and it's confusing the visualizer
#uniquename(namesend)
%namesend% := trim(trim(%whichtouse%.firstname) + 
		if(trim(%whichtouse%.middlename) != '', ' ','') + trim(%whichtouse%.middlename)
		 + ' ' + trim(%whichtouse%.lastname));
#uniquename(companysend)
%companysend% := trim(trim(%whichtouse%.CompanyPrime) + ' ' + trim(%whichtouse%.companysecond));
// Class 0 is a name
// Class 1 is a company
#uniquename(graph_edge_record)
%graph_edge_record% := 
	record
		unsigned1 category := 0; // only one type
		unsigned1 from_category := class;
		varstring from_id := trim(tag); 
		unsigned1 to_category := if(class = 0, 1, 0);
		varstring to_id := if (class = 0, %companysend%, %namesend%);
		varstring reclabel1 := 'Testing 1';
		varstring reclabel2 := 'Testing 2';
		varstring reclabel3 := 'Testing 3';
		varstring reclabel4 := 'Testing 4';
end;

output(table(%whichtouse%, %graph_edge_record%), named('edges'));

#uniquename(graph_vertex_record)
%graph_vertex_record% := 
	record
		unsigned1 category := if(class = 0,1,0);
		varstring id := if (class = 0, %companysend%, %namesend%);
		varstring label := if (class = 0, %companysend%, %namesend%);
	end;
// just have to send category (int1) and id

output(table(%whichtouse%, %graph_vertex_record%), named('vertices'))
	endmacro;