export NNEQ_Date(unsigned8 l, unsigned8 r) := 
  l=r or l=0 or r = 0 or
  l div 100 = r div 100 and ( l % 100 <= 1 or r % 100 <= 1 ) or
  l div 10000 = r div 10000 and ( l % 10000 <= 0101 or r % 10000 <= 0101 );