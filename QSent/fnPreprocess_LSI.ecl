import lib_stringlib, lssi;

export fnPreprocess_LSI(dataset(qsent.Layout_Qsent.lsi) inputfile) := function 

qsent.Layout_Qsent.common reformat(inputfile l) := transform

/* FUNCTION CALL - W20090512-092724 Dataland
// To pull out a normal field use find_field_lst(field, fieldname2)
// To pull out a listinfo field use find_field_lst(field, fieldname2, 'p') - P is for pluck b/c you pluck the data out of field
// Another option available is clean find_field_lst(field, fieldname2, 'c') - view the "Pluckable" fields as [FIELDNAME]=[FIELD] as in the data
*/

find_field(string field, string fieldname2) := function
			fieldname := stringlib.stringtouppercase(fieldname2);
			out := trim(regexreplace('.*=',regexreplace('\\|.*',field[stringlib.stringfind(stringlib.stringtouppercase(field), fieldname+'=',1)..500], ''), ''), left, right);
return out;
end;

find_field_lst(string field, string fieldname2, string flag = '') := function
	fieldname := stringlib.stringtouppercase(fieldname2);

	upCase	:= if(regexfind(fieldname,stringlib.stringtouppercase(field)), stringlib.stringtouppercase(field), '');
	
	startL	:= stringlib.stringfind(upcase, '|LISTINFODESC',1);
	endL 		:= length(upcase) - stringlib.stringfind(StringLib.StringReverse(upcase), '=OFNITSIL',1);
	findEnd	:= upcase[startL..endL] + regexreplace('\\|.*', upcase[endL+1..endL+500], '');
	
	clean		:= regexreplace('^;;',regexreplace('\\|',regexreplace('LISTINFO=',regexreplace('\\|LISTINFODESC=', findEnd, ';;'), '='), '') + '|', '|');

	plucked := find_field(regexreplace('^\\|',regexreplace(';;',clean,'|'), ''), fieldname);
	
	out			:= if(flag in ['P','p'], plucked, if(flag in ['C','c'], clean, find_field(field, fieldname2)));

return out;
end;
  self.file := 'I';
  self.RECID:=find_field_lst(l.field, 'SEISINTID');
  self.xcode	:=	find_field_lst(l.field, 'I/O');
  self.lsttyp	:=	regexreplace('[^0-9]',regexreplace('LP' ,regexreplace('NL' ,regexreplace('NP' ,find_field_lst(l.field, 'SEC'), '3'), '2'), '1'), '');
  self.npa	:=	find_field_lst(l.field, 'NPA');
  self.telno	:=	regexreplace('[^0-9]',find_field_lst(l.field, 'TELNO'), '');
  self.lststy	:=	'';
  self.indent	:=	find_field_lst(l.field, 'LEV');
  self.split	:=	trim(find_field_lst(l.field, 'LISTSPLIT'), all);
  self.fsn	:=	find_field_lst(l.field, 'NAME') + ' ' + find_field(l.field, 'GN');
  self.ftd	:=	'';
  self.lstnm	:=	find_field_lst(l.field, 'NAME');
  self.lstgn	:=	find_field_lst(l.field, 'GN');
  self.hseno	:=	find_field_lst(l.field, 'HN');
  self.hsesx	:=	'';
  self.strt	:=	find_field_lst(l.field, 'STREET');
  self.locnm	:=	find_field_lst(l.field, 'LOC');
  self.state	:=	find_field_lst(l.field, 'ST');
  self.dirtx	:=	find_field_lst(l.field, 'DWELLING');
  self.zip	:=	find_field_lst(l.field, 'ZIP');
  self.spltx	:=	find_field_lst(l.field, 'SPECTXT');
  self.nstel	:=	find_field_lst(l.field, 'SEC');
  self.COUNTY	:=	find_field_lst(l.field, 'CNTY');
  self.dwelling	:=	'';
  self.geo_acc	:=	find_field_lst(l.field, 'GEOACC');
  self.geo_lat	:=	find_field_lst(l.field, 'DLAT');
  self.geo_long	:=	find_field_lst(l.field, 'DLON');
  self.mailable	:=	find_field_lst(l.field, 'MAILVFD');
  self.orig_loc	:=	find_field_lst(l.field, 'ORIGLOC', 'P');
  self.orig_state	:=	'';
  self.orig_hseno	:=	'';
  self.orig_hsesx	:=	'';
  self.orig_strt	:=	find_field_lst(l.field, 'ORIGSTREET', 'P');
  self.orig_npa	:=	'';
  self.orig_telno	:=	'';
  self.orig_zip	:=	'';
  self.postal_type	:=	find_field_lst(l.field, 'POSTALTYPE', 'P');
  self.privacy	:=	'';
  self.vendor	:=	'';
  self.last_udt_date	:=	find_field_lst(l.field, 'UPDATED', 'P');
  self.ven_reg	:=	'';
	self.siccode := '';
	// self.input_string := l.field;
end;

projLSI := project(inputfile, reformat(left)); //"Plucks" out the fields from the raw field and assigns them to the LSS orig format.

return projLSI;
end;