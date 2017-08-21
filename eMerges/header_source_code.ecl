export header_source_code(string file_id_in) :=
 case(file_id_in,
  'HUNT' => 'E1',
  'FISH' => 'E2',
  'CCW'  => 'E3',
  'CENS' => 'E4',
  '');