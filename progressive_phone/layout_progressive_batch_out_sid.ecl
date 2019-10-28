import $;
EXPORT layout_progressive_batch_out_sid := RECORD
  $.layout_progressive_batch_out_with_did;
  unsigned6 key_did := 0;
  unsigned4 global_sid := 0;
  unsigned8 record_sid := 0;
END;
