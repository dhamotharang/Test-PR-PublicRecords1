export date_overlap_first(unsigned8 lf, unsigned8 ll, 
                         unsigned8 rf, unsigned8 rl) :=

  MAP ( yearmap_low(lf) > yearmap_high(rl) => 0,
        yearmap_low(rf) > yearmap_high(ll) => 0,
        yearmap_low(lf) > yearmap_low(rf) => yearmap_low(lf),
        yearmap_low(rf) );