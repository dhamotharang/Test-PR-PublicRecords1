/*---Function to extract letters from a single word into a set
-----Input parameter is a word ---*/

export WordTokenizer(string inword) := function

			word_length := length(inword);

			rec_word := record
				string wrd;
			end;

			ds_word := DATASET([{ inword }], rec_word);

			rec_char := record
				string1 char := '';
			end;

			rec_char tokenize_word(recordof(ds_word) L, integer C) := transform
				self.char := L.wrd[c];
			end;

			ds_token_letters := normalize(ds_word, word_length, tokenize_word(left, counter));

			return ds_token_letters;

end;