export date_overlap(unsigned8 lf, unsigned8 ll, 
                         unsigned8 rf, unsigned8 rl) :=

  MAP( date_overlap_last(lf,ll,rf,rl)=0 => if (date_overlap_first(lf,ll,rf,rl)=0,0,1),
       date_overlap_first(lf,ll,rf,rl)=0 => 1,
       (date_overlap_last(lf,ll,rf,rl) div 100 - date_overlap_first(lf,ll,rf,rl) div 100) * 12 +
date_overlap_last(lf,ll,rf,rl)%100-date_overlap_first(lf,ll,rf,rl) % 100+1);