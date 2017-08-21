h:=header.file_headers;
segmented_header := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
// append segmentation indicator to best_cid
bcid_with_ind := JOIN(best_cid, segmented_header
					,left.did=right.did
					,transform({best_cid
								,segmented_header.ind}
									,self:=left
									,self:=right)
					,LOCAL)
					 :persist('~thor_data400::persist::compid::bcid_with_ind')
					;