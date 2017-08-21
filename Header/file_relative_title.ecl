import doxie, data_services, ut, watchdog, header, nid, contactcard;
EXPORT file_relative_title := module
shared r := doxie.File_Relatives_Plus(current_relatives = true,person1>0,person2>0,number_cohabits>=6);
doxie.Layout_Relatives_Plus swap(doxie.Layout_Relatives_Plus le) := transform
  self.person1 := le.person2;
  self.person2 := le.person1;
  self := le;
  end;

shared res := r + project(r,swap(left));

shared head := pull(doxie.Key_Header);
shared titles := header.fn_relative_title(res, head);

Layout_Relatives_v2.main_rel_title append_title (res l, titles r) := transform
self.rel_title:= DATASET([{if(r.title <> 0, r.title, if(~l.same_lname and l.number_cohabits >= contactcard.constants.min_number_cohabits, relative_titles.num_associate , relative_titles.num_relative)), 1}],{layout_relatives_v2.rel_title_layout});
self := l;
end;

EXPORT build_file := join(distribute(res, hash(person1)),
											distribute(titles, hash(person1)),
											left.person1 = right.person1 and
											left.person2 = right.person2,
											append_title(left, right),
											left outer,
											local);

EXPORT file := dataset(data_services.Data_location.person_header +'thor_data400::base::relative_title', Layout_Relatives_v2.main_rel_title, thor);

END;
	

