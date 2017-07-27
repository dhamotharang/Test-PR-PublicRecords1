//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert2Strings() function
// -- Pass it the segment code(ex, '0010') and the output file
// -- it will convert the binary fields to strings
//////////////////////////////////////////////////////////////////////////////////////////////
import ut, Business_Header, Business_Header_SS, did_add, address;

export Convert2Strings(segment_code, File_Out) := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(File_Base)
#uniquename(File_In)
#uniquename(Layout_Base)
#uniquename(Layout_In)
#uniquename(Layout_New_Base)
#uniquename(t2strings)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Input Files
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.GetSegmentFile_Base(	segment_code, %File_Base%)
ebr.GetSegmentFile_In(	segment_code, %File_In%)
%Layout_Base%	:= recordof(%File_Base%);
%Layout_In%	:= recordof(%File_In%);

//#if(segment_code != '5610' and segment_code != '2020' and segment_code != '2025' and segment_code != '6000')
	%Layout_New_Base% := 
	record
		ebr.Layout_Base_ASCII;
		%Layout_In%;
	end;
//#end

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert binary fields to strings
//////////////////////////////////////////////////////////////////////////////////////////////
%Layout_New_Base% %t2strings%(%Layout_Base% l) := 
transform
	self.bdid 				:= if (l.bdid = 0,'',intformat(l.bdid, 12, 1));
	self.date_first_seen		:= l.date_first_seen;
	self.date_last_seen 		:= l.date_last_seen;
	self.process_date_first_seen	:= intformat(l.process_date_first_seen,8,1);
	self.process_date_last_seen 	:= intformat(l.process_date_last_seen,8,1);
	self.record_type			:= l.record_type;
	self 					:= l;
end;

File_Out := project(%File_Base%, %t2strings%(left));

endmacro;
