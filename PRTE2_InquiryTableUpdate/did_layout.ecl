layout_counts := RECORD
   unsigned2 counttotal;
   unsigned2 count01;
   unsigned2 count03;
   unsigned2 count06;
   unsigned2 count12;
   unsigned2 count24;
   unsigned2 count36;
   unsigned2 count60;
  END;

Export did_layout:=RECORD
  unsigned6 did;
  layout_counts collection;
  layout_counts accountopen;
  layout_counts other;
  unsigned8 __internal_fpos__;
 END;
