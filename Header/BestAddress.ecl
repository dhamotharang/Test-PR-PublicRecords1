/*Look at our 1s
// This gives a non_glb best address
If multiple pick those with the most recent date last seen
If multiple then pick the one with a gong record
If multiple (or none) then pick the one with the most recent first reported
*/
import mdr, address;
f := header.file_headers_nonglb(not mdr.Source_is_DPPA(src) and zip4!='');

MAC_Best_Address(f, did, 4, en)

export BestAddress := en : persist('BestAddress4');