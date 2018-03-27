EXPORT Layouts := module

	export rLayoutFileDetails := record
		string keyedfields;
		string fulllayout;
		string errormsg;
	end;

	rDFUInfoResponse := record,maxlength(30000)
		string fullxml{xpath('FileDetail/Ecl')};
		string contenttype{xpath('FileDetail/ContentType')};
	end;

	outrec := record,maxlength(50000)
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
	end;
		
	export superkeyrecs := record(outrec)
		string qa_key;
		string qa_key_create_sf;
		string keyname;
		string full_layout;
		string layout;
		string keyedfields;
		dataset(rLayoutFileDetails) FileDetails;
		string best_file_match := '';
		string orig_logicalkey := '';
	end;

	export layoutRec := Record
		string dataType;
		string fieldName;
		string layoutName :='';
	end;

	export parentLayouts := record
		dataset(layoutRec) children;
		string layoutName:='';
	end;
  export layout_list_rec := record
	  string 								layout_name;
	  string 								layout_concat;
	  dataset(layoutRec) allFields;
	end;
end;
