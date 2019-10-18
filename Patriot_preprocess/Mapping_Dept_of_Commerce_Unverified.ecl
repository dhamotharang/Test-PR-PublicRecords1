
#OPTION('multiplePersistInstances',false);

Dept_of_Commerce_Unverified	:= 	DATASET('~thor::in::globalwatchlists::unverified', 
                             layout_Dept_of_Commerce_Unverified.layout_unverified, CSV(separator('\t') , heading(1),quote('"'),TERMINATOR(['\n', '\r\n'])));	


Layout_Dept_of_Commerce_Unverified_seq := record
string sequence;
layout_Dept_of_Commerce_Unverified.layout_unverified;
end;

Layout_Dept_of_Commerce_Unverified_seq
                               tr_add_sequence(Dept_of_Commerce_Unverified l, integer c) := TRANSFORM

self.sequence := (string) c;
self := l;
end; 

add_sequence := PROJECT(Dept_of_Commerce_Unverified,tr_add_sequence(left,counter));
//output(add_sequence, named('add_sequence'));

sort_add_sequence := sort(add_sequence,sequence);

Patriot_preprocess.layout_patriot_common tr_patriot_common(sort_add_sequence l ) := TRANSFORM

position_first_comma := StringLib.StringFind(l.lstd_person_address,',',1);

orig_pty_name := trim(l.lstd_person_address[1..position_first_comma - 1],left,right); 
	
address := 	trim(l.lstd_person_address[position_first_comma + 1..],left,right); 

addr_1 := address[1..50];
addr_2 := address[51..100];
addr_3 := address[101..150];
addr_4 := address[151..200];	
addr_5 := address[201..250];
addr_6 := address[251..300];
addr_7 := address[301..350];	
																 
left_pad_with_zeros := map(length((string)l.sequence) = 1 => '0','');

pty_key := 'UVE' + trim(left_pad_with_zeros,left,right) + (string)l.sequence;

self.pty_key := pty_key;
self.source := 'US Bureau of Industry and Security Unverified Entity List';
self.orig_pty_name := orig_pty_name;
self.addr_1 := addr_1;
self.addr_2 := addr_2;
self.addr_3 := addr_3;
self.addr_4 := addr_4	;
self.addr_5 := addr_5;
self.addr_6 := addr_6;
self.addr_7 := addr_7;		
self.country := map(regexfind('China',address)	
                     => 'China',
										   regexfind('Hong Kong',address)	
                        => 'Hong Kong',
										     regexfind('Russia',address)	
                          => 'Russia',
										       regexfind('UAE',address)	
                            => 'UAE',
										           '');
self.entity_flag := 'Y';										 

self := [];

end;

patriot_common := PROJECT(sort_add_sequence,tr_patriot_common (left));
//output(patriot_common, named('patriot_common'));

filter_patriot_common := patriot_common(orig_pty_name not in [
																															'P.O. Box 263128',                                                                                                                                                                                                                                                                                                                         
																															'Rm 1203',                                                                                                                                                                                                                                                                                                                                                       
																															'Rm 2309',                                                                                                                                                                                                                                                                                                                                                       
																															'Rm 2309',                                                                                                                                                                                                                                                                                                                                                       
																															'Room 1609',                                                                                                                                                                                                                                                                                                                                                     
																															'Room 603',                                                                                                                                                                                                                                                                                                                                                      
																															'Room N',                                                                                                                                                                                                                                                                                                                              
																															'Unit 503',                                                                                                                                                                                                                                                                                                                                                      
																															'Units A&B'
                                                               ]);																								                                                                                                                                                                                                                                                                                                                     

EXPORT Mapping_Dept_of_Commerce_Unverified := filter_patriot_common
                      : persist('~thor::persist::out::patriot::preprocess::Dept_of_Commerce_Unverified');