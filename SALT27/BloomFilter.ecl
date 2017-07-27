// 2 words associated with hashl and hashr are definitely not within editN if this filter returns false;
// otherwise, they might be within editN, so additional test is necessary!
EXPORT BOOLEAN BloomFilter(STRING hashl, STRING bitvecl, STRING hashr, STRING bitvecr) := BEGINC++
#option pure
{
  if( (bitvecl[hashr[0] >> 3] & (1ull << (hashr[0] & 0x7))) != 0) {
    if( (bitvecr[hashl[0] >> 3] & (1ull << (hashl[0] & 0x7))) != 0) {
			return true;
    }
  }
  return false;
}
ENDC++;
