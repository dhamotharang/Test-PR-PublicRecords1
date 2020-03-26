IMPORT $;

EXPORT key_Vintelligence():=module

Shared keyed_fields1 := RECORD
  $.layouts.r_VintelligencePart1.l_vin1;
  $.layouts.r_VintelligencePart1.l_vin2;
  $.layouts.r_VintelligencePart1.l_vin3;
  $.layouts.r_VintelligencePart1.l_vin4;
  $.layouts.r_VintelligencePart1.l_vin5;
  $.layouts.r_VintelligencePart1.l_vin6;
  $.layouts.r_VintelligencePart1.l_vin7;
  $.layouts.r_VintelligencePart1.l_vin8;
  $.layouts.r_VintelligencePart1.l_vin9;
  $.layouts.r_VintelligencePart1.l_vin10;
  $.layouts.r_VintelligencePart1.l_vin11;
  $.layouts.r_VintelligencePart1.l_vin12;
  $.layouts.r_VintelligencePart1.l_vin13;
  $.layouts.r_VintelligencePart1.l_vin14;
  $.layouts.r_VintelligencePart1.l_vin15;
  $.layouts.r_VintelligencePart1.l_vin16;
  $.layouts.r_VintelligencePart1.l_vin17;
END;

Shared keyed_fields2 := RECORD
  $.layouts.r_VintelligencePart2.l_vin1;
  $.layouts.r_VintelligencePart2.l_vin2;
  $.layouts.r_VintelligencePart2.l_vin3;
  $.layouts.r_VintelligencePart2.l_vin4;
  $.layouts.r_VintelligencePart2.l_vin5;
  $.layouts.r_VintelligencePart2.l_vin6;
  $.layouts.r_VintelligencePart2.l_vin7;
  $.layouts.r_VintelligencePart2.l_vin8;
  $.layouts.r_VintelligencePart2.l_vin9;
  $.layouts.r_VintelligencePart2.l_vin10;
  $.layouts.r_VintelligencePart2.l_vin11;
  $.layouts.r_VintelligencePart2.l_vin12;
  $.layouts.r_VintelligencePart2.l_vin13;
  $.layouts.r_VintelligencePart2.l_vin14;
  $.layouts.r_VintelligencePart2.l_vin15;
  $.layouts.r_VintelligencePart2.l_vin16;
  $.layouts.r_VintelligencePart2.l_vin17;
END;


EXPORT Key1 := INDEX ({keyed_fields1}, {$.layouts.r_VintelligencePart1}, $.names().i_VintelligenceKey1, OPT);
EXPORT Key2 := INDEX ({keyed_fields2}, {$.layouts.r_VintelligencePart2}, $.names().i_VintelligenceKey2, OPT);

end;