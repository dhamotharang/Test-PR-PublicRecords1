// Note: function doesn't check whether masking was actually requested, it is a responsibility of a caller
export dl_mask (string dl) := if (dl = '', dl, 'xxxxxxxxxxxxxx');